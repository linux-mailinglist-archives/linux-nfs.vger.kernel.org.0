Return-Path: <linux-nfs+bounces-6229-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880596DE3B
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 17:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB19B1C25D7F
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68084D3E;
	Thu,  5 Sep 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8y70zvh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BEC7F7FC;
	Thu,  5 Sep 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550277; cv=none; b=b5gHWQNCddItLjff6ZAvb19VelIjuum8h6jPqo4r1SkVLac0paKWNNswIQM5HJsiTDL7POm56T4w2pD4cs4U2x36ExG2xnZEzbYvkyycC9lOP/wCUF1j40B1kQP05zBHrv9VIiBXWQ1kIW5whK9WMbM1DMSqitlwhGLY0ituIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550277; c=relaxed/simple;
	bh=s06Fd52zaQ6YeE4FvigUbNXvSQgkkN8aStazVLYd8hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pGr7iroKa89ysKJLy/WW1kCnmlT6Pdvb0HGK+3tj/O1BUG8XwE8ZjYfnqJL7ZVW7QwwGhSm4vryCUxVyvA/XbFy6KgpReLaqFFSPcFcjOKuXWbRq1mwyKFGNqIMmgk7D0Cos3Znm0r+TdiFHti3vxrGG3LYdHD8md3NEhuFtKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8y70zvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAB7C4CEC3;
	Thu,  5 Sep 2024 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725550277;
	bh=s06Fd52zaQ6YeE4FvigUbNXvSQgkkN8aStazVLYd8hE=;
	h=From:To:Cc:Subject:Date:From;
	b=U8y70zvhXHCgJ7rn8lb1kbMdLJhu3OoIBTdgbKvncubgPkAu4UDXdiqQ2yP3Gvmqc
	 wyhc3xibPHrCQiTLzKtM0kpq4xsc6EEodOS+qJK3jOk2mndsLPniMK3NxOJN//T6Eu
	 byUTmyVeXZZDmPhbppcWhBNhyYpBrqnmRuYax7hR0y/puu7XdquUODNdZjxUrfMuIW
	 eA4pKbScA70M46TVsYg5R1NMsFiJaGPBofGSR1apJ3TI9Aelw26Ls5WUB9PYB6/jHu
	 sYpusIdj++gjBM1ZS+pVGbjuioU1zm5gVUxLCjsZIH60JdCfwDFs3/wENK80fcKAaP
	 6iV4G9503zwCw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Petr Vorel <pvorel@suse.cz>,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.10.y 00/19] Backport "make svc_stat per-net instead of global"
Date: Thu,  5 Sep 2024 11:30:42 -0400
Message-ID: <20240905153101.59927-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Following up on

https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/

Here is a backport series targeting origin/linux-5.10.y that closes
the information leak described in the above thread.

Review comments welcome.


Chuck Lever (6):
  NFSD: Refactor nfsd_reply_cache_free_locked()
  NFSD: Rename nfsd_reply_cache_alloc()
  NFSD: Replace nfsd_prune_bucket()
  NFSD: Refactor the duplicate reply cache shrinker
  NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
  NFSD: Fix frame size warning in svc_export_parse()

Jeff Layton (2):
  nfsd: move reply cache initialization into nfsd startup
  nfsd: move init of percpu reply_cache_stats counters back to
    nfsd_init_net

Josef Bacik (10):
  sunrpc: don't change ->sv_stats if it doesn't exist
  nfsd: stop setting ->pg_stats for unused stats
  sunrpc: pass in the sv_stats struct through svc_create_pooled
  sunrpc: remove ->pg_stats from svc_program
  sunrpc: use the struct net as the svc proc private
  nfsd: rename NFSD_NET_* to NFSD_STATS_*
  nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
  nfsd: make all of the nfsd stats per-network namespace
  nfsd: remove nfsd_stats, make th_cnt a global counter
  nfsd: make svc_stat per-network namespace instead of global

NeilBrown (1):
  NFSD: simplify error paths in nfsd_svc()

 fs/lockd/svc.c             |   3 -
 fs/nfs/callback.c          |   3 -
 fs/nfsd/export.c           |  32 ++++--
 fs/nfsd/export.h           |   4 +-
 fs/nfsd/netns.h            |  25 ++++-
 fs/nfsd/nfs4proc.c         |   6 +-
 fs/nfsd/nfscache.c         | 202 ++++++++++++++++++++++---------------
 fs/nfsd/nfsctl.c           |  24 ++---
 fs/nfsd/nfsd.h             |   1 +
 fs/nfsd/nfsfh.c            |   3 +-
 fs/nfsd/nfssvc.c           |  38 ++++---
 fs/nfsd/stats.c            |  52 ++++------
 fs/nfsd/stats.h            |  83 ++++++---------
 fs/nfsd/trace.h            |  22 ++++
 fs/nfsd/vfs.c              |   6 +-
 include/linux/sunrpc/svc.h |   5 +-
 net/sunrpc/stats.c         |   2 +-
 net/sunrpc/svc.c           |  36 ++++---
 18 files changed, 306 insertions(+), 241 deletions(-)

-- 
2.45.1


