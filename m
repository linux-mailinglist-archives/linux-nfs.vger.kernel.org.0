Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF4A6F8481
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 16:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjEEOGW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 May 2023 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjEEOGV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 May 2023 10:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A8818870
        for <linux-nfs@vger.kernel.org>; Fri,  5 May 2023 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683295527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWdhihNOOXVm0zZFYmeLX9phb1SH4wF1CHHv75Y5Xjo=;
        b=KfPdNcIEKlXkNPMQshUs5sd7Dqp22wIaK2gzXowXxjI3khamy7xrwxS0ZIkwjVhV504S47
        CU8+8ehJHwwpEXpBN5QpmUdAN6lCeu7iIv6siv1WWmmvVUQTQ0RJ4gjswkyLcrDx1+rF0Y
        143j/NocBhITKMY/lu6g3sREmwih+HA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-fz1EpI4dPUuQuSMM2tL1cA-1; Fri, 05 May 2023 10:05:26 -0400
X-MC-Unique: fz1EpI4dPUuQuSMM2tL1cA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6437c45318aso995849b3a.2
        for <linux-nfs@vger.kernel.org>; Fri, 05 May 2023 07:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683295524; x=1685887524;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWdhihNOOXVm0zZFYmeLX9phb1SH4wF1CHHv75Y5Xjo=;
        b=StzG/gNra2r55BUZN8jxS30Mzfhff9z5htJUgbHGYOz8CpVUDKW4Pj2CZMAE/t7G6l
         70DiYqdQnxZpSzn/DtCvlZYUoFz8VSd9HQfI3bDK4/8C5/LD3BrSSS3c1U34Kz6I8Mb2
         yTobeFlEXGBwIU8E3BKu15nGnTU6lQNXI1ySF70zUEioL7e2+EJB+XsFlknkdsK8waEP
         DjRHUG5CCy/HrqiVga/4V6Rj2z0QQMcBddctZgOcR0VeYimmBCYhpRP3kbWLfYff2IEp
         81+9eV+9LT422y1ke/lApejp95gfBCwyTDGiqmuDL39pB0H56pNj162Zcj6cmmr9T949
         QWyg==
X-Gm-Message-State: AC+VfDxFaRMJEkZ8HmRC2yavekFViO7+nBh3aTPVGwy4oiYFzac6WXcZ
        kBVc7vfvG7qZn6r/smIZ/NUyrUozYtPOWkFU3nAZUiSODmkJ/nrrjpm1v7Kocs6b88F9XO0LRMg
        ut9YdpJyubn+xKO+NdD+lMHYMzQtL21k=
X-Received: by 2002:a05:6a00:2d99:b0:63b:5496:7b04 with SMTP id fb25-20020a056a002d9900b0063b54967b04mr2677034pfb.9.1683295523888;
        Fri, 05 May 2023 07:05:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FsJalLk1HIP0ooeyW6JHodonR+YPeL9foW/qWe2qanfKRRGOrP6cJaVA+84eDO05Pv6K0sg==
X-Received: by 2002:a05:6a00:2d99:b0:63b:5496:7b04 with SMTP id fb25-20020a056a002d9900b0063b54967b04mr2677008pfb.9.1683295523489;
        Fri, 05 May 2023 07:05:23 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x3-20020aa793a3000000b0062607d604b2sm1702934pff.53.2023.05.05.07.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 07:05:23 -0700 (PDT)
Date:   Fri, 5 May 2023 22:05:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] nfs/002: Add a test for xattr ctime updates
Message-ID: <20230505140519.xtloxhejjw7hoc24@zlang-mailbox>
References: <20230504204847.405037-1-anna@kernel.org>
 <20230505044458.wrvhvamrkcuqin3z@zlang-mailbox>
 <CAFX2Jfk15M9_097BjTPicZ-G0p+TYVqjGmzvZX8r-D7mAOX21Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFX2Jfk15M9_097BjTPicZ-G0p+TYVqjGmzvZX8r-D7mAOX21Q@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 05, 2023 at 09:11:52AM -0400, Anna Schumaker wrote:
> Hi Zorro,
> 
> On Fri, May 5, 2023 at 12:45 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Thu, May 04, 2023 at 04:48:47PM -0400, Anna Schumaker wrote:
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > The NFS client wasn't updating ctime after a setxattr request. This is a
> > > test written while fixing the bug.
> > >
> > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > ---
> > >  tests/nfs/002     | 39 +++++++++++++++++++++++++++++++++++++++
> > >  tests/nfs/002.out |  2 ++
> > >  2 files changed, 41 insertions(+)
> > >  create mode 100755 tests/nfs/002
> > >  create mode 100644 tests/nfs/002.out
> > >
> > > diff --git a/tests/nfs/002 b/tests/nfs/002
> > > new file mode 100755
> > > index 000000000000..5bfedef6c57d
> > > --- /dev/null
> > > +++ b/tests/nfs/002
> > > @@ -0,0 +1,39 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> > > +#
> > > +# FS QA Test 002
> > > +#
> > > +# Test a bug whene the NFS client wasn't sending a post-op GETATTR to the
> > > +# server after setting an xattr, resulting in `stat` reporting a stale ctime.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick attr
> > > +
> > > +# Import common functions
> > > +. ./common/filter
> > > +. ./common/attr
> > > +
> > > +# real QA test starts here
> > > +_supported_fs nfs
> >
> > Great, a new nfs test case!
> >
> > > +_require_test_nfs_version 4.2
> >
> > But I'm wondering if this case can be a generic test case, due to the operations
> > in this case are common (need xattr and ctime support), don't depend on
> > any nfs specific features/operations.
> 
> This probably could be a generic test case.

Great :)

> 
> >
> > Not sure why nfs4.2 is necessary, can it be removed or replaced ?
> 
> That's because xattrs were added to the NFS protocol in NFS v4.2, so I
> filtered out the other versions since they're not going to run anyway.
> I think xattr support is already checked to properly skip this on
> other versions, however, so changing this to a generic test shouldn't
> create a new failure on earlier NFS versions.

That makes sense.

> 
> Should I send a v2 with those changes? And should I find an open test

Sure, please send v2 to change this case to be a generic test case. Then we
can check if more other filesystems has this issue :)

> number, or choose something like "generic/999"?

That depends on you. Due to there's only one test case in this patch, so you
just need to base on latest for-next branch, then choose a number which has
been taken, I'll deal with that if there's conflict when I merge.

> Anna
> >
> > Thanks,
> > Zorro
> >
> > > +_require_attrs
> > > +
> > > +touch $TEST_DIR/testfile
> > > +
> > > +before_ctime=$(stat -c %z $TEST_DIR/testfile)
> > > +$SETFATTR_PROG -n user.foobar -v 123 $TEST_DIR/testfile
> > > +after_ctime=$(stat -c %z $TEST_DIR/testfile)
> > > +
> > > +test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change."
> > > +
> > > +
> > > +before_ctime=$after_ctime
> > > +$SETFATTR_PROG -x user.foobar $TEST_DIR/testfile
> > > +after_ctime=$(stat -c %z $TEST_DIR/testfile)
> > > +
> > > +test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change."
> > > +
> > > +echo "Silence is golden"
> > > +status=0
> > > +exit
> > > diff --git a/tests/nfs/002.out b/tests/nfs/002.out
> > > new file mode 100644
> > > index 000000000000..61705c7cc203
> > > --- /dev/null
> > > +++ b/tests/nfs/002.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 002
> > > +Silence is golden
> > > --
> > > 2.40.1
> > >
> >
> 

