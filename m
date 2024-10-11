Return-Path: <linux-nfs+bounces-7111-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDEC99AF52
	for <lists+linux-nfs@lfdr.de>; Sat, 12 Oct 2024 01:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ED01C26C72
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 23:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C5F1D130E;
	Fri, 11 Oct 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGZirJTt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820351CFED4
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689088; cv=none; b=j40QEbjw6CHa7rwx5b65lvGWRQ3ewGnk/mB6EhsyYMZqdP1seU5Ve+19ImTcaXV4OlxU/+suBd5OVF/7IdGFzLmHLGZGYZgN9C2HcPiPrfIK3BE7B209oT2Q3KbuB8FnTxHQIz0eqgYgN93NjE2sXzxMXQ+MFBvU8lpkZHiU5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689088; c=relaxed/simple;
	bh=Gtpo/qd0846s4AqkxPLQZstkf0aO23Cv953vkkZqmzo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s+0RxWOrutMSBD1BdNQc94Ehg+gIDRvK0r55XPEPuuDRz32r+t3cqG2LjfEVIr9Ed4Hlfzp0U2kBJ23H9l90RrLuOD/d1mntoutX1ffUGMDovAQNMvEoY2f71OWDHbFslY4YuIXrONsdFZdyY08NpyJHDPq93F7uGcMRF94UHec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGZirJTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62673C4CEC3;
	Fri, 11 Oct 2024 23:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728689088;
	bh=Gtpo/qd0846s4AqkxPLQZstkf0aO23Cv953vkkZqmzo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tGZirJTtr5qlwB3HRG7s1/LB9heaxg3u+HCKIo4JjGqhxpu1JRioYXcRcTMcs+DTL
	 7OloZY90LI3+zO/5XMerJ865BoegayZQAjCU+JWt847ZAT15bwfqzUwM4jGg0NTKyU
	 TH7+9jaMhhjeXMM17MWs+1m60LkYLN0IAAjQW5YKvWUKbwgz1TY0PtSVteUhtFixXx
	 7GK7Cj0S1f4eMk67xLVf93Q32mvG05yGbxJATmLlu/wWqygnB1qK+vufyUp5Y968QO
	 HO8BwVg/TrD2sS6trflcv2Di0DoScK1Nwt6CsBkiukW0dwiWWXVz/KLI8DbQcJzApJ
	 JO67TQ+fmINtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3429E38363CB;
	Fri, 11 Oct 2024 23:24:54 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS Client Bugfixes for Linux 6.12-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241011204628.270296-1-anna@kernel.org>
References: <20241011204628.270296-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241011204628.270296-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.12-2
X-PR-Tracked-Commit-Id: 7ef60108069b7e3cc66432304e1dd197d5c0a9b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6254d537277947fc086324954ddfba1188ba8212
Message-Id: <172868909280.3026331.5580275288390876415.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 23:24:52 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 16:46:28 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6254d537277947fc086324954ddfba1188ba8212

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

