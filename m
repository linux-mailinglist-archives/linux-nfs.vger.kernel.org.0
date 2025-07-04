Return-Path: <linux-nfs+bounces-12898-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A70AF91D5
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 13:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094C61C85F04
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 11:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B88F2D5C70;
	Fri,  4 Jul 2025 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqFEeVmd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D02D5C76;
	Fri,  4 Jul 2025 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751629782; cv=none; b=janDw3MONxbqlQVfA3NuWhuHwYnb0HRPqF1RT38H/9BlohqC4pqjkuhV6/R0aeUqvB1Hhsbuiim+smY54I4dgCcXXvwEg6NUorrnwTVswLaHeVCiBk+gGM6yqTpa7cQ1uLoSUyPFFZkzweICc3U7znLY/2nRieKJzEI1bcEUHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751629782; c=relaxed/simple;
	bh=Vt5NdclMlwsVVf/u0ju4MxfPoQmGAU81RJC4Iq80sWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=al7AsNqYJBjFop6cgC/urP3EFkkUdz54EcWXMhmFVvteQ2dVYno516AzMkNFN3hcp529wbdMwd8xjGEPr/yUqf6Tya3ceGed04YsJ76JzfyYeRV9G6Cy6XupTCqrsyURFI4luymhupia8Vjs5N4GArROfD+mbNAfrjGfyxCS+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqFEeVmd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553b3316160so1113760e87.2;
        Fri, 04 Jul 2025 04:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751629779; x=1752234579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es/zDifoBNluPfkeaqM7f8ZSqCroElrIfIrI6Q096mw=;
        b=SqFEeVmde0EZu1KMp+zzLlbuG/nNw5mOXedc/kxSczSE+qk4m1xNjzL/cYtowIpisd
         qAD9eBlw42/VQ8wEQYDnYQftmWLcooVXp3N80ainlmkH+BxAWnEPZ4JP3gUvwJkYda7E
         T0l/xpErx9APKKP8bT+1ojRJ0tn1UvRwrHdX0KDFzMH6DCY2JV/JlYNtiVdzTSjwg5nG
         NmYXB4ErZX1i1Ij7kIjHEpMGA0ZR+POkzfKrFVCDLnfJ3DRvETr0rFARXNRtcYbOIJgJ
         M703R4WqpUWcao9cOsxEkR+GaCiDO9HKAbp8SXvFeL+J6t/p/JZUYFEkVMF17tsNAoZR
         xnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751629779; x=1752234579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Es/zDifoBNluPfkeaqM7f8ZSqCroElrIfIrI6Q096mw=;
        b=NyJYU6djJ8KGPzjsUjPj+Nm/XeJAuqx+7wY0NOLALrr7z8W9g/pxcFdhfLzTVPas87
         5OSx+kpf7xnCOgNhMcd5nwlaudlAAYc93GRbs/ABqCwIArmnUYxTejNBhdNJjqfdqveL
         LhmlzjyGMLuN2wKFwyg26FK6GJjepPino2Q2zTCJpD22xlWIxtgmBjPSejeXHB2/L6j5
         rvFiJMRSrVJjRSElFCNdHxYZ757D3c9DwcJHR822G8kVH1dnZeJf/IEOJZwlalMCn9lB
         iYRiHr4tH+KXNeQlSFx8Wu5rp6JKl7bsb2FczxT195M3TKLyWJjFXxQSXPUrEmjauL6e
         yBZw==
X-Forwarded-Encrypted: i=1; AJvYcCXlMXoJip5amVlltUpL5rCroKjeb42wng2HdHj3wQpMojYbV6Rnk/gpjd07ySdymtTnBF5r98tKi/hc0ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOmm1ggFTMCD4fB8MFDoil/4sknVl7vhu0AaRctQCM/Ifdcw5
	UdU1C1suRqiTCqlzfJKleDAUvCxrg52I4nZrHqeTIFOZIg6iX60707GU
X-Gm-Gg: ASbGncuYrIFHLy+f9KRQ1nY2bWJYj4FFQoU377RGXuHLCBCPkHm2QDWTh92ZA3uHkOW
	lE7ZWY/oGiipXIaQD5J573Vy8qYJDFWiXzfOKdyLqmz/aaKvDeQYBmeFxvJpaNVygc3AFZBTII1
	W+OWF+8Eow4nvyveazqnsWfPc6wHZ8O1W2Vt3sD8t+5dwWs6uXnRVcNM8i8OBhBt/caQ+o32IJV
	7rB9lSdMwMZlusNMsS6GBp2obvRoKavr8L4d91JUeQPM0E1kGMD+EWqqdsKJN3hjQy1g4MPLdZT
	QRgzf1OjEx7UNWoXDQoGtBYDe1LYRum5mnIQoYCxXiJEVbEWOxl83th76b7tIfXpZi8/RtbKLLR
	g+vuSgnzhsWE=
X-Google-Smtp-Source: AGHT+IGs5o63JQNUBrWEPM77gH9/AJixotcitaHpbR9D9F4NKNkC1KJGwjSO4EKqNBWfaOSaVd2uWw==
X-Received: by 2002:a05:6512:2203:b0:553:297b:3d45 with SMTP id 2adb3069b0e04-557aaa58e98mr473443e87.43.1751629778387;
        Fri, 04 Jul 2025 04:49:38 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.70.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55638494e1esm231109e87.89.2025.07.04.04.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 04:49:37 -0700 (PDT)
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
Subject: [PATCH 2/2] NFSD: Fix last write offset handling in layoutcommit
Date: Fri,  4 Jul 2025 14:49:05 +0300
Message-ID: <20250704114917.18551-3-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704114917.18551-1-sergeybashirov@gmail.com>
References: <20250704114917.18551-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data type of loca_last_write_offset is newoffset4 and is switched
on a boolean value, no_newoffset, that indicates if a previous write
occurred or not. If no_newoffset is FALSE, an offset is not given.
This means that client does not try to update the file size. Thus,
server should not try to calculate new file size and check if it fits
into the seg range.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/blocklayout.c |  2 +-
 fs/nfsd/nfs4proc.c    | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 19078a043e85..ee6544bdc045 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -118,7 +118,7 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
 	struct timespec64 mtime = inode_get_mtime(inode);
-	loff_t new_size = lcp->lc_last_wr + 1;
+	loff_t new_size = (lcp->lc_newoffset) ? lcp->lc_last_wr + 1 : 0;
 	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 37bdb937a0ae..ff38be803d8b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2482,7 +2482,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
-	loff_t new_size = lcp->lc_last_wr + 1;
+	loff_t new_size = (lcp->lc_newoffset) ? lcp->lc_last_wr + 1 : 0;
 	struct inode *inode;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
@@ -2498,13 +2498,13 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		goto out;
 	inode = d_inode(current_fh->fh_dentry);
 
-	nfserr = nfserr_inval;
-	if (new_size <= seg->offset)
-		goto out;
-	if (new_size > seg->offset + seg->length)
-		goto out;
-	if (!lcp->lc_newoffset && new_size > i_size_read(inode))
-		goto out;
+	if (new_size) {
+		nfserr = nfserr_inval;
+		if (new_size <= seg->offset)
+			goto out;
+		if (new_size > seg->offset + seg->length)
+			goto out;
+	}
 
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
 						false, lcp->lc_layout_type,
-- 
2.43.0


