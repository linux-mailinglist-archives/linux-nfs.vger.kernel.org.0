Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09BD25836
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfEUTWC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 15:22:02 -0400
Received: from mail.prgmr.com ([71.19.149.6]:46906 "EHLO mail.prgmr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfEUTWC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 May 2019 15:22:02 -0400
Received: from turtle.mx (96-92-68-116-static.hfc.comcastbusiness.net [96.92.68.116])
        (Authenticated sender: adp)
        by mail.prgmr.com (Postfix) with ESMTPSA id D8D2B28C003
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2019 20:19:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.prgmr.com D8D2B28C003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prgmr.com;
        s=default; t=1558484397;
        bh=7LTOX4pUVHPrVGkEgfXC03cYfFx0ZUTYY9bZO8iVEBM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=mUYRxipE7YN2fdGIkGZtdSq475v81ZHdqDQmyYLxwcQj6Oq3Xto0xsVRd6K3/6jvb
         PA27ElT/RRtGKCa5Sf0KvCFmxX0U7tWNoYzymeQr4b3LSH1YkLoVNwvhHEB1WwhJNZ
         nXostXVY17GfA+sBUnOmtQ0m3By5r8k8IKM1OuE8=
Received: (qmail 27831 invoked by uid 1353); 21 May 2019 19:22:54 -0000
Date:   Tue, 21 May 2019 13:22:54 -0600
From:   Alan Post <adp@prgmr.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang followed by automount hang requiring
 reboot
Message-ID: <20190521192254.GN4158@turtle.email>
References: <20190520223324.GL4158@turtle.email>
 <c10084e889df77fc2b6a6c9a04b232faae3a80bc.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10084e889df77fc2b6a6c9a04b232faae3a80bc.camel@hammerspace.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 21, 2019 at 03:46:03PM +0000, Trond Myklebust wrote:
> > A representative sample of stack traces from hung user-submitted
> > processes (jobs).  The first here is quite a lot more common than
> > the later two:
> > 
> >     $ sudo cat /proc/197520/stack
> >     [<0>] io_schedule+0x12/0x40
> >     [<0>] nfs_lock_and_join_requests+0x309/0x4c0 [nfs]
> >     [<0>] nfs_updatepage+0x2a2/0x8b0 [nfs]
> >     [<0>] nfs_write_end+0x63/0x4c0 [nfs]
> >     [<0>] generic_perform_write+0x138/0x1b0
> >     [<0>] nfs_file_write+0xdc/0x200 [nfs]
> >     [<0>] new_sync_write+0xfb/0x160
> >     [<0>] vfs_write+0xa5/0x1a0
> >     [<0>] ksys_write+0x4f/0xb0
> >     [<0>] do_syscall_64+0x53/0x100
> >     [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >     [<0>] 0xffffffffffffffff
> > 
> 
> Have you tried upgrading to 4.19.44? There is a fix that went in not
> too long ago that deals with a request leak that can cause stack traces
> like the above that wait forever.
> 

That I haven't tried.  I gather you're talking about either or both
of:

    63b0ee126f7e
    be74fddc976e

Which I do see went in after 4.19.24 (which I've tried) but didn't
get in 4.20.9 (which I've also tried).  Let me see about trying the
4.19.44 kernel.

> By the way, the above stack trace with "nfs_lock_and_join_requests"
> usually means that you are using a very small rsize or wsize (less than
> 4k). Is that the case? If so, you might want to look into just
> increasing the I/O size.
> 

These exports have rsize and wsize set to 1048576.  That decision was
before my time, and I'll guess this value was picked to match
NFSSVC_MAXBLKSIZE.

Thank you for your help,

-A
-- 
Alan Post | Xen VPS hosting for the technically adept
PO Box 61688 | Sunnyvale, CA 94088-1681 | https://prgmr.com/
email: adp@prgmr.com
