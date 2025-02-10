Return-Path: <linux-nfs+bounces-10027-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F6DA2F807
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 19:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A724A3A7FCF
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10D525E44A;
	Mon, 10 Feb 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acpTWoPM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896ED25E444;
	Mon, 10 Feb 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213947; cv=none; b=nSWdXWuww6sux7kb4UMxM0D8AWM+LsJyNbAbiZ3lbWo4x1Eo/EbLeGC/WoWfLeofZZ+9D0dFIcHlb3vux0vi583mAnveykqUZYhdRgpYhQmo0p+a2HI7VvhFCM07Y0k4K7ayZTI4JnCnghSOX2gbwBUSkJkt781EOgcdmC7An3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213947; c=relaxed/simple;
	bh=k0owo3IVCUR+CM41/5x/95F8+WLokMaFCe6y2riL7vI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D48X+krADUuoDVkUuCn/EUlug0GmCiJ8hOhy/FKHkdqvGPRTzilKRd5BRhsMyyzzTuwJh0VPVUh1BcR2nHgSh1ydcn6xZIMaiE8lk1qKmmWNcXnRP3yLhkCHOJZHOUmNETLievC9JoMTJSpcsDQcSCYQEvo5dSCTffL3her+UJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acpTWoPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAB6C4CED1;
	Mon, 10 Feb 2025 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739213947;
	bh=k0owo3IVCUR+CM41/5x/95F8+WLokMaFCe6y2riL7vI=;
	h=From:To:Cc:Subject:Date:From;
	b=acpTWoPMT07fidOgjrlJ91T0A07XoVZ9J/g1AXwHtYUv4ZgLhlOH6quRDa2vPLApJ
	 KOt3EdKpnw05GG8ohN0cl+jMsidWXpWfBxmwbtmECYX8oN4JV4x3Mym/UAmIG+U0xM
	 5SM4o5GGsiZtrxeN2Ha/p7/msbKttGihoZmKh9E7T0gUuKov4Y7d6kW1Yo/6ONltlh
	 sPcd1wgUkAjr+me2EqvpPBxNMXTC+SbSccya59L6t7k9AWXc4hiElG3mh4Z2H+VuxT
	 hXomirscoZRQd0EBV2FQBRxUkck+uqu8jECzQfnFMf2yqhgf6WPqzzi/uLc6QhWRhQ
	 Ay9fSQmjBZ4yA==
From: cel@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [GIT PULL] NFSD fixes for v6.14
Date: Mon, 10 Feb 2025 13:59:05 -0500
Message-ID: <20250210185905.116290-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus-

Note that my GPG key expired a few days ago. I renewed it with no
expiry and pushed it to pgp.mit.edu earlier today.

---

The following changes since commit c92066e78600b058638785288274a1f1426fe268:

  sunrpc: Remove gss_{de,en}crypt_xdr_buf deadcode (2025-01-21 15:30:01 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.14-1

for you to fetch changes up to 4990d098433db18c854e75fb0f90d941eb7d479e:

  NFSD: Fix CB_GETATTR status fix (2025-02-10 13:31:28 -0500)

----------------------------------------------------------------
nfsd-6.14 fixes:

- Introduced during the v6.14 merge window:
  - A fix for CB_GETATTR reply decoding was not quite correct
  - Fix the NFSD connection limiting logic
  - Fix a bug in the new session table resizing logic

- Bugs that pre-date v6.14
  - Support for courteous clients (5.19) introduced a shutdown hang
  - Fix a crash in the filecache laundrette (6.9)
  - Fix a zero-day crash in NFSD's NFSv3 ACL implementation

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Fix CB_GETATTR status fix

Dai Ngo (1):
      NFSD: fix hang in nfsd4_shutdown_callback

Jeff Layton (1):
      nfsd: validate the nfsd_serv pointer before calling svc_wake_up

Li Lingfeng (1):
      nfsd: clear acl_access/acl_default after releasing them

NeilBrown (1):
      nfsd: fix uninitialised slot info when a request is retried

Olga Kornievskaia (1):
      nfsd: fix __fh_verify for localio

 fs/nfsd/filecache.c    | 11 ++++++++++-
 fs/nfsd/nfs2acl.c      |  2 ++
 fs/nfsd/nfs3acl.c      |  2 ++
 fs/nfsd/nfs4callback.c |  9 ++++++---
 fs/nfsd/nfs4state.c    |  3 ++-
 fs/nfsd/nfsfh.c        |  5 +++--
 6 files changed, 25 insertions(+), 7 deletions(-)

