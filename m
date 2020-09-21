Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5E52731A4
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIUSMM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgIUSMM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:12:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724FBC061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m17so16484849ioo.1
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WeKUxNVt+8zhLOcbPlJ9sZD8g3/VzZikI/k/oonllhk=;
        b=lhPHHH9fQdQHCpwXhadkESMQM+mrUgk7XN68R4cZOlQnhvIFXrEpkbiZr/1e0DvXMB
         1l4lAznhJ87aF9f+xbqOVxgo/jx3GN+1jvMLdH+MKRnQVoA+Mc608N7nAyYTpio855XK
         wxiKhL2FYNiBddPjh/nsNzt2VTIsv97k+aO0MrZ3ULJ/YSXazoxuWeayw/DZL7FgsDBy
         dMXObbpL/Kku69AM2eq2crg0s3OZvETtxDEfblsfvGpG2WYKIIkkOOBRYNKhZqUiSxTj
         7292SnXv6cTG6XTvV69Ij459FoarmBkm+QqqnrSS0g8dXAxT+z2rUSMyIctQEgEjcAi0
         dCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WeKUxNVt+8zhLOcbPlJ9sZD8g3/VzZikI/k/oonllhk=;
        b=fKDEH+xzprfmZhSYfpujcK1Hwzk4/zD2mrPETtWsXHezflHLj/E/9Vu9ZkEAC/Jo0B
         lg8hi5w7LFsHkeYiir+jN+iw8HgXUpwHt8/MGZpUzxUSJdNMf0L/zbaTM268dTr9R+ac
         4HmhOOrFZz9f1sog7EWGXZ0g5R3+XtAbU9zA2BoFHqg0eHGvdo0UoJbTLZIVbQaSH30V
         ZCgpn2rNg0FpXMEPJWVMsJBR3BNr4j2mo3pZZ9wRmCakHgIeEGVQoLi3XkNig74oUinP
         tsU1wodOQgsnShrNaY7pxYwVsw1Jb+nnhTnW1eYv4K0O52UEhZdIQtBNIut1SJ2X/vVx
         rJbg==
X-Gm-Message-State: AOAM531nx//FddxQZu+F43Sf0NuLbDhQriuDuPzHfb3EGffFuW4x8CcQ
        j6KKNJcC23t+ZXISXqHOCWI=
X-Google-Smtp-Source: ABdhPJzRvpQybZnQjKsUUnWgJOiSbxSvSv+GWgqWIv9XDiHNeRs1uWV2dePComdWZLTixiyf6xyOtg==
X-Received: by 2002:a05:6638:22ba:: with SMTP id z26mr1026111jas.55.1600711931719;
        Mon, 21 Sep 2020 11:12:11 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a23sm6034912ioc.54.2020.09.21.11.12.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:12:10 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LIC8l6003887;
        Mon, 21 Sep 2020 18:12:08 GMT
Subject: [PATCH v2 15/27] NFSD: Add client ID lifetime tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:12:08 -0400
Message-ID: <160071192895.1468.17380041365423822743.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
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
nfsd-1037  [000]  1282.828496: nfsd4_compoundstatus: xid=0xef35f61d op=1/1 OP_SETCLIENTID status=OK

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
nfsd-1036  [003]   239.777887: nfsd4_compoundstatus: xid=0x746ca73c op=1/1 OP_EXCHANGE_ID status=OK
nfsd-1036  [003]   239.779793: nfsd4_compound:       xid=0x756ca73c opcnt=1
nfsd-1036  [003]   239.780052: nfsd4_cb_state:       addr=192.168.2.51:0 client 5f610879:b615c40a state=UNKNOWN
kworker/u8:4-144   [002]   239.780063: nfsd4_cb_work:        addr=192.168.2.51:0 client 5f610879:b615c40a procedure=CB_NULL
kworker/u8:4-144   [002]   239.780416: nfsd4_cb_setup:       addr=192.168.2.51:0 client 5f610879:b615c40a state=UNKNOWN
nfsd-1036  [000]   239.780433: nfsd4_compoundstatus: xid=0x756ca73c op=1/1 OP_CREATE_SESSION status=OK
nfsd-1036  [000]   239.782856: nfsd4_compound:       xid=0x766ca73c opcnt=2
nfsd-1036  [000]   239.782874: nfsd4_compoundstatus: xid=0x766ca73c op=1/2 OP_SEQUENCE status=OK
nfsd-1036  [000]   239.782876: nfsd4_clid_reclaim_complete: client 5f610879:b615c40a
nfsd-1036  [000]   239.785385: nfsd4_compoundstatus: xid=0x766ca73c op=2/2 OP_RECLAIM_COMPLETE status=OK

 ...

nfsd-1036  [003]   649.644616: nfsd4_compound:       xid=0x88d1a73c opcnt=1
nfsd-1036  [003]   649.647841: nfsd4_clid_destroy:   client 5f610879:b615c40a
kworker/u8:6-158   [002]   649.647854: nfsd4_cb_work:        addr=192.168.2.51:0 client 5f610879:b615c40a procedure=CB_NULL
nfsd-1036  [003]   649.647946: nfsd4_compoundstatus: xid=0x88d1a73c op=1/1 OP_DESTROY_CLIENTID status=OK

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c        |   37 ++++++---------
 fs/nfsd/trace.h            |  107 ++++++++++++++++++++++++++++++++------------
 fs/nfsd/xdr4.h             |    3 +
 include/trace/events/nfs.h |   22 +++++++++
 4 files changed, 116 insertions(+), 53 deletions(-)

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
index afcb3bcf13f2..192d039da0ec 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -14,6 +14,7 @@
 
 #include "export.h"
 #include "nfsfh.h"
+#include "xdr4.h"
 
 #define show_nfsd_may_flags(x)						\
 	__print_flags(x, "|",						\
@@ -294,6 +295,79 @@ DEFINE_EVENT(nfsd_err_class, nfsd_##name,	\
 DEFINE_NFSD_ERR_EVENT(read_err);
 DEFINE_NFSD_ERR_EVENT(write_err);
 
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
+		show_nfs4_exchgid4_flags(__entry->flags),
+		show_nfs4_exchid4_spa_how(__entry->spa_how),
+		__entry->seqid, __entry->cl_boot, __entry->cl_id
+	)
+);
+
 TRACE_EVENT(nfsd4_compound,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,
@@ -433,10 +507,12 @@ DECLARE_EVENT_CLASS(nfsd_clientid_class,
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
@@ -462,35 +538,6 @@ DEFINE_EVENT(nfsd_net_class, nfsd_##name, \
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
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 66499fb6b567..9267a4775263 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -763,6 +763,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op);
 
 #define NFS4_SVC_XDRSIZE		sizeof(struct nfsd4_compoundargs)
 
+#ifdef CONFIG_NFSD_V3
 static inline void
 set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 {
@@ -778,7 +779,7 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 	cinfo->after_ctime_nsec = fhp->fh_post_attr.ctime.tv_nsec;
 
 }
-
+#endif /* CONFIG_NFSD_V3 */
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
 int nfs4svc_encode_voidres(struct svc_rqst *, __be32 *);
diff --git a/include/trace/events/nfs.h b/include/trace/events/nfs.h
index 8e3de3b421f4..76f661e8cdf4 100644
--- a/include/trace/events/nfs.h
+++ b/include/trace/events/nfs.h
@@ -359,3 +359,25 @@ TRACE_DEFINE_ENUM(NFS_FILE_SYNC);
 		{ SEQ4_STATUS_RESTART_RECLAIM_NEEDED,	"RESTART_RECLAIM_NEEDED" }, \
 		{ SEQ4_STATUS_CB_PATH_DOWN_SESSION,	"CB_PATH_DOWN_SESSION" }, \
 		{ SEQ4_STATUS_BACKCHANNEL_FAULT,	"BACKCHANNEL_FAULT" })
+
+#define show_nfs4_exchgid4_flags(x) \
+	__print_flags(x, "|", \
+		{ EXCHGID4_FLAG_SUPP_MOVED_REFER,	"SUPP_MOVED_REFER" }, \
+		{ EXCHGID4_FLAG_SUPP_MOVED_MIGR,	"SUPP_MOVED_MIGR" }, \
+		{ EXCHGID4_FLAG_BIND_PRINC_STATEID,	"BIND_PRINC_STATEID" }, \
+		{ EXCHGID4_FLAG_USE_NON_PNFS,		"USE_NON_PNFS" }, \
+		{ EXCHGID4_FLAG_USE_PNFS_MDS,		"USE_PNFS_MDS" }, \
+		{ EXCHGID4_FLAG_USE_PNFS_DS,		"USE_PNFS_DS" }, \
+		{ EXCHGID4_FLAG_MASK_PNFS,		"MASK_PNFS" }, \
+		{ EXCHGID4_FLAG_UPD_CONFIRMED_REC_A,	"UPD_CONFIRMED_REC_A" }, \
+		{ EXCHGID4_FLAG_CONFIRMED_R,		"CONFIRMED_R" })
+
+TRACE_DEFINE_ENUM(SP4_NONE);
+TRACE_DEFINE_ENUM(SP4_MACH_CRED);
+TRACE_DEFINE_ENUM(SP4_SSV);
+
+#define show_nfs4_exchid4_spa_how(x) \
+	__print_symbolic(x, \
+		{ SP4_NONE,				"NONE" }, \
+		{ SP4_MACH_CRED,			"MACH_CRED" }, \
+		{ SP4_SSV,				"SSV" })


