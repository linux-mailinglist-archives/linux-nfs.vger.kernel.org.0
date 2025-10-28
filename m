Return-Path: <linux-nfs+bounces-15730-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 932C7C16913
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 20:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC4F44F2CC0
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 19:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8174934F46C;
	Tue, 28 Oct 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riYo9HvQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8F21FF23;
	Tue, 28 Oct 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678368; cv=none; b=MSGI0OVHHR8k3ZfiuzhWCTRgpTxlo2e5+6V+yztBOqPYmtxzZ0lIYwDYtb5/VkviMbeKWT1be6B1YBQGNBKVRtxSHGFTUGt33IPPWoZOsC+nEsluYK4zOmbxZbBR6koshSdKNZ57wehpt8YjuIUrtqW7AxxptGP7VTAePdhHLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678368; c=relaxed/simple;
	bh=et3TjHHUJHnhLissX05CTcH7NUJZawlKWU51Gpn9pEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+fFynxk2Xs22g9/qHswydEiHQDf26Dx86RKeWBJ7P+B+8Ymvg19XLpCikObi53YbkVNJDJkU0T9EHTd84pCBgajLPOxtY3KXX9ZGqEV4v8LJhDj0prSHj5FzcXnWE2DEVNYivvaFQJCl2arDGutCv3rbvVzTTpIUagunBnkEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riYo9HvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA7DC4CEE7;
	Tue, 28 Oct 2025 19:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761678367;
	bh=et3TjHHUJHnhLissX05CTcH7NUJZawlKWU51Gpn9pEg=;
	h=From:To:Cc:Subject:Date:From;
	b=riYo9HvQ8On9iY3bCnZ6z2abrdWfCeBeU/lJbhtW5QoC9tj+woUbNM+l/soQDHrpZ
	 FPrOhxaVkm68O0msySR2L+cCOtidIVsAbSZIwChTWWjNYRk4uiLfv8titZPoTj7Qyr
	 DtHpzWuOv2D9oALRba7+ZRDj8r92fEAtiNK5ISOaj843ilTA6b0IKn8r2hOmGfbw92
	 KxA5RHh/7V0oNgyBCKC8OKiiEkfvfB62WuylKLhyRauaSZsG+j5y4bomdwvk/VkSe5
	 9Ju2c6JS7Uxbq3gyrie0UCyH5r/0657AHaVvCNMQ+QtEA/FYRut6nin2cLl0CYRRRw
	 8dkthCSVRK3uw==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] More NFSD fixes for v6.18-rc
Date: Tue, 28 Oct 2025 15:06:06 -0400
Message-ID: <20251028190606.43007-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 4b47a8601b71ad98833b447d465592d847b4dc77:

  NFSD: Define a proc_layoutcommit for the FlexFiles layout type (2025-10-10 12:53:50 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.18-2

for you to fetch changes up to 3e7f011c255582d7c914133785bbba1990441713:

  Revert "NFSD: Remove the cap on number of operations per NFSv4 COMPOUND" (2025-10-21 11:03:50 -0400)

----------------------------------------------------------------
nfsd-6.18 fixes:

Issues reported with v6.18-rc:
- Revert the patch that removed the cap on MAX_OPS_PER_COMPOUND
- Address a kernel build issue

Issues that need expedient stable backports:
- Fix crash when a client queries new attributes on forechannel
- Fix rare NFSD crash when tracing is enabled

----------------------------------------------------------------
Chuck Lever (3):
      NFSD: Define actions for the new time_deleg FATTR4 attributes
      NFSD: Fix crash in nfsd4_read_release()
      Revert "NFSD: Remove the cap on number of operations per NFSv4 COMPOUND"

Nathan Chancellor (1):
      nfsd: Avoid strlen conflict in nfsd4_encode_components_esc()

 fs/nfsd/nfs4proc.c  | 21 ++++++++++++++++-----
 fs/nfsd/nfs4state.c |  1 +
 fs/nfsd/nfs4xdr.c   | 21 ++++++++++++++-------
 fs/nfsd/nfsd.h      |  3 +++
 fs/nfsd/xdr4.h      |  1 +
 5 files changed, 35 insertions(+), 12 deletions(-)

