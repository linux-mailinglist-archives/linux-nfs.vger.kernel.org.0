Return-Path: <linux-nfs+bounces-21988-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GFJMqn4FWpxgQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21988-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 21:46:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 712BD5DC1B2
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 21:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38968302A7DA
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79F113AD1C;
	Tue, 26 May 2026 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIZFRH2Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFED2030A;
	Tue, 26 May 2026 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824805; cv=none; b=PPoDbKVzQJ+5yxJTFyKs8RUYmAFcKha1MA0qqFDzjxt1STTjBwHi35d19t9nhY+8Pi+RSJA0f9I/lY9y00Vr+aG1BdHXS7V1FJnIeerIqCCME9l098tk5eBQbZxuMOOJ6vmZdG+UfgJ1YVihegYIXZ0IaxyaEpHnpKDb2guuKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824805; c=relaxed/simple;
	bh=GYuSZxbwc47rCjuBVhyi3AsWfTWnRH48TN4A1UjDw8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iv0iZwITqI1R4l+yMm16tcY5BXiA1+KlSZs3YuXGeDKzWZCuvahEg3VAfeGkw/TSKgGnGCsjce6/IzOuCQv2QXBSr6eWGNOAR42DDncYPuXJau9DshfEPfRKNz9k6evfszsyAz+cJ4qqoqbbQEHgRepDMCOyuwoYQORM870Ouqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIZFRH2Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23BD1F000E9;
	Tue, 26 May 2026 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779824804;
	bh=nvPqcgp99rGR290IbOGwIooVUWWcSGWbqEpEv+gGOPI=;
	h=From:To:Cc:Subject:Date;
	b=hIZFRH2Q3a1Xeh6fq87U85mtrAIBc94P+Ap2ct+n18aL/qRwrcmARo9ONBOlEX8ka
	 FeAxt2KBsiLq2DJSz1nK/vqbUO7HipF5ukWcUE9lI+H4qt2oIKfWidxaD4t9QNpLeC
	 iRF7+O+8Lfpp8SADbdEhtMPGJKNg/kDGjVgrd7HuevPhQIFEtXaRkLbUpYmvM2eeFa
	 nG0pUyeT3fPeb2NRrLR7vMXoSW99O7mv3aMip2HjPHtXX6VTLXAiqvfJ+JX8LR59cU
	 f4AvqsEqaYqniyZliUCpg4yfoIuN+aIFmAstG7Ow2Oy0W6BUHo5TDpu7U1ut6xwbW/
	 d+4DktBxCOlDQ==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] More NFSD fixes for 7.1-rc
Date: Tue, 26 May 2026 15:46:42 -0400
Message-ID: <20260526194642.108872-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21988-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 712BD5DC1B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 4f8ef58c10bfe5f86a643c7c8331b37e69e3dae1:

  NFSD: Fix infinite loop in layout state revocation (2026-05-10 12:41:08 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.1-2

for you to fetch changes up to 0b474240327cebeff08ad429e8ed3cfc6c8ee816:

  lockd: fix TEST handling when not all permissions are available. (2026-05-21 17:08:47 -0400)

----------------------------------------------------------------
nfsd-7.1 fixes:

Issues reported with v7.1-rc:
- Tighten bounds checking for sunrpc cache hash tables
- Don't report key material in the ftrace log

Issues that need expedient stable backports:
- Fix lockd's implementation of the NLM TEST procedure

----------------------------------------------------------------
Chuck Lever (2):
      sunrpc: prevent out-of-bounds read in __cache_seq_start()
      NFSD: Report whether fh_key was actually updated

NeilBrown (1):
      lockd: fix TEST handling when not all permissions are available.

 fs/lockd/lockd.h    |  2 +-
 fs/lockd/svc4proc.c |  9 +++++++--
 fs/lockd/svclock.c  |  4 +---
 fs/lockd/svcproc.c  | 15 ++++++++++++---
 fs/lockd/svcsubs.c  | 31 +++++++++++++++++++++----------
 fs/nfsd/nfsctl.c    | 18 ++++++++++++++----
 fs/nfsd/trace.h     | 16 +++++++---------
 net/sunrpc/cache.c  |  3 +++
 8 files changed, 66 insertions(+), 32 deletions(-)

