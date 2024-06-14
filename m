Return-Path: <linux-nfs+bounces-3820-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC4D90868F
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 10:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44591C25436
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA38C18508D;
	Fri, 14 Jun 2024 08:40:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A71836DE;
	Fri, 14 Jun 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354425; cv=none; b=O8+GAzonR097uK+BZ8saqzmKJ4GURYZ6IqfWpWHursY0sEA59pmXVimVsyPEVLOl+dtxIP51mRpWU7vWgsCPeVy5MPpZmkNPag7E8kNn4EVfB3CQXB31cLgXQHxoMgiQoyliDXtdTSBW/PDiApwsC1K96KC7Ojk70j8pid76m44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354425; c=relaxed/simple;
	bh=fUz6PrtFBHmdSanceP4rEnElFSeTVqazvmJwnBn6bg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxWcqTeG85nviXwhRoja5wS+TJUgYc1lfV+t+08vup9zBJywIpBNW5uw20ZRyUVXs+xNo/kEVNjU5OmbnsZ7C7li22tPRi7GXdrIAEK4BQFEBRzXwiKOiWE0M13TANjlB93E3BYNekp3zFJMQ0MEEdnQsgyPAtTKgKNlc8lO/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtpsz10t1718354248tjm52n
X-QQ-Originating-IP: qslyn0oMXcpOJEcFPvUvJm0egT/cIEGM1bOAZQB2Bz0=
Received: from [192.168.3.231] ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Jun 2024 16:37:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8925404822079021439
Message-ID: <93D6D58053EB522F+de1c8896-65e1-442d-99f6-c5b222c0a816@chenxiaosong.com>
Date: Fri, 14 Jun 2024 16:37:24 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about pNFS documentation
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Benjamin Coddington <bcodding@redhat.com>,
 Olga Kornievskaia <kolga@netapp.com>, Josef Bacik <josef@toxicpanda.com>,
 Jeff Layton <jlayton@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "liuzhengyuan@kylinos.cn" <liuzhengyuan@kylinos.cn>,
 "huhai@kylinos.cn" <huhai@kylinos.cn>,
 "chenxiaosong@kylinos.cn" <chenxiaosong@kylinos.cn>
References: <BA2DED4720A37AFC+88e58d9e-6117-476d-8e06-1d1a62037d6d@chenxiaosong.com>
 <08BB98A6-FA14-4551-B977-8BC4029DB0E1@oracle.com>
Content-Language: en-US
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <08BB98A6-FA14-4551-B977-8BC4029DB0E1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Thanks for your reply. By the way, are there any plans for the Linux NFS 
server to implement the file, flexfile and object layout?

Thanks,
ChenXiaoSong.

在 2024/6/13 23:31, Chuck Lever III 写道:
> Hi-
> 
>> On Jun 13, 2024, at 4:35 AM, ChenXiaoSong <chenxiaosong@chenxiaosong.com> wrote:
>>
>> Greetings,
>>
>> I am very interested in Parallel NFS (pNFS) and want to setup a testing and debugging environment for pNFS. I found some pNFS documentation [1] [2] [3], but I still don't know how to setup Linux environment about file layout, block layout, object layout, and flexible file layout. Some documentation like spNFS(simple pNFS) is unmaintained and was dropped. Can you recommend some other detailed documentation(how to use pNFS in Linux)?
>>
>> Thanks,
>> ChenXiaoSong.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/nfs/pnfs-block-server.rst
>>
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
>>
>> [3] https://linux-nfs.org/wiki/index.php/PNFS_Development
> 
> I'm not aware of recent documentation other than what you
> have listed here.
> 
> Note that the Linux NFS client implements the file, block,
> and flexfile layout types, but the Linux NFS server
> implements only the pNFS block layout type.
> 
> I've been building out testing that we can run for each
> release of NFSD that will exercise pNFS block layout
> support in the Linux NFS server and client, since pNFS
> block is the common denominator between our client and
> server.
> 
> Look at the 9 commits at the tip of [1]. These contain
> changes to kdevops that add the ability for it to set up
> an iSCSI target and enable pNFS on its local NFS server.
> If you can read Ansible scripts, these might help you
> form recipes for you to set up your own environment
> using the Linux NFS implementation and its iSCSI target
> and initiator.
> 
> Admin documentation (outside of kdevops) is on the to-do
> list, but hasn't been started.
> 
> 
> --
> Chuck Lever
> 
> [1] https://github.com/chucklever/kdevops/tree/pnfs-block-testing

