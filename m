Return-Path: <linux-nfs+bounces-16858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D36C9D781
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 02:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2182348C20
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 01:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F1E1FA178;
	Wed,  3 Dec 2025 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEBZSR3b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5B1E8826
	for <linux-nfs@vger.kernel.org>; Wed,  3 Dec 2025 01:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724168; cv=none; b=f0HiEXBFlOPHDJ/LOVP7WT/1BAsprKHFkPDZcpSMvsak/IXY4EcTDGh8yGg4PbJJk6ulaJzq9vjwsg/yF61wL+OV2rTzJcOeBPPmusfV3NKZGB26+iNDjtywsRS5kzPlbe/lYi+/WbIgvGs7hD01awdgPHts21W8VHW+s2dKAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724168; c=relaxed/simple;
	bh=6fHMLY9nzx/qk7eCUo5CKi2uxMKJlPKvhN3nUdBaoio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOwJHnMgVkk2+nZF8fWOZIe7avlL96nxMAEMlPPbOw6fB3fWu6F28psKvv4IvtPDyRI+/60pyN7QOHtdTGH5y1ysMxmDHMdTuvw2Mm/ogpgwwC1IE17bwZDb+28paUqoyRT23EV7MFeE80aSi90xJP0s1Xt37W9N2Pj5VG1M0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEBZSR3b; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-298039e00c2so86567615ad.3
        for <linux-nfs@vger.kernel.org>; Tue, 02 Dec 2025 17:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764724166; x=1765328966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em6jfQZn/yELHlaBR2HoIyDIAqcmTdw7KjJD9azyEhY=;
        b=EEBZSR3b0dBwfdzWUg6K++SqhDQbdTzr2bB2bxzJCk1mdF5tWGWoDX2+0JiuaE+Xp2
         VR1d34XOgSJHjcMVaqINz4E4+Pd6fMh9OSyzGs8TQeM2DBLd54C1cgvyxexBXPO31ZG0
         rgvXgH5qROAcfsy2JREK05bBH9I8RtgiEE0pDJMbAjXzl5CtkU8MGr5jNzeMnTrLA2Mb
         aRWn5FqWvCyJhvkz+SPTvofz0hwQsuA2rvFVMTSyBZQtM+13GEvIL8EXQxFnNEFjfkZY
         K0v88vgaJ4+6W9dtexY7UMiGEBaBl4kWafPJ0k6zJGjzcRErpZmk+yDPUaSxUTo/bYMV
         A4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764724166; x=1765328966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=em6jfQZn/yELHlaBR2HoIyDIAqcmTdw7KjJD9azyEhY=;
        b=cEvnpdGSX4qStKo2s+Uk7bq2tKQLIx/OOAuD5/Vmz5a6109FY1ua7a+XKwpB51szms
         a54zmWHfEPxWCTgYQaFD6/XnByz6EkP3wEaUEsDpm6snzCAfkwdYQG6fax2luiYZfOx2
         +Ksdcr/I060P03Bq9iyUHPpuCvbDGH23BQWXu8ZoQ5Ws/3kyT+PZ+2qE8SkencxPmEFc
         HJ3YwOim9MJLuo/0u4Jkr/nn0n3XgzJVnmdQNWXeKw6tzNHY1auOuwr68zMwJpLDUsAx
         nDhDRZk0BxtouaUpqS65J9f0wRcGbjOqlSmmIX27Kd+w1mZ0WuuEy1QaC2qU5g8ql7RV
         DP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMe9k7wsvM8aUg38UXJAE5tF5l27Rnp/kkfWp2a62N2E5tFnzjD8/MgSGlpwhoO6EHBvWi3UsrpV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb96E9NZFPsOEsqUevwcW+4rJDu0x2lDvkYVG6tb9KaXJId3W2
	EATUzUTzoITg796gIsX8j4/0sbx5g0rXLLxWWYtZyZvZWmmfLgCWH61x
X-Gm-Gg: ASbGnctD6QrTThOzR/AeMA3pD4Nz7aAF4VcMf6KBV3Hml/6dQ9K9nQixuq0inlnw/Bo
	Sf5/GqzBlBXo1IIMYjOgj13RrShNtiRgWTBEehM4PAMcEUqgkk+1C5YLUJ4uyaII9Js3hqLJBsl
	v0lt2ZqMLodYS3M5u4ZCiPkb+wIrzhCgTGUwAgu9tqpEwdJW6YZZ1I3XJtKNq9700Xq9QrZk9Ph
	O9U8muExRU1fROfKNl/TkRDP2EcJl5r4iD+FbcaqeXR4XG8oas54e3DSwL7fpXJ2d+6xrLL5YSp
	6IWt12v5i+kGadF+zxfdegRHynWJTQZdTi72wbMr2dsAmhucDOx9lWd0yVyy5pRWCw/JmbMK24o
	uWjTTrHpedwbFljy7xU7BDv/ylGhWLpqBd7WnA0PnLgz8o3nQUDMIDPj2JwrGMXt8yS1AR0+sC5
	spKMb4qFeD9vQ=
X-Google-Smtp-Source: AGHT+IG3vKLqQKpkwoikY08lxmkSKyzlesJHIK2dDXGy98QlzQH0KRi1t8Esy4WYV0xAJppLVDx0Xw==
X-Received: by 2002:a17:903:2986:b0:298:485d:5576 with SMTP id d9443c01a7336-29d6833c7d1mr6204845ad.8.1764724166264;
        Tue, 02 Dec 2025 17:09:26 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb29fbbsm165394905ad.49.2025.12.02.17.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 17:09:24 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id AA5904353266; Wed, 03 Dec 2025 08:09:21 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux NFS <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mike Snitzer <snitzer@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 3/3] NFSD: nfsd-io-modes: Separate lists
Date: Wed,  3 Dec 2025 08:09:11 +0700
Message-ID: <20251203010911.14234-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203010911.14234-1-bagasdotme@gmail.com>
References: <20251203010911.14234-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2634; i=bagasdotme@gmail.com; h=from:subject; bh=6fHMLY9nzx/qk7eCUo5CKi2uxMKJlPKvhN3nUdBaoio=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn6Pe9LBObG7S6WTlAV6pIViqhnP7u6IUT2uZK6m9q0D U6/18zpKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwESKbzIydF8M8lP46FW5Y/nt mAS5riVrTIVe3AwWuSPBKWVeqbhhP8Mf7p13Prs9DTnxP0xRrljReOrTAO0FvZr+FkUfVE+pmJS wAQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports htmldocs indentation warnings:

Documentation/filesystems/nfs/nfsd-io-modes.rst:58: ERROR: Unexpected indentation. [docutils]
Documentation/filesystems/nfs/nfsd-io-modes.rst:59: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]

These caused the lists to be shown as long running paragraphs merged
with their previous paragraphs.

Fix these by separating the lists with a blank line.

Fixes: fa8d4e6784d1b6 ("NFSD: add Documentation/filesystems/nfs/nfsd-io-modes.rst")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251202152506.7a2d2d41@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/nfs/nfsd-io-modes.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentation/filesystems/nfs/nfsd-io-modes.rst
index fa47c4d3dfb95d..0fd6e82478fe6e 100644
--- a/Documentation/filesystems/nfs/nfsd-io-modes.rst
+++ b/Documentation/filesystems/nfs/nfsd-io-modes.rst
@@ -13,6 +13,7 @@ to override that default to use either DONTCACHE or DIRECT IO modes.
 
 Experimental NFSD debugfs interfaces are available to allow the NFSD IO
 mode used for READ and WRITE to be configured independently. See both:
+
 - /sys/kernel/debug/nfsd/io_cache_read
 - /sys/kernel/debug/nfsd/io_cache_write
 
@@ -20,6 +21,7 @@ The default value for both io_cache_read and io_cache_write reflects
 NFSD's default IO mode (which is NFSD_IO_BUFFERED=0).
 
 Based on the configured settings, NFSD's IO will either be:
+
 - cached using page cache (NFSD_IO_BUFFERED=0)
 - cached but removed from page cache on completion (NFSD_IO_DONTCACHE=1)
 - not cached stable_how=NFS_UNSTABLE (NFSD_IO_DIRECT=2)
@@ -56,6 +58,7 @@ because the page cache will eventually become a bottleneck to servicing
 new IO requests.
 
 For more context on DONTCACHE, please see these Linux commit headers:
+
 - Overview:  9ad6344568cc3 ("mm/filemap: change filemap_create_folio()
   to take a struct kiocb")
 - for READ:  8026e49bff9b1 ("mm/filemap: add read support for
@@ -87,7 +90,9 @@ be made.
 The performance win associated with using NFSD DIRECT was previously
 discussed on linux-nfs, see:
 https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
+
 But in summary:
+
 - NFSD DIRECT can significantly reduce memory requirements
 - NFSD DIRECT can reduce CPU load by avoiding costly page reclaim work
 - NFSD DIRECT can offer more deterministic IO performance
-- 
An old man doll... just what I always wanted! - Clara


