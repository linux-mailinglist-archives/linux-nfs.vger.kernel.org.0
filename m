Return-Path: <linux-nfs+bounces-16335-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45076C5575F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 03:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE1F54E147F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 02:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF8C23EA96;
	Thu, 13 Nov 2025 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSu8Yw35"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EED1D5ADE;
	Thu, 13 Nov 2025 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001918; cv=none; b=DFRmWCpCfVPlDSfwYoNUUatzdbgTvm3w7zExSCMBYNOheWfhFIU94eesyixncTXclT36q0t1JoHde8DtoiUiLnDbIj0JJ4Z3GmT6LDUOrtrTTHW7WD/R0y4+u0QfG3/Vx7BD2AhUEkRHms1BjD+zxrCL5Kt5inMbTvCE449KbYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001918; c=relaxed/simple;
	bh=dZscqE4NTDduPbW3tWrDD2SlETomTn8MIeELE2ZJaZ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tPbRvAMebmc6U+nU+NT0Jue8kAVMLwq5JJKAaTX9c8FK/b9kZhaK5JsvrmbAalVPhd5PiR9NzhNRJeDJYbTWfURNciJo4Z1j/Gjzag+bMBqD2e1LoMjm23qj9G03L2l7vhPZZp2EA605an4densICysNfrLhIhuHjUp9sECfdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSu8Yw35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3544C116B1;
	Thu, 13 Nov 2025 02:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763001917;
	bh=dZscqE4NTDduPbW3tWrDD2SlETomTn8MIeELE2ZJaZ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RSu8Yw355oQfszyGjBF5ZRPYwnBk96OcvHs90smBF/IqIQFI1Nn2REzEuSLo4kH9h
	 gjyZnfgOEa/xBH3smAjHxmnE18ZrmzAaShp3J/SKucwX7gu4yBu98WEzFFYb48Z3S0
	 HEYR+dBzBdQk4y3aLkNMp0FxP1rKSpPFH+Azi/qU27QWwseFFwYSliJ97NqSWDGhky
	 oWmC/xKpDH8zrOTQ29YGDUDxZ+PDy1df8O+rB7LIhSA+NeOhGr0Fi87jue8bO7C8bl
	 mRHEgorLNQeXoUmz10yl2Lgoc3Lg/cWKDPW1mrZDDa8vheMcav6Jqjhbvztv6Mhh2b
	 3P8uVaihLsKng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711623A40FD1;
	Thu, 13 Nov 2025 02:44:48 +0000 (UTC)
Subject: Re: [GIT PULL] Third round of NFSD fixes for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251112175354.13059-1-cel@kernel.org>
References: <20251112175354.13059-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251112175354.13059-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.18-3
X-PR-Tracked-Commit-Id: 324be6dcbf09133a322db16977a84fbb45c16129
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fa9041b7177f6771817b95e83f6df17b147c8c6
Message-Id: <176300188713.293034.268925913498722094.pr-tracker-bot@kernel.org>
Date: Thu, 13 Nov 2025 02:44:47 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 12 Nov 2025 12:53:54 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fa9041b7177f6771817b95e83f6df17b147c8c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

