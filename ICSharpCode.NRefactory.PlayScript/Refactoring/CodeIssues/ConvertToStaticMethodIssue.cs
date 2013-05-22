//
// ConvertToStaticMethodIssue.cs
//
// Author:
//       Ciprian Khlud <ciprian.mustiata@yahoo.com>
//
// Copyright (c) 2013 Ciprian Khlud
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

using System.Collections.Generic;
using ICSharpCode.NRefactory.Semantics;
using System.Linq;
using ICSharpCode.NRefactory.TypeSystem;

namespace ICSharpCode.NRefactory.PlayScript.Refactoring
{
    [IssueDescription("Make this method static",
                      Description = "This method doesn't use any non static members so it can be made static",
                      Severity = Severity.Hint,
                      IssueMarker = IssueMarker.Underline)]
    public class ConvertToStaticMethodIssue : ICodeIssueProvider
    {
        public IEnumerable<CodeIssue> GetIssues(BaseRefactoringContext context)
        {
            return new GatherVisitor(context).GetIssues();
        }

        private class GatherVisitor : GatherVisitorBase<ConvertToStaticMethodIssue>
        {
            private bool initializerInvoked;
            private ConstructorInitializer initializer;

            public GatherVisitor(BaseRefactoringContext context)
                : base(context) {
            }

            public override void VisitMethodDeclaration(MethodDeclaration declaration)
            {
                // TODO: Invert if without else
                // ex. if (cond) DoSomething () == if (!cond) return; DoSomething ()
                // beware of loop contexts return should be continue then.
                var context = ctx;
                var methodDeclaration = declaration;

                var resolved = context.Resolve(methodDeclaration) as MemberResolveResult;
                if (resolved == null)
                    return;
                var isImplementingInterface = resolved.Member.ImplementedInterfaceMembers.Any();

                if (isImplementingInterface)
                    return;

                AddIssue(methodDeclaration.NameToken.StartLocation, methodDeclaration.NameToken.EndLocation,
                    context.TranslateString(string.Format("Make '{0}' static", methodDeclaration.Name)),
                    script => ExecuteScriptToFixStaticMethodIssue(script, context, methodDeclaration));
            }

            private static void ExecuteScriptToFixStaticMethodIssue(Script script,
                                                                    BaseRefactoringContext context, 
                AstNode methodDeclaration)
            {
                var clonedDeclaration = (MethodDeclaration) methodDeclaration.Clone();
                clonedDeclaration.Modifiers |= Modifiers.Static;
                script.Replace(methodDeclaration, clonedDeclaration);
                var rr = context.Resolve(methodDeclaration) as MemberResolveResult;
                var method = (IMethod) rr.Member;
                //method.ImplementedInterfaceMembers.Any(m => methodGroupResolveResult.Methods.Contains((IMethod)m));

                script.DoGlobalOperationOn(rr.Member,
                                           (fctx, fscript, fnode) => { DoStaticMethodGlobalOperation(fnode, fctx, rr, fscript); });
            }

            private static void DoStaticMethodGlobalOperation(AstNode fnode, RefactoringContext fctx, MemberResolveResult rr,
                                                              Script fscript)
            {
                if (fnode is MemberReferenceExpression) {
                    var memberReference = new MemberReferenceExpression
                        (
                        new TypeReferenceExpression(
                            fctx.CreateShortType(rr.Member.DeclaringType)),
                        rr.Member.Name
                        );
                    fscript.Replace(fnode, memberReference);
                }
                else {
                    var invoke = fnode as InvocationExpression;
                    if (invoke == null) return;
                    if ((invoke.Target is MemberReferenceExpression))
                        return;
                    var memberReference = new MemberReferenceExpression
                        (
                        new TypeReferenceExpression(
                            fctx.CreateShortType(
                                rr.Member.DeclaringType)),
                        rr.Member.Name
                        );
                    fscript.Replace(invoke.Target, memberReference);
                }
            }
        }

    }
}

