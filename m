Return-Path: <linux-nfs+bounces-16978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD6BCAACD6
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Dec 2025 20:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A377F3094E05
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Dec 2025 19:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B48303C9E;
	Sat,  6 Dec 2025 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwK/RD5q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD6302171;
	Sat,  6 Dec 2025 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765048053; cv=none; b=ugSMLokgP3pcc1lK6P6IoS8WbSPy62Cep9BmePI7oJfZK5zCtJjD4//DDNrpJPxTFY7JrZkFdJZH+6Pj6DmiPtBjEhQSHiS9dpEF9m3a25/ua0q/MAv50E8ASzQGUhFuV6rOdAK/Xm1vg3ePxHNUnfRJYd1H5a8tVMV0d0pMhmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765048053; c=relaxed/simple;
	bh=rzKahAeISC0IS/G7nUCMBr9yKx2s21dezFUK+bIkKKE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KB1b564ybExuVubv44E4ZjlLIpB2HkFq61O0FeS6I5He1mPG9m6ATznaNQgqmWaFqM/j8RZ4Naw4I2Iy+Ta0UR9ZHF80PRx66BYEqaA6UwAj6MFeWpvgFG9EnpZOVjywPLTs2KXSh7P9b4fld7QhBykrVYDBWrPuAm2tq3nFlfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwK/RD5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C015AC116B1;
	Sat,  6 Dec 2025 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765048050;
	bh=rzKahAeISC0IS/G7nUCMBr9yKx2s21dezFUK+bIkKKE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IwK/RD5qW4cfwp951GF969JorlZ4SHD4ant20rPpspAwYH8kO5ARAijB2aGNIihbJ
	 S+sUXC5v9E1ACBUV1k+b7qsDSIQBdfuX/FKZ03Hp9pYpZMttT9K84mvuEo0PVa/5kx
	 wIX6W6orZp+3VUfldn3+UrlE5gfIN8BI3mLBcxws8VIccyRlhRVXLGbbQn6j190sRM
	 wv+FxywYyUxi82+ENktvGePfR86uji7iJ2zxhtlhIPFFk5hrsApg20s8mDQEUgIT0z
	 c+ZepEs/2l+Xiqp9rRcdqYXEplU2eyG3mMD6d8QgD+e37jn6kcOVrhLKJOHtHRhCc5
	 iRAOuyX4B9CWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2B623808200;
	Sat,  6 Dec 2025 19:04:28 +0000 (UTC)
Subject: Re: [GIT PULL]: NFSD changes for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251206153343.66592-1-cel@kernel.org>
References: <20251206153343.66592-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251206153343.66592-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19
X-PR-Tracked-Commit-Id: df8c841dd92a7f262ad4fa649aa493b181e02812
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0319c4642638bad4b36974055b1c0894b2c7aa9
Message-Id: <176504786764.2170003.7774585863148042681.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 19:04:27 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  6 Dec 2025 10:33:43 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0319c4642638bad4b36974055b1c0894b2c7aa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

