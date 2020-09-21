Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9352B2731B0
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgIUSNG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgIUSNG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:13:06 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CB8C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:13:05 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m17so16488147ioo.1
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=x8zg4HJzl0OLfsGFLbEiuov1V+gjwdNQwD9XKe+yg14=;
        b=iScPCph7DWXWSCjRc4vT82iX4+3ra3QXG6p9oka+8ZIkEclRnG1JMyJYNM2C5/PhOY
         +PtePVh4WAdxKrQlKw+sEd8j19+suEEsnuuiPrGr7vqTj1cHXZUC7WdDbjGOxsBYQBoP
         hGiviwbEF1NWpscEs4HX74XQZMWKrK47BG9cO6UtldB5bast3X0bRcKdKzSD7a2BTLS0
         Z9pf7ABhwKpdD1m/OKVEV8Ra96De/1U2yjX2zXGf1A3wE4DRpZne6cWawQD9G627h8pX
         RopR51MMHmMvkRWwMs8W5wICbv5lMRwzVr6thmUftqwlNG6W1HinO6fTBmihEs6DDiZh
         k0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=x8zg4HJzl0OLfsGFLbEiuov1V+gjwdNQwD9XKe+yg14=;
        b=qQMzdBM0eHWZGeFLE8/xwavqydl0swZc1CeE36wSbNyyzUlXmhS7YvgfK49egoLGkt
         5GDfCXKi4+mj0MiyRqLWGDrbGu4V8xGFj5sfDRXCzxjKbhJwzAjQXfRGdCdZ54KeE28b
         0Rz/kHjR8p8L7Pm/Q5uUmGydEc6qCpHzwHTgV/8fbMEfWjI+1r6UMSoiet7YiJ/OJ5on
         QDTNruoY0YSHheAFup9nsaZZOmPGahkJQL/CR8pmzro1+kmJ25mJLOu+oMbG3FHvYVb8
         hkF9e0B2mlht8uJJWjXmuKo2lYtyVBtj82L3JQyOC6PGwvaj85yROhE8lYFDk5miKTYD
         8buw==
X-Gm-Message-State: AOAM531YWVDZnVshp9u0Oc6eg3K7m12gQg9r2jJfBZEVR6aQZUp6L2Kl
        zl5vv/6fsxzGeXPIJ1SoBbE=
X-Google-Smtp-Source: ABdhPJweoopwnWHoPgL2RK/BlpgtrU40H5ly/71aoW+gyAkPYtKRAPGgjxjGUzUJTVmaMdCCPhgSDg==
X-Received: by 2002:a6b:908:: with SMTP id t8mr517901ioi.124.1600711983576;
        Mon, 21 Sep 2020 11:13:03 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k1sm6179439iop.42.2020.09.21.11.13.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:13:02 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LID1ap003917;
        Mon, 21 Sep 2020 18:13:01 GMT
Subject: [PATCH v2 25/27] NFSD: Rename nfsd_ tracepoints to nfsd4_
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:13:01 -0400
Message-ID: <160071198185.1468.9304540772685242936.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Allow administrators to enable just NFS4-related or non-NFSv4-related
server tracepoints by changing the prefix of NFSv4-related
tracepoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   28 ++++++++++++++--------------
 fs/nfsd/nfs4layouts.c  |   16 ++++++++--------
 fs/nfsd/nfs4proc.c     |    4 ++--
 fs/nfsd/nfs4state.c    |   14 +++++++-------
 fs/nfsd/trace.h        |   16 ++++++++--------
 5 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 052be5bf9ef5..65675c0158ed 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -906,7 +906,7 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	if (clp->cl_minorversion == 0) {
 		if (!clp->cl_cred.cr_principal &&
 		    (clp->cl_cred.cr_flavor >= RPC_AUTH_GSS_KRB5)) {
-			trace_nfsd_cb_setup_err(clp, -EINVAL);
+			trace_nfsd4_cb_setup_err(clp, -EINVAL);
 			return -EINVAL;
 		}
 		args.client_name = clp->cl_cred.cr_principal;
@@ -916,7 +916,7 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		clp->cl_cb_ident = conn->cb_ident;
 	} else {
 		if (!conn->cb_xprt) {
-			trace_nfsd_cb_setup_err(clp, -EINVAL);
+			trace_nfsd4_cb_setup_err(clp, -EINVAL);
 			return -EINVAL;
 		}
 		clp->cl_cb_conn.cb_xprt = conn->cb_xprt;
@@ -930,18 +930,18 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	/* Create RPC client */
 	client = rpc_create(&args);
 	if (IS_ERR(client)) {
-		trace_nfsd_cb_setup_err(clp, PTR_ERR(client));
+		trace_nfsd4_cb_setup_err(clp, PTR_ERR(client));
 		return PTR_ERR(client);
 	}
 	cred = get_backchannel_cred(clp, client, ses);
 	if (!cred) {
-		trace_nfsd_cb_setup_err(clp, -ENOMEM);
+		trace_nfsd4_cb_setup_err(clp, -ENOMEM);
 		rpc_shutdown_client(client);
 		return -ENOMEM;
 	}
 	clp->cl_cb_client = client;
 	clp->cl_cb_cred = cred;
-	trace_nfsd_cb_setup(clp);
+	trace_nfsd4_cb_setup(clp);
 	return 0;
 }
 
@@ -950,7 +950,7 @@ static void nfsd4_mark_cb_down(struct nfs4_client *clp, int reason)
 	if (test_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags))
 		return;
 	clp->cl_cb_state = NFSD4_CB_DOWN;
-	trace_nfsd_cb_state(clp);
+	trace_nfsd4_cb_state(clp);
 }
 
 static void nfsd4_mark_cb_fault(struct nfs4_client *clp, int reason)
@@ -958,19 +958,19 @@ static void nfsd4_mark_cb_fault(struct nfs4_client *clp, int reason)
 	if (test_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags))
 		return;
 	clp->cl_cb_state = NFSD4_CB_FAULT;
-	trace_nfsd_cb_state(clp);
+	trace_nfsd4_cb_state(clp);
 }
 
 static void nfsd4_cb_probe_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_client *clp = container_of(calldata, struct nfs4_client, cl_cb_null);
 
-	trace_nfsd_cb_done(clp, task->tk_status);
+	trace_nfsd4_cb_done(clp, task->tk_status);
 	if (task->tk_status)
 		nfsd4_mark_cb_down(clp, task->tk_status);
 	else {
 		clp->cl_cb_state = NFSD4_CB_UP;
-		trace_nfsd_cb_state(clp);
+		trace_nfsd4_cb_state(clp);
 	}
 }
 
@@ -996,7 +996,7 @@ static const struct rpc_call_ops nfsd4_cb_probe_ops = {
 void nfsd4_probe_callback(struct nfs4_client *clp)
 {
 	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
-	trace_nfsd_cb_state(clp);
+	trace_nfsd4_cb_state(clp);
 	set_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
 	nfsd4_run_cb(&clp->cl_cb_null);
 }
@@ -1013,7 +1013,7 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
 	spin_lock(&clp->cl_lock);
 	memcpy(&clp->cl_cb_conn, conn, sizeof(struct nfs4_cb_conn));
 	spin_unlock(&clp->cl_lock);
-	trace_nfsd_cb_state(clp);
+	trace_nfsd4_cb_state(clp);
 }
 
 /*
@@ -1170,7 +1170,7 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 	struct nfsd4_callback *cb = calldata;
 	struct nfs4_client *clp = cb->cb_clp;
 
-	trace_nfsd_cb_done(clp, task->tk_status);
+	trace_nfsd4_cb_done(clp, task->tk_status);
 
 	if (!nfsd4_cb_sequence_done(task, cb))
 		return;
@@ -1275,7 +1275,7 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 	 * kill the old client:
 	 */
 	if (clp->cl_cb_client) {
-		trace_nfsd_cb_shutdown(clp);
+		trace_nfsd4_cb_shutdown(clp);
 		rpc_shutdown_client(clp->cl_cb_client);
 		clp->cl_cb_client = NULL;
 		put_cred(clp->cl_cb_cred);
@@ -1321,7 +1321,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 	struct rpc_clnt *clnt;
 	int flags;
 
-	trace_nfsd_cb_work(clp, cb->cb_msg.rpc_proc->p_name);
+	trace_nfsd4_cb_work(clp, cb->cb_msg.rpc_proc->p_name);
 
 	if (cb->cb_need_restart) {
 		cb->cb_need_restart = false;
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index a97873f2d22b..7daa553abba4 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -158,7 +158,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	struct nfs4_file *fp = ls->ls_stid.sc_file;
 
-	trace_nfsd_layoutstate_free(&ls->ls_stid.sc_stateid);
+	trace_nfsd4_layoutstate_free(&ls->ls_stid.sc_stateid);
 
 	spin_lock(&clp->cl_lock);
 	list_del_init(&ls->ls_perclnt);
@@ -257,7 +257,7 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
 	list_add(&ls->ls_perfile, &fp->fi_lo_states);
 	spin_unlock(&fp->fi_lock);
 
-	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
+	trace_nfsd4_layoutstate_alloc(&ls->ls_stid.sc_stateid);
 	return ls;
 }
 
@@ -327,7 +327,7 @@ nfsd4_recall_file_layout(struct nfs4_layout_stateid *ls)
 	if (list_empty(&ls->ls_layouts))
 		goto out_unlock;
 
-	trace_nfsd_layout_recall(&ls->ls_stid.sc_stateid);
+	trace_nfsd4_layout_recall(&ls->ls_stid.sc_stateid);
 
 	refcount_inc(&ls->ls_stid.sc_count);
 	nfsd4_run_cb(&ls->ls_recall);
@@ -500,7 +500,7 @@ nfsd4_return_file_layouts(struct svc_rqst *rqstp,
 						false, lrp->lr_layout_type,
 						&ls);
 	if (nfserr) {
-		trace_nfsd_layout_return_lookup_fail(&lrp->lr_sid);
+		trace_nfsd4_layout_return_lookup_fail(&lrp->lr_sid);
 		return nfserr;
 	}
 
@@ -516,7 +516,7 @@ nfsd4_return_file_layouts(struct svc_rqst *rqstp,
 			nfs4_inc_and_copy_stateid(&lrp->lr_sid, &ls->ls_stid);
 		lrp->lrs_present = 1;
 	} else {
-		trace_nfsd_layoutstate_unhash(&ls->ls_stid.sc_stateid);
+		trace_nfsd4_layoutstate_unhash(&ls->ls_stid.sc_stateid);
 		nfs4_unhash_stid(&ls->ls_stid);
 		lrp->lrs_present = 0;
 	}
@@ -686,7 +686,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 		/*
 		 * Unknown error or non-responding client, we'll need to fence.
 		 */
-		trace_nfsd_layout_recall_fail(&ls->ls_stid.sc_stateid);
+		trace_nfsd4_layout_recall_fail(&ls->ls_stid.sc_stateid);
 
 		ops = nfsd4_layout_ops[ls->ls_layout_type];
 		if (ops->fence_client)
@@ -695,7 +695,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 			nfsd4_cb_layout_fail(ls);
 		return 1;
 	case -NFS4ERR_NOMATCHING_LAYOUT:
-		trace_nfsd_layout_recall_done(&ls->ls_stid.sc_stateid);
+		trace_nfsd4_layout_recall_done(&ls->ls_stid.sc_stateid);
 		task->tk_status = 0;
 		return 1;
 	}
@@ -708,7 +708,7 @@ nfsd4_cb_layout_release(struct nfsd4_callback *cb)
 		container_of(cb, struct nfs4_layout_stateid, ls_recall);
 	LIST_HEAD(reaplist);
 
-	trace_nfsd_layout_recall_release(&ls->ls_stid.sc_stateid);
+	trace_nfsd4_layout_recall_release(&ls->ls_stid.sc_stateid);
 
 	nfsd4_return_all_layouts(ls, &reaplist);
 	nfsd4_free_layouts(&reaplist);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index c4fa121560ae..49109645af24 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1973,7 +1973,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lgp->lg_sid,
 						true, lgp->lg_layout_type, &ls);
 	if (nfserr) {
-		trace_nfsd_layout_get_lookup_fail(&lgp->lg_sid);
+		trace_nfsd4_layout_get_lookup_fail(&lgp->lg_sid);
 		goto out;
 	}
 
@@ -2042,7 +2042,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 						false, lcp->lc_layout_type,
 						&ls);
 	if (nfserr) {
-		trace_nfsd_layout_commit_lookup_fail(&lcp->lc_sid);
+		trace_nfsd4_layout_commit_lookup_fail(&lcp->lc_sid);
 		/* fixup error code as per RFC5661 */
 		if (nfserr == nfserr_bad_stateid)
 			nfserr = nfserr_badlayout;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index eaad1763d33a..690483e0b933 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2893,12 +2893,12 @@ gen_callback(struct nfs4_client *clp, struct nfsd4_setclientid *se, struct svc_r
 	conn->cb_prog = se->se_callback_prog;
 	conn->cb_ident = se->se_callback_ident;
 	memcpy(&conn->cb_saddr, &rqstp->rq_daddr, rqstp->rq_daddrlen);
-	trace_nfsd_cb_args(clp, conn);
+	trace_nfsd4_cb_args(clp, conn);
 	return;
 out_err:
 	conn->cb_addr.ss_family = AF_UNSPEC;
 	conn->cb_addrlen = 0;
-	trace_nfsd_cb_nodelegs(clp);
+	trace_nfsd4_cb_nodelegs(clp);
 	return;
 }
 
@@ -3954,7 +3954,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (clp_used_exchangeid(conf))
 			goto out;
 		if (!same_creds(&conf->cl_cred, &rqstp->rq_cred)) {
-			trace_nfsd_clid_inuse_err(conf);
+			trace_nfsd4_clid_inuse_err(conf);
 			goto out;
 		}
 	}
@@ -4578,7 +4578,7 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 
-	trace_nfsd_deleg_break(&dp->dl_stid.sc_stateid);
+	trace_nfsd4_deleg_break(&dp->dl_stid.sc_stateid);
 
 	/*
 	 * We don't want the locks code to timeout the lease for us;
@@ -5145,7 +5145,7 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
 
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
-	trace_nfsd_deleg_open(&dp->dl_stid.sc_stateid);
+	trace_nfsd4_deleg_open(&dp->dl_stid.sc_stateid);
 	open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
 	nfs4_put_stid(&dp->dl_stid);
 	return;
@@ -5262,7 +5262,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	nfs4_open_delegation(current_fh, open, stp);
 nodeleg:
 	status = nfs_ok;
-	trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
+	trace_nfsd4_deleg_none(&stp->st_stid.sc_stateid);
 out:
 	/* 4.1 client trying to upgrade/downgrade delegation? */
 	if (open->op_delegate_type == NFS4_OPEN_DELEGATE_NONE && dp &&
@@ -7804,7 +7804,7 @@ nfsd_recall_delegations(struct list_head *reaplist)
 		list_del_init(&dp->dl_recall_lru);
 		clp = dp->dl_stid.sc_client;
 
-		trace_nfsd_deleg_recall(&dp->dl_stid.sc_stateid);
+		trace_nfsd4_deleg_recall(&dp->dl_stid.sc_stateid);
 
 		/*
 		 * We skipped all entries that had a zero dl_time before,
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 10927da9d016..53115fbc00b2 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -889,7 +889,7 @@ DECLARE_EVENT_CLASS(nfsd_stateid_class,
 )
 
 #define DEFINE_STATEID_EVENT(name) \
-DEFINE_EVENT(nfsd_stateid_class, nfsd_##name, \
+DEFINE_EVENT(nfsd_stateid_class, nfsd4_##name, \
 	TP_PROTO(stateid_t *stp), \
 	TP_ARGS(stp))
 
@@ -985,7 +985,7 @@ DEFINE_EVENT(nfsd_net_class, nfsd_##name, \
 DEFINE_NET_EVENT(grace_start);
 DEFINE_NET_EVENT(grace_complete);
 
-TRACE_EVENT(nfsd_clid_inuse_err,
+TRACE_EVENT(nfsd4_clid_inuse_err,
 	TP_PROTO(const struct nfs4_client *clp),
 	TP_ARGS(clp),
 	TP_STRUCT__entry(
@@ -1208,7 +1208,7 @@ TRACE_EVENT(nfsd_drc_mismatch,
 		__entry->ingress)
 );
 
-TRACE_EVENT(nfsd_cb_args,
+TRACE_EVENT(nfsd4_cb_args,
 	TP_PROTO(
 		const struct nfs4_client *clp,
 		const struct nfs4_cb_conn *conn
@@ -1234,7 +1234,7 @@ TRACE_EVENT(nfsd_cb_args,
 		__entry->addr, __entry->prog, __entry->ident)
 );
 
-TRACE_EVENT(nfsd_cb_nodelegs,
+TRACE_EVENT(nfsd4_cb_nodelegs,
 	TP_PROTO(const struct nfs4_client *clp),
 	TP_ARGS(clp),
 	TP_STRUCT__entry(
@@ -1282,7 +1282,7 @@ DECLARE_EVENT_CLASS(nfsd_cb_class,
 );
 
 #define DEFINE_NFSD_CB_EVENT(name)			\
-DEFINE_EVENT(nfsd_cb_class, nfsd_cb_##name,		\
+DEFINE_EVENT(nfsd_cb_class, nfsd4_cb_##name,		\
 	TP_PROTO(const struct nfs4_client *clp),	\
 	TP_ARGS(clp))
 
@@ -1290,7 +1290,7 @@ DEFINE_NFSD_CB_EVENT(setup);
 DEFINE_NFSD_CB_EVENT(state);
 DEFINE_NFSD_CB_EVENT(shutdown);
 
-TRACE_EVENT(nfsd_cb_setup_err,
+TRACE_EVENT(nfsd4_cb_setup_err,
 	TP_PROTO(
 		const struct nfs4_client *clp,
 		long error
@@ -1313,7 +1313,7 @@ TRACE_EVENT(nfsd_cb_setup_err,
 		__entry->addr, __entry->cl_boot, __entry->cl_id, __entry->error)
 );
 
-TRACE_EVENT(nfsd_cb_work,
+TRACE_EVENT(nfsd4_cb_work,
 	TP_PROTO(
 		const struct nfs4_client *clp,
 		const char *procedure
@@ -1337,7 +1337,7 @@ TRACE_EVENT(nfsd_cb_work,
 		__get_str(procedure))
 );
 
-TRACE_EVENT(nfsd_cb_done,
+TRACE_EVENT(nfsd4_cb_done,
 	TP_PROTO(
 		const struct nfs4_client *clp,
 		int status


