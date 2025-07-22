Return-Path: <linux-nfs+bounces-13170-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A44B0CFDC
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 04:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65653AFEC2
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 02:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6BF2737F0;
	Tue, 22 Jul 2025 02:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKncOFne"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7E1272E6B
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152566; cv=none; b=jcACK/K0YIfgwLZAugzOKbebDHHKzo7Wvvtl3mHrZJLcITr/tNNPTvRg+dVhsqUNe9EFL6ceBrULroLgyXByloONqr3D89Iu1X8ICGPqgNorxXujpRa5Ewiqs197Ob7Oq0dkJURoQlBMRlSfzODb9MdIhZtk9IWfff+CbphMW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152566; c=relaxed/simple;
	bh=f9jnpPhYb/ImzUCnnR0tgxteUTl84fcOVy1NC2XFFMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGkg0USyNU4clm6BnA7YVQVwo9WIfK9BoNk4QDfBxl1h4TMOneaQ881KBVNICipNwJW48ZB1djWh4X59iqKTwKMBv0TtmT6JMFJ74Hsw9At6zCbsdCMlIc8Y5ATDFX4Zr23AHGwowFYXnvTC4dU3tKBfHT5FC1caJNuvgIbeyoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKncOFne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7E7C4CEED;
	Tue, 22 Jul 2025 02:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753152565;
	bh=f9jnpPhYb/ImzUCnnR0tgxteUTl84fcOVy1NC2XFFMs=;
	h=From:To:Cc:Subject:Date:From;
	b=GKncOFneNY3qfWyTzXtxhDQ4KoZpmaYkj9gUQBoNL9lipWT+s+VfQnsDX9/mCsCZt
	 Wo8Apc/NVeWwFboj9IYONHOzbnlfLMxo1t93GNgb1KTNbazir1+s+++KUFvwoBWt/o
	 BAb+VclArFyktO6LA5Xtvy7KhStYGsw6cU730Dk5F5WoNm8ogqzZuvLMug5+ywVgHs
	 mw0ZAf4aa2kvba3AMrQFZr36jiCcBndqhCKH+cf+GWYhuHLvCS/XZl5sDEN5TzbESD
	 bO71GDIE32TprfUTsNNvfc+6xh7hXlZQvTYh6AtSs3e8s9j42bhkopdmR8eCWqFCQA
	 toBpeyE7yjKxg==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/7] NFS DIRECT: handle misaligned READ and WRITE for LOCALIO
Date: Mon, 21 Jul 2025 22:49:17 -0400
Message-ID: <20250722024924.49877-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This "NFS DIRECT" series depends on the "NFSD DIRECT" series here:
https://lore.kernel.org/linux-nfs/20250714224216.14329-1-snitzer@kernel.org/
(for the benefit of nfsd_file_dio_alignment patch in this series)

The first patch was posted as part of a LOCALIO revert series I posted
a week or so ago, thankfully that series isn't needed thanks to Trond
and Neil's efforts.  BUT the first patch is needed, has Reviewed-by
from Jeff and Neil and is marked for stable@.

The biggest change in v2 is the introduction of O_DIRECT misaligned
READ and WRITE handling for the benefit of LOCALIO. Please see patches
6 and 7 for more details.

Changes since v1:
- renamed nfs modparam from localio_O_DIRECT_align_misaligned_READ to
  localio_O_DIRECT_align_misaligned_IO (is used for misaligned READ
  and WRITE support in fs/nfs/direct.c)
- added misaligned O_DIRECT handling for both READ and WRITE to
  fs/nfs/direct.c which in practice obviates LOCALIO's need to
  fallback to sending misaligned READs to NFSD.
- But the 5th patch that adds LOCALIO support to fallback to NFSD is a
  useful backup mechanism (that will hopefully never be needed unless
  some fs/nfs/direct.c bug gets introduced in the future). Patch 5
  also provides refactoring that is useful.

Thanks,
Mike

Mike Snitzer (7):
  nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
  nfs/localio: make trace_nfs_local_open_fh more useful
  nfs/localio: add nfsd_file_dio_alignment
  nfs/localio: refactor iocb initialization
  nfs/localio: fallback to NFSD for misaligned O_DIRECT READs
  nfs/direct: add misaligned READ handling
  nfs/direct: add misaligned WRITE handling

 fs/nfs/direct.c                        | 262 +++++++++++++++++++++++--
 fs/nfs/flexfilelayout/flexfilelayout.c |   1 +
 fs/nfs/internal.h                      |  17 +-
 fs/nfs/localio.c                       | 231 ++++++++++++++--------
 fs/nfs/nfstrace.h                      |  47 ++++-
 fs/nfs/pagelist.c                      |  22 ++-
 fs/nfsd/localio.c                      |  11 ++
 include/linux/nfs_page.h               |   1 +
 include/linux/nfslocalio.h             |   2 +
 9 files changed, 485 insertions(+), 109 deletions(-)

-- 
2.44.0


