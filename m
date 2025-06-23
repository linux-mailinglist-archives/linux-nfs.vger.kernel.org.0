Return-Path: <linux-nfs+bounces-12623-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E13AE33D7
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 05:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FD1188FC07
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 03:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2622510E5;
	Mon, 23 Jun 2025 03:01:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B06A225D7
	for <linux-nfs@vger.kernel.org>; Mon, 23 Jun 2025 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750647668; cv=none; b=AoXaqaoTul8qGB202JoT6e7SBVW6ObAUTbnv8i5vM+pFnFO3z8SqR53V6u/ZP2/H2r5ERd0mMmJw6TbtsLeIbZJuMpt3Ul1PeOOH2c+WUITygNOH8F/iJImpUtccxGpBBa+oCSNqD+ERa0gAsMgH/6vmcxfyo1Su6y9eMsBamt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750647668; c=relaxed/simple;
	bh=LD3caA4Q5N5OFh614gnBObLUFvJGyhm7Ola4G9QIcME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ7HQR26k4NvwWJVujbyfjUxJHoF7w9dB2McTfp5CTfXJbPsI8vz8/Z03sQAp8nC4XH86FmK2c4dYgjtJeTzf69L4whUccP7cY6UKpPTDIDM4OhvtwjOGkuHekoiYIXIAoAN2why636ZQeKQ9fA3qHDQUtrYNyjKw2shOn+9/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uTXQd-0036bN-KB;
	Mon, 23 Jun 2025 03:01:03 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 4/4] nfsd: use guard(mutex) for all ->config_mutex locking.
Date: Mon, 23 Jun 2025 12:47:16 +1000
Message-ID: <20250623030015.2353515-5-neil@brown.name>
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

Several function that lock ->config_mutex have multiple error paths.
Part of handling this is "goto unlock" statements, part is having
__write_foo() functions which are called by write_foo() after taking
the lock.

This can all be handled more neatly with
   guard(mutex)(&nn->config_mutex)
which ensures the mutex is dropped at the end of the scope.

this patch changes all locking on ->config_mutex to use guard() or
occasionally scoped_guard(), and folds the __write_foo() functions back
into write_foo().

Those function which are changed in this way have other clean changed
from goto to guard() or __free(), as mixing cleanup function with gotos
can sometimes be awkward.

This necessitates adding a guard for spin_lock_bh() and a __free function
for nlmsg.  This should probably go in the relevant header files at some
stage.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfsctl.c | 442 ++++++++++++++++++-----------------------------
 fs/nfsd/nfssvc.c |  17 +-
 2 files changed, 176 insertions(+), 283 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index eaed3df8b84b..06e39dbf9512 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -443,9 +443,8 @@ static ssize_t write_threads(struct file *file, char *buf, size_t size)
 		if (newthreads < 0)
 			return -EINVAL;
 		trace_nfsd_ctl_threads(net, newthreads);
-		mutex_lock(&nn->config_mutex);
-		rv = nfsd_svc(1, &newthreads, net, file->f_cred, NULL);
-		mutex_unlock(&nn->config_mutex);
+		scoped_guard(mutex, &nn->config_mutex)
+			rv = nfsd_svc(1, &newthreads, net, file->f_cred, NULL);
 		if (rv < 0)
 			return rv;
 	} else
@@ -486,11 +485,12 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 	int rv;
 	int len;
 	int npools;
-	int *nthreads;
+	int *nthreads __free(kfree) = NULL;
 	struct net *net = netns(file);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	mutex_lock(&nn->config_mutex);
+	guard(mutex)(&nn->config_mutex);
+
 	npools = nfsd_nrpools(net);
 	if (npools == 0) {
 		/*
@@ -498,15 +498,13 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 		 * writing to the threads file but NOT the pool_threads
 		 * file, sorry.  Report zero threads.
 		 */
-		mutex_unlock(&nn->config_mutex);
 		strcpy(buf, "0\n");
 		return strlen(buf);
 	}
 
 	nthreads = kcalloc(npools, sizeof(int), GFP_KERNEL);
-	rv = -ENOMEM;
 	if (nthreads == NULL)
-		goto out_free;
+		return -ENOMEM;
 
 	if (size > 0) {
 		for (i = 0; i < npools; i++) {
@@ -514,10 +512,9 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 			if (rv == -ENOENT)
 				break;		/* fewer numbers than pools */
 			if (rv)
-				goto out_free;	/* syntax error */
-			rv = -EINVAL;
+				return rv;	/* syntax error */
 			if (nthreads[i] < 0)
-				goto out_free;
+				return -EINVAL;
 			trace_nfsd_ctl_pool_threads(net, i, nthreads[i]);
 		}
 
@@ -530,12 +527,12 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 
 		rv = nfsd_set_nrthreads(i, nthreads, net);
 		if (rv)
-			goto out_free;
+			return rv;
 	}
 
 	rv = nfsd_get_nrthreads(npools, nthreads, net);
 	if (rv)
-		goto out_free;
+		return rv;
 
 	mesg = buf;
 	size = SIMPLE_TRANSACTION_LIMIT;
@@ -545,11 +542,7 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size)
 		size -= len;
 		mesg += len;
 	}
-	rv = mesg - buf;
-out_free:
-	kfree(nthreads);
-	mutex_lock(&nn->config_mutex);
-	return rv;
+	return mesg - buf;
 }
 
 static ssize_t
@@ -573,7 +566,39 @@ nfsd_print_version_support(struct nfsd_net *nn, char *buf, int remaining,
 			supported ? '+' : '-', vers, minor);
 }
 
-static ssize_t __write_versions(struct file *file, char *buf, size_t size)
+/*
+ * write_versions - Set or report the available NFS protocol versions
+ *
+ * Input:
+ *			buf:		ignored
+ *			size:		zero
+ * Output:
+ *	On success:	passed-in buffer filled with '\n'-terminated C
+ *			string containing positive or negative integer
+ *			values representing the current status of each
+ *			protocol version;
+ *			return code is the size in bytes of the string
+ *	On error:	return code is zero or a negative errno value
+ *
+ * OR
+ *
+ * Input:
+ *			buf:		C string containing whitespace-
+ *					separated positive or negative
+ *					integer values representing NFS
+ *					protocol versions to enable ("+n")
+ *					or disable ("-n")
+ *			size:		non-zero length of C string in @buf
+ * Output:
+ *	On success:	status of zero or more protocol versions has
+ *			been updated; passed-in buffer filled with
+ *			'\n'-terminated C string containing positive
+ *			or negative integer values representing the
+ *			current status of each protocol version;
+ *			return code is the size in bytes of the string
+ *	On error:	return code is zero or a negative errno value
+ */
+static ssize_t write_versions(struct file *file, char *buf, size_t size)
 {
 	char *mesg = buf;
 	char *vers, *minorp, sign;
@@ -582,6 +607,7 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
 	char *sep;
 	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
 
+	guard(mutex)(&nn->config_mutex);
 	if (size > 0) {
 		if (nn->nfsd_serv)
 			/* Cannot change versions without updating
@@ -677,49 +703,6 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
 	return tlen + len;
 }
 
-/*
- * write_versions - Set or report the available NFS protocol versions
- *
- * Input:
- *			buf:		ignored
- *			size:		zero
- * Output:
- *	On success:	passed-in buffer filled with '\n'-terminated C
- *			string containing positive or negative integer
- *			values representing the current status of each
- *			protocol version;
- *			return code is the size in bytes of the string
- *	On error:	return code is zero or a negative errno value
- *
- * OR
- *
- * Input:
- *			buf:		C string containing whitespace-
- *					separated positive or negative
- *					integer values representing NFS
- *					protocol versions to enable ("+n")
- *					or disable ("-n")
- *			size:		non-zero length of C string in @buf
- * Output:
- *	On success:	status of zero or more protocol versions has
- *			been updated; passed-in buffer filled with
- *			'\n'-terminated C string containing positive
- *			or negative integer values representing the
- *			current status of each protocol version;
- *			return code is the size in bytes of the string
- *	On error:	return code is zero or a negative errno value
- */
-static ssize_t write_versions(struct file *file, char *buf, size_t size)
-{
-	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
-	ssize_t rv;
-
-	mutex_lock(&nn->config_mutex);
-	rv = __write_versions(file, buf, size);
-	mutex_unlock(&nn->config_mutex);
-	return rv;
-}
-
 /*
  * Zero-length write.  Return a list of NFSD's current listener
  * transports.
@@ -811,21 +794,6 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	return err;
 }
 
-static ssize_t __write_ports(struct file *file, char *buf, size_t size,
-			     struct net *net)
-{
-	if (size == 0)
-		return __write_ports_names(buf, net);
-
-	if (isdigit(buf[0]))
-		return __write_ports_addfd(buf, net, file->f_cred);
-
-	if (isalpha(buf[0]))
-		return __write_ports_addxprt(buf, net, file->f_cred);
-
-	return -EINVAL;
-}
-
 /*
  * write_ports - Pass a socket file descriptor or transport name to listen on
  *
@@ -871,13 +839,21 @@ static ssize_t __write_ports(struct file *file, char *buf, size_t size,
  */
 static ssize_t write_ports(struct file *file, char *buf, size_t size)
 {
-	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
-	ssize_t rv;
+	struct net *net = netns(file);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	mutex_lock(&nn->config_mutex);
-	rv = __write_ports(file, buf, size, netns(file));
-	mutex_unlock(&nn->config_mutex);
-	return rv;
+	guard(mutex)(&nn->config_mutex);
+
+	if (size == 0)
+		return __write_ports_names(buf, net);
+
+	if (isdigit(buf[0]))
+		return __write_ports_addfd(buf, net, file->f_cred);
+
+	if (isalpha(buf[0]))
+		return __write_ports_addxprt(buf, net, file->f_cred);
+
+	return -EINVAL;
 }
 
 int nfsd_max_blksize;
@@ -921,13 +897,11 @@ static ssize_t write_maxblksize(struct file *file, char *buf, size_t size)
 		bsize = max_t(int, bsize, 1024);
 		bsize = min_t(int, bsize, NFSSVC_MAXBLKSIZE);
 		bsize &= ~(1024-1);
-		mutex_lock(&nn->config_mutex);
-		if (nn->nfsd_serv) {
-			mutex_unlock(&nn->config_mutex);
+
+		guard(mutex)(&nn->config_mutex);
+		if (nn->nfsd_serv)
 			return -EBUSY;
-		}
 		nfsd_max_blksize = bsize;
-		mutex_unlock(&nn->config_mutex);
 	}
 
 	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%d\n",
@@ -974,12 +948,8 @@ static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
 static ssize_t nfsd4_write_time(struct file *file, char *buf, size_t size,
 				time64_t *time, struct nfsd_net *nn)
 {
-	ssize_t rv;
-
-	mutex_lock(&nn->config_mutex);
-	rv = __nfsd4_write_time(file, buf, size, time, nn);
-	mutex_unlock(&nn->config_mutex);
-	return rv;
+	guard(mutex)(&nn->config_mutex);
+	return __nfsd4_write_time(file, buf, size, time, nn);
 }
 
 /*
@@ -1026,35 +996,6 @@ static ssize_t write_gracetime(struct file *file, char *buf, size_t size)
 }
 
 #ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
-static ssize_t __write_recoverydir(struct file *file, char *buf, size_t size,
-				   struct nfsd_net *nn)
-{
-	char *mesg = buf;
-	char *recdir;
-	int len, status;
-
-	if (size > 0) {
-		if (nn->nfsd_serv)
-			return -EBUSY;
-		if (size > PATH_MAX || buf[size-1] != '\n')
-			return -EINVAL;
-		buf[size-1] = 0;
-
-		recdir = mesg;
-		len = qword_get(&mesg, recdir, size);
-		if (len <= 0)
-			return -EINVAL;
-		trace_nfsd_ctl_recoverydir(netns(file), recdir);
-
-		status = nfs4_reset_recoverydir(recdir);
-		if (status)
-			return status;
-	}
-
-	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%s\n",
-							nfs4_recoverydir());
-}
-
 /*
  * write_recoverydir - Set or report the pathname of the recovery directory
  *
@@ -1078,13 +1019,33 @@ static ssize_t __write_recoverydir(struct file *file, char *buf, size_t size,
  */
 static ssize_t write_recoverydir(struct file *file, char *buf, size_t size)
 {
-	ssize_t rv;
 	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
+	char *mesg = buf;
+	char *recdir;
+	int len, status;
 
-	mutex_lock(&nn->config_mutex);
-	rv = __write_recoverydir(file, buf, size, nn);
-	mutex_unlock(&nn->config_mutex);
-	return rv;
+	guard(mutex)(&nn->config_mutex);
+
+	if (size > 0) {
+		if (nn->nfsd_serv)
+			return -EBUSY;
+		if (size > PATH_MAX || buf[size-1] != '\n')
+			return -EINVAL;
+		buf[size-1] = 0;
+
+		recdir = mesg;
+		len = qword_get(&mesg, recdir, size);
+		if (len <= 0)
+			return -EINVAL;
+		trace_nfsd_ctl_recoverydir(netns(file), recdir);
+
+		status = nfs4_reset_recoverydir(recdir);
+		if (status)
+			return status;
+	}
+
+	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%s\n",
+							nfs4_recoverydir());
 }
 #endif
 
@@ -1552,13 +1513,11 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 	int i, ret, rqstp_index = 0;
 	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
 
-	mutex_lock(&nn->config_mutex);
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
@@ -1624,17 +1583,13 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
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
-	mutex_unlock(&nn->config_mutex);
 
 	return ret;
 }
@@ -1648,7 +1603,8 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
  */
 int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	int *nthreads, count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
+	int count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
+	int *nthreads __free(kfree) = NULL;
 	struct net *net = genl_info_net(info);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	const struct nlattr *attr;
@@ -1663,14 +1619,12 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 			count++;
 	}
 
-	mutex_lock(&nn->config_mutex);
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
@@ -1684,17 +1638,15 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
 	    info->attrs[NFSD_A_SERVER_SCOPE]) {
-		ret = -EBUSY;
 		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
-			goto out_unlock;
+			return -EBUSY;
 
-		ret = -EINVAL;
 		attr = info->attrs[NFSD_A_SERVER_GRACETIME];
 		if (attr) {
 			u32 gracetime = nla_get_u32(attr);
 
 			if (gracetime < 10 || gracetime > 3600)
-				goto out_unlock;
+				return -EINVAL;
 
 			nn->nfsd4_grace = gracetime;
 		}
@@ -1704,7 +1656,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 			u32 leasetime = nla_get_u32(attr);
 
 			if (leasetime < 10 || leasetime > 3600)
-				goto out_unlock;
+				return -EINVAL;
 
 			nn->nfsd4_lease = leasetime;
 		}
@@ -1717,12 +1669,10 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	ret = nfsd_svc(nrpools, nthreads, net, get_current_cred(), scope);
 	if (ret > 0)
 		ret = 0;
-out_unlock:
-	mutex_unlock(&nn->config_mutex);
-	kfree(nthreads);
 	return ret;
 }
 
+DEFINE_FREE(nlmsg_free, struct sk_buff *, if (_T) nlmsg_free(_T))
 /**
  * nfsd_nl_threads_get_doit - get the number of running threads
  * @skb: reply buffer
@@ -1734,29 +1684,28 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct sk_buff *reply __free(nlmsg_free) =
+		genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	void *hdr;
 	int err;
 
-	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!skb)
+	if (!reply)
 		return -ENOMEM;
 
-	hdr = genlmsg_iput(skb, info);
-	if (!hdr) {
-		err = -EMSGSIZE;
-		goto err_free_msg;
-	}
+	hdr = genlmsg_iput(reply, info);
+	if (!hdr)
+		return -EMSGSIZE;
 
-	mutex_lock(&nn->config_mutex);
+	guard(mutex)(&nn->config_mutex);
 
-	err = nla_put_u32(skb, NFSD_A_SERVER_GRACETIME,
+	err = nla_put_u32(reply, NFSD_A_SERVER_GRACETIME,
 			  nn->nfsd4_grace) ||
-	      nla_put_u32(skb, NFSD_A_SERVER_LEASETIME,
+	      nla_put_u32(reply, NFSD_A_SERVER_LEASETIME,
 			  nn->nfsd4_lease) ||
-	      nla_put_string(skb, NFSD_A_SERVER_SCOPE,
+	      nla_put_string(reply, NFSD_A_SERVER_SCOPE,
 			  nn->nfsd_name);
 	if (err)
-		goto err_unlock;
+		return err;
 
 	if (nn->nfsd_serv) {
 		int i;
@@ -1764,29 +1713,20 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 		for (i = 0; i < nfsd_nrpools(net); ++i) {
 			struct svc_pool *sp = &nn->nfsd_serv->sv_pools[i];
 
-			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
+			err = nla_put_u32(reply, NFSD_A_SERVER_THREADS,
 					  sp->sp_nrthreads);
 			if (err)
-				goto err_unlock;
+				return err;
 		}
 	} else {
-		err = nla_put_u32(skb, NFSD_A_SERVER_THREADS, 0);
+		err = nla_put_u32(reply, NFSD_A_SERVER_THREADS, 0);
 		if (err)
-			goto err_unlock;
+			return err;
 	}
 
-	mutex_unlock(&nn->config_mutex);
-
-	genlmsg_end(skb, hdr);
+	genlmsg_end(reply, hdr);
 
-	return genlmsg_reply(skb, info);
-
-err_unlock:
-	mutex_unlock(&nn->config_mutex);
-err_free_msg:
-	nlmsg_free(skb);
-
-	return err;
+	return genlmsg_reply(no_free_ptr(reply), info);
 }
 
 /**
@@ -1806,11 +1746,9 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
-	mutex_lock(&nn->config_mutex);
-	if (nn->nfsd_serv) {
-		mutex_unlock(&nn->config_mutex);
+	guard(mutex)(&nn->config_mutex);
+	if (nn->nfsd_serv)
 		return -EBUSY;
-	}
 
 	/* clear current supported versions. */
 	nfsd_vers(nn, 2, NFSD_CLEAR);
@@ -1853,8 +1791,6 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	mutex_unlock(&nn->config_mutex);
-
 	return 0;
 }
 
@@ -1868,21 +1804,20 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
 int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nfsd_net *nn;
-	int i, err;
+	struct sk_buff *reply __free(nlmsg_free) =
+		genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	int i;
 	void *hdr;
 
-	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!skb)
+	if (!reply)
 		return -ENOMEM;
 
-	hdr = genlmsg_iput(skb, info);
-	if (!hdr) {
-		err = -EMSGSIZE;
-		goto err_free_msg;
-	}
+	hdr = genlmsg_iput(reply, info);
+	if (!hdr)
+		return -EMSGSIZE;
 
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
-	mutex_lock(&nn->config_mutex);
+	guard(mutex)(&nn->config_mutex);
 
 	for (i = 2; i <= 4; i++) {
 		int j;
@@ -1900,42 +1835,28 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 			if (i < 4 && j)
 				continue;
 
-			attr = nla_nest_start(skb,
+			attr = nla_nest_start(reply,
 					      NFSD_A_SERVER_PROTO_VERSION);
-			if (!attr) {
-				err = -EINVAL;
-				goto err_nfsd_unlock;
-			}
+			if (!attr)
+				return -EINVAL;
 
-			if (nla_put_u32(skb, NFSD_A_VERSION_MAJOR, i) ||
-			    nla_put_u32(skb, NFSD_A_VERSION_MINOR, j)) {
-				err = -EINVAL;
-				goto err_nfsd_unlock;
-			}
+			if (nla_put_u32(reply, NFSD_A_VERSION_MAJOR, i) ||
+			    nla_put_u32(reply, NFSD_A_VERSION_MINOR, j))
+				return -EINVAL;
 
 			/* Set the enabled flag if the version is enabled */
 			if (nfsd_vers(nn, i, NFSD_TEST) &&
 			    (i < 4 || nfsd_minorversion(nn, j, NFSD_TEST)) &&
-			    nla_put_flag(skb, NFSD_A_VERSION_ENABLED)) {
-				err = -EINVAL;
-				goto err_nfsd_unlock;
-			}
+			    nla_put_flag(reply, NFSD_A_VERSION_ENABLED))
+				return -EINVAL;
 
-			nla_nest_end(skb, attr);
+			nla_nest_end(reply, attr);
 		}
 	}
 
-	mutex_unlock(&nn->config_mutex);
-	genlmsg_end(skb, hdr);
-
-	return genlmsg_reply(skb, info);
-
-err_nfsd_unlock:
-	mutex_unlock(&nn->config_mutex);
-err_free_msg:
-	nlmsg_free(skb);
+	genlmsg_end(reply, hdr);
 
-	return err;
+	return genlmsg_reply(no_free_ptr(reply), info);
 }
 
 /**
@@ -1957,13 +1878,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	int err, rem;
 
 	nn = net_generic(net, nfsd_net_id);
-	mutex_lock(&nn->config_mutex);
+	guard(mutex)(&nn->config_mutex);
 
 	err = nfsd_create_serv(net);
-	if (err) {
-		mutex_unlock(&nn->config_mutex);
+	if (err)
 		return err;
-	}
 
 	serv = nn->nfsd_serv;
 
@@ -2025,10 +1944,8 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2079,12 +1996,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
 		nfsd_destroy_serv(net);
 
-out_unlock_mtx:
-	mutex_unlock(&nn->config_mutex);
-
 	return err;
 }
 
+DEFINE_GUARD(spin_lock_bh, spinlock_t *, spin_lock_bh(_T), spin_unlock_bh(_T))
 /**
  * nfsd_nl_listener_get_doit - get the nfs running listeners
  * @skb: reply buffer
@@ -2098,61 +2013,44 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
 	struct svc_serv *serv;
 	struct nfsd_net *nn;
 	void *hdr;
-	int err;
 
-	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!skb)
+	struct sk_buff __free(nlmsg_free) *reply =
+			genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!reply)
 		return -ENOMEM;
 
-	hdr = genlmsg_iput(skb, info);
-	if (!hdr) {
-		err = -EMSGSIZE;
-		goto err_free_msg;
-	}
+	hdr = genlmsg_iput(reply, info);
+	if (!hdr)
+		return -EMSGSIZE;
 
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
-	mutex_lock(&nn->config_mutex);
+	guard(mutex)(&nn->config_mutex);
 
 	/* no nfs server? Just send empty socket list */
-	if (!nn->nfsd_serv)
-		goto out_unlock_mtx;
+	if (nn->nfsd_serv) {
+		serv = nn->nfsd_serv;
+		guard(spin_lock_bh)(&serv->sv_lock);
+		list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
+			struct nlattr *attr;
 
-	serv = nn->nfsd_serv;
-	spin_lock_bh(&serv->sv_lock);
-	list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
-		struct nlattr *attr;
+			attr = nla_nest_start(reply, NFSD_A_SERVER_SOCK_ADDR);
+			if (!attr)
+				return -EINVAL;
 
-		attr = nla_nest_start(skb, NFSD_A_SERVER_SOCK_ADDR);
-		if (!attr) {
-			err = -EINVAL;
-			goto err_serv_unlock;
-		}
+			if (nla_put_string(reply, NFSD_A_SOCK_TRANSPORT_NAME,
+					   xprt->xpt_class->xcl_name) ||
+			    nla_put(reply, NFSD_A_SOCK_ADDR,
+				    sizeof(struct sockaddr_storage),
+				    &xprt->xpt_local))
+				return -EINVAL;
 
-		if (nla_put_string(skb, NFSD_A_SOCK_TRANSPORT_NAME,
-				   xprt->xpt_class->xcl_name) ||
-		    nla_put(skb, NFSD_A_SOCK_ADDR,
-			    sizeof(struct sockaddr_storage),
-			    &xprt->xpt_local)) {
-			err = -EINVAL;
-			goto err_serv_unlock;
+			nla_nest_end(reply, attr);
 		}
-
-		nla_nest_end(skb, attr);
 	}
-	spin_unlock_bh(&serv->sv_lock);
-out_unlock_mtx:
-	mutex_unlock(&nn->config_mutex);
-	genlmsg_end(skb, hdr);
-
-	return genlmsg_reply(skb, info);
 
-err_serv_unlock:
-	spin_unlock_bh(&serv->sv_lock);
-	mutex_unlock(&nn->config_mutex);
-err_free_msg:
-	nlmsg_free(skb);
+	genlmsg_end(reply, hdr);
 
-	return err;
+	return genlmsg_reply(no_free_ptr(reply), info);
 }
 
 /**
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c19e608802a6..b459d6283f16 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -225,14 +225,12 @@ static void nfsd_net_free(struct percpu_ref *ref)
 
 int nfsd_nrthreads(struct net *net)
 {
-	int rv = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	mutex_lock(&nn->config_mutex);
-	if (nn->nfsd_serv)
-		rv = nn->nfsd_serv->sv_nrthreads;
-	mutex_unlock(&nn->config_mutex);
-	return rv;
+	guard(mutex)(&nn->config_mutex);
+	if (!nn->nfsd_serv)
+		return 0;
+	return nn->nfsd_serv->sv_nrthreads;
 }
 
 static int nfsd_init_socks(struct net *net, const struct cred *cred)
@@ -578,17 +576,14 @@ void nfsd_shutdown_threads(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
-	mutex_lock(&nn->config_mutex);
+	guard(mutex)(&nn->config_mutex);
 	serv = nn->nfsd_serv;
-	if (serv == NULL) {
-		mutex_unlock(&nn->config_mutex);
+	if (serv == NULL)
 		return;
-	}
 
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
 	nfsd_destroy_serv(net);
-	mutex_unlock(&nn->config_mutex);
 }
 
 struct svc_rqst *nfsd_current_rqst(void)
-- 
2.49.0


