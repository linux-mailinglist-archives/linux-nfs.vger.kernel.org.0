Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34C6A0E61
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 18:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBWRK5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 12:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWRK5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 12:10:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852D73B841
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 09:10:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33DC9B8198C
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 17:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B60C433D2;
        Thu, 23 Feb 2023 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172249;
        bh=SoJaSBcKbVogoZATjmjkhnWm8zZDk4z4SRUE3K5MpC8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OKwIgtMycnjwL6adZJ2t8AUu3qRuyZrO5cy/PJSS6RPJSCKRDC4GdOG3pwxmWeo1M
         zy8rMLlzn7q3Fh3+ya9vXZBIhz+ZXAimkfrPWdhA3gx6hAig0YrEEsoIYb4Lb1f23N
         Os+vTJFuFLOq+D/7JQ7jn1vJyCRpfoqISXypxBdJg6s8XDYM8pmfe4syPbR81DZ8tp
         xiBfYfnFwtqfc/+LMruzhnTK3pMUvJzdBz7oJQFPIsX+m3yqHpGLfIlXRom4QSgAYs
         CTqGr8Ke7zUOM+fcosAg/H0+34xbVHXRpMZ0YsnusO/2OdVIXcyMlXeizyopQtnyH+
         F9F4rOoKpsFuQ==
Message-ID: <fabf62538a93fda344c05b1a07c1298e7f3199bb.camel@kernel.org>
Subject: Re: [pynfs RFC PATCH] testserver.py: special-case the "all" flag
From:   Jeff Layton <jlayton@kernel.org>
To:     Frank Filz <ffilzlnx@mindspring.com>,
        'Chuck Lever III' <chuck.lever@oracle.com>,
        'Bruce Fields' <bfields@fieldses.org>
Cc:     'Dai Ngo' <dai.ngo@oracle.com>,
        'Linux NFS Mailing List' <linux-nfs@vger.kernel.org>,
        'Calum Mackay' <calum.mackay@oracle.com>
Date:   Thu, 23 Feb 2023 12:10:47 -0500
In-Reply-To: <029a01d947a3$a51b4750$ef51d5f0$@mindspring.com>
References: <20230222182043.155712-1-jlayton@kernel.org>
         <20230223151959.GC10456@fieldses.org>
         <3B034712-F376-4D71-8A72-703B030140F9@oracle.com>
         <029a01d947a3$a51b4750$ef51d5f0$@mindspring.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-02-23 at 08:26 -0800, Frank Filz wrote:
>=20
> > -----Original Message-----
> > From: Chuck Lever III [mailto:chuck.lever@oracle.com]
> > Sent: Thursday, February 23, 2023 8:22 AM
> > To: Bruce Fields <bfields@fieldses.org>
> > Cc: Jeff Layton <jlayton@kernel.org>; Dai Ngo <dai.ngo@oracle.com>; Lin=
ux
> > NFS Mailing List <linux-nfs@vger.kernel.org>; Calum Mackay
> > <calum.mackay@oracle.com>; Frank Filz <ffilzlnx@mindspring.com>
> > Subject: Re: [pynfs RFC PATCH] testserver.py: special-case the "all" fl=
ag
> >=20
> >=20
> >=20
> > > On Feb 23, 2023, at 10:19 AM, J. Bruce Fields <bfields@fieldses.org>
> wrote:
> > >=20
> > > On Wed, Feb 22, 2023 at 01:20:43PM -0500, Jeff Layton wrote:
> > > > The READMEs for v4.0 and v4.1 are inconsistent here. For v4.0, the
> "all"
> > > > flag is supposed to run all of the "standard" tests. For v4.1 "all"
> > > > is documented to run all of the tests, but it actually doesn't sinc=
e
> > > > not every tests has "all" in its FLAGS: field.
> > > >=20
> > > > I move that we change this. If I say that I want to run "all", then=
 I
> > > > really do want to run _all_ of the tests. Ensure that every test ha=
s
> > > > the "all" flag set.
> > >=20
> > > In some (all?) cases where the "all" flag was left off, it was
> > > intentional.
> > >=20
> > > We try not to flag spec-compliant servers as failing, because people
> > > are sometimes a little careless about "fixing" failures that in their
> > > particular case really shouldn't be fixed.  But sometimes it's still
> > > useful to have a test that goes somewhat beyond the spec.
> > >=20
> > > There might be other ways to handle that kind of test, but it would
> > > need some more thought.
> >=20
> > We could use a different name for "all" since it doesn't actually run
> /all/ tests.
> > Jeff suggested "standard", which seems sensible.
>=20
> The challenge with changing this is all the CI scripts and other testing
> scripts out there that use all. If all suddenly changed, server maintaine=
rs
> might get a deluge of bug reports for failing odd test cases no one
> necessarily expected to work...
>=20

Are those CI systems pulling down the upstream tree to run? How do they
contend with new tests that might suddenly show up as part of "all"?

> > Also, we could add test categories specifically for particular server
> > implementations, if that's interesting to folks.
>=20
> I have already done so with a ganesha tag...
>=20
> Literally all anyone has to do is start using a new tag so it's a trivial
> thing for developers to add.
>=20

The problem is that you have to add the tag to hundreds of tests. It's
scriptable, sure, but if you want to be at all selective, it's not
trivial.

That said, I'm open to doing something different here. Maybe we could
declare a new "everything" special case instead? It's confusing naming,
but that would at least preserve the existing behavior for those CI
systems.

> >=20
> > > --b.
> > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > nfs4.1/testmod.py | 2 ++
> > > > 1 file changed, 2 insertions(+)
> > > >=20
> > > > If this is unacceptable, then an alternative could be to add a new
> > > > (similarly special-cased) "everything" flag.
> > > >=20
> > > > diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py index
> > > > 11e759d673fd..7b3bac543084 100644
> > > > --- a/nfs4.1/testmod.py
> > > > +++ b/nfs4.1/testmod.py
> > > > @@ -386,6 +386,8 @@ def createtests(testdir):
> > > >     for t in tests:
> > > > ##         if not t.flags_list:
> > > > ##             raise RuntimeError("%s has no flags" % t.fullname)
> > > > +        if "all" not in t.flags_list:
> > > > +            t.flags_list.append("all")
> > > >         for f in t.flags_list:
> > > >             if f not in flag_dict:
> > > >                 flag_dict[f] =3D bit
> > > > --
> > > > 2.39.2
> >=20
> > --
> > Chuck Lever
> >=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
