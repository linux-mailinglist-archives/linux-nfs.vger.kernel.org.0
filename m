Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8783AA21F
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jun 2021 19:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFPRLG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 13:11:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60920 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230083AbhFPRLG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 13:11:06 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15GH8lKW010194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 13:08:49 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0DA7615C3CB8; Wed, 16 Jun 2021 13:08:47 -0400 (EDT)
Date:   Wed, 16 Jun 2021 13:08:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: set block size according to pnfs_blksize first
Message-ID: <YMowH6STCondvzuJ@mit.edu>
References: <1623847469-150122-1-git-send-email-hsiangkao@linux.alibaba.com>
 <4898aa11dc26396c13bbc3d8bf18c13efe4d513a.camel@hammerspace.com>
 <YMoFcdhVwMXJQPJ+@B-P7TQMD6M-0146.local>
 <2c14b63eacf1742bb0bcd2ae02f2d7005f7682d8.camel@hammerspace.com>
 <YMoNnr1RYDOLXtKJ@B-P7TQMD6M-0146.local>
 <80199ffaf89fc5ef2ad77245f9a5e75beed2dc37.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80199ffaf89fc5ef2ad77245f9a5e75beed2dc37.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 16, 2021 at 03:14:17PM +0000, Trond Myklebust wrote:
> > should we transform it to E2BIG instead (at least in NFS
> > protocol)? but I'm still not sure that E2BIG is a valid return code for
> > setxattr()...
> 
> The setxattr() manpage appears to suggest ERANGE is the correct return
> value here.
> 
>        ERANGE The size of name or value exceeds a filesystem-specific
> limit.
> 
> However I can't tell if ext4 and xfs ever do that.

Ext4 will return ERANGE if the size of the xattr name is greater than
255 bytes.  However, if there is no room to create the xattr --- for
example there is no space to allocate a file system block, ext4 will
return ENOSPC.

Without the ea_inode feature, ext2 and ext4 use a single 4k block to
store all extended attributes.  So whether an xattr can be created is
dependent on whether there is room in that 4k block.  If there are too
many xattrs, or the sum of the length of all the xattr names and
values plus a certain amount of overhead exceeds 4k, it will return
ENOSPC.

> Furthermore, it looks as if the VFS is always returning E2BIG if
> size > XATTR_SIZE_MAX.

This is defined by the attr_set(3) man page, but not in the
setxattr(2) man page.  The set of errors are never intended to be
exhaustive --- there are some tcp-related errors that probably can
exposed to the caller when it is operating on a network-based file
system, for example.  But it would probably be a good idea to update
the man pages so it's a bit clearer when E2BIG and ERANGE and ENOSPC
mean.

Cheers,

					- Ted
