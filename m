Return-Path: <linux-nfs+bounces-12834-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D9AEF86E
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 14:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BBA482C4D
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293426B975;
	Tue,  1 Jul 2025 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0su1eZN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EC270EDD;
	Tue,  1 Jul 2025 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372704; cv=none; b=F7a7VZHRlEAI74XTtxxhOM0ua6jhVpwrf4ZwSBGd3+uZRkEUkheU3xdPG3TH6hed1h7T+EbRTgVM8RCzNzQwz+VGHvf2WFigBklExrHIRCTcWAubAtXygoLBYiEqOB+UZtrQtJFKrNiosOiTlDSGksFCQTv9UA8ztuRVgg8URmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372704; c=relaxed/simple;
	bh=NmcjOq31Gb0th3ag4qLiGH35SqygK9MXceGdxECczTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HevBZukuu6A63mK34wtHDW7oCa5oSjjrJFjdkxq77BR9997lBr2eaE/l/NLVwzwqnEqUMAEA7KbnOs2Lo7XeUnLehBYFoLVwvsB44mTS9HZSNALbrndwA/PqoYRm60ktAsZOVtTE9SXDjqo62Jl9YnJt0UR5ePai0LBTMlv2WBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0su1eZN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54d98aa5981so4780966e87.0;
        Tue, 01 Jul 2025 05:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751372700; x=1751977500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb5Ep9r3vpiD7ybqKvh3wn7iDchYBiJpC7QxUP6423Y=;
        b=V0su1eZN3ZYkaKgGzEPaWOWqnjwptPBnnl7LZ1Zn232skSZCq3T+HqOy6ZlcYT/9ao
         tX+eIgCrgE4/fnfl3pUULBTjJR3yW/Yiq24NhW2FPJN9r4wlRghigRuHscw9akTYb3TQ
         If2FHZAVnbvGU/ihws927SuL0QH2UcPllJSSwRBT4hGOu7rsDkS+grlJWzNrKFcrr6qz
         XkUIECr7OiuoKopMoGVyn0e63LWYODWh95z2BKIQae9iCy42kGlZb0npno+NBThOlv58
         6ftttksx8TbnaA+pDs6058Js09QNr1slPCIG70TWCkLLoHvE75xm/orDZU9YqypdeUye
         Vrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751372700; x=1751977500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sb5Ep9r3vpiD7ybqKvh3wn7iDchYBiJpC7QxUP6423Y=;
        b=q7yMqjHoLRt3ZqpoagmV1mP3b7vyWhGHa3Yb5wI8U0Af8yRP4O9ST8PdOmDVTb+en6
         y164Ovsu7WCLA/BIcOyu8oKp3bpvMwNjFy7PZBzuueR4oIEP5fKlFKN1Us9S3QkuPEU9
         CKs8YuhTzscKcwIIZYyPA1OF2q57p9cPFWdAUVPaxuzjFrR/aVu4YBW3og/X9VH4s2Hs
         r+N1H4rT7FdxmXz4iWf8RP5Jp1QsNGrIOBtaSBx/V9DR6VarDzn8fr2J2H8csL7Qr/1l
         HlLHwpBPhcqO854TX20ihv9OIVenPSA1qPcnSMPPmLZR3zriGkKYtb/xz44QNcokKr9u
         WhRA==
X-Forwarded-Encrypted: i=1; AJvYcCU3e0k1zmJpuvQTvB4rLO7j8Ir6lD/Mx9Q8RNsavsE5uWzWmQqpy7OGWGtdQfu+a71YNZ3OQ2YGFIiRmeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBsiNivloWXDKIJ71LxV7DzR86VmeQku6CG4UDlahxIeFW1Ct
	e8zKXoIYmkISPH2vIB0djQdoJ0GPHcAwiKKGQefpQfip3vswI5lD+dVP
X-Gm-Gg: ASbGncsP71YzNKpipRVlmUxh+yeKwqXJefNpWCBcATx+OnhlpB8jR6o7hg6kX+BskCM
	EO7zaa6BsT7OlAPpxJIDyDe1YL3h3Piss1mmbE1ESCSaXxiW8Bntgu1mj26dFmmvUiZyrALn5tv
	A8ynkgKBDt3iBUTggh3nbMdmhImH4nHAdZaoi0QRkhqKi65DI9hMKNGWIZlA06CNZ4cfkT3yju8
	QNw1iCfimnNJ8DWqqsHLWlfyLJQdcLeedZ/6DiaqjP0b836Ew1Lp8uN3+N+y4EruhECAf2uumfI
	b2vt5hNoEEou164kvlM7WXLxAPfSf2rugTHUs7lAhSPUHu4JMQOcPBv/aq0aOXDRUVd3rJzPU7f
	9YUURG4c+38gohQ==
X-Google-Smtp-Source: AGHT+IE8JPSjlgJX/ljFkWvNiEGayauKBp0F7/traHojzfmX3lACaAnF5hbUBchaqf2LdilB9mEplA==
X-Received: by 2002:a05:6512:1281:b0:553:2e82:1632 with SMTP id 2adb3069b0e04-5550b8c3e0fmr5562588e87.44.1751372699990;
        Tue, 01 Jul 2025 05:24:59 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.230.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2b8c9fsm1818695e87.137.2025.07.01.05.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:24:59 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH] pNFS: Fix stripe mapping in block/scsi layout
Date: Tue,  1 Jul 2025 15:21:48 +0300
Message-ID: <20250701122341.199112-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because of integer division, we need to carefully calculate the
disk offset. Consider the example below for a stripe of 6 volumes,
a chunk size of 4096, and an offset of 70000.

chunk = div_u64(offset, dev->chunk_size) = 70000 / 4096 = 17
offset = chunk * dev->chunk_size = 17 * 4096 = 69632
disk_offset_wrong = div_u64(offset, dev->nr_children) = 69632 / 6 = 11605
disk_chunk = div_u64(chunk, dev->nr_children) = 17 / 6 = 2
disk_offset = disk_chunk * dev->chunk_size = 2 * 4096 = 8192

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfs/blocklayout/dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index cab8809f0e0f..44306ac22353 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -257,10 +257,11 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
 	struct pnfs_block_dev *child;
 	u64 chunk;
 	u32 chunk_idx;
+	u64 disk_chunk;
 	u64 disk_offset;
 
 	chunk = div_u64(offset, dev->chunk_size);
-	div_u64_rem(chunk, dev->nr_children, &chunk_idx);
+	disk_chunk = div_u64_rem(chunk, dev->nr_children, &chunk_idx);
 
 	if (chunk_idx >= dev->nr_children) {
 		dprintk("%s: invalid chunk idx %d (%lld/%lld)\n",
@@ -273,7 +274,7 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
 	offset = chunk * dev->chunk_size;
 
 	/* disk offset of the stripe */
-	disk_offset = div_u64(offset, dev->nr_children);
+	disk_offset = disk_chunk * dev->chunk_size;
 
 	child = &dev->children[chunk_idx];
 	child->map(child, disk_offset, map);
-- 
2.43.0


