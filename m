Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3034320A365
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2020 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390792AbgFYQxr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 12:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390448AbgFYQxr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 12:53:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE0C08C5C1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2020 09:53:47 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0A85B1509; Thu, 25 Jun 2020 12:53:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0A85B1509
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1593104027;
        bh=tmWE9sAI5HM3fN+Nngg1ZT1PmnePaT3IXNt2Luy3pzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqAP1wtIy80dm+Q2ybd91stRdam2EdvGYMnagppEV5Kx0OFeJjdxS8VUH5Iyma5Ic
         UEypOGfviWDRLx1vTQ0Ah6KLc/WlEdrKmL6+ZQoNFXTK2lg2rOoIdecyXth3pZhGL0
         eEjX0ndABQrodaw2KF8OrtZWp+D5YCogX8Xt43sw=
Date:   Thu, 25 Jun 2020 12:53:47 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 00/10] server side user xattr support (RFC 8276)
Message-ID: <20200625165347.GB30655@fieldses.org>
References: <20200623223927.31795-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

By the way, I can't remember if I asked this before: is there a
particular use case that motivates this xattr work?

--b.

On Tue, Jun 23, 2020 at 10:39:17PM +0000, Frank van der Linden wrote:
> v3:
>   * Rebase to v5.8-rc2
>   * Use length probe + allocate + query for the listxattr and setxattr
>     operations to avoid allocating unneeded space.
>   * Because of the above, drop the 'use kvmalloc for svcxdr_tmpalloc' patch,
>     as it's no longer needed.
> 
> v2:
>   * As per the discussion, user extended attributes are enabled if
>     the client and server support them (e.g. they support 4.2 and
>     advertise the user extended attribute FATTR). There are no longer
>     options to switch them off.
>   * The code is no longer conditioned on a config option.
>   * The number of patches has been reduced somewhat by merging
>     smaller, related ones.
>   * Renamed some functions and added parameter comments as requested.
> 
> v1:
> 
>   * Split in to client and server (changed from the original RFC patch).
> 
> Original RFC combined set is here:
> 
> https://www.spinics.net/lists/linux-nfs/msg74843.html
> 
> In general, these patches were, both server and client, tested as
> follows:
> 	* stress-ng-xattr with 1000 workers
> 	* Test all corner cases (XATTR_SIZE_*)
> 	* Test all failure cases (no xattr, setxattr with different or
> 	  invalid flags, etc).
> 	* Verify the content of xattrs across several operations.
> 	* Use KASAN and KMEMLEAK for a longer mix of testruns to verify
> 	  that there were no leaks (after unmounting the filesystem).
>  	* Interop run against FreeBSD server/client implementation.
>  	* Ran xfstests-dev, with no unexpected/new failures as compared
> 	  to an unpatched kernel. To fully use xfstests-dev, it needed
> 	  some modifications, as it expects to either use all xattr
> 	  namespaces, or none. Whereas NFS only suppors the "user."
> 	  namespace (+ optional ACLs). I will send the changes in
> 	  seperately.
> 
> 
> Frank van der Linden (10):
>   xattr: break delegations in {set,remove}xattr
>   xattr: add a function to check if a namespace is supported
>   nfs,nfsd: NFSv4.2 extended attribute protocol definitions
>   nfsd: split off the write decode code in to a separate function
>   nfsd: add defines for NFSv4.2 extended attribute support
>   nfsd: define xattr functions to call in to their vfs counterparts
>   nfsd: take xattr bits in to account for permission checks
>   nfsd: add structure definitions for xattr requests / responses
>   nfsd: implement the xattr functions and en/decode logic
>   nfsd: add fattr support for user extended attributes
> 
>  fs/nfsd/nfs4proc.c        | 128 ++++++++-
>  fs/nfsd/nfs4xdr.c         | 531 +++++++++++++++++++++++++++++++++++---
>  fs/nfsd/nfsd.h            |   5 +-
>  fs/nfsd/vfs.c             | 239 +++++++++++++++++
>  fs/nfsd/vfs.h             |  10 +
>  fs/nfsd/xdr4.h            |  31 +++
>  fs/xattr.c                | 111 +++++++-
>  include/linux/nfs4.h      |  22 +-
>  include/linux/xattr.h     |   4 +
>  include/uapi/linux/nfs4.h |   3 +
>  10 files changed, 1044 insertions(+), 40 deletions(-)
> 
> -- 
> 2.17.2
