Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8491A37CAF8
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhELQdK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239212AbhELQHg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:07:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E9AC61D1E;
        Wed, 12 May 2021 15:36:54 +0000 (UTC)
Subject: [PATCH v2 18/25] NFSD: Remove spurious cb_setup_err tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:36:53 -0400
Message-ID: <162083381366.3108.6618271807599739861.stgit@klimt.1015granger.net>
In-Reply-To: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This path is not really an error path, so the tracepoint I added
there is just noise.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index ab1836381e22..15ba16c54793 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -915,10 +915,8 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		args.authflavor = clp->cl_cred.cr_flavor;
 		clp->cl_cb_ident = conn->cb_ident;
 	} else {
-		if (!conn->cb_xprt) {
-			trace_nfsd_cb_setup_err(clp, -EINVAL);
+		if (!conn->cb_xprt)
 			return -EINVAL;
-		}
 		clp->cl_cb_conn.cb_xprt = conn->cb_xprt;
 		clp->cl_cb_session = ses;
 		args.bc_xprt = conn->cb_xprt;


