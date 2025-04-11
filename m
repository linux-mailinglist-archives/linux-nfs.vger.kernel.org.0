Return-Path: <linux-nfs+bounces-11118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2930CA866F1
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 22:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340BA8C17C4
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D53283C97;
	Fri, 11 Apr 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kkvjskun"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AB221D98
	for <linux-nfs@vger.kernel.org>; Fri, 11 Apr 2025 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744402582; cv=none; b=mTXj3a1P5wP/hkzhE469AGZNwvxQG+s2lvqVR9v4tLphl5e7oVop5tcvqtwJtUFJpvythyh+QaCgRXBWQgTiKv0YtVcaI5YcU5J3VhODql2w6joLMD826ekAAyJCMcKzfd6apnBnPv/suj569e0rHKgWzx47G39PSRLl0wkmmc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744402582; c=relaxed/simple;
	bh=QmvUMiCsUu0o8dnUYlVByV+18u7ZbPaUqBZVKmkVp60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3roy1rGdLC+DQZTE/XHAZwxgWP/o1BS62P1im/ygnInW7wFu2pYElMphg0URUPWzcnGBqjV9zGKVIFdrubYlCjddeFIgPlwVajT6d1XMp2XgHDuVVRd6oIEWzTSNPpVJsj6b6a770aLr+wbhvDZ5lRUux0/39tqVXOCjG3WOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kkvjskun; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744402578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vL7JRGklwQ3uLxAbxwFXOOsc1w9C2IACwJQU/ZGeUjU=;
	b=KkvjskunmSQJVT6/aDhuZ9onRCRj9ZZlFKFMyp6p1QN4dVyvXfk7KgRCO66R9zoAOeXvcV
	Q01VO/zgmpqClj6WD43Z4ZhJk0fOaq+1ZKjswoNzd+iQh/YItyLuebzjgKVwsQxTbKTvSY
	A4iqkUgjUFAbrc4LOQLh5T7LLprzO6A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-Sn1dNwRVMJedqZJ9T3jmvQ-1; Fri,
 11 Apr 2025 16:16:16 -0400
X-MC-Unique: Sn1dNwRVMJedqZJ9T3jmvQ-1
X-Mimecast-MFC-AGG-ID: Sn1dNwRVMJedqZJ9T3jmvQ_1744402574
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEBF2180025B;
	Fri, 11 Apr 2025 20:16:14 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.98])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AF391956094;
	Fri, 11 Apr 2025 20:16:14 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id A8EB333FF69;
	Fri, 11 Apr 2025 16:16:12 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: xattr handlers should check for absent nfs filehandles
Date: Fri, 11 Apr 2025 16:16:12 -0400
Message-ID: <20250411201612.2993634-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The nfs inodes for referral anchors that have not yet been followed have
their filehandles zeroed out.

Attempting to call getxattr() on one of these will cause the nfs client
to send a GETATTR to the nfs server with the preceding PUTFH sans
filehandle.  The server will reply NFS4ERR_NOFILEHANDLE, leading to -EIO
being returned to the application.

For example:

$ strace -e trace=getxattr getfattr -n system.nfs4_acl /mnt/t/ref
getxattr("/mnt/t/ref", "system.nfs4_acl", NULL, 0) = -1 EIO (Input/output error)
/mnt/t/ref: system.nfs4_acl: Input/output error
+++ exited with 1 +++

Have the xattr handlers return -ENODATA instead.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/nfs4proc.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 970f28dbf253..a01592930370 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7933,6 +7933,11 @@ static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
 				   const char *key, const void *buf,
 				   size_t buflen, int flags)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
+
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_ACL);
 }
 
@@ -7940,11 +7945,21 @@ static int nfs4_xattr_get_nfs4_acl(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
 				   const char *key, void *buf, size_t buflen)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
+
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_ACL);
 }
 
 static bool nfs4_xattr_list_nfs4_acl(struct dentry *dentry)
 {
+	struct nfs_fh *fh = NFS_FH(d_inode(dentry));
+
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_ACL);
 }
 
@@ -7957,6 +7972,11 @@ static int nfs4_xattr_set_nfs4_dacl(const struct xattr_handler *handler,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
+
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_DACL);
 }
 
@@ -7964,11 +7984,21 @@ static int nfs4_xattr_get_nfs4_dacl(const struct xattr_handler *handler,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, void *buf, size_t buflen)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
+
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_DACL);
 }
 
 static bool nfs4_xattr_list_nfs4_dacl(struct dentry *dentry)
 {
+	struct nfs_fh *fh = NFS_FH(d_inode(dentry));
+
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_DACL);
 }
 
@@ -7980,6 +8010,11 @@ static int nfs4_xattr_set_nfs4_sacl(const struct xattr_handler *handler,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
+
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	return nfs4_proc_set_acl(inode, buf, buflen, NFS4ACL_SACL);
 }
 
@@ -7987,11 +8022,21 @@ static int nfs4_xattr_get_nfs4_sacl(const struct xattr_handler *handler,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, void *buf, size_t buflen)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
+
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	return nfs4_proc_get_acl(inode, buf, buflen, NFS4ACL_SACL);
 }
 
 static bool nfs4_xattr_list_nfs4_sacl(struct dentry *dentry)
 {
+	struct nfs_fh *fh = NFS_FH(d_inode(dentry));
+
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_SACL);
 }
 
@@ -8005,6 +8050,11 @@ static int nfs4_xattr_set_nfs4_label(const struct xattr_handler *handler,
 				     const char *key, const void *buf,
 				     size_t buflen, int flags)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
+
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	if (security_ismaclabel(key))
 		return nfs4_set_security_label(inode, buf, buflen);
 
@@ -8015,6 +8065,11 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
 				     struct dentry *unused, struct inode *inode,
 				     const char *key, void *buf, size_t buflen)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
+
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	if (security_ismaclabel(key))
 		return nfs4_get_security_label(inode, buf, buflen);
 	return -EOPNOTSUPP;
@@ -8023,8 +8078,12 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
 static ssize_t
 nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
 	int len = 0;
 
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
 		len = security_inode_listsecurity(inode, list, list_len);
 		if (len >= 0 && list_len && len > list_len)
@@ -8056,9 +8115,13 @@ static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
 	u32 mask;
 	int ret;
 
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
 		return -EOPNOTSUPP;
 
@@ -8093,9 +8156,13 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, void *buf, size_t buflen)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
 	u32 mask;
 	ssize_t ret;
 
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
 		return -EOPNOTSUPP;
 
@@ -8120,6 +8187,7 @@ static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
 static ssize_t
 nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
 {
+	struct nfs_fh *fh = NFS_FH(inode);
 	u64 cookie;
 	bool eof;
 	ssize_t ret, size;
@@ -8127,6 +8195,9 @@ nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
 	size_t buflen;
 	u32 mask;
 
+	if (unlikely(fh->size == 0))
+		return -ENODATA;
+
 	if (!nfs_server_capable(inode, NFS_CAP_XATTR))
 		return 0;
 
-- 
2.48.1


