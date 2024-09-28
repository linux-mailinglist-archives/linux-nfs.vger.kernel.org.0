Return-Path: <linux-nfs+bounces-6683-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59B3988E44
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Sep 2024 09:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039731C20F7C
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Sep 2024 07:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6605319DF64;
	Sat, 28 Sep 2024 07:42:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C9136663
	for <linux-nfs@vger.kernel.org>; Sat, 28 Sep 2024 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727509320; cv=none; b=YJByX/pNbqcCzGR9w2o/ngw8SygMMStM0R1AwI4fBc8eAdKY+LXIHbeBlRAI/09A3hToeqE0g9C310SFAS8gRG9GGsuNGzXb8f3YoGTo1SU9oEmvJZgukZLyaJfwxbTT8+rn+ryKZ6HbKLVvO52uk8mYFIJpYW0z4zz6yliAjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727509320; c=relaxed/simple;
	bh=+EMyevqQbSiJ4vjgK+X08T2LpxvnKmyxc6suXfSts4k=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=NK0yLwHpA+2WwAIN1fAs4z+Q3nzk7vDoDytbuZkZp3rr0A0uBiRffpNgmPuqa9QgSe1dYSvdyupGdUmvToIkoLPiIw6Gn8vPyiPeRq1TJxzhZGgwCgGHGpEIhyJPURN6DPUJlRE9cFzDYi5xN7hLDZlYarKiL4IwckjVy0LpWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 22519 invoked from network); 28 Sep 2024 07:41:47 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@87.160.249.214)
  by mailout.selfhost.de with ESMTPA; 28 Sep 2024 07:41:47 -0000
Received: from [IPV6:2003:e3:1f1d:a202:68fd:ffff:fe6f:e76] (p200300e31f1da20268fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f1d:a202:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id 985d6e11;
	Sat, 28 Sep 2024 09:41:47 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------OFEmP2D8kqKtskjzz4nw11v8"
Message-ID: <eb6ef7e3-8980-4202-8b99-012d9269b236@afaics.de>
Date: Sat, 28 Sep 2024 09:41:47 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_umount
From: Harald Dunkel <harri@afaics.de>
To: NeilBrown <neilb@suse.de>,
 syzbot <syzbot+b568ba42c85a332a88ee@syzkaller.appspotmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Dai.Ngo@oracle.com,
 chuck.lever@oracle.com, kolga@netapp.com, linux-nfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, tom@talpey.com
References: <000000000000f8ed54061ca0d9a5@google.com>
 <9825cc5ff85d4a2a4ce1c955f49681bef8d03442.camel@kernel.org>
 <172039726840.11489.12386749198888516742@noble.neil.brown.name>
 <42600ff8-512f-bea1-848c-2cc1c823cb76@afaics.de>
Content-Language: en-US
In-Reply-To: <42600ff8-512f-bea1-848c-2cc1c823cb76@afaics.de>

This is a multi-part message in MIME format.
--------------OFEmP2D8kqKtskjzz4nw11v8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

On 2024-09-21 09:58:55, Harald Dunkel wrote:
> NeilBrown wrote:
>>
>> We can guess though.  It isn't waiting for a lock - that would show in
>> the above list - so it might be waiting for a wakeup, or might be
>> spinning.
>> The only wake-up I can imagine is in one of the memory-allocation calls,
>> but if the system were running out of memory we would probably see
>> messages about that.
>>
> 
> I have seen something like this. I am running NFS inside a container,
> using legacy cgroup. When it got stuck it claimed I cannot login
> into the container due to out of memory. When it happens again, I
> can send you the exact error message. The next hung nfsd is overdue,
> anyway.
> 

my NFS server got stuck again last night. Unfortunately the service was
recovered by a colleague, so I had no chance to check the memory. Attached
you can find the log files of both nfs container and LXC server, with
/proc/sys/kernel/hung_task_all_cpu_backtrace set to 1.

I dropped the kernel mailing list from this reply, due to large attachments.
Hopefully this was OK?

Hope this helps. Please mail if I can help
Harri

--------------OFEmP2D8kqKtskjzz4nw11v8
Content-Type: application/gzip; name="log.nfs01.txt.gz"
Content-Disposition: attachment; filename="log.nfs01.txt.gz"
Content-Transfer-Encoding: base64

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
n5OMBD9DThIohf0EIXe/O+1/5dngNqNcAAA=
--------------OFEmP2D8kqKtskjzz4nw11v8
Content-Type: application/gzip; name="log.nasl006.txt.gz"
Content-Disposition: attachment; filename="log.nasl006.txt.gz"
Content-Transfer-Encoding: base64

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
PwHe5yTF6QYBAA==

--------------OFEmP2D8kqKtskjzz4nw11v8--

