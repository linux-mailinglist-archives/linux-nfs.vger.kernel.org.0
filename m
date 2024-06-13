Return-Path: <linux-nfs+bounces-3724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680B9906309
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96DA1B22E40
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B20313213E;
	Thu, 13 Jun 2024 04:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzNZqhDm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A72A1C5
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252275; cv=none; b=FOLPtX5/u6AXo+d/zaU7txdlet7w6yiIFamAK5Nqwj+sUM3cicKlIStosGnjrYvOo3ojGi6ApieoFSNkc6EF4jD+GwoLiskb74mpHgwDFcmBOdmVpa82t1MAK1vMoLYUgYstCZOMLklOlo8uW7EbnRtOFyu86rZePqwC97ReN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252275; c=relaxed/simple;
	bh=3T0lVk0s05b94t3g+WI4sOi/ux5TRvqg3k33wukiVMY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+1ahd9Y9aCgR5m099Crh64kLweC7SVYS7m2LldfTUAlF2Hlu9uTUN69L36Yp/fytpprbR0zNwgmCqshd4Ln03WJkW9lLeskLradHNp+LuvOghuzN5udAJjuc8KDruzbwrcY+uX9qhS8SVLoZG5A85XgYzRwuGmZAuI4ScZRjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzNZqhDm; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b06446f667so3121406d6.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252272; x=1718857072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bjuzTSTyyuy7nSHWdlaaw758n1TGH2uD8+CpJLQezE=;
        b=VzNZqhDmWwVIrZ+r1oddn2DwVkAUWCHC2QU71a9BMam9nwD2zaP0O5M6Ck+Vb5AkTI
         aTQLGUSoixWxsc6spvrlJyBeQgPUmVqOme8wviyr2g1D5cn0HBqb3ivq5IJ0EfFYxpsV
         faHQG4HyTmgpL+d7kc/nn2D6OlL/ovikaw9BtZsw+mwlwu/V8nirLlA0jk34F7HWXUUO
         VCGj+I5sFi2T8JHzzLknlT/XaI/auVdwgLWu86n3pqtXmgwMDDKuKXaS/WYfS7sNKRF7
         /CQDEncHLTzW6/FPfmOpVLGCiiNF1akcLklgu6td/aATqwvspFLkkUt7s3gZTsrHgO6n
         evew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252272; x=1718857072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bjuzTSTyyuy7nSHWdlaaw758n1TGH2uD8+CpJLQezE=;
        b=w1D1x7RxZRWTSeRfieg2uWbrUv1gR+IogK/Z0E2pB8QR579zyiFK0zd9E+6YDANq9b
         Z8oUTQoq+7Z+d9udGg1Biu2fFfeKcwlc6BynAQ4lWkskklEtQPsnL1Q+Rz82jLDgew6c
         DhJlKXkduyKMhkyerzexzcK18Ctu35sw5JeE8w6fXX6l9klrv4GKYWyfNz8dDYcgC3cU
         qOCzufb1+fWnk0Pkd7zb81NMsb9ICdkKZnNmiTUXP+BY0gBFqysYYIjXZnBFs+2rjjkC
         YHVzY8PK18xE/5LQrmUnUt0qPXJtuHDyBZAba6uCA/gTIRusRadtEQu3n6DsqKplBMYp
         Hs7Q==
X-Gm-Message-State: AOJu0YxxM5fISk2X0MkopX5dsnuchXaugtITj07017cuwejGVHsALu5v
	qd4uLkdhZjEI8GzL5FQZAfnoyq9iIhx2a4j+0piuleL2OOwkI/H1/tM/
X-Google-Smtp-Source: AGHT+IFY3d+twPm6Y4QWYnxnmQUXUjCRoomiBBHae8hLMYNAd3rp8N2vJWzvlXuSgxQDCyzWXvg4gg==
X-Received: by 2002:a05:6214:2d43:b0:6b0:8d8d:8d1 with SMTP id 6a1803df08f44-6b19230dcfbmr33497496d6.32.1718252272457;
        Wed, 12 Jun 2024 21:17:52 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:51 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 15/19] NFSv4: Detect support for OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
Date: Thu, 13 Jun 2024 00:11:32 -0400
Message-ID: <20240613041136.506908-16-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-15-trond.myklebust@hammerspace.com>
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
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c         | 4 ++++
 include/linux/nfs_fs_sb.h | 1 +
 include/uapi/linux/nfs4.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ca2c115b6545..87a197864277 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3990,6 +3990,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 				sizeof(server->attr_bitmask));
 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
 
+		if (res.open_caps.oa_share_access_want[0] &
+		    NFS4_SHARE_WANT_OPEN_XOR_DELEGATION)
+			server->caps |= NFS_CAP_OPEN_XOR;
+
 		memcpy(server->cache_consistency_bitmask, res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
 		server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
 		server->cache_consistency_bitmask[1] &= FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 5a76a87cd924..fe5b1a8bd723 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -278,6 +278,7 @@ struct nfs_server {
 #define NFS_CAP_LGOPEN		(1U << 5)
 #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
 #define NFS_CAP_CASE_PRESERVING	(1U << 7)
+#define NFS_CAP_OPEN_XOR	(1U << 12)
 #define NFS_CAP_DELEGTIME	(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
 #define NFS_CAP_UIDGID_NOMAP	(1U << 15)
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index afd7e32906c3..caf4db2fcbb9 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -46,6 +46,7 @@
 #define NFS4_OPEN_RESULT_CONFIRM		0x0002
 #define NFS4_OPEN_RESULT_LOCKTYPE_POSIX		0x0004
 #define NFS4_OPEN_RESULT_PRESERVE_UNLINKED	0x0008
+#define NFS4_OPEN_RESULT_NO_OPEN_STATEID	0x0010
 #define NFS4_OPEN_RESULT_MAY_NOTIFY_LOCK	0x0020
 
 #define NFS4_SHARE_ACCESS_MASK	0x000F
@@ -70,6 +71,7 @@
 #define NFS4_SHARE_PUSH_DELEG_WHEN_UNCONTENDED		0x20000
 
 #define NFS4_SHARE_WANT_DELEG_TIMESTAMPS		0x100000
+#define NFS4_SHARE_WANT_OPEN_XOR_DELEGATION		0x200000
 
 #define NFS4_CDFC4_FORE	0x1
 #define NFS4_CDFC4_BACK 0x2
-- 
2.45.2


