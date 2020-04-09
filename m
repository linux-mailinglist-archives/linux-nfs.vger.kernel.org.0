Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2131A3B2E
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2020 22:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgDIUPf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Apr 2020 16:15:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46870 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgDIUPf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Apr 2020 16:15:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id f13so6888141wrm.13
        for <linux-nfs@vger.kernel.org>; Thu, 09 Apr 2020 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVq3itUlAiBm4NAYXG61zLXuwOWBuRo1pSKnKCYUgJU=;
        b=c2KnbvOiIP+hHB3lvLihVHGPPDgbY8Tsq/8lUY6Pf+A5pY7BpaRDyIsHHD1G03ivWS
         hzjzH8F9kScJ1JRywqFbXwTT680cXJRyPbcptMnF6xRnwK7x9qyn+pZefgEcFZd9twvm
         wUch3fpbwTH2XYb5EuanihBOTg/M1X+Ci8MMnB4ujJyHdA9iLShdwULbwMKvwqjPFkGt
         q6sbi4Yzg/vCsyrIRe+iPXfUCTPbDrV6pSncziSe7v+4LUf92wXA7IXIgfrcVex/ooXi
         5mBo6kCojQGIiY7h9B1fX8wzUXA/7rlRW5eqsUT5lsFWuvVsj6RUcxeRYsOqopGv8KUv
         6WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVq3itUlAiBm4NAYXG61zLXuwOWBuRo1pSKnKCYUgJU=;
        b=hjIVK3cGYVJgtrFq+wOzYgXy/agOMJTH9EPJiGmpDRSvsnxunhOTqGN1TPEJ2VGXyK
         I5Gq4V8uAYX40YWjLxR4cCeuHC+kRu7NY637nNl83ICltSMXxkjNO/eiYonmlIs/ZC79
         34CfIdKxvQpGm7z1E5RZHpSGOKKYCgVST9zBwvwVUf0P0QTGBpRqEUt7X69mXnXSiFye
         GEHwmBJUDHjNracKrFu6jIS8EQkdFH3jmm6dYEz+3zBmR31Crm3gPdWuScYkkTCZb01q
         B3Atg2Gea2RO388ydUe6vzNH5aRl8ss1NPMf/YANmWJcsybMZg5hzpRZA2AjGZHPHtQ/
         +NDA==
X-Gm-Message-State: AGi0PuaJv21+Jv6gupixASvZVUrvy05+p5q41tvUqPvFi0UYBfVf+zaV
        CaWJCmnBVAUVSH0SPEO+aOazCKxfvVMDi/JZ+/+9Qw==
X-Google-Smtp-Source: APiQypJtfuebJjuo1ActDjy7NeT5nf4FNg14cx4OR6qUtIY2j3RojzGQJJ+uqHtadAiaZ1fRi0sgcjssD64sCt5AX00=
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr933362wrp.403.1586463332128;
 Thu, 09 Apr 2020 13:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyE4w3LPx8oy=e=S+shq8w74iRGD-0Aktd0DtzGk8KkkJA@mail.gmail.com>
 <8be4b4e465f01f66f96c2308c833cbf95546e2cb.camel@hammerspace.com>
In-Reply-To: <8be4b4e465f01f66f96c2308c833cbf95546e2cb.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 9 Apr 2020 16:15:20 -0400
Message-ID: <CAN-5tyE+s-iY=pqdUD6CVXCytYJiax3upCm=B_BM9iDUiiMGrg@mail.gmail.com>
Subject: Re: VFS rename hang
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Thu, Apr 9, 2020 at 3:16 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Hi Olga,
>
> On Thu, 2020-04-09 at 13:14 -0400, Olga Kornievskaia wrote:
> > Hi folks,
> >
> > This is a rename on an NFS mount but the stack trace is not in NFS,
> > but I'm curious if any body ran into this. Thanks.
> >
> > Apr  7 13:34:53 scspr1865142002 kernel:      Not tainted 5.5.7 #1
> > Apr  7 13:34:53 scspr1865142002 kernel: "echo 0 >
> > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > Apr  7 13:34:53 scspr1865142002 kernel: dt              D    0 24788
> > 24323 0x00000080
> > Apr  7 13:34:53 scspr1865142002 kernel: Call Trace:
> > Apr  7 13:34:53 scspr1865142002 kernel: ? __schedule+0x2ca/0x6e0
> > Apr  7 13:34:53 scspr1865142002 kernel: schedule+0x4a/0xb0
> > Apr  7 13:34:53 scspr1865142002 kernel:
> > schedule_preempt_disabled+0xa/0x10
> > Apr  7 13:34:53 scspr1865142002 kernel:
> > __mutex_lock.isra.11+0x233/0x4e0
> > Apr  7 13:34:53 scspr1865142002 kernel: ?
> > strncpy_from_user+0x47/0x160
> > Apr  7 13:34:53 scspr1865142002 kernel: lock_rename+0x28/0xd0
> > Apr  7 13:34:53 scspr1865142002 kernel: do_renameat2+0x1e7/0x4f0
> > Apr  7 13:34:53 scspr1865142002 kernel: __x64_sys_rename+0x1c/0x20
> > Apr  7 13:34:53 scspr1865142002 kernel: do_syscall_64+0x5b/0x200
> > Apr  7 13:34:53 scspr1865142002 kernel:
> > entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > Apr  7 13:34:53 scspr1865142002 kernel: RIP: 0033:0x7f747a10ac77
> > Apr  7 13:34:53 scspr1865142002 kernel: Code: Bad RIP value.
> > Apr  7 13:34:53 scspr1865142002 kernel: RSP: 002b:00007f7479f92948
> > EFLAGS: 00000206 ORIG_RAX: 0000000000000052
> > Apr  7 13:34:53 scspr1865142002 kernel: RAX: ffffffffffffffda RBX:
> > 00000000023604c0 RCX: 00007f747a10ac77
> > Apr  7 13:34:53 scspr1865142002 kernel: RDX: 0000000000000000 RSI:
> > 00007f7479f94a80 RDI: 00007f7479f96b80
> > Apr  7 13:34:53 scspr1865142002 kernel: RBP: 0000000000000005 R08:
> > 00007f7479f9d700 R09: 00007f7479f9d700
> > Apr  7 13:34:53 scspr1865142002 kernel: R10: 645f72656464616c R11:
> > 0000000000000206 R12: 0000000000000001
> > Apr  7 13:34:53 scspr1865142002 kernel: R13: 00007f7479f98c80 R14:
> > 00007f7479f9ad80 R15: 00007f7479f94a80
>
> It looks like the rename locking (i.e. taking the inode mutex on the
> source and target directory) is hung. That likely indicates that
> something else is leaking or holding onto one or more of the directory
> mutexes. Is some other thread/process perhaps also hung on the same
> directory?

Thanks for the reply. I see several hung application processes with
the same stack. Question now is there some NFS rename that's maybe
hanging because server isn't replying (but I would think in that case
I'd get a stack with a hung somewhere in NFS and there isn't one).
This is also with nconnect so not sure if that has any effect on this.

>
> Cheers
>   Trond
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
