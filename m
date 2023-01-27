Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A627867EBAE
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 17:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjA0Qym (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 11:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjA0Qyh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 11:54:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AEE7FA2F
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 08:54:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A86961D0B
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 16:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B00C433A0;
        Fri, 27 Jan 2023 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674838459;
        bh=UAovYgajuEo/hozkHLtx+54MFgqb2fTVlx5kWCuyZ5U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ToMix8AucE7eqouM87jQuC7b/IZfxnycQ0RW/OsyvSGQfRXXJPSP6sET33CimLfNT
         2mnDnLamSBNsbvpl0GpnhpPxbRgsh6oWuuAmpQJnQRS1UTwHmoOdWT7hbeGkPGEJTf
         MAUrbkgu+hzhmfocaRJIl78aPArqU2+KvuyxqH65AFZqWzXE0dYkc6i7rXqZzG2ryI
         BdAlHoSP7hY/Ue9hQ6f5CFJErHu3NAbELgL61psMTJndr2LKQOIwT1alfr7H5Vk+Lw
         2D/DXCRB/EpFKO3TkP12WE/F+4kMMsZilIPzSDBMreXgGFxOq4zZbX0Lus/+9FFXfa
         6byQiVeU95aoQ==
Message-ID: <65f5cf4e367dd90692580bcf8c31c9f72b0fb633.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't hand out delegation on setuid files being
 opened for write
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Boyang Xue <bxue@redhat.com>
Date:   Fri, 27 Jan 2023 11:54:17 -0500
In-Reply-To: <63A8B84E-EEBC-4AC8-AADA-DD05B59D2C30@oracle.com>
References: <20230127120933.7056-1-jlayton@kernel.org>
         <D439961A-3E64-425F-8385-E5179325576C@oracle.com>
         <869327c01b6cc76d02b0dbc1c0e3a1170fd04dd4.camel@kernel.org>
         <78E46DCB-AAAD-4996-98B2-B85087226DFE@oracle.com>
         <7e932c18eb0c6a1e34382fa220a9ff95f3beec4f.camel@kernel.org>
         <63A8B84E-EEBC-4AC8-AADA-DD05B59D2C30@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-01-27 at 16:17 +0000, Chuck Lever III wrote:
>=20
> > On Jan 27, 2023, at 11:12 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2023-01-27 at 15:35 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Jan 27, 2023, at 10:30 AM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > >=20
> > > > On Fri, 2023-01-27 at 15:21 +0000, Chuck Lever III wrote:
> > > > >=20
> > > > > > On Jan 27, 2023, at 7:09 AM, Jeff Layton <jlayton@kernel.org> w=
rote:
> > > > > >=20
> > > > > > We had a bug report that xfstest generic/355 was failing on NFS=
v4.0.
> > > > > > This test sets various combinations of setuid/setgid modes and =
tests
> > > > > > whether DIO writes will cause them to be stripped.
> > > > > >=20
> > > > > > What I found was that the server did properly strip those bits,=
 but
> > > > > > the client didn't notice because it held a delegation that was =
not
> > > > > > recalled. The recall didn't occur because the client itself was=
 the
> > > > > > one generating the activity and we avoid recalls in that case.
> > > > > >=20
> > > > > > Clearing setuid bits is an "implicit" activity. The client didn=
't
> > > > > > specifically request that we do that, so we need the server to =
issue a
> > > > > > CB_RECALL, or avoid the situation entirely by not issuing a del=
egation.
> > > > > >=20
> > > > > > The easiest fix here is to simply not give out a delegation if =
the file
> > > > > > is being opened for write, and the mode has the setuid and/or s=
etgid bit
> > > > > > set. Note that there is a potential race between the mode and l=
ease
> > > > > > being set, so we test for this condition both before and after =
setting
> > > > > > the lease.
> > > > > >=20
> > > > > > This patch fixes generic/355, generic/683 and generic/684 for m=
e.
> > > > >=20
> > > > > generic/355 2s ...  1s
> > > > >=20
> > > >=20
> > > > I should note that 355 only fails with vers=3D4.0. On 4.1+ the clie=
nt
> > > > specifies that it doesn't want a delegation (as this test is doing =
DIO).
> > >=20
> > > I used a NFSv4.0 mount for the test.
> > >=20
> > >=20
> > > > > That's good.
> > > > >=20
> > > > > generic/683 2s ... [not run] xfs_io falloc  failed (old kernel/wr=
ong fs?)
> > > > > generic/684 2s ... [not run] xfs_io fpunch  failed (old kernel/wr=
ong fs?)
> > > > >=20
> > > > > What am I doing wrong?
> > > > >=20
> > > > >=20
> > > >=20
> > > > Not sure here. This test requires v4.2, but the client and server s=
hould
> > > > negotiate that. You might need to run the test by hand and see what=
 it
> > > > outputs. i.e.:
> > > >=20
> > > >   $ sudo ./tests/generic/683
> > >=20
> > > Then, these two failed only for NFSv4.2 and are not run for other
> > > minor versions. For some reason I thought this was an NFSv4.0-only
> > > bug.
> > >=20
> >=20
> > Ok, that's expected. I should have been more clear. 355 only fails on
> > v4.0 only, but 683 and 684 require v4.2 to run and fail.
>=20
> I'll add that clarification to the patch description.
>=20

Thanks!

>=20
> > The cause of all 3 failures are the same though, and this patch should
> > fix it.
>=20
> Since this regression has been around for a bit, I plan to apply
> the fix to nfsd-next. Anyone who wants it backported to stable can
> apply it and test it -- I'm going to leave off a Cc: stable or Fixes:.
>=20

I think that sounds reasonable. Setuid files are pretty rare overall,
and this only affects the writing client's perception of them.

It's hard to nail down a Fixes: for this. I suspect the regression came
about once we stopped recalling delegations for activity by the same
client, but I haven't tested that theory.
--=20
Jeff Layton <jlayton@kernel.org>
