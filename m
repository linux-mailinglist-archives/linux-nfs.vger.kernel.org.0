Return-Path: <linux-nfs+bounces-23303-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KYCWORvvVGoBhgAAu9opvQ
	(envelope-from <linux-nfs+bounces-23303-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 15:58:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 842CF74BFDB
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 15:58:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MEh7qSVs;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23303-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23303-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4343301B03F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4587438013;
	Mon, 13 Jul 2026 13:57:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21D43746E;
	Mon, 13 Jul 2026 13:57:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951023; cv=none; b=ZGGItCQ1Bjer3LaAKLI50aOGnS6l8AnzaFFzJm36n71xJeOC4jrzpjEyWnydvpJYAfjtNBngXCu/wOya9enPWYiSO6OIQhpmWy5o0efjnS9PPGdW3ifeqOjO3KCmCW6xTWB/MZhij476Ow6Ts0lKJAS5HXNI+OV23wv+4PXZH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951023; c=relaxed/simple;
	bh=Cc3XAS9IoU84OnzXhWYptm8R93DLa78UdvUwGVhgxes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbWt7/KsUQZLEFV85Vw2WPFFknp0ko5gdSWMCHZ2qz/yweUM6HaO5AXi6ru47gm4DPtVG7G/fZrgQ2YPVlceqY9VVhpWvmpwW7KPTfxndgyL8J8jFXsTknLxw60ySNjP5G+NNyqZUkvjQBiUHNHP6kafpMrGjJ/O6bkMCFfJwXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEh7qSVs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DF31F00A3D;
	Mon, 13 Jul 2026 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951022;
	bh=7heVHIUSg75wKIQQcMgteb9WWY9p3eK+uwtmy3SjeZ4=;
	h=From:To:Cc:Subject:Date;
	b=MEh7qSVsdCdes4SYl6KHnLwyfjI/A6OH9huzjHIOYy+YyeYHOTZXHGMO6tFBkyPUs
	 +l7s5xlg01eJH18sj3abZs9QpAyQ0OaTcYJaeiCQ6q6oxQG2AVvukABCjcNFPfxBnJ
	 W6N3SpPSMQ2SALtISN9T3CFra2Mc/qkEveavtJuG4etUPxz6/ssL4hFjRzQ+CACl9k
	 3aFH/dcUG1O7Df5wOvzguKfGrRIannsmNn4zJOUbq3xE6aOc8kOcmyY2Cd6EVrxFLe
	 38eZKyqYQYbCxzMuUIdTaYW0Z3j+1e78i7dlylU1/KqL3jtnrYpM7y/jFjI+TDTpIl
	 hi7L2sYJtpPJA==
From: Chuck Lever <cel@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] NFSD fix for v7.2-rc
Date: Mon, 13 Jul 2026 09:57:01 -0400
Message-ID: <20260713135701.2280016-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23303-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 842CF74BFDB

The following changes since commit e5248a7426030db1e126363f72afdb3b71339a5c:

  svcrdma: wake sq waiters when the transport closes (2026-06-09 16:32:59 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.2-1

for you to fetch changes up to 92ea163c773cb4d0d5eaf103ed80c49d6758b96f:

  NFSD: Prevent post-shutdown use-after-free in NFSD_CMD_UNLOCK_FILESYSTEM (2026-07-05 21:09:42 -0400)

----------------------------------------------------------------
nfsd-7.2 fixes:

Issues reported with v7.2-rc:
- Fix a UAF when unlocking a filesystem

----------------------------------------------------------------
Chuck Lever (1):
      NFSD: Prevent post-shutdown use-after-free in NFSD_CMD_UNLOCK_FILESYSTEM

 fs/nfsd/nfsctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

