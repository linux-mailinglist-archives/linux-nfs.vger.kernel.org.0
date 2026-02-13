Return-Path: <linux-nfs+bounces-18911-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG25INKGjmlfCwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18911-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 03:05:06 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D07BC1325A6
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 03:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F0D6305596D
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 02:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D929224D6;
	Fri, 13 Feb 2026 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8kLTh0m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E6EADC
	for <linux-nfs@vger.kernel.org>; Fri, 13 Feb 2026 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770948304; cv=none; b=LnInm83fcYV3HTz4PNIzoCaqUadlY6CqTgQy1Ln3PXki9i+Zp96ya0RzPE97meUU+YoS4ExbXEJK94scoTybBfpB4YZraHjs1psEqytgspEdt5rT5EqOzMAO7rZ892DwcTWFcdJ6+W88TDBjFwUdafM8oioDQVIZH2FcBbyj0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770948304; c=relaxed/simple;
	bh=mPiaYn7aSkAv3Xl4OLhELpWMtHqFQk9BszfTlq/rMNY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s0y/dnWYmfxNCMBshIYdSWJzVZW2S6dh9q5ynLeTNgmLNKS6Qb32bkvxAUXl54N68vWTHZ+wlQpEMTjHpkny0MPIAPD3jbVhUTl2hD+XqiYsfY1ZH0qPUd2zMfXM1rxnwsXy3LonXmQwSo9RwpOUe9Mb7bYg7xlxVBEiUDySTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8kLTh0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4178C4CEF7;
	Fri, 13 Feb 2026 02:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770948303;
	bh=mPiaYn7aSkAv3Xl4OLhELpWMtHqFQk9BszfTlq/rMNY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V8kLTh0mmoYv48l90hMeY3PnNaMOc3pcEkgHB0g70x2GRnrrmRerxAE2xH9fEm5QX
	 ps0eTXDUkUe6SWox3cdDsUwkp/kIsmXLw6uxRPqjsUSGTp6T10QOiZYTBbXfJpl9A+
	 VHQ5QxFlISOjNmtj7lxQr7sKXmMh+hSsS/wvGQtFaMLIaljED+7Ywc6rGndcLtoBQw
	 tGklKZf+u+bq2MAGWIEsLaZHWOC6qlairEprZWNciYy095Ye/SrQJtjMKx3MZ2d08r
	 QZQXn2ra3h2P4WUZBlyOaT/VDlQw537im64oQfv8mhD46v32O6XD7BD/G9KYk9YXHp
	 oUi6Ec/5e3ehw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4833D393108D;
	Fri, 13 Feb 2026 02:04:59 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260212220625.358550-1-anna@kernel.org>
References: <20260212220625.358550-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260212220625.358550-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-7.0-1
X-PR-Tracked-Commit-Id: dd2fdc3504592d85e549c523b054898a036a6afe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7449f86bafcdb588422bb14a4babfd285e723670
Message-Id: <177094829786.1808670.7564289153140983436.pr-tracker-bot@kernel.org>
Date: Fri, 13 Feb 2026 02:04:57 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18911-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D07BC1325A6
X-Rspamd-Action: no action

The pull request you sent on Thu, 12 Feb 2026 17:06:25 -0500:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-7.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7449f86bafcdb588422bb14a4babfd285e723670

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

