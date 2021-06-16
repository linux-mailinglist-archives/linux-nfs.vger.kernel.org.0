Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022423AA2A9
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 19:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFPRxP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 13:53:15 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36036 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230291AbhFPRxP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 13:53:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UcdmIg3_1623865865;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UcdmIg3_1623865865)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Jun 2021 01:51:06 +0800
Date:   Thu, 17 Jun 2021 01:51:04 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Message-ID: <YMo6CKAaNcZlqzNC@B-P7TQMD6M-0146.local>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
 <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
 <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
 <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
 <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
 <YMojdN145g9JqAC8@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMojdN145g9JqAC8@mit.edu>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ted,

On Wed, Jun 16, 2021 at 12:14:44PM -0400, Theodore Ts'o wrote:
> On Wed, Jun 16, 2021 at 10:41:34PM +0800, Gao Xiang wrote:
> > > > Yet my question is how to deal with generic/486, should we just skip
> > > > the case directly? I cannot find some proper way to get underlayfs
> > > > block size or real xattr value limit.
> 
> Note that the block size does not necessarily have thing to do with
> the xattr value limit.  For example, in ext4, if you create the file
> system with the ea_inode feature enabled, you can create extended
> attributes up to the maximum value of 64k defined by the xattr
> interface --- unless, of course, there isn't enough space in the file
> system.
> 
> (The ea_inode feature will also use shared space for large xattrs, so
> if you are storing hundreds of thousands of files that all have an
> identical 20 kilbyte Windows security id or ACL, ea_inode is going to
> be much more efficient way of supporting that particular use case.)

Thanks for your detailed explanation too.

Yeah, yet it's not enabled in the issue setup I was assigned :(

> 
> > > As noted above, the NFS server should really be returning
> > > NFS4ERR_XATTR2BIG in this case, which the client, again, should be
> > > transforming into -E2BIG. Where does ENOSPC come from?
> > 
> > Thanks for the detailed explanation...
> > 
> > I think that is due to ext4 returning ENOSPC since I tested
> 
> It's not just ext4.  From inspection, under some circumstances f2fs
> and btrfs can return ENOSPC.

I did some test on ext4 only earlier since it's our test environment.
I didn't mean the ENOSPC behavior was ext4 only ( :-) very sorry about
that if some misunderstanding here )

> 
> The distinction is that E2BIG is (from the attr_set man page):
> 
>        [E2BIG]          The value of the given attribute is too large,
>        			it exceeds the maximum allowable size of an
> 			attribute value.
> 
> The maximum allowable size (enforced by the VFS) is XATTR_MAX_SIZE,
> which is 65536 bytes.  Some file systems may impose a smaller max
> allowable size.
> 
> In contrast ENOSPC means something different:
> 
>        ENOSPC		No space left on device.
> 
> This isn't necessarily just block space, BTW; it might some other file
> system space --- thre might not be a free inode in the case of ext4's
> ea_inode feature.  Or it be the f2fs file system not being able to
> allocate a node id via f2fs_alloc_nid().
> 
> Note that generic/486 is testing a very specific case, which is
> replacing a small xattr (16 bytes) with an xattr with a large value.
> This is would be a really interesting test for ext4 ea_inode, when we
> are replacing an xattr stored inline in the inode, or in a single 4k
> block, with an xattr stored in a separate inode.  But not the way
> src/attr_replace_test.c (which does all of the heavy lifting for the
> generic/486 test) is currently written.
> 

Yeah, as for the original case, it tried to test when it turned into
the XFS extents format, but I'm not sure if it's just the regression
test for such report only (similiar to ext4 inline xattr to non-inline
xattr case.) rather than test the XFS_DINODE_FMT_BTREE case or ea_inode
case...

> So what I would suggest is to have attr_replace_test.c try to
> determine the maximum attr value size using binary search.  Start with
> min=16, and max=65536, and try creating an xattr of a particular size,
> and then delete the xattr, and then retry creating the xattr with the
> next binary search size.  This will allow you to create a function
> which determines the maximum size attr for a particular file system,
> especially in those cases where it is dependent on how the file system
> is configured.

Considering the original XFS regression report [1], I think
underlayfs blksize may still be needed. And binary search to get the
maximum attr value may be another new case for this as well. Or
alternatively just add by block size to do a trip test.

Although I have no idea if we can just skip the case when testing with
NFS. If getting underlayfs blksize is unfeasible, I think we might
skip such case for now since nfs blksize is not useful for generic/486.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=199119

Thanks,
Gao Xiang

> 
> > should we transform it to E2BIG instead (at least in NFS
> > protocol)? but I'm still not sure that E2BIG is a valid return code for
> > setxattr()...
> 
> E2BIG is defined in the attr_set(3) man page.  ENOSPC isn't mentioned
> in the attr_set man page, but given that multiple file systems return
> ENOSPC, and ENOSPC has a well-defined meaning in POSIX.1 which very
> much makes sense when creating extended attributes, we should fix that
> by adding ENOSPC to the attr_set(3) man page (which is shipped as part
> of the libattr library sources).
> 
> Cheers,
> 
> 						- Ted
