Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BF31AF78A
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2020 08:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSGWs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 02:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSGWs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 02:22:48 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3DCC061A0C;
        Sat, 18 Apr 2020 23:22:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u6so6406268ljl.6;
        Sat, 18 Apr 2020 23:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IzTtIFRjYXveQaOsap7Ahk5ZI4rl9Tq5J8b2Kvm4YXI=;
        b=DkrhN0oztnt/6TlHZBaZWxItG3iTHrKv+3OY50mbu4fdcWCDR85VXaNG6gdhmXmNMT
         W5Xxpbp9QtG7MvXH5AFoGqsefik9MG6q6ZsHaEJjKL71W88o/RNOFIUkc4a2W6q/gVaM
         Xu5W1Fp8VhojFInwbd04DMztBE0F5n/jJImjmrmtgBkGPw+qFNB32WmTKEAXnA01z3sy
         Hc8hsUAzbNMhwUeo3ohZK57b9VA9ujJMySuNYBw85dLLljB+fVFj0HEiV3/Ytn/2jA34
         PrJj1wcBJ3xeuWwjNlzfIa5Yd3/Lxcbd5YHxMZlL45Fj/CXsNe9uGQpZzI17ulqZgnUJ
         sfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IzTtIFRjYXveQaOsap7Ahk5ZI4rl9Tq5J8b2Kvm4YXI=;
        b=pQPg5o3WZjmsGzONEOzWli0O00vQwnFfpBeHkh37zbNSA2o6mfeKy20+0yNvtDwdPj
         VpCoJluj1+dYELmb8iYBhVJDqNiKvlwKB/C5RO7X7ajGPXDDzaMbadTnZWGU3i3+32pc
         Lbhck+pjjNFf4RfbYDnckUxYphssx5iSyvRv85zpDIURuD+kcOjcOkS/9iHOrQIld+Di
         mFJ7xt6K6MYYUV5GXQqoSBrjQ2RqMU0ryI64J3ppWs0sx3om6NK/nUrNZ7oU/9r9CNM5
         7Y9u3hNoAOwhSD20hy5vocWCQTLxOPfyav+HabHcCDkVuAHKhUiWTOMmECB1BMwKq5//
         rGsg==
X-Gm-Message-State: AGi0PuZZbNT6QVGXd+6xV2H41QPy8nMVaiNyYOPfUPopTDbJ0Mt9Xfa7
        1kPGod+p63kRpt53lM1DEVErLBQ/uJsAwBN8GGeLVfE+
X-Google-Smtp-Source: APiQypIpY3aUAzHUQfQLx2jI0YLTTDEpw59oWaAaUqF68KrTWhsXeiTiQmgKQhJGx86x0bo3AGFsTKMaBIRQ6QS+v9U=
X-Received: by 2002:a2e:9616:: with SMTP id v22mr6182921ljh.107.1587277365815;
 Sat, 18 Apr 2020 23:22:45 -0700 (PDT)
MIME-Version: 1.0
From:   Sun Ted <xulinsun@gmail.com>
Date:   Sun, 19 Apr 2020 14:22:34 +0800
Message-ID: <CACiNFG4y9T8tjcpypyfFfOgPjRkc++rNhn85iuuWARA7dXemJA@mail.gmail.com>
Subject: net/sunrpc Bug ? Unable to handle kernel NULL pointer dereference at
 virtual address 0000000000000000 on kernel 5.2.37
To:     linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        xulin sun <xulinsun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Forks,

On the kernel version 5.2.37 or a bit earlier, running pressure
testing with module insert & remove, actually the inserted module is
not special and could be anyone.
After dozens of testing, there will be throw below call trace and the
system hung.

Testing script for insert & remove module like below:
             for each in {1..100} ; do echo "$each" ; insmod
openvswitch.ko ;  rmmod  openvswitch.ko ; usleep 100000 ; done
The target machine is: arm64, cortex a53.

Disassembled the line " __wake_up_common_lock+0x98/0xe0 ", it located
the code "include/linux/spinlock.h" , it should be using the NULL
pointer "lock->rlock "

static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
unsigned long flags)
{
        raw_spin_unlock_irqrestore(&lock->rlock, flags);

Did you ever see this issue or have a fix for this based on kernel
5.2.37 version?

Call trace:
openvswitch: Open vSwitch switching datapath
Unable to handle kernel NULL pointer dereference at virtual address
0000000000000000
Mem abort info:
  ESR = 0x86000005
  Exception class = IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
user pgtable: 4k pages, 39-bit VAs, pgdp=00000008f2ea9000
[0000000000000000] pgd=0000000000000000, pud=0000000000000000
Internal error: Oops: 86000005 [#1] PREEMPT SMP
Modules linked in: openvswitch hse sch_fq_codel nsh nf_conncount
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 [last unloaded:
openvswitch]
CPU: 2 PID: 209 Comm: kworker/u9:3 Not tainted 5.2.37-yocto-standard #1
Hardware name: Freescale S32G275 (DT)
Workqueue: xprtiod xs_stream_data_receive_workfn
pstate: 80000085 (Nzcv daIf -PAN -UAO)
pc : 0x0
lr : __wake_up_common+0x90/0x150
sp : ffffff801146ba60
x29: ffffff801146ba60 x28: ffffff8010d36000
x27: ffffff801146bb90 x26: 0000000000000000
x25: 0000000000000003 x24: 0000000000000000
x23: 0000000000000001 x22: ffffff801146bb00
x21: ffffff8010d351e8 x20: 0000000000000000
x19: ffffff80112c37a0 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000000 x14: 0000000000000000
x13: 0000003002000000 x12: 0000902802000000
x11: 0000000000000000 x10: 000001000000ed01
x9 : 0000010000000000 x8 : 9b5e0000000048a6
x7 : 0000000000000068 x6 : ffffff80112c37a0
x5 : 0000000000000000 x4 : ffffff801146bb90
x3 : ffffff801146bb90 x2 : 0000000000000000
x1 : 0000000000000003 x0 : ffffff80112c37a0
Call trace:
 0x0
 __wake_up_common_lock+0x98/0xe0
 __wake_up+0x40/0x50
 wake_up_bit+0x8c/0xb8
 rpc_make_runnable+0xc8/0xd0
 rpc_wake_up_task_on_wq_queue_action_locked+0x110/0x278
 rpc_wake_up_queued_task.part.0+0x40/0x58
 rpc_wake_up_queued_task+0x38/0x48
 xprt_complete_rqst+0x68/0x128
 xs_read_stream.constprop.0+0x2ec/0x3d0
 xs_stream_data_receive_workfn+0x60/0x190
 process_one_work+0x1bc/0x440
 worker_thread+0x50/0x408
 kthread+0x104/0x130
 ret_from_fork+0x10/0x1c
Code: bad PC value
Kernel panic - not syncing: Fatal exception in interrupt
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x0002,2000200c
Memory Limit: none

Thanks
Xulin
