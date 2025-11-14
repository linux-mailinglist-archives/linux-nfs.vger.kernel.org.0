Return-Path: <linux-nfs+bounces-16416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F59DC5F6D4
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 22:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A73BE4E1911
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3136D302746;
	Fri, 14 Nov 2025 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO2qc8aG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F252FD660
	for <linux-nfs@vger.kernel.org>; Fri, 14 Nov 2025 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156810; cv=none; b=ptUj1o1DdwZ5S5+ObTnU7h69oLpHWDg/X9+eXtpmx0slq+2iduQtQYl/5vMFQE+bUvpOLNMolBNiVamT7kZob6iY8tB0ssF+rXllhH5fZo5aKDf+oTGRa0PkwK3N2EpEWr03+mWCsA+SfsPfdrPSoIBD8J5PYRQdCc7FZGoJnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156810; c=relaxed/simple;
	bh=hIhQcq3wloTYcdBUPaa+J+8zS6XawHjRgRJfLbj5Jhw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G2xrUroGOxqaQCTqH5YMu1Pt7ZGDKMSoNMQNT/4gxZKdXsPMAC+EzVQRsqHMoU4/HplQjwqRSnBvgdwayJySbr/kPtGjRbcb2+MRg7f7yfP/uv/4A42SHs8vQyJBSTlK+j+RMh6mWB2EZjaozUO6qzAa+uFyxqAWYCK36DsyrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO2qc8aG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843A4C116D0;
	Fri, 14 Nov 2025 21:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763156808;
	bh=hIhQcq3wloTYcdBUPaa+J+8zS6XawHjRgRJfLbj5Jhw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bO2qc8aGvKwe9mMJ3WkeBjMRKcc/+U65VzpvMVGlrkQGcbhnR3SCkaMYTymeaYjJM
	 RBc9yxpmBpZYe8dZ2Uvr7wqOCiZC6Ef27lCg6kFlwT0rF/gE1jF7VuZ1aL6cXfQSmj
	 0sdje2xYxM4xGQkO/1hQls7tkcW+IllC0bvzq7agESoKpseby22viSSuwrg1BPBY03
	 oduyBoRqDEQ+j2IZRtxbJu0RtmOV8EM3xbAj1obN1LT4ZDSwbeTAv3ylVJ3o6ue6/Q
	 r39jsb5b/AcOeXJF+bLAzjIulTHovKTJd2LdoxNJtRC400MqbxQX/XyDEuUaVktN+j
	 ToOM+pKozkXNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DCE3A78A5E;
	Fri, 14 Nov 2025 21:46:18 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull More NFS Client Bugfixes for Linux 6.18-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251114211657.521976-1-anna@kernel.org>
References: <20251114211657.521976-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251114211657.521976-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.18-3
X-PR-Tracked-Commit-Id: b623390045a81fc559decb9bfeb79319721d3dfb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1cc41c88ef00de0f3216c5f4b9cfab47de1c49d3
Message-Id: <176315677676.1847601.5626219772864475127.pr-tracker-bot@kernel.org>
Date: Fri, 14 Nov 2025 21:46:16 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Nov 2025 16:16:57 -0500:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1cc41c88ef00de0f3216c5f4b9cfab47de1c49d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

