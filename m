Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1983AA107
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 18:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhFPQRI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 12:17:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53220 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234572AbhFPQRH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 12:17:07 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15GGEiZL021199
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 12:14:47 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A9E1F15C3CB8; Wed, 16 Jun 2021 12:14:44 -0400 (EDT)
Date:   Wed, 16 Jun 2021 12:14:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Message-ID: <YMojdN145g9JqAC8@mit.edu>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
 <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
 <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
 <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
 <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 16, 2021 at 10:41:34PM +0800, Gao Xiang wrote:
> > > Yet my question is how to deal with generic/486, should we just skip
> > > the case directly? I cannot find some proper way to get underlayfs
> > > block size or real xattr value limit.

Note that the block size does not necessarily have thing to do with
the xattr value limit.  For example, in ext4, if you create the file
system with the ea_inode feature enabled, you can create extended
attributes up to the maximum value of 64k defined by the xattr
interface --- unless, of course, there isn't enough space in the file
system.

(The ea_inode feature will also use shared space for large xattrs, so
if you are storing hundreds of thousands of files that all have an
identical 20 kilbyte Windows security id or ACL, ea_inode is going to
be much more efficient way of supporting that particular use case.)

> > As noted above, the NFS server should really be returning
> > NFS4ERR_XATTR2BIG in this case, which the client, again, should be
> > transforming into -E2BIG. Where does ENOSPC come from?
> 
> Thanks for the detailed explanation...
> 
> I think that is due to ext4 returning ENOSPC since I tested

It's not just ext4.  From inspection, under some circumstances f2fs
and btrfs can return ENOSPC.

The distinction is that E2BIG is (from the attr_set man page):

       [E2BIG]          The value of the given attribute is too large,
       			it exceeds the maximum allowable size of an
			attribute value.

The maximum allowable size (enforced by the VFS) is XATTR_MAX_SIZE,
which is 65536 bytes.  Some file systems may impose a smaller max
allowable size.

In contrast ENOSPC means something different:

       ENOSPC		No space left on device.

This isn't necessarily just block space, BTW; it might some other file
system space --- thre might not be a free inode in the case of ext4's
ea_inode feature.  Or it be the f2fs file system not being able to
allocate a node id via f2fs_alloc_nid().

Note that generic/486 is testing a very specific case, which is
replacing a small xattr (16 bytes) with an xattr with a large value.
This is would be a really interesting test for ext4 ea_inode, when we
are replacing an xattr stored inline in the inode, or in a single 4k
block, with an xattr stored in a separate inode.  But not the way
src/attr_replace_test.c (which does all of the heavy lifting for the
generic/486 test) is currently written.

So what I would suggest is to have attr_replace_test.c try to
determine the maximum attr value size using binary search.  Start with
min=16, and max=65536, and try creating an xattr of a particular size,
and then delete the xattr, and then retry creating the xattr with the
next binary search size.  This will allow you to create a function
which determines the maximum size attr for a particular file system,
especially in those cases where it is dependent on how the file system
is configured.

> should we transform it to E2BIG instead (at least in NFS
> protocol)? but I'm still not sure that E2BIG is a valid return code for
> setxattr()...

E2BIG is defined in the attr_set(3) man page.  ENOSPC isn't mentioned
in the attr_set man page, but given that multiple file systems return
ENOSPC, and ENOSPC has a well-defined meaning in POSIX.1 which very
much makes sense when creating extended attributes, we should fix that
by adding ENOSPC to the attr_set(3) man page (which is shipped as part
of the libattr library sources).

Cheers,

						- Ted
