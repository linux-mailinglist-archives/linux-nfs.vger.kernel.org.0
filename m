Return-Path: <linux-nfs+bounces-21637-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAF4IlgrB2ppsQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21637-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 16:19:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1705513ED
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 16:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29DB230182AC
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9FA48B377;
	Fri, 15 May 2026 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv9hJ6uX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15F481FAA;
	Fri, 15 May 2026 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854468; cv=none; b=CxTPhqs0utVZPsdD2oUZDHkHJlkwrfcYDtah5KWhclF9pcSht62hvZ4dU2jsI8WJXqGykw0Wb+o4FJ+b62QMDg4QHaGhg06dPDao3CFxxd+78BTlysFw2d5AJodzZGJBip/WswZZ2FcvI+sOkX14+mEhNXCFxAELWGsXucJUgdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854468; c=relaxed/simple;
	bh=PupZGIUIOWTzqfwyczHyLau2+0ZLlxqhSbjCJk7ooDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ECv3vYaJq2nC2NNKv4uj7QPEfpLi6LY1NpW1MfsgNQC1Ii5HvncnNcN7Av+xTZa3hp6iyppWoov00eB1pa0n/2Hm7UF64wyNKMvOCKW0WE0WN/2EChN72uRuLmCkHGStc8AVu8Ed0vmPbzCDw28ygq4KWEYAJMubEghLormMyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv9hJ6uX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D473C2BCB0;
	Fri, 15 May 2026 14:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778854467;
	bh=PupZGIUIOWTzqfwyczHyLau2+0ZLlxqhSbjCJk7ooDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hv9hJ6uXMUL6EaUhA3nb+DbiIbU17AmMC4VT7GHKurnfL4paRylcYM0r2cXLrH9MS
	 W+92/8rsUhiSClrY0SVyk4ZZdHgy6c6BAsSygNGQgq5QqcbGnCI1+C67BSugVxNLvf
	 2ye2ef9FElKVHtYNFatU1qfs8aFytURUjHVjhUrS9QsSwa56X7pRTrWSlB/2DfD9gi
	 eVPAYoGG9oOO7PWIGbfif7dVk287+q44IBApZLIjaQjUUObji4vCYGk7FTsw18Yn4H
	 hy6yM1maPfuOlmyKNDEMasutWmuavbdU5RbSajM2Ry0U16d5u1Caa8/skCK1bmj3+m
	 Dtfo71vOpcaNA==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD fixes for v7.1-rc
Date: Fri, 15 May 2026 10:14:26 -0400
Message-ID: <20260515141426.357776-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C1705513ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21637-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The following changes since commit d644a698de12e996778657f65a4608299368e138:

  NFSD: Docs: clean up pnfs server timeout docs (2026-04-03 09:29:32 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.1-1

for you to fetch changes up to 4f8ef58c10bfe5f86a643c7c8331b37e69e3dae1:

  NFSD: Fix infinite loop in layout state revocation (2026-05-10 12:41:08 -0400)

----------------------------------------------------------------
nfsd-7.1 fixes:

Issues reported with v7.1-rc:
- Correctness fix for the new sunrpc cache netlink protocol

Issues that need expedient stable backports:
- Correctness fixes for delegated attributes
- Prevent an infinite loop when revoking layouts

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Fix infinite loop in layout state revocation

Jeff Layton (1):
      sunrpc: start cache request seqno at 1 to fix netlink GET_REQS

Olga Kornievskaia (3):
      nfsd: fix GET_DIR_DELEGATION when VFS leases are disabled
      nfsd: update mtime/ctime on CLONE in presense of delegated attributes
      nfsd: update mtime/ctime on COPY in presence of delegated attributes

Scott Mayhew (1):
      nfsd: fix file change detection in CB_GETATTR

 fs/nfsd/nfs4proc.c  | 18 ++++++++++-----
 fs/nfsd/nfs4state.c | 64 ++++++++++++++++++++++++++++++++++++-----------------
 fs/nfsd/state.h     |  1 +
 fs/nfsd/xdr4.h      |  1 +
 net/sunrpc/cache.c  |  2 +-
 5 files changed, 60 insertions(+), 26 deletions(-)

