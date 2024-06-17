Return-Path: <linux-nfs+bounces-3946-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC3090BD38
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 00:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC650283FD7
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 22:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A65190664;
	Mon, 17 Jun 2024 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIQeyxAk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4207492;
	Mon, 17 Jun 2024 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661811; cv=none; b=aYX/t22e7MWoAahoEhJP2vclDDNsFAhEt5glX47Nu0HQWadYrZ/j1H2UBCCEb8r4EAxFHOLcjHLYsu0cGcNO0/fnc/MtcVshWSL9KeR+x742p3hg9KaoY6AYb8dcJTt5KxjRResuDJ5ISwOZTjhYsS+vZ/LMLyA6gjMvnGKvLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661811; c=relaxed/simple;
	bh=JeRfqVsQjqxDYKThVMdHv+1/FYBdVvbNZXaE7Z6ggS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GRvwlBMBo1WRssm5oRPAiw/sLOiwF6reCM8Y27Z4oLeXhpYFXyqAvXmfIQ3v3q7Z3ZnOKfQ+G6QppSKkCl0lZs9Cq8SMzwvBqlwZioFClScMVlILKW4YiNTBQkw5LMniU90iNLbGrbGMAQu+Kw/kl3tbsL1ssa/cHACIDqNqbow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIQeyxAk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7042cb2abc8so3506750b3a.0;
        Mon, 17 Jun 2024 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661809; x=1719266609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OthT64InZoPSjxn4tC63hXPySB5WxWKH+1+hvHHCkCU=;
        b=HIQeyxAk+cqWDUVO+OE0FpqswN/W3iuaEBN6qvCddgNuZFKdWt3O5cFpXJFiQRLfNi
         R4b+akVKFYTRtS05AoVtHJXzbB2q9dthEXqEXNKn6lT78dnmtEVDPoCxucTSSoSOUXbA
         V2TxQs9+Y6bmhrG+hxxpgLVFu69VS2YBpgCdK4osIBrYDMFgTYMcCDXdyj84i47cBgEE
         3frofH1Th3K3HuNXIB9GYvrXWXszh/G4toPRl2zRIX0cNWmm97ueW2h6Ahjt5D+BS7NI
         O/1xGxE1EsrZGDfYDjkizx7N4RoGC5mf0UEX24CGJtrtHFusx0DTUORhsufy6qCrs6o4
         WXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661809; x=1719266609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OthT64InZoPSjxn4tC63hXPySB5WxWKH+1+hvHHCkCU=;
        b=TRjy5uNi7yg1uaTS10MIoakYkxn7VY8Vpc1t0XCe/JPcs9bITWJwoU/tpoerm93WAR
         cEc9M4ldRPtB/mp8uxsxayQtDjeaDm+EkwH7+5yo7eYIDrQCz74YRGYxXcfExvzKNnkt
         VhKn/wFnI74112qepDkY5SMkMrie2OOw1KPahjEm9UGwXC6k+Ci/fpq0VNSvRpKemkOv
         gsOhIH3uAxUiDfVQ0/iu+Ll7TllupsfUnXUoDbXo4Id356zGjZ4XUE1RT0sVWx1NJ+i7
         AEotyCc2FSE4OPQn5hX9vyE4IY+1qF0i3LmIe6gKeBHT7P6+5sBK+g11mcptnqvROrW+
         KzOg==
X-Forwarded-Encrypted: i=1; AJvYcCXNc1nUO95qiNdYSLTOkzj73Q09FsLEZm9R+Pe7yUrGNxmPbML8Z4szCvj7VvPb4+cQxq/Djsq3xOLd4g2f+AD4ScnasbxF6m/1s0vwWa503VAgzwW1KCbiYGD4fihpsIl8
X-Gm-Message-State: AOJu0Yzw8g0Xh7aKl3LUEPj6xbv6Dp4hLDzgc7XpstwMiuWYP3l95S8b
	HB4A1jBFMTnImYSuBaNBTWCENDtLsP9B1/qsjBniAPca4TzvbBEV
X-Google-Smtp-Source: AGHT+IG9I5vkz7rxNTFokc77oylq1cp4BaWMyV8LYpDzB0f5nXtaQTES9UcpoMyRf5qpPVLsCCExLA==
X-Received: by 2002:a05:6a21:6da3:b0:1b4:4370:60f with SMTP id adf61e73a8af0-1bae7e1c9e6mr11360428637.1.1718661809341;
        Mon, 17 Jun 2024 15:03:29 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91dc5csm8079864b3a.10.2024.06.17.15.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:03:28 -0700 (PDT)
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
Subject: [PATCH] nfs: fix the incorrect assertion in nfs_swap_rw()
Date: Tue, 18 Jun 2024 10:01:35 +1200
Message-Id: <20240617220135.43563-1-21cnbao@gmail.com>
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
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 fs/nfs/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index bb2f583eb28b..a1bfa86f467a 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -141,7 +141,7 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 {
 	ssize_t ret;
 
-	VM_BUG_ON(iov_iter_count(iter) != PAGE_SIZE);
+	VM_WARN_ON(iov_iter_count(iter) != iov_iter_npages(iter, INT_MAX) * PAGE_SIZE);
 
 	if (iov_iter_rw(iter) == READ)
 		ret = nfs_file_direct_read(iocb, iter, true);
-- 
2.34.1


