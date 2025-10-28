Return-Path: <linux-nfs+bounces-15735-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCE1C1718A
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 22:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D77794E568C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 21:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044DD2D7DDA;
	Tue, 28 Oct 2025 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB+x+UOv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DBB2264CC;
	Tue, 28 Oct 2025 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688281; cv=none; b=TvDh8Db0gNcRWp5VZGMHZIupHevdDDpuuH1Am+UnwIlqyWdpKUoYwAJmYAoohvhhv8caOzmkWcur2lhBqJreeYzRuF/pqK4AGFZb9+U3DH0oM9Qxn2B/Kw17r2Ujx5Y2b9tVDsNapGB0RlDIRoD9FWL/boPf0k+rRGSd+dL74s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688281; c=relaxed/simple;
	bh=Tgo/Diqb6qAKHmT2jl6HTVJ3zxL91BoUvu6ARtS30n4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B3BxoXo+vkH3bTXTl+gcYIAAGXAgRcmK/eLse3ojzhoerQ+2pNTn1d/E9lHctY0LZwu+uZEkRqp1IDTrvnqoIB9ji1ED+AL1NwsrX/NgBN8nZDtBdVaawbTrWu1LC2LZDNf0fXyvQRVUqNGN1HRJnXlax7dqr1RmLjbLmOC2iFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB+x+UOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC84C4CEE7;
	Tue, 28 Oct 2025 21:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761688279;
	bh=Tgo/Diqb6qAKHmT2jl6HTVJ3zxL91BoUvu6ARtS30n4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gB+x+UOvor3i3nIOFWmA+9z3XrblhgBiDZXrn35NbvwC2z2NNMs9Kun5DzFOnviC0
	 He7JwcYKC1G/GLEqYx0/LQ3P6SDxqfGelhKltcBMxEFLKrGQWQeNrH9V0TvuraFZB2
	 2yVv4phLOx9+Tet9bj0cfeK4w97lx4wGVjJ+kK89J5c4J7XHXfqqPAO3djxiIBI1q1
	 YcLi3Yi2CtPr0wDHQ+CMS7POTcFZYEWGuqkv0MyHXJJsKwYao7uq/6JejdtUZAAdKX
	 oPLn50BTEM5dDrjjUPjl/4gU/deeimlSZBcJeSrt/Fwiwu7YO45XY8QF0hpb7VCiCP
	 VmLu4XwWlUfUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F2739EFBBB;
	Tue, 28 Oct 2025 21:50:58 +0000 (UTC)
Subject: Re: [GIT PULL] More NFSD fixes for v6.18-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251028190606.43007-1-cel@kernel.org>
References: <20251028190606.43007-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251028190606.43007-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.18-2
X-PR-Tracked-Commit-Id: 3e7f011c255582d7c914133785bbba1990441713
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8eefed8f65cc17c31fdf4ab32292b794b34893ad
Message-Id: <176168825690.2398724.14356407496886059884.pr-tracker-bot@kernel.org>
Date: Tue, 28 Oct 2025 21:50:56 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 28 Oct 2025 15:06:06 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8eefed8f65cc17c31fdf4ab32292b794b34893ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

