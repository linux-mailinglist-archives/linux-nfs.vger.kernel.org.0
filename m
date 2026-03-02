Return-Path: <linux-nfs+bounces-19499-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNEEJgmcpWmfEwYAu9opvQ
	(envelope-from <linux-nfs+bounces-19499-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 15:17:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 977461DA884
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 15:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55029303D4DE
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90893FD13A;
	Mon,  2 Mar 2026 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI1Z5QaF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CEC8EB;
	Mon,  2 Mar 2026 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460691; cv=none; b=AgflpCCKsNfyLis3EwAuYOGHc5i6mAOIQshEVnCDWGzExAFUzMyZn3XXQkHTJFRl3oBDoltjr5JAc6rf28kgxpWoa/938QZqvc1FutZwoTcROlJfuGpyv+jexA7gIlSvw87+Ws3TZl8w3M49Dj0ACnGAA+mixaKH/PgIi9O1oEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460691; c=relaxed/simple;
	bh=MDftjcC1mSgCSd2IuUj1q3+4aSGvqwrNZNcMgNWygWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNpiEohY9/3WqladBOzbriik6CjewL7AeMniDVaMtgos5WkWgtNXgEYOfQeE0AbJe88j7/dhfcK4AjMI4jKEI1giwkK6K9RnQj3j+o6C5kVslIfs46s1RrZaM6sARYZlOe0jmAZEAoT5YSoJMttoOlOa8mRVMkgvUaNcrLSMJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI1Z5QaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064DAC19423;
	Mon,  2 Mar 2026 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460691;
	bh=MDftjcC1mSgCSd2IuUj1q3+4aSGvqwrNZNcMgNWygWs=;
	h=From:To:Cc:Subject:Date:From;
	b=mI1Z5QaFAyKNDFwSibI6KgA/4Rj3xuss0tq8TUZ4iFLeHer9W8RMVH4Xg1evu8O8S
	 umMZ2bj5B6QLQ7wLYW6mJWRDeoeAtmdMs7HGGnVVEhyzdiOdawE8dYcIKmRTFszUN5
	 yiv12h2KPIF1qxw3sauIISxtJQWj7uVBIwGyY+Et/U39ZAR897BWDN5HwRyB4xmHth
	 SZwh8tLyn781HgbED1/LnUTTdhmpxVOadZRBFWa/cB+RcCYNT1TnI/PAnAo1FVIk2y
	 5SSU75H1h8gZpGhMOeL0G9KdYPrGy49r6Q4FsfZJYdTprtr9kthZH1w/riM9RmEtMj
	 ozDyLH+6lswcQ==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] First round of NFSD fixes for v7.0
Date: Mon,  2 Mar 2026 09:11:29 -0500
Message-ID: <20260302141130.9098-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19499-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 977461DA884
X-Rspamd-Action: no action

The following changes since commit e939bd675634fd52d559b90e2cf58333e16afea8:

  NFSD: Add POSIX ACL file attributes to SUPPATTR bitmasks (2026-01-29 09:48:33 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.0-1

for you to fetch changes up to 364410170ab33f6e7ef0eb2afb12bf89b0feb3a6:

  nfsd: report the requested maximum number of threads instead of number running (2026-02-24 10:27:51 -0500)

----------------------------------------------------------------
nfsd-7.0 fixes:

NFSD fixes that arrived too late for the 7.0 merge window.

Fixes for commits merged in 7.0:
- Restore previous nfsd thread count reporting behavior

Issues that need expedient stable backports:
- Fix credential reference leaks in the NFSD netlink admin protocol

----------------------------------------------------------------
Jeff Layton (1):
      nfsd: report the requested maximum number of threads instead of number running

Kuniyuki Iwashima (2):
      nfsd: Fix cred ref leak in nfsd_nl_threads_set_doit().
      nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().

 Documentation/netlink/specs/nfsd.yaml |  4 ++--
 fs/nfsd/nfsctl.c                      | 22 +++++++++++-----------
 fs/nfsd/nfssvc.c                      |  7 ++++---
 3 files changed, 17 insertions(+), 16 deletions(-)

