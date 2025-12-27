Return-Path: <linux-nfs+bounces-17315-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69716CDF5F2
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 10:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0426930006F5
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 09:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CEC14AD20;
	Sat, 27 Dec 2025 09:21:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF083A1E6F
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766827303; cv=none; b=cdXaRoONe7H0UsyE2IN+DPhlfot3FLBhw3oSs1Hb6q6gkYbRNWBqJXpKhdOcujpat9BpJ55/cGfsPHs+nRUanqfnQsOg0rNoM/i/LvfHw7SKC4UQM1Ek6lk+gScJWGkey7wifOlMcI9nj1bEaYXGBEnE+xYzByQAjBOuQfYFc3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766827303; c=relaxed/simple;
	bh=fFwVVGcJqrVkxixMvj0z+94H8UkeF6/gwS9QJIkCfgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfZz99zdxlvgdtTG0QSxiqbSWtK5izeAAzvljmVYGSkLn2A3R0FLnLO8TIUIQ+3kUhwuabWEjyjZZ5FtysjRBQNbTgRX7e3Alj5DJmJA2U151tMSam0Y91hs89NIKmIp/SNlai8KDoe5bZE4FnRAuUlkIp1FVLgPWSqPUaurpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso41830715e9.1
        for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 01:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766827299; x=1767432099;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=59SrHxI4ZbwtTifag7GL5AVm2CT81Vegw7xpSqOU7RQ=;
        b=Ob0mnu1TIfQSchmZZt385BOFOAx3V6NPRpp991HzbL6NTaSwxHXyCb+OKIFJmYYUXC
         YVHsjo28ZdzyK6UhDBxfieAWS57lsD2ObOZoX+c3Wv0/Eu4GL7IWgqerLaMnuBm3xt0v
         4ab+WtooCAV53d81meuXjWgGsMf+zkmkTtdRVoc76uhFA6EPYKOO6Uur079B2lNWd49/
         PbgtBbW9u/t3On+XmistS3kxoTsdDPpOX3jbzHuhErE8TV5JFDvgeA9J72CWpWEvvNgu
         iJLJdqjf83f8O6i69X//o2xvBVvDO1izsDscpj/fBBHt2vHwpq6S7hYF5BoKtgKvIK7g
         we8g==
X-Gm-Message-State: AOJu0Yz++EgAJea9xiN0zqzmD2vMTAchf9Og5Mundyz8RekDoEW99AWu
	MNyjqsbNQHfuprfVWoUPdjLAfP8hBr128p706TgZuOh4+hhIwW7qjr1ExfqsNPkE
X-Gm-Gg: AY/fxX6kgIURT8fTv2mQ/9RjDqktDHf+XaHNbkv2gJKv7xQD38QFJClPvNt0HUQult3
	IN3fbUx0FmC0RqUYIh6enxmCpG9AlTxB/Qi2roZQIrd2MHnjtJpPV+d8qvwZY6l1RGp/w/gFrK0
	lDhD8p+hAaaDAUyGYO9TSyNSxiQ5g+xFdEKEIHbDkw+krTtmCdomrC+0SRqWZbeL1Lnr8i+5EwU
	ZDOr2Sy5d7EpHxNjO4zD8Q3l/3edDvl+Y0stNdhC2LMz9F0FdKhT3UWo4HcYeatyL1nhgd1yMtP
	xyLbTR1Lp6hdWYNWHUqAIfutot3eeQpvqi65I1WnBo1tbFx4rPAs53Xeo73vl5KGrxnFH25GYW1
	eQFvVZ++IA6sZ1lraZeJdwJpbJHoLNGiiJzcCVC8Ude8IUldQkOObGqa7U6abZABtxBCP+HyE0v
	XzBQ3SeQU/XJK7cKCL7sIodDWJALTaiAuP8NHVBA6+ERUWMENjCX1zXCxx5TAsig==
X-Google-Smtp-Source: AGHT+IF0eeYNo3PTc+8jIo2rSX//1SOFrSiTj7hiJsp1esNhnBjkF6H1G1l2taFKv5TKHNaORH2lkg==
X-Received: by 2002:a05:6000:1ac7:b0:430:fafd:f1ca with SMTP id ffacd0b85a97d-432448b7e24mr34864923f8f.16.1766827299204;
        Sat, 27 Dec 2025 01:21:39 -0800 (PST)
Received: from vastdata-ubuntu2.vastdata.com (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm50651947f8f.37.2025.12.27.01.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 01:21:38 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] fs/nfs: Fix readdir slow-start regression
Date: Sat, 27 Dec 2025 11:21:37 +0200
Message-ID: <20251227092137.229156-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 580f236737d1 ("NFS: Adjust the amount of readahead
performed by NFS readdir") reduces the amount of readahead names
caching done by the client.

The downside of this approach is READDIR now may suffer from
a slow-start issue, where initially it will fetch names that fit
in a single page, then in 2, 4, 8 until the maximum supported
transfer size (usually 1M).

This patch tries to take a balanced approach between mitigating
the slow-start issue still maintain some  efficiency gains.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ea9f6ca8f30f..514a2aadf612 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -72,7 +72,7 @@ const struct address_space_operations nfs_dir_aops = {
 	.free_folio = nfs_readdir_clear_array,
 };
 
-#define NFS_INIT_DTSIZE PAGE_SIZE
+#define NFS_INIT_DTSIZE SZ_64K
 
 static struct nfs_open_dir_context *
 alloc_nfs_open_dir_context(struct inode *dir)
@@ -83,7 +83,7 @@ alloc_nfs_open_dir_context(struct inode *dir)
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
 	if (ctx != NULL) {
 		ctx->attr_gencount = nfsi->attr_gencount;
-		ctx->dtsize = NFS_INIT_DTSIZE;
+		ctx->dtsize = min(NFS_SERVER(dir)->dtsize, NFS_INIT_DTSIZE);
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
 		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
-- 
2.43.0


