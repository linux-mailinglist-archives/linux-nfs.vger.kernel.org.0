Return-Path: <linux-nfs+bounces-2355-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D094687DB42
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Mar 2024 19:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4A11C211CD
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Mar 2024 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E5F610C;
	Sat, 16 Mar 2024 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meNYMILc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21634C9A;
	Sat, 16 Mar 2024 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710615057; cv=none; b=nkHmJ7Z6oQU9ab8/nj22ondcqGe6/Jeq+NaxY+RqqNBZqXmXhVtQfX9P864BWNC1Q7QxWGSGoM4BewhGo8y9Z1Z9HcAUMTFZYNmoIM9gSXG52kpjhtcm6e1YMlm93D4DzWn89NsGL2cCGqnl0FGkfSJzBHAq40YWZUr8KEJG1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710615057; c=relaxed/simple;
	bh=83py2/xNNq7D0IX8F4E2R1O+OXAt5TZio6y2c1uomO4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EFn4rYA5ZRUGA88WrvVmSKIzDO1SC/vYt/R5Aw8T+mJ6/oQisT4BGe7RoOhgckC2k1Dt57v8FrkRGMWXuvbLx30ewbq3KKI/yfrl+rjyBRHRL16nUtRBQ+M3PNGux3M25qIZjJfiDfIKI2XJ0grPMm0k9DQKFY7a6RRpRujRgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meNYMILc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5D74C433C7;
	Sat, 16 Mar 2024 18:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710615057;
	bh=83py2/xNNq7D0IX8F4E2R1O+OXAt5TZio6y2c1uomO4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=meNYMILcnk6xRBMP6D0YUIDv3KgBx/W/nrdkgfnl1iRHfh4TCouSdruyAXQYSz5dP
	 My7sn0lOIvf1WE5cZhkhnVgd3MZwPCUZkl7Y6s7udosrLaDCqiVULc++m2oJQ+ddJy
	 +W6OVoSXHoeAb5GjKWCQxLUkbfwtspKjB0+RW043vtGBItBIc8kszQbUfpwEulxwql
	 SKfhqbEN3v6fSwtcIIVPT1kaIyKctLgOYxQpoGCGAOx0WPrZYSzcaUqvkEnTWHW2gI
	 3OdfFdaUyxdIEr1rN5nOczJa8OycDpN93BKW+s1V+c0Sap5PPi6CUfkAByHYBb3oIn
	 08P0+kf25sQUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC466D95053;
	Sat, 16 Mar 2024 18:50:57 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client updates for Linux 6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <4623cb545316bfdb45b8d294861ad7eb508ec1b8.camel@hammerspace.com>
References: <4623cb545316bfdb45b8d294861ad7eb508ec1b8.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <4623cb545316bfdb45b8d294861ad7eb508ec1b8.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.9-1
X-PR-Tracked-Commit-Id: 719fcafe07c12646691bd62d7f8d94d657fa0766
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1f10ac840caced7a9f717d4170dcc14b3fac076
Message-Id: <171061505769.24411.4773695359951231947.pr-tracker-bot@kernel.org>
Date: Sat, 16 Mar 2024 18:50:57 +0000
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Mar 2024 18:17:31 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1f10ac840caced7a9f717d4170dcc14b3fac076

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

