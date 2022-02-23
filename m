Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960484C1AEA
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 19:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbiBWSY4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 13:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243822AbiBWSYz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 13:24:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2A24A3DE;
        Wed, 23 Feb 2022 10:24:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0748614AC;
        Wed, 23 Feb 2022 18:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB79C340EC;
        Wed, 23 Feb 2022 18:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645640666;
        bh=rgRvW1Qn3oSDYFubJHW9j2LhGBXXkh7qZ9/mK+YaNbo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m8fEWD4GaLZ7waaLQ7ty81ymd0pdAvkb/U+sTbFD9QI7N6nrANWX72lZRJhik+vPK
         x7sX9MqPirv/+RnFB1FbdUAOgfR/+HbxoJuKEGmpy2SJ5c3PIkygTAJbyF1c9U1eDb
         DcNWwPIV1cmo3+gLmBPQaPXch3iVcphl4v3bmM3GUcL0SJE4pXFB5wnqES0jyku+gp
         8gkZa6sH2Oa3zSrDC1zTOn5ML6srO8K65+AiBrdeBnvA4lmhF2K77E9U6vYF96dOg1
         yHKa9vnMF92xIoV4qkyun2OEy7n42RBNgetKpEemzvyQnAMCsZX2h92WMPDPhO8Dxb
         8IZsjXFshYoHw==
Received: by mail-wr1-f54.google.com with SMTP id o4so4274958wrf.3;
        Wed, 23 Feb 2022 10:24:26 -0800 (PST)
X-Gm-Message-State: AOAM533pLjA3R+DMOy0QMLX7Z8hxoUC5J2NC5wAdJBUeZBhnGqxRZtmj
        3nyZrcuWKrShOj0NQSUhmyMJC0DSrq7bFIRdGiM=
X-Google-Smtp-Source: ABdhPJwvY74YtBuDahnwr0uyH1IlIUzyz5bn91fZKzOhSgrdyjhpWP5Omd9qz1sWAAWMhxQUPbJFgoh/6Ji5wRMC0jk=
X-Received: by 2002:a5d:6ace:0:b0:1ed:89dc:a456 with SMTP id
 u14-20020a5d6ace000000b001ed89dca456mr684028wrw.114.1645640664650; Wed, 23
 Feb 2022 10:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20220208215232.491780-1-anna@kernel.org> <20220208215232.491780-4-anna@kernel.org>
 <20220223165729.GH8288@magnolia>
In-Reply-To: <20220223165729.GH8288@magnolia>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 23 Feb 2022 13:24:08 -0500
X-Gmail-Original-Message-ID: <CAFX2JfmJmeFusSEGLEtCXtNGyCW_3faCtMFXEzBKonw+rUO54A@mail.gmail.com>
Message-ID: <CAFX2JfmJmeFusSEGLEtCXtNGyCW_3faCtMFXEzBKonw+rUO54A@mail.gmail.com>
Subject: Re: [PATCH 3/4] generic/578: Test that filefrag is supported before running
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 23, 2022 at 11:57 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Tue, Feb 08, 2022 at 04:52:31PM -0500, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > NFS does not support FIBMAP/FIEMAP, so the check for non-shared extents
> > on NFS v4.2 always fails with the message: "FIBMAP/FIEMAP unsupported".
> > I added the _require_filefrag check for NFS and other filesystems that
> > don't have FIEMAP or FIBMAP support.
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >  common/rc         | 14 ++++++++++++++
> >  tests/generic/578 |  2 +-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/common/rc b/common/rc
> > index b3289de985d8..73d17da9430e 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4673,6 +4673,20 @@ _require_inode_limits()
> >       fi
> >  }
> >
> > +_require_filefrag()
> > +{
> > +     _require_command "$FILEFRAG_PROG" filefrag
> > +
> > +     local file="$TEST_DIR/filefrag_testfile"
> > +
> > +     echo "XX" > $file
>
> Nit: You might want to rm -f $file before echoing into it, just in case
> some future knave ;) sets up that pathname to point to a named pipe or
> something that will hang fstests...
>
> > +     ${FILEFRAG_PROG} $file 2>&1 | grep -q "FIBMAP/FIEMAP[[:space:]]*unsupported"
> > +     if [ $? -eq 0 ]; then
>
> ...and rm it again here to avoid leaving test files around.

Sure, I can make that change. Should I update
_require_filefrag_options() and _require_fibmap() to follow the same
pattern while I'm at it? The new function was based off of those.

Anna

>
> Otherwise this looks ok to me.
>
> --D
>
> > +             _notrun "FIBMAP/FIEMAP not supported by this filesystem"
> > +     fi
> > +     rm -f $file
> > +}
> > +
> >  _require_filefrag_options()
> >  {
> >       _require_command "$FILEFRAG_PROG" filefrag
> > diff --git a/tests/generic/578 b/tests/generic/578
> > index 01929a280f8c..64c813032cf8 100755
> > --- a/tests/generic/578
> > +++ b/tests/generic/578
> > @@ -23,7 +23,7 @@ _cleanup()
> >  # real QA test starts here
> >  _supported_fs generic
> >  _require_test_program "mmap-write-concurrent"
> > -_require_command "$FILEFRAG_PROG" filefrag
> > +_require_filefrag
> >  _require_test_reflink
> >  _require_cp_reflink
> >
> > --
> > 2.35.1
> >
