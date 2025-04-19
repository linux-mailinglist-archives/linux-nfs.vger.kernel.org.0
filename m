Return-Path: <linux-nfs+bounces-11189-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5BFA944DE
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 19:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFE83BB193
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B7E1C84C7;
	Sat, 19 Apr 2025 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/YLZndg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0B19066D;
	Sat, 19 Apr 2025 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083938; cv=none; b=pCbHX8x65qfTkLRNNDH8Xz4UX5BISXP5xG5OHN0U4V/tglRP2IZnUUaUJckaHTrBdikXvCIbzXux/C5vTHV0rJtCa327RVY4SwPUbEixi2R80RD0kmYNOmPXc/q6Cce52UvuM8xIuQyd37TjJ32Z50kRb0khSxGj64Dgmx4cUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083938; c=relaxed/simple;
	bh=F5gr2eFei0vNBUOugpBm7WEsuy7mqr3bMIQ8rcDq4fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dpjgeRfmK6iR5395DzD9kZXUaDVyGfvbMl5Rt29BXBCo6tOnTUx/vd1wkCNLTb1drhN+B//O9ID03xXEK8XrmiyjouzP73GcBwmforri7c581fUhYByVDJFjltDjU5h8jG37pg3baIK6buTpkJ972kqyFFqMxneCtnT54G6GtfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/YLZndg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DD0C4CEE7;
	Sat, 19 Apr 2025 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083937;
	bh=F5gr2eFei0vNBUOugpBm7WEsuy7mqr3bMIQ8rcDq4fY=;
	h=From:To:Cc:Subject:Date:From;
	b=T/YLZndgjxDHQvH+uySfN4z+DaieqKlIAFL7M5Mb+feOpYg4KpXmZlLkrjHZa2MPH
	 YPZlDQlnrndOR/px64/baotp3mn15j/qOawmfQ+zn7ikdinlSdkoxvgnzII7ta5bmU
	 6ekBIo+Aek4OVqQ2ZBUMBLrW+W69TBmg5ufRXKoDepGE49E8LKLMTZr5Os6/9luC2V
	 qEauvlFd2F9dmbVEQa2yGFuSTadxQR3GppC7GRWzSp22ePI2J3/uPK+qdHybIYkqUT
	 X2r3/aucP2yu8f0/7hEP6rViOZcYvFHwZj9QGbmRO2btp3L1BeKGvGGxols36vozvp
	 0uxFrxK1Cx2rw==
From: cel@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] First set of NFSD fixes for v6.15
Date: Sat, 19 Apr 2025 13:32:16 -0400
Message-ID: <20250419173216.7115-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 26a80762153ba0dc98258b5e6d2e9741178c5114:

  NFSD: Add a Kconfig setting to enable delegated timestamps (2025-03-14 10:49:47 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.15-1

for you to fetch changes up to a1d14d931bf700c1025db8c46d6731aa5cf440f9:

  nfsd: decrease sc_count directly if fail to queue dl_recall (2025-04-13 16:39:42 -0400)

----------------------------------------------------------------
nfsd-6.15 fixes:

- v6.15 libcrc clean-up makes invalid configurations possible
- Fix a potential deadlock introduced during the v6.15 merge window

----------------------------------------------------------------
Eric Biggers (1):
      nfs: add missing selections of CONFIG_CRC32

Li Lingfeng (1):
      nfsd: decrease sc_count directly if fail to queue dl_recall

 fs/Kconfig           | 1 +
 fs/nfs/Kconfig       | 2 +-
 fs/nfs/internal.h    | 7 -------
 fs/nfs/nfs4session.h | 4 ----
 fs/nfsd/Kconfig      | 1 +
 fs/nfsd/nfs4state.c  | 2 +-
 fs/nfsd/nfsfh.h      | 7 -------
 include/linux/nfs.h  | 7 -------
 8 files changed, 4 insertions(+), 27 deletions(-)

