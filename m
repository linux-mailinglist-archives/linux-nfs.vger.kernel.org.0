Return-Path: <linux-nfs+bounces-8508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FA69EB3C3
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 15:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABFF283A9A
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8047D1B3F30;
	Tue, 10 Dec 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6NxqYLV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA81B2195
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841891; cv=none; b=EOX4tYg3GjTHuAjCQPiNifUg/YI9lahct+ovLbqoEtAzs332Znd24XbvOvWZJ+nux5X0CbPTT8LBjd9p6ulIWjaN7+mBL/mOxLHER46JaYIWCc6PFrX1jHi9tHuzX5WFhWUG+2jTMZ2X5anyrDtOMttppIAUkoc/6SOW6RDk+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841891; c=relaxed/simple;
	bh=F8a58kaQ5HBZIhboLnmf7ghhmu9jU4mV2qydZOzHjpw=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=TtYFPasLbxax+QPhWAMgJjMa7/pL4LSr+6swzFcN/2G/5/ruQMfvt9PUMa3RUqIP1AP7rx1OYEHpc8BNrfiLg7XHagvcZiQRcOkQTr/ZY5OkmxnqFm4vbALIKXpeG2+8AJM4E5zvFRnxgum52sNKlslEj1LpkIs6F33rH/EfEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6NxqYLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D841BC4CED6;
	Tue, 10 Dec 2024 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733841890;
	bh=F8a58kaQ5HBZIhboLnmf7ghhmu9jU4mV2qydZOzHjpw=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=o6NxqYLVxlYdNP6ldBVPdEyNQRjrEyDmOQQBTZiQrMgn/JRCPXiJ1CBZMa6UJANND
	 W5MGGjy9tTfUXLHZ/1vw/BNXyUhO2ew2+neeJwXPL2SRHGyQ4IeYI9VbMvbkrnZ10I
	 2txW08Wh+XJMBh9rLEL5DblEn3hxnvt/q3pikjnzth3xK8Ipn+tAcfgd/+KkuOtL0h
	 0x4KZ+lCHZnW6RsTs4NkHpLkFs5i3bp7gdv27aYVHE0UOlgaB3U786puAXGCgKOyt5
	 47uHcyT5fMcMQU+kh6pT2LR51j38+SUXF7fhtKKJloaoNAE8I2/47UXacWoBjfIxu6
	 GSIx808a2i8Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3F0D380A954;
	Tue, 10 Dec 2024 14:45:07 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 10 Dec 2024 14:45:14 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, cel@kernel.org, anna@kernel.org, 
 trondmy@kernel.org, jlayton@kernel.org
Message-ID: <20241210-b219535c11-366357209853@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

This is what comment 0 says:

> My RHEL9 server with only NFS service often OOMed after a day or two,
> with no userspace memory usage. So I switched to elrepo kernel-lts and
> still the problem persists.

> I'm now using 6.1.119-1.el9.elrepo.x86_64. The problem also occured on
> (RHEL 5.14.0-427.40.1.el9_4, (RHEL) 5.14.0-503.14.1.el9_5 and
> 6.1.115-1.el9.elrepo.x86_64.

You mentioned RHEL, and RHEL 9 in particular, several times here. I have no prior knowledge of "the ELRepo Project" -- never heard of it. By "uname" these all look like distro-built kernels to me.

> Anyway, I encountered another 2 crashes in the last two days and
> call stack insists nfsd caused it.

I'm not saying this isn't an NFSD bug. But it might not be a problem in recent kernels. If I'm reading your reports correctly, you have not tested with 6.12 or newer. 6.1.anything is based on a two-year old code base.

Any fix we create for this issue must be applied to the upstream Linus kernel first. Indeed, a fix might already exist somewhere in upstream. By upstream, I mean the "master" branch in this repo:

https://git.kernel.org./pub/scm/linux/kernel/git/torvalds/linux.git

Therefore the first task is for you to confirm by testing that this branch either still has this issue, in which case we have to troubleshoot further; or does not, in which case you can bisect to find the upstream fix that needs to be backported to the LTS kernels.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219535#c11
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


