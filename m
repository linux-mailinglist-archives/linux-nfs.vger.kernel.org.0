Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3720A358
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2020 18:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391030AbgFYQuj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 12:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390474AbgFYQuj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 12:50:39 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AD4C08C5C1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2020 09:50:39 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1A471878B; Thu, 25 Jun 2020 12:50:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1A471878B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1593103838;
        bh=taoj4fEBL2XYuKGTw5DBfTott/w3SEy7nXmLpmToEmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVzKIRFSQsfQxznm8f2VGbqbjDEBZpub+nS2D5SXn4LKf16nTA/UlNu/0G2QTpQfR
         +lD5VIW0ywxv7SpyNlXD2Vv5MOOwP6XdWjXb3hsTNvzlnbIU0SdE8qBmJuAIAbg0t/
         I/1r8nS2DYsxOAukNm/KkWibWDXyBAzZfb6n+TSY=
Date:   Thu, 25 Jun 2020 12:50:38 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 00/10] server side user xattr support (RFC 8276)
Message-ID: <20200625165038.GA30655@fieldses.org>
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

Do you have some code to share for these tests?

--b.

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
