Return-Path: <linux-nfs+bounces-5280-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0053494DE52
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF541F214AC
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C947A62;
	Sat, 10 Aug 2024 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9yGIITY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA4200A3;
	Sat, 10 Aug 2024 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320022; cv=none; b=d8lQUxxS4ycoJphLZY4Coxz8fVG8RBR4P2KMnKeVCbYrFUPe3DHrrBL1ncy8nlEBBrI0LFCGiH5lK6H4ZMLOu/Z7nd+O2THiWWMVrql+j1W2v579AvrECaebkr7BejdwuitrOQHB75ujXh1dym+/KEs0YYVIYNZY5IrdTXnkX34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320022; c=relaxed/simple;
	bh=qOKcnQkaX10mZFAjQgmcLyscNeRuIIwIDOc8y9F/bsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tJho54ULqEiju/LFdsm4m4E04ZtvF9Xqf80wIsyiCnYT3TtQFnVF2EAD6NRpgNJUVLQ31aZmgylaMzdSgrKuCtNopb/XsXbesLOx+2lG4Z3HTQ/mvSQp+MThNtE2544GoCLYqicMNVKOzUVVz0Eh8XBdLkgF3FW+Rm//+VyM4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9yGIITY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25EEC32781;
	Sat, 10 Aug 2024 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320021;
	bh=qOKcnQkaX10mZFAjQgmcLyscNeRuIIwIDOc8y9F/bsg=;
	h=From:To:Cc:Subject:Date:From;
	b=W9yGIITY0d+t9fudujiHz7Et7B8hWewMPqIvRub3FtE4yndHtoXvzhPbMHHPfNLXR
	 KH2/4q/FBTiTkoPljLhEuDjitTYsHCgxjT1wGRPTT0+MY+P3jLQW9L9u0wjE2YmvZQ
	 6pI1o3smnRJyrBmDdrJZ07JG82v73IHqHJLZjv8liPMD3if8j7HhL6FOEsOcoDZN35
	 eJywZW5fv64uj+qm8JYCjiiNqFHFFNOpBZ1/LC99YkT8x2F6ZTdIV35db/jj3ljFeY
	 J6fVphICe18RtapeYRHYMs6E4UXoekBdfeIM0EEkro1hEJY26M7++Cu9om9Kj0TG66
	 AlCahi+PXtrvg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	ltp@lists.linux.it,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1.y 00/18] Backport "make svc_stat per-net instead of global"
Date: Sat, 10 Aug 2024 15:59:51 -0400
Message-ID: <20240810200009.9882-1-cel@kernel.org>
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

Here is a backport series targeting origin/linux-6.1.y that closes
the information leak described in the above thread.

I started with v6.1.y because that is the most recent LTS kernel
and thus the closest to upstream. I plan to look at 5.15 and 5.10
LTS too if this series is applied to v6.1.y.

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

 fs/lockd/svc.c             |   3 -
 fs/nfs/callback.c          |   3 -
 fs/nfsd/export.c           |  32 ++++--
 fs/nfsd/export.h           |   4 +-
 fs/nfsd/netns.h            |  25 ++++-
 fs/nfsd/nfs4proc.c         |   6 +-
 fs/nfsd/nfscache.c         | 201 ++++++++++++++++++++++---------------
 fs/nfsd/nfsctl.c           |  24 ++---
 fs/nfsd/nfsd.h             |   1 +
 fs/nfsd/nfsfh.c            |   3 +-
 fs/nfsd/nfssvc.c           |  24 +++--
 fs/nfsd/stats.c            |  52 ++++------
 fs/nfsd/stats.h            |  83 ++++++---------
 fs/nfsd/trace.h            |  22 ++++
 fs/nfsd/vfs.c              |   6 +-
 include/linux/sunrpc/svc.h |   5 +-
 net/sunrpc/stats.c         |   2 +-
 net/sunrpc/svc.c           |  36 ++++---
 18 files changed, 301 insertions(+), 231 deletions(-)

-- 
2.45.1


