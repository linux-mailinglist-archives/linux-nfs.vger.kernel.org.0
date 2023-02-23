Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A932E6A12EB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 23:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjBWWnc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 17:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBWWnb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 17:43:31 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 14:43:30 PST
Received: from mta-201a.earthlink-vadesecure.net (mta-201b.earthlink-vadesecure.net [51.81.229.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BBB4C2C
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 14:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=l90jKrPo8JaGDYSZmIt+zfKjlxTkTddc0YH5ar
 3XNws=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1677192200;
 x=1677797000; b=WAsEqmtjZC8NViT37rwLdQhYHU9Mme07WFRLEvNDSo5flgbj81m3VTq
 bZ6DwypnvaKJ3iwlAbBjiVX3gQ/yiyd6zEeC3652OPQ2lb9UdMWhAz5+lxY4xggS5sYGYxN
 MqsdHYhggMQUGoNYObKAxNqAw7qv2jPgL+GpwPH21/xvO7QNIXxhQd2x2YYlqBKNmP95TQZ
 91NTVMtGHeE6/zkcmxmXCaBrleM94N5n5MB6z7ciXXQV5BmwC85g99o+rpt5uWEByMmM+Kj
 iFmL30aaVXtoiC+E0mIUXkpTO7WQfdgSYDPxgZ8o/XA5A6UYU2GtwMICmy+DnVSuy6ZDMsN
 UlQ==
Received: from FRANKSTHINKPAD ([174.174.49.201])
 by smtp.earthlink-vadesecure.net ESMTP vsel2nmtao01p with ngmta
 id fb4d1d98-1746956b828a13b7; Thu, 23 Feb 2023 22:43:20 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Mkrtchyan, Tigran'" <tigran.mkrtchyan@desy.de>,
        "'Jeff Layton'" <jlayton@kernel.org>
Cc:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'Dai Ngo'" <dai.ngo@oracle.com>,
        "'linux-nfs'" <linux-nfs@vger.kernel.org>
References: <20230222134952.32851-1-jlayton@kernel.org> <029901d947a3$0dd00c00$29702400$@mindspring.com> <bc8ab54d427e62f17f46022980bfcaf392e0a0c3.camel@kernel.org> <1292079534.40950670.1677181082600.JavaMail.zimbra@desy.de>
In-Reply-To: <1292079534.40950670.1677181082600.JavaMail.zimbra@desy.de>
Subject: RE: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error when tests fail
Date:   Thu, 23 Feb 2023 14:43:20 -0800
Message-ID: <02c401d947d8$3ac30e30$b0492a90$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQInBvp4ShtorjsaZdmfQzq7ERPYuwNLYFcJAXdoi1oCBUJXSK4LYaGA
Content-Language: en-us
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> -----Original Message-----
> From: Mkrtchyan, Tigran [mailto:tigran.mkrtchyan@desy.de]
> Sent: Thursday, February 23, 2023 11:38 AM
> To: Jeff Layton <jlayton@kernel.org>
> Cc: Frank Filz <ffilzlnx@mindspring.com>; J. Bruce Fields =
<bfields@fieldses.org>;
> Dai Ngo <dai.ngo@oracle.com>; linux-nfs <linux-nfs@vger.kernel.org>
> Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an =
error when
> tests fail
>=20
>=20
>=20
> ----- Original Message -----
> > From: "Jeff Layton" <jlayton@kernel.org>
> > To: "Frank Filz" <ffilzlnx@mindspring.com>, "J. Bruce Fields"
> <bfields@fieldses.org>, "Dai Ngo" <dai.ngo@oracle.com>
> > Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> > Sent: Thursday, 23 February, 2023 18:08:19
> > Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an =
error
> when tests fail
>=20
> > On Thu, 2023-02-23 at 08:22 -0800, Frank Filz wrote:
> >> > From: Jeff Layton [mailto:jlayton@kernel.org]
> >>
> >> > This script was originally changed in eb3ba0b60055 ("Have
> >> > testserver.py
> >> have
> >> > non-zero exit code if any tests fail"), but the same change =
wasn't
> >> > made to
> >> the
> >> > 4.1 testserver.py script.
> >> >
> >> > There also wasn't much explanation for it, and it makes it =
difficult
> >> > to
> >> tell
> >> > whether the test harness itself failed, or whether there was a
> >> > failure in
> >> a
> >> > requested test.
> >> >
> >> > Stop the 4.0 testserver.py from exiting with an error code when a
> >> > test
> >> fails, so
> >> > that a successful return means only that the test harness itself
> >> > worked,
> >> not that
> >> > every requested test passed.
> >> >
> >> > Cc: Frank Filz <ffilzlnx@mindspring.com>
> >> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >> > ---
> >> >  nfs4.0/testserver.py | 2 --
> >> >  1 file changed, 2 deletions(-)
> >> >
> >> > I'm not sure about this one. I've worked around this in kdevops =
for
> >> > now,
> >> but it
> >> > would really be preferable if it worked this way, imo. If this =
isn't
> >> acceptable,
> >> > maybe we can add a new option that enables this behavior?
> >> >
> >> > Frank, what was the original rationale for eb3ba0b60055 ?
> >>
> >> We needed a way for CI to easily detect failure of pynfs. I'm not =
sure
> >> how
> >> helpful it is since Ganesha does fail some tests...
> >>
> >> It might be helpful to have some helpers for CI to use, or an =
option
> >> that
> >> causes pynfs to report in a way that's much easier for CI to =
determine
> >> if
> >> pynfs succeeded or not.
> >>
> >
> > That's exactly the issue I had when working with this for kdevops. =
It
> > runs testserver.py via ansible, and when it gets a non-zero exit =
code,
> > the run aborts without doing anything further. I have it ignoring =
the
> > return code from testserver.py for now, but that's not ideal since I
> > can't catch actual problems with the test harness.
> >
> > I have testserver.py output the result to JSON, and then analyze =
that to
> > see if anything failed. That also gives us what you were asking for =
in
> > your other email -- the ability to filter out known failures. Here's
> > what I have so far, but I'd like to expand it to highlight other
> > behavior changes:
> >
> > https://github.com/linux-
> =
kdevops/kdevops/blob/master/scripts/workflows/pynfs/check_pynfs_results.p=
y
> >
> > It may make sense to move that script into pynfs itself.
> >
> > If there is CI that depends on this behavior, then I'd be interested =
to
> > hear how they are dealing with failed tests. Do they just not run =
the
> > tests that always fail?
>=20
>=20
> Same here... The test generates for us xunit report, thus error code =
is in the
> reporting and we always have to run it as:
>=20
> ```
> ./testserver.py -v --noinit =
--xml=3D"${WORKSPACE}/xunit-report-v41.xml"
> ${SUT}:${TEST_PATH} all $NFS41_INCLUDES $NFS41_EXCLUDES_OPTION ||
> true
> ```

OK, maybe we just need to revert this behavior. Honestly, I'm not sure =
that the Ganesha CI are in good shape so if this reversion prompts =
examination of why things aren't working as expected, well, then we just =
need to revisit those things.

I still would argue against changing the meaning of "all"...

Frank

> >
> >> Hmm, one thing that would help is to be able to flag a set of tests
> >> that
> >> should not constitute a CI failure (known errors) but we want to =
keep
> >> running them because of what they exercise, or to more readily =
detect
> >> that
> >> they have been fixed.
>=20
> yeah, an option might do the job.
>=20
> Tigran.
>=20
> >>
> >
> > The right way to do that is the same way that xfstests works. You =
test
> > for the conditions being favorable for a test and then just skip it =
if
> > they aren't.
> >
> >> > diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py index
> >> > f2c41568e5c7..4f4286daa657 100755
> >> > --- a/nfs4.0/testserver.py
> >> > +++ b/nfs4.0/testserver.py
> >> > @@ -387,8 +387,6 @@ def main():
> >> >
> >> >      if nfail < 0:
> >> >          sys.exit(3)
> >> > -    if nfail > 0:
> >> > -        sys.exit(2)
> >> >
> >> >  if __name__ =3D=3D "__main__":
> >> >      main()
> >> > --
> >> > 2.39.2
> >>
> >
> > --
> > Jeff Layton <jlayton@kernel.org>

