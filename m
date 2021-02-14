Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665A331AED3
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Feb 2021 04:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhBNDkQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Feb 2021 22:40:16 -0500
Received: from btbn.de ([5.9.118.179]:52564 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhBNDkP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 13 Feb 2021 22:40:15 -0500
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Feb 2021 22:40:14 EST
Received: from [IPv6:2001:16b8:64a9:df00:1919:ab25:6f81:b8e4] (200116b864a9df001919ab256f81b8e4.dip.versatel-1u1.de [IPv6:2001:16b8:64a9:df00:1919:ab25:6f81:b8e4])
        by btbn.de (Postfix) with ESMTPSA id 0EA3D11C62C;
        Sun, 14 Feb 2021 04:31:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1613273480;
        bh=gGdDHyBr690J6lMUdcn244aIllFpV/2H37cOhwF6h2k=;
        h=To:From:Subject:Date;
        b=e+nsjcb72kMcdz7ZAgG6lfyXfjxtb3bVcTeM8DLv4bwJuxYfWsEei1OnBBmNr7O2q
         oDxSdic132Mjw/JkNIIc7wTDam4/Rwz3SbGzKbccAbrlJfjQ56I6ZOs4KiUh2G8uWA
         rZBpJ4H1H8GiqiF0qA0i+7RqIfDO7i4FoLSiTxAzkwr67JDO38Zl8P6YTJEXhUHxRU
         klbkG1FgdTMjPhuxTTYnUk4hC0SzcITgSIWGnT4i8akY+Owdh4oCDUpIvVKOl+WGsD
         74zB23YWOa2TEQglrAMC9/8ubyfv9x1rTzWBVZPooGrMcV6fvBHfJcWpPq1uZQzgm/
         RaHd7W+sOUblQ==
To:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From:   Timo Rothenpieler <timo@rothenpieler.org>
Subject: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
Message-ID: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
Date:   Sun, 14 Feb 2021 04:31:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On our Fileserver, running a few weeks old 5.10, we are running into a 
weird issue with NFS 4.2 Server-Side Copy and RDMA (and ZFS, though I'm 
not sure how relevant that is to the issue).
The servers are connected via InfiniBand, on a Mellanox ConnectX-4 card, 
using the mlx5 driver.

Anything using the copy_file_range() syscall to copy stuff just hangs.
In strace, the syscall never returns.

Simple way to reproduce on the client:
 > xfs_io -fc "pwrite 0 1M" testfile
 > xfs_io -fc "copy_range testfile" testfile.copy

The second call just never exits. It sits in S+ state, with no CPU 
usage, and can easily be killed via Ctrl+C.
I let it sit for a couple hours as well, it does not seem to ever complete.

Some more observations about it:

If I do a fresh reboot of the client, the operation works fine for a 
short while (like, 10~15 minutes). No load is on the system during that 
time, it's effectively idle.

The operation actually does successfully copy all data. The size and 
checksum of the target file is as expected. It just never returns.

This only happens when mounting via RDMA. Mounting the same NFS share 
via plain TCP has the operation work reliably.

Had this issue with Kernel 5.4 already, and had hoped that 5.10 might 
have fixed it, but unfortunately it didn't.

I tried two server and 30 different client machines, they all exhibit 
the exact same behaviour. So I'd carefully rule out a hardware issue.


Any pointers on how to debug or maybe even fix this?



Thanks,
Timo
