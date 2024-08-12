Return-Path: <linux-nfs+bounces-5326-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793EE94F996
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 00:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2431E1F22BEB
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 22:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC1194A6C;
	Mon, 12 Aug 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNDabvya"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED915C12D;
	Mon, 12 Aug 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502168; cv=none; b=o2Xwox6d8/LQSvXhzXN9dR83qfklACDTsPJLQXsgos7P1Gf3Pn8TrigzLIFwv/ZC7kjcwCy6xJGDzZg4gTMyzXrSiIoYmpXo0UleG3ifdFB5JMo0SZRH1sB0orS0Yr38mSTm0LF4hBoPUUDb70T00ibQqpzUrTAxtXIRN8ZG/H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502168; c=relaxed/simple;
	bh=YZzDT6b6QlZXy7PlKgKU3oVVt20wZn4lpLmuAx/rlwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VfcSMDjD1vGP38RnrJsNydXx1Vla58p9sKgb3UICazann8u3mLhHMrYJUqN5EfnsTIFyjgmgiXnuXP8gSUg6LDnm0Ne5SdUvS616CPf0SJksA1Mr2VNzOEb1fgHcCtdXKNQDVUa7StdV7/Afb5sKXQhfAvxUkxYuTfadw48Hvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNDabvya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F43C4AF0D;
	Mon, 12 Aug 2024 22:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723502168;
	bh=YZzDT6b6QlZXy7PlKgKU3oVVt20wZn4lpLmuAx/rlwE=;
	h=From:To:Cc:Subject:Date:From;
	b=gNDabvyaJGsT8g3jRSjXPNf++7X1iOGIxvmRywYOJ6L6sNp6nY6ISs77GhjEWsO08
	 NNrkPeoMS0+5a3gi29PXOdn8OP+gyIpsn+t7aGFhMwe2246s2+q/vzpK17sECUBpbp
	 EhXSHO/tpfa2NbfwjHs4oJpIObky8hP5O+JMmgGjtIp5/6Mfj4Mf3YY2tKx8yPGw7C
	 QkhksjRTf1IOSqpqmr2fa6AnvpjT/RjzzgiDuz3kebj9QUoUUuHeWgyt+AHg3E9wGT
	 SMaOIifULA+YmBiWEFPoGt4RcO3nkysILSfbhYyrdT6klX4K6JBRC3Y+2PbbKqKXis
	 u6Thzu0Ihovlg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6.y 00/12] Backport "make svc_stat per-net instead of global"
Date: Mon, 12 Aug 2024 18:35:52 -0400
Message-ID: <20240812223604.32592-1-cel@kernel.org>
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

Following up on:

https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/

Here is a backport series targeting origin/linux-6.6.y that closes
the information leak described in the above thread. It passes basic
NFSD regression testing.

Review comments welcome.   

Chuck Lever (2):
  NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
  NFSD: Fix frame size warning in svc_export_parse()

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

 fs/lockd/svc.c             |  3 --
 fs/nfs/callback.c          |  3 --
 fs/nfsd/cache.h            |  2 -
 fs/nfsd/export.c           | 32 ++++++++++----
 fs/nfsd/export.h           |  4 +-
 fs/nfsd/netns.h            | 25 +++++++++--
 fs/nfsd/nfs4proc.c         |  6 +--
 fs/nfsd/nfs4state.c        |  3 +-
 fs/nfsd/nfscache.c         | 40 ++++-------------
 fs/nfsd/nfsctl.c           | 16 +++----
 fs/nfsd/nfsd.h             |  1 +
 fs/nfsd/nfsfh.c            |  3 +-
 fs/nfsd/nfssvc.c           | 14 +++---
 fs/nfsd/stats.c            | 54 ++++++++++-------------
 fs/nfsd/stats.h            | 88 ++++++++++++++------------------------
 fs/nfsd/vfs.c              |  6 ++-
 include/linux/sunrpc/svc.h |  5 ++-
 net/sunrpc/stats.c         |  2 +-
 net/sunrpc/svc.c           | 39 +++++++++++------
 19 files changed, 163 insertions(+), 183 deletions(-)

-- 
2.45.1

