Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFBB79B79F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355511AbjIKWAM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 18:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbjIKMu1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 08:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A71CCEB
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 05:50:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F993C433C7;
        Mon, 11 Sep 2023 12:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694436621;
        bh=funz6Wq9f0LidCNXKO99Xw5AdCgtADdnX9Xc5HOKx18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoNmr29XUx+h7HDkzOAxgShar8Y7HGEVVfw6PwxY5uNkXEWzAIc7e3oBxLNU6/F5U
         TJh+yI5/Zn7R9q4jKxN9o/GUPSNs9v871oopduLU0R59KrQq9SRAYyqzEt3PRsyAZj
         YmziDvvR66NLnpfZXf8hpEJNjjvy4nCvVVcUtfY2ZDErNq3w+P9j/ClctoCi5cGFj/
         fNN7oIWJJsw3Ly0xeg2/hzuKfmfzJs1NKnx504zcNBrbr6dA9nfStqM2XnYKw5chwp
         cG4TA8P08mP5Gyt/2MBfMKrVvDeQRMbUQpgdyiTWwC7ZvMbkr6DeDF7545VPQNeVZX
         boHze9nfKIRng==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org
Subject: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Date:   Mon, 11 Sep 2023 14:49:46 +0200
Message-ID: <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694436263.git.lorenzo@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce rpc_status netlink support for NFSD in order to dump pending
RPC requests debugging information from userspace.

Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/nfsctl.c           | 192 ++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsd.h             |  16 ++++
 fs/nfsd/nfssvc.c           |  15 +++
 fs/nfsd/state.h            |   2 -
 include/linux/sunrpc/svc.h |   1 +
 5 files changed, 222 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1be66088849c..b862a759ea15 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -26,6 +26,7 @@
 #include "pnfs.h"
 #include "filecache.h"
 #include "trace.h"
+#include "nfs_netlink_gen.h"
 
 /*
  *	We have a single directory with several nodes in it.
@@ -1497,17 +1498,199 @@ unsigned int nfsd_net_id;
 
 int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb)
 {
-	return 0;
+	struct nfsd_net *nn = net_generic(sock_net(cb->skb->sk), nfsd_net_id);
+	int ret = -ENODEV;
+
+	mutex_lock(&nfsd_mutex);
+	if (nn->nfsd_serv) {
+		svc_get(nn->nfsd_serv);
+		ret = 0;
+	}
+	mutex_unlock(&nfsd_mutex);
+
+	return ret;
 }
 
-int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb)
+static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
+					    struct netlink_callback *cb,
+					    struct nfsd_genl_rqstp *rqstp)
 {
+	void *hdr;
+	int i;
+
+	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			  &nfsd_server_nl_family, NLM_F_MULTI,
+			  NFSD_CMD_RPC_STATUS_GET);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put_be32(skb, NFSD_ATTR_RPC_STATUS_XID, rqstp->rq_xid) ||
+	    nla_put_u32(skb, NFSD_ATTR_RPC_STATUS_FLAGS, rqstp->rq_flags) ||
+	    nla_put_u32(skb, NFSD_ATTR_RPC_STATUS_PROG, rqstp->rq_prog) ||
+	    nla_put_u32(skb, NFSD_ATTR_RPC_STATUS_PROC, rqstp->rq_proc) ||
+	    nla_put_u8(skb, NFSD_ATTR_RPC_STATUS_VERSION, rqstp->rq_vers) ||
+	    nla_put_s64(skb, NFSD_ATTR_RPC_STATUS_SERVICE_TIME,
+			ktime_to_us(rqstp->rq_stime),
+			NFSD_ATTR_RPC_STATUS_PAD))
+		return -ENOBUFS;
+
+	switch (rqstp->saddr.sa_family) {
+	case AF_INET: {
+		const struct sockaddr_in *s_in, *d_in;
+
+		s_in = (const struct sockaddr_in *)&rqstp->saddr;
+		d_in = (const struct sockaddr_in *)&rqstp->daddr;
+		if (nla_put_in_addr(skb, NFSD_ATTR_RPC_STATUS_SADDR4,
+				    s_in->sin_addr.s_addr) ||
+		    nla_put_in_addr(skb, NFSD_ATTR_RPC_STATUS_DADDR4,
+				    d_in->sin_addr.s_addr) ||
+		    nla_put_be16(skb, NFSD_ATTR_RPC_STATUS_SPORT,
+				 s_in->sin_port) ||
+		    nla_put_be16(skb, NFSD_ATTR_RPC_STATUS_DPORT,
+				 d_in->sin_port))
+			return -ENOBUFS;
+		break;
+	}
+	case AF_INET6: {
+		const struct sockaddr_in6 *s_in, *d_in;
+
+		s_in = (const struct sockaddr_in6 *)&rqstp->saddr;
+		d_in = (const struct sockaddr_in6 *)&rqstp->daddr;
+		if (nla_put_in6_addr(skb, NFSD_ATTR_RPC_STATUS_SADDR6,
+				     &s_in->sin6_addr) ||
+		    nla_put_in6_addr(skb, NFSD_ATTR_RPC_STATUS_DADDR6,
+				     &d_in->sin6_addr) ||
+		    nla_put_be16(skb, NFSD_ATTR_RPC_STATUS_SPORT,
+				 s_in->sin6_port) ||
+		    nla_put_be16(skb, NFSD_ATTR_RPC_STATUS_DPORT,
+				 d_in->sin6_port))
+			return -ENOBUFS;
+		break;
+	}
+	default:
+		break;
+	}
+
+	if (rqstp->opcnt) {
+		struct nlattr *attr;
+
+		attr = nla_nest_start(skb, NFSD_ATTR_RPC_STATUS_COMPOND_OP);
+		if (!attr)
+			return -ENOBUFS;
+
+		for (i = 0; i < rqstp->opcnt; i++) {
+			struct nlattr *op_attr;
+
+			op_attr = nla_nest_start(skb, i);
+			if (!op_attr)
+				return -ENOBUFS;
+
+			if (nla_put_u32(skb, NFSD_ATTR_RPC_STATUS_COMP_OP,
+					rqstp->opnum[i]))
+				return -ENOBUFS;
+
+			nla_nest_end(skb, op_attr);
+		}
+
+		nla_nest_end(skb, attr);
+	}
+
+	genlmsg_end(skb, hdr);
+
 	return 0;
 }
 
 int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 					 struct netlink_callback *cb)
 {
+	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
+	int i, ret, rqstp_index;
+
+	rcu_read_lock();
+
+	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
+		struct svc_rqst *rqstp;
+
+		if (i < cb->args[0]) /* already consumed */
+			continue;
+
+		rqstp_index = 0;
+		list_for_each_entry_rcu(rqstp,
+				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
+				rq_all) {
+			struct nfsd_genl_rqstp genl_rqstp;
+			unsigned int status_counter;
+
+			if (rqstp_index++ < cb->args[1]) /* already consumed */
+				continue;
+			/*
+			 * Acquire rq_status_counter before parsing the rqst
+			 * fields. rq_status_counter is set to an odd value in
+			 * order to notify the consumers the rqstp fields are
+			 * meaningful.
+			 */
+			status_counter =
+				smp_load_acquire(&rqstp->rq_status_counter);
+			if (!(status_counter & 1))
+				continue;
+
+			genl_rqstp.rq_xid = rqstp->rq_xid;
+			genl_rqstp.rq_flags = rqstp->rq_flags;
+			genl_rqstp.rq_vers = rqstp->rq_vers;
+			genl_rqstp.rq_prog = rqstp->rq_prog;
+			genl_rqstp.rq_proc = rqstp->rq_proc;
+			genl_rqstp.rq_stime = rqstp->rq_stime;
+			genl_rqstp.opcnt = 0;
+			memcpy(&genl_rqstp.daddr, svc_daddr(rqstp),
+			       sizeof(struct sockaddr));
+			memcpy(&genl_rqstp.saddr, svc_addr(rqstp),
+			       sizeof(struct sockaddr));
+
+#ifdef CONFIG_NFSD_V4
+			if (rqstp->rq_vers == NFS4_VERSION &&
+			    rqstp->rq_proc == NFSPROC4_COMPOUND) {
+				/* NFSv4 compund */
+				struct nfsd4_compoundargs *args;
+				int j;
+
+				args = rqstp->rq_argp;
+				genl_rqstp.opcnt = args->opcnt;
+				for (j = 0; j < genl_rqstp.opcnt; j++)
+					genl_rqstp.opnum[j] =
+						args->ops[j].opnum;
+			}
+#endif /* CONFIG_NFSD_V4 */
+
+			/*
+			 * Acquire rq_status_counter before reporting the rqst
+			 * fields to the user.
+			 */
+			if (smp_load_acquire(&rqstp->rq_status_counter) !=
+			    status_counter)
+				continue;
+
+			ret = nfsd_genl_rpc_status_compose_msg(skb, cb,
+							       &genl_rqstp);
+			if (ret)
+				goto out;
+		}
+	}
+
+	cb->args[0] = i;
+	cb->args[1] = rqstp_index;
+	ret = skb->len;
+out:
+	rcu_read_unlock();
+
+	return ret;
+}
+
+int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb)
+{
+	mutex_lock(&nfsd_mutex);
+	nfsd_put(sock_net(cb->skb->sk));
+	mutex_unlock(&nfsd_mutex);
+
 	return 0;
 }
 
@@ -1605,6 +1788,10 @@ static int __init init_nfsd(void)
 	retval = register_filesystem(&nfsd_fs_type);
 	if (retval)
 		goto out_free_all;
+	retval = genl_register_family(&nfsd_server_nl_family);
+	if (retval)
+		goto out_free_all;
+
 	return 0;
 out_free_all:
 	nfsd4_destroy_laundry_wq();
@@ -1629,6 +1816,7 @@ static int __init init_nfsd(void)
 
 static void __exit exit_nfsd(void)
 {
+	genl_unregister_family(&nfsd_server_nl_family);
 	unregister_filesystem(&nfsd_fs_type);
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 11c14faa6c67..d787bd38c053 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -62,6 +62,22 @@ struct readdir_cd {
 	__be32			err;	/* 0, nfserr, or nfserr_eof */
 };
 
+/* Maximum number of operations per session compound */
+#define NFSD_MAX_OPS_PER_COMPOUND	50
+
+struct nfsd_genl_rqstp {
+	struct sockaddr daddr;
+	struct sockaddr saddr;
+	unsigned long rq_flags;
+	ktime_t rq_stime;
+	__be32 rq_xid;
+	u32 rq_vers;
+	u32 rq_prog;
+	u32 rq_proc;
+	/* NFSv4 compund */
+	u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
+	u16 opcnt;
+};
 
 extern struct svc_program	nfsd_program;
 extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1582af33e204..fad34a7325b3 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -998,6 +998,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
 		goto out_decode_err;
 
+	/*
+	 * Release rq_status_counter setting it to an odd value after the rpc
+	 * request has been properly parsed. rq_status_counter is used to
+	 * notify the consumers if the rqstp fields are stable
+	 * (rq_status_counter is odd) or not meaningful (rq_status_counter
+	 * is even).
+	 */
+	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter | 1);
+
 	rp = NULL;
 	switch (nfsd_cache_lookup(rqstp, &rp)) {
 	case RC_DOIT:
@@ -1015,6 +1024,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
+	/*
+	 * Release rq_status_counter setting it to an even value after the rpc
+	 * request has been properly processed.
+	 */
+	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1);
+
 	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
 out_cached_reply:
 	return 1;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index cbddcf484dba..41bdc913fa71 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -174,8 +174,6 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
 
 /* Maximum number of slots per session. 160 is useful for long haul TCP */
 #define NFSD_MAX_SLOTS_PER_SESSION     160
-/* Maximum number of operations per session compound */
-#define NFSD_MAX_OPS_PER_COMPOUND	50
 /* Maximum  session per slot cache size */
 #define NFSD_SLOT_CACHE_SIZE		2048
 /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index dbf5b21feafe..caa20defd255 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -251,6 +251,7 @@ struct svc_rqst {
 						 * net namespace
 						 */
 	void **			rq_lease_breaker; /* The v4 client breaking a lease */
+	unsigned int		rq_status_counter; /* RPC processing counter */
 };
 
 /* bits for rq_flags */
-- 
2.41.0

