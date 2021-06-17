Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0843F3AA907
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jun 2021 04:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhFQCl0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 22:41:26 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:44234 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhFQClZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 22:41:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UcfUaa1_1623897555;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UcfUaa1_1623897555)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Jun 2021 10:39:17 +0800
Date:   Thu, 17 Jun 2021 10:39:15 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Message-ID: <YMq104Ps9nTnzE9R@B-P7TQMD6M-0146.local>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
 <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
 <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
 <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
 <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
 <YMojdN145g9JqAC8@mit.edu>
 <YMo6CKAaNcZlqzNC@B-P7TQMD6M-0146.local>
 <YMqBY0hk/AmgGMeb@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMqBY0hk/AmgGMeb@mit.edu>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 16, 2021 at 06:55:31PM -0400, Theodore Ts'o wrote:
> On Thu, Jun 17, 2021 at 01:51:04AM +0800, Gao Xiang wrote:
> > 
> > Considering the original XFS regression report [1], I think
> > underlayfs blksize may still be needed. And binary search to get the
> > maximum attr value may be another new case for this as well. Or
> > alternatively just add by block size to do a trip test.
> > 
> > Although I have no idea if we can just skip the case when testing with
> > NFS. If getting underlayfs blksize is unfeasible, I think we might
> > skip such case for now since nfs blksize is not useful for generic/486.
> > 
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=199119
> 
> I've looked at the original XFS regression size, and I don't see why
> using the underlaying blocksize matters at all.  This is especially
> true if you look at the comment in the test, and the commit which
> fixed the bug.  All that is needed for the xfs regression test is to
> start with a small xattr, and replace it with a large xattr.  The
> blocksize is really irrelevant.

What I said was the original testcase strictly addressing the original
regression report, which converts from shortform to single-block
leaf format, see:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/attr_replace_test.c#n40

>	/*
>	 * The value should be 3/4 the size of a fs block to ensure that we
>	 * get to extents format.
>	 */
>	ret = fstat(fd, &sbuf);
>	if (ret < 0) die();
>	size = sbuf.st_blksize * 3 / 4;

and

https://lore.kernel.org/fstests/20180425054826.GB1661@magnolia/

> > And I found another problem in the test, it fails on 1k/2k block size
> > extN filesystems, because 2k xattr doesn't fit in single block.. e.g.
> > 
> >     -Attribute "world" has a 2048 byte value for SCRATCH_MNT/hello
> >     +No space left on device
> >     +error=22 at line 46
> >     +Attribute "world" has a 1 byte value for
> > 
> > We probably need to check the block size of SCRATCH_DEV and _notrun if
> > it's smaller than 4k.
> >
> > Or require ea_inode feature when block size < 4k? Note that this test
> > does fail on ext4 with ea_inode feature enabled (so add ext4 list to
> > cc). e.g.

> I was about to say "Eh, this is a regression test for XFS so that's
> probably fine, but then...

Of course, the testcase itself may have room to improve, I'll look at
it when I have extra time.

Thanks,
Gao Xiang

> 
> 						- Ted
