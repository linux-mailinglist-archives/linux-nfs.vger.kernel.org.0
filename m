Return-Path: <linux-nfs+bounces-12612-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB98AE2A61
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1307A9601
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Jun 2025 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5840521FF58;
	Sat, 21 Jun 2025 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjtXTDkj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02F4A23;
	Sat, 21 Jun 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750524873; cv=none; b=ruVtuUrbZ6KtWyK3HslV+xPHnkd1e/paEeHCrocicK3FlulGzj1Bwx7qvE2Q2K1GsdhrVNUaGuUkedsU/y40CXYVRo7C3H25uwematAIqapqyovDWrrBzkH/GydsEGG3+nUhKWRuRvAtpb+aadsFHvrlfKR6cwhj6vk2zL0EWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750524873; c=relaxed/simple;
	bh=L1+kiTA/vhjZdyDEy21T0OZ3Qo87gtoftS7wFlo6Cd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLxGvlRDQS9CCO5QVAx1fNW6nsvh6+LlSK6uEIGg5NlWHnTLOCbEfSw0hjvsyLK5QY8d2L1BHm+INCs9UAYDW5QFyOhZiL3jRBojFR9eraZmXCNmBi+RwLnRRCpkAk2YDr0A5LQi+0/bS7/SGamlgCYxicvGhSpurDgy33hnQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjtXTDkj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so3142825e87.1;
        Sat, 21 Jun 2025 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750524870; x=1751129670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZqzY1QpwGna7jeD9CVFkNjAHzWC9d4UYNHQHj4Znho=;
        b=EjtXTDkjE3pKJGo/jYEZfGJMMJEbvJmTbso09bHybZlHHc2EGtE5jjJ69KYtJsUFXn
         WFKukMUxdM0lF28kCiO/lWWV9fY/9zlRdmbGTDGF9lEQulrHBIuU/gzz7MTK/n7OGYy7
         yfOh5afZnHN9kml2T7w/F3gXDy1M1v5/Z3AfXuBkKskZUCM/qepcrd/3URX7NdExa89b
         Z5c7c6ka9oecz4YfEdJugRbFWgxx7H7LnmMktIoqXo1yGZ6U/fc2EwPAySiocpayKEFR
         KWyVRYqekkxww5YKTvpTxaKCMqLVuTTfIGCltq6s+kfYVEZmbkII378rvYNTCi/u+X/v
         gpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750524870; x=1751129670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZqzY1QpwGna7jeD9CVFkNjAHzWC9d4UYNHQHj4Znho=;
        b=BjWz29ix2x2wAXEh3fiDtT8OPbGrlMc2jopHC8lLqrIrPmbp3sSk02cuT43NdngdGW
         48Gu7Dary0BS21DxPp6I/ONuVnBNglSMPX/k9T3Ky6k4QDDrC7bAW6kGkKByVFBGUPXn
         ewJ+qYAmX4onFTE3ZSwe6AApV8o0i716a0dO8+NpsgG09GxjEF6gT5qHsm+Jpm+Td42i
         cTQrWMy7M5KxWLdC2GkFjPALQjPMnMVWCWWF/pi8kSHwAxS1GA7HZBv10LPyyTj5R+9a
         DC0zRfR+yMAYtUtQ+09IW+rKJ6Gos3b5tFTDkdtfknz+0zQ10sLQ5VrCMEHlm15d6fqe
         6jNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmS/aD3CrFvFRUcql8VebZ8U6GtIk0MUJdppWlqeeCcMIpkPMyBLfPQ+2eQeUcWYozV5KzpBPcxXc5ApI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZCTNy+py4Mt/6eYKG3BSLfvPhekP0yU1bIvN276FwZd81n4U
	9xnobthnYB2OPjPWj7bVLqqccN11OYL1qkdQuunZQpa0gtfmo5cLKJ3e
X-Gm-Gg: ASbGnctrcVu8/52B+V2NJuL2KnTLdkIkxGVn891wczRpkg9QK4Ukr8hmNq1aOt70q8x
	TVf8GvksSyItYyWzLaLJWo0K8B3bFtCk13uae6CZEFXulOFzhh3zldFi/voA7hroEVwlu70PMX7
	5ScpvWquhsDUIprIBq9dGqI0Hzr5QNQqEYq0X0ke0p9QKfoR11aFnO0pGxlms8640R+SiDZTXtz
	88F3asyQcGj/bqAbfL9uwAgRc0EyJWikCwidSSrjq2g3Q0LkGJYpti6P4DtyEnlrghK4ixa6Jja
	boW7B7M6BX1bP2UVuHGy+UAZFBmasIlB3clxHxJIP9ewzILO93SI53+QxGAyAghOISx2Q80Gu6h
	mqY5fRXouf39b5Q==
X-Google-Smtp-Source: AGHT+IEOIm5GKnQuJeHExGcRYUBVR7dcg5QsQ+PVkmfLTAyH/xXwA3UGrvbI1duPsbLRG+CkmYgOjQ==
X-Received: by 2002:a05:6512:ace:b0:54e:8172:fb6e with SMTP id 2adb3069b0e04-553e3d0b1a6mr2181319e87.54.1750524869247;
        Sat, 21 Jun 2025 09:54:29 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.201.55])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980c72ecsm6948661fa.84.2025.06.21.09.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 09:54:28 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH v4 1/2] nfsd: Drop dprintk in blocklayout xdr functions
Date: Sat, 21 Jun 2025 19:52:44 +0300
Message-ID: <20250621165409.147744-2-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621165409.147744-1-sergeybashirov@gmail.com>
References: <20250621165409.147744-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor clean up. Instead of dprintk there are appropriate error codes.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/blocklayoutxdr.c | 40 +++++++---------------------------------
 1 file changed, 7 insertions(+), 33 deletions(-)

diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 669ff8e6e966..bcf21fde9120 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -139,28 +139,19 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	struct iomap *iomaps;
 	u32 nr_iomaps, i;
 
-	if (len < sizeof(u32)) {
-		dprintk("%s: extent array too small: %u\n", __func__, len);
+	if (len < sizeof(u32))
 		return nfserr_bad_xdr;
-	}
 	len -= sizeof(u32);
-	if (len % PNFS_BLOCK_EXTENT_SIZE) {
-		dprintk("%s: extent array invalid: %u\n", __func__, len);
+	if (len % PNFS_BLOCK_EXTENT_SIZE)
 		return nfserr_bad_xdr;
-	}
 
 	nr_iomaps = be32_to_cpup(p++);
-	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE) {
-		dprintk("%s: extent array size mismatch: %u/%u\n",
-			__func__, len, nr_iomaps);
+	if (nr_iomaps != len / PNFS_BLOCK_EXTENT_SIZE)
 		return nfserr_bad_xdr;
-	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
-	if (!iomaps) {
-		dprintk("%s: failed to allocate extent array\n", __func__);
+	if (!iomaps)
 		return nfserr_delay;
-	}
 
 	for (i = 0; i < nr_iomaps; i++) {
 		struct pnfs_block_extent bex;
@@ -170,26 +161,18 @@ nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 
 		p = xdr_decode_hyper(p, &bex.foff);
 		if (bex.foff & (block_size - 1)) {
-			dprintk("%s: unaligned offset 0x%llx\n",
-				__func__, bex.foff);
 			goto fail;
 		}
 		p = xdr_decode_hyper(p, &bex.len);
 		if (bex.len & (block_size - 1)) {
-			dprintk("%s: unaligned length 0x%llx\n",
-				__func__, bex.foff);
 			goto fail;
 		}
 		p = xdr_decode_hyper(p, &bex.soff);
 		if (bex.soff & (block_size - 1)) {
-			dprintk("%s: unaligned disk offset 0x%llx\n",
-				__func__, bex.soff);
 			goto fail;
 		}
 		bex.es = be32_to_cpup(p++);
 		if (bex.es != PNFS_BLOCK_READWRITE_DATA) {
-			dprintk("%s: incorrect extent state %d\n",
-				__func__, bex.es);
 			goto fail;
 		}
 
@@ -231,38 +214,29 @@ nfsd4_scsi_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
 	struct iomap *iomaps;
 	u32 nr_iomaps, expected, i;
 
-	if (len < sizeof(u32)) {
-		dprintk("%s: extent array too small: %u\n", __func__, len);
+	if (len < sizeof(u32))
 		return nfserr_bad_xdr;
-	}
 
 	nr_iomaps = be32_to_cpup(p++);
 	expected = sizeof(__be32) + nr_iomaps * PNFS_SCSI_RANGE_SIZE;
-	if (len != expected) {
-		dprintk("%s: extent array size mismatch: %u/%u\n",
-			__func__, len, expected);
+	if (len != expected)
 		return nfserr_bad_xdr;
-	}
 
 	iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
-	if (!iomaps) {
-		dprintk("%s: failed to allocate extent array\n", __func__);
+	if (!iomaps)
 		return nfserr_delay;
-	}
 
 	for (i = 0; i < nr_iomaps; i++) {
 		u64 val;
 
 		p = xdr_decode_hyper(p, &val);
 		if (val & (block_size - 1)) {
-			dprintk("%s: unaligned offset 0x%llx\n", __func__, val);
 			goto fail;
 		}
 		iomaps[i].offset = val;
 
 		p = xdr_decode_hyper(p, &val);
 		if (val & (block_size - 1)) {
-			dprintk("%s: unaligned length 0x%llx\n", __func__, val);
 			goto fail;
 		}
 		iomaps[i].length = val;
-- 
2.43.0


