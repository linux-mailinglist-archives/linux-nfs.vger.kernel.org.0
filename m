Return-Path: <linux-nfs+bounces-13165-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8569EB0CAA6
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 20:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315961AA0114
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jul 2025 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20ED2E2EFD;
	Mon, 21 Jul 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSrCbbQO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9A2E267B;
	Mon, 21 Jul 2025 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753123278; cv=none; b=sQGS+YWtzt7OF28544ZofF/6raEWjNrMEzUM0zKWhpP7upqrKtDJtbiYCS+8xU3EfKfb46hzCsmM1KA5PuevXgiy6jKArdnHczp34VFLdcJIZzeCiIULZdwnHzAytLy/j2PIdHhMTTA2x6vnEfUohJAD+1ssM7WP415ptH1KHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753123278; c=relaxed/simple;
	bh=8hNG9wZ0JE6FoGtgzaIMtbuagmSpN6K4kVCvXzXp048=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HroOX/0fwK+yA0W64p0UBUpf/WTyBfN3z5weomRGs7IpSlQ4K/EHICREZfn7XGBf9NKxhYdS9WYSGTpErO+MTe+fQ+rVfmunfPJ3CAYqy8copdDPshagp0H/x3kRMAjOEz60r07mbHJQzLQpiZh74Fbk5KJP0Ns7seuRf9GxUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSrCbbQO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso39727501fa.3;
        Mon, 21 Jul 2025 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753123274; x=1753728074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5ktcj173SDXe4/XzIGuJERLLK4dG9ApB39JQrJE8iI=;
        b=OSrCbbQOn6IQXLdfQZwbLX70f8QMliuQjfWY58s3iecxNVuuZN8ZgON0NHdWBKpHnT
         t/z6xYtj+paTO199KBv0J/9vCjnLXWAT8lRXdhfIjbtSI8YPVsdioHItFx3fiAnscSE8
         xv5H73zOGUB0jdx9uzA5mir949Di6LrU92r25DnWCRSvBkfQy7rS1LhWXksG/OYCjMaB
         09ERcwOYU17Ne2Gej2d0me0NvGkEXxcUWHNjR1Qz5FKmENt+1IE2NlCqfZidscQ9QyP4
         VRO0MpDoWpE9WCbftmyImbUJQqA243SUZBYQuQMibrojujXS3atqL+xlUY9dpywoBirf
         Jvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753123274; x=1753728074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5ktcj173SDXe4/XzIGuJERLLK4dG9ApB39JQrJE8iI=;
        b=eHBbOh+P4beN3VyBAjrZrhK9Gb2BPBAvNtoUTfQABelXm+m/Qfeu2sK+Jp0ZNLboMw
         qBz4aA1oxw42To3ci61wMkLDDCgK01/YMePayHT9Po3ZKY5jwvjiiqqvCnP+uBvWaKGM
         6wdJwLeN9sGmcq2f0pBsCd6sfcGBOvUD5xxEIeppRjvHhzDPZ2x73VwQQi0chqc8oqLX
         Gg7vdyYCsn/avA2Oi4axtemCP7LETjTegKt6yUKI9IXkMzzcFpnKyzAbeRfz5Pa0sRUl
         L3v8O7lavEpptJrl34/a/crvXRLQx9J+TLfxO706sd3PdVOYBG1PCvt8ZGU5qW4sXY0T
         tXDg==
X-Forwarded-Encrypted: i=1; AJvYcCU7/nvZNdhou2GkF7PRB//24x8bBR62qaYCZiAwEkKgFICousN0GviC1h9Yg+UfLULgqt2ueQ9ScCI4wMc=@vger.kernel.org, AJvYcCVPBwR+q1RCu1Jcn99JzuT+/RoXHu5WvhCu8B/1HHaj4/k+QrIdvid+Q6YweYpIkLDda2tBCxVU@vger.kernel.org, AJvYcCWnEkK+A7MnAQZ+KdP7kyeJLJlEuM6FVX9wwf+bTot15zbY6Kbmq8VIKbjLGEr3FM8S4Hw8QOg6AfX3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17nbPYPfTvMRAwKXerKaYJfVwkwuX0GgcXe0jloE76CSFRAYS
	cOl8feGojbfal5ASVKCYL2hPo38VQIAYv0Z/iFvxDEPgCxIKmlW6sT5Z
X-Gm-Gg: ASbGnctN714X+b9XLT2m6izb50V5WntyPj/Ky+/hfPrgNy2XAGyxH/SUFyAIx8EHNN7
	nrf8HSrNXapyNwhHpSv3B7VMvKH8vsnRy8/CJtvXCD4xO2//fwFGcVUE/KncXoWpn0lncg7d+DK
	0cz1obirhzi/0cRSxi0lPgyeJsY5qNYEdXg/hAzX+rKazJ58UyVlfsMlcIPG1HTYLKZIuSUgiXz
	ouQYSjmL90BeVSAB9leJLqM/F2wE+zN5ST5BsjXDxE0TWw4SpfE6shCkag1grSY9iacNMRagrSi
	QOQYsOKqbdccFRwOi+bR9QxQNQjz47Tge7NnG0pUk1rMCp/Lynbt2AN7DtmZoprZTA+A1/BKgNW
	qu0GrQILMQRSJZutn4Ecdw7nJ+8ZwIugQG7OlScQA3r/d3ebzEsF1PITbiVI=
X-Google-Smtp-Source: AGHT+IGFdgfQQ9oE8s8x5eWEmCVimaM2qWC8xpbOZFHE2zPoMEbfi3kg9s1xj/qIY0vo5leyRvOrrg==
X-Received: by 2002:a2e:bc06:0:b0:32b:5272:3214 with SMTP id 38308e7fff4ca-3309a5a7b30mr50861711fa.30.1753123273630;
        Mon, 21 Jul 2025 11:41:13 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.122.38])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a910546bsm14116661fa.42.2025.07.21.11.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:41:13 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	stable@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: [PATCH 2/2] NFSD: Fix last write offset handling in layoutcommit
Date: Mon, 21 Jul 2025 21:40:56 +0300
Message-ID: <20250721184105.137015-3-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721184105.137015-1-sergeybashirov@gmail.com>
References: <20250721184105.137015-1-sergeybashirov@gmail.com>
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
into the segment range. See RFC 8881, section 12.5.4.2.

Sometimes the current incorrect logic may cause clients to hang when
trying to sync an inode. If layoutcommit fails, the client marks the
inode as dirty again.

Fixes: 9cf514ccfacb ("nfsd: implement pNFS operations")
Cc: stable@vger.kernel.org
Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/blocklayout.c |  5 ++---
 fs/nfsd/nfs4proc.c    | 30 +++++++++++++++---------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 4c936132eb440..0822d8a119c6f 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -118,7 +118,6 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
 	struct timespec64 mtime = inode_get_mtime(inode);
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
@@ -128,9 +127,9 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
 	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
 
-	if (new_size > i_size_read(inode)) {
+	if (lcp->lc_size_chg) {
 		iattr.ia_valid |= ATTR_SIZE;
-		iattr.ia_size = new_size;
+		iattr.ia_size = lcp->lc_newsize;
 	}
 
 	error = inode->i_sb->s_export_op->commit_blocks(inode, iomaps,
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 656b2e7d88407..7043fc475458d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2475,7 +2475,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
 	struct svc_fh *current_fh = &cstate->current_fh;
 	const struct nfsd4_layout_ops *ops;
-	loff_t new_size = lcp->lc_last_wr + 1;
 	struct inode *inode;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
@@ -2491,13 +2490,21 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		goto out;
 	inode = d_inode(current_fh->fh_dentry);
 
-	nfserr = nfserr_inval;
-	if (new_size <= seg->offset)
-		goto out;
-	if (new_size > seg->offset + seg->length)
-		goto out;
-	if (!lcp->lc_newoffset && new_size > i_size_read(inode))
-		goto out;
+	lcp->lc_size_chg = false;
+	if (lcp->lc_newoffset) {
+		loff_t new_size = lcp->lc_last_wr + 1;
+
+		nfserr = nfserr_inval;
+		if (new_size <= seg->offset)
+			goto out;
+		if (new_size > seg->offset + seg->length)
+			goto out;
+
+		if (new_size > i_size_read(inode)) {
+			lcp->lc_size_chg = true;
+			lcp->lc_newsize = new_size;
+		}
+	}
 
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
 						false, lcp->lc_layout_type,
@@ -2513,13 +2520,6 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	/* LAYOUTCOMMIT does not require any serialization */
 	mutex_unlock(&ls->ls_mutex);
 
-	if (new_size > i_size_read(inode)) {
-		lcp->lc_size_chg = true;
-		lcp->lc_newsize = new_size;
-	} else {
-		lcp->lc_size_chg = false;
-	}
-
 	nfserr = ops->proc_layoutcommit(inode, rqstp, lcp);
 	nfs4_put_stid(&ls->ls_stid);
 out:
-- 
2.43.0


