Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CA023B91C
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 12:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgHDKwn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 06:52:43 -0400
Received: from btbn.de ([5.9.118.179]:40948 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729385AbgHDKwd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Aug 2020 06:52:33 -0400
Received: from [IPv6:2001:16b8:64d7:4500:fc3b:cfd2:151e:7636] (200116b864d74500fc3bcfd2151e7636.dip.versatel-1u1.de [IPv6:2001:16b8:64d7:4500:fc3b:cfd2:151e:7636])
        by btbn.de (Postfix) with ESMTPSA id B558D4BD30;
        Tue,  4 Aug 2020 12:52:30 +0200 (CEST)
Subject: Re: NFS over RDMA issues on Linux 5.4
To:     Leon Romanovsky <leon@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
 <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
 <20200804093635.GA4432@unreal>
From:   Timo Rothenpieler <timo@rothenpieler.org>
Message-ID: <92a5a932-b843-eed3-555e-7557ccc1f308@rothenpieler.org>
Date:   Tue, 4 Aug 2020 12:52:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804093635.GA4432@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 04.08.2020 11:36, Leon Romanovsky wrote:
> On Mon, Aug 03, 2020 at 12:24:21PM -0400, Chuck Lever wrote:
>> Hi Timo-
>>
>>> On Aug 3, 2020, at 11:05 AM, Timo Rothenpieler <timo@rothenpieler.org> wrote:
>>>
>>> Hello,
>>>
>>> I have just deployed a new system with Mellanox ConnectX-4 VPI EDR IB cards and wanted to setup NFS over RDMA on it.
>>>
>>> However, while mounting the FS over RDMA works fine, actually using it results in the following messages absolutely hammering dmesg on both client and server:
>>>
>>>> https://gist.github.com/BtbN/9582e597b6581f552fa15982b0285b80#file-server-log
>>>
>>> The spam only stops once I forcibly reboot the client. The filesystem gets nowhere during all this. The retrans counter in nfsstat just keeps going up, nothing actually gets done.
>>>
>>> This is on Linux 5.4.54, using nfs-utils 2.4.3.
>>> The mlx5 driver had enhanced-mode disabled in order to enable IPoIB connected mode with an MTU of 65520.
>>>
>>> Normal NFS 4.2 over tcp works perfectly fine on this setup, it's only when I mount via rdma that things go wrong.
>>>
>>> Is this an issue on my end, or did I run into a bug somewhere here?
>>> Any pointers, patches and solutions to test are welcome.
>>
>> I haven't seen that failure mode here, so best I can recommend is
>> keep investigating. I've copied linux-rdma in case they have any
>> advice.
> 
> The mentioning of IPoIB is a slightly confusing in the context of NFS-over-RDMA.
> Are you running NFS over IPoIB?

For all I'm aware, NFS over RDMA still needs an IP and port to be 
targeted to, so IPoIB is mandatory?
At least the admin guide in the kernel says so.

Right now I actually am running NFS over IPoIB (without RDMA), because 
of the issue at hand. And would like to turn on RDMA for enhanced 
performance.

>  From brief look on CQE error syndrome (local length error), the client sends wrong WQE.

Does that point at an issue in the kernel code, or something I did wrong?

The fstab entries for these mounts look like this:

10.110.10.200:/home /home nfs4 
rw,rdma,port=20049,noatime,async,vers=4.2,_netdev 0 0

Is there anything more I can investigate? I tried turning connected mode 
off and lowering the mtu in turn, but that did not have any effect.
