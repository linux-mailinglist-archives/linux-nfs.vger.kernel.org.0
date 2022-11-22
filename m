Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1273633515
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Nov 2022 07:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiKVGKf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Nov 2022 01:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKVGKe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Nov 2022 01:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4AE2A70E
        for <linux-nfs@vger.kernel.org>; Mon, 21 Nov 2022 22:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669097378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0otfa5oIaXfFOn/qOpuKQ3hX2Udv94ppDYda4ZkcxI=;
        b=GMuL7K9ZmuNyl/xYcfHF0oJzCVv7/r3ZCL0ABJ3jNGCQ9fK4UOw2Q9Da0+xuBIwbJvIkg7
        Bz48x9vaQUKwUN0veGdnbYwdhwdeka4w/lVZgMRKL4/n1AIYWvQkoxEjLfCAUoDZ6mLdx1
        jPmHGQmwhnpU70Jgmf6qO+rCOoqx64U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209--7OhgR-3PdmQAMkklfgwRg-1; Tue, 22 Nov 2022 01:09:37 -0500
X-MC-Unique: -7OhgR-3PdmQAMkklfgwRg-1
Received: by mail-pj1-f72.google.com with SMTP id mj8-20020a17090b368800b002137a506927so7096878pjb.1
        for <linux-nfs@vger.kernel.org>; Mon, 21 Nov 2022 22:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0otfa5oIaXfFOn/qOpuKQ3hX2Udv94ppDYda4ZkcxI=;
        b=HaJXcE17nJ1YsiGfNKXVGLo/2b6If42fVpuzaxiaw8erFfIQltLpZo7/DaC6S/2m5q
         Z5oE0XI61oSf4uT9WzkYUrXeWY0mah4EQGtlmCxziLKPD3AhiO5KnPWGpScuF/+9fnsW
         LuSPYGyZFWYrnTR3BoLsAe0VbWb9dP0wZ2AUm9BvfB3HpHTC8ZDawOnw/hK1bZzFCSN2
         fdvoRWAAK58wJav++s0IZs6XR8aJNfSYX3r9W2BgoxMBV96Qh4YQbjjjqVlXOmBKKkMK
         TF14jAA+G+Gbyv4+GiqJv7SoiUFqTxdQGZzBWuJZp+SXEwUjqh+p9u4iA2Q8hEOw0qJ1
         LC7Q==
X-Gm-Message-State: ANoB5pnnsGNy+AL1CmQBkn5B+Pu2iW51lyHEyhfNZRp5y/ekLyLL6GQM
        4C16vxpxgcnXS6wQsqmoBLrFdK3BHShYRYOH9dNiLVYK08trt5efHhoN939wGDBB+1JiuarRjpl
        2RRyYeZrXJIGf+yEIUknu
X-Received: by 2002:a63:de4a:0:b0:429:983d:22f8 with SMTP id y10-20020a63de4a000000b00429983d22f8mr2391883pgi.165.1669097376227;
        Mon, 21 Nov 2022 22:09:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4lZhrFC3o+Cv91ip17F5Syxlw85Unv0JH5vucSWxf4+kuTEUWQzOs7kgg512kmH1HQBhrcGw==
X-Received: by 2002:a63:de4a:0:b0:429:983d:22f8 with SMTP id y10-20020a63de4a000000b00429983d22f8mr2391867pgi.165.1669097375872;
        Mon, 21 Nov 2022 22:09:35 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001780e4e6b65sm11036329plg.114.2022.11.21.22.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 22:09:35 -0800 (PST)
Date:   Tue, 22 Nov 2022 14:09:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
        linux-nfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] nfs: test files written size as expected
Message-ID: <20221122060931.yjnuljl62cehrm2a@zlang-mailbox>
References: <20221105032329.2067299-1-zlang@kernel.org>
 <20221121184745.p3duc7thj53s5fgv@zlang-mailbox>
 <Y3vTbHqT64gsQ573@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3vTbHqT64gsQ573@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 21, 2022 at 11:37:16AM -0800, Darrick J. Wong wrote:
> On Tue, Nov 22, 2022 at 02:47:45AM +0800, Zorro Lang wrote:
> > On Sat, Nov 05, 2022 at 11:23:29AM +0800, Zorro Lang wrote:
> > > Test nfs and its underlying fs, make sure file size as expected
> > > after writting a file, and the speculative allocation space can
> > > be shrunken.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > ---
> > > 
> > > Hi,
> > > 
> > > The original bug reproducer is:
> > > 1. mount nfs3 backed by xfs
> > > 2. dd if=/dev/zero of=/nfs/10M bs=1M count=10
> > > 3. du -sh /nfs/10M                           
> > > 16M	/nfs/10M 
> > > 
> > > As this was a xfs issue, so cc linux-xfs@ to get review.
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > >  tests/nfs/002     | 43 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/nfs/002.out |  2 ++
> > >  2 files changed, 45 insertions(+)
> > >  create mode 100755 tests/nfs/002
> > >  create mode 100644 tests/nfs/002.out
> > > 
> > > diff --git a/tests/nfs/002 b/tests/nfs/002
> > > new file mode 100755
> > > index 00000000..3d29958d
> > > --- /dev/null
> > > +++ b/tests/nfs/002
> > > @@ -0,0 +1,43 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 002
> > > +#
> > > +# Make sure nfs gets expected file size after writting a big sized file. It's
> > > +# not only testing nfs, test its underlying fs too. For example a known old bug
> > > +# on xfs (underlying fs) caused nfs get larger file size (e.g. 16M) after
> > > +# writting 10M data to a file. It's fixed by a series of patches around
> > > +# 579b62faa5fb16 ("xfs: add background scanning to clear eofblocks inodes")
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto rw
> > > +
> > > +# real QA test starts here
> > > +_supported_fs nfs
> > > +_require_test
> > > +
> > > +localfile=$TEST_DIR/testfile.$seq
> > > +rm -rf $localfile
> > > +
> > > +$XFS_IO_PROG -f -t -c "pwrite 0 10m" -c "fsync" $localfile >>$seqres.full 2>&1
> > > +block_size=`stat -c '%B' $localfile`
> > > +iblocks_expected=$((10 * 1024 * 1024 / $block_size))
> > > +# Try several times for the speculative allocated file size can be shrunken
> > > +res=1
> > > +for ((i=0; i<10; i++));do
> > > +	iblocks_real=`stat -c '%b' $localfile`
> > > +	if [ "$iblocks_expected" = "$iblocks_real" ];then
> > > +		res=0
> > > +		break
> > > +	fi
> > > +	sleep 10
> > > +done
> > 
> > Hmm... this case sometimes fails on kernel 6.1.0-rc6 [1] (nfs4.2 base on xfs),
> > even I changed the sleep time to 20s * 10, it still fails. But I can't reproduce
> > this failure if the underlying fs is ext4... cc linux-xfs, to check if I miss
> > something for xfs? Or this's a xfs issue?
> 
> Could be anything, really -- speculative preallocation on the server, or
> xattrs blowing up the attr fork.  You'd have to go query the file
> mappings and whatnot of the xfs file on the server to find out.

Hi Darrick,

Thanks for your reply.

When the number of blocks isn't as expected, I printed the bmap of the test
file on xfs, it really shows 20480 blocks [1], not 32640 blocks.

And I checked the xattr of the file on xfs, it doesn't has attr blocks [2], it's
local format. Even if it has some attr blocks, 32640 too much bigger than 20480,
I don't think selinux or other xattr takes that many blocks.

Hmm... this test case passed on nfs3 and nfs4.0 with xfs, but fails on nfs4.1 or
nfs4.2 with xfs. cc linux-nfs@ list to get more review.

BTW, this case is an original regression test for a rhel bug:
https://bugzilla.redhat.com/show_bug.cgi?id=955254 (you might can't open it)
which blamed that "xfs files written over nfs are bigger due to speculative
allocation and may never shrink while fs is mounted".

Dave said:
For NFS servers, keeping the speculative prealloc around for as long as possible
is the desired behaviour. It will get truncated away when the inode is cycled
out of the cache by memory pressure on the NFS server. So the code is currently
behaving as designed.

But there are changes upstream that give different behaviour, so we merged
below xfs patches to "fix" that bug:

  xfs: add EOFBLOCKS inode tagging/untagging
  xfs: support a tag-based inode_ag_iterator
  xfs: create helper to check whether to free eofblocks on inode
  xfs: make xfs_free_eofblocks() non-static, return EAGAIN on trylock failure
  xfs: create function to scan and clear EOFBLOCKS inodes
  xfs: add XFS_IOC_FREE_EOFBLOCKS ioctl
  xfs: add inode id filtering to eofblocks scan
  xfs: support multiple inode id filtering in eofblocks scan
  xfs: add minimum file size filtering to eofblocks scan
  xfs: add background scanning to clear eofblocks inodes
  xfs: limit speculative prealloc near ENOSPC thresholds
  xfs: limit speculative prealloc size on sparse files
  xfs: fix potential infinite loop in xfs_iomap_prealloc_size()
  xfs: increase prealloc size to double that of the previous extent
  xfs: fix xfs_iomap_eof_prealloc_initial_size type
  xfs: Define a new function xfs_this_quota_on()
  xfs: Define a new function xfs_inode_dquot()
  xfs: reorganize xfs_iomap_prealloc_size to remove indentation
  xfs: push rounddown_pow_of_two() to after prealloc throttle
  xfs: pass xfs_dquot to xfs_qm_adjust_dqlimits() instead of xfs_disk_dquot_t
  xfs: xfs_dquot prealloc throttling watermarks and low free space
  xfs: add quota-driven speculative preallocation throttling
  xfs: xfs_iomap_prealloc_size() tracepoint
  xfs: don't use speculative prealloc for small files

How I'm not sure if it's a bug again, or an expected result for nfs4.2 with xfs.

Thanks,
Zorro

[1]
/mnt/xfstests/test/nfs-server/testfile.002:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
 FLAG Values:
    0100000 Shared extent
    0010000 Unwritten preallocated extent
    0001000 Doesn't begin on stripe unit
    0000100 Doesn't end   on stripe unit
    0000010 Doesn't begin on stripe width
    0000001 Doesn't end   on stripe width


[2]
core.format = 2 (extents)
...
core.size = 10485760     
core.nblocks = 2560   
core.extsize = 0            
core.nextents = 1             
core.naextents = 0       
core.forkoff = 24          
core.aformat = 1 (local)
...
u3.bmx[0] = [startoff,startblock,blockcount,extentflag] 
0:[0,24,2560,0]
a.sfattr.hdr.totsize = 47
a.sfattr.hdr.count = 1
a.sfattr.list[0].namelen = 7
a.sfattr.list[0].valuelen = 33
a.sfattr.list[0].root = 0
a.sfattr.list[0].secure = 1
a.sfattr.list[0].name = "selinux"
a.sfattr.list[0].value = "system_u:object_r:unlabeled_t:s0\000"

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > [1]
> > # ./check nfs/002
> > FSTYP         -- nfs
> > PLATFORM      -- Linux/x86_64 dell-per640-04 6.1.0-rc6 #1 SMP PREEMPT_DYNAMIC Mon Nov 21 00:51:20 EST 2022
> > MKFS_OPTIONS  -- dell-per640-04.dell2.lab.eng.bos.redhat.com:/mnt/xfstests/scratch/nfs-server
> > MOUNT_OPTIONS -- -o vers=4.2 -o context=system_u:object_r:root_t:s0 dell-per640-04.dell2.lab.eng.bos.redhat.com:/mnt/xfstests/scratch/nfs-server /mnt/xfstests/scratch/nfs-client
> > 
> > nfs/002 3s ... - output mismatch (see /var/lib/xfstests/results//nfs/002.out.bad)
> >     --- tests/nfs/002.out       2022-11-21 01:29:33.861770474 -0500
> >     +++ /var/lib/xfstests/results//nfs/002.out.bad      2022-11-21 13:27:37.424199056 -0500
> >     @@ -1,2 +1,3 @@
> >      QA output created by 002
> >     +Write 20480 blocks, but get 32640 blocks
> >      Silence is golden
> >     ...
> >     (Run 'diff -u /var/lib/xfstests/tests/nfs/002.out /var/lib/xfstests/results//nfs/002.out.bad'  to see the entire diff)
> > Ran: nfs/002
> > Failures: nfs/002
> > Failed 1 of 1 tests
> > 
> > 
> > > +if [ $res -ne 0 ];then
> > > +	echo "Write $iblocks_expected blocks, but get $iblocks_real blocks"
> > > +fi
> > > +
> > > +echo "Silence is golden"
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/nfs/002.out b/tests/nfs/002.out
> > > new file mode 100644
> > > index 00000000..61705c7c
> > > --- /dev/null
> > > +++ b/tests/nfs/002.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 002
> > > +Silence is golden
> > > -- 
> > > 2.31.1
> > > 
> > 
> 

