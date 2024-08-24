Return-Path: <linux-nfs+bounces-5676-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D48795DA5A
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 03:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5936F283C81
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 01:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1921B660;
	Sat, 24 Aug 2024 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h14X1owo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB9B65C
	for <linux-nfs@vger.kernel.org>; Sat, 24 Aug 2024 01:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724462680; cv=none; b=FR+8NvjM9HtAwjmhdUKkBL1WwWqbpwNfsA3/sfI+QAPXq7YxGsYiI5lmP5XnbDBET0MlHUfiS4AA28khfC0ffUn0GUjNMZSXutSzxUn0OJuf1bNm3vVPG8ji8f4fx/b9ux5y/Ymy2SSzrYT17VMDN+1TG9in7f82QOYFzPHQGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724462680; c=relaxed/simple;
	bh=ZJs3OnwtH2DzTfEioW6QFcSpLLDQ0NT3oIl4xB1YpwA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JLRFbzEfkLqxQLTgoyFm3TEInpIYlj0CrhyjU0xKkROnoQnhGK45yJPj1uDB7vZELo8nlChO7NUhuj/9/TxgHoc04QEoJX1jNJhfIa02ALSedC8EJ5VIYDlnE04oKojBA1wLmZLtgw1L+bKh+vR0WviaCY8lWovBgEPsEgw942s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h14X1owo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3829FC4AF11;
	Sat, 24 Aug 2024 01:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724462680;
	bh=ZJs3OnwtH2DzTfEioW6QFcSpLLDQ0NT3oIl4xB1YpwA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h14X1owo53OxPabqpI/M9FSJMq5A+57WZvBqce9KPL6sSNuLwpSPXr7bwV2TCjiSj
	 T87E1mP16eMhcuhWPdGILX3+b3exiDqfAanFFP+Y9tws0t+IBzYWKCocvT2eMpgj7D
	 0E5quTKnxoAT9CMI3BCEe5raunHC2fzvRht2Qwg39aby2NlYTXUNffuZnAH0boLgR8
	 L4Ldk4r28fUkKimRC9hq9Z32u4I4k1oQbJym3slPe0neovjyGePTM/kYokVN/Hq+sy
	 PmU/PJivUqj8U7g/LUB8RcAoMeZ02SVziLVNzK6fZDcyqTvvATq5TTszNZ/xqY2ksz
	 mMqzYmqMvzxbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B4B3804C87;
	Sat, 24 Aug 2024 01:24:41 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS Client bugfixes for 6.11-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240823175044.38868-1-anna@kernel.org>
References: <20240823175044.38868-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240823175044.38868-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.11-2
X-PR-Tracked-Commit-Id: f92214e4c312f6ea9d78650cc6291d200f17abb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60f0560f53e395adf4bce7282d8d4bc94a4952ac
Message-Id: <172446267980.3127411.10710971733586719264.pr-tracker-bot@kernel.org>
Date: Sat, 24 Aug 2024 01:24:39 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 13:50:44 -0400:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60f0560f53e395adf4bce7282d8d4bc94a4952ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

