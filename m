Return-Path: <linux-nfs+bounces-15363-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B63BBED52C
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 19:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACED5E2309
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 17:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E7D23D7DC;
	Sat, 18 Oct 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn7KWUDl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA321CA0D
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808401; cv=none; b=pu2URkI18u2tzSnNO+C/IYDb/tbvjHyyupvD8jcloGwUl+DDy2JXPkOlpD8zYIE3h7bqYzFC4p+S1B+xn53JJh/TBGVyhMK74XIayMBr1XUXGWt64CCnFb6pqklHY/RzJ3HpGlHT7nmf26ZTbA67QTLyqNhJHzkpS4NQHT3KVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808401; c=relaxed/simple;
	bh=jzflYiZK7OpLXc9ubgefEEr5xAOFOBQqyUDLAaEeHvs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XrI4+/0Qhp3Kwlp6MT3mYq24TgmU5YAejQVp1ZTxHWMuZ4FSZE3um+HVboPQc7ehHRe7DdxRr/3tA4Rk55SxarY10tq64d8wVVbzrSEOs07w/hP1LUAkHCDpQD4CTgWvl9R6ySiadHi0rgX5ycrlmrUG0+7DXpJNUhq2VxQCzIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn7KWUDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2313C4CEF8;
	Sat, 18 Oct 2025 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760808401;
	bh=jzflYiZK7OpLXc9ubgefEEr5xAOFOBQqyUDLAaEeHvs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pn7KWUDlYP/L6gSyZliAHGphKCAl9i0jahjpRbuGK5zp6DhNwoczU7Qf51TLYScEp
	 +gMXFjjclvqYqjsJ6Hf+TaxSqOadl+gypJGS3KFcf0A2sATAuZjRGeYJTwBMS56BRK
	 Ka7AXxsLQwNS5cj0Xf9UNWooJHJgAGFViwEIXTl1yacp2I/hba2rfNFu09cJBqLT/K
	 cVVuDwW93j5WgXB0sJgazLkc5cwL0KMn8APnGOdl9j8+9mTKUTvfZ/nBxka1kFSVsT
	 AeFR5xM6fT2ZQkUnN552xfgLnijFbL115rv5LhC5OKSS2HHbAJIf9Ef3ZW8we36iAt
	 fejkeI80HZ62Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2C439EFBB7;
	Sat, 18 Oct 2025 17:26:25 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS Client Bugfixes for Linux 6.18-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251017204426.355167-1-anna@kernel.org>
References: <20251017204426.355167-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251017204426.355167-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.18-2
X-PR-Tracked-Commit-Id: 9bb3baa9d1604cd20f49ae7dac9306b4037a0e7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d07c6c2098805054f84ce642587093bb8feaf8c
Message-Id: <176080838453.3050468.9709588538802616330.pr-tracker-bot@kernel.org>
Date: Sat, 18 Oct 2025 17:26:24 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 16:44:26 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d07c6c2098805054f84ce642587093bb8feaf8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

