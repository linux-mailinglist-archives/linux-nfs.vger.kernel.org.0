Return-Path: <linux-nfs+bounces-16306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15912C53D27
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 19:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 037804E27F7
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Nov 2025 17:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23510345750;
	Wed, 12 Nov 2025 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcI/QEhF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8C23BCEE;
	Wed, 12 Nov 2025 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970036; cv=none; b=KC5JBZWuZmNG514QyT9/z7+FyawXlR/VCCx/XEItiULwUKB4u7Ln7LyDS5LkiFkxNAK0fmBcFbYoXJhy3ZRpAodtYVXWOWhWKfSKfP15Mhst//thUbL4FLD7q2J17QYqh7cvpHeWxqSXrNwbbKSU97xu/6uMPe4PlZNHM6SrJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970036; c=relaxed/simple;
	bh=4b3se09iHRWwWYcdoNAIZlLBYirLJ2RPBDSWNssH0LA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDBQA3seaiUd13QF3ou1rE+OFW1OXsEoEx81eILd0TFNGcA5MP6i3OxMNWx0aW2G7LrmYC67oTlmz1L4hqYrz+vsn3GTQSskPDwrs4YieSxqSdmyab7lRkQYttQLsyNsbJH0pWae9k2Ts6t7+9d60EninOQI0JV6WgVx8kfM93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcI/QEhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C808C19422;
	Wed, 12 Nov 2025 17:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762970035;
	bh=4b3se09iHRWwWYcdoNAIZlLBYirLJ2RPBDSWNssH0LA=;
	h=From:To:Cc:Subject:Date:From;
	b=pcI/QEhFuUQusIdh5b6gEC5cssjrm1ylszm0/06WdesfyAg7iW+jLOhn7KTLzMLXY
	 h57ZIjnqhh1innDdeCrsl88w0l6Ol8YmSp1ZQEj/jdZ19tinG7nZSbOqXV1qQ/mXrd
	 wt43hVS1ri+PkoI4KcLrC3Ha9eN5o6e3fUQx1AX55t/I/C6o82FBerYFdMpxoLegrY
	 6cVmdKPMfW2MOsSAW4Q9Yo1Ef9b5OidOFhykQ97AzHLA5IyJxvCdvm1LpS96YvyNob
	 tqP+aU8byIu18Liav3V+wOmNfmvP6VVHtzN/6L0/SlgEYO3fXm4amTQ9IIYu8ltVqP
	 K9mGGu+N88IKA==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] Third round of NFSD fixes for v6.18
Date: Wed, 12 Nov 2025 12:53:54 -0500
Message-ID: <20251112175354.13059-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 3e7f011c255582d7c914133785bbba1990441713:

  Revert "NFSD: Remove the cap on number of operations per NFSv4 COMPOUND" (2025-10-21 11:03:50 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.18-3

for you to fetch changes up to 324be6dcbf09133a322db16977a84fbb45c16129:

  Revert "SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it" (2025-11-10 09:31:52 -0500)

----------------------------------------------------------------
nfsd-6.18 fixes:

Address recently reported issues or issues found at the recent NFS
bake-a-thon held in Raleigh, NC.

Issues reported with v6.18-rc:
- Address a kernel build issue
- Reorder SEQUENCE processing to avoid spurious NFS4ERR_SEQ_MISORDERED

Issues that need expedient stable backports:
- Close a refcount leak exposure
- Report support for NFSv4.2 CLONE correctly
- Fix oops during COPY_NOTIFY processing
- Prevent rare crash after XDR encoding failure
- Prevent crash due to confused or malicious NFSv4.1 client

----------------------------------------------------------------
Chuck Lever (3):
      NFSD: Skip close replay processing if XDR encoding fails
      NFSD: Never cache a COMPOUND when the SEQUENCE operation fails
      Revert "SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending on it"

NeilBrown (2):
      nfsd: fix refcount leak in nfsd_set_fh_dentry()
      nfsd: ensure SEQUENCE replay sends a valid reply.

Olga Kornievskaia (2):
      nfsd: add missing FATTR4_WORD2_CLONE_BLKSIZE from supported attributes
      NFSD: free copynotify stateid in nfs4_free_ol_stateid()

 fs/nfsd/nfs4state.c | 68 ++++++++++++++++++++++++++++++++++++++---------------
 fs/nfsd/nfs4xdr.c   |  5 ++--
 fs/nfsd/nfsd.h      |  1 +
 fs/nfsd/nfsfh.c     |  6 ++---
 fs/nfsd/xdr4.h      |  3 ++-
 net/sunrpc/Kconfig  |  3 +--
 6 files changed, 58 insertions(+), 28 deletions(-)

