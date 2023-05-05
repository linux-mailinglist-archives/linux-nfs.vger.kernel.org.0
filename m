Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4D6F838E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 May 2023 15:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjEENML (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 May 2023 09:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjEENMK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 May 2023 09:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC321AEC7;
        Fri,  5 May 2023 06:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D6C63B66;
        Fri,  5 May 2023 13:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6962C433EF;
        Fri,  5 May 2023 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683292328;
        bh=9B6QXXuo4HcCA8VAMOPYNMu04swRcyeYFUwzkmSUl8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TukNWJFF4LE0vgzS2VKtDxoAbvP+Gx5CwPwie3PYKCSTVHvDkwNdj+Mu2YN6V3cNu
         Frzf6M2SX4dDzq9EB/TXXYdlFQqsSMT2fzyiRUAmCiGgFzi3RKrW7WEfZBbql6GTp8
         2cQlnZ/dTRDb3MKlPiy6Vjv18vKkEPVpQX5NSpDK2THbaT48vC8aZqGw1GASgvoHPN
         JjmpdR6qMa7G06lXQaa2H4OoKSS94wWs0S0oWXDvpfjjHBVdSjHlxe+6Q0lq3OU//6
         DHu3hqf68k5ODwbqoQhEaELlRYTUfXE6s/KW0E8CPIoOczHoyE8UH9sEVrd8czTZrf
         lKHu/iHlkqpTQ==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-75131c2997bso934320385a.1;
        Fri, 05 May 2023 06:12:08 -0700 (PDT)
X-Gm-Message-State: AC+VfDzWOUQazgpMhcvZNHNhk4j0uPSz3UWPY+H3MSutLNvB9gpWx14f
        y/0TnrSMrAYv1W1LP2wOm7VNy4PIzv3XHA7TLCI=
X-Google-Smtp-Source: ACHHUZ4q7ovTD7I50QVqFNVbA0xe9kfcom/1RZUsRtf7OTcXImTQ02syoYCnoKHnHjtZ6imEmQW0SULwVZwFcl58EWA=
X-Received: by 2002:ac8:5c90:0:b0:3ee:dffa:5b30 with SMTP id
 r16-20020ac85c90000000b003eedffa5b30mr2296246qta.24.1683292327907; Fri, 05
 May 2023 06:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230504204847.405037-1-anna@kernel.org> <20230505044458.wrvhvamrkcuqin3z@zlang-mailbox>
In-Reply-To: <20230505044458.wrvhvamrkcuqin3z@zlang-mailbox>
From:   Anna Schumaker <anna@kernel.org>
Date:   Fri, 5 May 2023 09:11:52 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfk15M9_097BjTPicZ-G0p+TYVqjGmzvZX8r-D7mAOX21Q@mail.gmail.com>
Message-ID: <CAFX2Jfk15M9_097BjTPicZ-G0p+TYVqjGmzvZX8r-D7mAOX21Q@mail.gmail.com>
Subject: Re: [PATCH] nfs/002: Add a test for xattr ctime updates
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Zorro,

On Fri, May 5, 2023 at 12:45=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Thu, May 04, 2023 at 04:48:47PM -0400, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > The NFS client wasn't updating ctime after a setxattr request. This is =
a
> > test written while fixing the bug.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  tests/nfs/002     | 39 +++++++++++++++++++++++++++++++++++++++
> >  tests/nfs/002.out |  2 ++
> >  2 files changed, 41 insertions(+)
> >  create mode 100755 tests/nfs/002
> >  create mode 100644 tests/nfs/002.out
> >
> > diff --git a/tests/nfs/002 b/tests/nfs/002
> > new file mode 100755
> > index 000000000000..5bfedef6c57d
> > --- /dev/null
> > +++ b/tests/nfs/002
> > @@ -0,0 +1,39 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> > +#
> > +# FS QA Test 002
> > +#
> > +# Test a bug whene the NFS client wasn't sending a post-op GETATTR to =
the
> > +# server after setting an xattr, resulting in `stat` reporting a stale=
 ctime.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick attr
> > +
> > +# Import common functions
> > +. ./common/filter
> > +. ./common/attr
> > +
> > +# real QA test starts here
> > +_supported_fs nfs
>
> Great, a new nfs test case!
>
> > +_require_test_nfs_version 4.2
>
> But I'm wondering if this case can be a generic test case, due to the ope=
rations
> in this case are common (need xattr and ctime support), don't depend on
> any nfs specific features/operations.

This probably could be a generic test case.

>
> Not sure why nfs4.2 is necessary, can it be removed or replaced ?

That's because xattrs were added to the NFS protocol in NFS v4.2, so I
filtered out the other versions since they're not going to run anyway.
I think xattr support is already checked to properly skip this on
other versions, however, so changing this to a generic test shouldn't
create a new failure on earlier NFS versions.

Should I send a v2 with those changes? And should I find an open test
number, or choose something like "generic/999"?
Anna
>
> Thanks,
> Zorro
>
> > +_require_attrs
> > +
> > +touch $TEST_DIR/testfile
> > +
> > +before_ctime=3D$(stat -c %z $TEST_DIR/testfile)
> > +$SETFATTR_PROG -n user.foobar -v 123 $TEST_DIR/testfile
> > +after_ctime=3D$(stat -c %z $TEST_DIR/testfile)
> > +
> > +test "$before_ctime" !=3D "$after_ctime" || echo "Expected ctime to ch=
ange."
> > +
> > +
> > +before_ctime=3D$after_ctime
> > +$SETFATTR_PROG -x user.foobar $TEST_DIR/testfile
> > +after_ctime=3D$(stat -c %z $TEST_DIR/testfile)
> > +
> > +test "$before_ctime" !=3D "$after_ctime" || echo "Expected ctime to ch=
ange."
> > +
> > +echo "Silence is golden"
> > +status=3D0
> > +exit
> > diff --git a/tests/nfs/002.out b/tests/nfs/002.out
> > new file mode 100644
> > index 000000000000..61705c7cc203
> > --- /dev/null
> > +++ b/tests/nfs/002.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 002
> > +Silence is golden
> > --
> > 2.40.1
> >
>
