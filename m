Return-Path: <linux-nfs+bounces-3735-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17BD906346
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1382859D7
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C456136663;
	Thu, 13 Jun 2024 05:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLzBqcmn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1E13210A
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255230; cv=none; b=scpRD6yCmTkB8xX3LfuAyb5dCdLKHzjCIzj39QjI/wd1X6xq76+FmlJcv9wmpABGJvdml8IIHrlbeUIReqUrNU6OxWCf9Ar4S9Mnh39RgOMGr8zvkybiarddAZh2EDwKhNoxV60XA/zSYmqG3VJ4a378lOYkxxRt1ETY0Frieak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255230; c=relaxed/simple;
	bh=LnQsu0aP6BeTihev6r9MalDiCOww0CE+Bb7G0p9mEm8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3uW/2qvs7ZdXVk+dNlESO1AEIC423xIdt/zeXwWnM2k2zRQaQJgI794L5zayNfTEN80SaypqaRyyLcGig6DfaJvXwZMN4OkQI0ZINS8rsInDFmfJPhFpHzNfqv1G4iT5RsCBVeyWu7NU/4uo0jLKT7Wr8eim/6cnwxTtz6Z48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLzBqcmn; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b072522bd5so3012536d6.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255228; x=1718860028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33CRu+C2JgTRZankJporQEOV03dfUw9PM9dUe4iPxTQ=;
        b=dLzBqcmnmmUX1hTA7+kYOZHEj4kLE4j/d7ZxHe4BlshAz0W8cLx+//CHTZvMdIr+m0
         LMh1LCbeOoNoImAseKVnvQGGAtOWq31hzR1NuCnl41SOHHjC7Qq+MeLssLb7kpR7Iqub
         ieTQskTTCL4EvQgAH5drIi+5LbtaBb41DyRIKSKzY2b/FKbZ55ho9D8l5nR2KbiUSSMw
         36hOKJ/dtOJuIeoELu1t7bgpWPlZ+QbGKhyARs1eG4joQ9jh/zXH24OE2NcdlvVWspw2
         RK46E31FI/YpYdxPfuh3D/WXjOMKzS0YJDq2ZSA8NL2EpG1hM1AVeX0+CbcKrXF92KpQ
         j7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255228; x=1718860028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33CRu+C2JgTRZankJporQEOV03dfUw9PM9dUe4iPxTQ=;
        b=MfscD8of84h8P/B8FPIRwnxnnQwBGasdRfWqYpjv00mR7kESg+XradMNbnmZuSNXrX
         c+DchVtRQuRyg6HbVHyoUgb9xl1zd2Qbg2DU78dIwwv54G6A2mco5cbVkZ20wbaNOMqc
         8HJEtwG7u+6MJIJm/h2XQ9MtruH0ktKyHWFGTLTqgWxjdoFW9JohYbsml4MJxdvvBV7L
         Hfrz5Ffgf6GQKKq8nkS6p3Em7GlpGQtS6I7lrk2raynvt0bAEnYSLCpLUdqw0EswvSSR
         vAtS5BzNYEv5rXBBQ5oDHEqx0z4wWyBY1nbkaK1m692DhVAkktxANQHqt2i0wAwWsDBk
         qmxA==
X-Gm-Message-State: AOJu0YwLKDuPNQAr7zVXaVvheDy1jOMVI3HKvJTAvSS26GplXPK3rvVg
	VjrvLJ1sE1obdEXCGwzDNcW1GDwRd78DcZGMpABDH1H4yuZew7HT06dE
X-Google-Smtp-Source: AGHT+IGxP49onCBYE4YlSLJjsG5M+Gm8CqwtWP4NEDhu70hkKr6eBTSHYMxSpXxDJt/Si4htzoem5g==
X-Received: by 2002:a05:6214:7ec:b0:6b2:9e65:2246 with SMTP id 6a1803df08f44-6b29e652402mr25881906d6.1.1718255227575;
        Wed, 12 Jun 2024 22:07:07 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.07
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:07 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 06/11] NFSv4/pNFS: Add a helper to defer failed layoutreturn calls
Date: Thu, 13 Jun 2024 01:00:50 -0400
Message-ID: <20240613050055.854323-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613050055.854323-6-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
 <20240613050055.854323-2-trond.myklebust@hammerspace.com>
 <20240613050055.854323-3-trond.myklebust@hammerspace.com>
 <20240613050055.854323-4-trond.myklebust@hammerspace.com>
 <20240613050055.854323-5-trond.myklebust@hammerspace.com>
 <20240613050055.854323-6-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the layoutreturn-on-close fails due to an RPC layer problem, such as
a timeout, then we want to retry at a later time. Add a helper function
to allow this.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 3bfc74841831..a79ae47b3842 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1171,6 +1171,26 @@ static void pnfs_clear_layoutcommit(struct inode *inode,
 	}
 }
 
+static void
+pnfs_layoutreturn_retry_later_locked(struct pnfs_layout_hdr *lo,
+				     const nfs4_stateid *arg_stateid,
+				     const struct pnfs_layout_range *range)
+{
+	const struct pnfs_layout_segment *lseg;
+	u32 seq = be32_to_cpu(arg_stateid->seqid);
+
+	if (pnfs_layout_is_valid(lo) &&
+	    nfs4_stateid_match_other(&lo->plh_stateid, arg_stateid)) {
+		list_for_each_entry(lseg, &lo->plh_return_segs, pls_list) {
+			if (pnfs_seqid_is_newer(lseg->pls_seq, seq) ||
+			    !pnfs_should_free_range(&lseg->pls_range, range))
+				continue;
+			pnfs_set_plh_return_info(lo, range->iomode, seq);
+			break;
+		}
+	}
+}
+
 void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 		const nfs4_stateid *arg_stateid,
 		const struct pnfs_layout_range *range,
@@ -1577,9 +1597,8 @@ void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 	switch (ret) {
 	case -NFS4ERR_NOMATCHING_LAYOUT:
 		spin_lock(&inode->i_lock);
-		if (pnfs_layout_is_valid(lo) &&
-		    nfs4_stateid_match_other(&args->stateid, &lo->plh_stateid))
-			pnfs_set_plh_return_info(lo, args->range.iomode, 0);
+		pnfs_layoutreturn_retry_later_locked(lo, &args->stateid,
+						     &args->range);
 		pnfs_clear_layoutreturn_waitbit(lo);
 		spin_unlock(&inode->i_lock);
 		break;
-- 
2.45.2


