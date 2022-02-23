Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6614C1C69
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 20:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242210AbiBWTjR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 14:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbiBWTjR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 14:39:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A5C48E6B;
        Wed, 23 Feb 2022 11:38:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82B196174C;
        Wed, 23 Feb 2022 19:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FB5C340E7;
        Wed, 23 Feb 2022 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645645127;
        bh=qVQkt3d+s5a/ZV8+v4uu6+xjdzHcxqgEzM9ID7fMw0c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K4pPewD4PLTCDsXjQCcMG4KLyz3AcJAoC4qZmowpJgMTNfUqPnqcX34xngPCxqZ34
         +pf7lFJJcEGidBoJbqADFanX8G39mCXjQa3wwdMQmIIThJ/zUk2Hp41JQnei1NEadI
         KSlc8xfT6pjurxIpX0E1crMOOAWqxxlZ55TyXvKBhcVgK7zmkzIjNplTXoqugwWw8K
         z9MNKANH8VX9/jCjgLubHghLuP1vVxGAxy7H2TXzV7yUKlQ/2iq0zw6re8+YgQYfpF
         HBiniTxWitMWHSOYGgWx81mDwlO3G9r/9/8qkS4swjZqtIKtoBQbNYFnm/CYXDpsrG
         4yUecb8vrNY8g==
Received: by mail-wm1-f54.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so1752930wmb.1;
        Wed, 23 Feb 2022 11:38:47 -0800 (PST)
X-Gm-Message-State: AOAM532tveEhQbGknyzSixWYuiF5zq4Og4OrH/z4DhFllmgzyFZvYUfO
        12zU46vkgWSYmupZlLFbC15+KOXDilWcndUCTpo=
X-Google-Smtp-Source: ABdhPJwQGbMOSGQ1aenegVucA4HjmtVArjSrN+7GuE2HssRPE0CBgTRXQhOiUfeXYINVXn3mD3MKRRi+Z1eQ/xLyz74=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr8889086wms.82.1645645126440; Wed, 23
 Feb 2022 11:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20220208215232.491780-1-anna@kernel.org> <20220208215232.491780-3-anna@kernel.org>
 <20220223165426.GG8288@magnolia>
In-Reply-To: <20220223165426.GG8288@magnolia>
From:   Anna Schumaker <anna@kernel.org>
Date:   Wed, 23 Feb 2022 14:38:30 -0500
X-Gmail-Original-Message-ID: <CAFX2Jfmfhh3NVtC3gE6pCtqdh3oy5LiHqTa2-Ggk995j-g8akA@mail.gmail.com>
Message-ID: <CAFX2Jfmfhh3NVtC3gE6pCtqdh3oy5LiHqTa2-Ggk995j-g8akA@mail.gmail.com>
Subject: Re: [PATCH 2/4] generic/531: Move test from 'quick' group to 'stress'
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

On Wed, Feb 23, 2022 at 11:54 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Tue, Feb 08, 2022 at 04:52:30PM -0500, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > The comment up top says this is a stress test, so at the very least it
> > should be added to this group. As for removing it from the quick group,
> > making this test variable on the number of CPUs means this test could
> > take a very long time to finish (I'm unsure exactly how long on NFS v4.1
> > because I usually kill it after a half hour or so)
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> > I have thought of two alternatives to this patch that would work for me:
> >   1) Could we add an _unsupported_fs function which is the opposite of
> >      _supported_fs to prevent tests from running on specific filesystems?
> >   2) Would it be okay to check if $FSTYP == "nfs" when setting nr_cpus,
> >      and set it to 1 instead? Perhaps through a function in common/rc
> >      that other tests can use if they scale work based on cpu-count?
>
> How about we create a function to estimate fs threading scalability?
> There are probably (simple) filesystems out there with a Big Filesystem
> Lock that won't benefit from more CPUs pounding on it...
>
> # Estimate how many writer threads we should start to stress test this
> # type of filesystem.
> _estimate_threading_factor() {
>         case "$FSTYP" in
>         "nfs")
>                 echo 1;;
>         *)
>                 echo $((2 * $(getconf _NPROCESSORS_ONLN) ));;
>         esac
> }
>
> and later:
>
> nr_cpus=$(_estimate_threading_factor)
>
> Once something like this is landed, we can customize for each FSTYP.  I
> suspect that XFS on spinning rust might actually want "2" here, not
> nr_cpus*2, given the sporadic complaints about this test taking much
> longer for a few people.

Sure. Should I do a `git grep` for "nr_cpus" on the other tests and
update them all at the same time, or just leave it with this one file
to start?

Anna
>
> > ---
> >  tests/generic/531 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/generic/531 b/tests/generic/531
> > index 5e84ca977b44..62e3cac92423 100755
> > --- a/tests/generic/531
> > +++ b/tests/generic/531
> > @@ -12,7 +12,7 @@
> >  # Use every CPU possible to stress the filesystem.
> >  #
> >  . ./common/preamble
> > -_begin_fstest auto quick unlink
> > +_begin_fstest auto stress unlink
>
> As for this change itself,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>
> --D
>
>
> >  testfile=$TEST_DIR/$seq.txt
> >
> >  # Import common functions.
> > --
> > 2.35.1
> >
