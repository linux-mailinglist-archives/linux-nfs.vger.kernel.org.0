Return-Path: <linux-nfs+bounces-22342-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FRsNB3seJWrMDgIAu9opvQ
	(envelope-from <linux-nfs+bounces-22342-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 09:32:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B664F043
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Jun 2026 09:32:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JeSeoNzw;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22342-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22342-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E5043013AB5
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jun 2026 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901FD282F26;
	Sun,  7 Jun 2026 07:32:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A60A302753
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jun 2026 07:32:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780817527; cv=none; b=gY7CsIo4b5Khze3DC0kVMGVMeQ707kjG/zTA/G/9HgJYJ4wJ0Ddzlg9x1yijY/pJEY+nUGQ67xWA8uch7dVF6kHUMiku6fi3RMc0zHwaxgiBxNFG/ZHZ3WPQIRMtXWgfi5JXB/ZkdTCqgHhr2aV8+aSwH0E+3PoEAirhinDn9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780817527; c=relaxed/simple;
	bh=X5iwO1FACE+1+2xU8oc4DOo/3EV26eWzaAKzM8GlpEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuznCVJEP9IA1U+ZvNodLQ5waFZnLMFciW7aLzxVSCoAZb9etkkRsqFmczPhrYIWIae7u/lbDDxlQWGwd4gNKg43l/4NADZAz8iXlLKDO0Qes/9sIMwKPhcGNNqSekbQOe4xS8YZ+Pf9QBN0JNz0tEuXDNeCdlBQL4s68rCyg6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeSeoNzw; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so2393305f8f.2
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jun 2026 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780817524; x=1781422324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGsP3mPndPhYcXEi6EgFHfHqDO/gbUdhLXTqxEZxCZg=;
        b=JeSeoNzwJH5dwinLL9rqqjEirJlPeXDYaaX3feCcHFOXrYUT0oW4zTEN4GZMcSOSxY
         U2DruBakXr3XDS5VjO6ReL2aVA9q2vNuEJodZI8AqOcO+DwccaJCSs4C/GgUzdnKn+ZL
         Udnv6TbvdKZ7GtIvKGCYaZ0S5ckaOezQahhxPH52UAGGxSxN7f7IrqfqPx5BSbJ7TVy4
         tvvRo7A0I8/DZEfFEpxw0Fj8OTzul/S5PPpe9jJcB1f54jhAVmvr1cRbhOx+teFbu0jX
         b2ZC3KIgOKeIgrgjjCf26hZ4ydpsQbkzJtdFU22ckj0CurdtjRlJqOa3/8lkHeffucdR
         MqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780817524; x=1781422324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGsP3mPndPhYcXEi6EgFHfHqDO/gbUdhLXTqxEZxCZg=;
        b=dSZTmbsukEx9MDRdcjkCkM6By80gsTm8W42339OAmq0LK0mrQ3JbvOJyPrBvoTiIc2
         Tk5LLHo1jf6ZtIrMbnQLojEXccvVKiB4BG44cxf3b3FnV/Nmvsee8FWY6cfW8B2kWQZH
         DuW5TI1YWgx7MRMKo8Guvg/yffYWdmwABp2EDF9oToaPrx75YNreSfwPaAkEEakMFRWr
         cGvY4hBEMqAQaniSBMQd1O380PEi2wCW/CP4xzeIKbowPPCjOCrSoQluVB1zwzpgumrS
         P5gibrHdiNQDMuSZ4NgAy0EA1JFIfV3k0DXPQT6Owkedez9TAnNpN+3cnKcftk0j7I7K
         ANVg==
X-Forwarded-Encrypted: i=1; AFNElJ9/UcR02aAXrR5zr9289Yl9KDKOEPYMtLu6626Si4nFktSFpS0+dJcNFs0ABoDvjRM4wecnwNmZeXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGv2gZboh4+8+q3F2DTPKAk+dopi6TTRXq+ANWLp2MoYcY3yv9
	YC7dv9+MsNdlsHtHmg5kb/Wy2taKm5UAV8tj/I7vDwjTM4ETjDDpFkel
X-Gm-Gg: Acq92OEN1YXJ66LtCg/uWRdEbahtYVh/KzEBuvxXGhuwS6spVSkUsWzUBL6zajhkaza
	G79SzBWhuJO2N//Brf/lSuKcSo37/kx3KQ+jklWQU21+V8pFQK/Ptm2FLlnWQYVo59EfzkS8xAA
	SE6hnthHuPHPdGnmnoo2u55f5nSwghZd9FLIObXkuicOP517hLRyxSs5UFfvgh58KPAjyB0VTzs
	7nCSsFhz+iLB6kcuKDmqlESww0jeQrM4QxwEITVN0mvM+iTiaSdN+gdQ3p9VjHVlCO1FZi4P93R
	iEkHMrl66OHTe69IMKHbnz7AgeW2vctWdaNJu/vuUNlCERFzTQG40FoCGPpyLQ2PqTmKOqAvAgL
	ZLvj76fQPOSmiW9lcH1WI00/bOPbbmnNFGfuqk8mp0U5Cu8t+zMeMZlcGnENDfZJbI7Jc7DSV5E
	ZIKxaaJHCgNc+m2eR89dVRmq7GQ9Yc8mLc376cDhnZV34F/M7c/LSo
X-Received: by 2002:adf:e30e:0:b0:460:1233:ecf2 with SMTP id ffacd0b85a97d-46030609798mr12570199f8f.30.1780817524257;
        Sun, 07 Jun 2026 00:32:04 -0700 (PDT)
Received: from puck (234.243.199.146.dyn.plus.net. [146.199.243.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm40459372f8f.26.2026.06.07.00.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 00:32:02 -0700 (PDT)
From: Dylan Yudaken <dyudaken@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Cc: axboe@kernel.dk,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dylan Yudaken <dyudaken@gmail.com>
Subject: [PATCH v2 0/2] nfs: support FMODE_NOWAIT on O_DIRECT reads
Date: Sun,  7 Jun 2026 08:31:53 +0100
Message-ID: <20260607073155.105314-1-dyudaken@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22342-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:axboe@kernel.dk,m:io-uring@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dyudaken@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dyudaken@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dyudaken@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 667B664F043

I had noticed that io_uring always punts O_DIRECT NFS reads to a background thread
since the file does not advertise FMODE_NOWAIT.

I am not very familiar with the NFS codebase, but looking around suggests a simple change
to nfs_start_io_direct is all that is required to properly support this functionality.
On the request issue side, it seems everything in NFS is actually run in the background
(post this lock change), and the completion codepaths all look to have no similar locking
semantics.

I have restricted this to read-only files initially, as the code paths are simpler.
  
I unfortunately do not have the means to test the performance improvement, since even
without this change my local network is the bottleneck here.
However I do suspect that there are people that would want this fix ([1]).
Applying a similar patch on that GitHub issue did give performance gains.

To convince myself this works at all I did trace io_uring events through with and
without the patch.
Using a test app ([2]) to issue O_DIRECT io_uring reads calls io_uring_queue_async_work
without this patch, while with it the call is skipped and the completion is queued into
io_uring directly from nfs_direct_read_completion.

Patch 1 here adds an unused nfs_start_io_direct_nowait which patch 2 uses in order to safely
advertise FMODE_NOWAIT.

v2: Suggestions from Sashiko:
* Handle file flags changing
* Do not use mapping_empty anymore as it was apparently racy
  
[1]: https://github.com/axboe/liburing/issues/1499
[2]: https://github.com/DylanZA/liburing/commit/264c06f1939dfd6b6bc4c967ada5960c4f4f2db3

Dylan Yudaken (2):
  nfs: add nowait version of nfs_start_io_direct
  nfs: expose FMODE_NOWAIT for read-only files

 fs/nfs/direct.c   | 12 ++++++++++--
 fs/nfs/file.c     | 16 +++++++++++++++-
 fs/nfs/internal.h |  1 +
 fs/nfs/io.c       | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 3 deletions(-)


base-commit: a2be31abc3fac6a20f662f6118815b9c40c371c9
-- 
2.50.1


