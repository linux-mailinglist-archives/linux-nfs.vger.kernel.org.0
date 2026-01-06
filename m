Return-Path: <linux-nfs+bounces-17515-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8DCCFA6FE
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 20:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9C8A3000972
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C5C339871;
	Tue,  6 Jan 2026 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Crcwgd+Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0FE33ADB1;
	Tue,  6 Jan 2026 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726016; cv=none; b=tBpcKCnZ9cVoU2jwIQRWIgfs9C6jcPzTr3j8bV91JUPjB/32zbbXOqNdpkHqoqFiTYraWt/20p7ecLjnTZJjieaz6vAJHJqB5PrOiqat8CRdrmv+b9f24uDv1o8WncZ7WYRUMJu4mUaMMpxRvdlbl+t2BRqi8Qnt0tZAmZUjYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726016; c=relaxed/simple;
	bh=cwF1fGndiwjwRCaQ0aE8P82ovlvsdNXA84sZ9+RFO4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gw1fM44qCT6cKboBD/HgHQZeGsGFRZxr1dsHN9kLT1RCAjokfaOJHhIkYA6Hfea3+F9i9bhV46np/GwmRblxy0x/S6KQc0wjSoQEH+iSYzz0iyjfHpGvmqYzuyL/jEhUBh7dST5x8YHvy0pxP92Jav+a/96mm6YZaJ5uWmj2rls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Crcwgd+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F06C19425;
	Tue,  6 Jan 2026 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767726015;
	bh=cwF1fGndiwjwRCaQ0aE8P82ovlvsdNXA84sZ9+RFO4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Crcwgd+QCKfQcNeopNzf7DMo7Yi6L2kC+zcRczJfhMAbN+xMoaJrfKEZ2lgqXnGew
	 waHclPqICLREKSbT5DKjD/wcBxgdV7amnW5bgpNeOqMOiT3+Ls6ImBayioZ+q1acZ9
	 9cWijpDkHrIkPZ119hl9RIVnR6Lxl9oTt9/w8YAuExYxLsDWLMtkc3GdKg/rnGimR1
	 9xCTOVN+WqTrVAbZLGzQY878me7gYoqCEbUG9wZaTvzqBPyM1N2qAPV2DMFXurn6f9
	 3u9JdhTY07BMPNxeDQ/f9VyK1Wj9tK2AlrtPBIfP3ahjYoLVfEq9GND1XkTHqYYLhh
	 cTViiBw2Wwyjw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 06 Jan 2026 13:59:50 -0500
Subject: [PATCH v2 8/8] nfsd: add controls to set the minimum number of
 threads per pool
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-nfsd-dynathread-v2-8-416e5f27b2b6@kernel.org>
References: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
In-Reply-To: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9398; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cwF1fGndiwjwRCaQ0aE8P82ovlvsdNXA84sZ9+RFO4k=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXVu0vnATGpJKGCeDPi64r+UndeAS4G/gyNdxf
 /AdzNk6uSSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV1btAAKCRAADmhBGVaC
 FVWnEADGYrNTvKo8kU4rKNdSMr/yqqKeaPr7HP1cALLEaHbHrGoecoUCF2FKJSEkF4dF9Y2qubq
 zn7+FIzCit3fMIGlXfCwJ1Tl7YKXgGkNlufrGPFhzsIdpU2gL/7J+Rzm5maX9onIk5H5PywcOrd
 w9RfixU+lRKYf8kt7kYHJEecgE8MvLN7sIXkEXq5AwIiivLPuf89xysb8Sqjl2WZjuiG2z/o7vo
 nIC5cgSHypebjZI0IuGlO9XqkipNOfUrp7oW/vpGgucFUEZuFy9y70GZL000J976U13N9WUCl8n
 o6E7NjbxMvIYCxE4xI/7eVTJegj72hbSE605lg8u1PIb0/EbYiq5Le9IBVXzPbH7ccR81Jasu0E
 4TQKNNF63d4d0QEoSxPYOnRlTjF9s9h+1ohaccBO2V2EEn174U4hlfSfxtHrcqndEpaXiS9PnNG
 B4D4C7BPMNvSGMS2YhiaOG5HzbvfDAH901TojoEhPELChI6sJdBH4xc3EcPKyPkEB850P+HH5Ws
 lvAC3jEMYeBTIJQ5iWZTTlF6wHbQjh97FnjB7/ufeS53UExKLfvuHIm5SIMPJs1novg163x1xrn
 FI5BzYo8abZ3dezqJ8BxMgrYZozqfAc8DGz4g/9n2tZgeZ8aUxHSPQxIMl3uixXoutD81OTaC7e
 NrSNBYzhSeY/naQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new "min_threads" variable to the nfsd_net, along with the
corresponding nfsdfs and netlink interfaces to set that value from
userland. Pass that value to svc_set_pool_threads() and
svc_set_num_threads().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  5 ++++
 fs/nfsd/netlink.c                     |  5 ++--
 fs/nfsd/netns.h                       |  6 +++++
 fs/nfsd/nfsctl.c                      | 50 +++++++++++++++++++++++++++++++++++
 fs/nfsd/nfssvc.c                      |  4 +--
 fs/nfsd/trace.h                       | 19 +++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 7 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 100363029e82aed87295e34a008ab771a95d508c..badb2fe57c9859c6932c621a589da694782b0272 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -78,6 +78,9 @@ attribute-sets:
       -
         name: scope
         type: string
+      -
+        name: min-threads
+        type: u32
   -
     name: version
     attributes:
@@ -159,6 +162,7 @@ operations:
             - gracetime
             - leasetime
             - scope
+            - min-threads
     -
       name: threads-get
       doc: get the number of running threads
@@ -170,6 +174,7 @@ operations:
             - gracetime
             - leasetime
             - scope
+            - min-threads
     -
       name: version-set
       doc: set nfs enabled versions
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index ac51a44e1065ec3f1d88165f70a831a828b58394..887525964451e640304371e33aa4f415b4ff2848 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -24,11 +24,12 @@ const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
 };
 
 /* NFSD_CMD_THREADS_SET - do */
-static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_SCOPE + 1] = {
+static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] = {
 	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
+	[NFSD_A_SERVER_MIN_THREADS] = { .type = NLA_U32, },
 };
 
 /* NFSD_CMD_VERSION_SET - do */
@@ -57,7 +58,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.cmd		= NFSD_CMD_THREADS_SET,
 		.doit		= nfsd_nl_threads_set_doit,
 		.policy		= nfsd_threads_set_nl_policy,
-		.maxattr	= NFSD_A_SERVER_SCOPE,
+		.maxattr	= NFSD_A_SERVER_MIN_THREADS,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index fe8338735e7cc599a2b6aebbea3ec3e71b07f636..5bde7975c343798639fec54e7daa80fc9ce060d9 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -130,6 +130,12 @@ struct nfsd_net {
 	seqlock_t writeverf_lock;
 	unsigned char writeverf[8];
 
+	/*
+	 * Minimum number of threads to run per pool.  If 0 then the
+	 * min == max requested number of threads.
+	 */
+	unsigned int min_threads;
+
 	u32 clientid_base;
 	u32 clientid_counter;
 	u32 clverifier_counter;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 084fc517e9e160b56cba0c40ac0daa749be3ffcd..035f08a31607b631ebfe2beda2c5e30781daaa26 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -48,6 +48,7 @@ enum {
 	NFSD_Versions,
 	NFSD_Ports,
 	NFSD_MaxBlkSize,
+	NFSD_MinThreads,
 	NFSD_Filecache,
 	NFSD_Leasetime,
 	NFSD_Gracetime,
@@ -67,6 +68,7 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size);
 static ssize_t write_versions(struct file *file, char *buf, size_t size);
 static ssize_t write_ports(struct file *file, char *buf, size_t size);
 static ssize_t write_maxblksize(struct file *file, char *buf, size_t size);
+static ssize_t write_minthreads(struct file *file, char *buf, size_t size);
 #ifdef CONFIG_NFSD_V4
 static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
 static ssize_t write_gracetime(struct file *file, char *buf, size_t size);
@@ -85,6 +87,7 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 	[NFSD_Versions] = write_versions,
 	[NFSD_Ports] = write_ports,
 	[NFSD_MaxBlkSize] = write_maxblksize,
+	[NFSD_MinThreads] = write_minthreads,
 #ifdef CONFIG_NFSD_V4
 	[NFSD_Leasetime] = write_leasetime,
 	[NFSD_Gracetime] = write_gracetime,
@@ -906,6 +909,46 @@ static ssize_t write_maxblksize(struct file *file, char *buf, size_t size)
 							nfsd_max_blksize);
 }
 
+/*
+ * write_minthreads - Set or report the current min number of threads per pool
+ *
+ * Input:
+ *			buf:		ignored
+ *			size:		zero
+ * OR
+ *
+ * Input:
+ *			buf:		C string containing an unsigned
+ *					integer value representing the new
+ *					min number of threads per pool
+ *			size:		non-zero length of C string in @buf
+ * Output:
+ *	On success:	passed-in buffer filled with '\n'-terminated C string
+ *			containing numeric value of min_threads setting
+ *			for this net namespace;
+ *			return code is the size in bytes of the string
+ *	On error:	return code is zero or a negative errno value
+ */
+static ssize_t write_minthreads(struct file *file, char *buf, size_t size)
+{
+	char *mesg = buf;
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
+	unsigned int minthreads = nn->min_threads;
+
+	if (size > 0) {
+		int rv = get_uint(&mesg, &minthreads);
+
+		if (rv)
+			return rv;
+		trace_nfsd_ctl_minthreads(netns(file), minthreads);
+		mutex_lock(&nfsd_mutex);
+		nn->min_threads = minthreads;
+		mutex_unlock(&nfsd_mutex);
+	}
+
+	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
+}
+
 #ifdef CONFIG_NFSD_V4
 static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
 				  time64_t *time, struct nfsd_net *nn)
@@ -1298,6 +1341,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 		[NFSD_Versions] = {"versions", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, S_IWUSR|S_IRUGO},
+		[NFSD_MinThreads] = {"min_threads", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO},
 #ifdef CONFIG_NFSD_V4
 		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
@@ -1642,6 +1686,10 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 			scope = nla_data(attr);
 	}
 
+	attr = info->attrs[NFSD_A_SERVER_MIN_THREADS];
+	if (attr)
+		nn->min_threads = nla_get_u32(attr);
+
 	ret = nfsd_svc(nrpools, nthreads, net, get_current_cred(), scope);
 	if (ret > 0)
 		ret = 0;
@@ -1681,6 +1729,8 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 			  nn->nfsd4_grace) ||
 	      nla_put_u32(skb, NFSD_A_SERVER_LEASETIME,
 			  nn->nfsd4_lease) ||
+	      nla_put_u32(skb, NFSD_A_SERVER_MIN_THREADS,
+			  nn->min_threads) ||
 	      nla_put_string(skb, NFSD_A_SERVER_SCOPE,
 			  nn->nfsd_name);
 	if (err)
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 55a4caaea97633670ffea1144ce4ac810b82c2ab..6bf3044934a0ab077a1af791860e7fa0faff71f1 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -690,7 +690,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 
 	/* Special case: When n == 1, distribute threads equally among pools. */
 	if (n == 1)
-		return svc_set_num_threads(nn->nfsd_serv, 0, nthreads[0]);
+		return svc_set_num_threads(nn->nfsd_serv, nn->min_threads, nthreads[0]);
 
 	if (n > nn->nfsd_serv->sv_nrpools)
 		n = nn->nfsd_serv->sv_nrpools;
@@ -718,7 +718,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	for (i = 0; i < n; i++) {
 		err = svc_set_pool_threads(nn->nfsd_serv,
 					   &nn->nfsd_serv->sv_pools[i],
-					   0, nthreads[i]);
+					   nn->min_threads, nthreads[i]);
 		if (err)
 			goto out;
 	}
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 8885fd9bead98ebf55379d68ab9c3701981a5150..d1d0b0dd054588a8c20e3386356dfa4e9632b8e0 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2164,6 +2164,25 @@ TRACE_EVENT(nfsd_ctl_maxblksize,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_minthreads,
+	TP_PROTO(
+		const struct net *net,
+		int minthreads
+	),
+	TP_ARGS(net, minthreads),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(int, minthreads)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->minthreads = minthreads
+	),
+	TP_printk("minthreads=%d",
+		__entry->minthreads
+	)
+);
+
 TRACE_EVENT(nfsd_ctl_time,
 	TP_PROTO(
 		const struct net *net,
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index e157e2009ea8c1ef805301261d536c82677821ef..e9efbc9e63d83ed25fcd790b7a877c0023638f15 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -35,6 +35,7 @@ enum {
 	NFSD_A_SERVER_GRACETIME,
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
+	NFSD_A_SERVER_MIN_THREADS,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)

-- 
2.52.0


