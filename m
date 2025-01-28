Return-Path: <linux-nfs+bounces-9728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CE4A2147D
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 23:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD71518860D2
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 22:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F211DFE12;
	Tue, 28 Jan 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6lO8MV6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF918FDD2
	for <linux-nfs@vger.kernel.org>; Tue, 28 Jan 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103879; cv=none; b=Qdu4BDn1bOrG/3SeKcRyq+DgrMHUcWQdnQzayrr8DCVJ75ZBdz2wUbI8hXUAf79851Kixitnn0Oi1upSCbWEOgmCflOtYi9cKPMm1CF2ZLfHqCSSIMbXaSUKSFPAjFBvf9xf2tTlNqQlZ3ElWYUU33Zu2FAH30cqaitATO7VDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103879; c=relaxed/simple;
	bh=Cahc6OhfHDgSTQV5xYWs4WtDli0UgqeuZ+Ffsu9Nj9w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WjJ9tZ2Ab4TsERXGdSt08tgG1z/UsMLzCSvrhnfbOy2mz5HxuQ3XfSrOw0YXtygwKR5N0bDqL60at3uVqTH2ONAafLUlmXpKCZayTC9tT8e6oLzDqLeUBATvqD0KI8efis3Bnh79mNUR1snKSdcX71ck6r8/BdkyA8U2fQ+eMeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6lO8MV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24746C4CED3;
	Tue, 28 Jan 2025 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738103879;
	bh=Cahc6OhfHDgSTQV5xYWs4WtDli0UgqeuZ+Ffsu9Nj9w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C6lO8MV6Dqta/MVZPBuMxBs8DgEVkYdGFC6Ot+kEfjrYOjFO+Cmw1GGKc6jbwO29s
	 5rWJLgEvanxOhOak4Gx7BJ6uIpGoxTT6h82Uwojlud7zqgRBAWaz0zQ6yncjOxPLie
	 FBkOqAyhpgHZE1wXBY3vtsVnj41f7/hWPkFak93iCE/rYXpu+yuRPJbq2zXFBAUeDH
	 zlD675gALPfEFgwg2vh2a6byMvVuTCyhJcZs5b4Lj+X/m8fOWVEv0A5SgIII7jUfJn
	 PUJsn4eLxLVSua3A67hyAhThDw+Ow/fUsANULSuAJ2vNfXAZ6TxX+1DZ/FWhxAhbf8
	 udhIjmAM8YNyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34CE1380AA66;
	Tue, 28 Jan 2025 22:38:26 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS Client Updates for Linux 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250128220429.377435-1-anna@kernel.org>
References: <20250128220429.377435-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250128220429.377435-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.14-1
X-PR-Tracked-Commit-Id: 6f56971841a178e99c502f4150fa28b9d699ed31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b88fe2b5dd018c2b856fd6c32b82f25033e908d4
Message-Id: <173810390475.3944426.14717347728766778857.pr-tracker-bot@kernel.org>
Date: Tue, 28 Jan 2025 22:38:24 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 28 Jan 2025 17:04:29 -0500:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b88fe2b5dd018c2b856fd6c32b82f25033e908d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

