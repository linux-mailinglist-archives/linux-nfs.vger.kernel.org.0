Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65566F84DF
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjEEOap (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 May 2023 10:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjEEOao (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 May 2023 10:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED0A11635
        for <linux-nfs@vger.kernel.org>; Fri,  5 May 2023 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683296987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ka/mbetpPBwrN3RsMooZaIJon8kxNnD3XI+PuXQvgFU=;
        b=ZtZnknX3JXoeDA8eMSB69INC8OoOHCaap8c3SbzPpnuJCm79A/n8pXWSHjzIPCJqwCsGMH
        ioubva6oKAe331v4jGeFfJBHHJbYyJRPtdTwi9Lc7a0AHdE4fXpF3Zo+QvHJIlVKD2lAv/
        DvXaB1mBHwJ9yrUFPXk1wQ2QWCrjXw0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-DCXlcqRmPkCgKEQmUg_TdQ-1; Fri, 05 May 2023 10:29:46 -0400
X-MC-Unique: DCXlcqRmPkCgKEQmUg_TdQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-51f10bda596so731171a12.1
        for <linux-nfs@vger.kernel.org>; Fri, 05 May 2023 07:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683296985; x=1685888985;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka/mbetpPBwrN3RsMooZaIJon8kxNnD3XI+PuXQvgFU=;
        b=C6/jr1PMuOf6tk7g4kpfHbg0q4HbGUto2fmX0VG4KmG9B6QnlRAFD0024tEHpvfVy/
         IOhK1Nhxw03QhkKJm3AzVlaKzoWkUM62feAhIkTLfDdTYtAnu29SiyeI4PH9YEWme8pc
         MA4gEdCchP+zOzPd+2FuC+fAXOFY9U4oLxeA+EHoZ/fsXn1mIYeZgs0ftanHgGJ8uW76
         2EneCu64E8Csoyw5q8aexVPyxd4pAYaaewV4B6GPzOsVI1NPh4bp8Vq3Omy1NkpfjWCW
         YcXdnRfduCzJ9uXHImfKMdOMAGBBKUMiR8khVTLPAeIp/BdOKN+alrHatdprT8/OZWwu
         T4SQ==
X-Gm-Message-State: AC+VfDw1TB1lgFHb3PT3iIEdjWehxHRoHor/HIpz3A2Gg2dXbyuZZ3M6
        kfGbPqkyEaC5xuGW/AHUsoQZCHT00UhcIoC2Focwh4QH4SW7k4Vo8kCWwGxcl6zv6gkyNZrpANb
        3LUIMwQUP2hGwRLY5nZc8
X-Received: by 2002:a17:903:183:b0:1a2:8c7e:f301 with SMTP id z3-20020a170903018300b001a28c7ef301mr1688790plg.45.1683296985006;
        Fri, 05 May 2023 07:29:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62OekRECGzgVCnqKvdZWzUJ6Kn8GG8tFIDCrG36XOiECeWA8/JONY+mmh2XjPZDh//9oLAmg==
X-Received: by 2002:a17:903:183:b0:1a2:8c7e:f301 with SMTP id z3-20020a170903018300b001a28c7ef301mr1688760plg.45.1683296984584;
        Fri, 05 May 2023 07:29:44 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001a5260a6e6csm1869483plg.206.2023.05.05.07.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 07:29:44 -0700 (PDT)
Date:   Fri, 5 May 2023 22:29:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] nfs/002: Add a test for xattr ctime updates
Message-ID: <20230505142940.46iulwinf27o4wil@zlang-mailbox>
References: <20230504204847.405037-1-anna@kernel.org>
 <20230505044458.wrvhvamrkcuqin3z@zlang-mailbox>
 <CAFX2Jfk15M9_097BjTPicZ-G0p+TYVqjGmzvZX8r-D7mAOX21Q@mail.gmail.com>
 <20230505140519.xtloxhejjw7hoc24@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230505140519.xtloxhejjw7hoc24@zlang-mailbox>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 05, 2023 at 10:05:19PM +0800, Zorro Lang wrote:
> On Fri, May 05, 2023 at 09:11:52AM -0400, Anna Schumaker wrote:
> > Hi Zorro,
> > 
> > On Fri, May 5, 2023 at 12:45 AM Zorro Lang <zlang@redhat.com> wrote:
> > >
> > > On Thu, May 04, 2023 at 04:48:47PM -0400, Anna Schumaker wrote:
> > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > >
> > > > The NFS client wasn't updating ctime after a setxattr request. This is a
> > > > test written while fixing the bug.
> > > >
> > > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > ---
> > > >  tests/nfs/002     | 39 +++++++++++++++++++++++++++++++++++++++
> > > >  tests/nfs/002.out |  2 ++
> > > >  2 files changed, 41 insertions(+)
> > > >  create mode 100755 tests/nfs/002
> > > >  create mode 100644 tests/nfs/002.out
> > > >
> > > > diff --git a/tests/nfs/002 b/tests/nfs/002
> > > > new file mode 100755
> > > > index 000000000000..5bfedef6c57d
> > > > --- /dev/null
> > > > +++ b/tests/nfs/002
> > > > @@ -0,0 +1,39 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> > > > +#
> > > > +# FS QA Test 002
> > > > +#
> > > > +# Test a bug whene the NFS client wasn't sending a post-op GETATTR to the
                      ^^ ?

> > > > +# server after setting an xattr, resulting in `stat` reporting a stale ctime.

If there's a known bug fix (git commit) in linux, you can use
_fixed_by_kernel_commit(), refer to other cases which use this function.

> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick attr
> > > > +
> > > > +# Import common functions
> > > > +. ./common/filter

I think the common/filter isn't needed.

> > > > +. ./common/attr
> > > > +
> > > > +# real QA test starts here
> > > > +_supported_fs nfs
> > >
> > > Great, a new nfs test case!
> > >
> > > > +_require_test_nfs_version 4.2
> > >
> > > But I'm wondering if this case can be a generic test case, due to the operations
> > > in this case are common (need xattr and ctime support), don't depend on
> > > any nfs specific features/operations.
> > 
> > This probably could be a generic test case.
> 
> Great :)
> 
> > 
> > >
> > > Not sure why nfs4.2 is necessary, can it be removed or replaced ?
> > 
> > That's because xattrs were added to the NFS protocol in NFS v4.2, so I
> > filtered out the other versions since they're not going to run anyway.
> > I think xattr support is already checked to properly skip this on
> > other versions, however, so changing this to a generic test shouldn't
> > create a new failure on earlier NFS versions.
> 
> That makes sense.
> 
> > 
> > Should I send a v2 with those changes? And should I find an open test
> 
> Sure, please send v2 to change this case to be a generic test case. Then we
> can check if more other filesystems has this issue :)
> 
> > number, or choose something like "generic/999"?
> 
> That depends on you. Due to there's only one test case in this patch, so you
> just need to base on latest for-next branch, then choose a number which has
> been taken, I'll deal with that if there's conflict when I merge.
> 
> > Anna
> > >
> > > Thanks,
> > > Zorro
> > >

_require_test

> > > > +_require_attrs
> > > > +
> > > > +touch $TEST_DIR/testfile

We can't be sure there's not a file (or even a directory or others) named
"testfile" in TEST_DIR when fstests is running. So better to remove it at
first. E.g

  rm -rf $TEST_DIR/testfile

> > > > +
> > > > +before_ctime=$(stat -c %z $TEST_DIR/testfile)
> > > > +$SETFATTR_PROG -n user.foobar -v 123 $TEST_DIR/testfile
> > > > +after_ctime=$(stat -c %z $TEST_DIR/testfile)

Might "%Z" be better to be compared? (optional)

Thanks,
Zorro

> > > > +
> > > > +test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change."
> > > > +
> > > > +
> > > > +before_ctime=$after_ctime
> > > > +$SETFATTR_PROG -x user.foobar $TEST_DIR/testfile
> > > > +after_ctime=$(stat -c %z $TEST_DIR/testfile)
> > > > +
> > > > +test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change."
> > > > +
> > > > +echo "Silence is golden"
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/nfs/002.out b/tests/nfs/002.out
> > > > new file mode 100644
> > > > index 000000000000..61705c7cc203
> > > > --- /dev/null
> > > > +++ b/tests/nfs/002.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 002
> > > > +Silence is golden
> > > > --
> > > > 2.40.1
> > > >
> > >
> > 

