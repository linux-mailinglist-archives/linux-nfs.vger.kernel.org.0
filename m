Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437651E91B1
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2020 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgE3Nak (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 30 May 2020 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgE3Naj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 30 May 2020 09:30:39 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC8C03E969;
        Sat, 30 May 2020 06:30:39 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 9so5146938ilg.12;
        Sat, 30 May 2020 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2K2KRK3RypI38A4j3fLeziuEON8iXBtWzncIU09Ocs0=;
        b=mPh6S9F1eIETPrqzDKnk0NfVI5rxfcAL0kAy8XytG00xaGaSmrL3cVRQzExdLvpuuN
         CWBlzYpvuvsnIYtou8zQGdHBUJuMeRtZzopvJ/DXyE8bAl6eqwJym9X6bWsM2BaTfj5L
         xfjfhjTV9PAIBAiiQJUFAe94YjFfsfVEfvehJbfd68oKy+Hp/11BLZO4BM/9Y5M5l54a
         CMJx7aCI6k62dZogMgYcZHDHdAwIkxCAK3/4Fl+eWSWncn3o4jzyvfUFyskHtqKhLxvg
         Dsr+4iFc3m6hNjAT5m2agcLComahWZy42XBApudoYyQ5IKNuU6ZrlAblbrq2WS7+xbqN
         atNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2K2KRK3RypI38A4j3fLeziuEON8iXBtWzncIU09Ocs0=;
        b=X+YMZUuLsxnPV6two8DUJAkEmVmlP7UiWy+EP0O73f90V5afdklc+zgS3LKhyVJk4i
         zbsvFVxTE+LUUDUsNJT7/nLhzT6+a3JVRZKAVMp6DFca1edjBJ1idkKe8suQ5RQGrDmR
         G46iHhV3kxhcn9ANfYQoVfQEC33+c+x58GtnBOli09CkjOwRpz9xDtwZFx84Mw4x5Den
         VMzG/P/iZ3ulDATTaDoz/Oq8PMGJ+/CJJ2C+KON5ELyBKHFrJn9S4NwtmjbR8hfOBcG/
         W16LvMbTh1Wj1JXIoH8ovQQAB6NHN5L4T3SJLA0rBBGwHIi8QSB3t4x+YSHeWffNXW0R
         xMpg==
X-Gm-Message-State: AOAM5301FcHfL070eBk7h3UYSYkK18Pi9WCv2/p/AgIyXMR/SXV7cZ1Y
        2ol1Knv7N2BIWFwGAptHGEk2Toay
X-Google-Smtp-Source: ABdhPJz/fZom4MTDuxlG0LhkmAzH6Emo68hPNc57CCVZ3HC/Exl8wFNS+vLUJRR6cVpIrcp4iG/gCg==
X-Received: by 2002:a92:c642:: with SMTP id 2mr12039364ill.24.1590845438273;
        Sat, 30 May 2020 06:30:38 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y6sm868500ilj.56.2020.05.30.06.30.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 06:30:37 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04UDUbPO001480;
        Sat, 30 May 2020 13:30:37 GMT
Subject: [PATCH v4 29/33] NFSD: Add tracepoints to the NFSD state management
 code
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 30 May 2020 09:30:37 -0400
Message-ID: <20200530133037.10117.93252.stgit@klimt.1015granger.net>
In-Reply-To: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
References: <20200530131711.10117.74063.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Capture obvious events and replace dprintk() call sites. Introduce
infrastructure so that adding more tracepoints in this code later
is simplified.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   52 +++++++-------------
 fs/nfsd/state.h     |    7 ---
 fs/nfsd/trace.h     |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 40 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c107caa56525..04d80f9e2f91 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -51,6 +51,7 @@
 #include "netns.h"
 #include "pnfs.h"
 #include "filecache.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
 
@@ -167,9 +168,6 @@ renew_client_locked(struct nfs4_client *clp)
 		return;
 	}
 
-	dprintk("renewing client (clientid %08x/%08x)\n",
-			clp->cl_clientid.cl_boot,
-			clp->cl_clientid.cl_id);
 	list_move_tail(&clp->cl_lru, &nn->client_lru);
 	clp->cl_time = ktime_get_boottime_seconds();
 }
@@ -1922,8 +1920,7 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net *nn)
 	 */
 	if (clid->cl_boot == (u32)nn->boot_time)
 		return 0;
-	dprintk("NFSD stale clientid (%08x/%08x) boot_time %08llx\n",
-		clid->cl_boot, clid->cl_id, nn->boot_time);
+	trace_nfsd_clid_stale(clid);
 	return 1;
 }
 
@@ -3879,11 +3876,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (clp_used_exchangeid(conf))
 			goto out;
 		if (!same_creds(&conf->cl_cred, &rqstp->rq_cred)) {
-			char addr_str[INET6_ADDRSTRLEN];
-			rpc_ntop((struct sockaddr *) &conf->cl_addr, addr_str,
-				 sizeof(addr_str));
-			dprintk("NFSD: setclientid: string in use by client "
-				"at %s\n", addr_str);
+			trace_nfsd_clid_inuse_err(conf);
 			goto out;
 		}
 	}
@@ -4076,7 +4069,6 @@ nfsd4_init_slabs(void)
 out_free_client_slab:
 	kmem_cache_destroy(client_slab);
 out:
-	dprintk("nfsd4: out of memory while initializing nfsv4\n");
 	return -ENOMEM;
 }
 
@@ -4508,6 +4500,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 
+	trace_nfsd_deleg_break(&dp->dl_stid.sc_stateid);
+
 	/*
 	 * We don't want the locks code to timeout the lease for us;
 	 * we'll remove it ourself if a delegation isn't returned
@@ -5018,8 +5012,7 @@ nfs4_open_delegation(struct svc_fh *fh, struct nfsd4_open *open,
 
 	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
 
-	dprintk("NFSD: delegation stateid=" STATEID_FMT "\n",
-		STATEID_VAL(&dp->dl_stid.sc_stateid));
+	trace_nfsd_deleg_open(&dp->dl_stid.sc_stateid);
 	open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
 	nfs4_put_stid(&dp->dl_stid);
 	return;
@@ -5136,9 +5129,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	nfs4_open_delegation(current_fh, open, stp);
 nodeleg:
 	status = nfs_ok;
-
-	dprintk("%s: stateid=" STATEID_FMT "\n", __func__,
-		STATEID_VAL(&stp->st_stid.sc_stateid));
+	trace_nfsd_deleg_none(&stp->st_stid.sc_stateid);
 out:
 	/* 4.1 client trying to upgrade/downgrade delegation? */
 	if (open->op_delegate_type == NFS4_OPEN_DELEGATE_NONE && dp &&
@@ -5192,8 +5183,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	dprintk("process_renew(%08x/%08x): starting\n", 
-			clid->cl_boot, clid->cl_id);
+	trace_nfsd_clid_renew(clid);
 	status = lookup_clientid(clid, cstate, nn, false);
 	if (status)
 		goto out;
@@ -5214,6 +5204,7 @@ nfsd4_end_grace(struct nfsd_net *nn)
 	if (nn->grace_ended)
 		return;
 
+	trace_nfsd_grace_complete(nn);
 	nn->grace_ended = true;
 	/*
 	 * If the server goes down again right now, an NFSv4
@@ -5279,13 +5270,10 @@ nfs4_laundromat(struct nfsd_net *nn)
 	copy_stateid_t *cps_t;
 	int i;
 
-	dprintk("NFSD: laundromat service - starting\n");
-
 	if (clients_still_reclaiming(nn)) {
 		new_timeo = 0;
 		goto out;
 	}
-	dprintk("NFSD: end of grace period\n");
 	nfsd4_end_grace(nn);
 	INIT_LIST_HEAD(&reaplist);
 
@@ -5307,8 +5295,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 			break;
 		}
 		if (mark_client_expired_locked(clp)) {
-			dprintk("NFSD: client in use (clientid %08x)\n",
-				clp->cl_clientid.cl_id);
+			trace_nfsd_clid_expired(&clp->cl_clientid);
 			continue;
 		}
 		list_add(&clp->cl_lru, &reaplist);
@@ -5316,8 +5303,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_unlock(&nn->client_lock);
 	list_for_each_safe(pos, next, &reaplist) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		dprintk("NFSD: purging unused client (clientid %08x)\n",
-			clp->cl_clientid.cl_id);
+		trace_nfsd_clid_purged(&clp->cl_clientid);
 		list_del_init(&clp->cl_lru);
 		expire_client(clp);
 	}
@@ -5407,7 +5393,6 @@ laundromat_main(struct work_struct *laundry)
 					   laundromat_work);
 
 	t = nfs4_laundromat(nn);
-	dprintk("NFSD: laundromat_main - sleeping for %lld seconds\n", t);
 	queue_delayed_work(laundry_wq, &nn->laundromat_work, t*HZ);
 }
 
@@ -5948,8 +5933,7 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 	struct nfs4_stid *s;
 	struct nfs4_ol_stateid *stp = NULL;
 
-	dprintk("NFSD: %s: seqid=%d stateid = " STATEID_FMT "\n", __func__,
-		seqid, STATEID_VAL(stateid));
+	trace_nfsd_preprocess(seqid, stateid);
 
 	*stpp = NULL;
 	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
@@ -6018,9 +6002,7 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	oo->oo_flags |= NFS4_OO_CONFIRMED;
 	nfs4_inc_and_copy_stateid(&oc->oc_resp_stateid, &stp->st_stid);
 	mutex_unlock(&stp->st_mutex);
-	dprintk("NFSD: %s: success, seqid=%d stateid=" STATEID_FMT "\n",
-		__func__, oc->oc_seqid, STATEID_VAL(&stp->st_stid.sc_stateid));
-
+	trace_nfsd_open_confirm(oc->oc_seqid, &stp->st_stid.sc_stateid);
 	nfsd4_client_record_create(oo->oo_owner.so_client);
 	status = nfs_ok;
 put_stateid:
@@ -7072,7 +7054,7 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 	unsigned int strhashval;
 	struct nfs4_client_reclaim *crp;
 
-	dprintk("NFSD nfs4_client_to_reclaim NAME: %.*s\n", name.len, name.data);
+	trace_nfsd_clid_reclaim(nn, name.len, name.data);
 	crp = alloc_reclaim();
 	if (crp) {
 		strhashval = clientstr_hashval(name);
@@ -7122,7 +7104,7 @@ nfsd4_find_reclaim_client(struct xdr_netobj name, struct nfsd_net *nn)
 	unsigned int strhashval;
 	struct nfs4_client_reclaim *crp = NULL;
 
-	dprintk("NFSD: nfs4_find_reclaim_client for name %.*s\n", name.len, name.data);
+	trace_nfsd_clid_find(nn, name.len, name.data);
 
 	strhashval = clientstr_hashval(name);
 	list_for_each_entry(crp, &nn->reclaim_str_hashtbl[strhashval], cr_strhash) {
@@ -7686,6 +7668,9 @@ nfsd_recall_delegations(struct list_head *reaplist)
 	list_for_each_entry_safe(dp, next, reaplist, dl_recall_lru) {
 		list_del_init(&dp->dl_recall_lru);
 		clp = dp->dl_stid.sc_client;
+
+		trace_nfsd_deleg_recall(&dp->dl_stid.sc_stateid);
+
 		/*
 		 * We skipped all entries that had a zero dl_time before,
 		 * so we can now reset the dl_time back to 0. If a delegation
@@ -7868,6 +7853,7 @@ nfs4_state_start_net(struct net *net)
 		goto skip_grace;
 	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
 	       nn->nfsd4_grace, net->ns.inum);
+	trace_nfsd_grace_start(nn);
 	queue_delayed_work(laundry_wq, &nn->laundromat_work, nn->nfsd4_grace * HZ);
 	return 0;
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 68d3f30ee760..3b408532a5dc 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -64,13 +64,6 @@ typedef struct {
 	refcount_t		sc_count;
 } copy_stateid_t;
 
-#define STATEID_FMT	"(%08x/%08x/%08x/%08x)"
-#define STATEID_VAL(s) \
-	(s)->si_opaque.so_clid.cl_boot, \
-	(s)->si_opaque.so_clid.cl_id, \
-	(s)->si_opaque.so_id, \
-	(s)->si_generation
-
 struct nfsd4_callback {
 	struct nfs4_client *cb_clp;
 	struct rpc_message cb_msg;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 371dc198d28e..7237fe2f3de9 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -277,6 +277,7 @@ DECLARE_EVENT_CLASS(nfsd_stateid_class,
 DEFINE_EVENT(nfsd_stateid_class, nfsd_##name, \
 	TP_PROTO(stateid_t *stp), \
 	TP_ARGS(stp))
+
 DEFINE_STATEID_EVENT(layoutstate_alloc);
 DEFINE_STATEID_EVENT(layoutstate_unhash);
 DEFINE_STATEID_EVENT(layoutstate_free);
@@ -288,6 +289,138 @@ DEFINE_STATEID_EVENT(layout_recall_done);
 DEFINE_STATEID_EVENT(layout_recall_fail);
 DEFINE_STATEID_EVENT(layout_recall_release);
 
+DEFINE_STATEID_EVENT(deleg_open);
+DEFINE_STATEID_EVENT(deleg_none);
+DEFINE_STATEID_EVENT(deleg_break);
+DEFINE_STATEID_EVENT(deleg_recall);
+
+DECLARE_EVENT_CLASS(nfsd_stateseqid_class,
+	TP_PROTO(u32 seqid, const stateid_t *stp),
+	TP_ARGS(seqid, stp),
+	TP_STRUCT__entry(
+		__field(u32, seqid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, si_id)
+		__field(u32, si_generation)
+	),
+	TP_fast_assign(
+		__entry->seqid = seqid;
+		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
+		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
+		__entry->si_id = stp->si_opaque.so_id;
+		__entry->si_generation = stp->si_generation;
+	),
+	TP_printk("seqid=%u client %08x:%08x stateid %08x:%08x",
+		__entry->seqid, __entry->cl_boot, __entry->cl_id,
+		__entry->si_id, __entry->si_generation)
+)
+
+#define DEFINE_STATESEQID_EVENT(name) \
+DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
+	TP_PROTO(u32 seqid, const stateid_t *stp), \
+	TP_ARGS(seqid, stp))
+
+DEFINE_STATESEQID_EVENT(preprocess);
+DEFINE_STATESEQID_EVENT(open_confirm);
+
+DECLARE_EVENT_CLASS(nfsd_clientid_class,
+	TP_PROTO(const clientid_t *clid),
+	TP_ARGS(clid),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clid->cl_boot;
+		__entry->cl_id = clid->cl_id;
+	),
+	TP_printk("client %08x:%08x", __entry->cl_boot, __entry->cl_id)
+)
+
+#define DEFINE_CLIENTID_EVENT(name) \
+DEFINE_EVENT(nfsd_clientid_class, nfsd_clid_##name, \
+	TP_PROTO(const clientid_t *clid), \
+	TP_ARGS(clid))
+
+DEFINE_CLIENTID_EVENT(expired);
+DEFINE_CLIENTID_EVENT(purged);
+DEFINE_CLIENTID_EVENT(renew);
+DEFINE_CLIENTID_EVENT(stale);
+
+DECLARE_EVENT_CLASS(nfsd_net_class,
+	TP_PROTO(const struct nfsd_net *nn),
+	TP_ARGS(nn),
+	TP_STRUCT__entry(
+		__field(unsigned long long, boot_time)
+	),
+	TP_fast_assign(
+		__entry->boot_time = nn->boot_time;
+	),
+	TP_printk("boot_time=%16llx", __entry->boot_time)
+)
+
+#define DEFINE_NET_EVENT(name) \
+DEFINE_EVENT(nfsd_net_class, nfsd_##name, \
+	TP_PROTO(const struct nfsd_net *nn), \
+	TP_ARGS(nn))
+
+DEFINE_NET_EVENT(grace_start);
+DEFINE_NET_EVENT(grace_complete);
+
+DECLARE_EVENT_CLASS(nfsd_clid_class,
+	TP_PROTO(const struct nfsd_net *nn,
+		 unsigned int namelen,
+		 const unsigned char *namedata),
+	TP_ARGS(nn, namelen, namedata),
+	TP_STRUCT__entry(
+		__field(unsigned long long, boot_time)
+		__field(unsigned int, namelen)
+		__dynamic_array(unsigned char,  name, namelen)
+	),
+	TP_fast_assign(
+		__entry->boot_time = nn->boot_time;
+		__entry->namelen = namelen;
+		memcpy(__get_dynamic_array(name), namedata, namelen);
+	),
+	TP_printk("boot_time=%16llx nfs4_clientid=%.*s",
+		__entry->boot_time, __entry->namelen, __get_str(name))
+)
+
+#define DEFINE_CLID_EVENT(name) \
+DEFINE_EVENT(nfsd_clid_class, nfsd_clid_##name, \
+	TP_PROTO(const struct nfsd_net *nn, \
+		 unsigned int namelen, \
+		 const unsigned char *namedata), \
+	TP_ARGS(nn, namelen, namedata))
+
+DEFINE_CLID_EVENT(find);
+DEFINE_CLID_EVENT(reclaim);
+
+TRACE_EVENT(nfsd_clid_inuse_err,
+	TP_PROTO(const struct nfs4_client *clp),
+	TP_ARGS(clp),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__field(unsigned int, namelen)
+		__dynamic_array(unsigned char, name, clp->cl_name.len)
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		memcpy(__entry->addr, &clp->cl_addr,
+			sizeof(struct sockaddr_in6));
+		__entry->namelen = clp->cl_name.len;
+		memcpy(__get_dynamic_array(name), clp->cl_name.data,
+			clp->cl_name.len);
+	),
+	TP_printk("nfs4_clientid %.*s already in use by %pISpc, client %08x:%08x",
+		__entry->namelen, __get_str(name), __entry->addr,
+		__entry->cl_boot, __entry->cl_id)
+)
+
 TRACE_DEFINE_ENUM(NFSD_FILE_HASHED);
 TRACE_DEFINE_ENUM(NFSD_FILE_PENDING);
 TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_READ);

