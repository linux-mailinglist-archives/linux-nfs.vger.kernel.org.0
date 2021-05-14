Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97113381132
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhENT5T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232881AbhENT5T (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 15:57:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9092361584;
        Fri, 14 May 2021 19:56:07 +0000 (UTC)
Subject: [PATCH v3 09/24] NFSD: Add a couple more nfsd_clid_expired call sites
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org
Date:   Fri, 14 May 2021 15:56:06 -0400
Message-ID: <162102216684.10915.14695537441898958289.stgit@klimt.1015granger.net>
In-Reply-To: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
References: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs4state.c |    9 ++++++---
 fs/nfsd/trace.h     |    3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 08ff643e96fb..2e7bbaa92684 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2665,6 +2665,8 @@ static void force_expire_client(struct nfs4_client *clp)
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	bool already_expired;
 
+	trace_nfsd_clid_admin_expired(&clp->cl_clientid);
+
 	spin_lock(&clp->cl_lock);
 	clp->cl_time = 0;
 	spin_unlock(&clp->cl_lock);
@@ -3211,6 +3213,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		status = mark_client_expired_locked(conf);
 		if (status)
 			goto out;
+		trace_nfsd_clid_replaced(&conf->cl_clientid);
 	}
 	new->cl_minorversion = cstate->minorversion;
 	new->cl_spo_must_allow.u.words[0] = exid->spo_must_allow[0];
@@ -3450,6 +3453,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
 				old = NULL;
 				goto out_free_conn;
 			}
+			trace_nfsd_clid_replaced(&old->cl_clientid);
 		}
 		move_to_confirmed(unconf);
 		conf = unconf;
@@ -4078,6 +4082,7 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 				old = NULL;
 				goto out;
 			}
+			trace_nfsd_clid_replaced(&old->cl_clientid);
 		}
 		move_to_confirmed(unconf);
 		conf = unconf;
@@ -5508,10 +5513,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
 		if (!state_expired(&lt, clp->cl_time))
 			break;
-		if (mark_client_expired_locked(clp)) {
-			trace_nfsd_clid_expired(&clp->cl_clientid);
+		if (mark_client_expired_locked(clp))
 			continue;
-		}
 		list_add(&clp->cl_lru, &reaplist);
 	}
 	spin_unlock(&nn->client_lock);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d6ba6a1a1e63..ac96416b4b33 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -514,7 +514,8 @@ DEFINE_EVENT(nfsd_clientid_class, nfsd_clid_##name, \
 DEFINE_CLIENTID_EVENT(reclaim_complete);
 DEFINE_CLIENTID_EVENT(confirmed);
 DEFINE_CLIENTID_EVENT(destroyed);
-DEFINE_CLIENTID_EVENT(expired);
+DEFINE_CLIENTID_EVENT(admin_expired);
+DEFINE_CLIENTID_EVENT(replaced);
 DEFINE_CLIENTID_EVENT(purged);
 DEFINE_CLIENTID_EVENT(renew);
 DEFINE_CLIENTID_EVENT(stale);


