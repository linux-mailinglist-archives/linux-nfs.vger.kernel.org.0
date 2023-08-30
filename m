Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD778D820
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjH3S3V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244376AbjH3NGN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 09:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4E0193
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 06:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D62261315
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 13:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321C7C433C9;
        Wed, 30 Aug 2023 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693400769;
        bh=EMWmVSVnhtukjyHDBv7UAQek9MCkWdJqN2xrvJoTq/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdzoHKmFZimagsXDywc4P8zilGaLTEGBTgVjuGl7M/Fo5V9CTSlcjY5LQPL6s2VOL
         S0erNWV567JFky+BG3ipRtrKQKbAozbsrxwrbzLsel5uV5/HFpdNAn1kkktWn86g3m
         OZQY8SkBo3j9S3ujDOS0oDMxDNDXALy+b0aSc1Dk7nxbrurc0e+zyRSPMNDoesmaDl
         2HOsuwYP78Hq/+HOfQWOl1xSGv72+tp950/r+CgBEysFJ9gVxU1x0gM1bC/5FXQd86
         TJ1PJBx1jnbcq9dj1kKz9SMbrMc+CRkkKiYxQftcrD+BbGuLJFU83UDi4QWB9vgjCK
         /zlnlEaKfQvZw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH v7 3/3] NFSD: add rpc_status netlink support
Date:   Wed, 30 Aug 2023 15:05:46 +0200
Message-ID: <b750dd468dd3fe4af8febf3a0bf8bc278ca7c05e.1693400242.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693400242.git.lorenzo@kernel.org>
References: <cover.1693400242.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce rpc_status netlink support for NFSD in order to dump pending
RPC requests debugging information from userspace.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/nfsctl.c           | 275 +++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h             |  19 +++
 fs/nfsd/nfssvc.c           |  15 ++
 fs/nfsd/state.h            |   2 -
 include/linux/sunrpc/svc.h |   1 +
 include/uapi/linux/nfs.h   |  54 ++++++++
 6 files changed, 364 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 33f80d289d63..4626a0002ceb 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -17,6 +17,9 @@
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/module.h>
 #include <linux/fsnotify.h>
+#include <net/genetlink.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
 
 #include "idmap.h"
 #include "nfsd.h"
@@ -1495,6 +1498,273 @@ static int create_proc_exports_entry(void)
 
 unsigned int nfsd_net_id;
 
+/* the netlink family */
+static struct genl_family nfsd_genl;
+
+static const struct nla_policy
+nfsd_rpc_status_compound_policy[NFS_ATTR_RPC_STATUS_COMPOUND_MAX + 1] = {
+	[NFS_ATTR_RPC_STATUS_COMPOUND_OP] = { .type = NLA_STRING },
+};
+
+static const struct nla_policy
+nfsd_rpc_status_policy[NFS_ATTR_RPC_STATUS_MAX + 1] = {
+	[NFS_ATTR_RPC_STATUS_XID] = { .type = NLA_U32 },
+	[NFS_ATTR_RPC_STATUS_FLAGS] = { .type = NLA_U32 },
+	[NFS_ATTR_RPC_STATUS_PC_NAME] = { .type = NLA_STRING },
+	[NFS_ATTR_RPC_STATUS_VERSION] = { .type = NLA_U8 },
+	[NFS_ATTR_RPC_STATUS_STIME] = { .type = NLA_S64 },
+	[NFS_ATTR_RPC_STATUS_SADDR4] = { .len = sizeof_field(struct iphdr, saddr) },
+	[NFS_ATTR_RPC_STATUS_DADDR4] = { .len = sizeof_field(struct iphdr, daddr) },
+	[NFS_ATTR_RPC_STATUS_SADDR6] = { .len = sizeof_field(struct ipv6hdr, saddr) },
+	[NFS_ATTR_RPC_STATUS_DADDR6] = { .len = sizeof_field(struct ipv6hdr, daddr) },
+	[NFS_ATTR_RPC_STATUS_SPORT] = { .type = NLA_U16 },
+	[NFS_ATTR_RPC_STATUS_DPORT] = { .type = NLA_U16 },
+	[NFS_ATTR_RPC_STATUS_COMPOUND] =
+		NLA_POLICY_NESTED_ARRAY(nfsd_rpc_status_compound_policy),
+};
+
+static const struct nla_policy
+nfsd_genl_policy[NFS_ATTR_MAX + 1] = {
+	[NFS_ATTR_RPC_STATUS] = NLA_POLICY_NESTED_ARRAY(nfsd_rpc_status_policy),
+};
+
+static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb, int index,
+					    struct nfsd_genl_rqstp *rqstp)
+{
+	struct nlattr *rq_attr, *comp_attr;
+	int i;
+
+	rq_attr = nla_nest_start(skb, index);
+	if (!rq_attr)
+		return -ENOBUFS;
+
+	if (nla_put_be32(skb, NFS_ATTR_RPC_STATUS_XID, rqstp->rq_xid) ||
+	    nla_put_u32(skb, NFS_ATTR_RPC_STATUS_FLAGS, rqstp->rq_flags) ||
+	    nla_put_string(skb, NFS_ATTR_RPC_STATUS_PC_NAME, rqstp->pc_name) ||
+	    nla_put_u8(skb, NFS_ATTR_RPC_STATUS_VERSION, rqstp->rq_vers) ||
+	    nla_put_s64(skb, NFS_ATTR_RPC_STATUS_STIME,
+			ktime_to_us(rqstp->rq_stime), NFS_ATTR_RPC_STATUS_PAD))
+		return -ENOBUFS;
+
+	switch (rqstp->saddr.sa_family) {
+	case AF_INET: {
+		const struct sockaddr_in *s_in, *d_in;
+
+		s_in = (const struct sockaddr_in *)&rqstp->saddr;
+		d_in = (const struct sockaddr_in *)&rqstp->daddr;
+		if (nla_put_in_addr(skb, NFS_ATTR_RPC_STATUS_SADDR4,
+				    s_in->sin_addr.s_addr) ||
+		    nla_put_in_addr(skb, NFS_ATTR_RPC_STATUS_DADDR4,
+				    d_in->sin_addr.s_addr) ||
+		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_SPORT,
+				 s_in->sin_port) ||
+		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_DPORT,
+				 d_in->sin_port))
+			return -ENOBUFS;
+		break;
+	}
+	case AF_INET6: {
+		const struct sockaddr_in6 *s_in, *d_in;
+
+		s_in = (const struct sockaddr_in6 *)&rqstp->saddr;
+		d_in = (const struct sockaddr_in6 *)&rqstp->daddr;
+		if (nla_put_in6_addr(skb, NFS_ATTR_RPC_STATUS_SADDR6,
+				     &s_in->sin6_addr) ||
+		    nla_put_in6_addr(skb, NFS_ATTR_RPC_STATUS_DADDR6,
+				     &d_in->sin6_addr) ||
+		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_SPORT,
+				 s_in->sin6_port) ||
+		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_DPORT,
+				 d_in->sin6_port))
+			return -ENOBUFS;
+		break;
+	}
+	default:
+		break;
+	}
+
+	comp_attr = nla_nest_start(skb, NFS_ATTR_RPC_STATUS_COMPOUND);
+	if (!comp_attr)
+		return -ENOBUFS;
+
+	for (i = 0; i < rqstp->opcnt; i++) {
+		struct nlattr *op_attr;
+
+		op_attr = nla_nest_start(skb, i);
+		if (!op_attr)
+			return -ENOBUFS;
+
+		if (nla_put_string(skb, NFS_ATTR_RPC_STATUS_COMPOUND_OP,
+				   nfsd4_op_name(rqstp->opnum[i])))
+			return -ENOBUFS;
+
+		nla_nest_end(skb, op_attr);
+	}
+
+	nla_nest_end(skb, comp_attr);
+	nla_nest_end(skb, rq_attr);
+
+	return 0;
+}
+
+static int nfsd_genl_get_rpc_status(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
+	struct nlattr *rpc_attr;
+	int i, rqstp_index = 0;
+	struct sk_buff *msg;
+	void *hdr;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, info->snd_portid, info->snd_seq, &nfsd_genl,
+			  0, NFS_CMD_NEW_RPC_STATUS);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -ENOBUFS;
+	}
+
+	rpc_attr = nla_nest_start(msg, NFS_ATTR_RPC_STATUS);
+	if (!rpc_attr)
+		goto nla_put_failure;
+
+	rcu_read_lock();
+
+	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
+		struct svc_rqst *rqstp;
+
+		list_for_each_entry_rcu(rqstp,
+				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
+				rq_all) {
+			struct nfsd_genl_rqstp genl_rqstp;
+			unsigned int status_counter;
+
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
+			genl_rqstp.pc_name = svc_proc_name(rqstp);
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
+			if (nfsd_genl_rpc_status_compose_msg(msg,
+							     rqstp_index++,
+							     &genl_rqstp))
+				goto nla_put_failure_rcu;
+		}
+	}
+
+	rcu_read_unlock();
+
+	nla_nest_end(msg, rpc_attr);
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+
+nla_put_failure_rcu:
+	rcu_read_unlock();
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	nlmsg_free(msg);
+
+	return -EMSGSIZE;
+}
+
+static int nfsd_genl_pre_doit(const struct genl_split_ops *ops,
+			      struct sk_buff *skb, struct genl_info *info)
+{
+	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
+
+	if (ops->internal_flags & NFSD_FLAG_NEED_REF_COUNT) {
+		int ret = -ENODEV;
+
+		mutex_lock(&nfsd_mutex);
+		if (nn->nfsd_serv) {
+			svc_get(nn->nfsd_serv);
+			ret = 0;
+		}
+		mutex_unlock(&nfsd_mutex);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static void nfsd_genl_post_doit(const struct genl_split_ops *ops,
+				struct sk_buff *skb, struct genl_info *info)
+{
+	if (ops->internal_flags & NFSD_FLAG_NEED_REF_COUNT) {
+		mutex_lock(&nfsd_mutex);
+		nfsd_put(genl_info_net(info));
+		mutex_unlock(&nfsd_mutex);
+	}
+}
+
+static struct genl_small_ops nfsd_genl_ops[] = {
+	{
+		.cmd = NFS_CMD_GET_RPC_STATUS,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nfsd_genl_get_rpc_status,
+		.internal_flags = NFSD_FLAG_NEED_REF_COUNT,
+	},
+};
+
+static struct genl_family nfsd_genl __ro_after_init = {
+	.name = "nfsd_server",
+	.version = 1,
+	.maxattr = NFS_ATTR_MAX,
+	.module = THIS_MODULE,
+	.netnsok = true,
+	.parallel_ops = true,
+	.hdrsize = 0,
+	.pre_doit = nfsd_genl_pre_doit,
+	.post_doit = nfsd_genl_post_doit,
+	.policy = nfsd_genl_policy,
+	.small_ops = nfsd_genl_ops,
+	.n_small_ops = ARRAY_SIZE(nfsd_genl_ops),
+	.resv_start_op = NFS_CMD_NEW_RPC_STATUS + 1,
+};
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
@@ -1589,6 +1859,10 @@ static int __init init_nfsd(void)
 	retval = register_filesystem(&nfsd_fs_type);
 	if (retval)
 		goto out_free_all;
+	retval = genl_register_family(&nfsd_genl);
+	if (retval)
+		goto out_free_all;
+
 	return 0;
 out_free_all:
 	nfsd4_destroy_laundry_wq();
@@ -1613,6 +1887,7 @@ static int __init init_nfsd(void)
 
 static void __exit exit_nfsd(void)
 {
+	genl_unregister_family(&nfsd_genl);
 	unregister_filesystem(&nfsd_fs_type);
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index e95c3322eb9b..749c871b3291 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -62,6 +62,25 @@ struct readdir_cd {
 	__be32			err;	/* 0, nfserr, or nfserr_eof */
 };
 
+enum nfsd_genl_internal_flag {
+	NFSD_FLAG_NEED_REF_COUNT = BIT(0),
+};
+
+/* Maximum number of operations per session compound */
+#define NFSD_MAX_OPS_PER_COMPOUND	50
+
+struct nfsd_genl_rqstp {
+	struct sockaddr daddr;
+	struct sockaddr saddr;
+	unsigned long rq_flags;
+	const char *pc_name;
+	ktime_t rq_stime;
+	__be32 rq_xid;
+	u32 rq_vers;
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
diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
index 946cb62d64b0..86a5daaaf9d9 100644
--- a/include/uapi/linux/nfs.h
+++ b/include/uapi/linux/nfs.h
@@ -132,4 +132,58 @@ enum nfs_ftype {
 	NFFIFO = 8
 };
 
+enum nfs_commands {
+	NFS_CMD_UNSPEC,
+
+	NFS_CMD_GET_RPC_STATUS,
+	NFS_CMD_NEW_RPC_STATUS,
+
+	/* add new commands above here */
+
+	__NFS_CMD_MAX,
+	NFS_CMD_MAX = __NFS_CMD_MAX - 1,
+};
+
+enum nfs_rcp_status_compound_attrs {
+	__NFS_ATTR_RPC_STATUS_COMPOUND_UNSPEC,
+	NFS_ATTR_RPC_STATUS_COMPOUND_OP,
+
+	/* keep it last */
+	NUM_NFS_ATTR_RPC_STATUS_COMPOUND,
+	NFS_ATTR_RPC_STATUS_COMPOUND_MAX = NUM_NFS_ATTR_RPC_STATUS_COMPOUND - 1,
+};
+
+enum nfs_rpc_status_attrs {
+	__NFS_ATTR_RPC_STATUS_UNSPEC,
+
+	NFS_ATTR_RPC_STATUS_XID,
+	NFS_ATTR_RPC_STATUS_FLAGS,
+	NFS_ATTR_RPC_STATUS_PC_NAME,
+	NFS_ATTR_RPC_STATUS_VERSION,
+	NFS_ATTR_RPC_STATUS_STIME,
+	NFS_ATTR_RPC_STATUS_SADDR4,
+	NFS_ATTR_RPC_STATUS_DADDR4,
+	NFS_ATTR_RPC_STATUS_SADDR6,
+	NFS_ATTR_RPC_STATUS_DADDR6,
+	NFS_ATTR_RPC_STATUS_SPORT,
+	NFS_ATTR_RPC_STATUS_DPORT,
+	NFS_ATTR_RPC_STATUS_PAD,
+	NFS_ATTR_RPC_STATUS_COMPOUND,
+
+	/* keep it last */
+	NUM_NFS_ATTR_RPC_STATUS,
+	NFS_ATTR_RPC_STATUS_MAX = NUM_NFS_ATTR_RPC_STATUS - 1,
+};
+
+enum nfs_attrs {
+	NFS_ATTR_UNSPEC,
+
+	NFS_ATTR_RPC_STATUS,
+
+	/* add new attributes above here */
+
+	__NFS_ATTR_MAX,
+	NFS_ATTR_MAX = __NFS_ATTR_MAX - 1
+};
+
 #endif /* _UAPI_LINUX_NFS_H */
-- 
2.41.0

