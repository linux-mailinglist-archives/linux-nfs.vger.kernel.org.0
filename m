Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D2F7B4C6
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 23:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfG3VIs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 17:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfG3VIs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 30 Jul 2019 17:08:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0867430C1325;
        Tue, 30 Jul 2019 21:08:48 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-120-110.rdu2.redhat.com [10.10.120.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE8115C1A1;
        Tue, 30 Jul 2019 21:08:47 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 43DE3203E8; Tue, 30 Jul 2019 17:08:47 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH RFC 1/2] nfsd: add a "GetVersion" upcall for nfsdcld
Date:   Tue, 30 Jul 2019 17:08:46 -0400
Message-Id: <20190730210847.9804-2-smayhew@redhat.com>
In-Reply-To: <20190730210847.9804-1-smayhew@redhat.com>
References: <20190730210847.9804-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 30 Jul 2019 21:08:48 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a "GetVersion" upcall to allow nfsd to determine the maximum upcall
version that the nfsdcld userspace daemon supports.  If the daemon
responds with -EOPNOTSUPP, then we know it only supports v1.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/nfs4recover.c         | 167 ++++++++++++++++++++++++----------
 include/uapi/linux/nfsd/cld.h |  11 ++-
 2 files changed, 127 insertions(+), 51 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 87679557d0d6..58a61339d40c 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -59,8 +59,12 @@ struct nfsd4_client_tracking_ops {
 	void (*remove)(struct nfs4_client *);
 	int (*check)(struct nfs4_client *);
 	void (*grace_done)(struct nfsd_net *);
+	uint8_t version;
+	size_t msglen;
 };
 
+static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops;
+
 /* Globals */
 static char user_recovery_dirname[PATH_MAX] = "/var/lib/nfs/v4recovery";
 
@@ -718,6 +722,8 @@ static const struct nfsd4_client_tracking_ops nfsd4_legacy_tracking_ops = {
 	.remove		= nfsd4_remove_clid_dir,
 	.check		= nfsd4_check_legacy_client,
 	.grace_done	= nfsd4_recdir_purge_old,
+	.version	= 1,
+	.msglen		= 0,
 };
 
 /* Globals */
@@ -737,19 +743,24 @@ struct cld_upcall {
 	struct list_head	 cu_list;
 	struct cld_net		*cu_net;
 	struct completion	 cu_done;
-	struct cld_msg		 cu_msg;
+	union {
+		struct cld_msg_hdr	 cu_hdr;
+		struct cld_msg		 cu_msg;
+	} cu_u;
 };
 
 static int
-__cld_pipe_upcall(struct rpc_pipe *pipe, struct cld_msg *cmsg)
+__cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
 {
 	int ret;
 	struct rpc_pipe_msg msg;
-	struct cld_upcall *cup = container_of(cmsg, struct cld_upcall, cu_msg);
+	struct cld_upcall *cup = container_of(cmsg, struct cld_upcall, cu_u);
+	struct nfsd_net *nn = net_generic(pipe->dentry->d_sb->s_fs_info,
+					  nfsd_net_id);
 
 	memset(&msg, 0, sizeof(msg));
 	msg.data = cmsg;
-	msg.len = sizeof(*cmsg);
+	msg.len = nn->client_tracking_ops->msglen;
 
 	ret = rpc_queue_upcall(pipe, &msg);
 	if (ret < 0) {
@@ -765,7 +776,7 @@ __cld_pipe_upcall(struct rpc_pipe *pipe, struct cld_msg *cmsg)
 }
 
 static int
-cld_pipe_upcall(struct rpc_pipe *pipe, struct cld_msg *cmsg)
+cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
 {
 	int ret;
 
@@ -809,7 +820,7 @@ __cld_pipe_inprogress_downcall(const struct cld_msg __user *cmsg,
 			kfree(name.data);
 			return -EFAULT;
 		}
-		return sizeof(*cmsg);
+		return nn->client_tracking_ops->msglen;
 	}
 	return -EFAULT;
 }
@@ -818,6 +829,7 @@ static ssize_t
 cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 {
 	struct cld_upcall *tmp, *cup;
+	struct cld_msg_hdr __user *hdr = (struct cld_msg_hdr __user *)src;
 	struct cld_msg __user *cmsg = (struct cld_msg __user *)src;
 	uint32_t xid;
 	struct nfsd_net *nn = net_generic(file_inode(filp)->i_sb->s_fs_info,
@@ -825,14 +837,14 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	struct cld_net *cn = nn->cld_net;
 	int16_t status;
 
-	if (mlen != sizeof(*cmsg)) {
+	if (mlen != nn->client_tracking_ops->msglen) {
 		dprintk("%s: got %zu bytes, expected %zu\n", __func__, mlen,
-			sizeof(*cmsg));
+			nn->client_tracking_ops->msglen);
 		return -EINVAL;
 	}
 
 	/* copy just the xid so we can try to find that */
-	if (copy_from_user(&xid, &cmsg->cm_xid, sizeof(xid)) != 0) {
+	if (copy_from_user(&xid, &hdr->cm_xid, sizeof(xid)) != 0) {
 		dprintk("%s: error when copying xid from userspace", __func__);
 		return -EFAULT;
 	}
@@ -842,7 +854,7 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	 * list (for -EINPROGRESS, we just want to make sure the xid is
 	 * valid, not remove the upcall from the list)
 	 */
-	if (get_user(status, &cmsg->cm_status)) {
+	if (get_user(status, &hdr->cm_status)) {
 		dprintk("%s: error when copying status from userspace", __func__);
 		return -EFAULT;
 	}
@@ -851,7 +863,7 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	cup = NULL;
 	spin_lock(&cn->cn_lock);
 	list_for_each_entry(tmp, &cn->cn_list, cu_list) {
-		if (get_unaligned(&tmp->cu_msg.cm_xid) == xid) {
+		if (get_unaligned(&tmp->cu_u.cu_hdr.cm_xid) == xid) {
 			cup = tmp;
 			if (status != -EINPROGRESS)
 				list_del_init(&cup->cu_list);
@@ -869,7 +881,7 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	if (status == -EINPROGRESS)
 		return __cld_pipe_inprogress_downcall(cmsg, nn);
 
-	if (copy_from_user(&cup->cu_msg, src, mlen) != 0)
+	if (copy_from_user(&cup->cu_u.cu_msg, src, mlen) != 0)
 		return -EFAULT;
 
 	complete(&cup->cu_done);
@@ -881,7 +893,7 @@ cld_pipe_destroy_msg(struct rpc_pipe_msg *msg)
 {
 	struct cld_msg *cmsg = msg->data;
 	struct cld_upcall *cup = container_of(cmsg, struct cld_upcall,
-						 cu_msg);
+						 cu_u.cu_msg);
 
 	/* errno >= 0 means we got a downcall */
 	if (msg->errno >= 0)
@@ -1012,9 +1024,10 @@ nfsd4_remove_cld_pipe(struct net *net)
 }
 
 static struct cld_upcall *
-alloc_cld_upcall(struct cld_net *cn)
+alloc_cld_upcall(struct nfsd_net *nn)
 {
 	struct cld_upcall *new, *tmp;
+	struct cld_net *cn = nn->cld_net;
 
 	new = kzalloc(sizeof(*new), GFP_KERNEL);
 	if (!new)
@@ -1024,20 +1037,20 @@ alloc_cld_upcall(struct cld_net *cn)
 restart_search:
 	spin_lock(&cn->cn_lock);
 	list_for_each_entry(tmp, &cn->cn_list, cu_list) {
-		if (tmp->cu_msg.cm_xid == cn->cn_xid) {
+		if (tmp->cu_u.cu_msg.cm_xid == cn->cn_xid) {
 			cn->cn_xid++;
 			spin_unlock(&cn->cn_lock);
 			goto restart_search;
 		}
 	}
 	init_completion(&new->cu_done);
-	new->cu_msg.cm_vers = CLD_UPCALL_VERSION;
-	put_unaligned(cn->cn_xid++, &new->cu_msg.cm_xid);
+	new->cu_u.cu_msg.cm_vers = nn->client_tracking_ops->version;
+	put_unaligned(cn->cn_xid++, &new->cu_u.cu_msg.cm_xid);
 	new->cu_net = cn;
 	list_add(&new->cu_list, &cn->cn_list);
 	spin_unlock(&cn->cn_lock);
 
-	dprintk("%s: allocated xid %u\n", __func__, new->cu_msg.cm_xid);
+	dprintk("%s: allocated xid %u\n", __func__, new->cu_u.cu_msg.cm_xid);
 
 	return new;
 }
@@ -1066,20 +1079,20 @@ nfsd4_cld_create(struct nfs4_client *clp)
 	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
 		return;
 
-	cup = alloc_cld_upcall(cn);
+	cup = alloc_cld_upcall(nn);
 	if (!cup) {
 		ret = -ENOMEM;
 		goto out_err;
 	}
 
-	cup->cu_msg.cm_cmd = Cld_Create;
-	cup->cu_msg.cm_u.cm_name.cn_len = clp->cl_name.len;
-	memcpy(cup->cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
+	cup->cu_u.cu_msg.cm_cmd = Cld_Create;
+	cup->cu_u.cu_msg.cm_u.cm_name.cn_len = clp->cl_name.len;
+	memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
 			clp->cl_name.len);
 
-	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_msg);
+	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
 	if (!ret) {
-		ret = cup->cu_msg.cm_status;
+		ret = cup->cu_u.cu_msg.cm_status;
 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
 	}
 
@@ -1103,20 +1116,20 @@ nfsd4_cld_remove(struct nfs4_client *clp)
 	if (!test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
 		return;
 
-	cup = alloc_cld_upcall(cn);
+	cup = alloc_cld_upcall(nn);
 	if (!cup) {
 		ret = -ENOMEM;
 		goto out_err;
 	}
 
-	cup->cu_msg.cm_cmd = Cld_Remove;
-	cup->cu_msg.cm_u.cm_name.cn_len = clp->cl_name.len;
-	memcpy(cup->cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
+	cup->cu_u.cu_msg.cm_cmd = Cld_Remove;
+	cup->cu_u.cu_msg.cm_u.cm_name.cn_len = clp->cl_name.len;
+	memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
 			clp->cl_name.len);
 
-	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_msg);
+	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
 	if (!ret) {
-		ret = cup->cu_msg.cm_status;
+		ret = cup->cu_u.cu_msg.cm_status;
 		clear_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
 	}
 
@@ -1145,21 +1158,21 @@ nfsd4_cld_check_v0(struct nfs4_client *clp)
 	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
 		return 0;
 
-	cup = alloc_cld_upcall(cn);
+	cup = alloc_cld_upcall(nn);
 	if (!cup) {
 		printk(KERN_ERR "NFSD: Unable to check client record on "
 				"stable storage: %d\n", -ENOMEM);
 		return -ENOMEM;
 	}
 
-	cup->cu_msg.cm_cmd = Cld_Check;
-	cup->cu_msg.cm_u.cm_name.cn_len = clp->cl_name.len;
-	memcpy(cup->cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
+	cup->cu_u.cu_msg.cm_cmd = Cld_Check;
+	cup->cu_u.cu_msg.cm_u.cm_name.cn_len = clp->cl_name.len;
+	memcpy(cup->cu_u.cu_msg.cm_u.cm_name.cn_id, clp->cl_name.data,
 			clp->cl_name.len);
 
-	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_msg);
+	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
 	if (!ret) {
-		ret = cup->cu_msg.cm_status;
+		ret = cup->cu_u.cu_msg.cm_status;
 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
 	}
 
@@ -1223,16 +1236,16 @@ nfsd4_cld_grace_start(struct nfsd_net *nn)
 	struct cld_upcall *cup;
 	struct cld_net *cn = nn->cld_net;
 
-	cup = alloc_cld_upcall(cn);
+	cup = alloc_cld_upcall(nn);
 	if (!cup) {
 		ret = -ENOMEM;
 		goto out_err;
 	}
 
-	cup->cu_msg.cm_cmd = Cld_GraceStart;
-	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_msg);
+	cup->cu_u.cu_msg.cm_cmd = Cld_GraceStart;
+	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
 	if (!ret)
-		ret = cup->cu_msg.cm_status;
+		ret = cup->cu_u.cu_msg.cm_status;
 
 	free_cld_upcall(cup);
 out_err:
@@ -1250,17 +1263,17 @@ nfsd4_cld_grace_done_v0(struct nfsd_net *nn)
 	struct cld_upcall *cup;
 	struct cld_net *cn = nn->cld_net;
 
-	cup = alloc_cld_upcall(cn);
+	cup = alloc_cld_upcall(nn);
 	if (!cup) {
 		ret = -ENOMEM;
 		goto out_err;
 	}
 
-	cup->cu_msg.cm_cmd = Cld_GraceDone;
-	cup->cu_msg.cm_u.cm_gracetime = (int64_t)nn->boot_time;
-	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_msg);
+	cup->cu_u.cu_msg.cm_cmd = Cld_GraceDone;
+	cup->cu_u.cu_msg.cm_u.cm_gracetime = (int64_t)nn->boot_time;
+	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
 	if (!ret)
-		ret = cup->cu_msg.cm_status;
+		ret = cup->cu_u.cu_msg.cm_status;
 
 	free_cld_upcall(cup);
 out_err:
@@ -1279,16 +1292,16 @@ nfsd4_cld_grace_done(struct nfsd_net *nn)
 	struct cld_upcall *cup;
 	struct cld_net *cn = nn->cld_net;
 
-	cup = alloc_cld_upcall(cn);
+	cup = alloc_cld_upcall(nn);
 	if (!cup) {
 		ret = -ENOMEM;
 		goto out_err;
 	}
 
-	cup->cu_msg.cm_cmd = Cld_GraceDone;
-	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_msg);
+	cup->cu_u.cu_msg.cm_cmd = Cld_GraceDone;
+	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
 	if (!ret)
-		ret = cup->cu_msg.cm_status;
+		ret = cup->cu_u.cu_msg.cm_status;
 
 	free_cld_upcall(cup);
 out_err:
@@ -1336,6 +1349,50 @@ cld_running(struct nfsd_net *nn)
 	return pipe->nreaders || pipe->nwriters;
 }
 
+static int
+nfsd4_cld_get_version(struct nfsd_net *nn)
+{
+	int ret = 0;
+	struct cld_upcall *cup;
+	struct cld_net *cn = nn->cld_net;
+	uint8_t version;
+
+	cup = alloc_cld_upcall(nn);
+	if (!cup) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+	cup->cu_u.cu_msg.cm_cmd = Cld_GetVersion;
+	ret = cld_pipe_upcall(cn->cn_pipe, &cup->cu_u.cu_msg);
+	if (!ret) {
+		ret = cup->cu_u.cu_msg.cm_status;
+		if (ret)
+			goto out_free;
+		version = cup->cu_u.cu_msg.cm_u.cm_version;
+		dprintk("%s: userspace returned version %u\n",
+				__func__, version);
+		if (version < 1)
+			version = 1;
+		else if (version > CLD_UPCALL_VERSION)
+			version = CLD_UPCALL_VERSION;
+
+		switch (version) {
+		case 1:
+			nn->client_tracking_ops = &nfsd4_cld_tracking_ops;
+			break;
+		default:
+			break;
+		}
+	}
+out_free:
+	free_cld_upcall(cup);
+out_err:
+	if (ret)
+		dprintk("%s: Unable to get version from userspace: %d\n",
+			__func__, ret);
+	return ret;
+}
+
 static int
 nfsd4_cld_tracking_init(struct net *net)
 {
@@ -1368,10 +1425,14 @@ nfsd4_cld_tracking_init(struct net *net)
 		goto err_remove;
 	}
 
+	status = nfsd4_cld_get_version(nn);
+	if (status == -EOPNOTSUPP)
+		pr_warn("NFSD: nfsdcld GetVersion upcall failed. Please upgrade nfsdcld.\n");
+
 	status = nfsd4_cld_grace_start(nn);
 	if (status) {
 		if (status == -EOPNOTSUPP)
-			printk(KERN_WARNING "NFSD: Please upgrade nfsdcld.\n");
+			pr_warn("NFSD: nfsdcld GraceStart upcall failed. Please upgrade nfsdcld.\n");
 		nfs4_release_reclaim(nn);
 		goto err_remove;
 	} else
@@ -1403,6 +1464,8 @@ static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops_v0 = {
 	.remove		= nfsd4_cld_remove,
 	.check		= nfsd4_cld_check_v0,
 	.grace_done	= nfsd4_cld_grace_done_v0,
+	.version	= 1,
+	.msglen		= sizeof(struct cld_msg),
 };
 
 /* For newer nfsdcld's */
@@ -1413,6 +1476,8 @@ static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops = {
 	.remove		= nfsd4_cld_remove,
 	.check		= nfsd4_cld_check,
 	.grace_done	= nfsd4_cld_grace_done,
+	.version	= 1,
+	.msglen		= sizeof(struct cld_msg),
 };
 
 /* upcall via usermodehelper */
@@ -1760,6 +1825,8 @@ static const struct nfsd4_client_tracking_ops nfsd4_umh_tracking_ops = {
 	.remove		= nfsd4_umh_cltrack_remove,
 	.check		= nfsd4_umh_cltrack_check,
 	.grace_done	= nfsd4_umh_cltrack_grace_done,
+	.version	= 1,
+	.msglen		= 0,
 };
 
 int
diff --git a/include/uapi/linux/nfsd/cld.h b/include/uapi/linux/nfsd/cld.h
index b1e9de4f07d5..c5aad16d10c0 100644
--- a/include/uapi/linux/nfsd/cld.h
+++ b/include/uapi/linux/nfsd/cld.h
@@ -36,7 +36,8 @@ enum cld_command {
 	Cld_Remove,		/* remove record of this cm_id */
 	Cld_Check,		/* is this cm_id allowed? */
 	Cld_GraceDone,		/* grace period is complete */
-	Cld_GraceStart,
+	Cld_GraceStart,		/* grace start (upload client records) */
+	Cld_GetVersion,		/* query max supported upcall version */
 };
 
 /* representation of long-form NFSv4 client ID */
@@ -54,7 +55,15 @@ struct cld_msg {
 	union {
 		__s64		cm_gracetime;	/* grace period start time */
 		struct cld_name	cm_name;
+		__u8		cm_version;	/* for getting max version */
 	} __attribute__((packed)) cm_u;
 } __attribute__((packed));
 
+struct cld_msg_hdr {
+	__u8		cm_vers;		/* upcall version */
+	__u8		cm_cmd;			/* upcall command */
+	__s16		cm_status;		/* return code */
+	__u32		cm_xid;			/* transaction id */
+} __attribute__((packed));
+
 #endif /* !_NFSD_CLD_H */
-- 
2.17.2

