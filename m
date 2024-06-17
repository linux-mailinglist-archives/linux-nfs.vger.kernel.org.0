Return-Path: <linux-nfs+bounces-3947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E290BD6E
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 00:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BC52819C2
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 22:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2418FC60;
	Mon, 17 Jun 2024 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNrRdJ/5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08139225AE;
	Mon, 17 Jun 2024 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718662711; cv=none; b=HP1Y0fUDlcBt7zojfP72WxZY4KNg3Na8S1q9b2vEFH3JlQ+MBW/LG6eDd/i/Ipy9Seh2MNZUbbJdtqJGmRkA4Sg+duwKQV3ns8sYUmuWPiGdBo7F+wMrs7dRbRM6awjcem2Bq3fdywLIChVmUiyEJ7yeQklPHDkEHuMv+iLzslQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718662711; c=relaxed/simple;
	bh=s5uDqeDxkxeHEEuY3eafRrrftRpfKweQTcQHgylYD6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=casi4vwYhJKvCslzobp9F/F7bf2io3ocz1w+scS6twyTX7mfO1pBYy8uKBoIDf2Vf4NG2YmdXxZxjlM8FpuNBTa46nIkDaN8v1nO440ydRO2PbrqkH7EV4gdMvYkAgpFwt74VZDfpoyebtAHrKid74XS0sp/0FZBy65sSmSskSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNrRdJ/5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f44b5b9de6so37901405ad.3;
        Mon, 17 Jun 2024 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718662709; x=1719267509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WgpPhgSpGnuAzgyitgZqw4rkMCpmuPP+oURq7WdfToI=;
        b=CNrRdJ/54B2qiaazcIvrSUddnbcErfEM1GpXM16qKUYw6fiWuU5PtqNXSUL4rS8DkY
         fZBXTE3pZlNnjE3lj7YkSerZTlKGfby5X2jbxud1C3PIfT2zfNsQhcfT0dFwJ3SjHGKZ
         HLfXBLO9QFmSVt2XXNjvjnhMmU0+qKlIaWt1C3EWdZbkPBy7O2nCkYHejWpduLDooe1J
         ifakLn+fYZbBwq0MCbFB108KvCEb3ug/iDWsgNsGPndDPnKRqcOJpd1nSxAOB4PLtfPA
         4HKasGG7IHwTusuHQvYW6zNgkpQyLFRrFb+cuVdRy+gnkLrJrJfGPVfltv1fvZZMCOio
         j7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718662709; x=1719267509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgpPhgSpGnuAzgyitgZqw4rkMCpmuPP+oURq7WdfToI=;
        b=ZSaWPA+QoOuuHmNQ1tNAcq+E2huoyVrzAsAXJ/kguBfA0tmdNBnYBgkpRxk1n9i3eZ
         bgeuxATCpYAD22YokMuThf9PiWjPckg/zeIiWnVZq1J4AUi2xkL1plQnpWCnvpSZYRtt
         d17hscDk5zzu4cOPMmjKOqPZUGDkhJSVOLx5PGXVw3VDND3VwxP1iM9AHbiOrE8JHU36
         Yzs1d3DFWvAaFvKRekJmR9IlBKD1/rxt2fu2PizIaYkqSrra1Q0ooAbXOdYPTUq2atcF
         7PVwWrzFav64Y7BL9H7r7/2c25QwZOCZYdZjtcaUJIcgdf3XJQ7OLLd6g+6QU74ZAI7s
         n5mw==
X-Forwarded-Encrypted: i=1; AJvYcCWnJo65uUdKhtEaXtr5VFlOn42IHXrfSgzROGJynz1t/F7Tpazc7GUSHt1a9fChBCrKBBZtq05vmvi854M2YR0t8Ls5fw/w/VhdA0jrlK9j6wOZvjxqnGdDLoC9yqKGSTID
X-Gm-Message-State: AOJu0YwKFzznflmEDw6rWo/vY1UPTnQd82MDORdYSU53LIsA5P0e+pU3
	HMd/qg21aV1Feh9uDvi2Tnsd8iOV+MJfK7QhroTmVBAWdcopHxbu
X-Google-Smtp-Source: AGHT+IFXZ4im6gENWa2acZ8xmU8vtV5qgUZB3zXzpkFv4olxojNSGSoqXbVj1YMNI4OecFpSuz2idg==
X-Received: by 2002:a17:903:2348:b0:1f8:67e4:3977 with SMTP id d9443c01a7336-1f867e453b5mr102032975ad.34.1718662709286;
        Mon, 17 Jun 2024 15:18:29 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee6e7esm83944365ad.139.2024.06.17.15.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:18:28 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Cc: linux-cifs@vger.kernel.org,
	sfrench@samba.org,
	Barry Song <v-songbaohua@oppo.com>,
	Christoph Hellwig <hch@lst.de>,
	NeilBrown <neilb@suse.de>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Jeff Layton <jlayton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] cifs: fix the incorrect assertion in cifs_swap_rw()
Date: Tue, 18 Jun 2024 10:18:13 +1200
Message-Id: <20240617221813.58244-1-21cnbao@gmail.com>
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 fs/smb/client/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9d5c2440abfc..2f11f138c57d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3200,7 +3200,7 @@ static int cifs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t ret;
 
-	WARN_ON_ONCE(iov_iter_count(iter) != PAGE_SIZE);
+	WARN_ON_ONCE(iov_iter_count(iter) != iov_iter_npages(iter, INT_MAX) * PAGE_SIZE);
 
 	if (iov_iter_rw(iter) == READ)
 		ret = netfs_unbuffered_read_iter_locked(iocb, iter);
-- 
2.34.1


