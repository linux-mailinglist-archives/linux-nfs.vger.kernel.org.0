Return-Path: <linux-nfs+bounces-6584-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F5E97DC12
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Sep 2024 10:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFBF1C20AB1
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Sep 2024 08:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18561149C50;
	Sat, 21 Sep 2024 08:05:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43C8C07
	for <linux-nfs@vger.kernel.org>; Sat, 21 Sep 2024 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726905943; cv=none; b=Gl0G5YOlrkaEYA5xA928JP4tTqVrFlRKEyNnooy+3VZOvLzK0qs8Cz+1e0rtYZ4+P+3ypPQxu323Gk8FAR3+oimOPAOp8KSzlsDIot7EJO53XIwGlI98GkwZohy6nh5awkHMVyU4gYvBfUR78HlFgQZlDVKgoI1RGcaSgxXdNVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726905943; c=relaxed/simple;
	bh=AtLz/usv0W73PVsD4gOVRs7NTWRnSxRNnoRRwVOzlaQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BmslOLqR7OF2RcN1PKrhdxP6svKOAHHjkYHGtJPBT+TRgrippFcFOnoOsBjkn2olFEgMY+wWLuOkPqp2z3d2Li/B2VWOH6VSDqLhRWF9LyCqOYRQOsceHeeZZlq4Vii6LVv3jOepoXhOTxVRbL5kK1DnqsCsA81ZFtDTAeV5LFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 11761 invoked from network); 21 Sep 2024 07:58:56 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@87.160.249.214)
  by mailout.selfhost.de with ESMTPA; 21 Sep 2024 07:58:56 -0000
Received: from cecil.afaics.de (p200300e31f1da20268fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f1d:a202:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id 0de61920;
	Sat, 21 Sep 2024 09:58:55 +0200 (CEST)
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_umount
To: NeilBrown <neilb@suse.de>,
 syzbot <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Dai.Ngo@oracle.com,
 chuck.lever@oracle.com, kolga@netapp.com, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, tom@talpey.com
References: <000000000000f8ed54061ca0d9a5@google.com>
 <9825cc5ff85d4a2a4ce1c955f49681bef8d03442.camel@kernel.org>
 <172039726840.11489.12386749198888516742@noble.neil.brown.name>
From: Harald Dunkel <harri@afaics.de>
Message-ID: <42600ff8-512f-bea1-848c-2cc1c823cb76@afaics.de>
Date: Sat, 21 Sep 2024 09:58:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <172039726840.11489.12386749198888516742@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

NeilBrown wrote:
> 
> We can guess though.  It isn't waiting for a lock - that would show in
> the above list - so it might be waiting for a wakeup, or might be
> spinning.
> The only wake-up I can imagine is in one of the memory-allocation calls,
> but if the system were running out of memory we would probably see
> messages about that.
> 

I have seen something like this. I am running NFS inside a container,
using legacy cgroup. When it got stuck it claimed I cannot login
into the container due to out of memory. When it happens again, I
can send you the exact error message. The next hung nfsd is overdue,
anyway.

> I wonder if it could be looping in svc_xprt_destroy_all(), and sitting
> in the msleep() when the hang is detected so there are no locks to
> report.   I can't see while it would block there.
> 
> It would really help to get a full task list.
> There is a sysctl for that: /proc/sys/kernel/hung_task_all_cpu_backtrace
> 
> Could that be enabled?
> 

I have enabled it on my NFS server (echo 1 >/proc/.../hung_task_all_cpu_backtrace).


Regards

Harri

