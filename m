Return-Path: <linux-nfs+bounces-3722-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC2C906307
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3171C21B15
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D2D135A71;
	Thu, 13 Jun 2024 04:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khUykbhp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9BD132126
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252273; cv=none; b=LNoPOhYfvNbM0SjyeV1koR4LSdA0pKaYr5lXd8fZyjkn7OhMPWpTxlo6NoRKeGQ686PmaR7UnOgZvq6ojOX7KyIZYrqIp4xPJZj1W1Pe/md5yFQMIGlEAdCTvPItHu0EmNmjL6p4L0QuXDxRji1+G2o5c5XMVy+NpQvCsA8Njvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252273; c=relaxed/simple;
	bh=G27ACknVe5YVvRgo+hV5Oonf899wVt4uaegDn9bmehI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX7oTUnULOpTBzf2Ic3G2ZMgmNCUqUAZ7aGdARJM3lgSx0h/6QMGRd698FiIUFEJ2BDxo4i9n6b87XzI/zxJhNsD7rc/yP+/FPoWZwO5b/1u2VFdziAOWQneNoWJwjfXy3UB4szWnUkmJUPimRCJbyCYeV55Ipo1a0dy/yRomEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khUykbhp; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dfab4779d95so623125276.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252270; x=1718857070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DBuH0RuQOohPHmiRiU+vGGomKOGtGnHlYyjvtJmgSA=;
        b=khUykbhpYEGkKk5yTHNP0zlS90SyHitlXzNBP4wIvTqlMyJxfZmJBMmks/4xtxCPEG
         NJdRqw4AjnJwJ1/9z8XgANj2181Z+LeSegDtBrPJiJomixSVJkgwqzj811jcfkTgcQnA
         QjS+KJl3EuNbjiKUjXX2f+hZgDr9gZfw+snjWzZ86fERCwoOscFkdEGrt0DawTGPR+SA
         A6AO0tlb4tmfQTAcMz5RdPGVCKbzjPJ/jxZnWBIwT89MW7HooGb67bV6R01lqUjGabPh
         l1X1HgGR7bhObelvM5lYeTpXIIYa9g+tezloVsN2qrU8YxuJlPrqjWQUlnn96itLQkBt
         czUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252270; x=1718857070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DBuH0RuQOohPHmiRiU+vGGomKOGtGnHlYyjvtJmgSA=;
        b=LTC5OoynCSCWMzxN1PWbyeqqPxZCUTyTtnGJHJopfAcR5mi3DOKQ07LGzAdlRUuXQB
         +N23hniPX8eJRg1HFJM+gLTX1/l6XsHzoCsGVJ1oBT+MXhkjJAZMUK8Tv8yIi7PRGkho
         XLC9est7yxmlixQcFsdCS/1QN4Ywe4SQhX9EZb7EuJxUpXg8M6oU/wqW4tAyqt22lI2P
         dbUeLm/IRSHaCzn9g4Jv0aLNrnEeqOzdMmBgY6tj/rIX8MvdybaH5cZ6win7K71txzda
         XgUoGL13NH2CDKZmYOylhPXMvN2YoCx2WPT24PkU/AgNGA+H80c0zehagIh7sr73KQvg
         eEVA==
X-Gm-Message-State: AOJu0YzJ+baDKZ8gfDWbZJMqbledbUCx7Kmt6KwwC8EVJ6WB0JTg2X4M
	Fo0Xxhousq5eqxrb3X9c6XxdezrREfw9wIZm/9IuauwZBQZZ1zAIIuv8
X-Google-Smtp-Source: AGHT+IGcOTyWteDQNy+wdRQkSm8RnHpkTKhC6iuV1shuWif9Gi4bu4Rg8JLYXFU34PEWQO7phvCd+A==
X-Received: by 2002:a25:aa43:0:b0:dff:237:4cca with SMTP id 3f1490d57ef6-dff02374dd8mr1160906276.7.1718252270345;
        Wed, 12 Jun 2024 21:17:50 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.49
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:49 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 13/19] NFSv4: Don't request atime/mtime/size if they are delegated to us
Date: Thu, 13 Jun 2024 00:11:30 -0400
Message-ID: <20240613041136.506908-14-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-13-trond.myklebust@hammerspace.com>
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
 <20240613041136.506908-13-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b0c1564a7bc7..512268c732a1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -310,6 +310,18 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 		dst[1] &= ~FATTR4_WORD1_MODE;
 	if (!(cache_validity & NFS_INO_INVALID_OTHER))
 		dst[1] &= ~(FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP);
+
+	if (nfs_have_delegated_mtime(inode)) {
+		if (!(cache_validity & NFS_INO_INVALID_ATIME))
+			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
+		if (!(cache_validity & NFS_INO_INVALID_MTIME))
+			dst[1] &= ~FATTR4_WORD1_TIME_MODIFY;
+		if (!(cache_validity & NFS_INO_INVALID_CTIME))
+			dst[1] &= ~FATTR4_WORD1_TIME_METADATA;
+	} else if (nfs_have_delegated_atime(inode)) {
+		if (!(cache_validity & NFS_INO_INVALID_ATIME))
+			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
+	}
 }
 
 static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dentry,
@@ -3414,7 +3426,8 @@ static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 		.inode = inode,
 		.stateid = &arg.stateid,
 	};
-	unsigned long adjust_flags = NFS_INO_INVALID_CHANGE;
+	unsigned long adjust_flags = NFS_INO_INVALID_CHANGE |
+				     NFS_INO_INVALID_CTIME;
 	int err;
 
 	if (sattr->ia_valid & (ATTR_MODE | ATTR_KILL_SUID | ATTR_KILL_SGID))
@@ -4958,7 +4971,7 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 
 	nfs4_inode_make_writeable(inode);
 	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, res.fattr->label), inode,
-				NFS_INO_INVALID_CHANGE);
+				NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME);
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	if (!status) {
 		nfs4_update_changeattr(dir, &res.cinfo, res.fattr->time_start,
-- 
2.45.2


