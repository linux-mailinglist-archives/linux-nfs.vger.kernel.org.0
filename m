Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A189C15895B
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2020 06:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgBKFMJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Feb 2020 00:12:09 -0500
Received: from mail1.ugh.no ([178.79.162.34]:43262 "EHLO mail1.ugh.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbgBKFMJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Feb 2020 00:12:09 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 00:12:07 EST
Received: from localhost (localhost [127.0.0.1])
        by mail1.ugh.no (Postfix) with ESMTP id 828AC24EA53;
        Tue, 11 Feb 2020 06:06:56 +0100 (CET)
Received: from mail1.ugh.no ([127.0.0.1])
        by localhost (catastrophix.ugh.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nklFG2JV6-TY; Tue, 11 Feb 2020 06:06:55 +0100 (CET)
Received: from [10.255.64.11] (unknown [185.176.245.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: andre@tomt.net)
        by mail.ugh.no (Postfix) with ESMTPSA id 5619224E025;
        Tue, 11 Feb 2020 06:06:55 +0100 (CET)
From:   Andre Tomt <andre@tomt.net>
To:     linux-nfs@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org
Subject: AMD IOMMU stops RDMA NFS from working since kernel 5.5 (bisected)
Message-ID: <7ee099af-e6bb-18fe-eb93-2a8abd401570@tomt.net>
Date:   Tue, 11 Feb 2020 06:06:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since upgrading my RDMA lab from kernel 5.4.x to 5.5.x, NFSv4 over RDMA 
stopped working. But only on my AMD Ryzen systems. And so far only NFS, 
curiously other RDMA diagnostic tools (like qperf <ip> -cm1 rc_bw) work 
fine.

A git bisect points to be62dbf554c5b50718a54a359372c148cd9975c7 
iommu/amd: Convert AMD iommu driver to the dma-iommu api

5.5.3-rc1, 5.6-rc1 are also not working.

I verified it by booting with amd_iommu=off on the kernel cmdline - it 
makes everything work again.

The NFS config is a pretty simple NFSv4.x only, sec=sys setup, running 
over RoCEv1 on Mellanox mlx4 hardware (ConnectX-3 Pro, fw 2.42.5000). 
Nothing fancy besides the RoCEv1 and related bits network bits like PFC 
and storage VLAN. Bare metal, no virtualization.

The impacted systems are:
ASUS ROG STRIX X399-E GAMING, with a Threadripper 1950x, BIOS 1002
ASUS Pro WS X570-ACE, with a Ryzen 7 3700x, BIOS 1201

pcaps off a mirror port can be provided. They show that on 5.5.x, CM 
succeeds, and then a couple of NFS NULL calls comes through (over RoCE), 
both acked, and then the rest just never goes out from the client until 
the mount times out and CM is torn down.

No messages shows up in the kernel log on either side. I was at least 
expecting some scary IOMMU warnings.

More serious hardware is not available for RDMA testing currently, so I 
dont know if a EPYC system or newer mlx5 cards would have similar 
issues. Intel I've only tested as server so far, that worked fine, as 
expected given the bisect result.


> git bisect start
> # bad: [d5226fa6dbae0569ee43ecfc08bdcd6770fc4755] Linux 5.5
> git bisect bad d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
> # good: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
> git bisect good 219d54332a09e8d8741c1e1982f5eae56099de85
> # good: [8c39f71ee2019e77ee14f88b1321b2348db51820] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> git bisect good 8c39f71ee2019e77ee14f88b1321b2348db51820
> # bad: [76bb8b05960c3d1668e6bee7624ed886cbd135ba] Merge tag 'kbuild-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> git bisect bad 76bb8b05960c3d1668e6bee7624ed886cbd135ba
> # good: [21b26d2679584c6a60e861aa3e5ca09a6bab0633] Merge tag '5.5-rc-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6
> git bisect good 21b26d2679584c6a60e861aa3e5ca09a6bab0633
> # good: [e5b3fc125d768eacd73bb4dc5019f0ce95635af4] Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good e5b3fc125d768eacd73bb4dc5019f0ce95635af4
> # bad: [937d6eefc716a9071f0e3bada19200de1bb9d048] Merge tag 'docs-5.5a' of git://git.lwn.net/linux
> git bisect bad 937d6eefc716a9071f0e3bada19200de1bb9d048
> # bad: [1daa56bcfd8b329447e0c1b1e91c3925d08489b7] Merge tag 'iommu-updates-v5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
> git bisect bad 1daa56bcfd8b329447e0c1b1e91c3925d08489b7
> # good: [937790699be9c8100e5358625e7dfa8b32bd33f2] mm/page_io.c: annotate refault stalls from swap_readpage
> git bisect good 937790699be9c8100e5358625e7dfa8b32bd33f2
> # good: [a5255bc31673c72e264d837cd13cd3085d72cb58] Merge tag 'dmaengine-5.5-rc1' of git://git.infradead.org/users/vkoul/slave-dma
> git bisect good a5255bc31673c72e264d837cd13cd3085d72cb58
> # good: [34d1b0895dbd10713c73615d8f532e78509e12d9] iommu/arm-smmu: Remove duplicate error message
> git bisect good 34d1b0895dbd10713c73615d8f532e78509e12d9
> # bad: [3c124435e8dd516df4b2fc983f4415386fd6edae] iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping
> git bisect bad 3c124435e8dd516df4b2fc983f4415386fd6edae
> # bad: [be62dbf554c5b50718a54a359372c148cd9975c7] iommu/amd: Convert AMD iommu driver to the dma-iommu api
> git bisect bad be62dbf554c5b50718a54a359372c148cd9975c7
> # good: [781ca2de89bae1b1d2c96df9ef33e9a324415995] iommu: Add gfp parameter to iommu_ops::map
> git bisect good 781ca2de89bae1b1d2c96df9ef33e9a324415995
> # good: [6e2350207f40e24884da262976f7fd4fba387e8a] iommu/dma-iommu: Use the dev->coherent_dma_mask
> git bisect good 6e2350207f40e24884da262976f7fd4fba387e8a
> # first bad commit: [be62dbf554c5b50718a54a359372c148cd9975c7] iommu/amd: Convert AMD iommu driver to the dma-iommu api
