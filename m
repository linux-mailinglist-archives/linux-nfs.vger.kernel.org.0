Return-Path: <linux-nfs+bounces-2263-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3B38782CB
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 16:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCA31C2107F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 15:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4854441C7C;
	Mon, 11 Mar 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vyTVfHHS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E241C79
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169937; cv=none; b=q4LKivuY4hwCm9PHSoiGgnP5CJIVgPtZ4SXcXDQzpd5BsmNep8MsZxZ40uVKeCnvVwypYy3fwAmUnnAb6R++EGdJicHskTDztAnRxsQRzdQyeXIM+Uvbk83GVr4lRZtq9NhRtvXz3J8jx+VNcRDu7X4wvE+CQpodDHmWaYnFY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169937; c=relaxed/simple;
	bh=+cWtgG8QKbU4auleYoCMI2b/h/LHKA1kMqqlhMoI4lc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HCVTLwLiEcqGN5IBiI4ccevoyiYpkWvtS7WcMs1D4GJeY/JbXrawvdQJhP+ha2QOyvdJy5K73+9z/YSiYTMK0foXzB5W+DcIHYa/KUIcaDde+AiL2IH69ecQ/BgXCpNeWp2VmmURChpk/mOiaUDxeuNJqUwpYIQBlvJLuOBYqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vyTVfHHS; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60a0599f647so22706487b3.1
        for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710169934; x=1710774734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LqWZIUqVCGNbnUYde2IU7lqIEkbaj4cHti1u5AYGtVc=;
        b=vyTVfHHSlry289rdXFp27fXUbIbC4LDVjRN9hTNgb2a/lT925i4MQL5J/+wWnME/rq
         rUq3Te8ah8hIwJQenCYihYGZzOdAr7FEB7Ae6YMTpnxQyNJrecSZ5Ek1nP7HvFxtsGVG
         DW9A5/PaZ780cPYTrC+J6mylDtDWGd5mNoC+ZazRv0l9K22JxnI3lGyCQ/7Jw5vGsVB9
         0YwuCv3VkjP4ppXxCDxZ+03urV3gEEFK2+EZ+onGnRfeffKWU3tCpUN/ALy3IXbH13t4
         1ak2HzFCNlbvue0xJlN4O2pGGMytvbivQGTWuxpHGIF0Zoo9cGoCCKOTmCBuR5BhhkKw
         l6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710169934; x=1710774734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqWZIUqVCGNbnUYde2IU7lqIEkbaj4cHti1u5AYGtVc=;
        b=bc9Yx9+6uGBCm6mO2Tn2mu0QPH6pNFAzYZmMqqRgYqZho7PZL97YV5lVfZjdFVBlTu
         GidZIKXl50+ls4Up5aeT7mqRkAGH880MiaK59ErWMG3knCDwAj1ZMG9+qYZWrXIO6z0u
         aFwGp3GD4JdH2Ywphncdh1wA3KJLVCiLwYraf87HDIFIv9544b06mNW3gJ1q5FW55lZc
         nm32NNeieCJzQzKxik8sjOiHxPcltxtqvzKjaIbs9m3Q9mQ+qmFwL0+WOU8WbOczoryz
         LA51NvqWAU+Arq1NZxCaFNTvEqAYiL+5KXg6pn9KKLU9pwDjNenkjKxQKliQgB8lnQ+x
         3ykg==
X-Forwarded-Encrypted: i=1; AJvYcCWl9NSZBwdXDn7O1GYoPXbVAdiG+DI4+fhTLrd3GVwSX1K1yPLkWO3NwCsBEn0SIy5/3DpXgH7aIbzG7Bi5wg36JvG/UeTmCW65
X-Gm-Message-State: AOJu0Yz55eRJzt3X8ON4SMIVS8x5CFFnqtNKBTY011EdYiwkZOlfk4i9
	8pqMgf0Eo/YaHxifyTrBU5YAhuQLxoGA1fYxCIhnEHEqfqcAV6yYv+t5j4/uNWs=
X-Google-Smtp-Source: AGHT+IEVT/Dk9IqQ9Kl3jm8LHlPKAGK9sHk9Epetl1tP7wQIDbfNR2Hsq5qVaB4yLmzzM8CSNujpnA==
X-Received: by 2002:a0d:cc56:0:b0:60a:5031:2de9 with SMTP id o83-20020a0dcc56000000b0060a50312de9mr722277ywd.51.1710169934442;
        Mon, 11 Mar 2024 08:12:14 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i17-20020a81aa11000000b006093c621a9asm1343583ywh.86.2024.03.11.08.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:12:13 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfs: fix panic when nfs4_ff_layout_prepare_ds() fails
Date: Mon, 11 Mar 2024 11:11:53 -0400
Message-ID: <5a244749e5bfefd921cb296c9e7b16fe4990f440.1710169883.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've been seeing the following panic in production

BUG: kernel NULL pointer dereference, address: 0000000000000065
PGD 2f485f067 P4D 2f485f067 PUD 2cc5d8067 PMD 0
RIP: 0010:ff_layout_cancel_io+0x3a/0x90 [nfs_layout_flexfiles]
Call Trace:
 <TASK>
 ? __die+0x78/0xc0
 ? page_fault_oops+0x286/0x380
 ? __rpc_execute+0x2c3/0x470 [sunrpc]
 ? rpc_new_task+0x42/0x1c0 [sunrpc]
 ? exc_page_fault+0x5d/0x110
 ? asm_exc_page_fault+0x22/0x30
 ? ff_layout_free_layoutreturn+0x110/0x110 [nfs_layout_flexfiles]
 ? ff_layout_cancel_io+0x3a/0x90 [nfs_layout_flexfiles]
 ? ff_layout_cancel_io+0x6f/0x90 [nfs_layout_flexfiles]
 pnfs_mark_matching_lsegs_return+0x1b0/0x360 [nfsv4]
 pnfs_error_mark_layout_for_return+0x9e/0x110 [nfsv4]
 ? ff_layout_send_layouterror+0x50/0x160 [nfs_layout_flexfiles]
 nfs4_ff_layout_prepare_ds+0x11f/0x290 [nfs_layout_flexfiles]
 ff_layout_pg_init_write+0xf0/0x1f0 [nfs_layout_flexfiles]
 __nfs_pageio_add_request+0x154/0x6c0 [nfs]
 nfs_pageio_add_request+0x26b/0x380 [nfs]
 nfs_do_writepage+0x111/0x1e0 [nfs]
 nfs_writepages_callback+0xf/0x30 [nfs]
 write_cache_pages+0x17f/0x380
 ? nfs_pageio_init_write+0x50/0x50 [nfs]
 ? nfs_writepages+0x6d/0x210 [nfs]
 ? nfs_writepages+0x6d/0x210 [nfs]
 nfs_writepages+0x125/0x210 [nfs]
 do_writepages+0x67/0x220
 ? generic_perform_write+0x14b/0x210
 filemap_fdatawrite_wbc+0x5b/0x80
 file_write_and_wait_range+0x6d/0xc0
 nfs_file_fsync+0x81/0x170 [nfs]
 ? nfs_file_mmap+0x60/0x60 [nfs]
 __x64_sys_fsync+0x53/0x90
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Inspecting the core with drgn I was able to pull this

  >>> prog.crashed_thread().stack_trace()[0]
  #0 at 0xffffffffa079657a (ff_layout_cancel_io+0x3a/0x84) in ff_layout_cancel_io at fs/nfs/flexfilelayout/flexfilelayout.c:2021:27
  >>> prog.crashed_thread().stack_trace()[0]['idx']
  (u32)1
  >>> prog.crashed_thread().stack_trace()[0]['flseg'].mirror_array[1].mirror_ds
  (struct nfs4_ff_layout_ds *)0xffffffffffffffed

This is clear from the stack trace, we call nfs4_ff_layout_prepare_ds()
which could error out initializing the mirror_ds, and then we go to
clean it all up and our check is only for if (!mirror->mirror_ds).  This
is inconsistent with the rest of the users of mirror_ds, which have

  if (IS_ERR_OR_NULL(mirror_ds))

to keep from tripping over this exact scenario.  Fix this up in
ff_layout_cancel_io() to make sure we don't panic when we get an error.
I also spot checked all the other instances of checking mirror_ds and we
appear to be doing the correct checks everywhere, only unconditionally
dereferencing mirror_ds when we know it would be valid.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- My bad, I missed the formatting of the drgn output and it looked mangled.

 fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index ef817a0475ff..3e724cb7ef01 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2016,7 +2016,7 @@ static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
 	for (idx = 0; idx < flseg->mirror_array_cnt; idx++) {
 		mirror = flseg->mirror_array[idx];
 		mirror_ds = mirror->mirror_ds;
-		if (!mirror_ds)
+		if (IS_ERR_OR_NULL(mirror_ds))
 			continue;
 		ds = mirror->mirror_ds->ds;
 		if (!ds)
-- 
2.43.0


