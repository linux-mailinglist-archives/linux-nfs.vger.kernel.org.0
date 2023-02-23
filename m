Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA56A0E54
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 18:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBWRIY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 12:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWRIX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 12:08:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526995249
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 09:08:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3C5B6174E
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 17:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C72C433D2;
        Thu, 23 Feb 2023 17:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677172101;
        bh=0cL+Aij9K4UBHsR+SEoLBuFZE6q9xnF6Ak5G2Yqm9Yk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JnQJmQEezFTjeVDIpT/0ZCg2z2x+c1vU03euhs978+ZqjKJScT1zFEwOFrZM3nXM9
         AoZ/5viAJAmcn5MmmgCy3szl6PT3t/PtsprqbxzOHw77mv8z4hVGO9L1zKsamoDO6o
         lO3MQP+vynfHjJFU6tdlzUH1s7KRrDdR5XVPeIp+YK+wMTI+aImR8S27Peh5c4/nnQ
         X5Kq9QCOi0+MPvBFXinInetCy0Z98ubnEL41RfcXDl+qf4HxiiGAPngOBpCNQPaurd
         JU9KRdJYQ+EEC4kxMuaVDhAeFyKXGWO+Ntxxi8mEceOTj3mzrhpES3hTBIpN+OTLzj
         Z21fKGovxp/1Q==
Message-ID: <bc8ab54d427e62f17f46022980bfcaf392e0a0c3.camel@kernel.org>
Subject: Re: [pynfs RFC PATCH] nfs4.0/testserver.py: don't return an error
 when tests fail
From:   Jeff Layton <jlayton@kernel.org>
To:     Frank Filz <ffilzlnx@mindspring.com>, bfields@fieldses.org,
        dai.ngo@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 23 Feb 2023 12:08:19 -0500
In-Reply-To: <029901d947a3$0dd00c00$29702400$@mindspring.com>
References: <20230222134952.32851-1-jlayton@kernel.org>
         <029901d947a3$0dd00c00$29702400$@mindspring.com>
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

On Thu, 2023-02-23 at 08:22 -0800, Frank Filz wrote:
> > From: Jeff Layton [mailto:jlayton@kernel.org]
> =A0
> > This script was originally changed in eb3ba0b60055 ("Have
> > testserver.py
> have
> > non-zero exit code if any tests fail"), but the same change wasn't
> > made to
> the
> > 4.1 testserver.py script.
> >=20
> > There also wasn't much explanation for it, and it makes it difficult
> > to
> tell
> > whether the test harness itself failed, or whether there was a
> > failure in
> a
> > requested test.
> >=20
> > Stop the 4.0 testserver.py from exiting with an error code when a
> > test
> fails, so
> > that a successful return means only that the test harness itself
> > worked,
> not that
> > every requested test passed.
> >=20
> > Cc: Frank Filz <ffilzlnx@mindspring.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > =A0nfs4.0/testserver.py | 2 --
> > =A01 file changed, 2 deletions(-)
> >=20
> > I'm not sure about this one. I've worked around this in kdevops for
> > now,
> but it
> > would really be preferable if it worked this way, imo. If this isn't
> acceptable,
> > maybe we can add a new option that enables this behavior?
> >=20
> > Frank, what was the original rationale for eb3ba0b60055 ?
>=20
> We needed a way for CI to easily detect failure of pynfs. I'm not sure
> how
> helpful it is since Ganesha does fail some tests...
>=20
> It might be helpful to have some helpers for CI to use, or an option
> that
> causes pynfs to report in a way that's much easier for CI to determine
> if
> pynfs succeeded or not.
>=20

That's exactly the issue I had when working with this for kdevops. It
runs testserver.py via ansible, and when it gets a non-zero exit code,
the run aborts without doing anything further. I have it ignoring the
return code from testserver.py for now, but that's not ideal since I
can't catch actual problems with the test harness.

I have testserver.py output the result to JSON, and then analyze that to
see if anything failed. That also gives us what you were asking for in
your other email -- the ability to filter out known failures. Here's
what I have so far, but I'd like to expand it to highlight other
behavior changes:
=20
https://github.com/linux-kdevops/kdevops/blob/master/scripts/workflows/pynf=
s/check_pynfs_results.py

It may make sense to move that script into pynfs itself.

If there is CI that depends on this behavior, then I'd be interested to
hear how they are dealing with failed tests. Do they just not run the
tests that always fail?

> Hmm, one thing that would help is to be able to flag a set of tests
> that
> should not constitute a CI failure (known errors) but we want to keep
> running them because of what they exercise, or to more readily detect
> that
> they have been fixed.
>=20

The right way to do that is the same way that xfstests works. You test
for the conditions being favorable for a test and then just skip it if
they aren't.

> > diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py index
> > f2c41568e5c7..4f4286daa657 100755
> > --- a/nfs4.0/testserver.py
> > +++ b/nfs4.0/testserver.py
> > @@ -387,8 +387,6 @@ def main():
> >=20
> > =A0=A0=A0=A0=A0if nfail < 0:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0sys.exit(3)
> > -    if nfail > 0:
> > -        sys.exit(2)
> >=20
> > =A0if __name__ =3D=3D "__main__":
> > =A0=A0=A0=A0=A0main()
> > --
> > 2.39.2
>=20

--=20
Jeff Layton <jlayton@kernel.org>
