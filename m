Return-Path: <linux-nfs+bounces-22306-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sfcRGZEJI2qlgwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22306-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:38:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C02D864A3B8
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:38:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Bx+ExevD;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22306-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22306-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6EDC303B173
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672A70836;
	Fri,  5 Jun 2026 17:32:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B871A3154;
	Fri,  5 Jun 2026 17:32:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680768; cv=none; b=YCrl4oUtPSu2AeBNp25EZQavgSY2eqzygeDCxgwuoRSvUGim+Y1xvo+tfKNOnLegTMr+z+irF8eMsEBRKPDV92LeIJFM49OFbZNYgShOdtPWnU0HQ/ufgFLBlXVHshl8EsBswmIz2ialy1ijf2uing6lZKVxx0I8AcnTO86ryMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680768; c=relaxed/simple;
	bh=/+/NNqEjun5z1Oyxwa8VYtTh3xkyVzE239uQnw+ubSw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OyUFNIF0C+OCkpCmkmKQ3EOXxybFDa6N0VDF5/x39yXq++c+fczo3D2+LUPTR4YhTR8mAMmVd14s3GX+Ni4peCDtOAm7HfbEAgFMU62zyI/7Srd0yfZT1wkoie63yhdrlFoR4eO2+/yfuWrsHkKtpLUPim9ytbhzLLuUpAoJSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx+ExevD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4981F00893;
	Fri,  5 Jun 2026 17:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680767;
	bh=yoFGQAsFx+OFw6LdMfRS6WkTMETWKH4H6QL0Nc46E5A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Bx+ExevD2y2hLbMK6z6Zzu5qHC3cJMJ2DR8gwdDIPkPifC2mWPgAQkgRRzRc3iuss
	 v1o0/JROjsjxFaAw8ShjYNeDBOc2o4sz6RLwNFY4D0pIQy8yRu+xxGw6uNPrlGyXB7
	 BKXYhlB8AR1p1C+ESDgA/Rh60wAbFs/MOubo0XYz+/pKB1B9/vZPg+QF5t3E/6A8qP
	 Bmc7VdEDMDClRZo6W5mOCBNps6YLWy9qrz1HIYYf93NY4GVc0Jv0azJ5t68BlVeb4J
	 jirjwKEcAcoHJdU1pLObh7Bea8xaoZxroLrBg4hTnoRotrb0i2TsRrnu4XYJVxE3Aa
	 vzJxcWDhvH/qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CA33930BAF;
	Fri,  5 Jun 2026 17:32:48 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull a NFS client bugfix for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <17a6eb87940db2a6306e087998b82a6da35d755c.camel@kernel.org>
References: <17a6eb87940db2a6306e087998b82a6da35d755c.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <17a6eb87940db2a6306e087998b82a6da35d755c.camel@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-7.1-2
X-PR-Tracked-Commit-Id: 317d5146fb399ad1e87b310ee7d018fe648d40ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8dc5f60d127f1d147a8e778563fcef7715d1316
Message-Id: <178068076747.3853150.12801531036179895212.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jun 2026 17:32:47 +0000
To: Trond Myklebust <trondmy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,tor.lore.kernel.org:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22306-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:torvalds@linux-foundation.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C02D864A3B8

The pull request you sent on Fri, 05 Jun 2026 12:14:01 -0400:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-7.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8dc5f60d127f1d147a8e778563fcef7715d1316

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

