Return-Path: <linux-nfs+bounces-5936-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C31963FA5
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 11:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C39C2837DE
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA691598EC;
	Thu, 29 Aug 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6JkJ/CN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A714B075
	for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922939; cv=none; b=Ui75EcXRvnzsHt/EcHGwx0tXX4pCfHW3YsirSkHt8PBi785bTb1kIhJDqzRHTXFAMuVwOo7+WlhpuPtGDCEqjio3MY1Jc++q4dIok/4EtAOsvTPynGOM25smRmFlL5B55ZjgtEnJiAaEU7/iX8geKWADIAveuICHPkcWvsTJZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922939; c=relaxed/simple;
	bh=BmoFrtWCiBfKvihgA4jm1sFxUL09pqaYEIMZvLbV7Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l4C0dh74R/bw2I7+zAfwcXOHSqmZWwgYFzG9GWBrBFaybemQvwqDTbAB8J6fgA4R65YQbGMiIvkEmF+2fTiC50wMjNb18URDhCgqC/wCNj4Uxkx8vOKhEeMtGkIQQXbpbjAsXyLW/CWSyZzz4D49g2/oNXqPmhnxlDfXhhLqvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6JkJ/CN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2023dd9b86aso3088215ad.1
        for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724922938; x=1725527738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mEkgSX+DVMCoxQhZAeY5R4b5LfgnsREhoU2O3ZydbJ4=;
        b=h6JkJ/CNSSYzKMbcWNvVnUmqf3KRfZzpVHJTdRN4z9yMa2XQmWhwFwyW63BjmY/KSb
         ylsgmS0lKsaf+8//RF4rL63xgs4RbevVpJ7E8f9Hrk5oYpHa8AslJhD+t73S2Cw49ZdI
         uOlEkHE3PSG0vdhCmv4M9KZDWDDfrGZhpAzwES6hT970hN+oQSIVRvEU+1pn4L/FXdD+
         7wsDA/P4D3BAOjtlNbUqqJIudEKXV6SKaolrboVdDGVbEPd1fd32CY0gQAA6LXxfLHsw
         Nc3VMNcBwyHcrVYupeWcW7DGYXXxYsVGxHMKQ5+QIAQyL1QJxxx2q+Y5SSqaVFvzKv9j
         xPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922938; x=1725527738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEkgSX+DVMCoxQhZAeY5R4b5LfgnsREhoU2O3ZydbJ4=;
        b=tu8nasw5va8tQhXWVnHUg7/gDSh8n2+GKoN7GaZfewMeWDEdFLu9U7SZNaSzhUJrrS
         +noBTQshnFRaHcqrCZSJlo77vHaAP4uSefPbk8SC/IUzulGWAEKKvrvB8khSdmMiTynR
         Ez+oDRs7hKZ5rUfgcFPkeTAQ1PKs1eHX+6/tl+EemT33ErV77BlBcuZipyowvRARGA+d
         HJp5iAqzCMMAkFE/sjA4sKkj9ZiysOgALzTC2Sx0enFlFejNXRwGVn1hLRMUxgU9i5rG
         Ytp8jou3i8K1qOk3kslE62IjUkJK0MjXkzudKPAIM/Mu+SWgnssKgBoEWOaiXST8kT46
         R3iw==
X-Gm-Message-State: AOJu0Yx+0z05HCgTcUliTaQ2+mJpM0qyKkPyKSuXL1BchqgKqd0vFUqm
	SE96iHg1+PHx/Si4ntPpDBiNwtJ1z2cbGA+rOKbbSZJRP51mrRBH
X-Google-Smtp-Source: AGHT+IEWHMskOKy9AaND4DFGgupuw3JPFqOvrCax/nf4bqFwSP2F+duCMCYkXYVOQSAEU8Kj/Q+O5g==
X-Received: by 2002:a17:902:dad0:b0:1fd:ae10:722b with SMTP id d9443c01a7336-2050c4b5d0cmr31468175ad.63.1724922937691;
        Thu, 29 Aug 2024 02:15:37 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b130fsm7386945ad.4.2024.08.29.02.14.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 02:15:37 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH] NFS: Fix missing files in `ls` command output
Date: Thu, 29 Aug 2024 17:13:40 +0800
Message-Id: <20240829091340.2043-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our production environment, we noticed that some files are missing when
running the ls command in an NFS directory. However, we can still
successfully cd into the missing directories. This issue can be illustrated
as follows:

  $ cd nfs
  $ ls
  a b c e f            <<<< 'd' is missing
  $ cd d               <<<< success

I verified the issue with the latest upstream kernel, and it still
persists. Further analysis reveals that files go missing when the dtsize is
expanded. The default dtsize was reduced from 1MB to 4KB in commit
580f236737d1 ("NFS: Adjust the amount of readahead performed by NFS readdir").
After restoring the default size to 1MB, the issue disappears. I also tried
setting the default size to 8KB, and the issue similarly disappears.

Upon further analysis, it appears that there is a bad entry being decoded
in nfs_readdir_entry_decode(). When a bad entry is encountered, the
decoding process breaks without handling the error. We should revert the
bad entry in such cases. After implementing this change, the issue is
resolved.

However, I am unable to reproduce this issue with a simple example; it only
occurs on our production servers.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/nfs/dir.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 07a7be27182e..1f5a99888a11 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -310,7 +310,7 @@ static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
 
 static int nfs_readdir_folio_array_append(struct folio *folio,
 					  const struct nfs_entry *entry,
-					  u64 *cookie)
+					  u64 *cookie, u64 *prev_cookie)
 {
 	struct nfs_cache_array *array;
 	struct nfs_cache_array_entry *cache_entry;
@@ -342,6 +342,7 @@ static int nfs_readdir_folio_array_append(struct folio *folio,
 		nfs_readdir_array_set_eof(array);
 out:
 	*cookie = array->last_cookie;
+	*prev_cookie = cache_entry->cookie;
 	kunmap_local(array);
 	return ret;
 }
@@ -826,10 +827,11 @@ static int nfs_readdir_folio_filler(struct nfs_readdir_descriptor *desc,
 {
 	struct address_space *mapping = desc->file->f_mapping;
 	struct folio *new, *folio = *arrays;
+	struct nfs_cache_array *array;
 	struct xdr_stream stream;
+	u64 cookie, prev_cookie;
 	struct page *scratch;
 	struct xdr_buf buf;
-	u64 cookie;
 	int status;
 
 	scratch = alloc_page(GFP_KERNEL);
@@ -841,10 +843,20 @@ static int nfs_readdir_folio_filler(struct nfs_readdir_descriptor *desc,
 
 	do {
 		status = nfs_readdir_entry_decode(desc, entry, &stream);
-		if (status != 0)
+		if (status != 0) {
+			if (status == -EAGAIN && entry->cookie == cookie) {
+				/* Revert the bad entry */
+				array = kmap_local_folio(folio, 0);
+				array->last_cookie = prev_cookie;
+				desc->last_cookie = 0;
+				desc->dir_cookie = 0;
+				array->size--;
+				kunmap_local(array);
+			}
 			break;
+		}
 
-		status = nfs_readdir_folio_array_append(folio, entry, &cookie);
+		status = nfs_readdir_folio_array_append(folio, entry, &cookie, &prev_cookie);
 		if (status != -ENOSPC)
 			continue;
 
@@ -866,7 +878,7 @@ static int nfs_readdir_folio_filler(struct nfs_readdir_descriptor *desc,
 			folio = new;
 		}
 		desc->folio_index_max++;
-		status = nfs_readdir_folio_array_append(folio, entry, &cookie);
+		status = nfs_readdir_folio_array_append(folio, entry, &cookie, &prev_cookie);
 	} while (!status && !entry->eof);
 
 	switch (status) {
-- 
2.30.1 (Apple Git-130)


