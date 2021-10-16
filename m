Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B543057B
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbhJPWt4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240998AbhJPWtx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:49:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51F8961242;
        Sat, 16 Oct 2021 22:47:44 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 13/14] SUNRPC: Fix kdoc comment for svc_unregister()
Date:   Sat, 16 Oct 2021 18:47:43 -0400
Message-Id:  <163442446319.1001.13808028456852897145.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; h=from:subject:message-id; bh=CH3wU0dGIEEDQ2Bredm60sz8sC7sPkjTixfJd2D8Wrg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1aPF099Yl9TmSa32uAGDosq007xnQmmy0IwfQv1 Wkas4XmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWjwAKCRAzarMzb2Z/l7SqD/ 9sZ7N2ixEQX5CKO+V/Xbnjrzqf3TYm8wzfhOReL2UgCduyxOyNgs2HYmJ7sJMhyJ+qkxN4AMpUbhIH /DGIhhAimOCS05LjzI+dqIZc30GQRyoLx+neZx9yz4WAuqQ9e51VQk6lG9F9/q3Bkuu4Pqws4M1XEB nvLEhNs9GDnoVPiQIb3w7d3XAmAASLoxX5UaYeNAZC5nn9hgRYHC4fw8hEendebWjUh4Wm/5St4SsJ 6x8d2IE0kPtfZwmEwKz7zWmgPgh/anWc+8RSOFjyBtPpEfuiIvDCRLyH4xkiN8hPLPIHgEBH+ookSt BE2tm4HyUET5W+AiY+5Wcgu3ivcw5Aj+el/bMliJl4+CWNQkV4Wl7giGSQ6z4QQ9disTYuToAOxsED z07Pq++jZ4DWhsi0Dg1edRxPksLOfxd4/IgCq8cZTtBi3B8WVXC0wTuq1hSwGqXiKXQFnly/TXJY21 GKtMgqkwDjUMpeCXssi0IpWZmDOg33Rl+/9d1Lt1sayQJe2xjoPYvKbkg8ozzpfegv1TJflzmlsqak 8dztmfXRmeZf85Wszr7oE2jpq5W7FwKbq8y7+WVp3MBNzKSEH5SrgvcVE4yB2h8NmATVayZmhTA5GS z7sUNtUaXloRnua5hRh+szrJ+N8R/VxTDD7mei9cyKE8IjPXcPGIl9UOxfAA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up. Commit b4af59328c25 ("SUNRPC: Trace server-side rpcbind
registration events") replaced the dprintk call site in
svc_unregister() but didn't update the function's documenting
comment.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ae3c2d31d6dc..e0773a85dbe5 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1127,9 +1127,6 @@ static void __svc_unregister(struct net *net, const u32 program, const u32 versi
  * All netids, bind addresses and ports registered for [program, version]
  * are removed from the local rpcbind database (if the service is not
  * hidden) to make way for a new instance of the service.
- *
- * The result of unregistration is reported via dprintk for those who want
- * verification of the result, but is otherwise not important.
  */
 static void svc_unregister(const struct svc_serv *serv, struct net *net)
 {

