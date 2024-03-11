Return-Path: <linux-nfs+bounces-2262-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F58782C6
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 16:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09B81C20FB2
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6529940877;
	Mon, 11 Mar 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HO+FMwk/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090A941C79
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169732; cv=none; b=u4RgUrH0r7sc1eQndz46WeRQGnzRrQ7XI/cjo3Vop4Mlglrnz3jhVJJ5ChCuxm0WCNcXSU6KlyLxLlweP8Kx6JIpSkwj2xVqw0dDcizMjp9XMVKsi/PzCkoF/vBFtwUxF2DudA1sqOlZDgqsBYwKs7nc/ht6mq1Y76xpwrk5Guw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169732; c=relaxed/simple;
	bh=nNOsfPkPzH+Ooip8aR01XZxj6ksmkuSMivWiEmnx1gY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nPWePOnKVRvkLspMkPRr8mel1Kwm+tak29UGMSpAk9dOEotxAHuW6WwQLK5jvUfdOmXZJ27zLKtbvdmGLCUUeDnd8pALb/yjtdeTuo8Jf3h9AEsFwLconw64K2/W2O7lLb/gXz+jl17Ly8sJzuILG6cTqxhKDFx8b3kR3Uqnv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HO+FMwk/; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-609f060cbafso47436427b3.0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710169729; x=1710774529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+znQQkwuIWlYT1mQyI/D8NgH0k3sIDAT2CT2uUHvBI=;
        b=HO+FMwk/CFDOQWOJoDzgBMQxPCsM1HNtEZQZEugHq6uOIxD2WfrEsBgU3EGyqW0Z+9
         BkIxkv52zQuJ63Rsl4wNjlOUtsi7loVah63vebjupNHoP+qQXhZvu3oVdkJgXL9Eowq/
         8nbzWwxiA/p2rrHm0EcII4COyJ0FTGECquS7d5tPfssKtYIOO3AoxpvqGxMg/ExyAfz2
         SfIg1rNkzUBaRtNtYBjBkh2X88zV7bVVoxSNQcGHehJhNoBkZDkrwV1NAkm2BAIoL+fy
         pZlkADQ+7vdXEzrO/WoItYIVMOELnD0Hi8I5tx4Le7iK7tZqsJF/lMVTJJy8/5AiBMjn
         BRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710169729; x=1710774529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+znQQkwuIWlYT1mQyI/D8NgH0k3sIDAT2CT2uUHvBI=;
        b=Fzdc19I9sgKEPh46lxSktsabCggkjNpaYUqrk3TI8gksaQkmz/1PV9LyPNtvoUF+37
         bW4Ai4bg50xwGZtU0wMdOIwf1pJEMF7LXENS7D2vVLBcSQr6P0kZcYJnyBjsbyX+d5dc
         KCK6fgA8vsZ4OtC4wwxmB6PybvR0Ly9qCSHaMd1SGT6pa7HucL9dnXt1fyJ3HedlUHtP
         izvHPOQZ73vshPVS9Je4X/UET2W4y2nm9uzOHP33Kmn9h0Foa0/KSaz8ksrAnA/wbEu5
         k35d7kDqv8ymS3kAi9bNMN12dK41N4hjfjXpweVPAgrhbJf9iF6JlSs58XyJzOQx3m8g
         wcow==
X-Forwarded-Encrypted: i=1; AJvYcCWm5dmXlEOPPNPKw0FLcgHBnjyC0qTXKs4c7mweStDU4fYbt0qsu38mWm6SoBTv7HtzZJXzFQyOEuvDckC+6VexXEOC9fQIEBit
X-Gm-Message-State: AOJu0Yy5oaIA3p69wRxV8mkx20PvAIcRR4IMHIq5ik1XZp+q+zCorxHX
	JkmP7/TxELXLO3+8J2+nEX3cAtGEQ+ZWvfAUrvR6cKJekZRHBJH3TCdKlIEQ+QhvFuyeIvaQFik
	N
X-Google-Smtp-Source: AGHT+IF+dy78xXcruGQYy2RgPAhZXfNtPzqIbsBF1PMSZO2YLYySibkwJ78zPvfp6AivXiDT94zn+Q==
X-Received: by 2002:a0d:d7d4:0:b0:60a:2ac2:104f with SMTP id z203-20020a0dd7d4000000b0060a2ac2104fmr3924654ywd.26.1710169728849;
        Mon, 11 Mar 2024 08:08:48 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a195-20020a0dd8cc000000b0060a54499339sm12784ywe.31.2024.03.11.08.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:08:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: fix panic when nfs4_ff_layout_prepare_ds() fails
Date: Mon, 11 Mar 2024 11:08:05 -0400
Message-ID: <d9dd921c94d063d5cb17ca2f5489e47b63cd765d.1710169680.git.josef@toxicpanda.com>
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

>>> prog.crashed_thread().stack_trace()[0]['idx']
(u32)1
>>> prog.crashed_thread().stack_trace()[0]
>>> prog.crashed_thread().stack_trace()[0]['idx']
(u32)1
>>>
prog.crashed_thread().stack_trace()[0]['flseg'].mirror_array[1].mirror_ds
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


