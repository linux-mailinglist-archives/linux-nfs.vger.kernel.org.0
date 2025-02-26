Return-Path: <linux-nfs+bounces-10371-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757BDA46DD3
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 22:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 705AC7A4E4A
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 21:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95360260A20;
	Wed, 26 Feb 2025 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzixH6uv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049325EFB8
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606367; cv=none; b=fJ4Fqx7RrNOab7HTxjucQdHDAZWUG30dfWWmC4hfDKbMA55lBquPBFyvmc4tomSHZbA0itNDPfEJko78bxdC3urpoXR4HNFaS8XyZR4kKjnwx9i8XbFfQ1hlXxVZWNASJaB+SqS0wlg3EIBDV0zUU6QBWCFhpe2VI2D9XUHzhl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606367; c=relaxed/simple;
	bh=kLtZWcrJ9KT9w5gqoHnCh/QexQtvHMjryeZFWr8FANE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rMOg4F8Ptn7GxDU8ZxVbDv+EnL0KyRv7f8k6/0e2j0R+Ur0qaBkwgWScDCz0fMEORXeXQ4qkjLN3MsOnqHVTdJq1+JaGmzGdlijGnJBO8c84GAyyb4aa3KBqbKeh9Qv3pqj+D8RFxWkA7ERg+TS8XaWwjeUY0bMQu6Pk4gNn6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzixH6uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AE6C4CED6;
	Wed, 26 Feb 2025 21:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606367;
	bh=kLtZWcrJ9KT9w5gqoHnCh/QexQtvHMjryeZFWr8FANE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mzixH6uvk/UBH+1m1J7J4jd34/lnmevBsaOZHfr7Zq2vF9iz24bTlMMIca9zZyNv0
	 zf/JpW0D0uii07epBPcn7HiECt6M7bW/XXeSOE0zTZoJNimQ5rW1Zij9cxmZbbv3Pd
	 fSYMAnj0xD3smGV9oDKzD8V1mbGbptABQ+gX0IZimxTouH+mj7qrkVZeP3IETpjsZR
	 0jA+/1gZZU9BWVOhtX6lim8Fr1cw7YjWopKznp3EKtdqhPpNDBIFy+dAc5bT1CEJSJ
	 /KHscQz3fcRUN+piliqBBrwCNGitaotFIBNM80hZSp/aU9ngAQ7ctOCprGd6WcU5V0
	 dkZtOoh+HQcGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D77380CFE5;
	Wed, 26 Feb 2025 21:46:40 +0000 (UTC)
Subject: Re: [GIT PULL] Please Pull NFS Client Bugfixes for Linux 6.14-rc
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250226155829.134451-1-anna@kernel.org>
References: <20250226155829.134451-1-anna@kernel.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250226155829.134451-1-anna@kernel.org>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.14-2
X-PR-Tracked-Commit-Id: 9084ed79ddaaaa1ec01cd304af9fb532c26252db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5394eea106517d5b0d4a372f00e63d5db8cb0370
Message-Id: <174060639905.856033.7196237853219711453.pr-tracker-bot@kernel.org>
Date: Wed, 26 Feb 2025 21:46:39 +0000
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, torvalds@linux-foundation.org, anna@kernel.org
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Feb 2025 10:58:29 -0500:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5394eea106517d5b0d4a372f00e63d5db8cb0370

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

