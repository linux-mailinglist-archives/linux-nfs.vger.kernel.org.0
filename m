Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636FD3AB450
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jun 2021 15:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhFQNLC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Jun 2021 09:11:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60067 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230137AbhFQNLC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Jun 2021 09:11:02 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15HD8gTt027407
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 09:08:44 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 027EA15C3CB8; Thu, 17 Jun 2021 09:08:41 -0400 (EDT)
Date:   Thu, 17 Jun 2021 09:08:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Message-ID: <YMtJWT7hWnHZhrmm@mit.edu>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
 <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
 <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
 <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
 <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
 <YMojdN145g9JqAC8@mit.edu>
 <YMo6CKAaNcZlqzNC@B-P7TQMD6M-0146.local>
 <YMqBY0hk/AmgGMeb@mit.edu>
 <YMq104Ps9nTnzE9R@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMq104Ps9nTnzE9R@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 17, 2021 at 10:39:15AM +0800, Gao Xiang wrote:
> What I said was the original testcase strictly addressing the original
> regression report, which converts from shortform to single-block
> leaf format, see:
> 
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/attr_replace_test.c#n40

So the question is really is this a generic test or an xfs test?  If
it's an xfs test, then you can make non-portable assumptions about the
returned values from statfs(2).

If it's a generic test, then you can't really do that.  And given the
name --- generic/486, it's a generic test.

What we probably *can* do is to test a series of xattr value
replacements --- e.g., find out what is the maximum xattr size
supported, and then try going from an 8 byte xattr value to an xattr
value of size N, where N might be 16, 32, 64, 128, 256, .. up to the
max xattr size supported.

One could also imagine testing starting with an xattr size of 16, 32,
64, 128, 256, ... max_size and replacing with a small xattr, which
would test the reverse case.

That would ba a truly general, generic test.

In any case, I'd suggest making a proposed patch to the fstests@
mailing list, since I'll note that the current set of lists where this
is being discussed may not guarantee that XFS developers will be
paying attention to this thread.

> > > And I found another problem in the test, it fails on 1k/2k block size
> > > extN filesystems, because 2k xattr doesn't fit in single block.. e.g.
> > > 
> > >     -Attribute "world" has a 2048 byte value for SCRATCH_MNT/hello
> > >     +No space left on device
> > >     +error=22 at line 46
> > >     +Attribute "world" has a 1 byte value for
> > > 
> > > We probably need to check the block size of SCRATCH_DEV and _notrun if
> > > it's smaller than 4k.

I think you mean using a 1k or 2k extN file system when testing over
NFS.  It works fine directly on a 1k block file system, since that's
one of my regular test configs and I would have noticed if it was
breaking.

BEGIN TEST 1k (1 test): Ext4 1k block Thu Jun 17 09:05:09 EDT 2021
DEVICE: /dev/vdd
EXT_MKFS_OPTIONS: -b 1024
EXT_MOUNT_OPTIONS: -o block_validity
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 kvm-xfstests 5.13.0-rc5-xfstests-00008-ga3f5d4136d5a #171 SMP Wed Jun 16 20:40:09 EDT 2021
MKFS_OPTIONS  -- -q -b 1024 /dev/vdc
MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc

generic/486             [09:05:10][   19.128541] run fstests generic/486 at 2021-06-17 09:05:10
 [09:05:10] 0s
Ran: generic/486
Passed all 1 tests
Xunit report: /results/ext4/results-1k/result.xml

Again, my suggestion of using binary search to find the largest size
xattr supported by the file system is really the way to go.

Cheers,

						- Ted
