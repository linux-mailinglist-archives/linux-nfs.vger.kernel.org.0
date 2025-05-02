Return-Path: <linux-nfs+bounces-11386-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8378CAA75CF
	for <lists+linux-nfs@lfdr.de>; Fri,  2 May 2025 17:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471793A7555
	for <lists+linux-nfs@lfdr.de>; Fri,  2 May 2025 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94393254AF2;
	Fri,  2 May 2025 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jkIcWJaF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB984A2B
	for <linux-nfs@vger.kernel.org>; Fri,  2 May 2025 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198968; cv=none; b=hBbYWxVQUcKqtGVvVepmk6ypRgRiZibHFmFRSxIn243Cmmpoz2oYuB80ea7Kc2TVfalKFaayMMF38YJqLoSHSk2rI5da+I6ydt81hTmGIH5X+l94/wHm5HkU6p9QIFVGkjQyAqQIpB8tBIYsCXymgr1HhcMIPgc9lgFmu0pxPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198968; c=relaxed/simple;
	bh=vfmAuAW3RJNYy00H4SGH+VdmMPq4ZZ/PtzHovJikSKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJcAlSGw672uljZilHfKu9J7ymE9umgMYvFqotxAXTRolRw6OswLVghqUmcmmGm8yTy/OMA7r7b7UhSiy6dS2lbXLyYO7nSuSNU71QT2UU97WHpeIlw/KjwxyCXpYmc2jAho9v8ZXhovFcxfKViB9setHjwFHHCvLicmUlLlwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jkIcWJaF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399838db7fso2405203b3a.0
        for <linux-nfs@vger.kernel.org>; Fri, 02 May 2025 08:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1746198965; x=1746803765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1E74FUcQ2JDxIDMxBtVIuaE3LtO2Q07aaQl58OExAFw=;
        b=jkIcWJaFx1vHn6LY4iDzZC9kzd0uzDwmq8pi8/efueS7OSoib7eaSj1LxUAXduroWZ
         F3gVMAHzUpyaF3xD8brGISO9crGaXVBJ4weQ0SSr/I8FP54Ey6AwpGBK+5incTd2G7cR
         iF45pCjv1PH27f82aJHDRBV7t34CL6FibRtTuXgvwulGJJG3KaBQrAfLOqeKnzX9YGvR
         u5bZbp8cGM9VMv3MkHY//V6G2WveGltM6mK95S1nY/GkkJcfwxHp6rTrj9YFcN8PcIwu
         LMRrTKP7HhYb8AduPpM2L4nGS3fDk1StvNPyBF9d+xURSZ6hjPJ560Yp+qoQJX0GjdI4
         NYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198965; x=1746803765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1E74FUcQ2JDxIDMxBtVIuaE3LtO2Q07aaQl58OExAFw=;
        b=bTf8CsJhpBOnfe6ljPnk+gvfDVinim8x7UKUIdtfqK04Vm1PdibtAjwRmOC+cYS9SC
         uclOS+PQ732acIstS9BrCGap4KFUO1dZ7A4RIgKYCr5sitJeeHHTHILABgFeQhPSl/rK
         lx5M7c4lQ0l1ZmjHm+NDzSfDVKMRQwH+T3g6VHYQlW2lkoyIn3oxZuB4xZefEbiaoVpm
         EUgDFQPFKjPE9eM8PIA8+vkUjs4cfnIFbFfPf83JfyKVYrv6Y5Y9FgrSoS79DiQGVyXb
         /Vzmz7xeH0OTsBEsEWqaWOO0y3mWo4Ff131K1b3NdueIWf8c5FUjTtc1Zu1YuiMRPXEt
         q0Sw==
X-Gm-Message-State: AOJu0YzV4zmw0tPrW/BKCe7GwVVNS1JA0VCTTRFilMOEa9To5r/96GWe
	vnOl5vdQayGG1yyfepWrQO8GWKsvTbqO4IaL7F2A5x+Fp/hVCEKzCZy8n+58lHst/7j9WiKlR7T
	N
X-Gm-Gg: ASbGncuGA4hBVhZUO12abSEDebN4Z5+kRRI72KnFvvU8p+oUZr7Ax6sjnEdGGCesXNI
	d7EBoXVW014ia9scUoXom9p1vkjE0jIyrxdybZqnlrMwHBoWcQ0wjw+9s+QE7HDl1FExaMMoQ3O
	u/jzgcdWI777qeuB9L638MuIn8Xwd374GHjleUP2kgi7Hh8IqTmN6jZwobC/dH+UhEXPGFcLoir
	YCPrBplzOhlEdZ3CcqAvqqRJEHqLeeyExk9Fdo3uP40HpzEKQ5fze7mTKZC2dwHeOpsZSp6MHnw
	4VpR/5/TyW3HxRyMeG6wsCf+b6iK+0dkH3z6vE/4/lTz7g4UacYVNtAaLnyHXCMRTZFEzxuS6Bz
	kPNIEWFZYLg==
X-Google-Smtp-Source: AGHT+IH5xJkDR2uXENBNwFL3hOOD28ct2B5XSlxlYkI7XAABf4NRak/vDJfIy8aYaDRRvK9P8LBT7Q==
X-Received: by 2002:a05:6a00:8c01:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-74057afb16amr5404525b3a.3.1746198965507;
        Fri, 02 May 2025 08:16:05 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590a463fsm1738714b3a.173.2025.05.02.08.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:16:05 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH] NFSv4: Always set NLINK even if the server doesn't support it
Date: Fri,  2 May 2025 23:15:44 +0800
Message-ID: <20250502151544.76653-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fattr4_numlinks is a recommended attribute, so the client should emulate
it even if the server doesn't support it. In decode_attr_nlink function
in nfs4xdr.c, nlink is initialized to 1. However, this default value
isn't set to the inode due to the check in nfs_fhget.

So if the server doesn't support numlinks, inode's nlink will be zero,
the mount will fail with error "Stale file handle". Change the check in
nfs_fhget so that the nlink value is always set.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 fs/nfs/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 119e447758b9..c19f135b5041 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -553,10 +553,11 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			inode->i_size = nfs_size_to_loff_t(fattr->size);
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_SIZE);
-		if (fattr->valid & NFS_ATTR_FATTR_NLINK)
-			set_nlink(inode, fattr->nlink);
-		else if (fattr_supported & NFS_ATTR_FATTR_NLINK)
+		if (!(fattr->valid & NFS_ATTR_FATTR_NLINK) &&
+			   fattr_supported & NFS_ATTR_FATTR_NLINK)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
+		else
+			set_nlink(inode, fattr->nlink);
 		if (fattr->valid & NFS_ATTR_FATTR_OWNER)
 			inode->i_uid = fattr->uid;
 		else if (fattr_supported & NFS_ATTR_FATTR_OWNER)
-- 
2.48.1


