Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1C41DBBDE
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 19:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgETRr2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 13:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRr2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 May 2020 13:47:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6952C061A0E
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 10:47:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g12so2854170wrw.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 May 2020 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=c0beAKyQmRVTVKU7s0kSBMSL/mr7Tu2mxCscmG+TQJ0=;
        b=YliE8jultGE1jgEltjaWEd8WFEwAZj5J1VmBTInA3R7mjQuJ7bz43Mdn8oIuW3GmE7
         uZ2FC4QiqiB718iwosypeZRYMY2d26lbHfDK6+uR0FsMZ9DGbJKODuh+f+t1CCZruyLF
         U5lczJmE/5hInyCZ/h9eIew9gGEh0hWRf+KSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=c0beAKyQmRVTVKU7s0kSBMSL/mr7Tu2mxCscmG+TQJ0=;
        b=q2J4Jbe0rB9Y1jSYcXFvmB4fI68tdr1li45KqVPW8jV4+DCtAKaqCiQgtgzFlcvC0t
         rpo5jL/RV5y06svRQINXg1FGlZlyG+d90gdpQQaqf6ozQQn3K640WkohrYTsMt0Co2y0
         id1jxBdL0PFZSmffsTY2UBdGZtu7y4buW+BsTPq2TX1SBjF806gqCG7OacSO64bgApeX
         lyK7D6ib2gaK/wPendkHWVrjrg0fMmOQzjzmYAf1uxW/D6X3lXJtIWmJsFZ1YG5CSf4v
         4GUueKtMBFZJXlBHGkBGWGsDMygx8ugxXT4m4lu68DdGDcuKFPobaI92xqrB8c8yFyq9
         KZ5w==
X-Gm-Message-State: AOAM533bVE0wHOxFt3C8RyZGkJ/rtoJCVldY6p/RFspkpMNheT06frk2
        U5YmiFNqQmdozFK1yDapJD3GoVsYonw=
X-Google-Smtp-Source: ABdhPJzSzgJ97XWEoW6z/bivPxepAcXk3tcGZbFPkqgKBPt0IbnNjXFKXHcG/638edo3ISARZGhlSw==
X-Received: by 2002:a5d:51cb:: with SMTP id n11mr4936648wrv.236.1589996845988;
        Wed, 20 May 2020 10:47:25 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id z7sm3566253wrl.88.2020.05.20.10.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:47:25 -0700 (PDT)
Message-ID: <09ad6e031e64820f2efd7495d7467e2bb8b51fc5.camel@linuxfoundation.org>
Subject: TEST_STATEID issues with NFS4.1 and FreeNAS server
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     linux-nfs@vger.kernel.org
Cc:     Michael Halstead <mhalstead@linuxfoundation.org>
Date:   Wed, 20 May 2020 18:47:24 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

We have a cluster of machines where we're observing file accesses
hanging over NFS. The clients showing the problems are Fedora and SUSE
distros with the 5.6.11 kernel, e.g.:

Linux version 5.6.11-1-default (geeko@buildhost) (gcc version 9.3.1 20200406 
[revision 6db837a5288ee3ca5ec504fbd5a765817e556ac2] (SUSE Linux)) 
#1 SMP Wed May 6 10:42:09 UTC 2020 (91c024a)

In the example below we see a git clone hang, its having trouble
reading a .pack file off the NFS share, the git process is in D state.
I've included part of dmesg below with sysrq-w output.

Mount options:

rw,relatime,vers=4.1,rsize=131072,wsize=131072,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,local_lock=none

mountstats shows:
 
READ:
	632014263 ops (62%) 	629809108 errors (99%) 
TEST_STATEID:
 	363257078 ops (36%) 	363257078 errors (100%)

which is a clue on what is happening. I grabbed some data with tcpdump
and it shows the READ getting NFS4ERR_BAD_STATEID, there is then a
TEST_STATEID which gets NFS4ERR_NOTSUPP. This repeats infinitely in a
loop.

The server is FreeNAS11.3 which does not have:
https://github.com/HardenedBSD/hardenedBSD-stable/commit/63f6f19b0756b18f2e68d82cbe037f21f9a8c500
applied so it will return NFS4ERR_NOTSUPP to TEST_STATEID.

I think something may be needed to stop Linux getting into an infinite
loop with this, regardless of whether the spec says TEST_STATEID can
get a NFS4ERR_NOTSUPP or not?

I freely admit I know little about much of this so I'm open to
pointers. If we did remount as 4.0 we probably wouldn't see the issue
as it would avoid the TEST_STATEID code.

Cheers,

Richard

[249239.124271] NFS: nfs4_reclaim_open_state: unhandled error -524
[249239.124722] NFSv4: state recovery failed for open file git2/github.com.rpm-software-management.dnf.git.lock, error = -524
[249239.124723] NFSv4: state recovery failed for open file git2/github.com.rpm-software-management.dnf.git.lock, error = -524
[249239.124724] NFSv4: state recovery failed for open file git2/github.com.rpm-software-management.dnf.git.lock, error = -524
[249244.947749] NFS: __nfs4_reclaim_open_state: Lock reclaim failed!
[249244.964169] NFS: nfs4_reclaim_open_state: unhandled error -524
[249244.964646] NFSv4: state recovery failed for open file git2/github.com.rpm-software-management.dnf.git.lock, error = -524
[249244.964648] NFSv4: state recovery failed for open file git2/github.com.rpm-software-management.dnf.git.lock, error = -524
[376912.912171] NFS: __nfs4_reclaim_open_state: Lock reclaim failed!
[376913.215654] NFS: __nfs4_reclaim_open_state: Lock reclaim failed!
[408558.690581] sysrq: Show Blocked State
[408558.690630]   task                        PC stack   pid father
[408558.692490] git             D    0 41178  41159 0x00000004
[408558.692494] Call Trace:
[408558.692506]  ? __schedule+0x2d8/0x760
[408558.692512]  ? blk_finish_plug+0x21/0x2e
[408558.692516]  ? read_pages+0x87/0x1a0
[408558.692519]  schedule+0x4a/0xb0
[408558.692522]  io_schedule+0x12/0x40
[408558.692528]  __lock_page_killable+0x131/0x250
[408558.692532]  ? file_fdatawait_range+0x20/0x20
[408558.692536]  filemap_fault+0x69e/0x9d0
[408558.692540]  ? alloc_set_pte+0x118/0x660
[408558.692546]  ? __alloc_pages_nodemask+0x166/0x300
[408558.692552]  ? xas_load+0x9/0x80
[408558.692556]  ? xas_find+0x177/0x1c0
[408558.692559]  ? filemap_map_pages+0x8b/0x380
[408558.692562]  __do_fault+0x36/0xd0
[408558.692565]  do_fault+0x246/0x520
[408558.692569]  __handle_mm_fault+0x5d5/0x820
[408558.692573]  handle_mm_fault+0xc4/0x1f0
[408558.692579]  do_user_addr_fault+0x1f9/0x450
[408558.692585]  page_fault+0x3e/0x50
[408558.692589] RIP: 0033:0x561301328dd1
[408558.692596] Code: Bad RIP value.
[408558.692597] RSP: 002b:00007fff69c81e10 EFLAGS: 00010202
[408558.692600] RAX: 00007fc2165118a2 RBX: 00007fff69c81ec8 RCX: 00007fff69c81ec0
[408558.692601] RDX: 00007fff69c81e2c RSI: 00000000001bd2a9 RDI: 00007fc2165118a2
[408558.692602] RBP: 0000561303310ab0 R08: 000000000014e8a2 R09: 0000000000000075
[408558.692604] R10: 00005613014843e0 R11: 0000000000000004 R12: 00007fff69c81ec0
[408558.692605] R13: 0000000000000040 R14: 00007fff69c81f00 R15: 00007fff69c81ed0

