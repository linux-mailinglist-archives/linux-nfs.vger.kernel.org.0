Return-Path: <linux-nfs+bounces-1970-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3819A856E34
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 21:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7451B1C21EB7
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 20:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D328F13AA21;
	Thu, 15 Feb 2024 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vhFpyvlk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E801386A2
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027064; cv=none; b=JsFrU9bVdDmHXRBe2CrfKEe6g9t0ryJBrs3tKJ/52B+weFJnpC9pilm7ZYjWQPU+DjFlwMOzGlkSxVg4Gq5MzW8OmgHxvrX8Or0ZdM3Ch23tnclPTAWpyZyySoE4UV9jjJ8Ppy1tWQmCTmORmS2QKk3QsevfGrNPmTCQz0oer2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027064; c=relaxed/simple;
	bh=amLKg7Ovia/QYA0JgChzsULO1RjMBpaskcWtWHEPZuY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q+OGPfbHc4LRkzSNWR03wpRNamUD2HGX6Fs7Kzj76XgdUJhQoOORpvnXSpLZS/ViD3zoFMopoRuqhU0le8dX4FZtd+88AE387JLWd9EeDxKVXt+/Xb/np7MvhRDIkDCJFS91ekI9lW6UfaDatxe6OjP+vPqJH370uh5unGUaYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vhFpyvlk; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1263103276.2
        for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 11:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1708027062; x=1708631862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9UN1aGk8a+LXgRW/y0/QDT8nNxXo5ieDh+ZdMh2biGs=;
        b=vhFpyvlkOd6ZCvSjwIco1v7zabUcy5AhcaxeblbJj+bj0pi/8D60pxQY2hzhcXyF15
         Cqof0NtkN4QVvtDbuAkUJEHkMO1lHkItQEqAlwaST0bZK6x4rEuRU2NtWOpogLuVZ3iC
         z+UnckgDg2IpTUq+iAhlBcXiPGWaWsIyJj2gHsBI2mvbBhVs6KUrdVRa1RDCkraqNTGC
         9gr46PWq/EQ7KeRsOzQBkmBsdoxO5gdCEMDCqya4NuQy+pmRSdhJSM5BUDqUGjZoOix0
         DwpSIiqxIY0U2UPHh6HqjFe/YwzRf0CeLDtU73k82D6qnNOeG9t8D+wf3hjmaKmIHXVw
         o/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708027062; x=1708631862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UN1aGk8a+LXgRW/y0/QDT8nNxXo5ieDh+ZdMh2biGs=;
        b=Rfom8KPG+oSvcDRAQlqcOB1oFzh06Y/FYr/S+o1Xvp5r3nPVoaAJNYEeqQk03X3hoL
         Dcqfj+ppM4CdKMEUerJ3E3Nh2e4PlI4/ZdDu+yOPW7NiMp/ubQo7MAuzTHiKMn2YIaG4
         05imINrNoLghPRuDTUyv1z6kXO9HuwoXpCKGbekwFCTjk5cMmef3eykM7Lhm3E/5UCGM
         F1kZis6QLjNxREZIx7pKYKKibEm9S23Gc115LaQqqC8RsZLSDX0CLpe9LcoCSgnuC98l
         e3lw9YZedRA5hSD0V6vB0cxskMV6ywQXbSAy4T8j2RKQcMq1+DNJXTGpWqqPBQXvsLaL
         JmLg==
X-Forwarded-Encrypted: i=1; AJvYcCUKA2u1iLVRTfV922jVgw7SNX711mAZulY+4nd493ZUe6u9wRu5P5WTeNUzyB+RJCKUYvIhXPkLW/67Sti+EDPCiF+oOHlyWArJ
X-Gm-Message-State: AOJu0Yy58mmX4zr0wrrFfitH4ryAjqtBJqVAWxuWAwtVVo9A+3znzQRr
	wouck29SvVyYde0ZApkqZOT4/J1q6J8U31rF+Yzqo4ipq2oCqjN01Xq+iorEZEk=
X-Google-Smtp-Source: AGHT+IG6Y1JaFnVdxsGQd9BWm7eSbP+ZauXFxFDTUZDNZ8aa9MRxe0rzG/4ZDTdMMBhKIn/pRx038Q==
X-Received: by 2002:a25:68cd:0:b0:dc6:4baa:cff8 with SMTP id d196-20020a2568cd000000b00dc64baacff8mr2494866ybc.43.1708027062046;
        Thu, 15 Feb 2024 11:57:42 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t17-20020a255f11000000b00dc9c5991ecdsm16852ybb.50.2024.02.15.11.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:57:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 0/3] Make nfs stats visible in network NS
Date: Thu, 15 Feb 2024 14:57:29 -0500
Message-ID: <cover.1708026931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-nfs/cover.1706124811.git.josef@toxicpanda.com/
v2: https://lore.kernel.org/linux-nfs/cover.1706212207.git.josef@toxicpanda.com/
v3: https://lore.kernel.org/linux-nfs/cover.1706283674.git.josef@toxicpanda.com/
v4: https://lore.kernel.org/linux-nfs/cover.1706305686.git.josef@toxicpanda.com/

v4->v5:
- If we clone a client pass through their ->cl_stats so it's populated properly.

v3->v4:
- Fix a weird formatting thing that snuck into 1/3.

v2->v3:
- Split out the nfs and nfsd related changes into their own patches.
- Dropped the change adding sv_stats throuch svc_create()
- Changed the th_cnt to be global, re-arranged it's location.

v1->v2:
- rework the sunprc service creation to take a pointer to the sv_stats.
- dropped ->pg_stats from the svc_program.
- converted all of the nfsd global stats to per-network namespace.
- added the ability to point at a specific rpc_stat for rpc program creation.
- converted the rpc stats for nfs to per-network namespace.

-- Original email --
Hello,

We're currently deploying NFS internally and have run into some oddities with
our usage of containers.  All of the services that mount and export NFS volumes
run inside of containers, specifically all the namespaces including network
namespaces.  Our monitoring is done on a per-container basis, so we need access
to the nfs and nfsd stats that are under /proc/net/sunrpc.  However these are
only tied to the init_net, which makes them invisible to containers in a
different network namespace.

Fix this so that these files are tied to the network namespace.  This allows us
to avoid the hack of bind mounting the hosts /proc into the container in order
to do proper monitoring.  Thanks,

Josef

Josef Bacik (3):
  sunrpc: add a struct rpc_stats arg to rpc_create_args
  nfs: expose /proc/net/sunrpc/nfs in net namespaces
  nfs: make the rpc_stat per net namespace

 fs/nfs/client.c             | 5 ++++-
 fs/nfs/inode.c              | 8 ++++----
 fs/nfs/internal.h           | 2 --
 fs/nfs/netns.h              | 2 ++
 include/linux/sunrpc/clnt.h | 1 +
 net/sunrpc/clnt.c           | 5 ++++-
 6 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.43.0


