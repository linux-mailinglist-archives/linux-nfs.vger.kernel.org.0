Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66DC4A3BEE
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2019 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfH3Q0c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Aug 2019 12:26:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfH3Q0c (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Aug 2019 12:26:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 028D94FCD9;
        Fri, 30 Aug 2019 16:26:32 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C0EF6012C;
        Fri, 30 Aug 2019 16:26:31 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 3C94620AC8; Fri, 30 Aug 2019 12:26:31 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] nfsd: add support for upcall version 2
Date:   Fri, 30 Aug 2019 12:26:31 -0400
Message-Id: <20190830162631.13195-3-smayhew@redhat.com>
In-Reply-To: <20190830162631.13195-1-smayhew@redhat.com>
References: <20190830162631.13195-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 30 Aug 2019 16:26:32 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Version 2 upcalls will allow the nfsd to include the kerberos principal
string (actually the first 1024 bytes of it) in the Cld_Create upcall.
If a principal is present in the svc_cred, then it will be included in
the Cld_Create upcall.  Upon a subsequent restart, the principal will be
returned in the Cld_Gracestart downcall and stored in the
reclaim_str_hashtbl so it can be used when handling reclaim opens.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfsd/nfs4recover.c         | 167 +++++++++++++++++++++++++++++++---
 fs/nfsd/nfs4state.c           |   6 +-
 fs/nfsd/state.h               |   3 +-
 include/uapi/linux/nfsd/cld.h |  26 +++++-
 4 files changed, 185 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 58a61339d40c..682760457368 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -64,6 +64,7 @@ struct nfsd4_client_tracking_ops {
 };
 
 static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops;
+static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops_v2;
 
 /* Globals */
 static char user_recovery_dirname[PATH_MAX] = "/var/lib/nfs/v4recovery";
@@ -177,6 +178,7 @@ __nfsd4_create_reclaim_record_grace(struct nfs4_client *clp,
 		const char *dname, int len, struct nfsd_net *nn)
 {
 	struct xdr_netobj name;
+	struct xdr_netobj princ = { .len = 0, .data = NULL };
 	struct nfs4_client_reclaim *crp;
 
 	name.data = kmemdup(dname, len, GFP_KERNEL);
@@ -186,7 +188,7 @@ __nfsd4_create_reclaim_record_grace(struct nfs4_client *clp,
 		return;
 	}
 	name.len = len;
-	crp = nfs4_client_to_reclaim(name, nn);
+	crp = nfs4_client_to_reclaim(name, princ, nn);
 	if (!crp) {
 		kfree(name.data);
 		return;
@@ -486,6 +488,7 @@ static int
 load_recdir(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
 {
 	struct xdr_netobj name;
+	struct xdr_netobj princ = { .len = 0, .data = NULL };
 
 	if (child->d_name.len != HEXDIR_LEN - 1) {
 		printk("%s: illegal name %pd in recovery directory\n",
@@ -500,7 +503,7 @@ load_recdir(struct dentry *parent, struct dentry *child, struct nfsd_net *nn)
 		goto out;
 	}
 	name.len = HEXDIR_LEN;
-	if (!nfs4_client_to_reclaim(name, nn))
+	if (!nfs4_client_to_reclaim(name, princ, nn))
 		kfree(name.data);
 out:
 	return 0;
@@ -746,6 +749,7 @@ struct cld_upcall {
 	union {
 		struct cld_msg_hdr	 cu_hdr;
 		struct cld_msg		 cu_msg;
+		struct cld_msg_v2	 cu_msg_v2;
 	} cu_u;
 };
 
@@ -792,12 +796,12 @@ cld_pipe_upcall(struct rpc_pipe *pipe, void *cmsg)
 }
 
 static ssize_t
-__cld_pipe_inprogress_downcall(const struct cld_msg __user *cmsg,
+__cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 		struct nfsd_net *nn)
 {
 	uint8_t cmd;
-	struct xdr_netobj name;
-	uint16_t namelen;
+	struct xdr_netobj name, princ = { .len = 0, .data = NULL };
+	uint16_t namelen, princlen;
 	struct cld_net *cn = nn->cld_net;
 
 	if (get_user(cmd, &cmsg->cm_cmd)) {
@@ -805,18 +809,43 @@ __cld_pipe_inprogress_downcall(const struct cld_msg __user *cmsg,
 		return -EFAULT;
 	}
 	if (cmd == Cld_GraceStart) {
-		if (get_user(namelen, &cmsg->cm_u.cm_name.cn_len))
-			return -EFAULT;
-		name.data = memdup_user(&cmsg->cm_u.cm_name.cn_id, namelen);
-		if (IS_ERR_OR_NULL(name.data))
-			return -EFAULT;
-		name.len = namelen;
+		if (nn->client_tracking_ops->version >= 2) {
+			const struct cld_clntinfo __user *ci;
+
+			ci = &cmsg->cm_u.cm_clntinfo;
+			if (get_user(namelen, &ci->cc_name.cn_len))
+				return -EFAULT;
+			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
+			if (IS_ERR_OR_NULL(name.data))
+				return -EFAULT;
+			name.len = namelen;
+			get_user(princlen, &ci->cc_principal.cp_len);
+			if (princlen > 0) {
+				princ.data = memdup_user(
+						&ci->cc_principal.cp_data,
+						princlen);
+				if (IS_ERR_OR_NULL(princ.data))
+					return -EFAULT;
+				princ.len = princlen;
+			} else
+				princ.len = 0;
+		} else {
+			const struct cld_name __user *cnm;
+
+			cnm = &cmsg->cm_u.cm_name;
+			if (get_user(namelen, &cnm->cn_len))
+				return -EFAULT;
+			name.data = memdup_user(&cnm->cn_id, namelen);
+			if (IS_ERR_OR_NULL(name.data))
+				return -EFAULT;
+			name.len = namelen;
+		}
 		if (name.len > 5 && memcmp(name.data, "hash:", 5) == 0) {
 			name.len = name.len - 5;
 			memmove(name.data, name.data + 5, name.len);
 			cn->cn_has_legacy = true;
 		}
-		if (!nfs4_client_to_reclaim(name, nn)) {
+		if (!nfs4_client_to_reclaim(name, princ, nn)) {
 			kfree(name.data);
 			return -EFAULT;
 		}
@@ -830,7 +859,7 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 {
 	struct cld_upcall *tmp, *cup;
 	struct cld_msg_hdr __user *hdr = (struct cld_msg_hdr __user *)src;
-	struct cld_msg __user *cmsg = (struct cld_msg __user *)src;
+	struct cld_msg_v2 __user *cmsg = (struct cld_msg_v2 __user *)src;
 	uint32_t xid;
 	struct nfsd_net *nn = net_generic(file_inode(filp)->i_sb->s_fs_info,
 						nfsd_net_id);
@@ -881,7 +910,7 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	if (status == -EINPROGRESS)
 		return __cld_pipe_inprogress_downcall(cmsg, nn);
 
-	if (copy_from_user(&cup->cu_u.cu_msg, src, mlen) != 0)
+	if (copy_from_user(&cup->cu_u.cu_msg_v2, src, mlen) != 0)
 		return -EFAULT;
 
 	complete(&cup->cu_done);
@@ -1103,6 +1132,54 @@ nfsd4_cld_create(struct nfs4_client *clp)
 				"record on stable storage: %d\n", ret);
 }
 
+/* Ask daemon to create a new record */
+static void
+nfsd4_cld_create_v2(struct nfs4_client *clp)
+{
+	int ret, len;
+	struct cld_upcall *cup;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	struct cld_net *cn = nn->cld_net;
+	struct cld_msg_v2 *cmsg;
+
+	/* Don't upcall if it's already stored */
+	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
+		return;
+
+	cup = alloc_cld_upcall(nn);
+	if (!cup) {
+		ret = -ENOMEM;
+		goto out_err;
+	}
+
+	cmsg = &cup->cu_u.cu_msg_v2;
+	cmsg->cm_cmd = Cld_Create;
+	cmsg->cm_u.cm_clntinfo.cc_name.cn_len = clp->cl_name.len;
+	memcpy(cmsg->cm_u.cm_clntinfo.cc_name.cn_id, clp->cl_name.data,
+			clp->cl_name.len);
+	if (clp->cl_cred.cr_principal) {
+		len = strlen(clp->cl_cred.cr_principal);
+		if (len > NFS4_OPAQUE_LIMIT)
+			len = NFS4_OPAQUE_LIMIT;
+		cmsg->cm_u.cm_clntinfo.cc_principal.cp_len = len;
+		memcpy(cmsg->cm_u.cm_clntinfo.cc_principal.cp_data,
+				clp->cl_cred.cr_principal, len);
+	} else
+		cmsg->cm_u.cm_clntinfo.cc_principal.cp_len = 0;
+
+	ret = cld_pipe_upcall(cn->cn_pipe, cmsg);
+	if (!ret) {
+		ret = cmsg->cm_status;
+		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
+	}
+
+	free_cld_upcall(cup);
+out_err:
+	if (ret)
+		pr_err("NFSD: Unable to create client record on stable storage: %d\n",
+				ret);
+}
+
 /* Ask daemon to create a new record */
 static void
 nfsd4_cld_remove(struct nfs4_client *clp)
@@ -1229,6 +1306,53 @@ nfsd4_cld_check(struct nfs4_client *clp)
 	return 0;
 }
 
+static int
+nfsd4_cld_check_v2(struct nfs4_client *clp)
+{
+	struct nfs4_client_reclaim *crp;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	struct cld_net *cn = nn->cld_net;
+	int status;
+	char dname[HEXDIR_LEN];
+	struct xdr_netobj name;
+
+	/* did we already find that this client is stable? */
+	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
+		return 0;
+
+	/* look for it in the reclaim hashtable otherwise */
+	crp = nfsd4_find_reclaim_client(clp->cl_name, nn);
+	if (crp)
+		goto found;
+
+	if (cn->cn_has_legacy) {
+		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
+		if (status)
+			return -ENOENT;
+
+		name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
+		if (!name.data) {
+			dprintk("%s: failed to allocate memory for name.data\n",
+					__func__);
+			return -ENOENT;
+		}
+		name.len = HEXDIR_LEN;
+		crp = nfsd4_find_reclaim_client(name, nn);
+		kfree(name.data);
+		if (crp)
+			goto found;
+
+	}
+	return -ENOENT;
+found:
+	if (crp->cr_principal.len)
+		if (memcmp(crp->cr_principal.data, clp->cl_cred.cr_principal,
+				crp->cr_principal.len))
+			return -ENOENT;
+	crp->cr_clp = clp;
+	return 0;
+}
+
 static int
 nfsd4_cld_grace_start(struct nfsd_net *nn)
 {
@@ -1380,6 +1504,9 @@ nfsd4_cld_get_version(struct nfsd_net *nn)
 		case 1:
 			nn->client_tracking_ops = &nfsd4_cld_tracking_ops;
 			break;
+		case 2:
+			nn->client_tracking_ops = &nfsd4_cld_tracking_ops_v2;
+			break;
 		default:
 			break;
 		}
@@ -1480,6 +1607,18 @@ static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops = {
 	.msglen		= sizeof(struct cld_msg),
 };
 
+/* v2 create/check ops include the principal, if available */
+static const struct nfsd4_client_tracking_ops nfsd4_cld_tracking_ops_v2 = {
+	.init		= nfsd4_cld_tracking_init,
+	.exit		= nfsd4_cld_tracking_exit,
+	.create		= nfsd4_cld_create_v2,
+	.remove		= nfsd4_cld_remove,
+	.check		= nfsd4_cld_check_v2,
+	.grace_done	= nfsd4_cld_grace_done,
+	.version	= 2,
+	.msglen		= sizeof(struct cld_msg_v2),
+};
+
 /* upcall via usermodehelper */
 static char cltrack_prog[PATH_MAX] = "/sbin/nfsdcltrack";
 module_param_string(cltrack_prog, cltrack_prog, sizeof(cltrack_prog),
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7857942c5ca6..3d2fa7fb079e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6888,7 +6888,8 @@ nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn)
  * will be freed in nfs4_remove_reclaim_record in the normal case).
  */
 struct nfs4_client_reclaim *
-nfs4_client_to_reclaim(struct xdr_netobj name, struct nfsd_net *nn)
+nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princ,
+		struct nfsd_net *nn)
 {
 	unsigned int strhashval;
 	struct nfs4_client_reclaim *crp;
@@ -6901,6 +6902,8 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct nfsd_net *nn)
 		list_add(&crp->cr_strhash, &nn->reclaim_str_hashtbl[strhashval]);
 		crp->cr_name.data = name.data;
 		crp->cr_name.len = name.len;
+		crp->cr_principal.data = princ.data;
+		crp->cr_principal.len = princ.len;
 		crp->cr_clp = NULL;
 		nn->reclaim_str_hashtbl_size++;
 	}
@@ -6912,6 +6915,7 @@ nfs4_remove_reclaim_record(struct nfs4_client_reclaim *crp, struct nfsd_net *nn)
 {
 	list_del(&crp->cr_strhash);
 	kfree(crp->cr_name.data);
+	kfree(crp->cr_principal.data);
 	kfree(crp);
 	nn->reclaim_str_hashtbl_size--;
 }
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 5dbd16946e8e..aac63470164c 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -378,6 +378,7 @@ struct nfs4_client_reclaim {
 	struct list_head	cr_strhash;	/* hash by cr_name */
 	struct nfs4_client	*cr_clp;	/* pointer to associated clp */
 	struct xdr_netobj	cr_name;	/* recovery dir name */
+	struct xdr_netobj	cr_principal;
 };
 
 /* A reasonable value for REPLAY_ISIZE was estimated as follows:  
@@ -645,7 +646,7 @@ extern void nfsd4_shutdown_callback(struct nfs4_client *);
 extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
 extern void nfsd4_prepare_cb_recall(struct nfs4_delegation *dp);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
-							struct nfsd_net *nn);
+				struct xdr_netobj princ, struct nfsd_net *nn);
 extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
 
 struct nfs4_file *find_file(struct knfsd_fh *fh);
diff --git a/include/uapi/linux/nfsd/cld.h b/include/uapi/linux/nfsd/cld.h
index c5aad16d10c0..8d200f0b07d6 100644
--- a/include/uapi/linux/nfsd/cld.h
+++ b/include/uapi/linux/nfsd/cld.h
@@ -26,7 +26,7 @@
 #include <linux/types.h>
 
 /* latest upcall version available */
-#define CLD_UPCALL_VERSION 1
+#define CLD_UPCALL_VERSION 2
 
 /* defined by RFC3530 */
 #define NFS4_OPAQUE_LIMIT 1024
@@ -46,6 +46,17 @@ struct cld_name {
 	unsigned char	cn_id[NFS4_OPAQUE_LIMIT];	/* client-provided */
 } __attribute__((packed));
 
+/* principal of the form servicetype@hostname */
+struct cld_principal {
+	__u16		cp_len;				/* length of cp_data */
+	unsigned char	cp_data[NFS4_OPAQUE_LIMIT];	/* princ from cred */
+} __attribute__((packed));
+
+struct cld_clntinfo {
+	struct cld_name		cc_name;
+	struct cld_principal	cc_principal;
+} __attribute__((packed));
+
 /* message struct for communication with userspace */
 struct cld_msg {
 	__u8		cm_vers;		/* upcall version */
@@ -59,6 +70,19 @@ struct cld_msg {
 	} __attribute__((packed)) cm_u;
 } __attribute__((packed));
 
+/* version 2 message includes the principal */
+struct cld_msg_v2 {
+	__u8		cm_vers;		/* upcall version */
+	__u8		cm_cmd;			/* upcall command */
+	__s16		cm_status;		/* return code */
+	__u32		cm_xid;			/* transaction id */
+	union {
+		struct cld_name	cm_name;
+		__u8		cm_version;	/* for getting max version */
+		struct cld_clntinfo cm_clntinfo; /* name & princ */
+	} __attribute__((packed)) cm_u;
+} __attribute__((packed));
+
 struct cld_msg_hdr {
 	__u8		cm_vers;		/* upcall version */
 	__u8		cm_cmd;			/* upcall command */
-- 
2.17.2

