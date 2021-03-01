Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16D132823C
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhCAPTP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:19:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237156AbhCAPS7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:18:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2580264DF5
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:18:44 +0000 (UTC)
Subject: [PATCH v1 34/42] NFSD: Add an xdr_stream-based encoder for NFSv2/3
 ACLs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:18:43 -0500
Message-ID: <161461192343.8508.18061557905904664325.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs_common/nfsacl.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nfsacl.h |    3 ++
 2 files changed, 74 insertions(+)

diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
index 79c563c1a5e8..5a5bd85d08f8 100644
--- a/fs/nfs_common/nfsacl.c
+++ b/fs/nfs_common/nfsacl.c
@@ -136,6 +136,77 @@ int nfsacl_encode(struct xdr_buf *buf, unsigned int base, struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(nfsacl_encode);
 
+/**
+ * nfs_stream_encode_acl - Encode an NFSv3 ACL
+ *
+ * @xdr: an xdr_stream positioned to receive an encoded ACL
+ * @inode: inode of file whose ACL this is
+ * @acl: posix_acl to encode
+ * @encode_entries: whether to encode ACEs as well
+ * @typeflag: ACL type: NFS_ACL_DEFAULT or zero
+ *
+ * Return values:
+ *   %false: The ACL could not be encoded
+ *   %true: @xdr is advanced to the next available position
+ */
+bool nfs_stream_encode_acl(struct xdr_stream *xdr, struct inode *inode,
+			   struct posix_acl *acl, int encode_entries,
+			   int typeflag)
+{
+	const size_t elem_size = XDR_UNIT * 3;
+	u32 entries = (acl && acl->a_count) ? max_t(int, acl->a_count, 4) : 0;
+	struct nfsacl_encode_desc nfsacl_desc = {
+		.desc = {
+			.elem_size = elem_size,
+			.array_len = encode_entries ? entries : 0,
+			.xcode = xdr_nfsace_encode,
+		},
+		.acl = acl,
+		.typeflag = typeflag,
+		.uid = inode->i_uid,
+		.gid = inode->i_gid,
+	};
+	struct nfsacl_simple_acl aclbuf;
+	unsigned int base;
+	int err;
+
+	if (entries > NFS_ACL_MAX_ENTRIES)
+		return false;
+	if (xdr_stream_encode_u32(xdr, entries) < 0)
+		return false;
+
+	if (encode_entries && acl && acl->a_count == 3) {
+		struct posix_acl *acl2 = &aclbuf.acl;
+
+		/* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
+		 * invoked in contexts where a memory allocation failure is
+		 * fatal.  Fortunately this fake ACL is small enough to
+		 * construct on the stack. */
+		posix_acl_init(acl2, 4);
+
+		/* Insert entries in canonical order: other orders seem
+		 to confuse Solaris VxFS. */
+		acl2->a_entries[0] = acl->a_entries[0];  /* ACL_USER_OBJ */
+		acl2->a_entries[1] = acl->a_entries[1];  /* ACL_GROUP_OBJ */
+		acl2->a_entries[2] = acl->a_entries[1];  /* ACL_MASK */
+		acl2->a_entries[2].e_tag = ACL_MASK;
+		acl2->a_entries[3] = acl->a_entries[2];  /* ACL_OTHER */
+		nfsacl_desc.acl = acl2;
+	}
+
+	base = xdr_stream_pos(xdr);
+	if (!xdr_reserve_space(xdr, XDR_UNIT +
+			       elem_size * nfsacl_desc.desc.array_len))
+		return false;
+	err = xdr_encode_array2(xdr->buf, base, &nfsacl_desc.desc);
+	if (err)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(nfs_stream_encode_acl);
+
+
 struct nfsacl_decode_desc {
 	struct xdr_array2_desc desc;
 	unsigned int count;
diff --git a/include/linux/nfsacl.h b/include/linux/nfsacl.h
index 0ba99c513649..8e76a79cdc6a 100644
--- a/include/linux/nfsacl.h
+++ b/include/linux/nfsacl.h
@@ -41,5 +41,8 @@ nfsacl_decode(struct xdr_buf *buf, unsigned int base, unsigned int *aclcnt,
 extern bool
 nfs_stream_decode_acl(struct xdr_stream *xdr, unsigned int *aclcnt,
 		      struct posix_acl **pacl);
+extern bool
+nfs_stream_encode_acl(struct xdr_stream *xdr, struct inode *inode,
+		      struct posix_acl *acl, int encode_entries, int typeflag);
 
 #endif  /* __LINUX_NFSACL_H */


