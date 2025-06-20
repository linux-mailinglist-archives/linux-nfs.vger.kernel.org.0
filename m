Return-Path: <linux-nfs+bounces-12604-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAE7AE2686
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 01:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642174A5DBC
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8823C4F1;
	Fri, 20 Jun 2025 23:39:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8E23D291
	for <linux-nfs@vger.kernel.org>; Fri, 20 Jun 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750462753; cv=none; b=Om948VFdeeVK7+i+jagVRXp31aE/E6gImMAwoKkNAGhOmDocBrogA47Z3WkWOCCgD+Cxsbrugwe8dXVmnWUKcCbBE7ZyZ2XfRBBhxzpdzJSKbNM0Zzf5jgtobFtL0EQqrwTDMS/Tp8EUxCu7wNBpjUv8AcWG8R2+RMukoMojPmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750462753; c=relaxed/simple;
	bh=Lh+/KSbbG0kkUijhXNbvFpN05Kyl5MuF1kPVlfpb32M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPZGc0gR2DbAzjdjWnXywxETAwKGd4AprZJA/q33t19JxfpXeCmoPb8IoLzv40oGxRWaa4O0WV2XuZtio/Cb62BuxVWDxzp3kRWkMh8/Lum7H22zoInTKtx20AVJQwn14cSjFhkHLLvc8e/hsdNBZVvkSAc9QMWCxh4HwVWMGUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uSlJz-0023qN-Vu;
	Fri, 20 Jun 2025 23:39:00 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 3/3] nfsd: split nfsd_mutex into one mutex per net-namespace.
Date: Sat, 21 Jun 2025 09:33:26 +1000
Message-ID: <20250620233802.1453016-4-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620233802.1453016-1-neil@brown.name>
References: <20250620233802.1453016-1-neil@brown.name>
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

The use of guard(mutex)(...) is extended to all users of this lock.

Signed-off-by: NeilBrown <neil@brown.name>
---
 .../admin-guide/nfs/nfsd-admin-interfaces.rst |   4 +-
 fs/nfsd/netns.h                               |   1 +
 fs/nfsd/nfsctl.c                              | 158 +++++++-----------
 fs/nfsd/nfsd.h                                |   1 -
 fs/nfsd/nfssvc.c                              |  40 ++---
 include/linux/sunrpc/svc.h                    |   2 +-
 net/sunrpc/svc_xprt.c                         |   4 +-
 7 files changed, 73 insertions(+), 137 deletions(-)

diff --git a/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst b/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
index c05926f79054..0d9c3392e1ed 100644
--- a/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
+++ b/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
@@ -37,4 +37,6 @@ Implementation notes
 
 Note that the rpc server requires the caller to serialize addition and
 removal of listening sockets, and startup and shutdown of the server.
-For nfsd this is done using nfsd_mutex.
+For nfsd this is done using nfsd_info.mutex in struct nfsd_net, which is
+called config_mutex.
+
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 3e2d0fde80a7..d05e3f405d2e 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -134,6 +134,7 @@ struct nfsd_net {
 
 	struct svc_info nfsd_info;
 #define nfsd_serv nfsd_info.serv
+#define config_mutex nfsd_info.mutex
 
 	struct percpu_ref nfsd_net_ref;
 	struct completion nfsd_net_confirm_done;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 0e7e89dc730b..66c87f63a258 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -223,7 +223,7 @@ static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
 	struct net *net = netns(file);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	guard(mutex)(&nfsd_mutex);
+	guard(mutex)(&nn->config_mutex);
 	if (!nn->nfsd_serv)
 		/* There cannot be any files to unlock */
 		return -EINVAL;
@@ -267,7 +267,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	int error;
 	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 
-	guard(mutex)(&nfsd_mutex);
+	guard(mutex)(&nn->config_mutex);
 	if (!nn->nfsd_serv)
 		/* There cannot be any files to unlock */
 		return -EINVAL;
@@ -413,6 +413,7 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
 	char *mesg = buf;
 	int rv;
 	struct net *net = netns(file);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	if (size > 0) {
 		int newthreads;
@@ -422,9 +423,8 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
 		if (newthreads < 0)
 			return -EINVAL;
 		trace_nfsd_ctl_threads(net, newthreads);
-		mutex_lock(&nfsd_mutex);
+		guard(mutex)(&nn->config_mutex);
 		rv = nfsd_svc(1, &newthreads, net, file->f_cred, NULL);
-		mutex_unlock(&nfsd_mutex);
 		if (rv < 0)
 			return rv;
 	} else
@@ -467,8 +467,10 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 	int npools;
 	int *nthreads;
 	struct net *net = netns(file);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	guard(mutex)(&nn->config_mutex);
 
-	mutex_lock(&nfsd_mutex);
 	npools = nfsd_nrpools(net);
 	if (npools == 0) {
 		/*
@@ -476,7 +478,6 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 		 * writing to the threads file but NOT the pool_threads
 		 * file, sorry.  Report zero threads.
 		 */
-		mutex_unlock(&nfsd_mutex);
 		strcpy(buf, "0\n");
 		return strlen(buf);
 	}
@@ -526,7 +527,6 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 	rv = mesg - buf;
 out_free:
 	kfree(nthreads);
-	mutex_unlock(&nfsd_mutex);
 	return rv;
 }
 
@@ -689,12 +689,10 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
  */
 static ssize_t write_versions(struct file *file, char *buf, size_t size)
 {
-	ssize_t rv;
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 
-	mutex_lock(&nfsd_mutex);
-	rv = __write_versions(file, buf, size);
-	mutex_unlock(&nfsd_mutex);
-	return rv;
+	guard(mutex)(&nn->config_mutex);
+	return __write_versions(file, buf, size);
 }
 
 /*
@@ -848,15 +846,12 @@ static ssize_t __write_ports(struct file *file, char *buf, size_t size,
  */
 static ssize_t write_ports(struct file *file, char *buf, size_t size)
 {
-	ssize_t rv;
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 
-	mutex_lock(&nfsd_mutex);
-	rv = __write_ports(file, buf, size, netns(file));
-	mutex_unlock(&nfsd_mutex);
-	return rv;
+	guard(mutex)(&nn->config_mutex);
+	return __write_ports(file, buf, size, netns(file));
 }
 
-
 int nfsd_max_blksize;
 
 /*
@@ -898,13 +893,11 @@ static ssize_t write_maxblksize(struct file *file, char *buf, size_t size)
 		bsize = max_t(int, bsize, 1024);
 		bsize = min_t(int, bsize, NFSSVC_MAXBLKSIZE);
 		bsize &= ~(1024-1);
-		mutex_lock(&nfsd_mutex);
-		if (nn->nfsd_serv) {
-			mutex_unlock(&nfsd_mutex);
+
+		guard(mutex)(&nn->config_mutex);
+		if (nn->nfsd_serv)
 			return -EBUSY;
-		}
 		nfsd_max_blksize = bsize;
-		mutex_unlock(&nfsd_mutex);
 	}
 
 	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%d\n",
@@ -951,12 +944,8 @@ static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
 static ssize_t nfsd4_write_time(struct file *file, char *buf, size_t size,
 				time64_t *time, struct nfsd_net *nn)
 {
-	ssize_t rv;
-
-	mutex_lock(&nfsd_mutex);
-	rv = __nfsd4_write_time(file, buf, size, time, nn);
-	mutex_unlock(&nfsd_mutex);
-	return rv;
+	guard(mutex)(&nn->config_mutex);
+	return __nfsd4_write_time(file, buf, size, time, nn);
 }
 
 /*
@@ -1055,13 +1044,10 @@ static ssize_t __write_recoverydir(struct file *file, char *buf, size_t size,
  */
 static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
 {
-	ssize_t rv;
 	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 
-	mutex_lock(&nfsd_mutex);
-	rv = __write_recoverydir(file, buf, size, nn);
-	mutex_unlock(&nfsd_mutex);
-	return rv;
+	guard(mutex)(&nn->config_mutex);
+	return __write_recoverydir(file, buf, size, nn);
 }
 #endif
 
@@ -1090,7 +1076,7 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 {
 	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 
-	guard(mutex)(&nfsd_mutex);
+	guard(mutex)(&nn->config_mutex);
 	if (size > 0) {
 		switch(buf[0]) {
 		case 'Y':
@@ -1525,17 +1511,13 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				  struct netlink_callback *cb)
 {
 	int i, ret, rqstp_index = 0;
-	struct nfsd_net *nn;
-
-	mutex_lock(&nfsd_mutex);
+	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
 
-	nn = net_generic(sock_net(skb->sk), nfsd_net_id);
-	if (!nn->nfsd_serv) {
-		ret = -ENODEV;
-		goto out_unlock;
-	}
+	guard(mutex)(&nn->config_mutex);
+	if (!nn->nfsd_serv)
+		return -ENODEV;
 
-	rcu_read_lock();
+	guard(rcu)();
 
 	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
 		struct svc_rqst *rqstp;
@@ -1601,17 +1583,13 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 			ret = nfsd_genl_rpc_status_compose_msg(skb, cb,
 							       &genl_rqstp);
 			if (ret)
-				goto out;
+				return ret;
 		}
 	}
 
 	cb->args[0] = i;
 	cb->args[1] = rqstp_index;
 	ret = skb->len;
-out:
-	rcu_read_unlock();
-out_unlock:
-	mutex_unlock(&nfsd_mutex);
 
 	return ret;
 }
@@ -1640,14 +1618,12 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 			count++;
 	}
 
-	mutex_lock(&nfsd_mutex);
+	guard(mutex)(&nn->config_mutex);
 
 	nrpools = max(count, nfsd_nrpools(net));
 	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
-	if (!nthreads) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!nthreads)
+		return -ENOMEM;
 
 	i = 0;
 	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
@@ -1663,7 +1639,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	    info->attrs[NFSD_A_SERVER_SCOPE]) {
 		ret = -EBUSY;
 		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
-			goto out_unlock;
+			goto out_free;
 
 		ret = -EINVAL;
 		attr = info->attrs[NFSD_A_SERVER_GRACETIME];
@@ -1671,7 +1647,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 			u32 gracetime = nla_get_u32(attr);
 
 			if (gracetime < 10 || gracetime > 3600)
-				goto out_unlock;
+				goto out_free;
 
 			nn->nfsd4_grace = gracetime;
 		}
@@ -1681,7 +1657,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 			u32 leasetime = nla_get_u32(attr);
 
 			if (leasetime < 10 || leasetime > 3600)
-				goto out_unlock;
+				goto out_free;
 
 			nn->nfsd4_lease = leasetime;
 		}
@@ -1694,8 +1670,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	ret = nfsd_svc(nrpools, nthreads, net, get_current_cred(), scope);
 	if (ret > 0)
 		ret = 0;
-out_unlock:
-	mutex_unlock(&nfsd_mutex);
+out_free:
 	kfree(nthreads);
 	return ret;
 }
@@ -1724,7 +1699,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_msg;
 	}
 
-	mutex_lock(&nfsd_mutex);
+	guard(mutex)(&nn->config_mutex);
 
 	err = nla_put_u32(skb, NFSD_A_SERVER_GRACETIME,
 			  nn->nfsd4_grace) ||
@@ -1733,7 +1708,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 	      nla_put_string(skb, NFSD_A_SERVER_SCOPE,
 			  nn->nfsd_name);
 	if (err)
-		goto err_unlock;
+		goto err_free_msg;
 
 	if (nn->nfsd_serv) {
 		int i;
@@ -1744,22 +1719,18 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
 					  sp->sp_nrthreads);
 			if (err)
-				goto err_unlock;
+				goto err_free_msg;
 		}
 	} else {
 		err = nla_put_u32(skb, NFSD_A_SERVER_THREADS, 0);
 		if (err)
-			goto err_unlock;
+			goto err_free_msg;
 	}
 
-	mutex_unlock(&nfsd_mutex);
-
 	genlmsg_end(skb, hdr);
 
 	return genlmsg_reply(skb, info);
 
-err_unlock:
-	mutex_unlock(&nfsd_mutex);
 err_free_msg:
 	nlmsg_free(skb);
 
@@ -1782,13 +1753,10 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_PROTO_VERSION))
 		return -EINVAL;
 
-	mutex_lock(&nfsd_mutex);
-
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
-	if (nn->nfsd_serv) {
-		mutex_unlock(&nfsd_mutex);
+	guard(mutex)(&nn->config_mutex);
+	if (nn->nfsd_serv)
 		return -EBUSY;
-	}
 
 	/* clear current supported versions. */
 	nfsd_vers(nn, 2, NFSD_CLEAR);
@@ -1831,8 +1799,6 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	mutex_unlock(&nfsd_mutex);
-
 	return 0;
 }
 
@@ -1859,8 +1825,8 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_msg;
 	}
 
-	mutex_lock(&nfsd_mutex);
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
+	guard(mutex)(&nn->config_mutex);
 
 	for (i = 2; i <= 4; i++) {
 		int j;
@@ -1882,13 +1848,13 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 					      NFSD_A_SERVER_PROTO_VERSION);
 			if (!attr) {
 				err = -EINVAL;
-				goto err_nfsd_unlock;
+				goto err_free_msg;
 			}
 
 			if (nla_put_u32(skb, NFSD_A_VERSION_MAJOR, i) ||
 			    nla_put_u32(skb, NFSD_A_VERSION_MINOR, j)) {
 				err = -EINVAL;
-				goto err_nfsd_unlock;
+				goto err_free_msg;
 			}
 
 			/* Set the enabled flag if the version is enabled */
@@ -1896,20 +1862,17 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 			    (i < 4 || nfsd_minorversion(nn, j, NFSD_TEST)) &&
 			    nla_put_flag(skb, NFSD_A_VERSION_ENABLED)) {
 				err = -EINVAL;
-				goto err_nfsd_unlock;
+				goto err_free_msg;
 			}
 
 			nla_nest_end(skb, attr);
 		}
 	}
 
-	mutex_unlock(&nfsd_mutex);
 	genlmsg_end(skb, hdr);
 
 	return genlmsg_reply(skb, info);
 
-err_nfsd_unlock:
-	mutex_unlock(&nfsd_mutex);
 err_free_msg:
 	nlmsg_free(skb);
 
@@ -1934,15 +1897,13 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	bool delete = false;
 	int err, rem;
 
-	mutex_lock(&nfsd_mutex);
+	nn = net_generic(net, nfsd_net_id);
+	guard(mutex)(&nn->config_mutex);
 
 	err = nfsd_create_serv(net);
-	if (err) {
-		mutex_unlock(&nfsd_mutex);
+	if (err)
 		return err;
-	}
 
-	nn = net_generic(net, nfsd_net_id);
 	serv = nn->nfsd_serv;
 
 	spin_lock_bh(&serv->sv_lock);
@@ -2003,10 +1964,8 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&serv->sv_lock);
 
 	/* Do not remove listeners while there are active threads. */
-	if (serv->sv_nrthreads) {
-		err = -EBUSY;
-		goto out_unlock_mtx;
-	}
+	if (serv->sv_nrthreads)
+		return -EBUSY;
 
 	/*
 	 * Since we can't delete an arbitrary llist entry, destroy the
@@ -2057,9 +2016,6 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
 		nfsd_destroy_serv(net);
 
-out_unlock_mtx:
-	mutex_unlock(&nfsd_mutex);
-
 	return err;
 }
 
@@ -2088,12 +2044,12 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_msg;
 	}
 
-	mutex_lock(&nfsd_mutex);
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
+	guard(mutex)(&nn->config_mutex);
 
 	/* no nfs server? Just send empty socket list */
 	if (!nn->nfsd_serv)
-		goto out_unlock_mtx;
+		goto out;
 
 	serv = nn->nfsd_serv;
 	spin_lock_bh(&serv->sv_lock);
@@ -2103,7 +2059,7 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
 		attr = nla_nest_start(skb, NFSD_A_SERVER_SOCK_ADDR);
 		if (!attr) {
 			err = -EINVAL;
-			goto err_serv_unlock;
+			goto err;
 		}
 
 		if (nla_put_string(skb, NFSD_A_SOCK_TRANSPORT_NAME,
@@ -2112,21 +2068,19 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
 			    sizeof(struct sockaddr_storage),
 			    &xprt->xpt_local)) {
 			err = -EINVAL;
-			goto err_serv_unlock;
+			goto err;
 		}
 
 		nla_nest_end(skb, attr);
 	}
 	spin_unlock_bh(&serv->sv_lock);
-out_unlock_mtx:
-	mutex_unlock(&nfsd_mutex);
+out:
 	genlmsg_end(skb, hdr);
 
 	return genlmsg_reply(skb, info);
 
-err_serv_unlock:
+err:
 	spin_unlock_bh(&serv->sv_lock);
-	mutex_unlock(&nfsd_mutex);
 err_free_msg:
 	nlmsg_free(skb);
 
@@ -2228,7 +2182,7 @@ static __net_init int nfsd_net_init(struct net *net)
 		nn->nfsd_versions[i] = nfsd_support_version(i);
 	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
 		nn->nfsd4_minorversions[i] = nfsd_support_version(4);
-	nn->nfsd_info.mutex = &nfsd_mutex;
+	mutex_init(&nn->config_mutex);
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
index b2080e5a71e6..f7fdb05203f2 100644
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
@@ -239,14 +225,12 @@ static void nfsd_net_free(struct percpu_ref *ref)
 
 int nfsd_nrthreads(struct net *net)
 {
-	int rv = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv)
-		rv = nn->nfsd_serv->sv_nrthreads;
-	mutex_unlock(&nfsd_mutex);
-	return rv;
+	guard(mutex)(&nn->config_mutex);
+	if (!nn->nfsd_serv)
+		return 0;
+	return nn->nfsd_serv->sv_nrthreads;
 }
 
 static int nfsd_init_socks(struct net *net, const struct cred *cred)
@@ -522,7 +506,6 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 };
 #endif
 
-/* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
 /**
@@ -534,7 +517,7 @@ void nfsd_destroy_serv(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
 
-	lockdep_assert_held(&nfsd_mutex);
+	lockdep_assert_held(&nn->config_mutex);
 
 	spin_lock(&nfsd_notifier_lock);
 	nn->nfsd_serv = NULL;
@@ -606,17 +589,14 @@ void nfsd_shutdown_threads(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
-	mutex_lock(&nfsd_mutex);
+	guard(mutex)(&nn->config_mutex);
 	serv = nn->nfsd_serv;
-	if (serv == NULL) {
-		mutex_unlock(&nfsd_mutex);
+	if (serv == NULL)
 		return;
-	}
 
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
 	nfsd_destroy_serv(net);
-	mutex_unlock(&nfsd_mutex);
 }
 
 struct svc_rqst *nfsd_current_rqst(void)
@@ -632,7 +612,7 @@ int nfsd_create_serv(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
-	WARN_ON(!mutex_is_locked(&nfsd_mutex));
+	WARN_ON(!mutex_is_locked(&nn->config_mutex));
 	if (nn->nfsd_serv)
 		return 0;
 
@@ -714,7 +694,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	int err = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	lockdep_assert_held(&nfsd_mutex);
+	lockdep_assert_held(&nn->config_mutex);
 
 	if (nn->nfsd_serv == NULL || n <= 0)
 		return 0;
@@ -787,7 +767,7 @@ nfsd_svc(int n, int *nthreads, struct net *net, const struct cred *cred, const c
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
-	lockdep_assert_held(&nfsd_mutex);
+	lockdep_assert_held(&nn->config_mutex);
 
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


