Return-Path: <linux-nfs+bounces-20074-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKJGEqf7smmQRQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20074-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 18:45:11 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C3276BD6
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 18:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36F513030B8F
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AA43D332F;
	Thu, 12 Mar 2026 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfGyi+WG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F84390C94
	for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2026 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337421; cv=none; b=b/LoycNUUWqWK2BC2jj0KwlCvy+50MblHm9/kvvLfTkVur2zb2fH3vkNwzxG11jo9eCS39B4L+UHHVxOgqYtiMbFTWziHLtJoYqNv/FUWAqS9dVfCPnqdR+UV/OQxNatkNrGFLNn+wAvpxEq94v3C5NrNmoEnBbbVuhhd6A3/48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337421; c=relaxed/simple;
	bh=fFA11/0bpeC6r3NQkDeHDh677LcEJN8Jl6Uf1ByApP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIim67ZHEQ8oGNylQBotBejPm1u3qq2Ypxy/OH2hKYoH6ABFyF+0URRH/BseNtOVQ5UNPFF+k5Nw0JGwKTwLCoo9uGgDZcRgDjyYpX0byDjftLED+nsMQyjU/MKlXnu7oIirj7rhDppGTZBps9ymQ54laNpWzYgy1bvdD0xRyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfGyi+WG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFC8C4CEF7;
	Thu, 12 Mar 2026 17:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773337421;
	bh=fFA11/0bpeC6r3NQkDeHDh677LcEJN8Jl6Uf1ByApP8=;
	h=From:To:Cc:Subject:Date:From;
	b=hfGyi+WGjFHqmIB/FZMKXw7uoBNiVP/LsmpIXBH2TZDh3L8nZaYP9HzehAsk5qlUx
	 VrfViWcepeu5lvLXaD4o6PzCvtzZ1WX1XY2zdxyTmdkgpshXZ0x7nEpeGYO/Sy6wq1
	 igbJLhqBy2NHgmeFwhNT7TYPLpcJYkwgKByjX0qtjTw3AAsIwy97HTh/wf+Vky9z/8
	 0w9lyF/3wz7sEsb7gqin/nGs1RnnGXfUpLTgEqAIAK1sb6g6OsYo9GSlsr2xSQwJjg
	 V9JtVwscDpt5ng4vk2m1eRyCfyX2IzqcDT9sUQ2H/rnI1PpDDxa3Evm62tfo/ks/z9
	 ad/0W5APiUUdw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	torvalds@linux-foundation.org
Cc: anna@kernel.org
Subject: [GIT PULL] Please Pull NFS CLient Bugfixes for Linux 7.0-rc
Date: Thu, 12 Mar 2026 13:43:40 -0400
Message-ID: <20260312174340.310766-1-anna@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20074-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 438C3276BD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus,

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-7.0-2

for you to fetch changes up to 4529e0015432977af3ecc3b9f940fc2a1ef1b265:

  NFS: Fix NFS KConfig typos (2026-02-27 15:42:14 -0500)

----------------------------------------------------------------
NFS CLient Bugfixes for Linux 7.0-rc

Bugfixes:
 * Fix NFS KConfig typos
 * Decrement re_receiving on the early exit paths
 * return EISDIR on nfs3_proc_create if d_alias is a dir

Thanks,
Anna

----------------------------------------------------------------
Anna Schumaker (1):
      NFS: Fix NFS KConfig typos

Eric Badger (1):
      xprtrdma: Decrement re_receiving on the early exit paths

Roberto Bergantinos Corpas (1):
      nfs: return EISDIR on nfs3_proc_create if d_alias is a dir

 fs/nfs/Kconfig              | 3 ++-
 fs/nfs/nfs3proc.c           | 7 ++++++-
 net/sunrpc/xprtrdma/verbs.c | 7 ++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

