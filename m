Return-Path: <linux-nfs+bounces-3721-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DEE906306
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A7E1C2215D
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28442135A53;
	Thu, 13 Jun 2024 04:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daVm3DJ0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD813211A
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252272; cv=none; b=VF4oDcz8nLzTf5d5bnmz58AWI/UEIXs/39yg/wedfBeWPBnJxPPErtB0Sxs6kGbhlKYK8fI0M67GC9BgNwL3b98aPIMGDbbTevzeA9ABDPQv9mbIUJuMPe4HFiMp4NtnxVJYCkz3PqdITpFhXeUsTb4inETwXsHRLLvebcrCwCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252272; c=relaxed/simple;
	bh=JUa26y4trDMjXv8kJNspKCpm0ZB2QdGxG8Rie3Z4Jus=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiE29rnduJHqKxeQcqd/zE9h51/ats3Dqm4Va5ISpFTg1hB4Hk6vN06WbOXqyM9RhtV4k0Fj9gVfVMClBnf9bmRPawn21ZIK+GENA54iDlWayT/O9DJ49oSgjMUYfG5lFPB07uHNI+JQOJg+g9y6PnqYzEGAg7B/CruszpJYGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daVm3DJ0; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfef552d425so747781276.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252269; x=1718857069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXhoor7Xv4QJH68bc35T5Xdx6w4YGZDyOa4YHXPzbbg=;
        b=daVm3DJ0qSa6dCu1W+YY8phtWl2w6ROQzkw77JTRTZfXewv3GOlJYWIugoqOc8fBIQ
         dJd+VfpEvrOJZGTe7knWrRNuiXI8qkWKf2OvCTDEMmmw6dDiMHktoAoVMFS7PbGKRxn6
         lLq5G/Njlj6zHL1rgMH8uqNOtB1WeYCujuw7ELM1W1hF9G3b2eO+fjjeBWAU2xBsA9Vg
         GWurgTW0m7ByYED03C4OSOFyX3MtaH6JNA2JX2spYEfdPqS2ZH4cqHd3WAQ2jLF804K7
         xCW/3RQYh6QpEIK58m9H4P81cXmUKzjf0eW/V9fYeG0ORxp++P7FgtBMjvtDXsGwJKIV
         jBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252269; x=1718857069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXhoor7Xv4QJH68bc35T5Xdx6w4YGZDyOa4YHXPzbbg=;
        b=rB/9aEDQQ78l7vqnzmejPU43wk303igk54cJl4cMIYBTL/TJJEcKgYyCpAGY1zhJZ/
         X7UxVj18exOrQzdk03tcfCJ6JOABTQGTYh/U0if23AEH5N9kPf4kAcq/LlZ5XKNvlMi0
         SW/LtzvaHWzhlwSvh5VpLXkdhQFPYOmz1dZIHVUg2GkG40qVYk6P8izm47KpA0j1iKHf
         PZwvoSRM76UW2jKlcQoa9Eu+7Qq3w1FNZyAhSjaNUHnL331qiYyMoEyo4q9AyBbh4i8K
         Y+y2gLM9KDSDBZqPjT+Gg/GIiaiHVT9X/kZjt8cvKsU9genwFGVUOS3r6+xvsFy/94op
         Z3Cw==
X-Gm-Message-State: AOJu0YywhqB9l6AaaMleltKAss3dsuGmtaHD2/nRZmNxEyZg3tH0i1GL
	YX4wl9J8Ko9I6sYVHHgDUf3Y4cfNFGsUoNjSPvS1u4W8f//CQHAEA10W
X-Google-Smtp-Source: AGHT+IFm0+bize7ayOACXX7yFKnmB3UcIFwBQ51TuEaD+9ahe103xHEjZIiu35kYy1UIF6OWo5Mlzg==
X-Received: by 2002:a25:26cd:0:b0:dff:1a2:a408 with SMTP id 3f1490d57ef6-dff01a2a6b8mr972119276.35.1718252269323;
        Wed, 12 Jun 2024 21:17:49 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:49 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 12/19] NFSv4: Fix up delegated attributes in nfs_setattr
Date: Thu, 13 Jun 2024 00:11:29 -0400
Message-ID: <20240613041136.506908-13-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-12-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
 <20240613041136.506908-9-trond.myklebust@hammerspace.com>
 <20240613041136.506908-10-trond.myklebust@hammerspace.com>
 <20240613041136.506908-11-trond.myklebust@hammerspace.com>
 <20240613041136.506908-12-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

nfs_setattr calls nfs_update_inode() directly, so we have to reset the
m/ctime there.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 91c0aeaf6c1e..e03c512c8535 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -605,6 +605,46 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 }
 EXPORT_SYMBOL_GPL(nfs_fhget);
 
+static void
+nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
+{
+	unsigned long cache_validity = NFS_I(inode)->cache_validity;
+
+	if (!nfs_have_read_or_write_delegation(inode))
+		return;
+
+	if (!(cache_validity & NFS_INO_REVAL_FORCED))
+		cache_validity &= ~(NFS_INO_INVALID_ATIME
+				| NFS_INO_INVALID_CHANGE
+				| NFS_INO_INVALID_CTIME
+				| NFS_INO_INVALID_MTIME
+				| NFS_INO_INVALID_SIZE);
+
+	if (!(cache_validity & NFS_INO_INVALID_SIZE))
+		fattr->valid &= ~(NFS_ATTR_FATTR_PRESIZE
+				| NFS_ATTR_FATTR_SIZE);
+
+	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
+		fattr->valid &= ~(NFS_ATTR_FATTR_PRECHANGE
+				| NFS_ATTR_FATTR_CHANGE);
+
+	if (nfs_have_delegated_mtime(inode)) {
+		if (!(cache_validity & NFS_INO_INVALID_CTIME))
+			fattr->valid &= ~(NFS_ATTR_FATTR_PRECTIME
+					| NFS_ATTR_FATTR_CTIME);
+
+		if (!(cache_validity & NFS_INO_INVALID_MTIME))
+			fattr->valid &= ~(NFS_ATTR_FATTR_PREMTIME
+					| NFS_ATTR_FATTR_MTIME);
+
+		if (!(cache_validity & NFS_INO_INVALID_ATIME))
+			fattr->valid &= ~NFS_ATTR_FATTR_ATIME;
+	} else if (nfs_have_delegated_atime(inode)) {
+		if (!(cache_validity & NFS_INO_INVALID_ATIME))
+			fattr->valid &= ~NFS_ATTR_FATTR_ATIME;
+	}
+}
+
 void nfs_update_delegated_atime(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
@@ -2163,6 +2203,9 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	 */
 	nfsi->read_cache_jiffies = fattr->time_start;
 
+	/* Fix up any delegated attributes in the struct nfs_fattr */
+	nfs_fattr_fixup_delegated(inode, fattr);
+
 	save_cache_validity = nfsi->cache_validity;
 	nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR
 			| NFS_INO_INVALID_ATIME
-- 
2.45.2


