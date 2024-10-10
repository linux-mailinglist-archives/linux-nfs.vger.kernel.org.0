Return-Path: <linux-nfs+bounces-7032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F1E998E53
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 19:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807BB1F259E2
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC1E19D07B;
	Thu, 10 Oct 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHSB8HPj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4C19CCEC;
	Thu, 10 Oct 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581439; cv=none; b=l1P2sILH5/mMTrVxLJJa7BSPN+53IL90oLFgFlsFd8ZwGJ85OHNkiDNtFizGgOmmzuptEwe6NtR3A6ReAvSamC+QZOzuHqM0CjcbH5XnilboTDjgzz9a/DOeF8IRYQgWg6XjtRNbRILAktAb0eQ+7NweaH0R3EI0HFSnmGe141A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581439; c=relaxed/simple;
	bh=kXhptPcxcC7ywLLATkBWn77WBhRpBXuYaI6GoxtDd+Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KQmtu8sDOx06Pc3f+DB/RKxQ+wcP+PKUQpDUF7autSBnqLYgzwc70lOeS7APZ0E8GkSlT7rsu8r7frLM1CrHE3qM+mqBLolWqroDIqELvrVYD3Px7DUm+Bt80XH9gNHRohVposLlhBszM8m0ZMQFh2M8zvnXuYRcfMOAeXK8c+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHSB8HPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19105C4CEC5;
	Thu, 10 Oct 2024 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728581439;
	bh=kXhptPcxcC7ywLLATkBWn77WBhRpBXuYaI6GoxtDd+Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iHSB8HPjye0R9mXiwmW1tDrFl+NNBQgf+Q3WP5MqWE03HYlUu3/N6f8ffhfXbBzPI
	 EgVOEwJSNCEMzpfZ3Yy+ffLWUF8lYMwuvia6iA44cpvWVJkfPJEozYV6FOuigvsfHg
	 xYIj262s3FnwUXUkkQO9oJqwd77ITTeyP0pf6xbvMAqLjP28dWmUlNwmsFq0d1lXWm
	 uFNtk1OkmwUeh6DGiSm1nkj/0I8QJLAxZ0v7CaV0zVPbazTGO1OcXfencCD7loCDiW
	 uJf48RGQWfd2s+hzQJdJQZeBENuQqXE/uoZbAPZpFhFRa+E0jQsV9zwJOdqiZ9RUmh
	 Z7hSZNhS8jc9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0EE3803263;
	Thu, 10 Oct 2024 17:30:44 +0000 (UTC)
Subject: Re: [GIT PULL] v6.12-rc fixes for NFSD
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZwfI3eK47tku5mtl@tissot.1015granger.net>
References: <ZwfI3eK47tku5mtl@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZwfI3eK47tku5mtl@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-1
X-PR-Tracked-Commit-Id: c88c150a467fcb670a1608e2272beeee3e86df6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5870963f6c0e2dc7f3330c6cfdbda6b81bfdd3a5
Message-Id: <172858144322.2105267.761406563892798196.pr-tracker-bot@kernel.org>
Date: Thu, 10 Oct 2024 17:30:43 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Oct 2024 08:30:21 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5870963f6c0e2dc7f3330c6cfdbda6b81bfdd3a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

