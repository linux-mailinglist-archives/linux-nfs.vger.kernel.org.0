Return-Path: <linux-nfs+bounces-15029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B79BC2141
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 18:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A052B18948BB
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7D2E6CB3;
	Tue,  7 Oct 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR+wuHLO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FF72E2DFA
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853854; cv=none; b=VpTzH7g5dDRlC2tfwyUcIcmL4/8ch3IuY1VBZVVPkXK6Xl5nBdzG4ZD+EQoP7AnypSGp3h1dEfqeeePWY9qp184fr6dTbaPwy20+FI+LWysdSppgSCW1xkwk/YSUVJYrM77nYdsZMc6xM6OdiOfwzPz9TMzHm270mni1frWsAfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853854; c=relaxed/simple;
	bh=zKULPQQuwiOMb26v+cKjhqRJho79LgmVc0rOc9shKDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSeNNNFzkXi4Sx6hqWYnXf9XJlS/rl+S8RsINNtjd1pP9XK4R4DDft8orsHpORE949/z8SrgxbYT3QWjJoX56YBY6+Rt+FqaqtBMoR/S6k39l6l5XBu2DPm4cgteJ+G7Eg377sytAEho9UhPV4tgueWFTlseBhrX5FLVTeDBKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TR+wuHLO; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8ca2e53c37bso552122639f.3
        for <linux-nfs@vger.kernel.org>; Tue, 07 Oct 2025 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759853851; x=1760458651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKULPQQuwiOMb26v+cKjhqRJho79LgmVc0rOc9shKDs=;
        b=TR+wuHLO585PamBK2WXdvWMukywEPATm2ScA8Xy93Y6vh160rpd0C3R7UeVBy/ECfJ
         AGs1noKFh5iDXRRceDbIEMGvhxm7m6Pzmj4QgQtlAbG/kjCrp+mDmsZgo4IlWV0Wqm6+
         7ohVwKGrvDOQYPXdPfoJMaXrI1kRzn8aoBh1o4Rai4WOflmO7BiHDt3POJ0M8e17MDvM
         tBvyUUmoi5fYjgRf0KOtIbncmZRMEBfmxXcyxm1bDwgX3Xz43p6S5B4EmHS6bh+WjoAf
         XLmm/IDdOiHnkkALeZDOMaFA7eSQJsFukwUI3U2PUu/9NRcb1bzRMNwrZZlah+WwzosZ
         DsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853851; x=1760458651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKULPQQuwiOMb26v+cKjhqRJho79LgmVc0rOc9shKDs=;
        b=vyhei6f1OZc2/fhVadix0D7XAzP2lcWR07s8tZM71WSy89aZqk2shCw9Hpeq+aQSkX
         rIRPZlOXF+JUaa+BsDoO4jp50k28lIkCF4Qv4xLIibb6JVt62fsMiWu36Z8j8OQvh36H
         4levGXP8NXflo5oKFPqcnBp+hG3qiFkdOeol/R+HX1B99w3MhM4uX35uLbXMu463CbhY
         PrK7CDl0RQveZHtm52q5qV/OvwISxjuQ0evvfTKKF195iKBoE3cdQJwK4fV5o7yIVysC
         9sZiEjVrvylcCdglf6f4EfEr/SCTjdel4YJW1jeZQuCwm/qsk5QmeFAbcrp39ZDCGCFi
         qSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlke6Q1XjWlLsI8g6q2Z8x1GzYSia1gZl2nHVzb+MltE/tO4L1gqRHTw0ukOdneFgqX3N9w1kCMw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4aYa0+0t3jyfpPT+G44jxDZu1ryLmMZBTEedXNikYd2v6IdKv
	G66egZ8B3rfpiuwoVcVFLuhXcdXJkxipN8Kp5XP6vfYh4j3YlGTy8sUEq1J4bYKi
X-Gm-Gg: ASbGncthRjk5yQhcc6iQVe3zkV0mzdcz4fqPMDfz7kk0fyTQtBsrH9UNCE5S5nP3hBt
	T/eL3lnRhWhSZ3BItcvuS/9DMzf4hKMlzr40fbgZhYM7YNbHUSi0SlLbdMbaPTksLeQKFcfbqp7
	brrVJ5MTKmvJBbj9hC0ky3LCIUB287Tis7ZjqtzinPBuRtvmN9IyRb2cp2Ln46dqrb3Je8Bs9yc
	vBEsHNq30eW83yNfySRy7xYEqpvzDaQ0AiR9KR3r9X4DyXRRv1IQWjiGHQForoPzzfDGVyF4pm3
	HzaUy5rDe3H70sS8v+6ogChXvSTvpP3AN4ArFaD1D2pSbBvHi3ZicN4FMLtkvouYzAuaCso+/6j
	6jIKGEHwDJ0+Cn2N9eadL7vDlWQTt3lxyOQd+0V72foLw6ZuiEMVAUCw=
X-Google-Smtp-Source: AGHT+IFyXdSH5lmXmhQmU+6+2rFb2XcvaPsAqqFnlPFjaKItZfU6kDMDObVgHMoy+y6gZCvNhaIPTw==
X-Received: by 2002:a05:6602:2d91:b0:937:43fd:ee68 with SMTP id ca18e2360f4ac-93b96ac2dbemr2694731539f.18.1759853851293;
        Tue, 07 Oct 2025 09:17:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::7bc8])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5e9e8efcsm6273618173.2.2025.10.07.09.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:17:30 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: jimzhao.ai@gmail.com
Cc: akpm@linux-foundation.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	linux-nfs@vger.kernel.org,
	Joshua Watt <jpewhacker@gmail.com>
Subject: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic into __wb_calc_thresh
Date: Tue,  7 Oct 2025 10:17:11 -0600
Message-ID: <20251007161711.468149-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20241121100539.605818-1-jimzhao.ai@gmail.com>
References: <20241121100539.605818-1-jimzhao.ai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Watt <jpewhacker@gmail.com>

This patch strangely breaks NFS 4 clients for me. The behavior is that a
client will start getting an I/O error which in turn is caused by the client
getting a NFS3ERR_BADSESSION when attempting to write data to the server. I
bisected the kernel from the latest master
(9029dc666353504ea7c1ebfdf09bc1aab40f6147) to this commit (log below). Also,
when I revert this commit on master the bug disappears.

The server is running kernel 5.4.161, and the client that exhibits the
behavior is running in qemux86, and has mounted the server with the options
rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,port=52049,timeo=600,retrans=2,sec=null,clientaddr=172.16.6.90,local_lock=none,addr=172.16.6.0

The program that I wrote to reproduce this is pretty simple; it does a file
lock over NFS, then writes data to the file once per second. After about 32
seconds, it receives the I/O error, and this reproduced every time. I can
provide the sample program if necessary.

I also captured the NFS traffic both in the passing case and the failure case,
and can provide them if useful.

I did look at the two dumps and I'm not exactly sure what the difference is,
other than with this patch the client tries to write every 30 seconds (and
fails), where as without it attempts to write back every 5 seconds. I have no
idea why this patch would cause this problem.

Any help is appreciated. Thank you.

git bisect start
# status: waiting for both good and bad commits
# good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
git bisect good 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
# status: waiting for bad commit, 1 good commit known
# bad: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect bad e5f0a698b34ed76002dc5cff3804a61c80233a7a
# good: [5f20e6ab1f65aaaaae248e6946d5cb6d039e7de8] Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect good 5f20e6ab1f65aaaaae248e6946d5cb6d039e7de8
# good: [28eb75e178d389d325f1666e422bc13bbbb9804c] Merge tag 'drm-next-2024-11-21' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 28eb75e178d389d325f1666e422bc13bbbb9804c
# bad: [1afba39f9305fe4061a4e70baa6ebab9d41459da] Merge drm/drm-next into drm-misc-next
git bisect bad 1afba39f9305fe4061a4e70baa6ebab9d41459da
# bad: [350130afc22bd083ea18e17452dd3979c88b08ff] Merge tag 'ubifs-for-linus-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs
git bisect bad 350130afc22bd083ea18e17452dd3979c88b08ff
# good: [cf33d96f50903214226b379b3f10d1f262dae018] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good cf33d96f50903214226b379b3f10d1f262dae018
# good: [c9c0543b52d8cfe3a3b15d1e39ab9dbc91be6df4] Merge tag 'platform-drivers-x86-v6.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
git bisect good c9c0543b52d8cfe3a3b15d1e39ab9dbc91be6df4
# good: [40648d246fa4307ef11d185933cb0d79fc9ff46c] Merge tag 'trace-tools-v6.14' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect good 40648d246fa4307ef11d185933cb0d79fc9ff46c
# bad: [125ca745467d4f87ae58e671a4a5714e024d2908] Merge tag 'staging-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad 125ca745467d4f87ae58e671a4a5714e024d2908
# bad: [d1366e74342e75555af2648a2964deb2d5c92200] mm/compaction: fix UBSAN shift-out-of-bounds warning
git bisect bad d1366e74342e75555af2648a2964deb2d5c92200
# good: [553e77529fb61e5520b839a0ce412a46cba996e0] mm: pgtable: introduce generic pagetable_dtor_free()
git bisect good 553e77529fb61e5520b839a0ce412a46cba996e0
# good: [65a1cf15802c7a571299df507b1b72ba89ef1da8] mm/zsmalloc: convert migrate_zspage() to use zpdesc
git bisect good 65a1cf15802c7a571299df507b1b72ba89ef1da8
# good: [136c5b40e0ad84f4b4a38584089cd565b97f799c] selftests/mm: use selftests framework to print test result
git bisect good 136c5b40e0ad84f4b4a38584089cd565b97f799c
# good: [fb7d3bc4149395c1ae99029c852eab6c28fc3c88] mm/filemap: drop streaming/uncached pages when writeback completes
git bisect good fb7d3bc4149395c1ae99029c852eab6c28fc3c88
# good: [7882d8fc8fe0c2b2a01f09e56edf82df6b3013fd] selftests/mm/mkdirty: fix memory leak in test_uffdio_copy()
git bisect good 7882d8fc8fe0c2b2a01f09e56edf82df6b3013fd
# bad: [6aeb991c54b281710591ce388158bc1739afc227] mm/page-writeback: consolidate wb_thresh bumping logic into __wb_calc_thresh
git bisect bad 6aeb991c54b281710591ce388158bc1739afc227
# good: [f752e677f85993c812fe9de7b4427f3f18408a11] mm: separate move/undo parts from migrate_pages_batch()
git bisect good f752e677f85993c812fe9de7b4427f3f18408a11
# good: [686fa9537d78d2f1bea42bf3891828510202be14] mm/page_alloc: remove the incorrect and misleading comment
git bisect good 686fa9537d78d2f1bea42bf3891828510202be14
# first bad commit: [6aeb991c54b281710591ce388158bc1739afc227] mm/page-writeback: consolidate wb_thresh bumping logic into __wb_calc_thresh

