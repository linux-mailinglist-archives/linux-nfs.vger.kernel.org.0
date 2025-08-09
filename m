Return-Path: <linux-nfs+bounces-13533-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD88B1F256
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 07:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15F9A041D6
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Aug 2025 05:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4FE27A460;
	Sat,  9 Aug 2025 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbvRJbaE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6B27A44A;
	Sat,  9 Aug 2025 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716788; cv=none; b=o21y3c8znpwnVG/LYd7NZrPSpOdDPutiNRWaeGCcFIRQspQFmC0YDgi9Q/WSrW51Eedq89bzd2UtuCaQTiSNpdesgau3LUc5DbJ0GAgOCIWstX3r5XiIUx/yztU4+69T3ofi4Z9z1O3uP2f7QUv7ccVNmL+OwGHii2MdvTUfj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716788; c=relaxed/simple;
	bh=Iks88uJIXClFLUe5jAuTx6gIZ0c3isCD3OKp+zeg/ug=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jlAAdKz8WUFzd/diwVClbAdR08EfYB6Zu91m/VrCdLW9ROlwQi7o2BBCtbvRdwKy1u2Dtdd/Hrj9fJPI9gIJqtr/LCAwj7mw65c/mLMlqpRDiw+8f+94eClWC+oLmvNgobCNvtqKbDcGmAsU59GTkyEtodcSmjR9k9tkLlWYnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbvRJbaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9E1C4CEE7;
	Sat,  9 Aug 2025 05:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754716788;
	bh=Iks88uJIXClFLUe5jAuTx6gIZ0c3isCD3OKp+zeg/ug=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KbvRJbaE2XV92LmTIySac9T/MuPdovLquVknpDYCip7kh2+IHn4KXc1UBPX7Po6g2
	 xa7pVG/JtRTJXKCvw8FDO5h8TSyoJQ5t0b1gho1nHuUXKPCzE/gM6v78qGgwEf68lS
	 +R1GGbZKivJbu50qlyokehAbwKufDP+tHrYP3YqRYaxVWSIlrFe3GXAWfKeUwpzPqh
	 nz8QCwoQXb4yUJMyzGTDje7NSg0oE0fJCozKujc7aFP7wT9Y7a9KioYjjJCLMFa24w
	 t9yW087tyFCBwGsWm93xQ257W4KBD6+YZHOB7yVxxX9xmFOj6QaKXK5NptGzCxXEsg
	 vmgg4HgfSu1TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CC9B5383BF5A;
	Sat,  9 Aug 2025 05:20:02 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull NFS client changes for Linux 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <f94837ec978d8ca505006f024b3cae3c920e5f58.camel@kernel.org>
References: <f94837ec978d8ca505006f024b3cae3c920e5f58.camel@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f94837ec978d8ca505006f024b3cae3c920e5f58.camel@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.17-1
X-PR-Tracked-Commit-Id: 4ec752ce6debd5a0e7e0febf6bcf780ccda6ab5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccc1ead23c3311be76e87d1b06620f6cb697b42a
Message-Id: <175471680160.380510.9682163862016537322.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 05:20:01 +0000
To: Trond Myklebust <trondmy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 08 Aug 2025 07:10:12 -0700:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccc1ead23c3311be76e87d1b06620f6cb697b42a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

