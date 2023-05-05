Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6246F6F84E5
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjEEOe3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 May 2023 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjEEOe3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 May 2023 10:34:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D962F1634D;
        Fri,  5 May 2023 07:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E95F63E7E;
        Fri,  5 May 2023 14:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB548C4339B;
        Fri,  5 May 2023 14:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683297264;
        bh=F56SR2uPO5iqBsvPiTHvhOQc2GsdQ3EtZFOxU6+7UO4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YCU0jLsuIPrL3WGFj5wdHCbQ7btSpdJvWipnHpRyg9ylqm7Z2SvONa5ONDoY8OKSq
         kB2dbHxO1XuH6l2H3UVCUy0+NZqDes1OgXYmOdg/qgYYsEOD3TC7Lj52ZP4RMrPGFV
         arxK/ChvieY80V3z0PSvLUnP6PqZucutorSfpIWr9+O9py43oluR121AOQIUXQgVVP
         NqSArP44Au4Njg5AfiSwZ8MyWNH+sI7N20j2WrjSUwlTIICRZ6+FkEse8WqEyXPB21
         759Lv9Xp5i0RzoZBC252xJzOn69k+6lQPhh73gBtEcJ8MOu9iEwDP6ZsT+rZX1R9j0
         hMqufAx6X3IyA==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-74fbf99adc2so82868285a.3;
        Fri, 05 May 2023 07:34:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDzEnNOxNqCl2Kli2GNAuXhGYkL4pau6PLXpA3y4Wj6gM4l1Zurj
        ptZMFeqNi+mQW6yngFKSqMQVv0vP9wQlDTc/o5A=
X-Google-Smtp-Source: ACHHUZ67jExIfYx/IiwXvprvBB4E1QXg/3/AGHHTJCYrKhjWGeX0w7IHcBppYf16T0YNDMSHCCfP6SKySGIg/N0K95o=
X-Received: by 2002:a05:622a:178b:b0:3e2:4280:bc56 with SMTP id
 s11-20020a05622a178b00b003e24280bc56mr2527117qtk.41.1683297263889; Fri, 05
 May 2023 07:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230504204847.405037-1-anna@kernel.org> <20230505044458.wrvhvamrkcuqin3z@zlang-mailbox>
 <CAFX2Jfk15M9_097BjTPicZ-G0p+TYVqjGmzvZX8r-D7mAOX21Q@mail.gmail.com>
 <20230505140519.xtloxhejjw7hoc24@zlang-mailbox> <20230505142940.46iulwinf27o4wil@zlang-mailbox>
In-Reply-To: <20230505142940.46iulwinf27o4wil@zlang-mailbox>
From:   Anna Schumaker <anna@kernel.org>
Date:   Fri, 5 May 2023 10:34:07 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfm1tkR4t-6B2y=Hu4e2MEkxqVn9U3yZbL-vVeU7qtzeEw@mail.gmail.com>
Message-ID: <CAFX2Jfm1tkR4t-6B2y=Hu4e2MEkxqVn9U3yZbL-vVeU7qtzeEw@mail.gmail.com>
Subject: Re: [PATCH] nfs/002: Add a test for xattr ctime updates
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 5, 2023 at 10:29=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Fri, May 05, 2023 at 10:05:19PM +0800, Zorro Lang wrote:
> > On Fri, May 05, 2023 at 09:11:52AM -0400, Anna Schumaker wrote:
> > > Hi Zorro,
> > >
> > > On Fri, May 5, 2023 at 12:45=E2=80=AFAM Zorro Lang <zlang@redhat.com>=
 wrote:
> > > >
> > > > On Thu, May 04, 2023 at 04:48:47PM -0400, Anna Schumaker wrote:
> > > > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > >
> > > > > The NFS client wasn't updating ctime after a setxattr request. Th=
is is a
> > > > > test written while fixing the bug.
> > > > >
> > > > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > > > ---
> > > > >  tests/nfs/002     | 39 +++++++++++++++++++++++++++++++++++++++
> > > > >  tests/nfs/002.out |  2 ++
> > > > >  2 files changed, 41 insertions(+)
> > > > >  create mode 100755 tests/nfs/002
> > > > >  create mode 100644 tests/nfs/002.out
> > > > >
> > > > > diff --git a/tests/nfs/002 b/tests/nfs/002
> > > > > new file mode 100755
> > > > > index 000000000000..5bfedef6c57d
> > > > > --- /dev/null
> > > > > +++ b/tests/nfs/002
> > > > > @@ -0,0 +1,39 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> > > > > +#
> > > > > +# FS QA Test 002
> > > > > +#
> > > > > +# Test a bug whene the NFS client wasn't sending a post-op GETAT=
TR to the
>                       ^^ ?

Whoops, typo! I'll fix that in v2
>
> > > > > +# server after setting an xattr, resulting in `stat` reporting a=
 stale ctime.
>
> If there's a known bug fix (git commit) in linux, you can use
> _fixed_by_kernel_commit(), refer to other cases which use this function.
>
> > > > > +#
> > > > > +. ./common/preamble
> > > > > +_begin_fstest auto quick attr
> > > > > +
> > > > > +# Import common functions
> > > > > +. ./common/filter
>
> I think the common/filter isn't needed.
>
Okay

> > > > > +. ./common/attr
> > > > > +
> > > > > +# real QA test starts here
> > > > > +_supported_fs nfs
> > > >
> > > > Great, a new nfs test case!
> > > >
> > > > > +_require_test_nfs_version 4.2
> > > >
> > > > But I'm wondering if this case can be a generic test case, due to t=
he operations
> > > > in this case are common (need xattr and ctime support), don't depen=
d on
> > > > any nfs specific features/operations.
> > >
> > > This probably could be a generic test case.
> >
> > Great :)
> >
> > >
> > > >
> > > > Not sure why nfs4.2 is necessary, can it be removed or replaced ?
> > >
> > > That's because xattrs were added to the NFS protocol in NFS v4.2, so =
I
> > > filtered out the other versions since they're not going to run anyway=
.
> > > I think xattr support is already checked to properly skip this on
> > > other versions, however, so changing this to a generic test shouldn't
> > > create a new failure on earlier NFS versions.
> >
> > That makes sense.
> >
> > >
> > > Should I send a v2 with those changes? And should I find an open test
> >
> > Sure, please send v2 to change this case to be a generic test case. The=
n we
> > can check if more other filesystems has this issue :)
> >
> > > number, or choose something like "generic/999"?
> >
> > That depends on you. Due to there's only one test case in this patch, s=
o you
> > just need to base on latest for-next branch, then choose a number which=
 has
> > been taken, I'll deal with that if there's conflict when I merge.
> >
> > > Anna
> > > >
> > > > Thanks,
> > > > Zorro
> > > >
>
> _require_test
>
> > > > > +_require_attrs
> > > > > +
> > > > > +touch $TEST_DIR/testfile
>
> We can't be sure there's not a file (or even a directory or others) named
> "testfile" in TEST_DIR when fstests is running. So better to remove it at
> first. E.g
>
>   rm -rf $TEST_DIR/testfile

Okay
>
> > > > > +
> > > > > +before_ctime=3D$(stat -c %z $TEST_DIR/testfile)
> > > > > +$SETFATTR_PROG -n user.foobar -v 123 $TEST_DIR/testfile
> > > > > +after_ctime=3D$(stat -c %z $TEST_DIR/testfile)
>
> Might "%Z" be better to be compared? (optional)

No, I tried that at first but since it's reporting seconds since epoch
it doesn't have enough granularity to detect the change.

Anna
>
> Thanks,
> Zorro
>
> > > > > +
> > > > > +test "$before_ctime" !=3D "$after_ctime" || echo "Expected ctime=
 to change."
> > > > > +
> > > > > +
> > > > > +before_ctime=3D$after_ctime
> > > > > +$SETFATTR_PROG -x user.foobar $TEST_DIR/testfile
> > > > > +after_ctime=3D$(stat -c %z $TEST_DIR/testfile)
> > > > > +
> > > > > +test "$before_ctime" !=3D "$after_ctime" || echo "Expected ctime=
 to change."
> > > > > +
> > > > > +echo "Silence is golden"
> > > > > +status=3D0
> > > > > +exit
> > > > > diff --git a/tests/nfs/002.out b/tests/nfs/002.out
> > > > > new file mode 100644
> > > > > index 000000000000..61705c7cc203
> > > > > --- /dev/null
> > > > > +++ b/tests/nfs/002.out
> > > > > @@ -0,0 +1,2 @@
> > > > > +QA output created by 002
> > > > > +Silence is golden
> > > > > --
> > > > > 2.40.1
> > > > >
> > > >
> > >
>
