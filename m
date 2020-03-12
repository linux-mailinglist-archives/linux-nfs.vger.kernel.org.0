Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F67183933
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 20:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgCLTGR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 15:06:17 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:40667 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLTGR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Mar 2020 15:06:17 -0400
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 70A36E07D9
        for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2020 20:06:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 70A36E07D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1584039975; bh=1DkqTwiwunDJuy0v3SWxolXd+lui/PhviiPYDWKxt0k=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=zQ/i4cnMdpuIGj7jkCf2XDfcVWPri9pL7kcQUOuBM2C90r95OzXrfrqtjBLP03RF9
         TjtsSq1oufriqpO7Dq9R7iTW/x6NBnzckvGZyTmxTESfhv5GEe4JKjWjKHPqBwb1RM
         2mIFhkTJlXOOVDFX2ZwrTU+knnu99//U8vxMaS1k=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 6632E120258;
        Thu, 12 Mar 2020 20:06:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 3BC29C00A2;
        Thu, 12 Mar 2020 20:06:15 +0100 (CET)
Date:   Thu, 12 Mar 2020 20:06:15 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <547455531.4549278.1584039975188.JavaMail.zimbra@desy.de>
In-Reply-To: <20200311195613.26108-1-fllinden@amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
Subject: Re: [PATCH 00/13] client side user xattr (RFC8276) support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: client side user xattr (RFC8276) support
Thread-Index: UN9LW1/gxlH1qGfS76YmPi1oK92AtA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


I have applied the patchset and run simple test against dCache nfs server:

root@anahit xattr-test]# df -h .
Filesystem      Size  Used Avail Use% Mounted on
ani:/           213G  179G   35G  84% /mnt
[root@anahit xattr-test]#
[root@anahit xattr-test]# touch file.txt
[root@anahit xattr-test]# attr -l file.txt
[root@anahit xattr-test]# attr -s key1 -V value1 file.txt
Attribute "key1" set to a 6 byte value for file.txt:
value1
[root@anahit xattr-test]# attr -s key2 -V value2 file.txt
Attribute "key2" set to a 6 byte value for file.txt:
value2
[root@anahit xattr-test]# attr -l file.txt
Attribute "user.key1" has a 6 byte value for file.txt
Attribute "user.key2" has a 6 byte value for file.txt
[root@anahit xattr-test]# attr -g key1 file.txt
Attribute "key1" had a 6 byte value for file.txt:
value1
[root@anahit xattr-test]# attr -g key2 file.txt
Attribute "key2" had a 6 byte value for file.txt:
value2
[root@anahit xattr-test]# getfattr -n user.key1 file.txt
# file: file.txt
user.key1="value1"

[root@anahit xattr-test]# getfattr -n user.key2 file.txt
# file: file.txt
user.key2="value2"

[root@anahit xattr-test]# attr -r key1 file.txt
[root@anahit xattr-test]# attr -r key2 file.txt
[root@anahit xattr-test]# attr -l file.txt
[root@anahit xattr-test]#


At lease a dirrerent implementation in addition to linux server works as expected.

Tested-by:  "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>


Tigran.

----- Original Message -----
> From: "Frank van der Linden" <fllinden@amazon.com>
> To: "Trond Myklebust" <trond.myklebust@hammerspace.com>, "Anna Schumaker" <anna.schumaker@netapp.com>, "linux-nfs"
> <linux-nfs@vger.kernel.org>
> Cc: "Frank van der Linden" <fllinden@amazon.com>
> Sent: Wednesday, March 11, 2020 8:56:00 PM
> Subject: [PATCH 00/13] client side user xattr (RFC8276) support

> This patchset implements the client side for NFS user extended attributes,
> as defined in RFC8726.
> 
> This was originally posted as an RFC in:
> 
> https://patchwork.kernel.org/cover/11143565/
> 
> Patch 1 is shared with the server side patch, posted
> separately.
> 
> Most comments in there still apply, except that:
> 
> 1. Client side caching is now included in this patch set.
> 2. As per the discussion, user extended attributes are enabled if
>   the client and server support them (e.g. they support 4.2 and
>   advertise the user extended attribute FATTR). There are no longer
>   options to switch them off on either the client or the server.
> 3. The code is no longer conditioned on a config option.
> 4. The number of patches has been reduced somewhat by merging
>   smaller, related ones.
> 
> The client side caching is implemented through a per-inode hash table,
> which is allocated on demand. See fs/nfs/nfs42xattr.c for details.
> 
> This has been tested as follows:
> 
> * Linux client and server:
>	* Test all corner cases (XATTR_SIZE_*)
>	* Test all failure cases (no xattr, setxattr with different or
>	  invalid flags, etc).
>	* Verify the content of xattrs across several operations.
>	* Use KASAN and KMEMLEAK for a longer mix of testruns to verify
>	  that there were no leaks (after unmounting the filesystem).
>	* Stress tested caching, trying to run the client out of memory.
> 
> * Tested against the FreeBSD-current implementation as well, which works
>  (after I fixed 2 bugs in that implementation, which I'm sending out to
>  them too).
> 
> * Not tested: RDMA (I couldn't get a setup going).
> 
> Frank van der Linden (13):
>  nfs,nfsd:  NFSv4.2 extended attribute protocol definitions
>  nfs: add client side only definitions for user xattrs
>  NFSv4.2: query the server for extended attribute support
>  NFSv4.2: define limits and sizes for user xattr handling
>  NFSv4.2: add client side XDR handling for extended attributes
>  nfs: define nfs_access_get_cached function
>  NFSv4.2: query the extended attribute access bits
>  nfs: modify update_changeattr to deal with regular files
>  nfs: define and use the NFS_INO_INVALID_XATTR flag
>  nfs: make the buf_to_pages_noslab function available to the nfs code
>  NFSv4.2: add the extended attribute proc functions.
>  NFSv4.2: hook in the user extended attribute handlers
>  NFSv4.2: add client side xattr caching.
> 
> fs/nfs/Makefile             |    1 +
> fs/nfs/client.c             |   19 +-
> fs/nfs/dir.c                |   24 +-
> fs/nfs/inode.c              |   16 +-
> fs/nfs/internal.h           |   28 ++
> fs/nfs/nfs42.h              |   24 +
> fs/nfs/nfs42proc.c          |  248 ++++++++++
> fs/nfs/nfs42xattr.c         | 1083 +++++++++++++++++++++++++++++++++++++++++++
> fs/nfs/nfs42xdr.c           |  442 ++++++++++++++++++
> fs/nfs/nfs4_fs.h            |    5 +
> fs/nfs/nfs4client.c         |   31 ++
> fs/nfs/nfs4proc.c           |  248 ++++++++--
> fs/nfs/nfs4super.c          |   10 +
> fs/nfs/nfs4xdr.c            |   29 ++
> fs/nfs/nfstrace.h           |    3 +-
> include/linux/nfs4.h        |   25 +
> include/linux/nfs_fs.h      |   12 +
> include/linux/nfs_fs_sb.h   |    6 +
> include/linux/nfs_xdr.h     |   60 ++-
> include/uapi/linux/nfs4.h   |    3 +
> include/uapi/linux/nfs_fs.h |    1 +
> 21 files changed, 2276 insertions(+), 42 deletions(-)
> create mode 100644 fs/nfs/nfs42xattr.c
> 
> --
> 2.16.6
