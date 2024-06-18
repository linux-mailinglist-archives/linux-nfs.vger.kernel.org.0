Return-Path: <linux-nfs+bounces-3975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF7790C44B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 09:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3011F21AE4
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD4413C805;
	Tue, 18 Jun 2024 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeIblFJ2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DACB13AA5E;
	Tue, 18 Jun 2024 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693829; cv=none; b=GLi4QCCOSvvirMIvhXVQZww5Rs++z4YTo/tjQB0dfHI7j1i1PdmSNnoirp4wuujMggUg5dQboAAMwFgxTQEhkti8/57pFrJYAuxSCnBiH5VflPMNKXqXWmEVZOZeKfEVuPLb6YlgTFoURG0WwHDv6oAGHTpA6YQO8apJzlgXmog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693829; c=relaxed/simple;
	bh=aXpZbCmgX6agv4GtPNMTFIx+xSarK2fPZBoKqm70O9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KeVSaJipR0iOV7ie01Z81uU5oqd5aswOeQa2pgm3G2e4ZhUBLDp2tCJHusQUW23G3fSY0i+Oe4QlI4zphyAxcL27ydsfE2wgRrshjGUyLGXpvCrT435xpXHOUCavuypOIetlqCLImlZZK7qqhLVeEZpDl9fzhbyld+VmckMa7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeIblFJ2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f480624d10so42051035ad.1;
        Mon, 17 Jun 2024 23:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718693827; x=1719298627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KmF6KPc9+GZruNyUDMjMgjUoCjmX7IHTZKqjKvSeh3Q=;
        b=aeIblFJ2ESs35SjVkjPCUzQ+7T7XCuedn3IXWyqubKTzt8+0y+RUZkzKYcwpoDLI1y
         3J1/UTT1iMUoH+jHqQJxKGjp2Ivsrs6J/p3B5fUw6auPghOsJ4dSyUFr2ZjD/+Rg2elo
         K35VfB175sYK+4jsc/czEe+pXQa7EfLbLKX8RRPakWFyfmDcD+B6SzicQzzXscU137IA
         BoMmI9vouzGRgjeBMDgfrwvMBnnYYTVCR06rnEr8Zg9G6NZm+IT8tWV0T2PwPbSGq/vw
         iJQJI9IxZOUKHSwTARFRgjtXuxUzJlsacuJuo5Ck6zG1RgbCRlPW7rZz1HXPouqrgQLq
         dl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718693827; x=1719298627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmF6KPc9+GZruNyUDMjMgjUoCjmX7IHTZKqjKvSeh3Q=;
        b=strhEOmj2MX/F6eNSvNw1Fcn6Q/e5PDknWjDV1CEo+Aqs48slNbGfzkyqSInP287QV
         UIhZhHGXAbEOcswtIRITqmPall1y1zD9ugz2vmXlQi8UbAgQNn3o2h4Ba3+1gZ+hsaZK
         /nIkA7d6yRD0vSvt934JjXSvBTRo8oHNS5uLTCZxA9etFjiePFeXYHrYqtmvrt860tWP
         PNQWWHO6No4TUezIqg5BckKVx4R7jxCp5KbZkeMpP02+usv8u18c4FlVNdb0vUL+eiky
         J0z+CRjksHsNMXP4L4+CHgFvVcdptOd24ABuwVKUUHjbi+K5lX60fj4Ltf6RrxmWThpB
         lmWg==
X-Forwarded-Encrypted: i=1; AJvYcCV1UMvM6Z3ZNrdM24qFnGe7fgtk/R8HN418d9N0NPbyIIbaske+QKi75Zq3HzgE9um5ErHwIfyAy8PllfywEFsG3BJLe9iSc1G345Cn5Hy1PpeCl1vinnr0Ww2BUSdHJbyWYgYXGgAdUQDQM0shgbGI63zBU0WUUIneVLCbsg==
X-Gm-Message-State: AOJu0Yzcu61R6T1iLUIctChKv/MUwya+TAN/ao9DuD5v5s7AqGct0g3y
	szQOs59LB3X8J4lbNqE5rlAIZVpnRdzKTVQQZb0ULp7NqoJBZiJq
X-Google-Smtp-Source: AGHT+IHMal/AokP8mwiRaq7bZ9i72VrxZV0AeSOZR7Q0WLxVY4/dev/bAUoih6DePWgeyRaz3HVOZQ==
X-Received: by 2002:a17:902:f682:b0:1f7:1ba3:b91c with SMTP id d9443c01a7336-1f8625c0724mr165605715ad.1.1718693827416;
        Mon, 17 Jun 2024 23:57:07 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e80ef6sm90156395ad.115.2024.06.17.23.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 23:57:07 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-nfs@vger.kernel.org
Cc: anna@kernel.org,
	chrisl@kernel.org,
	hanchuanhua@oppo.com,
	hch@lst.de,
	jlayton@kernel.org,
	linux-cifs@vger.kernel.org,
	neilb@suse.de,
	ryan.roberts@arm.com,
	sfrench@samba.org,
	stable@vger.kernel.org,
	trondmy@kernel.org,
	v-songbaohua@oppo.com,
	ying.huang@intel.com,
	Matthew Wilcox <willy@infradead.org>,
	Martin Wege <martin.l.wege@gmail.com>
Subject: [PATCH v2] nfs: drop the incorrect assertion in nfs_swap_rw()
Date: Tue, 18 Jun 2024 18:56:47 +1200
Message-Id: <20240618065647.21791-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Since commit 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS
swap-space"), we can plug multiple pages then unplug them all together.
That means iov_iter_count(iter) could be way bigger than PAGE_SIZE, it
actually equals the size of iov_iter_npages(iter, INT_MAX).

Note this issue has nothing to do with large folios as we don't support
THP_SWPOUT to non-block devices.

Fixes: 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS swap-space")
Reported-by: Christoph Hellwig <hch@lst.de>
Closes: https://lore.kernel.org/linux-mm/20240617053201.GA16852@lst.de/
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
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Martin Wege <martin.l.wege@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[Barry: figure out the cause and correct the commit message]
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 fs/nfs/direct.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index bb2f583eb28b..90079ca134dd 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -141,8 +141,6 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t ret;
 
-	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
-
 	if (iov_iter_rw(iter) == READ)
 		ret = nfs_file_direct_read(iocb, iter, true);
 	else
-- 
2.34.1


