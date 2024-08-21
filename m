Return-Path: <linux-nfs+bounces-5502-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BABE95A07B
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037081F216C5
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749BD1B1D66;
	Wed, 21 Aug 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMUjjSpC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF151B1D4E;
	Wed, 21 Aug 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252155; cv=none; b=IzmYXIByDpNsO61GiFjaDfvqwFwk5Ptb1SNBwHBdxQ8X40hgkim7ReSnOxJlLjt0iimL8xFfZfMQIwwXeePpyZN9Fbg6eBS6WZU96MJovSzef7TWrKTmn03c6b5vB0D9XC1nDoIg5vzQk5zIIFsocg/F/K5aPXihAabqs0/IIiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252155; c=relaxed/simple;
	bh=Z27Jo76f3T2sy25byCwkgjJLEz5yoPzSv/niImKLgrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MfL0qE4HUJBEXGo6tb9LDxLEIxXxmbMQj38uJfeU7o9Le4SZsuzGvJC631/wc/kbMqNg/fmNnvO5oe3M6kJD5ncfmPV2Y3AGndm5isKr62ytqHUqySc1jq7V7smEj4+d8VCzAchU6n8Lgp3pNLqXHB9thuoWFyK9QXEcRE+6Uwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMUjjSpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7BDC4AF0E;
	Wed, 21 Aug 2024 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252154;
	bh=Z27Jo76f3T2sy25byCwkgjJLEz5yoPzSv/niImKLgrQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lMUjjSpChUxEvkyuGpvoqf3djfKUlQ2t5Kdei6Esarmhll1a+FCOgarFT/xOLOOKe
	 X1JWpXo0mvNCy3hFiaxaEVpXEm93BpvIgBpbHg9DDaWv5lSL9C9msHrfMxvwzki25N
	 fsG3XU5/pWfmw1Sp5Rg/uvgvbj+rlKYW98E95DlkBBMnqLZUGQhzVwBPvX4LdF1OL9
	 iavzQ1a9oLxcJ0Nkr09LMS0NhGYmVn+JH1xNXcSvvpwk3IcvYIyhkNBXGJOwTe6d94
	 krqR8pNzBFHPM5yyXjhnmQLGbOg/asagIzrwTpKuD6w0SVX9+sb/ebZtoSUs8ZWNJJ
	 dN7QU22lZ4B9Q==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15.y 00/18] Backport "make svc_stat per-net instead of global"
Date: Wed, 21 Aug 2024 10:55:30 -0400
Message-ID: <20240821145548.25700-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
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

Here is a backport series targeting origin/linux-5.15.y that closes
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
 fs/nfsd/nfssvc.c           |  24 +++--
 fs/nfsd/stats.c            |  52 ++++------
 fs/nfsd/stats.h            |  83 ++++++---------
 fs/nfsd/trace.h            |  22 ++++
 fs/nfsd/vfs.c              |   6 +-
 include/linux/sunrpc/svc.h |   5 +-
 net/sunrpc/stats.c         |   2 +-
 net/sunrpc/svc.c           |  36 ++++---
 18 files changed, 302 insertions(+), 231 deletions(-)

-- 
2.45.2


