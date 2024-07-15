Return-Path: <linux-nfs+bounces-4905-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A86CA930F23
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A6F281370
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342D6AB8;
	Mon, 15 Jul 2024 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZGbxhIwh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iJXCk/Mj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZGbxhIwh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iJXCk/Mj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E657175A6
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029762; cv=none; b=e8ZD10hUFRf1cgqQdVBnB9toIIusJQoDgquYiG78EhHAWDCTnCNgTsUuhx80lvgPGQhG7hp0WNS2wWc5oOcXqgmy3OfRC6ZUsUnxGtNknBhQLouNTGtjkerXweJBK/wtnU8kUzny/pyer3DwyRbA8jn3IGxDMvZvhpbsl/s7wQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029762; c=relaxed/simple;
	bh=vscPcf6UYREKHryS/pLl53183fRoe1ba0l8MhyHCm1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/0+4lv2sxX1rA1vXzjVeoH6bU8TuIFd/KlfAmUmQgdhDYdpjqwD/H8Y6n2a5mvtuKb8iofAo6jkX79mKJU2C/rGqaHguVC/IcvLvHJfTyjEHtO073QNtvuvhA2pR9ebaV0gFb3NRXlGfr+h+fivtGPNQ4PhBW8G31REuBgCtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZGbxhIwh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iJXCk/Mj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZGbxhIwh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iJXCk/Mj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3E9821A03;
	Mon, 15 Jul 2024 07:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06DghijWnCCc3GMBDVkth3Kjwzk52ff3/Ea7+Rb/gzA=;
	b=ZGbxhIwh4Tg0Ua3LbD4vl1PVEAcaHlNtgd992yiGQTz4sROe0du7/3eBIiqSm3GTr62aBy
	biObp3MPtBmtOl8mU4MW264a79M8BeIjzJWGzO4lWzIEh1fdROzPlI+7ilq0bIAcW3gciL
	xiBjjCZgrWsX2Rj0x0scGU038PoK96Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06DghijWnCCc3GMBDVkth3Kjwzk52ff3/Ea7+Rb/gzA=;
	b=iJXCk/MjzshBRmHOiogui0WdpvfjWRpKUaXn+JGS4o7hbfhFy3QpCp3bAiQU8I/RWb0p4j
	shfWwvaoT+tZDjBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06DghijWnCCc3GMBDVkth3Kjwzk52ff3/Ea7+Rb/gzA=;
	b=ZGbxhIwh4Tg0Ua3LbD4vl1PVEAcaHlNtgd992yiGQTz4sROe0du7/3eBIiqSm3GTr62aBy
	biObp3MPtBmtOl8mU4MW264a79M8BeIjzJWGzO4lWzIEh1fdROzPlI+7ilq0bIAcW3gciL
	xiBjjCZgrWsX2Rj0x0scGU038PoK96Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06DghijWnCCc3GMBDVkth3Kjwzk52ff3/Ea7+Rb/gzA=;
	b=iJXCk/MjzshBRmHOiogui0WdpvfjWRpKUaXn+JGS4o7hbfhFy3QpCp3bAiQU8I/RWb0p4j
	shfWwvaoT+tZDjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 661A0137EB;
	Mon, 15 Jul 2024 07:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5apjB3zUlGZXbgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:49:16 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 13/14] nfsd: introduce concept of a maximum number of threads.
Date: Mon, 15 Jul 2024 17:14:26 +1000
Message-ID: <20240715074657.18174-14-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240715074657.18174-1-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

A future patch will allow the number of threads in each nfsd pool to
vary dynamically.
The lower bound will be the number explicit requested via
/proc/fs/nfsd/threads or /proc/fs/nfsd/pool_threads

The upper bound can be set in each net-namespace by writing
/proc/fs/nfsd/max_threads.  This upper bound applies across all pools,
there is no per-pool upper limit.

If no upper bound is set, then one is calculated.  A global upper limit
is chosen based on amount of memory.  This limit only affects dynamic
changes. Static configuration can always over-ride it.

We track how many threads are configured in each net namespace, with the
max or the min.  We also track how many net namespaces have nfsd
configured with only a min, not a max.

The difference between the calculated max and the total allocation is
available to be shared among those namespaces which don't have a maximum
configured.  Within a namespace, the available share is distributed
equally across all pools.

In the common case there is one namespace and one pool.  A small number
of threads are configured as a minimum and no maximum is set.  In this
case the effective maximum will be directly based on total memory.
Approximately 8 per gigabyte.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/netns.h  |  6 +++++
 fs/nfsd/nfsctl.c | 45 +++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h   |  4 ++++
 fs/nfsd/nfssvc.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/trace.h  | 19 +++++++++++++++
 5 files changed, 135 insertions(+)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 0d2ac15a5003..329484696a42 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -133,6 +133,12 @@ struct nfsd_net {
 	 */
 	unsigned int max_connections;
 
+	/*
+	 * Maximum number of threads to auto-adjust up to.  If 0 then a
+	 * share of nfsd_max_threads will be used.
+	 */
+	unsigned int max_threads;
+
 	u32 clientid_base;
 	u32 clientid_counter;
 	u32 clverifier_counter;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d85b6d1fa31f..37e9936567e9 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -48,6 +48,7 @@ enum {
 	NFSD_Ports,
 	NFSD_MaxBlkSize,
 	NFSD_MaxConnections,
+	NFSD_MaxThreads,
 	NFSD_Filecache,
 	NFSD_Leasetime,
 	NFSD_Gracetime,
@@ -68,6 +69,7 @@ static ssize_t write_versions(struct file *file, char *buf, size_t size);
 static ssize_t write_ports(struct file *file, char *buf, size_t size);
 static ssize_t write_maxblksize(struct file *file, char *buf, size_t size);
 static ssize_t write_maxconn(struct file *file, char *buf, size_t size);
+static ssize_t write_maxthreads(struct file *file, char *buf, size_t size);
 #ifdef CONFIG_NFSD_V4
 static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
 static ssize_t write_gracetime(struct file *file, char *buf, size_t size);
@@ -87,6 +89,7 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 	[NFSD_Ports] = write_ports,
 	[NFSD_MaxBlkSize] = write_maxblksize,
 	[NFSD_MaxConnections] = write_maxconn,
+	[NFSD_MaxThreads] = write_maxthreads,
 #ifdef CONFIG_NFSD_V4
 	[NFSD_Leasetime] = write_leasetime,
 	[NFSD_Gracetime] = write_gracetime,
@@ -939,6 +942,47 @@ static ssize_t write_maxconn(struct file *file, char *buf, size_t size)
 	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", maxconn);
 }
 
+/*
+ * write_maxthreads - Set or report the current max number threads
+ *
+ * Input:
+ *			buf:		ignored
+ *			size:		zero
+ * OR
+ *
+ * Input:
+ *			buf:		C string containing an unsigned
+ *					integer value representing the new
+ *					max number of threads
+ *			size:		non-zero length of C string in @buf
+ * Output:
+ *	On success:	passed-in buffer filled with '\n'-terminated C string
+ *			containing numeric value of max_threads setting
+ *			for this net namespace;
+ *			return code is the size in bytes of the string
+ *	On error:	return code is zero or a negative errno value
+ */
+static ssize_t write_maxthreads(struct file *file, char *buf, size_t size)
+{
+	char *mesg = buf;
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
+	unsigned int maxthreads = nn->max_threads;
+
+	if (size > 0) {
+		int rv = get_uint(&mesg, &maxthreads);
+
+		if (rv)
+			return rv;
+		trace_nfsd_ctl_maxthreads(netns(file), maxthreads);
+		mutex_lock(&nfsd_mutex);
+		nn->max_threads = maxthreads;
+		nfsd_update_nets();
+		mutex_unlock(&nfsd_mutex);
+	}
+
+	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", maxthreads);
+}
+
 #ifdef CONFIG_NFSD_V4
 static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
 				  time64_t *time, struct nfsd_net *nn)
@@ -1372,6 +1416,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MaxConnections] = {"max_connections", &transaction_ops, S_IWUSR|S_IRUGO},
+		[NFSD_MaxThreads] = {"max_threads", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO},
 #ifdef CONFIG_NFSD_V4
 		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index e4c643255dc9..6874c2de670b 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -156,6 +156,10 @@ int nfsd_create_serv(struct net *net);
 void nfsd_destroy_serv(struct net *net);
 
 extern int nfsd_max_blksize;
+void nfsd_update_nets(void);
+extern unsigned int	nfsd_max_threads;
+extern unsigned long	nfsd_net_used;
+extern unsigned int	nfsd_net_cnt;
 
 static inline int nfsd_v4client(struct svc_rqst *rq)
 {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b005b2e2e6ad..75d78c17756f 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -80,6 +80,21 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
 unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_slotsize_sum;
 
+/*
+ * nfsd_max_threads is auto-configured based on available ram.
+ * Each network namespace can configure a minimum number of threads
+ * and optionally a maximum.
+ * nfsd_net_used is the number of the max or min from each net namespace.
+ * nfsd_new_cnt is the number of net namespaces with a configured minimum
+ *    but no configured maximum.
+ * When nfsd_max_threads exceeds nfsd_net_used, the different is divided
+ * by nfsd_net_cnt and this number gives the excess above the configured minimum
+ * for all net namespaces without a configured maximum.
+ */
+unsigned int	nfsd_max_threads;
+unsigned long	nfsd_net_used;
+unsigned int	nfsd_net_cnt;
+
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static const struct svc_version *nfsd_acl_version[] = {
 # if defined(CONFIG_NFSD_V2_ACL)
@@ -130,6 +145,47 @@ struct svc_program		nfsd_program = {
 	.pg_rpcbind_set		= nfsd_rpcbind_set,
 };
 
+void nfsd_update_nets(void)
+{
+	struct net *net;
+
+	if (nfsd_max_threads == 0) {
+		nfsd_max_threads = (nr_free_buffer_pages() >> 7) /
+			(NFSSVC_MAXBLKSIZE >> PAGE_SHIFT);
+	}
+	nfsd_net_used = 0;
+	nfsd_net_cnt = 0;
+	down_read(&net_rwsem);
+	for_each_net(net) {
+		struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+		if (!nn->nfsd_serv)
+			continue;
+		if (nn->max_threads > 0) {
+			nfsd_net_used += nn->max_threads;
+		} else {
+			nfsd_net_used += nn->nfsd_serv->sv_nrthreads;
+			nfsd_net_cnt += 1;
+		}
+	}
+	up_read(&net_rwsem);
+}
+
+static inline int nfsd_max_pool_threads(struct svc_pool *p, struct nfsd_net *nn)
+{
+	int svthreads = nn->nfsd_serv->sv_nrthreads;
+
+	if (nn->max_threads > 0)
+		return nn->max_threads;
+	if (nfsd_net_cnt == 0 || svthreads == 0)
+		return 0;
+	if (nfsd_max_threads < nfsd_net_cnt)
+		return p->sp_nrthreads;
+	/* Share nfsd_max_threads among all net, then among pools in this net. */
+	return p->sp_nrthreads +
+		nfsd_max_threads / nfsd_net_cnt * p->sp_nrthreads / svthreads;
+}
+
 bool nfsd_support_version(int vers)
 {
 	if (vers >= NFSD_MINVERS && vers <= NFSD_MAXVERS)
@@ -474,6 +530,7 @@ void nfsd_destroy_serv(struct net *net)
 	spin_lock(&nfsd_notifier_lock);
 	nn->nfsd_serv = NULL;
 	spin_unlock(&nfsd_notifier_lock);
+	nfsd_update_nets();
 
 	/* check if the notifier still has clients */
 	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
@@ -614,6 +671,8 @@ int nfsd_create_serv(struct net *net)
 	nn->nfsd_serv = serv;
 	spin_unlock(&nfsd_notifier_lock);
 
+	nfsd_update_nets();
+
 	set_max_drc();
 	/* check if the notifier is already set */
 	if (atomic_inc_return(&nfsd_notifier_refcount) == 1) {
@@ -720,6 +779,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 			goto out;
 	}
 out:
+	nfsd_update_nets();
 	return err;
 }
 
@@ -759,6 +819,7 @@ nfsd_svc(int n, int *nthreads, struct net *net, const struct cred *cred, const c
 	error = nfsd_set_nrthreads(n, nthreads, net);
 	if (error)
 		goto out_put;
+	nfsd_update_nets();
 	error = serv->sv_nrthreads;
 out_put:
 	if (serv->sv_nrthreads == 0)
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 77bbd23aa150..92b888e178e8 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2054,6 +2054,25 @@ TRACE_EVENT(nfsd_ctl_maxconn,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_maxthreads,
+	TP_PROTO(
+		const struct net *net,
+		int maxthreads
+	),
+	TP_ARGS(net, maxthreads),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(int, maxthreads)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->maxthreads = maxthreads
+	),
+	TP_printk("maxthreads=%d",
+		__entry->maxthreads
+	)
+);
+
 TRACE_EVENT(nfsd_ctl_time,
 	TP_PROTO(
 		const struct net *net,
-- 
2.44.0


