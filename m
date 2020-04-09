Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D861A38BF
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2020 19:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgDIRPK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Apr 2020 13:15:10 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:37450 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgDIRPK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Apr 2020 13:15:10 -0400
Received: by mail-wm1-f47.google.com with SMTP id z6so542098wml.2
        for <linux-nfs@vger.kernel.org>; Thu, 09 Apr 2020 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=dYMuIM09uSuDMlVyCFWa0MtpmIVWKeNHzL28I446tas=;
        b=ga281Dmep7ZR/RGs1PzwPrAIs71os3f2/mhZpnY7D90YKtNBJKKW8gn+2hCELbWF1F
         3ReHwqFv5pzhoXSI91JlsclsyZFATRLsYDZoqAH6lXJZBdKYoA8ffbrvVhxNLR4WaOAL
         Sx3peGJD7jNgIpEEnmWhfSo6wF2h4Ux7dMCymljea41KguPOhWSXbHJp9EYz7SAWilfi
         CwcLPwLoz+K6gekVc/parYa+x4zMJNATNRoL0y6/LL7GBMOTAeVaNTISKNVYKVUs53St
         EMXslvnJoMj9SrCWYxOWP5WTqdkhpzDNvKHv0GuuGdUbaBmuiLo/IL66V180qmIfWvtm
         hz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dYMuIM09uSuDMlVyCFWa0MtpmIVWKeNHzL28I446tas=;
        b=Y9CSPNxeWDMv9x3ynTwW0tV/yDm8kGJj3TRNuSpmb0TApavahaDuyLjpqG/TYXc1bR
         MPsgFyF5WoWul+Nnp0qdlrJLKkQMjSYyvtQFyFEh+lsKpslxWWVTD50HubTL4QpK2Xxh
         feQlZiP/nLKT98xGvECJe7/ry40ZOVdQGvZatj6dmoiz84zyInV2O8G/HCPMKT030h2z
         sKwDfriQ0ANTo0/XmGnRFW0IS2RQLfxLWemcUIiiDnXtiJCUfzZj1HmTDz+kUJSwXp6T
         kG6xydY0Dxy3+DplRiIk2ypZGL7XAr1nHCfxHx9oQCeP8Z0wnlhmneQr76V5Njg2EE9N
         DXKg==
X-Gm-Message-State: AGi0PuajkA4x7mh6bjrp9RMq4n+pPBgXn4crZBYhZ93aGRD7Mbhf/xQO
        3Hdp7T0igwhxRA8zqNljOJKMmL+9oYofcWGVK9Ayl3t3
X-Google-Smtp-Source: APiQypIxQF3LKh930/H6qIrASCy9o1rvhE7PRdO0tIKtplbBUxkaXYLnFNQTMQO5cUMwTqrO3v7/7A3QRNMoU2ul3NI=
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr864852wmn.46.1586452509017;
 Thu, 09 Apr 2020 10:15:09 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 9 Apr 2020 13:14:58 -0400
Message-ID: <CAN-5tyE4w3LPx8oy=e=S+shq8w74iRGD-0Aktd0DtzGk8KkkJA@mail.gmail.com>
Subject: VFS rename hang
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

This is a rename on an NFS mount but the stack trace is not in NFS,
but I'm curious if any body ran into this. Thanks.

Apr  7 13:34:53 scspr1865142002 kernel:      Not tainted 5.5.7 #1
Apr  7 13:34:53 scspr1865142002 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr  7 13:34:53 scspr1865142002 kernel: dt              D    0 24788
24323 0x00000080
Apr  7 13:34:53 scspr1865142002 kernel: Call Trace:
Apr  7 13:34:53 scspr1865142002 kernel: ? __schedule+0x2ca/0x6e0
Apr  7 13:34:53 scspr1865142002 kernel: schedule+0x4a/0xb0
Apr  7 13:34:53 scspr1865142002 kernel: schedule_preempt_disabled+0xa/0x10
Apr  7 13:34:53 scspr1865142002 kernel: __mutex_lock.isra.11+0x233/0x4e0
Apr  7 13:34:53 scspr1865142002 kernel: ? strncpy_from_user+0x47/0x160
Apr  7 13:34:53 scspr1865142002 kernel: lock_rename+0x28/0xd0
Apr  7 13:34:53 scspr1865142002 kernel: do_renameat2+0x1e7/0x4f0
Apr  7 13:34:53 scspr1865142002 kernel: __x64_sys_rename+0x1c/0x20
Apr  7 13:34:53 scspr1865142002 kernel: do_syscall_64+0x5b/0x200
Apr  7 13:34:53 scspr1865142002 kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Apr  7 13:34:53 scspr1865142002 kernel: RIP: 0033:0x7f747a10ac77
Apr  7 13:34:53 scspr1865142002 kernel: Code: Bad RIP value.
Apr  7 13:34:53 scspr1865142002 kernel: RSP: 002b:00007f7479f92948
EFLAGS: 00000206 ORIG_RAX: 0000000000000052
Apr  7 13:34:53 scspr1865142002 kernel: RAX: ffffffffffffffda RBX:
00000000023604c0 RCX: 00007f747a10ac77
Apr  7 13:34:53 scspr1865142002 kernel: RDX: 0000000000000000 RSI:
00007f7479f94a80 RDI: 00007f7479f96b80
Apr  7 13:34:53 scspr1865142002 kernel: RBP: 0000000000000005 R08:
00007f7479f9d700 R09: 00007f7479f9d700
Apr  7 13:34:53 scspr1865142002 kernel: R10: 645f72656464616c R11:
0000000000000206 R12: 0000000000000001
Apr  7 13:34:53 scspr1865142002 kernel: R13: 00007f7479f98c80 R14:
00007f7479f9ad80 R15: 00007f7479f94a80
