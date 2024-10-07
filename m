Return-Path: <linux-nfs+bounces-6916-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7839936E7
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 20:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8F41C23BC7
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3BC1DE3AF;
	Mon,  7 Oct 2024 18:54:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4521DE3AE
	for <linux-nfs@vger.kernel.org>; Mon,  7 Oct 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728327276; cv=none; b=e1ZsJJXlavpbdQNvzm3V/nyFp5CSRbidsBT3wOhHw/0//sAxCx9XpeH1fakSG+RE/W8x2XMaqXUzhgtL1zZ/L4tdhh6bnGpLSv+eVsWswD3cB5Sgxb9+S0KHrUrZR+5jhqnz9h32IpNJix375GxLfVWrHZ8CyXkHESjEUJxp2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728327276; c=relaxed/simple;
	bh=FJ2i0gCuiLN7Y5sHLWGH2qKOsPdPjWskYeuQ5ygjcoQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oaMUkT+F7YtpIJDNhcN7wOgMfV/d5Xv31dGYoBUoXT3cuAEwdt6IMHD5ZpbMyMo068+ILtTKcTRwmhGuSbLyq2qd/jBs3Eu6wDGwRpzxHrjdEc601pmIvtE8RoLe8gLg1gozsgB3kHeepx9k6DFiB0qRJTcHq1gJ3uCjGAdFd+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 11331 invoked from network); 7 Oct 2024 18:54:28 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@79.192.205.88)
  by mailout.selfhost.de with ESMTPA; 7 Oct 2024 18:54:28 -0000
Received: from [IPV6:2003:e3:1f39:3702:68fd:ffff:fe6f:e76] (p200300e31f39370268fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f39:3702:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id f24367b8;
	Mon, 7 Oct 2024 20:54:28 +0200 (CEST)
Message-ID: <f67d904a-4c94-490b-83a3-24d11112a6a4@afaics.de>
Date: Mon, 7 Oct 2024 20:54:28 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_umount
From: Harald Dunkel <harri@afaics.de>
To: NeilBrown <neilb@suse.de>
Cc: syzbot <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>,
 Jeff Layton <jlayton@kernel.org>, Dai.Ngo@oracle.com,
 chuck.lever@oracle.com, kolga@netapp.com, linux-nfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tom@talpey.com
References: <> <d8e1e97f-997f-4dca-8b3f-0628a3783957@afaics.de>
 <172808507143.1692160.17519936392458356798@noble.neil.brown.name>
 <f1e538b5-fd93-46f7-a8b1-8c0c649f5a11@afaics.de>
Content-Language: en-US
In-Reply-To: <f1e538b5-fd93-46f7-a8b1-8c0c649f5a11@afaics.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-07 12:51:08, Harald Dunkel wrote:
> Hi Neil,
> 
> ACK. Debian provided a new kernel version 6.1.112 for Bookworm, anyway.
> May I send you a task dump of the running system (before nfsd getting
> stuck) after the reboot, just for verification?
> 

Rebooted. The changelog for the new kernel mentions some nfsd fixes:

     - nfsd: Simplify code around svc_exit_thread() call in nfsd()
     - nfsd: separate nfsd_last_thread() from nfsd_put()
     - NFSD: simplify error paths in nfsd_svc()
     - nfsd: call nfsd_last_thread() before final nfsd_put()
     - nfsd: drop the nfsd_put helper
     - nfsd: don't call locks_release_private() twice concurrently
     - nfsd: Fix a regression in nfsd_setattr()

Do you think these fixes could be relevant here?


Regards

Harri

