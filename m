Return-Path: <linux-nfs+bounces-3976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D332D90C50D
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75B12834AB
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75DC154C15;
	Tue, 18 Jun 2024 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqNg+6e9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48940154C00;
	Tue, 18 Jun 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695400; cv=none; b=DkNPrfzF4JUELBjei7/T7semTayN9JXlaZdZJKUPLXB4rUcFZOVsvlKwSphGQFusM0egLmcvmULHyWTKCxhACV1LxZLiWlY6FRmIO91pWMD2Y81utINw34SmUIZNxpZAZVY2HTTJxaCNCAkQyThZ2wI8R6/7SNDNlvuWFjiWGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695400; c=relaxed/simple;
	bh=SCsuJ+kfzDOMEQ57UrziTxcGFOjstcZqXtS5oCJ1WXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MNOVgb8KqRxIj+Wk+wi2j2lSK1wXW73SDo5BPhv0zA6GZySb0RLhpAXRzR4OlTVVewgTbcBsBvKFhY8wqH/PwkuQI8Rflj9p1qzjpxnX6T4M1UI7FUs1fS+MvlQ2hFGMuVsRAyPuqyK7UqZhNpwoA3bz559f85Pyx2phP2w/ZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqNg+6e9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-705e9e193caso2088015b3a.2;
        Tue, 18 Jun 2024 00:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718695398; x=1719300198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n7p6iRUSW5XVR70B17ZTO0vLEn0KFEfKaxRI0vxTAiM=;
        b=hqNg+6e9XoplbgmtkinhKOtcOw91xvatwus2dS9sHoLk/AqUQRKWRVdzcA93e5+FHo
         l9pruqhluNglUQ/4WTs5qGmqlm1morVlpabsSWReVP6ddvQAZzy/rNoqryxlv8RNH5bF
         qbH1H+vUaEbTPTegdjFVmGS4OQVdbP3dHLZ2YrP3amXwD/bMrE5ZCUTip1rHSAAoNTA3
         ZfzPfyACOr5FFUXElzlA5eWgilzEzFVAXvHSzGxuYBhr7T+mq47bFdNjkNaSZoUhbjz1
         3eyr9cD1iAACkq6FJ8HS0KVdaXn1fHjvEqKycKYgN0hDbIokI1Gw2khLKyCvz3wwGOMC
         GKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718695398; x=1719300198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7p6iRUSW5XVR70B17ZTO0vLEn0KFEfKaxRI0vxTAiM=;
        b=Ya8oJHIiTdWzqEBZfAgcNXwkTTGa8EoIkqbu3shfDeCWtXbVuJipepabJT4g8d8FND
         4j1UmBzoEKCvD/Hd3quntsK9eBGSEXyo/P6e0UCJ6RxBIh5eSyy82QNr0mm/l7Zvv9xi
         qvMchotTc+jXxwkqq3OaP1oWzTQfsdEunlMrGwFRI9Dt6ieB7n2Wd72gwKqdWl3kp4xh
         PDZ+5LiC7+bYinz2N0aByi/PBgnlIfCEuxU1kMoLmnNuIn6biSfABKK24thM7Gj2cQEv
         rNP2Q0mVmtPKh4NiuF3CkT63tGbFcLNpHZxy+cnoVfkAPG2RP4JuFZqBDLngfys5l2Y5
         flDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXrtYS6AmRTLxwLOu6V/FNN9ji1ET4lzxurK+BbIjLbqO7FPfyvhFC7P56kKQWaua4cIQzkORsijvn120hTE9AjVdCyh9JFzkauuFGUZzvxk/AXieedwHc/0WNQ7XLeHo8b5AFhr1obz5X37ex28aRdzG/ne03VeyQYmvMNg==
X-Gm-Message-State: AOJu0YyaMSxPTOii4griQFHQ7uljs4dAFZqHmL7sJtb9TeGz3JXPrSJx
	IMYDxtG3V6VM0Zpza3/UTaAVaZnxu+grzgOmj28u5bf757OWcQ1A
X-Google-Smtp-Source: AGHT+IGLgq7HqLryiT2SHaAY/eKo2T49wUObwJ5Wedf9z2+YS6ZtJtX6QZyW4RjJ+hSMRnucE8IAoA==
X-Received: by 2002:aa7:88cd:0:b0:705:befb:fcd2 with SMTP id d2e1a72fcca58-705d71b105fmr13944511b3a.33.1718695398519;
        Tue, 18 Jun 2024 00:23:18 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4aa4fsm8396536b3a.131.2024.06.18.00.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:23:18 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org,
	sfrench@samba.org
Cc: anna@kernel.org,
	chrisl@kernel.org,
	hanchuanhua@oppo.com,
	hch@lst.de,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	neilb@suse.de,
	ryan.roberts@arm.com,
	stable@vger.kernel.org,
	trondmy@kernel.org,
	v-songbaohua@oppo.com,
	ying.huang@intel.com,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: [PATCH v2] cifs: drop the incorrect assertion in cifs_swap_rw()
Date: Tue, 18 Jun 2024 19:22:58 +1200
Message-Id: <20240618072258.33128-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Since commit 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS
swap-space"), we can plug multiple pages then unplug them all together.
That means iov_iter_count(iter) could be way bigger than PAGE_SIZE, it
actually equals the size of iov_iter_npages(iter, INT_MAX).

Note this issue has nothing to do with large folios as we don't support
THP_SWPOUT to non-block devices.

Fixes: 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS swap-space")
Reported-by: Christoph Hellwig <hch@lst.de>
Closes: https://lore.kernel.org/linux-mm/20240614100329.1203579-1-hch@lst.de/
Cc: NeilBrown <neilb@suse.de>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Steve French <sfrench@samba.org>
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Chuanhua Han <hanchuanhua@oppo.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2:
 * drop the assertion instead of fixing the assertion.
   per the comments of Willy, Christoph in nfs thread.

 fs/smb/client/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9d5c2440abfc..1e269e0bc75b 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3200,8 +3200,6 @@ static int cifs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t ret;
 
-	WARN_ON_ONCE(iov_iter_count(iter) != PAGE_SIZE);
-
 	if (iov_iter_rw(iter) == READ)
 		ret = netfs_unbuffered_read_iter_locked(iocb, iter);
 	else
-- 
2.34.1


