Return-Path: <linux-nfs+bounces-3734-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A0D906345
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188D81F235D7
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26611131E33;
	Thu, 13 Jun 2024 05:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhed+FoM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9060F135A7F
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255230; cv=none; b=R3+MeougiHLYc5lD5VdJEi1CNt9WCVoLgnZYRGSolbeC/ztC5XghRFBuNfY5uQPAXEGvhalMTjWl/plr8MhwkLfc4W8M5MwqDcBWmn2M1Lg2LIvv7JECLYu9fOw4TeBEmKQzjlhaCtCC7UQ6WURYmn/fDU32QKSqqZjeDBJG5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255230; c=relaxed/simple;
	bh=aT4ooRWy6Q9mHjAJ43jWjy4JB4MBPAdYv6OxUJAusvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0xry6bcsiuxe6uFt3ccKPSh9K3LjAUsz+AyZRafkj1rlpLdmSb7Hmz3WDV3bRGfpNxyNxpYjUb7G3wB3If8eFB4Fzsmpiy7in9NFFnMvg4hYnCorvM7hqCRNF+LL0Pz2tcLpfyQoTGuIfImt4DMlc9C07J+h4kzVxUTmuf6I+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhed+FoM; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6adc63c2ee0so2905556d6.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255227; x=1718860027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+nTzPMvSWl4m5h2cBhbYEHOr/LrU5BlmjvCINmnnkI=;
        b=Rhed+FoMTI+1tIt2EgDjj9eXqLNC+tBZIt+T7+kILFszm6rUCVY4jvsEd8xir9i2Lb
         MjOn24RIC+CZ6wLHtc/LgXMb1VtshJcMzjs33sDS4lPeN2YSb/8OQaDQpZuxAipNyMUz
         Sy64mwRIvF/Bd3crRmk5ZWGEUzlT6IfZu/psZl55tbcEL4l2a3GSfESseDZViHpcfQF6
         FYfvMEGK6MDH0rFd0hLg6IAF4IXvtGAXShYKTGAXZG5B87lmEYIJD5JkQHCVLsdpidQG
         HGTl3X6TfLI7hjS417I7kklJ47CGN3HNPzZZD+XtMJckLXiltiUCZPqY7dg+28YZS7GI
         fowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255227; x=1718860027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+nTzPMvSWl4m5h2cBhbYEHOr/LrU5BlmjvCINmnnkI=;
        b=TDyzSWdHt+dvmZP5ikN1FEwO6LCdTN5WVSGKeMctF9caDFnxYOSdIAWS+ABay0+aDa
         BeLso5WjFmTtD7s/eU8aeadlffeVwcBsWH/PCrMWnmYDPuaJquxUrhMfPfWQwKPjJ603
         9xh3y4aJYG7TwmJt6T8NlWFJC5I611rCR5Kcr60f5TFb6Fifg/p3gxp9wDupzCYuILu5
         y8xrhNyZLDLb0EaNXqLDLuYoUjD53fcviHG5BI3+nxpzDK9SYtkObmXniGOUqyyiarFw
         Ar/PkMtt7AQngp8ssstO2pxLl3nJWV9Vy7JQageI05CDpnlNCfpDFbd7tvQA0E54MVzp
         Q1dQ==
X-Gm-Message-State: AOJu0Yzi1i28molzDO3cEaRY/6J5vtdkivV1sqmx6fNNCZ4bcV/4I4Mr
	IvJRpVJTwsSH0hti9wj7DyqgRR4Z+zNr6GkDj7fDkB5f/A6xAux9uf4B
X-Google-Smtp-Source: AGHT+IFcR5ftOSwgtWqtUeguDAsUwiIqhPwqTuzwukZ0j6FWbnTKY38JvqdLYFkKpzveaaadqlQclg==
X-Received: by 2002:a05:6214:4801:b0:6b0:8b48:f7e5 with SMTP id 6a1803df08f44-6b191778b54mr45047316d6.3.1718255226899;
        Wed, 12 Jun 2024 22:07:06 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.06
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:06 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 05/11] NFSv4/pnfs: Add support for the PNFS_LAYOUT_FILE_BULK_RETURN flag
Date: Thu, 13 Jun 2024 01:00:49 -0400
Message-ID: <20240613050055.854323-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613050055.854323-5-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
 <20240613050055.854323-2-trond.myklebust@hammerspace.com>
 <20240613050055.854323-3-trond.myklebust@hammerspace.com>
 <20240613050055.854323-4-trond.myklebust@hammerspace.com>
 <20240613050055.854323-5-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add a flag PNFS_LAYOUT_FILE_BULK_RETURN, that will attempt to return all
the layouts in a pnfs_layout_destroy_byfsid/pnfs_layout_destroy_byclid
call, instead of just invalidating them.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 35 +++++++++++++++++++----------------
 fs/nfs/pnfs.h |  1 +
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 0e188bc303ee..3bfc74841831 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -476,6 +476,18 @@ pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
 	return !list_empty(&lo->plh_segs);
 }
 
+static int pnfs_mark_layout_stateid_return(struct pnfs_layout_hdr *lo,
+					   struct list_head *lseg_list,
+					   enum pnfs_iomode iomode, u32 seq)
+{
+	struct pnfs_layout_range range = {
+		.iomode = iomode,
+		.length = NFS4_MAX_UINT64,
+	};
+
+	return pnfs_mark_matching_lsegs_return(lo, lseg_list, &range, seq);
+}
+
 static int
 pnfs_iomode_to_fail_bit(u32 iomode)
 {
@@ -886,7 +898,10 @@ pnfs_layout_free_bulk_destroy_list(struct list_head *layout_list,
 
 		spin_lock(&inode->i_lock);
 		list_del_init(&lo->plh_bulk_destroy);
-		if (pnfs_mark_layout_stateid_invalid(lo, &lseg_list)) {
+		if (mode == PNFS_LAYOUT_FILE_BULK_RETURN) {
+			pnfs_mark_layout_stateid_return(lo, &lseg_list,
+							IOMODE_ANY, 0);
+		} else if (pnfs_mark_layout_stateid_invalid(lo, &lseg_list)) {
 			if (mode == PNFS_LAYOUT_BULK_RETURN)
 				set_bit(NFS_LAYOUT_BULK_RECALL, &lo->plh_flags);
 			ret = -EAGAIN;
@@ -1265,27 +1280,15 @@ pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo,
 	return status;
 }
 
-static bool
-pnfs_layout_segments_returnable(struct pnfs_layout_hdr *lo,
-				enum pnfs_iomode iomode,
-				u32 seq)
-{
-	struct pnfs_layout_range recall_range = {
-		.length = NFS4_MAX_UINT64,
-		.iomode = iomode,
-	};
-	return pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs,
-					       &recall_range, seq) != -EBUSY;
-}
-
 /* Return true if layoutreturn is needed */
 static bool
 pnfs_layout_need_return(struct pnfs_layout_hdr *lo)
 {
 	if (!test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags))
 		return false;
-	return pnfs_layout_segments_returnable(lo, lo->plh_return_iomode,
-					       lo->plh_return_seq);
+	return pnfs_mark_layout_stateid_return(lo, &lo->plh_return_segs,
+					       lo->plh_return_iomode,
+					       lo->plh_return_seq) != EBUSY;
 }
 
 static void pnfs_layoutreturn_before_put_layout_hdr(struct pnfs_layout_hdr *lo)
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index a6f9427782c2..8fa0f152ed19 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -121,6 +121,7 @@ enum layoutdriver_policy_flags {
 enum pnfs_layout_destroy_mode {
 	PNFS_LAYOUT_INVALIDATE = 0,
 	PNFS_LAYOUT_BULK_RETURN,
+	PNFS_LAYOUT_FILE_BULK_RETURN,
 };
 
 struct nfs4_deviceid_node;
-- 
2.45.2


