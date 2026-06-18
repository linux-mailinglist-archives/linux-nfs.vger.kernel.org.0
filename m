Return-Path: <linux-nfs+bounces-22678-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HHKuOWomNGrPPwYAu9opvQ
	(envelope-from <linux-nfs+bounces-22678-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 19:10:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B71B6A1D2F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 19:10:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MNlOqVYF;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22678-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22678-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAC0E3107ADB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15212348C78;
	Thu, 18 Jun 2026 17:04:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E134388E;
	Thu, 18 Jun 2026 17:04:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802292; cv=none; b=lmPFxNO0Rwzpt88nspiUZINXW5Dsm0X2uSum6H1Vg3bgMaFJxrhfKvWiSd/GqamnLX/8cGMuj4pRbPBF7oNktN2RqviEcKTLQ+s24NpAjqequtN4rM7n6wHv+GE2NjWIOi28PNimAs/VdDEuPnq89eGMKZaERmtV9v4ENVzhpcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802292; c=relaxed/simple;
	bh=Vmg0jwtA9UNfBTD/y23QZlSpZZW4weMDQC/AJTIh2PE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HaVKgUXag3LxBlx1hjyddDqNY2nJ9kK0ItVDNFw4NII3gnV6ZcLm7mkCUkvym2U3mWu4YVaBREOTeYgSwzPsnro73JFcj1UtG6jPt3xRlhm4lPmwVz7VFoJr8BClyGngEpLu3qR5NfU05LgFiTTGRRg7ZuoLD3KBXMLlkh82IQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNlOqVYF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8011F000E9;
	Thu, 18 Jun 2026 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781802291;
	bh=iKfB72a4p5lHyhGFksJP8Qg7ay8vjtK0QIHRHJlYGMI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MNlOqVYFF9MRp9JBJgPgWh7hoyCQq9UpwiTCOn2mIevuSxivJXl1wXmp7cLcV6FHW
	 r++txsDGKDx6trd2xoJK4+GbQyoHIeyAWyu+SZ21Z6OAd+nWxAy+t+sPldqLDevgP+
	 tq9rnkNMyfOi++6RkbYyhUD3YQWS+sIaw2vzOfZW4u1yr5rhuRVL1rB0YGF6ejtNeU
	 Abclmg63EhHQvLTBX/0DimVQbnBUBvHeTIl5YgKKWEemEt1aYYX+ua10V9jbXp8sFG
	 RVRjNiztO3lLVtJs7AI+Gono105itXEcfhZWiwVi0LE9Kf7Xf1NNcgSYEkeBmwU+BS
	 Ew7syo0AMTPWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AE53A566ED;
	Thu, 18 Jun 2026 17:04:46 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260617134243.1541292-1-cel@kernel.org>
References: <20260617134243.1541292-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260617134243.1541292-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.2
X-PR-Tracked-Commit-Id: e5248a7426030db1e126363f72afdb3b71339a5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3dc7c001169d112b3e514cacff6c93091c57af9a
Message-Id: <178180228495.2987783.2036918314171449343.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jun 2026 17:04:44 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:torvalds@linux-foundation.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22678-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B71B6A1D2F

The pull request you sent on Wed, 17 Jun 2026 09:42:39 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3dc7c001169d112b3e514cacff6c93091c57af9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

