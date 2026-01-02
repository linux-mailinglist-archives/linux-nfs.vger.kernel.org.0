Return-Path: <linux-nfs+bounces-17401-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F70CEF787
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 00:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DAB63009F52
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Jan 2026 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8521F8AC8;
	Fri,  2 Jan 2026 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+ZNcXvq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68294248176
	for <linux-nfs@vger.kernel.org>; Fri,  2 Jan 2026 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767396633; cv=none; b=ddRoG5JoQ3hdrBJgjd0w7HX7+y29TU/vECaFWo9SH+DzETVZdmbA/wM9qT0CdTfQgYCsQw4Rgggl/+m4S0eMvH4eq8GKVZR1bS8GbF6eOmqfd3XnqtSZErEu9Y5EtWZdtE7AK1z0GTu6hKtsDkborJTUvR6YsaEPQhN1bAUBZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767396633; c=relaxed/simple;
	bh=B6QpSVGPSgD99WFuEwdiW261a/1D8TJvKNb6V23sGec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua+i8QMmK7rZPsxZv7yFYCrNZf1DHUk/Ay8Qg7YwvCZAwIHh2eyQ/IRbOLw+ytrQ2nj3Z3YL8G8UcpHR3hfvVOhzTbBsGIHRjo0wMAju6gaKQsmoUSQskV+G0wFDbF2PhRbF6zh0h/LYR2nLVJ+u5kEMiHNNMkwxZW43NYTu0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+ZNcXvq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0ac29fca1so104377615ad.2
        for <linux-nfs@vger.kernel.org>; Fri, 02 Jan 2026 15:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767396632; x=1768001432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo42MFi5fiUQy/do/oVCUt2XC83J1ozAsIdaxKEr5x4=;
        b=Z+ZNcXvqKLcmXn+Pb8b47Jk7BSKubaPzkOfxp0BH+yhYDgsfbxNNUGXl00R52723t3
         gqGw7k2QG84SJdIWe1mUJxRFvMtrcxp5FFBAtN7RNYgYP7nIU+rkKC8vFjPq7EWq7hl4
         n4LdrMN0ziLT1Alv1y2GyqpKKnkQ9ee6aAK8tJnBI1/WaC+7PjjGe9avWl389tTYTfou
         PjFtg8HlQ+Fg8UdgKk2ff9JZ3p9gibOBKmgPGgyjROYvZEmVFlpC//BLbvT6X1At2E0Q
         mrNKzmKXz/0r/GFwBXv/rmwuT4q7lkK8dWm/9cw1KH9+8II7jm9nmlCxrBnbw6gp3ng8
         lviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767396632; x=1768001432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mo42MFi5fiUQy/do/oVCUt2XC83J1ozAsIdaxKEr5x4=;
        b=LEpRVWYwgU2NfwSg+VR3GhcaRV+RNr+aMQsdxMA8f1mXhaJX/0TIXIE4kHIPGrYR4C
         IyEHLqWfAc81uCapJgv41KsVE0UukmAuEZsMjbiWdly+7/TWUqNNn5LbsZpGDZdicGJI
         rU6Ti6X36PDzh1FOKMca0nGfhOge/zagudtWZqSmVQwxVyzoA0jqJ2QlkqVBX6NLrsFL
         KsK2oqi0F+e+sUVRFNFzPTIg6Y5Xd38IZ2tIPqp3zB3g5qOxkfi/T1/yRj0+5GVLl+13
         iwxYIJ2feh3mJUceTXht0dRh5b6bC+reyP7Eh7f5ha6H8/spb5op5NWF4susaMof2Jty
         sJ8w==
X-Gm-Message-State: AOJu0YzNFVM5SgCYsk71W78HveTeGBe53P9oPoRt4pKIaUM61xJrUvLm
	JcRbCwvfYPrEeWd0FYG6UJHM1bqS1wSOG29TD0KDysqnCC6BJW62r9oNKfzadS0=
X-Gm-Gg: AY/fxX7Fbk4YH0hgAMm6UwXixu+SEjtBQ2mQZPXyisoB3m8ku7iWlFjSyDdA9PLoG+N
	R13yQZtLnwCqtPmXiYHt6X47i6Va+OCdullxn2DHg+pl8fNDv2huGaZHUKCVN3cRzb/Y55wkJ2U
	RvhRxEL95WSNKx82ar6gGirBZQ2O/P39ARXJmVlivroLbRiJs7YFsE7QIeOCL+OF5gilWY7BQe+
	SUVt7MAk2fbnZoYP0DEPnLZdQfFVZfCoIvks0EsgWMnbWH5SBIBLJWUC1vRce6AcaXYyTTDDeWB
	OiZFq9FE6xAtacGHUBohRB87ombKzd+oBL+ufPjDVo3fg0BCjODbZv02PHmk8moqUoEb+eJ1vBr
	B858xPJMCPOPesO8Ve/0d2sVQLUXSmCoyhW2esBHq0MCsX/Idc07Wjtu3aSeYzdKhkIBB/uH2vj
	0EiO4dTiv6LA/t8eMoF8eL94ResY7r/9ew/ENc5vHiXWdxI7XbR3bAI4H9
X-Google-Smtp-Source: AGHT+IEM2z3mXO0ORB7ptIKY7j6ik/UJxr5bZV0X2IpS86Y1iE7jrkplfBrKHE4IJuTyzire1vjHfw==
X-Received: by 2002:a17:902:ce8b:b0:295:b46f:a6c2 with SMTP id d9443c01a7336-2a2f27325d5mr424725435ad.37.1767396631524;
        Fri, 02 Jan 2026 15:30:31 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c71853sm391508805ad.19.2026.01.02.15.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 15:30:30 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 3/7] Make posix_acl_from_nfsacl() global
Date: Fri,  2 Jan 2026 15:29:30 -0800
Message-ID: <20260102232934.1560-4-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260102232934.1560-1-rick.macklem@gmail.com>
References: <20260102232934.1560-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

The function posix_acl_from_nfsacl() needs to be called
from the NFSv4.2 client code handling the POSIX draft
ACL extensions.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfs_common/nfsacl.c | 3 ++-
 include/linux/nfsacl.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
index e2eaac14fd8e..2ef7038b8d69 100644
--- a/fs/nfs_common/nfsacl.c
+++ b/fs/nfs_common/nfsacl.c
@@ -289,7 +289,7 @@ cmp_acl_entry(const void *x, const void *y)
 /*
  * Convert from a Solaris ACL to a POSIX 1003.1e draft 17 ACL.
  */
-static int
+int
 posix_acl_from_nfsacl(struct posix_acl *acl)
 {
 	struct posix_acl_entry *pa, *pe,
@@ -325,6 +325,7 @@ posix_acl_from_nfsacl(struct posix_acl *acl)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(posix_acl_from_nfsacl);
 
 /**
  * nfsacl_decode - Decode an NFSv3 ACL
diff --git a/include/linux/nfsacl.h b/include/linux/nfsacl.h
index 8e76a79cdc6a..f068160bfdc5 100644
--- a/include/linux/nfsacl.h
+++ b/include/linux/nfsacl.h
@@ -44,5 +44,7 @@ nfs_stream_decode_acl(struct xdr_stream *xdr, unsigned int *aclcnt,
 extern bool
 nfs_stream_encode_acl(struct xdr_stream *xdr, struct inode *inode,
 		      struct posix_acl *acl, int encode_entries, int typeflag);
+extern int
+posix_acl_from_nfsacl(struct posix_acl *acl);
 
 #endif  /* __LINUX_NFSACL_H */
-- 
2.49.0


