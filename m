Return-Path: <linux-nfs+bounces-13552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D20B20B8F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE94427660
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 14:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73215202C3E;
	Mon, 11 Aug 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEKRnI3P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCB19CC02;
	Mon, 11 Aug 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921606; cv=none; b=pUXKpS8e7Q7OmKmxLVCzIUsaK731hRnMe+PjeUSSLFA+OoDTul1Io055MXiHsj+21J9v6se8WC51qN8Pkv+3BJCVawR0uVrS/Pc7rT/fC4Xrh5BxEw2UappGBOci6IpADUgYr8RuYy/E+5Y9+teBM3wZBuddm7hZFtMEKQ3vcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921606; c=relaxed/simple;
	bh=YODxWRV0t5j0Uvx0KfcISHMYG/15/qfa1cKGeXfizDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRCKLwSeSY4fhVWBrf3sSAohJMOKEAuGJHAkKaS6g6uPs4/NsovzuRbnl59X8Zo0YNky5Odo/QbG/GkqyDGueaYJZwESsORZdSB5UKz0uJ+MHUVlj0Q/3A39+Cr1lL6L/tFeCfxLqmNXIb6L4Gs57H/GzcrwUYgucspnaoqyxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEKRnI3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682D0C4CEED;
	Mon, 11 Aug 2025 14:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754921605;
	bh=YODxWRV0t5j0Uvx0KfcISHMYG/15/qfa1cKGeXfizDo=;
	h=From:To:Cc:Subject:Date:From;
	b=XEKRnI3PhAheE2mgilO7vDmXHdXSCGbo7TWfrPZaUK1Jkimahd21goYCimKwa0bkB
	 XNY/kuOxstrpsWLhJ95WlNWK6igZ/ULEfeCZ41NjlRsHszzgoow6banBmYBZgXhLpz
	 PISS5qIKSCG+x8d9B6FwWtUOBTcVPp/U2miQzILAz5rJFI91tPyZKZ0GHSPB6WUZSB
	 WapoVp1zUb4GSJhd3DPmisyJETa+bSLVJ1ej29PDY4rSXGi7CN5BcYYZnwd6RL25Cj
	 EyXsw44GPWZ4Q9QzeuXlEENJEiywfvX64zNAjIh1Bce3j3ZCGZj67lTgbyTbKZlrYG
	 BLFzv7Q0E6L8g==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>
Subject: [GIT PULL] NFSD fixes for v6.17-rc
Date: Mon, 11 Aug 2025 10:13:24 -0400
Message-ID: <20250811141324.6094-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e339967eecf1305557f7c697e1bc10b5cc495454:

  nfsd: Drop dprintk in blocklayout xdr functions (2025-07-14 12:46:50 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.17-1

for you to fetch changes up to bee47cb026e762841f3faece47b51f985e215edb:

  sunrpc: fix handling of server side tls alerts (2025-08-06 09:57:50 -0400)

----------------------------------------------------------------
nfsd-6.17 fixes:

- A correctness fix for delegated timestamps
- Address an NFSD shutdown hang when LOCALIO is in use
- Prevent a remotely exploitable crasher when TLS is in use

These arrived too late to be included in the initial nfsd-6.17
pull request.

----------------------------------------------------------------
Jeff Layton (1):
      nfsd: don't set the ctime on delegated atime updates

NeilBrown (1):
      nfsd: avoid ref leak in nfsd_open_local_fh()

Olga Kornievskaia (1):
      sunrpc: fix handling of server side tls alerts

 fs/nfsd/localio.c    |  5 +++--
 fs/nfsd/vfs.c        | 10 +++++++++-
 net/sunrpc/svcsock.c | 43 +++++++++++++++++++++++++++++++++++--------
 3 files changed, 47 insertions(+), 11 deletions(-)

