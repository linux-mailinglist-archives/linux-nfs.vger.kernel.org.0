Return-Path: <linux-nfs+bounces-1410-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAEF83CCE0
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B056B238C8
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C60134759;
	Thu, 25 Jan 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xHdGi1VF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF18472
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212420; cv=none; b=aL/q5KWoU3D9UGWQr6KWDsD5Nt/QW9cK7iboheeOC2LXoWY1ZvadNE3dm6sso+ySikqcoyIEpycOz7ikR9BbxWYhXyZOIGejAQ33YL9+n/MAlxo3A0wE32kh2yTJXQI1NrllZ5mZe36M8TcVNX5ojiKf9RvRwRStY6Q4WbZ+zjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212420; c=relaxed/simple;
	bh=BBauO0dfPBCkOgquKUpzHwfByZUbvH7rZFvY/exQlJA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xw8eqrLvuTESvizpKuOfYqCC+2+y4thb3Yn8SDxfiKL5oAl8aF1JX1+rxrG2Pj69xNttbdACFSQVd90JWylncjqs1fOCQgcSVvjYbN25ghPPToYOw/3nwNtSfSFbSSCeq+0FC8k5eFTLN2XFGNNNqfiuIp6hNUPU/jbl7P2wKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xHdGi1VF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5edfcba97e3so72556627b3.2
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212417; x=1706817217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsVqDNsRoBMC66hu6EgrqRGtxd3g6r7gKr0dNwfERXs=;
        b=xHdGi1VFZkJI96G8dUUHqQzGc0c+AegxoSB2/+qLVNkK7CMIUPPGelMTGhG5CUrhRq
         F0u1cv6HFijlowT/CHFWvnFS3em6L+d4QkegCCOtpgBNehYpaAevUl3afzzxyfDAmetM
         iMl8xS+Lfz7RZWBQCqLabiOh7B+elukjMjYe3jS4bQ5EURrc5Qm45s4Hw7yPtAjrTj4H
         sWLyJWC23XZPF+2NE3QYoZemwwpArO83UPW8GJA8N2SPt5L43sI7EXrVPSbhdDe9SCHq
         jF5IHr/mC6J9vKlII/m7hZkgbvWo/FRRGPbDQLSkhSrtuAffKK8YOYUaffwxYWz9XRP8
         00fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212417; x=1706817217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsVqDNsRoBMC66hu6EgrqRGtxd3g6r7gKr0dNwfERXs=;
        b=BxoofgNJB6OeYXtmWkCvmMloQWdWiuyNgyv57JjRk8qDEuZmXRmTioI/cwX/ff4Nn7
         pU0Wzd51sM6hmNl6vyIqJUMN0KMzekOkbiO7K/RfD7VklXaOvKgrp9YrRTnrxaCIFHZR
         7+45AWK4p7ngOdkXd2ai7AdtbDySChH71eIgnEWIsdO7kgshG5lSe6xE4Zt0JxvXtQ4b
         GipTagt0r9aSSOMZczb2SUa+S0v1cfs/BuZPx8IjQImvCxAbP4HiQxQXhO/JU/JccSQq
         qDUByKZK0t0UvRaYxOYEX8PBtntejuouzzG5z6pqUGWPl1dgmVMDB1m0M9Na0swKvOcV
         TBqA==
X-Gm-Message-State: AOJu0YwVKxjnkO32ljtHv41i2xPH7UATXN1k81mh9Ex6ISIPmvs0cbTx
	Ck8z9Nsumo/Po3XsqKggVlUMxYQYS5cwpeP/0fAwjiD+Z0kDJ85VvHIm8XAUA3LV4zKjhYyu8Xi
	4
X-Google-Smtp-Source: AGHT+IHBRMHEQOlUyKbIf41pq9DkOkLTx4Ew1lenomVfHp5OzKNAQhMrhOl4iP0VFvcABtsKe78H3g==
X-Received: by 2002:a81:ca0f:0:b0:5ff:82fc:9686 with SMTP id p15-20020a81ca0f000000b005ff82fc9686mr400827ywi.3.1706212416608;
        Thu, 25 Jan 2024 11:53:36 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ci12-20020a05690c0a8c00b006029d6509casm855596ywb.67.2024.01.25.11.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:36 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 00/13] Make nfs and nfsd stats visible in network ns
Date: Thu, 25 Jan 2024 14:53:10 -0500
Message-ID: <cover.1706212207.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-nfs/cover.1706124811.git.josef@toxicpanda.com/

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

Josef Bacik (13):
  sunrpc: don't change ->sv_stats if it doesn't exist
  nfs: stop setting ->pg_stats for unused stats
  sunrpc: pass in the sv_stats struct through svc_create*
  sunrpc: remove ->pg_stats from svc_program
  sunrpc: add a struct rpc_stats arg to rpc_create_args
  sunrpc: use the struct net as the svc proc private
  nfsd: rename NFSD_NET_* to NFSD_STATS_*
  nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
  nfsd: make all of the nfsd stats per-network namespace
  nfsd: move th_cnt into nfsd_net
  nfsd: make svc_stat per-network namespace instead of global
  nfs: expose /proc/net/sunrpc/nfs in net namespaces
  nfs: make the rpc_stat per net namespace

 fs/lockd/svc.c              |  5 +--
 fs/nfs/callback.c           |  5 +--
 fs/nfs/client.c             |  5 ++-
 fs/nfs/inode.c              |  8 ++---
 fs/nfs/internal.h           |  2 --
 fs/nfs/netns.h              |  2 ++
 fs/nfsd/cache.h             |  2 --
 fs/nfsd/netns.h             | 28 ++++++++++++---
 fs/nfsd/nfs4proc.c          |  6 ++--
 fs/nfsd/nfs4state.c         |  3 +-
 fs/nfsd/nfscache.c          | 40 +++++----------------
 fs/nfsd/nfsctl.c            | 16 ++++-----
 fs/nfsd/nfsfh.c             |  3 +-
 fs/nfsd/nfssvc.c            | 13 +++----
 fs/nfsd/stats.c             | 53 ++++++++++++----------------
 fs/nfsd/stats.h             | 70 +++++++++++++------------------------
 fs/nfsd/vfs.c               |  5 +--
 include/linux/sunrpc/clnt.h |  1 +
 include/linux/sunrpc/svc.h  |  9 +++--
 net/sunrpc/clnt.c           |  2 +-
 net/sunrpc/stats.c          |  2 +-
 net/sunrpc/svc.c            | 44 ++++++++++++++---------
 22 files changed, 147 insertions(+), 177 deletions(-)

-- 
2.43.0


