Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D04C22F3
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 05:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiBXEOt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 23:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBXEOs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 23:14:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B391923A1A5;
        Wed, 23 Feb 2022 20:14:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57D25B821CD;
        Thu, 24 Feb 2022 04:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCB0C340E9;
        Thu, 24 Feb 2022 04:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645676056;
        bh=duXreLDG7fFLuDafK9lAiAc6Pa1xpMj8KZPXZphy+gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UqN+6Ug2W6ywgubYeFU/fOTTE6zNnKYpCF0oy2stgbTQpENMrkEw13hVwdXd5SgiE
         rizfzemvJe38DNI/NIxKv7L5WmoCZ+/gBVdJKZecsJBXreQ6FJgGxJnkpbjx3G7bIY
         RXt+e+UaSlpWny3paLjrEqfZNc7BtTAApWlNpcU1rWlbNBxI3lV8Uxkd94KvW/xQng
         wUB1rfYZAHe7VHShpq4QlMtQ6pOMlIHSl10pF6eDmdtk8W0cIyazFKhbvdb2F4oUJW
         qf4wBj1UetEQtGDkobG+rfCLCwF6htMp40fyYbt4ODusKVjXSlvR4U2T46GwX9Iibr
         x8QQ6CXnn8Wqw==
Date:   Wed, 23 Feb 2022 20:14:15 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anna Schumaker <anna@kernel.org>
Cc:     fstests@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] generic/531: Move test from 'quick' group to 'stress'
Message-ID: <20220224041415.GI8288@magnolia>
References: <20220208215232.491780-1-anna@kernel.org>
 <20220208215232.491780-3-anna@kernel.org>
 <20220223165426.GG8288@magnolia>
 <CAFX2Jfmfhh3NVtC3gE6pCtqdh3oy5LiHqTa2-Ggk995j-g8akA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2Jfmfhh3NVtC3gE6pCtqdh3oy5LiHqTa2-Ggk995j-g8akA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 23, 2022 at 02:38:30PM -0500, Anna Schumaker wrote:
> On Wed, Feb 23, 2022 at 11:54 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Tue, Feb 08, 2022 at 04:52:30PM -0500, Anna Schumaker wrote:
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > The comment up top says this is a stress test, so at the very least it
> > > should be added to this group. As for removing it from the quick group,
> > > making this test variable on the number of CPUs means this test could
> > > take a very long time to finish (I'm unsure exactly how long on NFS v4.1
> > > because I usually kill it after a half hour or so)
> > >
> > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > > ---
> > > I have thought of two alternatives to this patch that would work for me:
> > >   1) Could we add an _unsupported_fs function which is the opposite of
> > >      _supported_fs to prevent tests from running on specific filesystems?
> > >   2) Would it be okay to check if $FSTYP == "nfs" when setting nr_cpus,
> > >      and set it to 1 instead? Perhaps through a function in common/rc
> > >      that other tests can use if they scale work based on cpu-count?
> >
> > How about we create a function to estimate fs threading scalability?
> > There are probably (simple) filesystems out there with a Big Filesystem
> > Lock that won't benefit from more CPUs pounding on it...
> >
> > # Estimate how many writer threads we should start to stress test this
> > # type of filesystem.
> > _estimate_threading_factor() {
> >         case "$FSTYP" in
> >         "nfs")
> >                 echo 1;;
> >         *)
> >                 echo $((2 * $(getconf _NPROCESSORS_ONLN) ));;
> >         esac
> > }
> >
> > and later:
> >
> > nr_cpus=$(_estimate_threading_factor)
> >
> > Once something like this is landed, we can customize for each FSTYP.  I
> > suspect that XFS on spinning rust might actually want "2" here, not
> > nr_cpus*2, given the sporadic complaints about this test taking much
> > longer for a few people.
> 
> Sure. Should I do a `git grep` for "nr_cpus" on the other tests and
> update them all at the same time, or just leave it with this one file
> to start?

Ugh, what a mess...

Unbeknownst to me, "$here/src/feature -o" also returns the CPU count.
If you want to get started on fixing other tests, I'd say ... add the
new helper here for this test, and attach any other conversions as new
patches at the end of the series.

--D

> Anna
> >
> > > ---
> > >  tests/generic/531 | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tests/generic/531 b/tests/generic/531
> > > index 5e84ca977b44..62e3cac92423 100755
> > > --- a/tests/generic/531
> > > +++ b/tests/generic/531
> > > @@ -12,7 +12,7 @@
> > >  # Use every CPU possible to stress the filesystem.
> > >  #
> > >  . ./common/preamble
> > > -_begin_fstest auto quick unlink
> > > +_begin_fstest auto stress unlink
> >
> > As for this change itself,
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> >
> > --D
> >
> >
> > >  testfile=$TEST_DIR/$seq.txt
> > >
> > >  # Import common functions.
> > > --
> > > 2.35.1
> > >
