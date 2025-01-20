Return-Path: <linux-nfs+bounces-9403-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DFBA172F2
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 20:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F603AA30F
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001521F190F;
	Mon, 20 Jan 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/1uNpCI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81E1F1914
	for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399582; cv=none; b=E4KTUZ0M1t4cTzbmxQucu0eV3E6IeGfa2i95mVb/u+HpaxejUwKRrXyaYotSg7CCrgCICwzQt6FDpZXmljlEDSaaLf96I5Wl1YPUsqAS4shTAQyWDfG+1KrBYM5gRluQz2BQBe6qjEnShlnqJn5T+Y4F0dN6OJEiWFkavRSOh00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399582; c=relaxed/simple;
	bh=jo4/etqlVP7GcbUYup13bI+WRTgBFRooXjx663D46Dk=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=rvCg08YzG+X3D7vIGmaGqenHRd87/JIuCXeTEaS91gZvc0ECYd65aM5hsLmG8weeSy7yUdaF+YjvoBqgYtKYtcJ6krbEprKsd9RAYovkzWmqT5/+iSCzou3BzLcPUCgaMRU0ZXThx/uyseOpqr4olAXFG2W/8OwPxzjlipMbh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/1uNpCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA4EC4CEDD;
	Mon, 20 Jan 2025 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737399582;
	bh=jo4/etqlVP7GcbUYup13bI+WRTgBFRooXjx663D46Dk=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=U/1uNpCI0qlUUKSK5/fMlVP24n5DI/+0NgKzCgeZpdl4zqLqQBoMOnXvpr0uNmZKc
	 virbFSKnYsNxD/OO4n5SmfMjYN7f/0nywWrJJ0LNryAmMrDXGKOedTbeO6MW8q5r6i
	 UvqEHOTwdHBCi1iAuRUs14we1qpRIzOqbBG37HEs9Swe3KQH8Rf6PQZlpVr2fTHSPZ
	 d1kXvmb/XSFVeMef6TIwSdQv/qUr+l+g7chnZ6H1l1bxUATC0AgzQljcg7VJstupLU
	 dP2IA63Dc5C0AguTXlAh8H+ZoG9pX4bUM0ZHs2F+m+ftzWXpfz3cJAIZGmSg8FWO0k
	 ZVjE2goU5n9vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED4C3380AA62;
	Mon, 20 Jan 2025 19:00:07 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 20 Jan 2025 19:00:07 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: chuck.lever@oracle.com, carnil@debian.org, 
 baptiste.pellegrin@ac-grenoble.fr, anna@kernel.org, jlayton@kernel.org, 
 herzog@phys.ethz.ch, trondmy@kernel.org, cel@kernel.org, 
 harald.dunkel@aixigo.com, linux-nfs@vger.kernel.org, 
 benoit.gschwind@minesparis.psl.eu
Message-ID: <20250120-b219710c4-c009d53d69fd@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

origin/linux-6.1.y is missing this commit:

> 961b4b5e86bf ("NFSD: Reset cb_seq_status after NFS4ERR_DELAY")

which is related to the problem reported in this bug, though it might not be a fix. This branch is based on 6.1.126 and has 961b4b5 applied to it for easy testing.

>
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-6.1.y

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c4
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


