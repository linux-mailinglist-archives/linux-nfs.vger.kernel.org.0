Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A3B4A55B
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2019 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfFRP3H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jun 2019 11:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfFRP3H (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 18 Jun 2019 11:29:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 507AC804F2;
        Tue, 18 Jun 2019 15:29:07 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E372C17ADC;
        Tue, 18 Jun 2019 15:29:06 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Alan Post" <adp@prgmr.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang in wait_on_commit with kworker
Date:   Tue, 18 Jun 2019 11:29:16 -0400
Message-ID: <6DE07E49-D450-4BF7-BC61-0973A14CD81B@redhat.com>
In-Reply-To: <20190618000613.GR4158@turtle.email>
References: <20190618000613.GR4158@turtle.email>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 18 Jun 2019 15:29:07 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Alan,

I think that your transport or NFS server is dropping the response to an
RPC.  The NFS client will not retransmit on an established connection.

What server are you using?  Any middle boxes on the network that could be
transparently dropping transmissions (less likely, but I have seen them)?

Ben

On 17 Jun 2019, at 20:06, Alan Post wrote:

> On May 20th I reported "User process NFS write hang followed
> by automount hang requiring reboot" to this list.  There I
> had a process that would hang on NFS write, followed by sync
> hanging, eventually leading to my need to reboot the host.
>
> On June 4th, after upgrading to Linux 4.19.44, I reported
> the issue resolved.  Since that time, as I've deployed out
> Linux 4.19.44, the issue has come back--sort of.
>
> I have begun once again getting sync hangs following a
> hung NFS write.  The hung write has a different stack trace
> than any I previously reported:
>
>     [<0>] wait_on_commit+0x60/0x90 [nfs]
>     [<0>] __nfs_commit_inode+0x146/0x1a0 [nfs]
>     [<0>] nfs_file_fsync+0xa7/0x1d0 [nfs]
>     [<0>] filp_close+0x25/0x70
>     [<0>] put_files_struct+0x66/0xb0
>     [<0>] do_exit+0x2af/0xbb0
>     [<0>] do_group_exit+0x35/0xa0
>     [<0>] __x64_sys_exit_group+0xf/0x10
>     [<0>] do_syscall_64+0x45/0x100
>     [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>     [<0>] 0xffffffffffffffff
>
> And there is attendant kworker thread:
>
>     [<0>] wait_on_commit+0x60/0x90 [nfs]
>     [<0>] __nfs_commit_inode+0x146/0x1a0 [nfs]
>     [<0>] nfs_write_inode+0x5c/0x90 [nfs]
>     [<0>] nfs4_write_inode+0xd/0x30 [nfsv4]
>     [<0>] __writeback_single_inode+0x27a/0x320
>     [<0>] writeback_sb_inodes+0x19a/0x460
>     [<0>] wb_writeback+0x102/0x2f0
>     [<0>] wb_workfn+0xa3/0x400
>     [<0>] process_one_work+0x1e3/0x3d0
>     [<0>] worker_thread+0x28/0x3c0
>     [<0>] kthread+0x10e/0x130
>     [<0>] ret_from_fork+0x35/0x40
>     [<0>] 0xffffffffffffffff
>
> Oddly enough, I can clear the problem without rebooting the host.
> I arrange to block all traffic between the NFS server and NFS
> client using iptables, of sufficient time for any open TCP
> connections to timeout.  After which the connection apparently
> reestablishes and unblocks the hung process.
>
> I can't explain what's keeping the connection alive but apparently
> stalled--requiring my manual intervention.  Do any of you have
> ideas or speculation?  I'm happy to poke around in a packet capture
> if the information provided isn't sufficient.
>
> -A
> -- 
> Alan Post | Xen VPS hosting for the technically adept
> PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
> email: adp@prgmr.com
