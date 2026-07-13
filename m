Return-Path: <linux-nfs+bounces-23307-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dt/dH3cZVWrEjwAAu9opvQ
	(envelope-from <linux-nfs+bounces-23307-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 18:59:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8F974DCEF
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 18:59:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OoxtLEd5;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23307-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23307-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 982A43082CEC
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 16:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAD633BBBD;
	Mon, 13 Jul 2026 16:58:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A643E9F9;
	Mon, 13 Jul 2026 16:58:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961917; cv=none; b=e+dOBPG0c1spCcHsI6FWEd3VqtbhOtO5UjkDVcoe7pethuxyu2lBSQzCbhRIIT4ACR88nwr7N8RCxyq681Skw5P/FmYsXa15kP+Z6f9tin3WFm0wXoNMaErufeJZRcO+O7gBGjNiBP3OlHRiiyQ0qwRMXSbbtFL1sWpFLPibvcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961917; c=relaxed/simple;
	bh=NBiCUabamImYJ8YFLdzFqgmzKdYSzeFsvdEwcWEmTXA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ERjLFq73dLrxdLo/BSauMy+82w8JdOsxalBrASG+klKLYWPIHRR0N62T3Y4RITnhdIKyFdf91Cg70oOC608cd00z1oj9Fw6J/h/mc3UXFdMEGFNac0v/z1G8+jcOsolRuu/dIA6MHJ9POLQlZs/Fk9Z3AB3XHd2Xfzf8Z3tR0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoxtLEd5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9F11F000E9;
	Mon, 13 Jul 2026 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783961916;
	bh=8PbYY7P5Mcys1i2Rwm0Tvgd1W5HcjEyI8YN/4YSoYhs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OoxtLEd50t0yvioRJywbYiNCIn0xgb5ZGjlNKuOkm97XGstvHoKjAmZ2lwYCOb/ab
	 6DwQyhQu7/Nd7VyzrNFG+NRF6Fu5K+M0jcp4hnb293RIXvcM7D+McK+69PvfC0eV3f
	 sRdTyE0FR84VVxkNpqS1/xhsA5Qncs5qC6V+XITq/omMuV5qKgYPGnjg3a/W6558ue
	 004B4Tdy3NEuKaJjjxYYOwsXjcGm1vfhqAia0HoxlF7gvMHoa4NKQaY+Kap2b5LDIp
	 0VzELVMvwNfsNesojE2Cj3as/fLP+sB5OrGdbWcyPyevgh5tELgcT06qruMEPHVutV
	 T69Mjo+tzRzQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A1F3924F84;
	Mon, 13 Jul 2026 16:58:12 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD fix for v7.2-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260713135701.2280016-1-cel@kernel.org>
References: <20260713135701.2280016-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260713135701.2280016-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.2-1
X-PR-Tracked-Commit-Id: 92ea163c773cb4d0d5eaf103ed80c49d6758b96f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f26556c5eeea62cc934fa8938b148aa5844a6b6
Message-Id: <178396189125.2325401.9814670735132451467.pr-tracker-bot@kernel.org>
Date: Mon, 13 Jul 2026 16:58:11 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:torvalds@linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23307-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD8F974DCEF

The pull request you sent on Mon, 13 Jul 2026 09:57:01 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f26556c5eeea62cc934fa8938b148aa5844a6b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

