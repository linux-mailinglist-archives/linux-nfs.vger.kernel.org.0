Return-Path: <linux-nfs+bounces-3727-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE36690630C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94231C22389
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2511D559;
	Thu, 13 Jun 2024 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no0IaaDE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88590132804
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252278; cv=none; b=fJXN6S24lnhLpXv2WimRwLiYXMnGGQD7j+3dgyv3YDcEVlhswk7+4Znp4qZGi/LzpeKbvHfiEW5yHscP/pSJHihqiZAkHBgMoV7akiCp1h960gMsw48VO7HhR2oMKlbaB2ddJb/B5wQUJxGk62uqqJqsXDrTKpAvGe5PlnXM0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252278; c=relaxed/simple;
	bh=1LBPvvtlZHa28WUHRVA0vfG2pidThOG2IpXVIh2sJqY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCgMKNKmhHeoZrLo+hKy98FGbSWMPmh8NWNvYzI3mSRMvDKB9yPTF87rXE4jCjpCwMxFK+lyyitShl5F0HfyPQL/HTj3hkVzk/sFjiPxadlDVHfv3q4z7kKXFc0HPoSjC/VEKjyvHwo77oDbLEebORc+IsfkdidfMRK2Ej/MhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no0IaaDE; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-440952018fbso3368211cf.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252275; x=1718857075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkH9pFmPV9zL+4pS1VYWpD/UMwAp9PQpyY7aL9EgcMg=;
        b=no0IaaDEnJtyDb5I6DE1m9sr6roF5yUszc+aDsd5lgZBkOwBsUvMfBNQrETsaaYfFI
         uNVMeB59tvyaMB1lLWpPyA/7MK7EXHHkXqC6vThF6vgOz6bzNkAhRnVWYfymk0ZdmfKD
         7zkrwjyyyOOtp/h2EhxmnFY4gI0UFSZjl3OKhLO/Nm8SL4cPzJR7Ehzpb5fEHuPICnwG
         rFQZrlk6tgQQuIPq/GzVLUaeZxbcsDIaKKUqTSsTsKcl2kR9VcxRw/yIOlw/Y4KPQnlY
         mA1OY8r5pinSjfAxZlKDvDD6jGHcstj03xP4qiaXvsyymo936Ssg9/SldBxxyRsqEXlY
         Akvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252275; x=1718857075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkH9pFmPV9zL+4pS1VYWpD/UMwAp9PQpyY7aL9EgcMg=;
        b=la2B+QhtgahZ/XlxSpF2Ov5VT0zsMcNTe7LomnszXniTOvx4TGpyXHSCMqFbRhqjYu
         Byd188ZvRUQyZNaMjh/c7EOPJMIlOyZ0lw09DqFK5KKkw6o6QD186zhxy0O4DxdIjJ4d
         0RhfVr/kT85RIRvXWgGa9xUkM3OzVL4M2VNlltbYQSXHT3Za/fT2nl9/0K/i1B+ZUxkD
         Pp5LD8VsgQL+mYpxLjAndISjs8+5dUZzyqb7NOSot5NnquOJmA/eDeu2nTCjVWmKZ7FZ
         A+567BZhEr3Kt0p1nArPo8OcDVgnAn1Bm8ariIyoc+qSqf5/vg/MFkD6QWRMHmWiRpoD
         CWbg==
X-Gm-Message-State: AOJu0YyCK6rkrea8QrgB+PGvNmRGQrrkTabPjSkwBMu5DOkOa5HcT7aY
	bSgxdpVm5u/ulM7AOCy5Zm7seQUODaYiF5txbqWJ/8KiHvk55xG7tLj5
X-Google-Smtp-Source: AGHT+IEW0pK2rpI5lSUM04zS7HXoz8pLdZfvKn1Rri33nCsNHqvRpxSUfqZ7A9xa+YxZJ8sIX+1enQ==
X-Received: by 2002:a05:6214:5908:b0:6b0:63fa:c42 with SMTP id 6a1803df08f44-6b191a64578mr43690396d6.26.1718252275090;
        Wed, 12 Jun 2024 21:17:55 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.54
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:54 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 18/19] NFS: Add a generic callback to return the delegation
Date: Thu, 13 Jun 2024 00:11:35 -0400
Message-ID: <20240613041136.506908-19-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-18-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
 <20240613041136.506908-9-trond.myklebust@hammerspace.com>
 <20240613041136.506908-10-trond.myklebust@hammerspace.com>
 <20240613041136.506908-11-trond.myklebust@hammerspace.com>
 <20240613041136.506908-12-trond.myklebust@hammerspace.com>
 <20240613041136.506908-13-trond.myklebust@hammerspace.com>
 <20240613041136.506908-14-trond.myklebust@hammerspace.com>
 <20240613041136.506908-15-trond.myklebust@hammerspace.com>
 <20240613041136.506908-16-trond.myklebust@hammerspace.com>
 <20240613041136.506908-17-trond.myklebust@hammerspace.com>
 <20240613041136.506908-18-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Shelton <lance.shelton@primarydata.com>

Allow generic NFS code to return the delegation when appropriate.

Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@hammerspace.com>
---
 fs/nfs/nfs3proc.c       | 8 ++++++++
 fs/nfs/nfs4proc.c       | 1 +
 fs/nfs/proc.c           | 8 ++++++++
 include/linux/nfs_xdr.h | 1 +
 4 files changed, 18 insertions(+)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index cab6c73d25d6..1566163c6d85 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -984,6 +984,13 @@ static int nfs3_have_delegation(struct inode *inode, fmode_t type, int flags)
 	return 0;
 }
 
+static int nfs3_return_delegation(struct inode *inode)
+{
+	if (S_ISREG(inode->i_mode))
+		nfs_wb_all(inode);
+	return 0;
+}
+
 static const struct inode_operations nfs3_dir_inode_operations = {
 	.create		= nfs_create,
 	.atomic_open	= nfs_atomic_open_v23,
@@ -1062,6 +1069,7 @@ const struct nfs_rpc_ops nfs_v3_clientops = {
 	.clear_acl_cache = forget_all_cached_acls,
 	.close_context	= nfs_close_context,
 	.have_delegation = nfs3_have_delegation,
+	.return_delegation = nfs3_return_delegation,
 	.alloc_client	= nfs_alloc_client,
 	.init_client	= nfs_init_client,
 	.free_client	= nfs_free_client,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d41d86c713ea..a4f85af880c2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10849,6 +10849,7 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.close_context  = nfs4_close_context,
 	.open_context	= nfs4_atomic_open,
 	.have_delegation = nfs4_have_delegation,
+	.return_delegation = nfs4_inode_return_delegation,
 	.alloc_client	= nfs4_alloc_client,
 	.init_client	= nfs4_init_client,
 	.free_client	= nfs4_free_client,
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 995cc42b0fa0..6c09cd090c34 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -692,6 +692,13 @@ static int nfs_have_delegation(struct inode *inode, fmode_t type, int flags)
 	return 0;
 }
 
+static int nfs_return_delegation(struct inode *inode)
+{
+	if (S_ISREG(inode->i_mode))
+		nfs_wb_all(inode);
+	return 0;
+}
+
 static const struct inode_operations nfs_dir_inode_operations = {
 	.create		= nfs_create,
 	.lookup		= nfs_lookup,
@@ -757,6 +764,7 @@ const struct nfs_rpc_ops nfs_v2_clientops = {
 	.lock_check_bounds = nfs_lock_check_bounds,
 	.close_context	= nfs_close_context,
 	.have_delegation = nfs_have_delegation,
+	.return_delegation = nfs_return_delegation,
 	.alloc_client	= nfs_alloc_client,
 	.init_client	= nfs_init_client,
 	.free_client	= nfs_free_client,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index af510a7ec46a..01efacae4634 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1840,6 +1840,7 @@ struct nfs_rpc_ops {
 				struct iattr *iattr,
 				int *);
 	int (*have_delegation)(struct inode *, fmode_t, int);
+	int (*return_delegation)(struct inode *);
 	struct nfs_client *(*alloc_client) (const struct nfs_client_initdata *);
 	struct nfs_client *(*init_client) (struct nfs_client *,
 				const struct nfs_client_initdata *);
-- 
2.45.2


