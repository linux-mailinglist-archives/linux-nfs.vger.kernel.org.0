Return-Path: <linux-nfs+bounces-12622-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F80AE33D6
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 05:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D607A1B82
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 02:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D816F34CDD;
	Mon, 23 Jun 2025 03:01:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D710E5
	for <linux-nfs@vger.kernel.org>; Mon, 23 Jun 2025 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750647665; cv=none; b=r/t8sN33vbVhwoRGKqrZWK2voA2H3vISVazuwgwSAtkgIzLil0BvzzcAE0A5U037+XoV7wFr22y1L0pLL6axQCj14pJlGUThaNrBFoDSYaFVKV80nr4OYAW7F86zKM/Dev6wuDqDgJ6StJEsI+LBHdgRpyqEQz+M4V4MU6iHHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750647665; c=relaxed/simple;
	bh=A7vQOanNSq+HuCXUvDXAzGGOGbR0+PNflTNSCzq4kSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYKUPZAM5gnRo15E1LP6jdxKoXzIZaveEUbDNghB4xnpyls3WGehz9/Pt+GdYp/pjL+fPWE07Z3Y5Y3JEstemsqjUghlcmOVkmN3atbJB8tDnjX+yP3bbfGpoqpDQRk5yZgP6vlc5kF+wsdlcgZJErHk5xWglqvoG6wSg3YqHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uTXQb-0036bJ-64;
	Mon, 23 Jun 2025 03:01:01 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 3/4] nfsd: split nfsd_mutex into one mutex per net-namespace.
Date: Mon, 23 Jun 2025 12:47:15 +1000
Message-ID: <20250623030015.2353515-4-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623030015.2353515-1-neil@brown.name>
References: <20250623030015.2353515-1-neil@brown.name>
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
We use a #define to call it "config_mutex"

Signed-off-by: NeilBrown <neil@brown.name>
---
 .../admin-guide/nfs/nfsd-admin-interfaces.rst |   4 +-
 fs/nfsd/netns.h                               |   1 +
 fs/nfsd/nfsctl.c                              | 100 +++++++++---------
 fs/nfsd/nfsd.h                                |   1 -
 fs/nfsd/nfssvc.c                              |  33 ++----
 include/linux/sunrpc/svc.h                    |   2 +-
 net/sunrpc/svc_xprt.c                         |   4 +-
 7 files changed, 67 insertions(+), 78 deletions(-)

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
index 2a1e54af89e5..eaed3df8b84b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -247,11 +247,12 @@ static ssize_t __write_unlock_ip(struct file *file, char *buf, size_t size)
 
 static ssize_t write_unlock_ip(struct file *file, char *buf, size_t size)
 {
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 	ssize_t ret;
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->config_mutex);
 	ret = __write_unlock_ip(file, buf, size);
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 	return ret;
 }
 
@@ -313,11 +314,12 @@ static ssize_t __write_unlock_fs(struct file *file, char *buf, size_t size)
 
 static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 {
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 	ssize_t ret;
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->config_mutex);
 	ret = __write_unlock_fs(file, buf, size);
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 	return ret;
 }
 
@@ -431,6 +433,7 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
 	char *mesg = buf;
 	int rv;
 	struct net *net = netns(file);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	if (size > 0) {
 		int newthreads;
@@ -440,9 +443,9 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
 		if (newthreads < 0)
 			return -EINVAL;
 		trace_nfsd_ctl_threads(net, newthreads);
-		mutex_lock(&nfsd_mutex);
+		mutex_lock(&nn->config_mutex);
 		rv = nfsd_svc(1, &newthreads, net, file->f_cred, NULL);
-		mutex_unlock(&nfsd_mutex);
+		mutex_unlock(&nn->config_mutex);
 		if (rv < 0)
 			return rv;
 	} else
@@ -485,8 +488,9 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 	int npools;
 	int *nthreads;
 	struct net *net = netns(file);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->config_mutex);
 	npools = nfsd_nrpools(net);
 	if (npools == 0) {
 		/*
@@ -494,7 +498,7 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 		 * writing to the threads file but NOT the pool_threads
 		 * file, sorry.  Report zero threads.
 		 */
-		mutex_unlock(&nfsd_mutex);
+		mutex_unlock(&nn->config_mutex);
 		strcpy(buf, "0\n");
 		return strlen(buf);
 	}
@@ -544,7 +548,7 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 	rv = mesg - buf;
 out_free:
 	kfree(nthreads);
-	mutex_unlock(&nfsd_mutex);
+	mutex_lock(&nn->config_mutex);
 	return rv;
 }
 
@@ -707,11 +711,12 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
  */
 static ssize_t write_versions(struct file *file, char *buf, size_t size)
 {
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 	ssize_t rv;
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->config_mutex);
 	rv = __write_versions(file, buf, size);
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 	return rv;
 }
 
@@ -866,15 +871,15 @@ static ssize_t __write_ports(struct file *file, char *buf, size_t size,
  */
 static ssize_t write_ports(struct file *file, char *buf, size_t size)
 {
+	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 	ssize_t rv;
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->config_mutex);
 	rv = __write_ports(file, buf, size, netns(file));
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 	return rv;
 }
 
-
 int nfsd_max_blksize;
 
 /*
@@ -916,13 +921,13 @@ static ssize_t write_maxblksize(struct file *file, char *buf, size_t size)
 		bsize = max_t(int, bsize, 1024);
 		bsize = min_t(int, bsize, NFSSVC_MAXBLKSIZE);
 		bsize &= ~(1024-1);
-		mutex_lock(&nfsd_mutex);
+		mutex_lock(&nn->config_mutex);
 		if (nn->nfsd_serv) {
-			mutex_unlock(&nfsd_mutex);
+			mutex_unlock(&nn->config_mutex);
 			return -EBUSY;
 		}
 		nfsd_max_blksize = bsize;
-		mutex_unlock(&nfsd_mutex);
+		mutex_unlock(&nn->config_mutex);
 	}
 
 	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%d\n",
@@ -971,9 +976,9 @@ static ssize_t nfsd4_write_time(struct file *file, char *buf, size_t size,
 {
 	ssize_t rv;
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->config_mutex);
 	rv = __nfsd4_write_time(file, buf, size, time, nn);
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 	return rv;
 }
 
@@ -1076,9 +1081,9 @@ static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
 	ssize_t rv;
 	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->config_mutex);
 	rv = __write_recoverydir(file, buf, size, nn);
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 	return rv;
 }
 #endif
@@ -1112,14 +1117,14 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 		case 'Y':
 		case 'y':
 		case '1':
-			mutex_lock(&nfsd_mutex);
+			mutex_lock(&nn->config_mutex);
 			if (!nn->nfsd_serv) {
-				mutex_unlock(&nfsd_mutex);
+				mutex_unlock(&nn->config_mutex);
 				return -EBUSY;
 			}
 			trace_nfsd_end_grace(netns(file));
 			nfsd4_end_grace(nn);
-			mutex_unlock(&nfsd_mutex);
+			mutex_unlock(&nn->config_mutex);
 			break;
 		default:
 			return -EINVAL;
@@ -1545,11 +1550,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 				  struct netlink_callback *cb)
 {
 	int i, ret, rqstp_index = 0;
-	struct nfsd_net *nn;
-
-	mutex_lock(&nfsd_mutex);
+	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
 
-	nn = net_generic(sock_net(skb->sk), nfsd_net_id);
+	mutex_lock(&nn->config_mutex);
 	if (!nn->nfsd_serv) {
 		ret = -ENODEV;
 		goto out_unlock;
@@ -1631,7 +1634,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 out:
 	rcu_read_unlock();
 out_unlock:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 
 	return ret;
 }
@@ -1660,7 +1663,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 			count++;
 	}
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->config_mutex);
 
 	nrpools = max(count, nfsd_nrpools(net));
 	nthreads = kcalloc(nrpools, sizeof(int), GFP_KERNEL);
@@ -1715,7 +1718,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret > 0)
 		ret = 0;
 out_unlock:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 	kfree(nthreads);
 	return ret;
 }
@@ -1744,7 +1747,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_msg;
 	}
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->config_mutex);
 
 	err = nla_put_u32(skb, NFSD_A_SERVER_GRACETIME,
 			  nn->nfsd4_grace) ||
@@ -1772,14 +1775,14 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 			goto err_unlock;
 	}
 
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 
 	genlmsg_end(skb, hdr);
 
 	return genlmsg_reply(skb, info);
 
 err_unlock:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 err_free_msg:
 	nlmsg_free(skb);
 
@@ -1802,11 +1805,10 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_PROTO_VERSION))
 		return -EINVAL;
 
-	mutex_lock(&nfsd_mutex);
-
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
+	mutex_lock(&nn->config_mutex);
 	if (nn->nfsd_serv) {
-		mutex_unlock(&nfsd_mutex);
+		mutex_unlock(&nn->config_mutex);
 		return -EBUSY;
 	}
 
@@ -1851,7 +1853,7 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 
 	return 0;
 }
@@ -1879,8 +1881,8 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_msg;
 	}
 
-	mutex_lock(&nfsd_mutex);
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
+	mutex_lock(&nn->config_mutex);
 
 	for (i = 2; i <= 4; i++) {
 		int j;
@@ -1923,13 +1925,13 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 	genlmsg_end(skb, hdr);
 
 	return genlmsg_reply(skb, info);
 
 err_nfsd_unlock:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 err_free_msg:
 	nlmsg_free(skb);
 
@@ -1954,15 +1956,15 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	bool delete = false;
 	int err, rem;
 
-	mutex_lock(&nfsd_mutex);
+	nn = net_generic(net, nfsd_net_id);
+	mutex_lock(&nn->config_mutex);
 
 	err = nfsd_create_serv(net);
 	if (err) {
-		mutex_unlock(&nfsd_mutex);
+		mutex_unlock(&nn->config_mutex);
 		return err;
 	}
 
-	nn = net_generic(net, nfsd_net_id);
 	serv = nn->nfsd_serv;
 
 	spin_lock_bh(&serv->sv_lock);
@@ -2078,7 +2080,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		nfsd_destroy_serv(net);
 
 out_unlock_mtx:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 
 	return err;
 }
@@ -2108,8 +2110,8 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_msg;
 	}
 
-	mutex_lock(&nfsd_mutex);
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
+	mutex_lock(&nn->config_mutex);
 
 	/* no nfs server? Just send empty socket list */
 	if (!nn->nfsd_serv)
@@ -2139,14 +2141,14 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	spin_unlock_bh(&serv->sv_lock);
 out_unlock_mtx:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 	genlmsg_end(skb, hdr);
 
 	return genlmsg_reply(skb, info);
 
 err_serv_unlock:
 	spin_unlock_bh(&serv->sv_lock);
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 err_free_msg:
 	nlmsg_free(skb);
 
@@ -2248,7 +2250,7 @@ static __net_init int nfsd_net_init(struct net *net)
 		nn->nfsd_versions[i] = nfsd_support_version(i);
 	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
 		nn->nfsd4_minorversions[i] = nfsd_support_version(4);
-	nn->nfsd_info.mutex = &nfsd_mutex;
+	mutex_init(&nn->config_mutex);
 	nn->nfsd_serv = NULL;
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 6c432133608f..ce489c04fdb2 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -77,7 +77,6 @@ struct nfsd_genl_rqstp {
 
 extern struct svc_program	nfsd_programs[];
 extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
-extern struct mutex		nfsd_mutex;
 extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
 bool nfsd_is_started(void);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 0eb144426e95..c19e608802a6 100644
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
+	mutex_lock(&nn->config_mutex);
 	if (nn->nfsd_serv)
 		rv = nn->nfsd_serv->sv_nrthreads;
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 	return rv;
 }
 
@@ -509,7 +495,6 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 };
 #endif
 
-/* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
 /**
@@ -521,7 +506,7 @@ void nfsd_destroy_serv(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
 
-	lockdep_assert_held(&nfsd_mutex);
+	lockdep_assert_held(&nn->config_mutex);
 
 	spin_lock(&nfsd_notifier_lock);
 	nn->nfsd_serv = NULL;
@@ -593,17 +578,17 @@ void nfsd_shutdown_threads(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&nn->config_mutex);
 	serv = nn->nfsd_serv;
 	if (serv == NULL) {
-		mutex_unlock(&nfsd_mutex);
+		mutex_unlock(&nn->config_mutex);
 		return;
 	}
 
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
 	nfsd_destroy_serv(net);
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&nn->config_mutex);
 }
 
 struct svc_rqst *nfsd_current_rqst(void)
@@ -619,7 +604,7 @@ int nfsd_create_serv(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
-	WARN_ON(!mutex_is_locked(&nfsd_mutex));
+	WARN_ON(!mutex_is_locked(&nn->config_mutex));
 	if (nn->nfsd_serv)
 		return 0;
 
@@ -701,7 +686,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	int err = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	lockdep_assert_held(&nfsd_mutex);
+	lockdep_assert_held(&nn->config_mutex);
 
 	if (nn->nfsd_serv == NULL || n <= 0)
 		return 0;
@@ -774,7 +759,7 @@ nfsd_svc(int n, int *nthreads, struct net *net, const struct cred *cred, const c
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


