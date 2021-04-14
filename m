Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D6335F5C2
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 16:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351726AbhDNOEk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 10:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351739AbhDNOEX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 10:04:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE631C061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 07:04:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 50A1A724B; Wed, 14 Apr 2021 10:04:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 50A1A724B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1618409041;
        bh=kit5Q+fmMpUlugVCcEl/uFMS1EoXvVUMm9zLx2UPaH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTgREo6UmAD56lUWBWX7Y+fprlaTTUl/tloM86mcvH1I3rpkjJcwbxq23v5iw9nEu
         dHlNYYMitrh2BfbSMQ9fVYmfewxsaBXJpwu0dLjsmN81sq08gDLNLDPvPbtJjObs4D
         Z4hmDgbv6jh5pAb8xJhEiEMP07iANvTdcCch+6vY=
Date:   Wed, 14 Apr 2021 10:04:01 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kolga@netapp.com" <kolga@netapp.com>
Subject: Re: generic/430 COPY/delegation caching regression
Message-ID: <20210414140401.GB16800@fieldses.org>
References: <20210413231958.GB31058@fieldses.org>
 <603d9d38a421b190a89254461e01625718ec5fcc.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603d9d38a421b190a89254461e01625718ec5fcc.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 14, 2021 at 03:09:18AM +0000, Trond Myklebust wrote:
> On Tue, 2021-04-13 at 19:19 -0400, J. Bruce Fields wrote:
> > generic/430 started failing in 4.12-rc3, as of 7c1d1dcc24b3 "nfsd:
> > grant
> > read delegations to clients holding writes".
> > 
> > Looks like that reintroduced the problem fixed by 16abd2a0c124
> > "NFSv4.2:
> > fix client's attribute cache management for copy_file_range": the
> > client
> > needs to invalidate its cache of the destination of a copy even when it
> > holds a delegation.
> > 
> > --b.
> 
> Hmm.. The only thing I see that could be causing an issue is the fact
> that we're relying on cache invalidation to change the file size. 
> 
>         nfs_set_cache_invalid(
>                 dst_inode, NFS_INO_REVAL_PAGECACHE | NFS_INO_REVAL_FORCED |
>                                    NFS_INO_INVALID_SIZE | NFS_INO_INVALID_ATTR |
>                                    NFS_INO_INVALID_DATA);
> 
> The only problem there is that nfs_set_cache_invalid() will clobber the
> NFS_INO_INVALID_SIZE because if we hold a delegation, then our client
> is the sole authority for the size attribute (hence we don't allow it
> to be invalidated). We therefore expect a call to i_size_write(), if
> the file size grew.
> 
> Otherwise, the setting of NFS_INO_INVALID_DATA should be redundant
> because we've already punched a hole with truncate_pagecache_range().

Looks like it's just copying a file and finding the destination still empty;
expected/actual output diff from xfstests is:

     e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
     e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/copy
     Copy beginning of original file
    +cmp: EOF on /mnt/test-430/beginning which is empty
     md5sums after copying beginning:
     e11fbace556cba26bf0076e74cab90a3  TEST_DIR/test-430/file
    -cabe45dcc9ae5b66ba86600cca6b8ba8  TEST_DIR/test-430/beginning

The test script there is:

echo "Create the original file and then copy"
$XFS_IO_PROG -f -c 'pwrite -S 0x61 0    1000' $testdir/file >> $seqres.full 2>&1
$XFS_IO_PROG -f -c 'pwrite -S 0x62 1000 1000' $testdir/file >> $seqres.full 2>&1
$XFS_IO_PROG -f -c 'pwrite -S 0x63 2000 1000' $testdir/file >> $seqres.full 2>&1
$XFS_IO_PROG -f -c 'pwrite -S 0x64 3000 1000' $testdir/file >> $seqres.full 2>&1
$XFS_IO_PROG -f -c 'pwrite -S 0x65 4000 1000' $testdir/file >> $seqres.full 2>&1
$XFS_IO_PROG -f -c "copy_range $testdir/file" "$testdir/copy"
cmp $testdir/file $testdir/copy
echo "Original md5sums:"
md5sum $testdir/{file,copy} | _filter_test_dir

echo "Copy beginning of original file"
$XFS_IO_PROG -f -c "copy_range -l 1000 $testdir/file" "$testdir/beginning"
cmp -n 1000 $testdir/file $testdir/beginning

If the client is just failing to notice when a newly created file's size is
grown as the result of a COPY, then I wonder why the first copy (of "file" to
"copy") didn't also fail.

--b.
