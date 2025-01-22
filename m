Return-Path: <linux-nfs+bounces-9460-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0062A190C6
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 12:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3C016790A
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 11:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE78212B13;
	Wed, 22 Jan 2025 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6xIh1f8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32CF212B11
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545984; cv=none; b=r6tOh/OSv6LXJdiO7pNbaw5GhF/3fkEIo0mgnTRVSU3wzSq44pFuegr0HBjoqcbQDwd6+X8r0Nxtla7LMP45j3di2Zze4M7dRrto7YdrV1HZo9gLQi/YKYl/GPihm1Vh/OyB+CZNhBZhhCxGA7t/P6xKgUKopJXkLF70hZtjJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545984; c=relaxed/simple;
	bh=cnoYvqV8+erZ8z0OeTXxklEHb6mE/XBAvoSr5iyppTI=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=oMwTVWnuITKlIT9/vCrr9YGSnKwtML2OID+oE8nfFzU1Jfug9ERRukgkUAupswSGFOmv3OmcHFSSXHitCbOs5XsKbRylA/x3+ezR13antuR79aF2DtYrCQF9uXP4bhbq/sfX57VanP0mcTT52CRqxe8auqFhd3Z1j28MJFikcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6xIh1f8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446A3C4CEE0;
	Wed, 22 Jan 2025 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737545983;
	bh=cnoYvqV8+erZ8z0OeTXxklEHb6mE/XBAvoSr5iyppTI=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=J6xIh1f8gLeBQWh1Bc7NL5CAzeVOyy3Hik43z3jbFX7Z5IoXoqyZWOJ1rZUskpkBs
	 ibnJaWYRUb9fggJZRKD+YcyKzT5cFQ7Pk/pi0DIgfUIUstbaueSMd2K6ydVVrhAuH5
	 y2L4OVjUsn2cxIg1S5wi4rpj7kWfijf8PsgR0y3vtXDmU2ugWRviZQUfvIxKG4c/9I
	 aVqtMJMDgHpRh3zEcWndxbYzl/sQroLaozooE+/HadCoIJtJrOVsyKUTdC8yW/frHj
	 f3jvkPQYly6JcvwQfLKsMM9PRNjXp8yaCeKcYfFkL0tISaJWnO7yacnqDjgCx7jzW+
	 JHjCzXqG+Ofug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B69BA380AA62;
	Wed, 22 Jan 2025 11:40:08 +0000 (UTC)
From: Baptiste PELLEGRIN via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 11:40:17 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: benoit.gschwind@minesparis.psl.eu, linux-nfs@vger.kernel.org, 
 harald.dunkel@aixigo.com, trondmy@kernel.org, carnil@debian.org, 
 baptiste.pellegrin@ac-grenoble.fr, anna@kernel.org, tom@talpey.com, 
 jlayton@kernel.org, cel@kernel.org, chuck.lever@oracle.com, 
 herzog@phys.ethz.ch
Message-ID: <20250122-b219710c13-b7767e78d1ec@bugzilla.kernel.org>
In-Reply-To: <20250121-b219710c9-24c03eb0cb57@bugzilla.kernel.org>
References: <20250121-b219710c9-24c03eb0cb57@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Baptiste PELLEGRIN writes via Kernel.org Bugzilla:

(In reply to Chuck Lever from comment #9)
> 
> The server generates a CB_RECALL_ANY message for each active client. If the
> number of active clients increases from zero at server boot time to a few
> dozen, that would also explain why you see more of these over time.

This mean that something can stay active overnight ? In my case, no client are running outside opening hour. They are all suspended or power off.

> 
> "-e sunrpc:xprt_reserve" for example would help us match the XIDs in the
> callback operations to the messages you see in the server's system journal.


I will try to help you I much as I can. Is not really a problem for me to run trace-cmd on all clients as they are all managed with Puppet. I will try as soon as possible.

You confirm to me that I need to run "trace-cmd record -e sunrpc:xprt_reserve" on all my clients ? No more flags ?

Did you see that I have added the "-e sunrpc:svc_xprt_detach -p function -l nfsd4_destroy_session" flags in my last recorded trace ? Do I need to add new one for the next crash ?

I will also send to you the dump of current kernel task next time.

Regards,

Baptiste.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c13
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


