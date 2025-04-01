Return-Path: <linux-nfs+bounces-10968-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA75EA77279
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 04:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D1216B4D0
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D978013B2B8;
	Tue,  1 Apr 2025 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8XEU0E8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCB43AB7;
	Tue,  1 Apr 2025 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743472936; cv=none; b=VcWyd6E6X3JmrTMKrwg4tXhJBunxbE8Op+lJypweAMaFR8zrjkj3L9pLdb3UsPCCPuELwR8sXqnT0ZwtUpKmebPdwAi+mUSNZai+58oX8RelEfdU4Zv/x/lqrLH296Tq5DccfTVubpK2FYaWhpLcEyO6fl9zf4OM37HcDdW2C/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743472936; c=relaxed/simple;
	bh=NOM20zla7befi98IS00z4CV1xi2dbSalN6S8b2eHOnY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UYmmTcmO+yv1fIz3tmyXz+Uu7xRs+DP6YB+317Nes1zq+kcANGl2MNLNv5ueY2MMCLQg3cuqc8yEaHTcnT6IPBZSn0tsOPztjAUIDC80yTNzFQ4uCyHdXqV1YYb/Jb37g/BwFGGxh2GhYaq9XHG8AUxs6eHAB1WD8VhBoIeGMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8XEU0E8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892D7C4CEE3;
	Tue,  1 Apr 2025 02:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743472936;
	bh=NOM20zla7befi98IS00z4CV1xi2dbSalN6S8b2eHOnY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I8XEU0E8g0F9Oq/aEeG/Kgmuf2fZFH4CdzbfTwuNc/QMRFkDhOU47hlt5oCo5ImS4
	 hTW1DCo1YmT0rNZ6bZvWAG5ZGZDl6R8PZ/s38ZPTzkd/C+QOo0YDXqz6X+nVEHcELc
	 ggNVa4ERaP54UUA9km12KkA/8f2At8BVatRo8WesogwHIif4w6rnLjoXqv6gd1aQon
	 V6Zhxmh5Fn/4udc8bINGI7fPAK3aXPQ9NbO58KuhcLybshg6RLALaBvuitDTN+Rw8o
	 RKYxhnXs4rFAk1XBjg/AIgq6OTyfaQ8Kc4XkRWhYzHtTl3GXT0W84OAVbyHmJbIps+
	 hftros9udR29Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711A4380AA7A;
	Tue,  1 Apr 2025 02:02:54 +0000 (UTC)
Subject: Re: [GIT PULL] NFSD changes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250328133852.2344-1-cel@kernel.org>
References: <20250328133852.2344-1-cel@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250328133852.2344-1-cel@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.15
X-PR-Tracked-Commit-Id: 26a80762153ba0dc98258b5e6d2e9741178c5114
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6dde1e5275ed82e4c89844e95a03f95ca48be13
Message-Id: <174347297300.206397.7126503214765949511.pr-tracker-bot@kernel.org>
Date: Tue, 01 Apr 2025 02:02:53 +0000
To: cel@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Mar 2025 09:38:52 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6dde1e5275ed82e4c89844e95a03f95ca48be13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

