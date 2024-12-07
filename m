Return-Path: <linux-nfs+bounces-8409-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD719E7F09
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 09:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A3A167D35
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CD855896;
	Sat,  7 Dec 2024 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS9fui4Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0518638
	for <linux-nfs@vger.kernel.org>; Sat,  7 Dec 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733560494; cv=none; b=ku6X338lFOyXSbdkFHMAvu7HVSgcJ/lq42PsVM2npSk2tkBUUlB5q1nt+NY7lElc2v8eUAFFPQnL/qGlWIqK3xCkl3Lj7+8F8yjb6Ivx94oIVpbAvC9kiwYTKD6sV166BQJ9iEUXA8zEIALBuGz5MK+pHt9xd2TbkZVjfS3+5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733560494; c=relaxed/simple;
	bh=dkrbRpLnL3o2NYZhbOW0uoBfmdmuXOO0he4s/8mkfDU=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=UpsUxV4GIzad6WI6S3A36qst0IfD+Rup+4tZf9XbOIBPeV5Q7rrzMff5c2sJ7Ms0AoCfqSH6wHs+3fWxcTXyP5aZ9ysWXyNIXJJyhBBwGC0IvzJK7k+cnlNEZTTbUZeijwAS2Lv8T2M65couAFrLrxKWQgwE/ZplQxezxpcj5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS9fui4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEB1C4CECD;
	Sat,  7 Dec 2024 08:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733560493;
	bh=dkrbRpLnL3o2NYZhbOW0uoBfmdmuXOO0he4s/8mkfDU=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=dS9fui4QgWSdhKFeSXA7FH/JOA2ki8nLHBN1yLdQK7SNw2/6OIu7N9T0CBEZtK7qT
	 YC+xB/EKIi5aJMN8bU+VfkKBWTdvn6xVaIi/XKXTyWfK5hVgZaBvIFXdJ8IRXf8Elu
	 H9UnBoMOTTZ7aVgrRJSQmNOr1fy94uPlsA863A8c5uXIwdNY2haKDfmZsAUdHf39ca
	 +2QYl/+tWxZNUhcZonNG0jFnn/a748lsvgT8QFF6dXgJ785or82QSkvfohma4OuZuN
	 Oa56SdzVxovjvdbcCq6q3X5Hb9NnOy8GX0Evh8hUGS8MYljESY/rxqEJvwTLSKWW+G
	 sygEwOW9XgWKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9416380A95D;
	Sat,  7 Dec 2024 08:35:09 +0000 (UTC)
From: Chen Chen via Bugspray Bot <bugbot@kernel.org>
Date: Sat, 07 Dec 2024 08:35:12 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jlayton@kernel.org, cel@kernel.org, linux-nfs@vger.kernel.org, 
 anna@kernel.org, trondmy@kernel.org
Message-ID: <20241207-b219535c8-544381616c66@bugzilla.kernel.org>
In-Reply-To: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
References: <20241127-b219535c0-4d5445e74947@bugzilla.kernel.org>
Subject: Re: Possible memory leak on nfsd
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chen Chen added an attachment on Kernel.org Bugzilla:

Created attachment 307330
dmesg of another 3 crashes

Since reporting I got another 3 crashes. All killed by nfsd.

First one:
[136965.765431] Out of memory and no killable processes...
[136965.765433] Kernel panic - not syncing: System is deadlocked on memory
[136965.766148] CPU: 2 PID: 1856 Comm: nfsd Kdump: loaded Tainted: G            E      6.1.119-1.el9.elrepo.x86_64 #1
[136965.766852] Hardware name: Dell Inc. PowerEdge R740/0923K0, BIOS 2.22.2 09/12/2024
[136965.767546] Call Trace:
[136965.768230]  <TASK>
[136965.768903]  dump_stack_lvl+0x45/0x5e
[136965.769571]  panic+0x10c/0x2c2
[136965.770231]  out_of_memory.cold+0x2f/0x7e
[136965.770874]  __alloc_pages_slowpath.constprop.0+0x707/0x9d0
[136965.771518]  __alloc_pages+0x35d/0x370
[136965.772147]  __alloc_pages_bulk+0x3e5/0x680
[136965.772766]  svc_alloc_arg+0x81/0x1f0 [sunrpc]
[136965.773431]  svc_recv+0x1f/0x190 [sunrpc]
[136965.774089]  ? nfsd_inet6addr_event+0x110/0x110 [nfsd]
[136965.774726]  nfsd+0x87/0xc0 [nfsd]
[136965.775347]  kthread+0xe5/0x110
[136965.775926]  ? kthread_complete_and_exit+0x20/0x20
[136965.776499]  ret_from_fork+0x1f/0x30
[136965.777062]  </TASK>

Second:
[167723.787640] WARNING: CPU: 3 PID: 1872 at mm/slab_common.c:957 free_large_kmalloc+0x5a/0x80
[167723.787667] Modules linked in: <cut here>
[167723.787874] CPU: 3 PID: 1872 Comm: nfsd Kdump: loaded Not tainted 5.14.0-503.15.1.el9_5.x86_64 #1
[167723.787882] Hardware name: Dell Inc. PowerEdge R740/0923K0, BIOS 2.22.2 09/12/2024
[167723.787886] RIP: 0010:free_large_kmalloc+0x5a/0x80

Third:
[ 3883.748094] ------------[ cut here ]------------
[ 3883.748105] WARNING: CPU: 9 PID: 1886 at mm/slab_common.c:957 free_large_kmalloc+0x5a/0x80
[ 3883.748131] Modules linked in: <cut here>
[ 3883.748339] CPU: 9 PID: 1886 Comm: nfsd Kdump: loaded Not tainted 5.14.0-503.15.1.el9_5.x86_64 #1
[ 3883.748342] Hardware name: Dell Inc. PowerEdge R740/0923K0, BIOS 2.22.2 09/12/2024
[ 3883.748344] RIP: 0010:free_large_kmalloc+0x5a/0x80

File: crash.log (text/plain)
Size: 31.77 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307330
---
dmesg of another 3 crashes

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


