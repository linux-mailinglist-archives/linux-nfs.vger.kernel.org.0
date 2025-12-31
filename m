Return-Path: <linux-nfs+bounces-17369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7788DCEB09D
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54CEE301B497
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FED2E22AA;
	Wed, 31 Dec 2025 02:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA66luLV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EFF1FC0EA
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147730; cv=none; b=btoIFWRGH7kpRTogNfnOmSvL0/xIviYYUcvRHiIqrAByFOywd43oiuoqI/vE5TKTGSLBAUkxgFKGuiH19GYDH/NzDSL+UZR7SaF+A87MEKOFFZPeCkO82vL/cliUi1svwjSxQyEOzGVm4/yzDD7frtIumlxXEiOFPCtKs3lFpfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147730; c=relaxed/simple;
	bh=qc0d6VSNSdzAAwtvbPn+TD+95qJwZpN3b+4Q8VBWyMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeZzTbCyp0vELNb70W5xIizWhPUYgEviFMEfKIGeILYZuC69OopQlbDTx6+AfSHdcKX7F8HKbWiOrsM52IwAxfdqxxC8Hlq6edTGu19/KfoCG4yCwdlfS82A65cd3MscxXe1uj/F8Q1XSJpq4cMvwU0f2G8QLLwDJeaVxNQLjJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA66luLV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a102494058so56263105ad.0
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147728; x=1767752528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOQo4bcbrjwkYU8xcs1B28zK0QvhBDdAZ/3McO9fAHc=;
        b=eA66luLVfmttexXurb62ER7LGbOaP4glSSp6YVDUUoL+ll8k57ctVI1Hdh2ox60JSB
         bQ5qC5iQDVB8Ok4B3MIOrwm/D30uF7FLY1yMY198qHRXHT7Sa66p0e9GAso3VY001jSe
         +UaF867Jy64PibCTN9TQOSrfbfMMahGVA8IxXEZcBqrfR/hvFWSiBzPoU4lDidcwXDks
         Q/1w/zOWT3esqds/Ex2L8JkwvWvJG7rBzCvFqY1bp8wxS0HzH6mhdSH3cBiFbfCAV1iG
         ikYMBxzimYjKqvC5VQ7OTLBhZzfY6Qz1W7y0T65OoRypY6t3qwdCK8qGOqa3csiLTObq
         HQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147728; x=1767752528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yOQo4bcbrjwkYU8xcs1B28zK0QvhBDdAZ/3McO9fAHc=;
        b=mNJC/xhtv8QJB6ZAQXECpp9ds0B4rsMDHnyUPrmN5gPBaCaBdA+VwdUoUToH3JeiuH
         drDdWBy7frcLWjLy1/7KVz00tHvdyxfJ4TGmp0spoUQplFBFoiYByzpsP0v3LfqITEX7
         Do3kEn27X1tvHJfZzj/11XndCsjKGfjBLubRV2NSe7/9ordsYATfkUVdHS/Xt0Rdrkk9
         qQbjCWnmbc9RKBX5h6jsNyfKZF1qsNG1uVvXacmHNdFBq0qyMEnoO19tTdU3rOggYO6I
         WkFg0JqOmaPk7Xwx+4CKtnlek3cqVraeTme40UpwkdQ03B3anqFhuaB6Vc0wwAMBcAsd
         kpHA==
X-Gm-Message-State: AOJu0YzY2vdFy0SH/YdjS9aZbH/0pJMxXZ6SylsVGjuGPDs7rD4/lsZ9
	I+KU1GuKfu4XXzVC54WKbnRBk2cjJb3Gr/rOFvIkPXoLIHPbfXEwFCJqzQgusMc=
X-Gm-Gg: AY/fxX4dmLcc1IzBiUY2Ui4+jl/mKMOR+K2lAXBaCyczxsSEl5NkOMBbffZ4dPPQ+xZ
	Xt0pTxNFV+XtLJJPJyrD8pj+aZA7NT3Z9zlqEPuqtg3iAl2sHfeSb+nGWzrDg++GphP1WU92Ia+
	NR0IekqV+UvkIOWsil3m3bLlIwj8sEH2r2s1S47Z80S2x14PInyAif7O+bw2kgfyJslemIlPbNP
	aF/PauxtoeoaKeh4WCbAepiS2bn4BiLZOVleffV48mNr9xKHBFAoniPw5JqtTEzAwyGsfM1/Ldg
	rt6o5OfNZziPsnyCMSxYat3PmwmcW/PHVWS+J8bkZXFr/gDkMf1sUYicsv+Sy6x8G6Bahf9ltCZ
	+JG4N/nQ9XsRddqR9ogS/v7i6g6SAlPqB00t5rHMFs3QRupKYWJri0+YNyfZ1amDC1XoQrkTrpB
	39lKRg9c8LQkr2gphMbgLpRhBGCU5bFw+dVzN4vf62wS9NEJ5LY3bjH98R
X-Google-Smtp-Source: AGHT+IG9Y01rXrOybwePN6D3RdcPrjJ2gh74IHdDiJhVRW5L3cYo8pScO3IWyfL3J1i99IXwyEX4Tw==
X-Received: by 2002:a17:903:1105:b0:2a0:b432:4a6 with SMTP id d9443c01a7336-2a2f0d2db41mr359847185ad.15.1767147728116;
        Tue, 30 Dec 2025 18:22:08 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:07 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 02/17] Add a new function to acquire the POSIX draft ACLs
Date: Tue, 30 Dec 2025 18:21:04 -0800
Message-ID: <20251231022119.1714-3-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251231022119.1714-1-rick.macklem@gmail.com>
References: <20251231022119.1714-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

This patch adds a function called nfsd4_get_posix_acl(),
which acquires the POSIX draft ACLs for a file.  It
acquires a POSIX draft access ACL based on the file's
mode, if no POSIX draft ACL exists for the file.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/acl.h     |  2 ++
 fs/nfsd/nfs4acl.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
index 4b7324458a94..213774cebeeb 100644
--- a/fs/nfsd/acl.h
+++ b/fs/nfsd/acl.h
@@ -47,6 +47,8 @@ __be32 nfs4_acl_write_who(struct xdr_stream *xdr, int who);
 
 int nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 		struct nfs4_acl **acl);
+int nfsd4_get_posix_acl(struct svc_rqst *rqstp, struct dentry *dentry,
+		struct posix_acl **pacl_ret, struct posix_acl **dpacl_ret);
 __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
 			 struct nfsd_attrs *attr);
 
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 936ea1ad9586..0a184b345f8c 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -176,6 +176,39 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
 	return error;
 }
 
+int
+nfsd4_get_posix_acl(struct svc_rqst *rqstp, struct dentry *dentry,
+		struct posix_acl **pacl_ret, struct posix_acl **dpacl_ret)
+{
+	struct inode *inode = d_inode(dentry);
+	int error = 0;
+	struct posix_acl *pacl = NULL, *dpacl = NULL;
+
+	*pacl_ret = NULL;
+	*dpacl_ret = NULL;
+	pacl = get_inode_acl(inode, ACL_TYPE_ACCESS);
+	if (!pacl)
+		pacl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
+
+	if (IS_ERR(pacl))
+		return PTR_ERR(pacl);
+
+	*pacl_ret = pacl;
+
+	if (S_ISDIR(inode->i_mode)) {
+		dpacl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
+		if (IS_ERR(dpacl)) {
+			error = PTR_ERR(dpacl);
+			goto out;
+		}
+
+		*dpacl_ret = dpacl;
+	}
+
+out:
+	return error;
+}
+
 struct posix_acl_summary {
 	unsigned short owner;
 	unsigned short users;
-- 
2.49.0


