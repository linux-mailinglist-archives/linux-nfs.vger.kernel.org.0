Return-Path: <linux-nfs+bounces-1472-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 825FE83DDAC
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6FB1F238F9
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4991CF83;
	Fri, 26 Jan 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oChAOhNi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F781CFA9
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283630; cv=none; b=u/WFpqBezuOXDrV27PVlF4cpJ4Eba0PkUsojFDH2x8LObqY3v85NbKkRINpZWOSTVV81sz29kt+Ilt2b42meQ/fT8oa7axNjOPqB+9Fg5OkoRAPVfKdKrC9OpeaU1gSsyXRv3ttklM7LF8Pa0ifVPAkEWekWSVv2Iz2q4KlSDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283630; c=relaxed/simple;
	bh=3a6v9OmqwgF07AvQBqsvMoAuQ4G9nFb104zBF13advs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ir6iorF1SEkRUGmfT/4QwY3y/QCwCHqbJYK0Rb6AvQKFZ+VDYMnPi4tOnEw0IJc3xMaWOQgIOskB2Gq9g3u1SMBnYNwwayA7NJ1FiDsohR4s9vd01DYqg5BoS+ikdqvJRomCyiZouj3AvrAEwwnckaxfB3BIiPgt/KCO5RhNYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oChAOhNi; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc256e97e0aso362771276.2
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283627; x=1706888427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ3ez6t5PnMSuNaWcSovI+99AQHhcdQwE3a4hRRZDJY=;
        b=oChAOhNiJ8FYCzO0/YMtdpI5NtzmcQkzlmhEp8q0UzlVZHQ1aMcbqXAweJnZfOZWD/
         JVNICdCHtOEd4BTmYfpPM2GdZ8mKcK6WNMPPPBkKAnYRL/b7X7RDAXkoF/e0A+Qc1rMk
         dMdgiVbYM85p1QKeyE2g5PFIppHaQ6CvlxameyfLAiPkjwXVI9Rz/Ao+YAFyLk/10fLb
         9sw7fb/G5KEgk2m3cjIqz+lwFyTj5ceJB/kExvQsVDdpW4B4H9QYSrDNCSZhnb052p/V
         Us7TpnMo9w5nkmaAcWVsKG16qgJFZZDm3YuIMCb8YPD32HJgPM3ymdQ8Ijbdn13CzJaY
         5dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283627; x=1706888427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ3ez6t5PnMSuNaWcSovI+99AQHhcdQwE3a4hRRZDJY=;
        b=GJw26DP6v9viN8+aNZ+rzQM4SaW5FGxt6vQUFFGu9akyGxalDjzNt88DEdhrGvSaL0
         m+zjV96BzmMx1vWPb3b/v4Ya5ZJWTJ72CPWJbPjH21EPQr2thSpcfcmWIvCCQu0UbD9O
         AbXxiP6YqGInZXJuCkEmkAzMpi5xWsteDkLy7enupafLOz5haHzHPjBWYlWh9X+yj1u8
         uq++d5R9e0SPMLXe6CvT5fabw6xRl//yr1Od7ZcsrdxDGJZubzUVLnuQyQN38hqNS7nM
         Edr69okmqSozNnguV0Z5he453pOEDIrHvuuTql9L+uQNowv5dJ/6R5+qnYtHNX6rQXTI
         MbTg==
X-Gm-Message-State: AOJu0Yxul67ibQG8Awt6kZUz3RZowZ1A1BFrxLoM/JD55LQNgbh0SZI7
	SLu7Vkwxay8D7ANmJ2PGZkpUB30Qq8ZhL6E2uYGnjHBmu7tzbWxh6CZP9aJeeI0=
X-Google-Smtp-Source: AGHT+IH0qJ3osuca8/JakUmwRWL2X7D/DMNTa9eAfAoEULsAE/R69JqO2ijuBKT9Q0nwrI8l1YYszg==
X-Received: by 2002:a25:902:0:b0:dbd:5db5:475a with SMTP id 2-20020a250902000000b00dbd5db5475amr22953ybj.34.1706283626920;
        Fri, 26 Jan 2024 07:40:26 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a056902100a00b00dc237c2d43csm438824ybt.49.2024.01.26.07.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:40:24 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 00/10] Make nfsd stats visible in network ns
Date: Fri, 26 Jan 2024 10:39:39 -0500
Message-ID: <cover.1706283433.git.josef@toxicpanda.com>
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

NOTE: there's still one nfs change in here and it's where I dropped pg_stats, I
assume that's ok for this series, but I can break it out and then follow up with
a removal later if necessary.

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

Josef Bacik (10):
  sunrpc: don't change ->sv_stats if it doesn't exist
  nfs: stop setting ->pg_stats for unused stats
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
 fs/nfsd/cache.h            |  2 --
 fs/nfsd/netns.h            | 25 +++++++++++---
 fs/nfsd/nfs4proc.c         |  6 ++--
 fs/nfsd/nfs4state.c        |  3 +-
 fs/nfsd/nfscache.c         | 40 +++++-----------------
 fs/nfsd/nfsctl.c           | 16 ++++-----
 fs/nfsd/nfsd.h             |  1 +
 fs/nfsd/nfsfh.c            |  3 +-
 fs/nfsd/nfssvc.c           | 14 +++-----
 fs/nfsd/stats.c            | 52 ++++++++++++----------------
 fs/nfsd/stats.h            | 70 +++++++++++++-------------------------
 fs/nfsd/vfs.c              |  5 +--
 include/linux/sunrpc/svc.h |  5 ++-
 net/sunrpc/stats.c         |  2 +-
 net/sunrpc/svc.c           | 39 +++++++++++++--------
 17 files changed, 126 insertions(+), 163 deletions(-)

-- 
2.43.0


