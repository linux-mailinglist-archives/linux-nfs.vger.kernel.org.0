Return-Path: <linux-nfs+bounces-13131-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A2B08F91
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 16:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC041636F7
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2272EBDC6;
	Thu, 17 Jul 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJoAXYzL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58315A85A;
	Thu, 17 Jul 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762945; cv=none; b=hhK41VT5yn6i+HM18S1ey0TJpNvG0IotahR6HrEo3vuT9zn/bUZTv92WvSB5pUr69GOjIp34+wMTCpx1VIncPnnwf4DtWh/BW+jFhV9rRfDJbws0Tup+LNr8QDK4v8WtNTABstSs55yIU16QpE10x0IL27u8hf5fSL9jCvRECjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762945; c=relaxed/simple;
	bh=aASdH393PiVHXIyaKBaJz7yCeciotgtIsdY4NM0Uvyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9UHgn2F+qhHdN5/tBdDCPRjVm5Ny7cbvYhL6mRAne5A3FIoVoecsETbnmB2iTydd+vy7ZoPo0PPSJN81jhAmewXv+qxf/M5fp8AbnhaW5PrggdO5q1S+6hG+HlYu7AfDkLpRjYrbMKHl/KXifhT3b28zj5KiYB6Kv3kjTF+eiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJoAXYzL; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32e14ce168eso11386211fa.1;
        Thu, 17 Jul 2025 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762941; x=1753367741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aSZklMWPvJBRpXH2PDxOcCQe+tBefDqw/pTTTb9JutM=;
        b=fJoAXYzLLzxY/0rZSQfva6eDmNoQZxQsxcYOd0ub1egy5h2zzdgJK4i3doNqzwTvW/
         TVTjk5vQB46fJSzMe5dZepr9i3mvtaBSaheT17qkUj6uN9A4iP72oqhnIerePT7ltk06
         5/VLl+rLFw4iWXPGpJOcor+1R4TE5KDrJABGyKQMoyrxUx6uW05RVLOEyahTZagRSN1H
         EJLZjhKklxcg3mryFYHTpl9hg5+7PQKNYn7zaM5J1duL0oJ4mFTyhZa6eFBVlX2gSc4H
         4zLM3CvsxWSqHKkNTupgZ/1GxzoBLrbSlDsiC2ptHi3Bjm3cviV+qBpKHCzNyaTNzM/P
         gVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762941; x=1753367741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSZklMWPvJBRpXH2PDxOcCQe+tBefDqw/pTTTb9JutM=;
        b=pRH3qDlyjFkVbzAGXjWvANhRnKDoHlWVYi7kGwXUx9mvHkiMF1+dJEC9jgGYwPFnS2
         exlMkVqjThBdcqRa2TddPQE3LJVgYjfGaMc3mRe8uRmM9zIHCElYg7N5+HkyF5DxrT2N
         OOfYbrUizyo+AqcnikECyJIfcAO/o+RGKBKFzF89JBNACTDY9Nup+Xp/7WgNZRmlJqXk
         mN7YlfKIFySIXKhvQeq/GsWaPerTQQwwV68nDGLYLIP51BfC61VlK+KWH/P6rb5+jOUW
         nriukTKyIYNg5y0JHckvAtxqjO+n9WzlpS6kGh4gR+3L/dh1V4h8aUVRa76vV8Xj8BVU
         o8gw==
X-Forwarded-Encrypted: i=1; AJvYcCVsL/BcTeKBxhVJIeGM8N9lbKNao1bFLcLeawKWaKyRI5qWudCDTXsQ258KCAgu3GWpGcSJKocCOqeWIbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxygyroua6wVpRYpyyBdVrnLNr3jzEFuJsE6zHhYUzgLK900vsh
	G5Ux8uOnJteDp74LCWORX+KkuNG/HkjA42sv0H0XqrinNAmfDUfENbR4
X-Gm-Gg: ASbGnctKrLA9BrL0MftKPDmMg+Vj74s8s5fTx2LD3dCcvpofRkVkoGLk133zBv+kZUL
	ZS8BTlq8LQp60g0/syisljhCT+g7VEFiaUT0zGLWgbCz415zYrZ8A3d2n9sWY7KuF2mQY6FC4zS
	dNFhz0wXTl7SPpdQj4AnHlGSk3FkOnnDBg+twiBQI3dCiYRBagyXIr827edw4p43ZRY3ISwi/7y
	QhVmcXMdf1QRQLYh6JjuXsQEWjwToy5GVxC6EwJJgRfbTAvjRgzwZF0AMF4GfQFLSQ5QpAD+Fv5
	yi1l59EjGGTX14IxWYoxrwt1M9RqHanHoy+NSSEoBN7uKahNF+DVqY+k3YC2BODLLAs970h73Tn
	HdRrsKcEzhGmPrA2WD2761T/5ZnOdtSZruJVkKlO8UO5J4pmunuU=
X-Google-Smtp-Source: AGHT+IHit2bi5tAPKfpMdzKUXhjwBP9TN0ciFwVismnSA+43fhLUaqJxDBilzkM2YqzAcatLX5K5WA==
X-Received: by 2002:a05:651c:e0f:b0:32a:ec98:e14d with SMTP id 38308e7fff4ca-3308f525fcbmr12006131fa.16.1752762941113;
        Thu, 17 Jul 2025 07:35:41 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.192.104])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29330f2sm24900191fa.36.2025.07.17.07.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:35:40 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH] pNFS: Fix uninited ptr access in ext_tree_encode_commit
Date: Thu, 17 Jul 2025 17:34:04 +0300
Message-ID: <20250717143522.59744-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of the function assumes that the provided buffer
can always accommodate at least one encoded extent. This patch adds
handling of all theoretically possible values of be_prev, so that
ext_tree_encode_commit makes no assumptions about the provided buffer
size, and static checks pass without warnings.

Fixes: d84c4754f874 ("pNFS: Fix extent encoding in block/scsi layout")
Addresses-Coverity-ID: 1647611 ("Memory - illegal accesses  (UNINIT)")
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfs/blocklayout/extent_tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
index 315949a7e92d..adc1fe190cfc 100644
--- a/fs/nfs/blocklayout/extent_tree.c
+++ b/fs/nfs/blocklayout/extent_tree.c
@@ -585,7 +585,7 @@ static int
 ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
 		size_t buffer_size, size_t *count, __u64 *lastbyte)
 {
-	struct pnfs_block_extent *be, *be_prev;
+	struct pnfs_block_extent *be, *be_prev = NULL;
 	int ret = 0;
 
 	spin_lock(&bl->bl_ext_lock);
@@ -611,10 +611,13 @@ ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
 	if (!ret) {
 		*lastbyte = (bl->bl_lwb != 0) ? bl->bl_lwb - 1 : U64_MAX;
 		bl->bl_lwb = 0;
-	} else {
+	} else if (be_prev) {
 		*lastbyte = be_prev->be_f_offset + be_prev->be_length;
 		*lastbyte <<= SECTOR_SHIFT;
 		*lastbyte -= 1;
+	} else {
+		/* Buffer too small even for one extent, count is zero */
+		*lastbyte = U64_MAX;
 	}
 	spin_unlock(&bl->bl_ext_lock);
 
-- 
2.43.0


