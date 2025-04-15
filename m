Return-Path: <linux-nfs+bounces-11136-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A7A895FF
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Apr 2025 10:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D703A397C
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Apr 2025 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3D23F410;
	Tue, 15 Apr 2025 08:06:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7A22DFA5E;
	Tue, 15 Apr 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704368; cv=none; b=Z6jX6aD0XWOakv2+KP3gQx6jeehAR+s7hNTw5wkF3cjPaRlUUFvru4y6/h5a4Tx4/jf2OmH/sLMWUN2f/vgGHZcogJdoXYM8Azk+A/MD/A3NLqOIOSH0cwEVP/uBsysPXxnJwxq/FAHrgCnbNHPZfzsqnRW7ySDSniFx5FoZ9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704368; c=relaxed/simple;
	bh=MGebOf2ZTsHVy4jS8oM84QfLfmMX91odJp2sX88dlPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t82FNSso8YJzU02GIpOREBJrJwaNg+jaQVdY4jt7crpfbwhU+VO0zMtsbyYu6phPkAupHDmq/y0D5E/FntL3fr/05uDxUKPzE21SAYmudAFc32GkpBD8w6F4kn2v2nWgLVym/mZ1m499U98A/WPrrAMxZA8z9nJRNJMCHel+T4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZcGss0TWpz2TS96;
	Tue, 15 Apr 2025 16:05:04 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 2519D1400CB;
	Tue, 15 Apr 2025 16:05:11 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Apr 2025 16:05:10 +0800
Message-ID: <5ea1bdf0-677f-4187-a626-a08ccd2ae7e5@huawei.com>
Date: Tue, 15 Apr 2025 16:05:09 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: NFS/SELinux regression caused by commit fc2a169c56de ("sunrpc:
 clean cache_detail immediately when flush is written frequently")
To: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list
	<selinux@vger.kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>, yangerkun <yangerkun@huawei.com>
References: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <CAFqZXNtqPBMGUL8kvYoW2VzdrmcY1cx1+NL+LmOs0oxjfG5csA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi,
Thank you for reporting this issue and sharing the detailed reproducer.
Apologies for the gap in my knowledge regarding security_label.
Would need some time to study its implementation in the security subsystem.

To begin validating the problem, I attempted to run the reproducer on
Fedora 26(with kernel -- master 8ffd015db85f). However, I didn't observe
the reported mislabeling of the root directory.

The modifications introduced by commit fc2a169c56de specifically affect
scenarios where the /proc/net/rpc/xxx/flush interface is frequently
invoked within a 1-second window. During the reproducer execution, I
indeed observed repeated calls to this flush interface, though I'm
currently uncertain about its precise impact on the security_label
mechanism.
[  124.108016][ T2754] call write_flush
[  124.108878][ T2754] call write_flush
[  124.147886][ T2757] call write_flush
[  124.148604][ T2757] call write_flush
[  124.149258][ T2757] call write_flush
[  124.149911][ T2757] call write_flush

Once I have a solid understanding of the ​security_label mechanism, I will
conduct a more thorough analysis.

Best regards,
Li Lingfeng

在 2025/4/14 18:53, Ondrej Mosnacek 写道:
> Hello,
>
> I noticed that the selinux-testsuite
> (https://github.com/SELinuxProject/selinux-testsuite) nfs_filesystem
> test recently started to spuriously fail on latest mainline-based
> kernels (the root directory didn't have the expected SELinux label
> after a specific sequence of exports/unexports + mounts/unmounts).
>
> I bisected (and revert-tested) the regression to:
>
>      commit fc2a169c56de0860ea7599ea6f67ad5fc451bde1
>      Author: Li Lingfeng <lilingfeng3@huawei.com>
>      Date:   Fri Dec 27 16:33:53 2024 +0800
>
>         sunrpc: clean cache_detail immediately when flush is written frequently
>
> It's not immediately obvious to me what the bug is, so I'm posting
> this to relevant people/lists in the hope they can debug and fix this
> better than I could.
>
> I'm attaching a simplified reproducer. Note that it only tries 50
> iterations, but sometimes that's not enough to trigger the bug. It
> requires a system with SELinux enabled and probably a policy that is
> close enough to Fedora's. I tested it on Fedora Rawhide, but it should
> probably also work on other SELinux-enabled distros that use the
> upstream refpolicy.
>

