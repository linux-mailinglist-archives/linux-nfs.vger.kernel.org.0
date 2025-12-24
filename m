Return-Path: <linux-nfs+bounces-17298-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F12ACDD032
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 19:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F345300DB80
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 18:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955822A4D8;
	Wed, 24 Dec 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQCgAPd4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215961B4224;
	Wed, 24 Dec 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766602707; cv=none; b=T7av8Gh5pYiMWs5Tza3e5vPw4HtaLlfHbd5RhzMXDUXrVGJuLZrOc6KIGxGce2Z0GPoYiVk8um6P10+2odlLNw69DugdaVgQySf4Flwuxp2iNG2cHsV7xqDoOj4E2OOQy9neOrsIMeRGNFRuWLoTrJ2JB7+3k0MEEptp9FfHmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766602707; c=relaxed/simple;
	bh=Z8tijVbskhj6HBCeLDUy6aqz7RiT5uyZHSBzFAfvMzw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RohadqBoNVLG16jx7PigAtHBSuTzfOfpkIHuCpgaa8eyNoOJKnrBuhfwf5HqafQFmRGet+1zbHa0B3xy6YW/iODlh5AkyIeA4+pGyQOkC4KUnDJYbx5tlDKDjMHqMmLOqAr0bD2emLTbykNOztWeDRREieK5tUBucw8Ud7HrTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQCgAPd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41B7C4CEF7;
	Wed, 24 Dec 2025 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766602706;
	bh=Z8tijVbskhj6HBCeLDUy6aqz7RiT5uyZHSBzFAfvMzw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TQCgAPd40oTIavaLsvZp2Kq1L6G5RSEqjX/3+lWCKn6VtW0Ud8JAgdP7DDKOMcxCQ
	 Bxod4WHtHVurCOLjfCaxVlxnfCFy+sdlMUDt8kuWBPISbiAZWfeZ3aMWMSHRec0kT5
	 0h2u8BxnZGdLsTPy53F/BQIJl0KK7m0RPP0Y/q9+F0hPtwM0Mpdxs+8I9eW6j47dHN
	 9ItCThmWPlZalGhle0OABXJ2FbjNvnXGtH+cF9nH/cn4fOppzAf6RpUh93MCi3L3Qb
	 VMH9aJz7Mhre6qnjvO7g3rnb9t07M+tu/7jiIBVxsZSUvtIKiU+n0nQZGf+yWfIjlN
	 wEpEv59kHa11g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78DD83AAA0CD;
	Wed, 24 Dec 2025 18:55:13 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD fixes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251223153654.1650936-1-cel@kernel.org>
References: <20251223153654.1650936-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251223153654.1650936-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19-1
X-PR-Tracked-Commit-Id: 913f7cf77bf14c13cfea70e89bcb6d0b22239562
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1
Message-Id: <176660251195.1574379.9552328309348711233.pr-tracker-bot@kernel.org>
Date: Wed, 24 Dec 2025 18:55:11 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Dec 2025 10:36:54 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

