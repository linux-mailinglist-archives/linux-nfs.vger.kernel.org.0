Return-Path: <linux-nfs+bounces-17381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C70DCEB0C7
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2303F3028FFD
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2EE83A14;
	Wed, 31 Dec 2025 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1fU/KMa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F92D7DCE
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147756; cv=none; b=awdXkWjp6Hz4LgdbLIHEd+ERQ6gF4lpyKQ5vhmw692RbC1SddbxtSvJK+bm5WnEbjIiPv05Ar6IKPHE5pnwGwud1O0BPwImDR0Rp84ukzpLgu2Wslg9Grbkg2eWxkYY6zVqydvvn0svOxpJIBbp4CfP+GMnanNnqd5pc3RRM2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147756; c=relaxed/simple;
	bh=cJ424lW/3BTBmS55dcm/MkbRE3SQjwNTiHRzh3q2Hu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUYxzaq13VwQFYIth6JLwgUgAWDOaQAIj97XrvtEs8cw/N0T/kD7No6d1JKvBYsFZBQiKnlTqh+fbLWWo/kS2+VYTY0j6RhqGlFsJR9bXPVCj2WI2PyFB7rS3nu/FqrAmaL1lCCtG/lpHhITOBwfhxVSMQQ8AI5TpOD/xXhvYcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1fU/KMa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b75e366866so4688417b3a.2
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147754; x=1767752554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzwuZhyYo5IBk/GnTgwuGLeHOj2/ZAEaelCwCwMgsZ4=;
        b=G1fU/KMayEMnXjzGZHIR/WGtkiA58uxnY+LDVqqWgWiJHZDkniAp/0tNUHNrvp328D
         Y011SGdmOqNxIzlBigu6BwbWP1GPc7/PuTYMxIGhLFi9qw3UnIQPSSf1n/+iAaJlSUGp
         j3FyOGAdhyqnCYEMh6T+znSqPz9rUO6DyM9m7dRPUfCmzGAom8m2I5uvlXIp1kdFwQ5e
         90x+jm57P9BxBe6aXFn+PFRxmgLLCNUFOenvoRkIGLAEEI+B0bCRI1aYjV3Wlw8WPL4q
         UyuOodrt9A6kYhztirnUgvmNyNmDZqG0j8o4MuDhnFobvcacKpcxe+FmzjxuHbl4gOdE
         BpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147754; x=1767752554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzwuZhyYo5IBk/GnTgwuGLeHOj2/ZAEaelCwCwMgsZ4=;
        b=gY8VtgUepOxilE0jMmAjlacYBqJ5mu0wBdgfXsRdPNFNshdi1XDkIybk9z+k3Um4Xn
         JQxqZ2d1vp9kia2U4j+0FSi30X0/vYnXJfNjY3Twy54MpOUY5tEnE2ktJL7cXInxAvu2
         M4rXxZ/taTORou6nDgbI7laQsgpOVsMKPyb181zY4fvaKh+xKDdc/fwoBxgtZdFVSa0u
         vrRd7EKwqL7c8N30xPniJiUm/KsQQD3Q2x5HnC6cag0Ra6VVL8Omx4DS3eEAJHcp2N07
         i6LXbUVmQiRZ0zKnXcGItvjO917KHdt4F0Zq4HMjhOuGavUZHifSF2Z+X30XQcl16B62
         t3mA==
X-Gm-Message-State: AOJu0YzBfabhvx4bop6mnZ7HZzCBPMMDHmqbdyNBga/XmOOiZRUR4xtO
	BJA3y9K1MguazEmUh18yhFZf22W45AVUj3Gj9IhSL7GES6aKw/hOD1WRZDDuAS8=
X-Gm-Gg: AY/fxX62HGjwmneECnVmRW5FISDEJlBKiRTcf/zg+ike+YDruOny9N++nJdYNxUIj74
	1GL9aU0lK+3+xD33Op1j7KDXVbXeOvQzLDLCRLQ/hiJu0LHxU6ojgBgAyAgjR/uiGu7IYx0Eqw2
	HreVG5YB/jTaGmtZx33tPDnUqmtQ1p0JL/R5BkWpACs4wIi7TFd2D8WkPyKOgdVKo9at8K/iybF
	hjya9FPwmJraXNoaM/SlYUq7IPC6pDeBR0HEMsuVS6K158dD03I8Mop8uBoUvmWFtxgn6HypDVH
	oRNkksOf6CpiK23vMdFvQCNfsNWiom0RkADamTHUvDqJYkPVb6YSi/FBy5VX8pzEhNNZZiN0QMd
	ORGJmYCOV3qYQFTOf1ZgjYRVl+lukeHRi4NUyhfqHNq4S5IUE/sxPrxZNJJt1oOSDGEjJ1a88EU
	XFdi0LwgvuC5VvpCfYCsXmEbYdzct/i1q+aUzA9O+VTVLg1AxunbjODjJF
X-Google-Smtp-Source: AGHT+IEf9AxpynuHbm8ReMk8fHHAWMpEbJZbOJu9EPgWsnZJiBmBy9ToOdmVraCW8lgJqrmVK4uXLw==
X-Received: by 2002:a05:6a00:4396:b0:7e8:43f5:bd4f with SMTP id d2e1a72fcca58-7ff676624b7mr30254708b3a.59.1767147754180;
        Tue, 30 Dec 2025 18:22:34 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:33 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 14/17] Fix handling of zero length ACLs for file creation
Date: Tue, 30 Dec 2025 18:21:16 -0800
Message-ID: <20251231022119.1714-15-rick.macklem@gmail.com>
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

Although it seems unlikely that a NFSv4.2 client would
specify deletion of an ACL for file object creation,
this patch applies the changes needed to support that
for a POSIX draft default ACL.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/vfs.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 146483bf8a65..c884c3f34afb 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -596,15 +596,35 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attr->na_seclabel && attr->na_seclabel->len)
 		attr->na_labelerr = security_inode_setsecctx(dentry,
 			attr->na_seclabel->data, attr->na_seclabel->len);
-	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl)
-		attr->na_paclerr = set_posix_acl(&nop_mnt_idmap,
-						dentry, ACL_TYPE_ACCESS,
-						attr->na_pacl);
-	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) &&
-				attr->na_dpacl && S_ISDIR(inode->i_mode))
-		attr->na_dpaclerr = set_posix_acl(&nop_mnt_idmap,
+	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_dpacl) {
+		if (!S_ISDIR(inode->i_mode))
+			attr->na_dpaclerr = -EINVAL;
+		else if (attr->na_dpacl->a_count > 0)
+			/* a_count == 0 means delete the ACL. */
+			attr->na_dpaclerr = set_posix_acl(&nop_mnt_idmap,
 						dentry, ACL_TYPE_DEFAULT,
 						attr->na_dpacl);
+		else
+			attr->na_dpaclerr = set_posix_acl(&nop_mnt_idmap,
+						dentry, ACL_TYPE_DEFAULT,
+						NULL);
+	}
+	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && attr->na_pacl) {
+		/*
+		 * For any file system that is not ACL_SCOPE_FILE_OBJECT,
+		 * a_count == 0 MUST reply nfserr_inval.
+		 * For a file system that is ACL_SCOPE_FILE_OBJECT,
+		 * a_count == 0 deletes the ACL.
+		 * XXX File systems that are ACL_SCOPE_FILE_OBJECT
+		 * are not yet supported.
+		 */
+		if (attr->na_pacl->a_count > 0)
+			attr->na_paclerr = set_posix_acl(&nop_mnt_idmap,
+							dentry, ACL_TYPE_ACCESS,
+							attr->na_pacl);
+		else
+			attr->na_paclerr = -EINVAL;
+	}
 out_fill_attrs:
 	/*
 	 * RFC 1813 Section 3.3.2 does not mandate that an NFS server
-- 
2.49.0


