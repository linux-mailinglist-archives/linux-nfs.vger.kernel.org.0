Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF39B4962A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2019 02:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfFRAEo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 20:04:44 -0400
Received: from mail.prgmr.com ([71.19.149.6]:47222 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbfFRAEn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 17 Jun 2019 20:04:43 -0400
Received: from turtle.mx (96-92-68-116-static.hfc.comcastbusiness.net [96.92.68.116])
        (Authenticated sender: adp)
        by mail.prgmr.com (Postfix) with ESMTPSA id CC39928C001
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2019 01:02:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com CC39928C001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1560834122;
        bh=EXsG36YSpeCI3FtWg/MPB9gYk2KfRVEuZirJiJwhjVw=;
        h=Date:From:To:Subject:From;
        b=WVacQohL5hMvokV5sxhFhicIxSOloPuewD4mCRrOyQjxluUuUwVaHYDs954yJMlwn
         TRRsWv1c4sZHQELCPXJRAXjVON90c6yzU8QV/4dilY3R68ihdq19h6VXkrEzbjOkdN
         MZLEkLSuEZhI8UFS5BChyflnsVSuiMiOpQGMQFAs=
Received: (qmail 5602 invoked by uid 1353); 18 Jun 2019 00:06:13 -0000
Date:   Mon, 17 Jun 2019 18:06:13 -0600
From:   Alan Post <adp@prgmr.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: User process NFS write hang in wait_on_commit with kworker
Message-ID: <20190618000613.GR4158@turtle.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On May 20th I reported "User process NFS write hang followed
by automount hang requiring reboot" to this list.  There I
had a process that would hang on NFS write, followed by sync
hanging, eventually leading to my need to reboot the host.

On June 4th, after upgrading to Linux 4.19.44, I reported
the issue resolved.  Since that time, as I've deployed out
Linux 4.19.44, the issue has come back--sort of.

I have begun once again getting sync hangs following a
hung NFS write.  The hung write has a different stack trace
than any I previously reported:

    [<0>] wait_on_commit+0x60/0x90 [nfs]
    [<0>] __nfs_commit_inode+0x146/0x1a0 [nfs]
    [<0>] nfs_file_fsync+0xa7/0x1d0 [nfs]
    [<0>] filp_close+0x25/0x70
    [<0>] put_files_struct+0x66/0xb0
    [<0>] do_exit+0x2af/0xbb0
    [<0>] do_group_exit+0x35/0xa0
    [<0>] __x64_sys_exit_group+0xf/0x10
    [<0>] do_syscall_64+0x45/0x100
    [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [<0>] 0xffffffffffffffff

And there is attendant kworker thread:

    [<0>] wait_on_commit+0x60/0x90 [nfs]
    [<0>] __nfs_commit_inode+0x146/0x1a0 [nfs]
    [<0>] nfs_write_inode+0x5c/0x90 [nfs]
    [<0>] nfs4_write_inode+0xd/0x30 [nfsv4]
    [<0>] __writeback_single_inode+0x27a/0x320
    [<0>] writeback_sb_inodes+0x19a/0x460
    [<0>] wb_writeback+0x102/0x2f0
    [<0>] wb_workfn+0xa3/0x400
    [<0>] process_one_work+0x1e3/0x3d0
    [<0>] worker_thread+0x28/0x3c0
    [<0>] kthread+0x10e/0x130
    [<0>] ret_from_fork+0x35/0x40
    [<0>] 0xffffffffffffffff

Oddly enough, I can clear the problem without rebooting the host.
I arrange to block all traffic between the NFS server and NFS
client using iptables, of sufficient time for any open TCP
connections to timeout.  After which the connection apparently
reestablishes and unblocks the hung process.

I can't explain what's keeping the connection alive but apparently
stalled--requiring my manual intervention.  Do any of you have
ideas or speculation?  I'm happy to poke around in a packet capture
if the information provided isn't sufficient.

-A
-- 
Alan Post | Xen VPS hosting for the technically adept
PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
email: adp@prgmr.com
