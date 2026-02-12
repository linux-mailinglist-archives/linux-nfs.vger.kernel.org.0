Return-Path: <linux-nfs+bounces-18907-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMCQB4gmjmlrAAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18907-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Feb 2026 20:14:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D99A13099D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Feb 2026 20:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4AC4306EF05
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Feb 2026 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F08725C818;
	Thu, 12 Feb 2026 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQU+SlZ3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F622D4DC;
	Thu, 12 Feb 2026 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923615; cv=none; b=lDLScjmJd4vF4WG+wYuptFcWqGblRkiTRACbtJxZoH7NBA4T1fFd8Cx5CBtOdF7A7XJaYshiHEwKC1y49E8G7CUv/nTvRxFqDRvesIaHemIVN9JVOjn2yGxE56Jlhj0r3U8M5EZitsNzLxwVoQ+f/PdRGgQSBkj2utrYezdZV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923615; c=relaxed/simple;
	bh=295x1utl6yjgwHahS4ry6bZmyBW9NYJTxlW+newD1/8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rjcN+XnYwztzLxpRU33l3JXZMUZXgBT7u6fWFEQpmmwyse/E+/uNxt2S3ozzLKqBmKeTnllcFu+w/3CTEPti8R8kPHO4pM+nwnBHufr4iub6GoEWEb/asvULH/ITL2CV64tXWI0xioxwod8a3iIckxUDJlAgCupN1eQEb7MAx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQU+SlZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDA8C4CEF7;
	Thu, 12 Feb 2026 19:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770923615;
	bh=295x1utl6yjgwHahS4ry6bZmyBW9NYJTxlW+newD1/8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CQU+SlZ3wMi7FE0lzMUk50deY6Q6NajVup5lbj3UJOkmyA3vxmbcyNgQdb6x5vgHG
	 XAavhFSwIEOyjkGvDyl9Esq70kdaKtdghYB0RkJfcHByk8o+74Kby8VdpLmoLWAWPT
	 vxGFEah86gE5HcwfKMsGMgPqDn3I83Hv5TpXV+oB0NMuG8BiR3+zDoJpF9pMq9vsy6
	 gW09i319A3tjW75g2bulzo+KIwAxbgd6YqjoHbufduoN6nTHKNtqIKS82VLdq1n2fm
	 vbPU4orsGs2AgVOyxb5V/zAPL3XwTbQnLx3s6ppu4j7BmIsfk3tFSmMHcSyS1fYtNr
	 X7dZ6G5y63IsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 853023800346;
	Thu, 12 Feb 2026 19:13:30 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for the v7.0 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260210161307.2356144-1-cel@kernel.org>
References: <20260210161307.2356144-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260210161307.2356144-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.0
X-PR-Tracked-Commit-Id: e939bd675634fd52d559b90e2cf58333e16afea8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2831fa8b8bcf1083f9526aa0c41fafb0796cf874
Message-Id: <177092360909.1663336.8547348418777703301.pr-tracker-bot@kernel.org>
Date: Thu, 12 Feb 2026 19:13:29 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18907-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D99A13099D
X-Rspamd-Action: no action

The pull request you sent on Tue, 10 Feb 2026 11:13:07 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2831fa8b8bcf1083f9526aa0c41fafb0796cf874

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

