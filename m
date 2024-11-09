Return-Path: <linux-nfs+bounces-7828-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FF99C2FB4
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 23:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B304B1F217B1
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 22:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C11A2C04;
	Sat,  9 Nov 2024 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zhgxk5s/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B81A2860;
	Sat,  9 Nov 2024 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731189656; cv=none; b=bXRE9WwahaVyb1hns/qPvLojnRAW+Rpz9QvEfKLxcsSyNtaWlGK95qDAJ1AtgIrhVGuBZ/dNRUQnENEfiCCIN+o9NZ+EEdPtprRQxOvgZXBk6GN6zuT3ZQo0fRVHZ4H029h/aL/LQZBebayj91iosvB6bF7h7enicOrHHfuymIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731189656; c=relaxed/simple;
	bh=+Au4KrjwLhVSphQtY3qJElawJPQGuZX7GMriGc/bqYw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tu9nNccOIO2Hl057WgAmxD4bb9tJxstcoit21OtoyfIwhFEMUNtMeE3CqBlNcILhUeR83vTA99AEpmNh4+WzvTICyVlhQXI2/4/uatR/cxlzmngszXwxz0SuaTb2wxwx+o9zJniLhwxOUoSVcNqQZhIhlnHjRfBKqibKuyKvKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zhgxk5s/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE37C4CECE;
	Sat,  9 Nov 2024 22:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731189656;
	bh=+Au4KrjwLhVSphQtY3qJElawJPQGuZX7GMriGc/bqYw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zhgxk5s/TodBDm0jzbw30ES5IQTi6QsZmf50KUzRTZ0ibXkrmsBrZCLhCbwk47+I/
	 dq4NgRA8JYVmY5txxEfhvyRPtZBoV85N23n4cfSRRD9nOD9HhwCckbY4iAseCf3G+m
	 SduR4pPzyf1YrFPU5KJAqu2L7Ta+f1CjLftqM0AxVbGTEcbcvjxr3F6xVDdBX5MU+g
	 w732c34+pfUpvjNqR7yym7YJt5NsXpaxIkNvmRyJdZj7oTRXEuHShVE8BMGAjv5u/d
	 EKRMMdPn1KrYjK8wmCynptgZRyZwYA4V9iFmCuC5l/IQog4iVZlj4hVtDBT+TlA1t5
	 D6CcLZ0dyUpVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9E3809A80;
	Sat,  9 Nov 2024 22:01:06 +0000 (UTC)
Subject: Re: [GIT PULL] one more NFSD fix for v6.12-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zy+dSVteJF/PSpL/@tissot.1015granger.net>
References: <Zy+dSVteJF/PSpL/@tissot.1015granger.net>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zy+dSVteJF/PSpL/@tissot.1015granger.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-4
X-PR-Tracked-Commit-Id: bb1fb40f8beb45a3733118780a3da24fb071a2e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de2f378f2b771b39594c04695feee86476743a69
Message-Id: <173118966545.3021408.12361114792234187121.pr-tracker-bot@kernel.org>
Date: Sat, 09 Nov 2024 22:01:05 +0000
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 9 Nov 2024 12:35:05 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.12-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de2f378f2b771b39594c04695feee86476743a69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

