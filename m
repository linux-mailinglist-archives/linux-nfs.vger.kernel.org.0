Return-Path: <linux-nfs+bounces-12570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B581DADF8CE
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 23:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7213188E3EC
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 21:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6201F1311;
	Wed, 18 Jun 2025 21:34:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C9B21ADA3
	for <linux-nfs@vger.kernel.org>; Wed, 18 Jun 2025 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282451; cv=none; b=l8VJW0oQQan95wrqJFjUmyxDtH/aQ1oRuX/snfAR86mfNgtmWGPB4mlJq54D35dBj1nmfPkT8tCGrC0MIDwAH8bsEmCy4TOYCZl8U0WO8oLtCYX0Jdztlh7ot0tGYadeMzVJPZ8FCPa8J/9kr9v4BJ+VXl7E3wGT0xaXr+1J8z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282451; c=relaxed/simple;
	bh=rWxAIgGe5t7pSGTscNM53New/9S/NRSdobKqt6529T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLuCrdOKNJRsUkIrPY4kD3R+dGWLpBYRvqLfb8ops7OKDaBwaK1BYKLPsA6Y4KOBjn/cPy7OUhVyk0SUQ6hMjvp+mRncfpKIe+D+/ZnUBIFc458wGco9VZvnd60z9F5HJBZipMBEhzjWkIgucGTZJYKvNge2SY2+KmifQ1HFZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uS0Pu-000Yqu-9x;
	Wed, 18 Jun 2025 21:33:58 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 3/3] nfsd: split nfsd_mutex into one mutex per net-namespace.
Date: Thu, 19 Jun 2025 07:31:53 +1000
Message-ID: <20250618213347.425503-4-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618213347.425503-1-neil@brown.name>
References: <20250618213347.425503-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remaining uses for nfsd_mutex are all to protect per-netns
resources.

This patch replaces the global mutex with one per netns.  The "svc_info"
struct now contains that mutex rather than a pointer to the mutex.

Macros are provided to make it easy to take the mutex given a file or net.

Signed-off-by: NeilBrown <neil@brown.name>
---
 .../admin-guide/nfs/nfsd-admin-interfaces.rst |   2 +-
 fs/nfsd/nfsctl.c                              | 113 +++++++++---------
 fs/nfsd/nfsd.h                                |   1 -
 fs/nfsd/nfssvc.c                              |  33 ++---
 include/linux/sunrpc/svc.h                    |   2 +-
 net/sunrpc/svc_xprt.c                         |   4 +-
 6 files changed, 72 insertions(+), 83 deletions(-)

diff --git a/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst b/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
index c05926f79054..9548e4ab35b6 100644
--- a/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
+++ b/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
@@ -37,4 +37,4 @@ Implementation notes
 
 Note that the rpc server requires the caller to serialize addition and
 removal of listening sockets, and startup and shutdown of the server.
-For nfsd this is done using nfsd_mutex.
+For nfsd this is done using nfsd_info.mutex in struct nfsd_net.
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3710a1992d17..70eddf2640f0 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -95,6 +95,13 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 #endif
 };
 
+#define	with_nfsd_net_locked(__net)					\
+	for (struct nfsd_net *__nn = net_generic(__net, nfsd_net_id);	\
+	     __nn ? ({mutex_lock(&__nn->nfsd_info.mutex); 1; }) : 0;	\
+	     ({mutex_unlock(&__nn->nfsd_info.mutex); __nn = NULL;}))
+#define with_nfsd_file_locked(__file)					\
+	with_nfsd_net_locked(netns(__file))
+
 static ssize_t nfsctl_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
 {
 	ino_t ino =  file_inode(file)->i_ino;
@@ -249,9 +256,8 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
 {
 	ssize_t rv;
 
-	mutex_lock(&nfsd_mutex);
-	rv = __write_unlock_ip(file, buf, size);
-	mutex_unlock(&nfsd_mutex);
+	with_nfsd_file_locked(file)
+		rv = __write_unlock_ip(file, buf, size);
 	return rv;
 }
 
@@ -315,9 +321,8 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 {
 	ssize_t rv;
 
-	mutex_lock(&nfsd_mutex);
-	rv = __write_unlock_fs(file, buf, size);
-	mutex_unlock(&nfsd_mutex);
+	with_nfsd_file_locked(file)
+		rv = __write_unlock_fs(file, buf, size);
 	return rv;
 }
 
@@ -440,9 +445,8 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
 		if (newthreads < 0)
 			return -EINVAL;
 		trace_nfsd_ctl_threads(net, newthreads);
-		mutex_lock(&nfsd_mutex);
-		rv = nfsd_svc(1, &newthreads, net, file->f_cred, NULL);
-		mutex_unlock(&nfsd_mutex);
+		with_nfsd_net_locked(net)
+			rv = nfsd_svc(1, &newthreads, net, file->f_cred, NULL);
 		if (rv < 0)
 			return rv;
 	} else
@@ -473,7 +477,7 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
  *			return code is the size in bytes of the string
  *	On error:	return code is zero or a negative errno value
  */
-static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
+static ssize_t __write_pool_threads(struct file *file, char *buf, size_t size)
 {
 	/* if size > 0, look for an array of number of threads per node
 	 * and apply them  then write out number of threads per node as reply
@@ -486,7 +490,6 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 	int *nthreads;
 	struct net *net = netns(file);
 
-	mutex_lock(&nfsd_mutex);
 	npools = nfsd_nrpools(net);
 	if (npools == 0) {
 		/*
@@ -494,7 +497,6 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 		 * writing to the threads file but NOT the pool_threads
 		 * file, sorry.  Report zero threads.
 		 */
-		mutex_unlock(&nfsd_mutex);
 		strcpy(buf, "0\n");
 		return strlen(buf);
 	}
@@ -544,10 +546,18 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 	rv = mesg - buf;
 out_free:
 	kfree(nthreads);
-	mutex_unlock(&nfsd_mutex);
 	return rv;
 }
 
+static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
+{
+	ssize_t ret;
+
+	with_nfsd_file_locked(file)
+		ret = __write_pool_threads(file, buf, size);
+	return ret;
+}
+
 static ssize_t
 nfsd_print_version_support(struct nfsd_net *nn, char *buf, int remaining,
 		const char *sep, unsigned vers, int minor)
@@ -709,9 +719,9 @@ static ssize_t write_versions(struct file *file, char *buf, size_t size)
 {
 	ssize_t rv;
 
-	mutex_lock(&nfsd_mutex);
-	rv = __write_versions(file, buf, size);
-	mutex_unlock(&nfsd_mutex);
+	with_nfsd_file_locked(file)
+		rv = __write_versions(file, buf, size);
+
 	return rv;
 }
 
@@ -868,9 +878,8 @@ static ssize_t write_ports(struct file *file, char *buf, size_t size)
 {
 	ssize_t rv;
 
-	mutex_lock(&nfsd_mutex);
-	rv = __write_ports(file, buf, size, netns(file));
-	mutex_unlock(&nfsd_mutex);
+	with_nfsd_file_locked(file)
+		rv = __write_ports(file, buf, size, netns(file));
 	return rv;
 }
 
@@ -916,13 +925,13 @@ static ssize_t write_maxblksize(struct file *file, char *buf, size_t size)
 		bsize = max_t(int, bsize, 1024);
 		bsize = min_t(int, bsize, NFSSVC_MAXBLKSIZE);
 		bsize &= ~(1024-1);
-		mutex_lock(&nfsd_mutex);
+		mutex_lock(&nn->nfsd_info.mutex);
 		if (nn->nfsd_serv) {
-			mutex_unlock(&nfsd_mutex);
+			mutex_unlock(&nn->nfsd_info.mutex);
 			return -EBUSY;
 		}
 		nfsd_max_blksize = bsize;
-		mutex_unlock(&nfsd_mutex);
+		mutex_unlock(&nn->nfsd_info.mutex);
 	}
 
 	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%d\n",
@@ -971,9 +980,8 @@ static ssize_t nfsd4_write_time(struct file *file, char *buf, size_t size,
 {
 	ssize_t rv;
 
-	mutex_lock(&nfsd_mutex);
-	rv = __nfsd4_write_time(file, buf, size, time, nn);
-	mutex_unlock(&nfsd_mutex);
+	with_nfsd_file_locked(file)
+		rv = __nfsd4_write_time(file, buf, size, time, nn);
 	return rv;
 }
 
@@ -1076,9 +1084,8 @@ static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
 	ssize_t rv;
 	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 
-	mutex_lock(&nfsd_mutex);
-	rv = __write_recoverydir(file, buf, size, nn);
-	mutex_unlock(&nfsd_mutex);
+	with_nfsd_file_locked(file)
+		rv = __write_recoverydir(file, buf, size, nn);
 	return rv;
 }
 #endif
@@ -1130,9 +1137,8 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 {
 	ssize_t rv;
 
-	mutex_lock(&nfsd_mutex);
-	rv = __write_v4_end_grace(file, buf, size);
-	mutex_unlock(&nfsd_mutex);
+	with_nfsd_file_locked(file)
+		rv = __write_v4_end_grace(file, buf, size);
 	return rv;
 }
 #endif
@@ -1552,9 +1558,8 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 	int i, ret, rqstp_index = 0;
 	struct nfsd_net *nn;
 
-	mutex_lock(&nfsd_mutex);
-
 	nn = net_generic(sock_net(skb->sk), nfsd_net_id);
+	mutex_lock(&nn->nfsd_info.mutex);
 	if (!nn->nfsd_serv) {
 		ret = -ENODEV;
 		goto out_unlock;
@@ -1636,7 +1641,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 out:
 	rcu_read_unlock();
 out_unlock:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 
 	return ret;
 }
@@ -1665,7 +1670,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 			count++;
 	}
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->nfsd_info.mutex);
 
 	nrpools = max(count, nfsd_nrpools(net));
 	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
@@ -1720,7 +1725,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret > 0)
 		ret = 0;
 out_unlock:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 	kfree(nthreads);
 	return ret;
 }
@@ -1749,7 +1754,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_msg;
 	}
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->nfsd_info.mutex);
 
 	err = nla_put_u32(skb, NFSD_A_SERVER_GRACETIME,
 			  nn->nfsd4_grace) ||
@@ -1777,14 +1782,14 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 			goto err_unlock;
 	}
 
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 
 	genlmsg_end(skb, hdr);
 
 	return genlmsg_reply(skb, info);
 
 err_unlock:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 err_free_msg:
 	nlmsg_free(skb);
 
@@ -1807,11 +1812,10 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_PROTO_VERSION))
 		return -EINVAL;
 
-	mutex_lock(&nfsd_mutex);
-
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
+	mutex_lock(&nn->nfsd_info.mutex);
 	if (nn->nfsd_serv) {
-		mutex_unlock(&nfsd_mutex);
+		mutex_unlock(&nn->nfsd_info.mutex);
 		return -EBUSY;
 	}
 
@@ -1856,7 +1860,7 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 
 	return 0;
 }
@@ -1884,7 +1888,7 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_msg;
 	}
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->nfsd_info.mutex);
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
 
 	for (i = 2; i <= 4; i++) {
@@ -1928,13 +1932,13 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 	genlmsg_end(skb, hdr);
 
 	return genlmsg_reply(skb, info);
 
 err_nfsd_unlock:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 err_free_msg:
 	nlmsg_free(skb);
 
@@ -1959,15 +1963,16 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	bool delete = false;
 	int err, rem;
 
-	mutex_lock(&nfsd_mutex);
+	nn = net_generic(net, nfsd_net_id);
+
+	mutex_lock(&nn->nfsd_info.mutex);
 
 	err = nfsd_create_serv(net);
 	if (err) {
-		mutex_unlock(&nfsd_mutex);
+		mutex_unlock(&nn->nfsd_info.mutex);
 		return err;
 	}
 
-	nn = net_generic(net, nfsd_net_id);
 	serv = nn->nfsd_serv;
 
 	spin_lock_bh(&serv->sv_lock);
@@ -2083,7 +2088,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		nfsd_destroy_serv(net);
 
 out_unlock_mtx:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 
 	return err;
 }
@@ -2113,8 +2118,8 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_msg;
 	}
 
-	mutex_lock(&nfsd_mutex);
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
+	mutex_lock(&nn->nfsd_info.mutex);
 
 	/* no nfs server? Just send empty socket list */
 	if (!nn->nfsd_serv)
@@ -2144,14 +2149,14 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	spin_unlock_bh(&serv->sv_lock);
 out_unlock_mtx:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 	genlmsg_end(skb, hdr);
 
 	return genlmsg_reply(skb, info);
 
 err_serv_unlock:
 	spin_unlock_bh(&serv->sv_lock);
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 err_free_msg:
 	nlmsg_free(skb);
 
@@ -2253,7 +2258,7 @@ static __net_init int nfsd_net_init(struct net *net)
 		nn->nfsd_versions[i] = nfsd_support_version(i);
 	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
 		nn->nfsd4_minorversions[i] = nfsd_support_version(4);
-	nn->nfsd_info.mutex = &nfsd_mutex;
+	mutex_init(&nn->nfsd_info.mutex);
 	nn->nfsd_serv = NULL;
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8ad9fcc23789..3cbca4d34f48 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -77,7 +77,6 @@ struct nfsd_genl_rqstp {
 
 extern struct svc_program	nfsd_programs[];
 extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
-extern struct mutex		nfsd_mutex;
 extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
 bool nfsd_startup_get(void);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b2080e5a71e6..9f70b1fbc55e 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -56,20 +56,6 @@ static __be32			nfsd_init_request(struct svc_rqst *,
 						const struct svc_program *,
 						struct svc_process_info *);
 
-/*
- * nfsd_mutex protects nn->nfsd_serv -- both the pointer itself and some members
- * of the svc_serv struct such as ->sv_temp_socks and ->sv_permsocks.
- *
- * Finally, the nfsd_mutex also protects some of the global variables that are
- * accessed when nfsd starts and that are settable via the write_* routines in
- * nfsctl.c. In particular:
- *
- *	user_recovery_dirname
- *	user_lease_time
- *	nfsd_versions
- */
-DEFINE_MUTEX(nfsd_mutex);
-
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 static const struct svc_version *localio_versions[] = {
 	[1] = &localio_version1,
@@ -242,10 +228,10 @@ int nfsd_nrthreads(struct net *net)
 	int rv = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->nfsd_info.mutex);
 	if (nn->nfsd_serv)
 		rv = nn->nfsd_serv->sv_nrthreads;
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 	return rv;
 }
 
@@ -522,7 +508,6 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 };
 #endif
 
-/* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
 /**
@@ -534,7 +519,7 @@ void nfsd_destroy_serv(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
 
-	lockdep_assert_held(&nfsd_mutex);
+	lockdep_assert_held(&nn->nfsd_info.mutex);
 
 	spin_lock(&nfsd_notifier_lock);
 	nn->nfsd_serv = NULL;
@@ -606,17 +591,17 @@ void nfsd_shutdown_threads(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->nfsd_info.mutex);
 	serv = nn->nfsd_serv;
 	if (serv == NULL) {
-		mutex_unlock(&nfsd_mutex);
+		mutex_unlock(&nn->nfsd_info.mutex);
 		return;
 	}
 
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
 	nfsd_destroy_serv(net);
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->nfsd_info.mutex);
 }
 
 struct svc_rqst *nfsd_current_rqst(void)
@@ -632,7 +617,7 @@ int nfsd_create_serv(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
-	WARN_ON(!mutex_is_locked(&nfsd_mutex));
+	WARN_ON(!mutex_is_locked(&nn->nfsd_info.mutex));
 	if (nn->nfsd_serv)
 		return 0;
 
@@ -714,7 +699,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	int err = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	lockdep_assert_held(&nfsd_mutex);
+	lockdep_assert_held(&nn->nfsd_info.mutex);
 
 	if (nn->nfsd_serv == NULL || n <= 0)
 		return 0;
@@ -787,7 +772,7 @@ nfsd_svc(int n, int *nthreads, struct net *net, const struct cred *cred, const c
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
-	lockdep_assert_held(&nfsd_mutex);
+	lockdep_assert_held(&nn->nfsd_info.mutex);
 
 	dprintk("nfsd: creating service\n");
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 48666b83fe68..a12fe99156ec 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -98,7 +98,7 @@ struct svc_serv {
 /* This is used by pool_stats to find and lock an svc */
 struct svc_info {
 	struct svc_serv		*serv;
-	struct mutex		*mutex;
+	struct mutex		mutex;
 };
 
 void svc_destroy(struct svc_serv **svcp);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 8b1837228799..b8352b7d6860 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1399,7 +1399,7 @@ static void *svc_pool_stats_start(struct seq_file *m, loff_t *pos)
 
 	dprintk("svc_pool_stats_start, *pidx=%u\n", pidx);
 
-	mutex_lock(si->mutex);
+	mutex_lock(&si->mutex);
 
 	if (!pidx)
 		return SEQ_START_TOKEN;
@@ -1436,7 +1436,7 @@ static void svc_pool_stats_stop(struct seq_file *m, void *p)
 {
 	struct svc_info *si = m->private;
 
-	mutex_unlock(si->mutex);
+	mutex_unlock(&si->mutex);
 }
 
 static int svc_pool_stats_show(struct seq_file *m, void *p)
-- 
2.49.0


