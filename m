Return-Path: <linux-nfs+bounces-6690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FC79893BC
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 10:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6EBB22D5B
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Sep 2024 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32AC1EA73;
	Sun, 29 Sep 2024 08:23:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501791E4B0
	for <linux-nfs@vger.kernel.org>; Sun, 29 Sep 2024 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727598226; cv=none; b=B5auEiigJPyD34Q63grJ5VWZCNMziboMdjro3HdJ2tKAfyf9LiPS4/y7TwcMLFBfncjXvZszzKxOHOn+AXnir8Zn4EZAGhpAeU6RiQwd1AZyqxqlSJ+HHrgN3OJ7blyRMu/TUrR2K+TAXVwgX5JWXQzeFEIaD+cuye92Xq1c35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727598226; c=relaxed/simple;
	bh=QGiLX1N25i5QiptM390ojj7ex5Xay1s9G4LoYtTTuwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4bEQrqyi+uxTpnQvMxoWfToT7juuIuPGsXvGXjtzXUkC49S+QbbJnC5JT41B0irPByXAeumEqcJXLYkUmOTUu+5/EErSxPhrqfvnME8QgblxjxY/hKI4DUeZrGJJcQ6ZdkljQ6q+LHCHZ+RP8IiN1gsXi+jArBXQbxr1s52Aqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 2526 invoked from network); 29 Sep 2024 08:23:35 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@87.160.249.214)
  by mailout.selfhost.de with ESMTPA; 29 Sep 2024 08:23:35 -0000
Received: from [IPV6:2003:e3:1f1d:a202:68fd:ffff:fe6f:e76] (p200300e31f1da20268fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f1d:a202:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id 912a126f;
	Sun, 29 Sep 2024 10:23:34 +0200 (CEST)
Message-ID: <90750d21-61fa-4243-8c6b-dbf6fa185ae4@afaics.de>
Date: Sun, 29 Sep 2024 10:23:34 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_umount
To: NeilBrown <neilb@suse.de>
Cc: syzbot <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>,
 Jeff Layton <jlayton@kernel.org>, Dai.Ngo@oracle.com,
 chuck.lever@oracle.com, kolga@netapp.com, linux-nfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tom@talpey.com
References: <> <eb6ef7e3-8980-4202-8b99-012d9269b236@afaics.de>
 <172756219838.470955.2955513122187106920@noble.neil.brown.name>
From: Harald Dunkel <harri@afaics.de>
Content-Language: en-US
In-Reply-To: <172756219838.470955.2955513122187106920@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Neil,

On 2024-09-29 00:23:18, NeilBrown wrote:
> 
> Thanks for the logs.  The point to flush_workqueue() being a problem,
> presumably from nfsd4_probe_callback_sync(), though I'm not 100% sure of
> that.  Maybe some deadlock in the callback code.  I'm not very familiar
> with that code and nothing immediately jumps out.
> 
> I had thought that hung_task_all_cpu_backtrace would show a backtrace of
> *all* tasks - I missed the "cpu" in there.
> If if it happens again and if you can
>    echo t > /proc/sysrq-trigger
> to get stack traces of everything, that might help.  Maybe it won't be
> necessary if I or someone else can spot a deadlock with
> flush_workqueue().
> 

I just learned that kernel.hung_task_panic = 1 should have been set, too.
Sorry for that. Currently I have

	kernel.hung_task_panic = 1
	kernel.hung_task_all_cpu_backtrace = 1

Please confirm.

I have set a watchdog to run the sysrq trigger on the NFS server if df
on an NFS client doesn't respond.


Regards
Harri

