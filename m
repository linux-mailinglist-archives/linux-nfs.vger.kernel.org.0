Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A0C67E97A
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 16:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjA0Pap (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 10:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjA0Pao (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 10:30:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D29621959
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 07:30:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C83360C27
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 15:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFF6C433EF;
        Fri, 27 Jan 2023 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674833443;
        bh=mE5aP2Q7IBNdA76OW0mHHE6bMLghunGPfUP21DsniDI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JXh7lncnaFAeOXRBiKNPm/AbL+wdd9UIr0gC/pvghORxnt00CymjqWuIQgm6LGhL7
         E3Ob9zjombNo5y+V0MGopoL9DtAy4bCaWq/2+6m/tcOmCPjJPtUjYyOxS91g4gwmDN
         baA4aRjgpZ3T/C8D9LPmvwiD9CXxN9uxPLI/nUxkHkNtkWuoBsXHhYzcW9aOQb6aqm
         +Wdo8IdxAg5zuPvRsEH0UT4m1r3yeRzUbKbhiFtvYx0QwuIX4Ck5Lwlu7PHbor0gXB
         /EzY6Jt2gLLqlKfFLqqSQZZnIjNq8foLw4q7zefi6loBFlU+YF9ZL2AWOoB8+xJJFN
         zSr/Q6Rie/IjQ==
Message-ID: <869327c01b6cc76d02b0dbc1c0e3a1170fd04dd4.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't hand out delegation on setuid files being
 opened for write
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Boyang Xue <bxue@redhat.com>
Date:   Fri, 27 Jan 2023 10:30:41 -0500
In-Reply-To: <D439961A-3E64-425F-8385-E5179325576C@oracle.com>
References: <20230127120933.7056-1-jlayton@kernel.org>
         <D439961A-3E64-425F-8385-E5179325576C@oracle.com>
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

On Fri, 2023-01-27 at 15:21 +0000, Chuck Lever III wrote:
>=20
> > On Jan 27, 2023, at 7:09 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > We had a bug report that xfstest generic/355 was failing on NFSv4.0.
> > This test sets various combinations of setuid/setgid modes and tests
> > whether DIO writes will cause them to be stripped.
> >=20
> > What I found was that the server did properly strip those bits, but
> > the client didn't notice because it held a delegation that was not
> > recalled. The recall didn't occur because the client itself was the
> > one generating the activity and we avoid recalls in that case.
> >=20
> > Clearing setuid bits is an "implicit" activity. The client didn't
> > specifically request that we do that, so we need the server to issue a
> > CB_RECALL, or avoid the situation entirely by not issuing a delegation.
> >=20
> > The easiest fix here is to simply not give out a delegation if the file
> > is being opened for write, and the mode has the setuid and/or setgid bi=
t
> > set. Note that there is a potential race between the mode and lease
> > being set, so we test for this condition both before and after setting
> > the lease.
> >=20
> > This patch fixes generic/355, generic/683 and generic/684 for me.
>=20
> generic/355 2s ...  1s
>=20

I should note that 355 only fails with vers=3D4.0. On 4.1+ the client
specifies that it doesn't want a delegation (as this test is doing DIO).

> That's good.
>=20
> generic/683 2s ... [not run] xfs_io falloc  failed (old kernel/wrong fs?)
> generic/684 2s ... [not run] xfs_io fpunch  failed (old kernel/wrong fs?)
>=20
> What am I doing wrong?
>=20
>=20

Not sure here. This test requires v4.2, but the client and server should
negotiate that. You might need to run the test by hand and see what it
outputs. i.e.:

    $ sudo ./tests/generic/683


> > Reported-by: Boyang Xue <bxue@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/nfs4state.c | 27 +++++++++++++++++++++++++++
> > 1 file changed, 27 insertions(+)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index e61b878a4b45..ace02fd0d590 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5421,6 +5421,23 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open *ope=
n, struct nfs4_file *fp,
> > 	return 0;
> > }
> >=20
> > +/*
> > + * We avoid breaking delegations held by a client due to its own activ=
ity, but
> > + * clearing setuid/setgid bits on a write is an implicit activity and =
the client
> > + * may not notice and continue using the old mode. Avoid giving out a =
delegation
> > + * on setuid/setgid files when the client is requesting an open for wr=
ite.
> > + */
> > +static int
> > +nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_file *n=
f)
> > +{
> > +	struct inode *inode =3D file_inode(nf->nf_file);
> > +
> > +	if ((open->op_share_access & NFS4_SHARE_ACCESS_WRITE) &&
> > +	    (inode->i_mode & (S_ISUID|S_ISGID)))
> > +		return -EAGAIN;
> > +	return 0;
> > +}
> > +
> > static struct nfs4_delegation *
> > nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *st=
p,
> > 		    struct svc_fh *parent)
> > @@ -5454,6 +5471,8 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
> > 	spin_lock(&fp->fi_lock);
> > 	if (nfs4_delegation_exists(clp, fp))
> > 		status =3D -EAGAIN;
> > +	else if (nfsd4_verify_setuid_write(open, nf))
> > +		status =3D -EAGAIN;
> > 	else if (!fp->fi_deleg_file) {
> > 		fp->fi_deleg_file =3D nf;
> > 		/* increment early to prevent fi_deleg_file from being
> > @@ -5494,6 +5513,14 @@ nfs4_set_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp,
> > 	if (status)
> > 		goto out_unlock;
> >=20
> > +	/*
> > +	 * Now that the deleg is set, check again to ensure that nothing
> > +	 * raced in and changed the mode while we weren't lookng.
> > +	 */
> > +	status =3D nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
> > +	if (status)
> > +		goto out_unlock;
> > +
> > 	spin_lock(&state_lock);
> > 	spin_lock(&fp->fi_lock);
> > 	if (fp->fi_had_conflict)
> > --=20
> > 2.39.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
