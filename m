Return-Path: <linux-nfs+bounces-17426-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF155CF0718
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 00:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85467300768B
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 23:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29C1FC0EF;
	Sat,  3 Jan 2026 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGtY3Q0I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE02750ED
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767483687; cv=none; b=u0RgDY3bcWlTKzLf5Els+wvtD27ghAT3u1lanXAshL2q3n3mCn4md2j7hLHSxZgbwrjQS/IfQBCku4+HNTCtUpVF1abeFUemBJ7D7CYrG90CsaVZ2WwyEEFtqXA0obRz553y43KdlcZRtldMJ7c9Ki0fEjQWCXMlFBLXb8757WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767483687; c=relaxed/simple;
	bh=mEMBWygtr6WdFEBmjRpo9TJgtSC0J5NMX35i6LkpUk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCjBiJI/eFbU+X1lfy3Hh9ztgDdYtz8edArMYdLiX7QyIxdZsHaux+jjh8hYxxAbtbEe8MhwDdru+tVAtDDPhctOlZhDVZbOr9feb8t2PFeQYH6AFzpYOb22Nzoj1kiT5uS9kDNft4zN62hh7O0PP+jy+IaSRrApR+OxyJkW7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGtY3Q0I; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0d67f1877so171098505ad.2
        for <linux-nfs@vger.kernel.org>; Sat, 03 Jan 2026 15:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767483685; x=1768088485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuT0OcjnS2ZfUPe5L6WcwGtANW1drcrT140zBccaCG8=;
        b=kGtY3Q0I3JGUmn+Cm6hc6bV3xP8VlG43ulxP8N5EjIlVEjR+atFYQieRbOgKVeBevR
         JTRMq5FWGu2GBufqjGVDxQYU3h/8RNGr2P9YFjUznJHDoElzluE52EFGQ1FmoVQw1bMr
         UtXV9D7G4qKD5tK7/TwdaZoUp50AVDWhvMZ61te8tJF5i1707VVtLD8lTJDekkELf/NL
         dGS9e0Y2hFqGwPm72YmBR5CW+Z2YnRUOrfa8F0XGkdO9LQFP0SNUU+ZpGmbJq6OIL2qq
         EyHxaUizyfE6HWnutjUFIU4PV6X3QA43zdgcwjoTk4+hUqurutsJL9vlq6xYz3tyokUc
         AxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767483685; x=1768088485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuT0OcjnS2ZfUPe5L6WcwGtANW1drcrT140zBccaCG8=;
        b=Vt+zWaPAXb3V+KQrWM9VgJBPeGN7hng43jg8e13zyKU0KpUR0+cG5FVaz1GVQCSzjD
         XBNDz1TkuAEr9KzXRLbxTTsBFpZPajsOg9Tgu7HI7QmSIa9ErCpLsjdLDGl5iuyiteUy
         dTxBkOrZO+yoXq2FemyDMm0Sx4xeZTMP2GBS5IAf+Pr58XVCwRtPI1DJmaSfOXef9qfz
         j2mUKPwkhHQgn+bp9DYDPdfZZhE7Vez5aewWqfNtKrw8YDLQQ5f9+ODaky/6s/31XMHr
         V3AGzgjA+8pNwGXI1Iikg2NB1NOvfJvf0VDVxKUcr27iayMpgoeT+kMO+vlvvTs6fePB
         FdYg==
X-Gm-Message-State: AOJu0YyJOim7PoavIPC9NMbUokYQhS3RDlir7oWcGEsK9cPnucQhdiBC
	ATEKLUAdzBPBEJ0R0fODhYY09LSDw8qfxMM3Md7ahJPVxo2V9K5TGyLjU1c5pMg=
X-Gm-Gg: AY/fxX5GMw0FqJffiYk8G9jdZpLOzm7pbBFEbVQuBlFaMxZ1wVpcsCb9soto37uSLIE
	HTirGvMRXzpwL6ezVspKkjgXs4G6g2DXMO7dx7IxqePuq6osEzc/lzdad7p9iqw7nxE9ineAIUw
	0+O75dKTexbsDmY+uHPFxJtePCgvE+Xd0/VxCwAuqUHFxFi4lZ1qRBngKTEtF6SyNi50csRC0DG
	p+FuH1qS1XxOvCxjYDOodnP+/cyJLISRNCsInqB8lt2/8W44o1H2vtmDrNnlplVcBoMLStkebWc
	e4jSXjj3AN++ndiAmLuzZUWp40QAvcobCn4vEEOKQ/Tz6v8EZdXnVm17dCAeKjWoW7s52JM0acS
	RZdfnw3j1s6v7+Ujv/I3VszhVUk1U3ZNJSJTQaeK4YGpPpK2vxn/NHQFt/ssZXSR19cfxnGviV3
	GyIh7wGPNiRvsoQkHkJWTQRfC5NR0eVj2YbWXHMod/NXiuxHvotkEixwS4
X-Google-Smtp-Source: AGHT+IFmFOeZsl7hE24dO9GTRDoY7vKJV0lWT0SukG1yX1BVGXsQrdY1cg77OwQmo43t13OsYkpBAQ==
X-Received: by 2002:a17:902:e552:b0:2a0:8360:3a74 with SMTP id d9443c01a7336-2a2f2835cfdmr326106765ad.51.1767483684957;
        Sat, 03 Jan 2026 15:41:24 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c5307c7sm38472577a12.28.2026.01.03.15.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 15:41:24 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 3/8] Add new entries for handling POSIX draft ACLs
Date: Sat,  3 Jan 2026 15:40:27 -0800
Message-ID: <20260103234033.1256-4-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260103234033.1256-1-rick.macklem@gmail.com>
References: <20260103234033.1256-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Add structures and definitions for the handling
of POSIX draft ACLs for the NFS client.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 include/linux/nfs_xdr.h | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 79fe2dfb470f..e787de158fd9 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1622,6 +1622,54 @@ struct nfs42_removexattrres {
 	struct nfs4_change_info		cinfo;
 };
 
+struct nfs42_getposixaclargs {
+	struct nfs4_sequence_args 	seq_args;
+	struct nfs_fh *			fh;
+	int				mask;
+	struct page **			pages;
+};
+
+struct nfs42_getposixaclres {
+	struct nfs4_sequence_res	seq_res;
+	const struct nfs_server *	server;
+	int				mask;
+	unsigned int			acl_access_count;
+	unsigned int			acl_default_count;
+	struct posix_acl *		acl_access;
+	struct posix_acl *		acl_default;
+};
+
+struct nfs42_setposixaclargs {
+	struct nfs4_sequence_args 	seq_args;
+	struct nfs_fh *			fh;
+	const struct nfs_server *	server;
+	struct inode *			inode;
+	int				mask;
+	struct posix_acl *		acl_access;
+	struct posix_acl *		acl_default;
+	size_t				len;
+	struct page **			pages;
+};
+
+struct nfs42_setposixaclres {
+	struct nfs4_sequence_res	seq_res;
+	const struct nfs_server *	server;
+};
+
+/*
+ * An NFSv4.2 POSIX draft ACL consists of:
+ * - an ACE cnt
+ * - 4 basic ACEs, which usually have a who string of 0 length
+ * - additional ACEs with who strings of up to IDMAP_NAMESZ
+ * - the above are 4byte quantities.
+ * All of the above is multiplied by 2, for the case where a directory
+ * has both a default and access ACL.
+ */
+#define	NFS4_ACL_INLINE_BUFSIZE	(2*(((1+NFS_ACL_MAX_ENTRIES_INLINE*3)*4)+	\
+				 (NFS_ACL_MAX_ENTRIES_INLINE-4)*IDMAP_NAMESZ))
+#define NFS4_ACL_MAXPAGES	(((2*(4+(3*4+IDMAP_NAMESZ)*			\
+				 NFS_ACL_MAX_ENTRIES))+PAGE_SIZE-1)>>PAGE_SHIFT)
+
 #endif /* CONFIG_NFS_V4_2 */
 
 struct nfs_page;
@@ -1765,6 +1813,15 @@ struct nfs_renamedata {
 	bool cancelled;
 };
 
+struct nfs_xdr_putpage_desc {
+	struct page	**pages;
+	void		*p;
+	void		*endp;
+	size_t		npages;
+	size_t		page_pos;
+	size_t		max_npages;
+};
+
 struct nfs_access_entry;
 struct nfs_client;
 struct rpc_timeout;
-- 
2.49.0


