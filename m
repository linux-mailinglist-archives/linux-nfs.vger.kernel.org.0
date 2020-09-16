Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F22026CEA0
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 00:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIPWXF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 18:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIPWXC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 18:23:02 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE9FC061A32
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:08 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id s88so267363ilb.6
        for <linux-nfs@vger.kernel.org>; Wed, 16 Sep 2020 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dyP3WvmFan7sebQUVao839wjBdNraxuzxfl07Af4Gok=;
        b=evDG5iyX4PMIQY4N0LiOZeKSvPjIzApWIA1t6a5vNYt7tsz0qGNJSbzOkvaxFLU2E7
         kZJYbODewA6vdBdfzZxKx9vBanQW3tXEXn5NoHxoDsQ8aDcS5aLQ1KAbFelyKtsnKUWN
         jJHcORsglJ+l+4+mnJUFjT+9xLAJ8sF6/QozbcneHeghTRXqTqpogoAc9Ro4rPAHKWN/
         1Hp+LpaGqBcIHs99y3+2WldHK/+45CMLmylTHtTVhGEe5sHdXeXMLENTw6ECAgipidCz
         U2tQ/kNRBzXXxU2iIb6Iojr6RY2UjpgxZ0dSqB+lD1kSTXPaUhgvMme9hkinWI8V8bho
         Lbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=dyP3WvmFan7sebQUVao839wjBdNraxuzxfl07Af4Gok=;
        b=LCV2/sQ+tTN7Quk/PMdqU02RTqOaNyo8FdvkVm2Ax1+5V10i7dCQ7HqaFLZ6Tx03GB
         JHcAYmvZH6f5Ka0bP0XJcTsFGu0bQJILo3lhNnDuwVnGa4Lw9vbElwIKQOgSy4e0AOBZ
         OoscjDmFdNrhZIbu2mxCrmYPoG7gAO60leHnqgs/J69qv3GLhshGKN1PUBG3AQPVEuau
         ctwAOPTK/xIonQ857VeDQLUFgodHxhxQixtqiAZrhRZPkNbaDnuzwoMhFnM5+wP3hPht
         4NLeQqxlUReR2nP5edAV/623Ymggt4snbUFsbPersOtFg8l4PRrXQgXH0e9Ze3VCXq46
         oIZQ==
X-Gm-Message-State: AOAM531SPd11OV6Q/hgkeSxqAHbs9r+SZvz/xOPK+GgoxYYp7OVXI6LG
        we0QKreSPue7cpzEVncBGHZgUJ1WzY0=
X-Google-Smtp-Source: ABdhPJz63q5wB6O9RQSoe3fA055WT4pSzZwGSgUjNix1jeu2do8fh4Q3qI/Z5Px/tyhp894CRpgrGQ==
X-Received: by 2002:a92:d988:: with SMTP id r8mr22435993iln.51.1600292587463;
        Wed, 16 Sep 2020 14:43:07 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r7sm11621203ilg.27.2020.09.16.14.43.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 14:43:06 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08GLh5Nl023008;
        Wed, 16 Sep 2020 21:43:05 GMT
Subject: [PATCH RFC 10/21] NFSD: Add client ID lifetime tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 16 Sep 2020 17:43:05 -0400
Message-ID: <160029258576.29208.5148448085599573840.stgit@klimt.1015granger.net>
In-Reply-To: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
References: <160029169954.29208.8757662600714736320.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These tracepoints enable troubleshooting of duplicate clientid strings
and they bracket NFSv4 state recovery. Examples:

NFSv4.0:

nfsd-1037  [000]  1282.828363: nfsd4_compound:       xid=0xef35f61d opcnt=1
nfsd-1037  [000]  1282.828488: nfsd_cb_args:         client 5f60f8c2:36e7ec84 callback addr=192.168.2.51:38549 prog=1073741824 ident=1
nfsd-1037  [000]  1282.828492: nfsd4_setclientid:    xid=0xef35f61d addr=192.168.2.51:0 \
	nfs4_clientid=Linux NFSv4.0 manet.1015granger.net/2d9f29bfc60e4c97b19dc38ae1bbed35/192.168.2.55 \
	verifier=1631b10 2717d415f client 5f60f8c2:36e7ec84
nfsd-1037  [000]  1282.828496: nfsd4_compoundstatus: xid=0xef35f61d op=1/1 OP_SETCLIENTID status=0

 ...

kworker/u8:2-1276  [001]  1802.149078: nfsd4_clid_purged:    client 5f60f8c2:36e7ec84
kworker/u8:2-1276  [002]  1802.152047: nfsd4_clid_destroy:   client 5f60f8c2:36e7ec84


NFSv4.1:

nfsd-1036  [003]   239.777632: nfsd4_compound:       xid=0x746ca73c opcnt=1
nfsd-1036  [003]   239.777776: nfsd4_exchange_id:    xid=0x746ca73c addr=192.168.2.51:0 \
	nfs4_clientid=Linux NFSv4.1 2d9f29bfc60e4c97b19dc38ae1bbed35/manet.1015granger.net \
	verifier=1631b102717d415f flags=SUPP_MOVED_REFER|USE_PNFS_MDS spa_how=SP4_MACH_CRED \
	seqid=0 client 5f610879:b615c40a
kworker/u8:4-144   [002]   239.777795: nfsd4_cb_work:        addr= client 5f610879:b615c409 procedure=CB_NULL
nfsd-1036  [003]   239.777887: nfsd4_compoundstatus: xid=0x746ca73c op=1/1 OP_EXCHANGE_ID status=0
nfsd-1036  [003]   239.779793: nfsd4_compound:       xid=0x756ca73c opcnt=1
nfsd-1036  [003]   239.780052: nfsd4_cb_state:       addr=192.168.2.51:0 client 5f610879:b615c40a state=UNKNOWN
kworker/u8:4-144   [002]   239.780063: nfsd4_cb_work:        addr=192.168.2.51:0 client 5f610879:b615c40a procedure=CB_NULL
kworker/u8:4-144   [002]   239.780416: nfsd4_cb_setup:       addr=192.168.2.51:0 client 5f610879:b615c40a state=UNKNOWN
nfsd-1036  [000]   239.780433: nfsd4_compoundstatus: xid=0x756ca73c op=1/1 OP_CREATE_SESSION status=0
nfsd-1036  [000]   239.782856: nfsd4_compound:       xid=0x766ca73c opcnt=2
nfsd-1036  [000]   239.782874: nfsd4_compoundstatus: xid=0x766ca73c op=1/2 OP_SEQUENCE status=0
nfsd-1036  [000]   239.782876: nfsd4_clid_reclaim_complete: client 5f610879:b615c40a
nfsd-1036  [000]   239.785385: nfsd4_compoundstatus: xid=0x766ca73c op=2/2 OP_RECLAIM_COMPLETE status=0

 ...

nfsd-1036  [003]   649.644616: nfsd4_compound:       xid=0x88d1a73c opcnt=1
nfsd-1036  [003]   649.647841: nfsd4_clid_destroy:   client 5f610879:b615c40a
kworker/u8:6-158   [002]   649.647854: nfsd4_cb_work:        addr=192.168.2.51:0 client 5f610879:b615c40a procedure=CB_NULL
nfsd-1036  [003]   649.647946: nfsd4_compoundstatus: xid=0x88d1a73c op=1/1 OP_DESTROY_CLIENTID status=0

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |   37 +++++--------
 fs/nfsd/trace.h     |  149 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 134 insertions(+), 52 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 0b3059b8b36c..974b3303d2fc 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1935,7 +1935,7 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net *nn)
 	 */
 	if (clid->cl_boot == (u32)nn->boot_time)
 		return 0;
-	trace_nfsd_clid_stale(clid);
+	trace_nfsd4_clid_stale(clid);
 	return 1;
 }
 
@@ -2077,6 +2077,8 @@ __destroy_client(struct nfs4_client *clp)
 	struct nfs4_delegation *dp;
 	struct list_head reaplist;
 
+	trace_nfsd4_clid_destroy(&clp->cl_clientid);
+
 	INIT_LIST_HEAD(&reaplist);
 	spin_lock(&state_lock);
 	while (!list_empty(&clp->cl_delegations)) {
@@ -3062,18 +3064,10 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_client *conf, *new;
 	struct nfs4_client *unconf = NULL;
 	__be32 status;
-	char			addr_str[INET6_ADDRSTRLEN];
 	nfs4_verifier		verf = exid->verifier;
-	struct sockaddr		*sa = svc_addr(rqstp);
 	bool	update = exid->flags & EXCHGID4_FLAG_UPD_CONFIRMED_REC_A;
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	rpc_ntop(sa, addr_str, sizeof(addr_str));
-	dprintk("%s rqstp=%p exid=%p clname.len=%u clname.data=%p "
-		"ip_addr=%s flags %x, spa_how %d\n",
-		__func__, rqstp, exid, exid->clname.len, exid->clname.data,
-		addr_str, exid->flags, exid->spa_how);
-
 	if (exid->flags & ~EXCHGID4_FLAG_MASK_A)
 		return nfserr_inval;
 
@@ -3200,8 +3194,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	exid->seqid = conf->cl_cs_slot.sl_seqid + 1;
 	nfsd4_set_ex_flags(conf, exid);
 
-	dprintk("nfsd4_exchange_id seqid %d flags %x\n",
-		conf->cl_cs_slot.sl_seqid, conf->cl_exchange_flags);
+	trace_nfsd4_exchange_id(rqstp, exid);
 	status = nfs_ok;
 
 out:
@@ -3894,8 +3887,11 @@ nfsd4_reclaim_complete(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
 {
 	struct nfsd4_reclaim_complete *rc = &u->reclaim_complete;
+	struct nfs4_client *clp = cstate->session->se_client;
 	__be32 status = 0;
 
+	trace_nfsd4_clid_reclaim_complete(&clp->cl_clientid);
+
 	if (rc->rca_one_fs) {
 		if (!cstate->current_fh.fh_dentry)
 			return nfserr_nofilehandle;
@@ -3907,12 +3903,11 @@ nfsd4_reclaim_complete(struct svc_rqst *rqstp,
 	}
 
 	status = nfserr_complete_already;
-	if (test_and_set_bit(NFSD4_CLIENT_RECLAIM_COMPLETE,
-			     &cstate->session->se_client->cl_flags))
+	if (test_and_set_bit(NFSD4_CLIENT_RECLAIM_COMPLETE, &clp->cl_flags))
 		goto out;
 
 	status = nfserr_stale_clientid;
-	if (is_client_expired(cstate->session->se_client))
+	if (is_client_expired(clp))
 		/*
 		 * The following error isn't really legal.
 		 * But we only get here if the client just explicitly
@@ -3923,8 +3918,8 @@ nfsd4_reclaim_complete(struct svc_rqst *rqstp,
 		goto out;
 
 	status = nfs_ok;
-	nfsd4_client_record_create(cstate->session->se_client);
-	inc_reclaim_complete(cstate->session->se_client);
+	nfsd4_client_record_create(clp);
+	inc_reclaim_complete(clp);
 out:
 	return status;
 }
@@ -3972,6 +3967,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	setclid->se_clientid.cl_id = new->cl_clientid.cl_id;
 	memcpy(setclid->se_confirm.data, new->cl_confirm.data, sizeof(setclid->se_confirm.data));
 	new = NULL;
+	trace_nfsd4_setclientid(rqstp, setclid);
 	status = nfs_ok;
 out:
 	spin_unlock(&nn->client_lock);
@@ -5314,7 +5310,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	trace_nfsd_clid_renew(clid);
+	trace_nfsd4_clid_renew(clid);
 	status = lookup_clientid(clid, cstate, nn, false);
 	if (status)
 		goto out;
@@ -5426,7 +5422,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 			break;
 		}
 		if (mark_client_expired_locked(clp)) {
-			trace_nfsd_clid_expired(&clp->cl_clientid);
+			trace_nfsd4_clid_expired(&clp->cl_clientid);
 			continue;
 		}
 		list_add(&clp->cl_lru, &reaplist);
@@ -5434,7 +5430,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_unlock(&nn->client_lock);
 	list_for_each_safe(pos, next, &reaplist) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		trace_nfsd_clid_purged(&clp->cl_clientid);
+		trace_nfsd4_clid_purged(&clp->cl_clientid);
 		list_del_init(&clp->cl_lru);
 		expire_client(clp);
 	}
@@ -7185,7 +7181,6 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 	unsigned int strhashval;
 	struct nfs4_client_reclaim *crp;
 
-	trace_nfsd_clid_reclaim(nn, name.len, name.data);
 	crp = alloc_reclaim();
 	if (crp) {
 		strhashval = clientstr_hashval(name);
@@ -7235,8 +7230,6 @@ nfsd4_find_reclaim_client(struct xdr_netobj name, struct nfsd_net *nn)
 	unsigned int strhashval;
 	struct nfs4_client_reclaim *crp = NULL;
 
-	trace_nfsd_clid_find(nn, name.len, name.data);
-
 	strhashval = clientstr_hashval(name);
 	list_for_each_entry(crp, &nn->reclaim_str_hashtbl[strhashval], cr_strhash) {
 		if (compare_blob(&crp->cr_name, &name) == 0) {
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index f58e43b5aa98..cbecefc3e112 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -11,6 +11,7 @@
 #include <linux/tracepoint.h>
 #include "export.h"
 #include "nfsfh.h"
+#include "xdr4.h"
 
 /*
  * from include/linux/fs.h
@@ -436,10 +437,12 @@ DECLARE_EVENT_CLASS(nfsd_clientid_class,
 )
 
 #define DEFINE_CLIENTID_EVENT(name) \
-DEFINE_EVENT(nfsd_clientid_class, nfsd_clid_##name, \
+DEFINE_EVENT(nfsd_clientid_class, nfsd4_clid_##name, \
 	TP_PROTO(const clientid_t *clid), \
 	TP_ARGS(clid))
 
+DEFINE_CLIENTID_EVENT(reclaim_complete);
+DEFINE_CLIENTID_EVENT(destroy);
 DEFINE_CLIENTID_EVENT(expired);
 DEFINE_CLIENTID_EVENT(purged);
 DEFINE_CLIENTID_EVENT(renew);
@@ -465,35 +468,6 @@ DEFINE_EVENT(nfsd_net_class, nfsd_##name, \
 DEFINE_NET_EVENT(grace_start);
 DEFINE_NET_EVENT(grace_complete);
 
-DECLARE_EVENT_CLASS(nfsd_clid_class,
-	TP_PROTO(const struct nfsd_net *nn,
-		 unsigned int namelen,
-		 const unsigned char *namedata),
-	TP_ARGS(nn, namelen, namedata),
-	TP_STRUCT__entry(
-		__field(unsigned long long, boot_time)
-		__field(unsigned int, namelen)
-		__dynamic_array(unsigned char,  name, namelen)
-	),
-	TP_fast_assign(
-		__entry->boot_time = nn->boot_time;
-		__entry->namelen = namelen;
-		memcpy(__get_dynamic_array(name), namedata, namelen);
-	),
-	TP_printk("boot_time=%16llx nfs4_clientid=%.*s",
-		__entry->boot_time, __entry->namelen, __get_str(name))
-)
-
-#define DEFINE_CLID_EVENT(name) \
-DEFINE_EVENT(nfsd_clid_class, nfsd_clid_##name, \
-	TP_PROTO(const struct nfsd_net *nn, \
-		 unsigned int namelen, \
-		 const unsigned char *namedata), \
-	TP_ARGS(nn, namelen, namedata))
-
-DEFINE_CLID_EVENT(find);
-DEFINE_CLID_EVENT(reclaim);
-
 TRACE_EVENT(nfsd_clid_inuse_err,
 	TP_PROTO(const struct nfs4_client *clp),
 	TP_ARGS(clp),
@@ -937,6 +911,121 @@ TRACE_EVENT(nfsd_setattr_args,
 	)
 );
 
+TRACE_EVENT(nfsd4_setclientid,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_setclientid *setclid
+	),
+	TP_ARGS(rqstp, setclid),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__array(char, verifier, NFS4_VERIFIER_SIZE)
+		__field(int, len)
+		__dynamic_array(unsigned char, clientid, setclid->se_name.len)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->cl_boot = setclid->se_clientid.cl_boot;
+		__entry->cl_id = setclid->se_clientid.cl_id;
+		memcpy(__entry->addr, svc_addr(rqstp), sizeof(struct sockaddr_in6));
+		memcpy(__entry->verifier, &setclid->se_verf, NFS4_VERIFIER_SIZE);
+		__entry->len = setclid->se_name.len;
+		memcpy(__get_dynamic_array(clientid),
+		       setclid->se_name.data, setclid->se_name.len);
+	),
+	TP_printk("xid=0x%08x addr=%pISpc nfs4_clientid=%.*s verifier=%s client=%08x:%08x",
+		__entry->xid, __entry->addr,
+		__entry->len, __get_str(clientid),
+		__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE),
+		__entry->cl_boot, __entry->cl_id
+	)
+);
+
+/*
+ * from include/uapi/linux/nfs4.h
+ */
+#define NFSD_EXCHGID4_FLAG_LIST					\
+	nfsd_exchgid4_flag(SUPP_MOVED_REFER)			\
+	nfsd_exchgid4_flag(SUPP_MOVED_MIGR)			\
+	nfsd_exchgid4_flag(BIND_PRINC_STATEID)			\
+	nfsd_exchgid4_flag(USE_NON_PNFS)			\
+	nfsd_exchgid4_flag(USE_PNFS_MDS)			\
+	nfsd_exchgid4_flag(USE_PNFS_DS)				\
+	nfsd_exchgid4_flag(MASK_PNFS)				\
+	nfsd_exchgid4_flag(UPD_CONFIRMED_REC_A)			\
+	nfsd_exchgid4_flag_end(CONFIRMED_R)
+
+#undef nfsd_exchgid4_flag
+#undef nfsd_exchgid4_flag_end
+#define nfsd_exchgid4_flag(x)		TRACE_DEFINE_ENUM(EXCHGID4_FLAG_##x);
+#define nfsd_exchgid4_flag_end(x)	TRACE_DEFINE_ENUM(EXCHGID4_FLAG_##x);
+
+NFSD_EXCHGID4_FLAG_LIST
+
+#undef nfsd_exchgid4_flag
+#undef nfsd_exchgid4_flag_end
+#define nfsd_exchgid4_flag(x)		{ EXCHGID4_FLAG_##x, #x },
+#define nfsd_exchgid4_flag_end(x)	{ EXCHGID4_FLAG_##x, #x }
+
+#define show_nfsd_exchgid4_flags(x) \
+	__print_flags(x, "|", NFSD_EXCHGID4_FLAG_LIST)
+
+/*
+ * from include/linux/nfs4.h
+ */
+TRACE_DEFINE_ENUM(SP4_NONE);
+TRACE_DEFINE_ENUM(SP4_MACH_CRED);
+TRACE_DEFINE_ENUM(SP4_SSV);
+
+#define show_nfsd_exchid4_spa_how(x) \
+	__print_symbolic(x, \
+		{ SP4_NONE,		"SP4_NONE" }, \
+		{ SP4_MACH_CRED,	"SP4_MACH_CRED" }, \
+		{ SP4_SSV,		"SP4_SSV" })
+
+TRACE_EVENT(nfsd4_exchange_id,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct nfsd4_exchange_id *exid
+	),
+	TP_ARGS(rqstp, exid),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, seqid)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(unsigned long, flags)
+		__field(unsigned long, spa_how)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__array(char, verifier, NFS4_VERIFIER_SIZE)
+		__field(int, len)
+		__dynamic_array(unsigned char, clientid, exid->clname.len)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->seqid = exid->seqid - 1;
+		__entry->cl_boot = exid->clientid.cl_boot;
+		__entry->cl_id = exid->clientid.cl_id;
+		__entry->flags = exid->flags;
+		__entry->spa_how = exid->spa_how;
+		memcpy(__entry->addr, svc_addr(rqstp), sizeof(struct sockaddr_in6));
+		memcpy(__entry->verifier, &exid->verifier, NFS4_VERIFIER_SIZE);
+		__entry->len = exid->clname.len;
+		memcpy(__get_dynamic_array(clientid), exid->clname.data, exid->clname.len);
+	),
+	TP_printk("xid=0x%08x addr=%pISpc nfs4_clientid=%.*s verifier=%s flags=%s spa_how=%s seqid=%u client=%08x:%08x",
+		__entry->xid, __entry->addr,
+		__entry->len, __get_str(clientid),
+		__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE),
+		show_nfsd_exchgid4_flags(__entry->flags),
+		show_nfsd_exchid4_spa_how(__entry->spa_how),
+		__entry->seqid, __entry->cl_boot, __entry->cl_id
+	)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH


