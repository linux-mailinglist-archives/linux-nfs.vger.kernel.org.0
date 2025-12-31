Return-Path: <linux-nfs+bounces-17388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0DBCEB4D4
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 06:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA259300B8E5
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 05:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC22DF133;
	Wed, 31 Dec 2025 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA7ngBF7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B22D592E;
	Wed, 31 Dec 2025 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767159400; cv=none; b=ql1UVIkPAl6wR+05Sp6vonKqwrm5kI9mhqeeQNEVy98qQS/hBEqzAvBVa1T6qnWGbigUmJWot0uO/EKWBPt5KsKs3Bg5n2f6hqzJMAVWR9fTX2WSHgreW8MbsrhK/UzdvhvvoYURhlDdER29kSe6XN6nRj0EfPLOttGvhZH4z4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767159400; c=relaxed/simple;
	bh=HsVxM1NS7zd9uPKtjKbdM1GE+HUUyP6sG9fvfhtAbVQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=srotxuu6RbThlB4fjYdqlOxdbLH2tGD2YxovoOp7YfUXe0qRjJCr+jbS8tGrut2rc3doTGKJ7adD4Ly1eoq9Fj7P9L1WRH64g9MhF1fTv+uqdROjGB9Vanft4OpNu1XPvd+WU2UL0D118CN8ZHWWJB94Q5eVPSlpJQJJjwBHh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA7ngBF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2DBC113D0;
	Wed, 31 Dec 2025 05:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767159400;
	bh=HsVxM1NS7zd9uPKtjKbdM1GE+HUUyP6sG9fvfhtAbVQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KA7ngBF7VkRE73tMlfyJ7vraIzQKCxkgLuA1hd437FP9mxdbvNqiJ9K3x6eW6iJCH
	 dVZQt9dV+fuJ+7v1DvX5Eslfu74JbfKsR09moKIM/ZJjW+tRkW49VK2ouA9oSaKoh4
	 L0Ev9Uex92ZL3KDQI2dVx/zeS6nLd9llAcCfR64BZXFh77eKVWmq9mX3zplRzDI9+N
	 w0jJ4fs5kKdivj+SDZ3jgzYr64VuZv3gIju9jYDS5u36AxJ0TePE+n/8YjywLoK8Yq
	 E2nK7RWlqH6fagk3TxA+hKbPV7tzAjpz90ZRKV1Xzf1gLuQ3SZLnrn3uxg6PF9OHTE
	 RaH0WfkM3EKLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2DD53809A19;
	Wed, 31 Dec 2025 05:33:22 +0000 (UTC)
Subject: Re: [GIT PULL] More NFSD fixes for v6.19-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251231014018.2635778-1-cel@kernel.org>
References: <20251231014018.2635778-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251231014018.2635778-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19-2
X-PR-Tracked-Commit-Id: 1f941b2c23fd34c6f3b76d36f9d0a2528fa92b8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8ebd433459bcbf068682b09544e830acd7ed222
Message-Id: <176715920155.3435870.18275302464734273644.pr-tracker-bot@kernel.org>
Date: Wed, 31 Dec 2025 05:33:21 +0000
To: Chuck Lever <cel@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Dec 2025 20:40:18 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8ebd433459bcbf068682b09544e830acd7ed222

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

