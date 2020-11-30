Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B775B2C8499
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 14:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgK3NBU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 08:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3NBU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 08:01:20 -0500
X-Greylist: delayed 404 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Nov 2020 05:00:40 PST
Received: from btbn.de (btbn.de [IPv6:2a01:4f8:162:63a9::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A8C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 05:00:40 -0800 (PST)
Received: from [IPv6:2001:16b8:64b8:ea00:8985:359a:bb0c:c985] (200116b864b8ea008985359abb0cc985.dip.versatel-1u1.de [IPv6:2001:16b8:64b8:ea00:8985:359a:bb0c:c985])
        by btbn.de (Postfix) with ESMTPSA id 7346624F8E2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 13:53:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1606740794;
        bh=xdOAhcHIrAC5Z4V3SSbuJ5eb+aN1NDRlRHBHueKdOyw=;
        h=To:From:Subject:Date;
        b=I7wE1c5xLfTYMhYl8znKhcGMjarJy49X1oNdnifrBqrkRJmZKZXJMvs4aBZ4skfXB
         VfzteAOrks9b0W4SIGdkK93P0BsyjiYpq6Jsv2ls7wDqHhS/D9QyoflWDvPUkOrj+x
         UWlRxW+fkfidt/qld+O+MvKecPinJp4CLwxTLWJxrFkX4JcThDvdmSxEWm63mndQjm
         Zj5DFgevHSe0fv/PcM1TFM1Bq7C9Smtrbc+gCd87gAyI9CtcSj/YdTw3G1QpywdTsW
         kAv7XpU+bot+eshxru7fuJtGAUWQQG3XMM2q3CtcYieQsi7JiKU9C3cl4vuxR8kH9D
         MJ/Xibwf5JrCA==
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From:   Timo Rothenpieler <timo@rothenpieler.org>
Subject: linux-5.4.80: "refcount_t: underflow; use-after-free" in
 rpc_async_schedule->rpc_free_task->nfs4_put_copy
Message-ID: <f310cd4d-c36e-ee14-2296-aa13b12cb438@rothenpieler.org>
Date:   Mon, 30 Nov 2020 13:53:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This has started happening quite recently, after some Kernel-Updates 
within the 5.4 stable series.

What seems to be triggering is an application (singularity doing a pull) 
on a (RDMA connected) NFS client calling copy_file_range().
Which gets infinitely stuck.

in dmesg on the server:

> [80245.802613] ------------[ cut here ]------------
> [80245.802653] refcount_t: underflow; use-after-free.
> [80245.802700] WARNING: CPU: 28 PID: 73131 at lib/refcount.c:190 refcount_sub_and_test_checked+0x55/0x60
> [80245.802749] Modules linked in: zfs(PO) zunicode(PO) zavl(PO) icp(PO) zlua(PO) zcommon(PO) znvpair(PO) spl(O)
> [80245.802810] CPU: 28 PID: 73131 Comm: kworker/u64:0 Tainted: P           O      5.4.80 #1
> [80245.802854] Hardware name: Supermicro AS -1014S-WTRT/H12SSW-NT, BIOS 1.1a 05/28/2020
> [80245.802900] Workqueue: rpciod rpc_async_schedule
> [80245.802928] RIP: 0010:refcount_sub_and_test_checked+0x55/0x60
> [80245.802960] Code: e0 41 5c c3 44 89 e0 41 5c c3 44 0f b6 25 97 d4 53 01 45 84 e4 75 e4 48 c7 c7 78 5c ce a4 c6 05 84 d4 53 01 01 e8 c9 ed ab ff <0f> 0b eb d0 0f 1f 80 00 00 00 00 48 89 fe bf 01 00 00 00 eb 96 66
> [80245.803059] RSP: 0018:ffffa28cc13f3dd8 EFLAGS: 00010286
> [80245.803089] RAX: 0000000000000000 RBX: 0000000000002a81 RCX: 0000000000000006
> [80245.803127] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8e228bf11a50
> [80245.803166] RBP: ffff8e20d4812000 R08: 0000000000000000 R09: 0000000000000873
> [80245.804042] R10: ffff8e227e48e820 R11: ffffffffa4ab3e40 R12: 0000000000000000
> [80245.804953] R13: ffff8e226556c930 R14: 0000000000000001 R15: 0000000000000000
> [80245.805821] FS:  0000000000000000(0000) GS:ffff8e228bf00000(0000) knlGS:0000000000000000
> [80245.806695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [80245.807540] CR2: 00007fed60557490 CR3: 0000003e45eae000 CR4: 00000000003406e0
> [80245.808430] Call Trace:
> [80245.809284]  nfs4_put_copy+0x15/0x30
> [80245.810157]  rpc_free_task+0x39/0x70
> [80245.811026]  __rpc_execute+0x354/0x370
> [80245.811918]  rpc_async_schedule+0x29/0x40
> [80245.812789]  process_one_work+0x1df/0x3a0
> [80245.813655]  worker_thread+0x4a/0x3c0
> [80245.814551]  kthread+0xfb/0x130
> [80245.815448]  ? process_one_work+0x3a0/0x3a0
> [80245.816332]  ? kthread_park+0x90/0x90
> [80245.817229]  ret_from_fork+0x22/0x40
> [80245.818138] ---[ end trace 41f9b2bba9f6f614 ]---

I don't know for sure if changes to the 5.4 kernel have triggered this, 
or changes in singularity which now make use of copy_file_range.
But restarting the nfs server, and then doing a "singularity pull" 
reliably triggers that dmesg message.

I found commit 49a361327332c9221438397059067f9b205f690d, but it seems 
related to the inter ssc stuff, which isn't even present in 5.4.

Any insights/help/fixes to backport would be highly appreciated.



Timo
