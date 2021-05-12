Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B9A37CAE5
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbhELQcq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239073AbhELQHP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:07:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE0726198B;
        Wed, 12 May 2021 15:35:55 +0000 (UTC)
Subject: [PATCH v2 09/25] NFSD: Add a couple more nfsd_clid_expired call sites
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:35:55 -0400
Message-ID: <162083375498.3108.14242612463783055564.stgit@klimt.1015granger.net>
In-Reply-To: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Improve observation of NFSv4 lease expiry.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 08ff643e96fb..7fa90a3177fa 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2665,6 +2665,8 @@ static void force_expire_client(struct nfs4_client *clp)
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	bool already_expired;
 
+	trace_nfsd_clid_expired(&clp->cl_clientid);
+
 	spin_lock(&clp->cl_lock);
 	clp->cl_time = 0;
 	spin_unlock(&clp->cl_lock);
@@ -4075,6 +4077,7 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 				goto out;
 			status = mark_client_expired_locked(old);
 			if (status) {
+				trace_nfsd_clid_expired(&old->cl_clientid);
 				old = NULL;
 				goto out;
 			}


