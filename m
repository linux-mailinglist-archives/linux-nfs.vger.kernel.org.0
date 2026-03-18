Return-Path: <linux-nfs+bounces-20264-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLdPEbEau2k+fAIAu9opvQ
	(envelope-from <linux-nfs+bounces-20264-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 22:35:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D054F2C3137
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 22:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FB843020514
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 21:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C6389106;
	Wed, 18 Mar 2026 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiML5euJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD2388E64;
	Wed, 18 Mar 2026 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869743; cv=none; b=Mrd8nU5hM2hsFoPClsp/65hJZYwpHyJGv+bt2BlZKiTZoL+oavgZn8/64ChZafjumXHohjJcEp5vjA3pK2Zr2aIPB3HChI2MsdVdh+j//OpKOyuAIEJALWU27wYFOQ8gePvCJmL56vsa8PNFAYkbSptK1yE8c6E+y8Xvzbj98Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869743; c=relaxed/simple;
	bh=ymT+mz/zm7O30sZEv0ysvh5dJ9qFqGo+QvLT+pP939c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tnE+kRxMt2JpZmQerMYTXB74/2z6JTO2bPoeVn5ZBAXZR6gE9hidYxdDiqrgBR4IWiMyZ11ovqWmjia+NP9oxhtP98kLrHKo2aJ+N2otaOFMUIG2/XS/GTBlH+FDkA8p50HwW6U9VR9pR/GoAwQViBDZ9u3LcZ78Rh5Atgnw/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiML5euJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8784FC19421;
	Wed, 18 Mar 2026 21:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773869742;
	bh=ymT+mz/zm7O30sZEv0ysvh5dJ9qFqGo+QvLT+pP939c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BiML5euJYCKI023Bmku71WjWse0Wug0zY3+CMUeb5Mjsg+4iKjoEyEFQgEFFB8wKG
	 nbfN4nNVghj2u9m6n/btepOgp+/mYurtRhLKOydS9NmO2oskdAEvRlyXsAwp4nHCOL
	 +Emu8EN6aFjMtybzLHBzqD9mYrQ9/tXbmEHkv20awjXBRJhHls2mwXvG1GE5QVMeTk
	 E5z1bByveMuWb/xpcG5tijd8088Kr3XjXJBrr0m6CEeSy8o2P8chqqqWNdZQXGLZGb
	 4+bJR2Zz6oly2Yh9zMjF/iBTuMCb6lf8xPi2jiWfL/I6jQICdNO94TRFZ8cHwcOl/q
	 nsrt0x8GBV5xA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400FA3808200;
	Wed, 18 Mar 2026 21:35:35 +0000 (UTC)
Subject: Re: [GIT PULL] Second round of NFSD fixes for v7.0-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260318211447.1808-1-cel@kernel.org>
References: <20260318211447.1808-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260318211447.1808-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.0-2
X-PR-Tracked-Commit-Id: 5133b61aaf437e5f25b1b396b14242a6bb0508e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a30aeb0d1b4e4aaf7f7bae72f20f2ae75385ccb
Message-Id: <177386973392.896903.4987434450063856806.pr-tracker-bot@kernel.org>
Date: Wed, 18 Mar 2026 21:35:33 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20264-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D054F2C3137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Wed, 18 Mar 2026 17:14:47 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-7.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a30aeb0d1b4e4aaf7f7bae72f20f2ae75385ccb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

