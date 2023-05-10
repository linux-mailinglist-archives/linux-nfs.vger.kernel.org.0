Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB56FE234
	for <lists+linux-nfs@lfdr.de>; Wed, 10 May 2023 18:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjEJQOT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 May 2023 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjEJQOS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 May 2023 12:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BD67AB1;
        Wed, 10 May 2023 09:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3F5963DC4;
        Wed, 10 May 2023 16:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA99C433EF;
        Wed, 10 May 2023 16:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683735256;
        bh=vdCB/r/SvhZk31bM9Yw2XYPcWrOxeuoR//IVE7iLA2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l41ebXm6zJCNd8GELQcXI7e1VF2xtPEDSAOE89OBrwLPlTzdH4MRPWjYGN6NlI+vK
         MijS9POVs/18ps0VU8jvyWmRU11wCQCFSL8iwSeeYoOz0sdISIGDQNxGc2yfQ+V36z
         VqGlYTHIWwCPYjWFZ9wPIjlLcHNmn/zyKnfxNGfcrIiOexSndvjHFigOSdIpaxGVEF
         H6gK7HVQanGIw3csrfbojahFdrawX12jdTRHov/EKZmnIC5bN0o1WFzUuLT+I4bDOJ
         +cNbtuJ8afdknwXQfTB6JbFl2ZV6cLw+bKM3ihiKX4OUBFNOQfJNSyVLbN8aBTYgti
         NiA5PQh1EgqoQ==
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-3f4de077aaaso4494001cf.1;
        Wed, 10 May 2023 09:14:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDwd0te9UvpqeBS3j/+PZnQBN+iB6txGx25hi5VTsLc/i3ZNdl4m
        MjYUO2PBi8e5tEZ6SwHOt0M18UcJs4SPgHs011k=
X-Google-Smtp-Source: ACHHUZ7rtDHrfMblnye2sTqvgb6tdSXeW4PT1nfwFhfvnD8TZH9rKL3Mpe8OURJcye5pPOTiOqF+5n3GqS7UoR3Sxec=
X-Received: by 2002:a05:622a:1011:b0:3f4:427:dbb8 with SMTP id
 d17-20020a05622a101100b003f40427dbb8mr4769442qte.2.1683735255403; Wed, 10 May
 2023 09:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230505172427.94963-1-anna@kernel.org> <20230510124511.wcgy63menqywvt34@zlang-mailbox>
In-Reply-To: <20230510124511.wcgy63menqywvt34@zlang-mailbox>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 10 May 2023 12:13:59 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=ma0cFAST9_Bfbekxa_2M8JC2TgwLLEDw-1QDK9SbZ1w@mail.gmail.com>
Message-ID: <CAFX2Jf=ma0cFAST9_Bfbekxa_2M8JC2TgwLLEDw-1QDK9SbZ1w@mail.gmail.com>
Subject: Re: [PATCH v2] generic/728: Add a test for xattr ctime updates
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 10, 2023 at 8:45=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Fri, May 05, 2023 at 01:24:27PM -0400, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > The NFS client wasn't updating ctime after a setxattr request. This is =
a
> > test written while fixing the bug.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > ---
> > v2:
> >  - Move test to generic/
> >  - Address comments from the mailing list
> > ---
> >  tests/generic/728     | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/728.out |  2 ++
> >  2 files changed, 44 insertions(+)
> >  create mode 100755 tests/generic/728
> >  create mode 100644 tests/generic/728.out
> >
> > diff --git a/tests/generic/728 b/tests/generic/728
> > new file mode 100755
> > index 000000000000..ab2414c151db
> > --- /dev/null
> > +++ b/tests/generic/728
> > @@ -0,0 +1,42 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> > +#
> > +# FS QA Test 728
> > +#
> > +# Test a bug where the NFS client wasn't sending a post-op GETATTR to =
the
> > +# server after setting an xattr, resulting in `stat` reporting a stale=
 ctime.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick attr
> > +
> > +# Import common functions
> > +. ./common/attr
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_test
> > +_require_attrs
> > +
> > +rm -rf $TEST_DIR/testfile
> > +touch $TEST_DIR/testfile
> > +
> > +
> > +_check_xattr_op()
> > +{
> > +  what=3D$1
> > +  shift 1
> > +
> > +  before_ctime=3D$(stat -c %z $TEST_DIR/testfile)
> > +  $SETFATTR_PROG $* $TEST_DIR/testfile
>
> Hi Anna,
>
> If there's not objection from you, I'll add below codes at here, and merg=
e
> this case in next fstests release:

Yeah, no objection from me. Sorry I haven't had a chance to get around
to the change this week, I've been doing LSF.

>
> +       # There might be filesystem's timestamp granularity, so sleep 2 s=
econds
> +       # for most filesystems can capture a different timestamp across a
> +       # setxattr operation
> +       sleep 2s
>
> BTW, is there a known git commit which fix the issue of this case trying =
to
> test?

Not yet, but there will be soon. Those patches are still in review and
might need minor fixups. Can the git commit be added once they're
ready?

Anna

>
> Thanks,
> Zorro
>
> > +  after_ctime=3D$(stat -c %z $TEST_DIR/testfile)
> > +
> > +  test "$before_ctime" !=3D "$after_ctime" || echo "Expected ctime to =
change after $what."
> > +}
> > +
> > +_check_xattr_op setxattr -n user.foobar -v 123
> > +_check_xattr_op removexattr -x user.foobar
> > +
> > +echo "Silence is golden"
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/728.out b/tests/generic/728.out
> > new file mode 100644
> > index 000000000000..ab39f45fe5da
> > --- /dev/null
> > +++ b/tests/generic/728.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 728
> > +Silence is golden
> > --
> > 2.40.1
> >
>
