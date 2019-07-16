Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CC66B033
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jul 2019 22:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfGPUEJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Jul 2019 16:04:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44001 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPUEJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Jul 2019 16:04:09 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so41977208ios.10
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jul 2019 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QW/RSSaqX7DCVOYb2NxsfmcHBH3BeWBKjGQ5pEXErN8=;
        b=m9HLzCxAiNUW8+//Z9U6rnMZL4qD44U7FMV+ydBZDBKEY9P8ThLIxVzuY3JOJUJiPH
         TuMDKL6ZJrXZ04PWwHpgZFjVyhRRzB12YrL3iGCwM4GQxwtyuNmbzSNAWB4xuBTcChRQ
         hG7+RzUPa9uED4qtBjz9GItdzus+rmdzkgAS6mBctzBr38O2hI9REdAXi3OLpzjkX72E
         mtg5jIK00Az5JT+72W+WFdCTUNDRm5/G33K+wU7tz7E5yd/NWWxvEEz7S7eoPMZU4Zup
         7KAUCAgp2Sb7uAFMj4vJCh95nYUUh+/vZmgA0DjyImbHNt+2F/aTIxpQTpvgJUfab476
         ymKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QW/RSSaqX7DCVOYb2NxsfmcHBH3BeWBKjGQ5pEXErN8=;
        b=f68FK30Z3SiW5Xpw8WcAMXQ87AuCywq9UpGs4XVcKROasqZ/ABLH1c7Cm/VVEXEwY5
         E/uBKVrycpa+879i40NnVsNh5F8Jqk514cwXeb6gaEgeDQHaYHva4ggyxd2pc0iOhyx3
         4nYYzj6xSfEsBcJClJhN2+yReesjf4UfCfMsgvN6ZnMJjWriyQgnD0idZOlbOO6W7XIq
         T10IfVzRHOsLJIqOeMqWmwNjC/d9XxqqsB/POie8kuJUz29yhEJGP1cVO0Ge1mwYuMK1
         PKi5Z947BvG/9raPYI0lnFBuIT+NvVs/tz3Nc2YzmIVI8Jo2eCWqmogC6i3qxv6cku9P
         DaBQ==
X-Gm-Message-State: APjAAAUgddToVQxHu8MBhVaCFGW0CwCzzSvoOg9AMiRpd076AiiV3yMs
        +KkRO2yEoMyqlBeaJ8JDc/5d7wM=
X-Google-Smtp-Source: APXvYqyGPaAO4MGOyf0zSBG74Nfk+g1setEI9ewRQuEoBqgNMqVvg9wl9/RA14tT/kANA3VNq0cWTQ==
X-Received: by 2002:a02:716e:: with SMTP id n46mr37616809jaf.137.1563307447202;
        Tue, 16 Jul 2019 13:04:07 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u4sm24997211iol.59.2019.07.16.13.04.05
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 13:04:05 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] SUNRPC: Fix up backchannel slot table accounting
Date:   Tue, 16 Jul 2019 16:01:56 -0400
Message-Id: <20190716200157.38583-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a per-transport maximum limit in the socket case, and add
helpers to allow the NFSv4 code to discover that limit.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c                 |  3 +++
 include/linux/sunrpc/bc_xprt.h    |  1 +
 include/linux/sunrpc/clnt.h       |  1 +
 include/linux/sunrpc/xprt.h       |  6 +++--
 net/sunrpc/backchannel_rqst.c     | 40 +++++++++++++++++--------------
 net/sunrpc/clnt.c                 | 13 ++++++++++
 net/sunrpc/svc.c                  |  2 +-
 net/sunrpc/xprtrdma/backchannel.c |  7 ++++++
 net/sunrpc/xprtrdma/transport.c   |  1 +
 net/sunrpc/xprtrdma/xprt_rdma.h   |  1 +
 net/sunrpc/xprtsock.c             |  1 +
 11 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 52de7245a2ee..39896afc6edf 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8380,6 +8380,7 @@ static void nfs4_init_channel_attrs(struct nfs41_create_session_args *args,
 {
 	unsigned int max_rqst_sz, max_resp_sz;
 	unsigned int max_bc_payload = rpc_max_bc_payload(clnt);
+	unsigned int max_bc_slots = rpc_num_bc_slots(clnt);
 
 	max_rqst_sz = NFS_MAX_FILE_IO_SIZE + nfs41_maxwrite_overhead;
 	max_resp_sz = NFS_MAX_FILE_IO_SIZE + nfs41_maxread_overhead;
@@ -8402,6 +8403,8 @@ static void nfs4_init_channel_attrs(struct nfs41_create_session_args *args,
 	args->bc_attrs.max_resp_sz_cached = 0;
 	args->bc_attrs.max_ops = NFS4_MAX_BACK_CHANNEL_OPS;
 	args->bc_attrs.max_reqs = max_t(unsigned short, max_session_cb_slots, 1);
+	if (args->bc_attrs.max_reqs > max_bc_slots)
+		args->bc_attrs.max_reqs = max_bc_slots;
 
 	dprintk("%s: Back Channel : max_rqst_sz=%u max_resp_sz=%u "
 		"max_resp_sz_cached=%u max_ops=%u max_reqs=%u\n",
diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xprt.h
index d4229a78524a..87d27e13d885 100644
--- a/include/linux/sunrpc/bc_xprt.h
+++ b/include/linux/sunrpc/bc_xprt.h
@@ -43,6 +43,7 @@ void xprt_destroy_backchannel(struct rpc_xprt *, unsigned int max_reqs);
 int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs);
 void xprt_destroy_bc(struct rpc_xprt *xprt, unsigned int max_reqs);
 void xprt_free_bc_rqst(struct rpc_rqst *req);
+unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt);
 
 /*
  * Determine if a shared backchannel is in use
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 4e070e00c143..abc63bd1be2b 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -194,6 +194,7 @@ void		rpc_setbufsize(struct rpc_clnt *, unsigned int, unsigned int);
 struct net *	rpc_net_ns(struct rpc_clnt *);
 size_t		rpc_max_payload(struct rpc_clnt *);
 size_t		rpc_max_bc_payload(struct rpc_clnt *);
+unsigned int	rpc_num_bc_slots(struct rpc_clnt *);
 void		rpc_force_rebind(struct rpc_clnt *);
 size_t		rpc_peeraddr(struct rpc_clnt *, struct sockaddr *, size_t);
 const char	*rpc_peeraddr2str(struct rpc_clnt *, enum rpc_display_format_t);
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index ed76e5fb36c1..13e108bcc9eb 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -158,6 +158,7 @@ struct rpc_xprt_ops {
 	int		(*bc_setup)(struct rpc_xprt *xprt,
 				    unsigned int min_reqs);
 	size_t		(*bc_maxpayload)(struct rpc_xprt *xprt);
+	unsigned int	(*bc_num_slots)(struct rpc_xprt *xprt);
 	void		(*bc_free_rqst)(struct rpc_rqst *rqst);
 	void		(*bc_destroy)(struct rpc_xprt *xprt,
 				      unsigned int max_reqs);
@@ -251,8 +252,9 @@ struct rpc_xprt {
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
 	struct svc_serv		*bc_serv;       /* The RPC service which will */
 						/* process the callback */
-	int			bc_alloc_count;	/* Total number of preallocs */
-	atomic_t		bc_free_slots;
+	unsigned int		bc_alloc_max;
+	unsigned int		bc_alloc_count;	/* Total number of preallocs */
+	atomic_t		bc_slot_count;	/* Number of allocated slots */
 	spinlock_t		bc_pa_lock;	/* Protects the preallocated
 						 * items */
 	struct list_head	bc_pa_list;	/* List of preallocated
diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index c47d82622fd1..339e8c077c2d 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -31,25 +31,20 @@ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #define RPCDBG_FACILITY	RPCDBG_TRANS
 #endif
 
+#define BC_MAX_SLOTS	64U
+
+unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt)
+{
+	return BC_MAX_SLOTS;
+}
+
 /*
  * Helper routines that track the number of preallocation elements
  * on the transport.
  */
 static inline int xprt_need_to_requeue(struct rpc_xprt *xprt)
 {
-	return xprt->bc_alloc_count < atomic_read(&xprt->bc_free_slots);
-}
-
-static inline void xprt_inc_alloc_count(struct rpc_xprt *xprt, unsigned int n)
-{
-	atomic_add(n, &xprt->bc_free_slots);
-	xprt->bc_alloc_count += n;
-}
-
-static inline int xprt_dec_alloc_count(struct rpc_xprt *xprt, unsigned int n)
-{
-	atomic_sub(n, &xprt->bc_free_slots);
-	return xprt->bc_alloc_count -= n;
+	return xprt->bc_alloc_count < xprt->bc_alloc_max;
 }
 
 /*
@@ -145,6 +140,9 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs)
 
 	dprintk("RPC:       setup backchannel transport\n");
 
+	if (min_reqs > BC_MAX_SLOTS)
+		min_reqs = BC_MAX_SLOTS;
+
 	/*
 	 * We use a temporary list to keep track of the preallocated
 	 * buffers.  Once we're done building the list we splice it
@@ -172,7 +170,9 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs)
 	 */
 	spin_lock(&xprt->bc_pa_lock);
 	list_splice(&tmp_list, &xprt->bc_pa_list);
-	xprt_inc_alloc_count(xprt, min_reqs);
+	xprt->bc_alloc_count += min_reqs;
+	xprt->bc_alloc_max += min_reqs;
+	atomic_add(min_reqs, &xprt->bc_slot_count);
 	spin_unlock(&xprt->bc_pa_lock);
 
 	dprintk("RPC:       setup backchannel transport done\n");
@@ -220,11 +220,13 @@ void xprt_destroy_bc(struct rpc_xprt *xprt, unsigned int max_reqs)
 		goto out;
 
 	spin_lock_bh(&xprt->bc_pa_lock);
-	xprt_dec_alloc_count(xprt, max_reqs);
+	xprt->bc_alloc_max -= max_reqs;
 	list_for_each_entry_safe(req, tmp, &xprt->bc_pa_list, rq_bc_pa_list) {
 		dprintk("RPC:        req=%p\n", req);
 		list_del(&req->rq_bc_pa_list);
 		xprt_free_allocation(req);
+		xprt->bc_alloc_count--;
+		atomic_dec(&xprt->bc_slot_count);
 		if (--max_reqs == 0)
 			break;
 	}
@@ -241,13 +243,14 @@ static struct rpc_rqst *xprt_get_bc_request(struct rpc_xprt *xprt, __be32 xid,
 	struct rpc_rqst *req = NULL;
 
 	dprintk("RPC:       allocate a backchannel request\n");
-	if (atomic_read(&xprt->bc_free_slots) <= 0)
-		goto not_found;
 	if (list_empty(&xprt->bc_pa_list)) {
 		if (!new)
 			goto not_found;
+		if (atomic_read(&xprt->bc_slot_count) >= BC_MAX_SLOTS)
+			goto not_found;
 		list_add_tail(&new->rq_bc_pa_list, &xprt->bc_pa_list);
 		xprt->bc_alloc_count++;
+		atomic_inc(&xprt->bc_slot_count);
 	}
 	req = list_first_entry(&xprt->bc_pa_list, struct rpc_rqst,
 				rq_bc_pa_list);
@@ -291,6 +294,7 @@ void xprt_free_bc_rqst(struct rpc_rqst *req)
 	if (xprt_need_to_requeue(xprt)) {
 		list_add_tail(&req->rq_bc_pa_list, &xprt->bc_pa_list);
 		xprt->bc_alloc_count++;
+		atomic_inc(&xprt->bc_slot_count);
 		req = NULL;
 	}
 	spin_unlock_bh(&xprt->bc_pa_lock);
@@ -357,7 +361,7 @@ void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
 
 	spin_lock(&xprt->bc_pa_lock);
 	list_del(&req->rq_bc_pa_list);
-	xprt_dec_alloc_count(xprt, 1);
+	xprt->bc_alloc_count--;
 	spin_unlock(&xprt->bc_pa_lock);
 
 	req->rq_private_buf.len = copied;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 383555d2b522..79c849391cb9 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1526,6 +1526,19 @@ size_t rpc_max_bc_payload(struct rpc_clnt *clnt)
 }
 EXPORT_SYMBOL_GPL(rpc_max_bc_payload);
 
+unsigned int rpc_num_bc_slots(struct rpc_clnt *clnt)
+{
+	struct rpc_xprt *xprt;
+	unsigned int ret;
+
+	rcu_read_lock();
+	xprt = rcu_dereference(clnt->cl_xprt);
+	ret = xprt->ops->bc_num_slots(xprt);
+	rcu_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rpc_num_bc_slots);
+
 /**
  * rpc_force_rebind - force transport to check that remote port is unchanged
  * @clnt: client to rebind
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e15cb704453e..220b79988000 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1595,7 +1595,7 @@ bc_svc_process(struct svc_serv *serv, struct rpc_rqst *req,
 	/* Parse and execute the bc call */
 	proc_error = svc_process_common(rqstp, argv, resv);
 
-	atomic_inc(&req->rq_xprt->bc_free_slots);
+	atomic_dec(&req->rq_xprt->bc_slot_count);
 	if (!proc_error) {
 		/* Processing error: drop the request */
 		xprt_free_bc_request(req);
diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index ce986591f213..59e624b1d7a0 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -52,6 +52,13 @@ size_t xprt_rdma_bc_maxpayload(struct rpc_xprt *xprt)
 	return maxmsg - RPCRDMA_HDRLEN_MIN;
 }
 
+unsigned int xprt_rdma_bc_max_slots(struct rpc_xprt *xprt)
+{
+	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
+
+	return r_xprt->rx_buf.rb_bc_srv_max_requests;
+}
+
 static int rpcrdma_bc_marshal_reply(struct rpc_rqst *rqst)
 {
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(rqst->rq_xprt);
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 4993aa49ecbe..52abddac19e5 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -812,6 +812,7 @@ static const struct rpc_xprt_ops xprt_rdma_procs = {
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
 	.bc_setup		= xprt_rdma_bc_setup,
 	.bc_maxpayload		= xprt_rdma_bc_maxpayload,
+	.bc_num_slots		= xprt_rdma_bc_max_slots,
 	.bc_free_rqst		= xprt_rdma_bc_free_rqst,
 	.bc_destroy		= xprt_rdma_bc_destroy,
 #endif
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 8378f45d2da7..92ce09fcea74 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -605,6 +605,7 @@ void xprt_rdma_cleanup(void);
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
 int xprt_rdma_bc_setup(struct rpc_xprt *, unsigned int);
 size_t xprt_rdma_bc_maxpayload(struct rpc_xprt *);
+unsigned int xprt_rdma_bc_max_slots(struct rpc_xprt *);
 int rpcrdma_bc_post_recv(struct rpcrdma_xprt *, unsigned int);
 void rpcrdma_bc_receive_call(struct rpcrdma_xprt *, struct rpcrdma_rep *);
 int xprt_rdma_bc_send_reply(struct rpc_rqst *rqst);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 3c2cc96afcaa..6b1fca51028a 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2788,6 +2788,7 @@ static const struct rpc_xprt_ops xs_tcp_ops = {
 #ifdef CONFIG_SUNRPC_BACKCHANNEL
 	.bc_setup		= xprt_setup_bc,
 	.bc_maxpayload		= xs_tcp_bc_maxpayload,
+	.bc_num_slots		= xprt_bc_max_slots,
 	.bc_free_rqst		= xprt_free_bc_rqst,
 	.bc_destroy		= xprt_destroy_bc,
 #endif
-- 
2.21.0

