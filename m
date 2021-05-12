Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1307037CAEA
	for <lists+linux-nfs@lfdr.de>; Wed, 12 May 2021 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhELQcx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 May 2021 12:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239100AbhELQHT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 May 2021 12:07:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7866A61C43;
        Wed, 12 May 2021 15:36:15 +0000 (UTC)
Subject: [PATCH v2 12/25] NFSD: Add tracepoints for EXCHANGEID edge cases
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org, rostedt@goodmis.org
Date:   Wed, 12 May 2021 11:36:14 -0400
Message-ID: <162083377456.3108.10014302155237911416.stgit@klimt.1015granger.net>
In-Reply-To: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
References: <162083366966.3108.12581818416105328952.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Some of the most common cases are traced. Enough infrastructure is
now in place that more can be added later, as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   12 +++++++++---
 fs/nfsd/trace.h     |    1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e38cf9c236f1..ad0139b6df15 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3178,6 +3178,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			}
 			/* case 6 */
 			exid->flags |= EXCHGID4_FLAG_CONFIRMED_R;
+			trace_nfsd_clid_confirmed_r(conf);
 			goto out_copy;
 		}
 		if (!creds_match) { /* case 3 */
@@ -3190,6 +3191,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		}
 		if (verfs_match) { /* case 2 */
 			conf->cl_exchange_flags |= EXCHGID4_FLAG_CONFIRMED_R;
+			trace_nfsd_clid_confirmed_r(conf);
 			goto out_copy;
 		}
 		/* case 5, client reboot */
@@ -3203,11 +3205,13 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	unconf  = find_unconfirmed_client_by_name(&exid->clname, nn);
+	unconf = find_unconfirmed_client_by_name(&exid->clname, nn);
 	if (unconf) /* case 4, possible retry or client restart */
 		unhash_client_locked(unconf);
 
-	/* case 1 (normal case) */
+	/* case 1, new owner ID */
+	trace_nfsd_clid_fresh(new);
+
 out_new:
 	if (conf) {
 		status = mark_client_expired_locked(conf);
@@ -3236,8 +3240,10 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 out_nolock:
 	if (new)
 		expire_client(new);
-	if (unconf)
+	if (unconf) {
+		trace_nfsd_clid_expire_unconf(&unconf->cl_clientid);
 		expire_client(unconf);
+	}
 	return status;
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 2be1881f05e6..7de8ca581c5d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -633,6 +633,7 @@ DEFINE_EVENT(nfsd_clid_class, nfsd_clid_##name, \
 	TP_ARGS(clp))
 
 DEFINE_CLID_EVENT(fresh);
+DEFINE_CLID_EVENT(confirmed_r);
 
 /*
  * from fs/nfsd/filecache.h


