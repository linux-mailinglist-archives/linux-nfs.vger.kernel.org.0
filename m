Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A5A358CA
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2019 10:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFEIlI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jun 2019 04:41:08 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13934 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFEIlI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jun 2019 04:41:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf780210006>; Wed, 05 Jun 2019 01:41:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 05 Jun 2019 01:41:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 05 Jun 2019 01:41:07 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Jun
 2019 08:40:32 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: [REGRESSION v5.2-rc] SUNRPC: Declare RPC timers as TIMER_DEFERRABLE
 (431235818bc3)
Message-ID: <c54db63b-0d5d-2012-162a-cb08cf32245a@nvidia.com>
Date:   Wed, 5 Jun 2019 09:40:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559724065; bh=AIuJqCcqbmoKjuvUB+D3xWpbfEEAbUrVWqGYxh7A6ug=;
        h=X-PGP-Universal:To:CC:From:Subject:Message-ID:Date:User-Agent:
         MIME-Version:X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Language:Content-Transfer-Encoding;
        b=UOPqHF5IysgiyQWNntAV8ouXo9RL/4MxkYeGphb3Uuxog9u4/ETf0mRoZK8IvhFUh
         9p9NCWJJVHhLJYNdRMNP5b58cf3yFtLlJLMSoTv8QOUXkFuRdv1jpc8OkIoYYkP64a
         fp1hrDV5IeXvEFiymGAnlsXQYjo4bwCMIjj/l3IJAdwhH5M2VtYMFHN5MlyJHrdc2F
         dpGraaIyGuyZdhX61O960e9ElAX7lvtjvU+lhrLuwCbjiTbUpAC08W4+ZxAR0axe1+
         oeUEV6C/9gorHMK2hJ1JAGc4P+Jj3bWx3ZkDYnP9J0eEjCIIuijUYe2ETlaK/tYps9
         dTL2EVvnyeL4w==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I have been noticing intermittent failures with a system suspend test on
some of our machines that have a NFS mounted root file-system. Bisecting
this issue points to your commit 431235818bc3 ("SUNRPC: Declare RPC
timers as TIMER_DEFERRABLE") and reverting this on top of v5.2-rc3 does
appear to resolve the problem.

The cause of the suspend failure appears to be a long delay observed
sometimes when resuming from suspend, and this is causing our test to
timeout. For example, in a failing case I see something like the
following ...

[   69.667385] PM: suspend entry (deep)

[   69.675642] Filesystems sync: 0.000 seconds

[   69.684983] Freezing user space processes ... (elapsed 0.001 seconds) done.

[   69.697880] OOM killer disabled.

[   69.705670] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.

[   69.719043] printk: Suspending console(s) (use no_console_suspend to debug)

[   69.758911] Disabling non-boot CPUs ...

[   69.761875] IRQ 17: no longer affine to CPU3

[   69.762609] Entering suspend state LP1

[   69.762636] Enabling non-boot CPUs ...

[   69.763600] CPU1 is up

[   69.764517] CPU2 is up

[   69.765532] CPU3 is up

[   69.845832] mmc1: queuing unknown CIS tuple 0x80 (50 bytes)

[   69.854223] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)

[   69.857238] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)

[   69.892700] mmc1: queuing unknown CIS tuple 0x02 (1 bytes)

[   70.407286] OOM killer enabled.

[   70.414674] Restarting tasks ... done.

[   70.423232] PM: suspend exit

[   73.533252] asix 1-1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xCDE1

[  105.461852] nfs: server 192.168.99.1 not responding, still trying

[  105.462347] nfs: server 192.168.99.1 not responding, still trying

[  105.484809] nfs: server 192.168.99.1 OK

[  105.486454] nfs: server 192.168.99.1 OK


So it would appear that making these timers deferrable is having an impact
when resuming from suspend. Do you have any thoughts on this?

Thanks
Jon
