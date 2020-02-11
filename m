Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7451B15932D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2020 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgBKPcF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Feb 2020 10:32:05 -0500
Received: from foss.arm.com ([217.140.110.172]:47896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgBKPcF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Feb 2020 10:32:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F3FF30E;
        Tue, 11 Feb 2020 07:32:04 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99F5F3F68E;
        Tue, 11 Feb 2020 07:32:03 -0800 (PST)
Subject: Re: AMD IOMMU stops RDMA NFS from working since kernel 5.5 (bisected)
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Andre Tomt <andre@tomt.net>, Tom Murphy <tmurphy@arista.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
References: <7ee099af-e6bb-18fe-eb93-2a8abd401570@tomt.net>
 <20200211072537.GD23114@suse.de>
 <2CE039F4-3519-4481-B0E2-840D24EE4428@oracle.com>
 <ac758665-9127-9a52-4f03-49fecc5289a2@arm.com>
 <3507674A-F860-4B65-BD46-93431DD268AC@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <21c801a6-9a8b-1ebb-7e41-76e8385116ea@arm.com>
Date:   Tue, 11 Feb 2020 15:32:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3507674A-F860-4B65-BD46-93431DD268AC@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11/02/2020 3:24 pm, Chuck Lever wrote:
> 
> 
>> On Feb 11, 2020, at 10:12 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 11/02/2020 1:48 pm, Chuck Lever wrote:
>>> Andre-
>>> Thank you for the detailed report!
>>> Tom-
>>> There is a rich set of trace points available in the RPC/RDMA implementation in 5.4/5.5, fwiw.
>>> Please keep me in the loop, let me know if there is anything I can do to help.
>>
>> One aspect that may be worth checking is whether there's anywhere that assumes a successful return value from dma_map_sg() is always the same as the number of entries passed in - that's the most obvious way the iommu-dma code differs (legitimately) from the previous amd-iommu implementation.
> 
> net/sunrpc/xprtrdma/frwr_ops.c: frwr_map()
> 
> 317         mr->mr_nents =
> 318                 ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir);
> 319         if (!mr->mr_nents)
> 320                 goto out_dmamap_err;
> 
> Should that rather be "if (mr->mr_nents != i)" ?

No, that much is OK - the point is that dma_map_sg() may pack the DMA 
addresses such that sg_dma_len(sg) > sg->length - however, subsequently 
passing that mr->nents to dma_unmap_sg() in frwr_mr_recycle() (rather 
than the original value of i) looks at a glance like an example of how 
things may start to get out-of-whack.

Robin.

>>>> On Feb 11, 2020, at 2:25 AM, Joerg Roedel <jroedel@suse.de> wrote:
>>>>
>>>> Adding Tom's new email address.
>>>>
>>>> Tom, can you have a look, please?
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=206461 seems to be a similar
>>>> issue.
>>>>
>>>> On Tue, Feb 11, 2020 at 06:06:54AM +0100, Andre Tomt wrote:
>>>>> Since upgrading my RDMA lab from kernel 5.4.x to 5.5.x, NFSv4 over RDMA
>>>>> stopped working. But only on my AMD Ryzen systems. And so far only NFS,
>>>>> curiously other RDMA diagnostic tools (like qperf <ip> -cm1 rc_bw) work
>>>>> fine.
>>>>>
>>>>> A git bisect points to be62dbf554c5b50718a54a359372c148cd9975c7 iommu/amd:
>>>>> Convert AMD iommu driver to the dma-iommu api
>>>>>
>>>>> 5.5.3-rc1, 5.6-rc1 are also not working.
>>>>>
>>>>> I verified it by booting with amd_iommu=off on the kernel cmdline - it makes
>>>>> everything work again.
>>>>>
>>>>> The NFS config is a pretty simple NFSv4.x only, sec=sys setup, running over
>>>>> RoCEv1 on Mellanox mlx4 hardware (ConnectX-3 Pro, fw 2.42.5000). Nothing
>>>>> fancy besides the RoCEv1 and related bits network bits like PFC and storage
>>>>> VLAN. Bare metal, no virtualization.
>>>>>
>>>>> The impacted systems are:
>>>>> ASUS ROG STRIX X399-E GAMING, with a Threadripper 1950x, BIOS 1002
>>>>> ASUS Pro WS X570-ACE, with a Ryzen 7 3700x, BIOS 1201
>>>>>
>>>>> pcaps off a mirror port can be provided. They show that on 5.5.x, CM
>>>>> succeeds, and then a couple of NFS NULL calls comes through (over RoCE),
>>>>> both acked, and then the rest just never goes out from the client until the
>>>>> mount times out and CM is torn down.
>>>>>
>>>>> No messages shows up in the kernel log on either side. I was at least
>>>>> expecting some scary IOMMU warnings.
>>>>>
>>>>> More serious hardware is not available for RDMA testing currently, so I dont
>>>>> know if a EPYC system or newer mlx5 cards would have similar issues. Intel
>>>>> I've only tested as server so far, that worked fine, as expected given the
>>>>> bisect result.
>>>>>
>>>>>
>>>>>> git bisect start
>>>>>> # bad: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
>>>>>> git bisect bad d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
>>>>>> # good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
>>>>>> git bisect good 219d54332a09e8d8741c1e1982f5eae56099de85
>>>>>> # good: [8c39f71ee2019e77ee14f88b1321b2348db51820] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>>>>>> git bisect good 8c39f71ee2019e77ee14f88b1321b2348db51820
>>>>>> # bad: [76bb8b05960c3d1668e6bee7624ed886cbd135ba] Merge tag 'kbuild-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
>>>>>> git bisect bad 76bb8b05960c3d1668e6bee7624ed886cbd135ba
>>>>>> # good: [21b26d2679584c6a60e861aa3e5ca09a6bab0633] Merge tag '5.5-rc-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6
>>>>>> git bisect good 21b26d2679584c6a60e861aa3e5ca09a6bab0633
>>>>>> # good: [e5b3fc125d768eacd73bb4dc5019f0ce95635af4] Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>>> git bisect good e5b3fc125d768eacd73bb4dc5019f0ce95635af4
>>>>>> # bad: [937d6eefc716a9071f0e3bada19200de1bb9d048] Merge tag 'docs-5.5a' of git://git.lwn.net/linux
>>>>>> git bisect bad 937d6eefc716a9071f0e3bada19200de1bb9d048
>>>>>> # bad: [1daa56bcfd8b329447e0c1b1e91c3925d08489b7] Merge tag 'iommu-updates-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
>>>>>> git bisect bad 1daa56bcfd8b329447e0c1b1e91c3925d08489b7
>>>>>> # good: [937790699be9c8100e5358625e7dfa8b32bd33f2] mm/page_io.c: annotate refault stalls from swap_readpage
>>>>>> git bisect good 937790699be9c8100e5358625e7dfa8b32bd33f2
>>>>>> # good: [a5255bc31673c72e264d837cd13cd3085d72cb58] Merge tag 'dmaengine-5.5-rc1' of git://git.infradead.org/users/vkoul/slave-dma
>>>>>> git bisect good a5255bc31673c72e264d837cd13cd3085d72cb58
>>>>>> # good: [34d1b0895dbd10713c73615d8f532e78509e12d9] iommu/arm-smmu: Remove duplicate error message
>>>>>> git bisect good 34d1b0895dbd10713c73615d8f532e78509e12d9
>>>>>> # bad: [3c124435e8dd516df4b2fc983f4415386fd6edae] iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping
>>>>>> git bisect bad 3c124435e8dd516df4b2fc983f4415386fd6edae
>>>>>> # bad: [be62dbf554c5b50718a54a359372c148cd9975c7] iommu/amd: Convert AMD iommu driver to the dma-iommu api
>>>>>> git bisect bad be62dbf554c5b50718a54a359372c148cd9975c7
>>>>>> # good: [781ca2de89bae1b1d2c96df9ef33e9a324415995] iommu: Add gfp parameter to iommu_ops::map
>>>>>> git bisect good 781ca2de89bae1b1d2c96df9ef33e9a324415995
>>>>>> # good: [6e2350207f40e24884da262976f7fd4fba387e8a] iommu/dma-iommu: Use the dev->coherent_dma_mask
>>>>>> git bisect good 6e2350207f40e24884da262976f7fd4fba387e8a
>>>>>> # first bad commit: [be62dbf554c5b50718a54a359372c148cd9975c7] iommu/amd: Convert AMD iommu driver to the dma-iommu api
>>> --
>>> Chuck Lever
>>> _______________________________________________
>>> iommu mailing list
>>> iommu@lists.linux-foundation.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> --
> Chuck Lever
> 
> 
> 
