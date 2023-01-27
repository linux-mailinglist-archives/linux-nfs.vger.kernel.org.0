Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEDD67EA81
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 17:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjA0QNE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 11:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjA0QND (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 11:13:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1276FD10
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 08:13:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED62760BEA
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 16:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09705C433EF;
        Fri, 27 Jan 2023 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674835981;
        bh=PHEI0jw+yAWdOIa8drojOLJutB7aEtp1gCBPTX31v1c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OjlAU450hZvleuCGyZqgXq/sAXTpr8sGx6X3dZHnQwKkbDm0wqs179ltuN/L9xupl
         PmOZ6R2zK7q78qYC6SLjDeEI+geiG+tn0soyN3XHN9Ksu4zhJUG2LrZIKWRsb5vMTT
         XDg4PNbO68o1wrA1so5ZvCdynZrawHwmS5IUB5V1yu+CfGTClMes/dNWXzNDMEYXwe
         NeWWtugjOXVyn96RPQEX6bYwyuTQv9ffOG2kwbyUxFVy6zNluZc97fV7W+y7HaTd3H
         qZtKUzYxhRMgvS74XdHfSlGsBYE/CQb1wa/wDTnAiw4r9mT5KgEys8SS7p5P7/4tId
         FzWX7Z0WVTVIQ==
Message-ID: <7e932c18eb0c6a1e34382fa220a9ff95f3beec4f.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't hand out delegation on setuid files being
 opened for write
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Boyang Xue <bxue@redhat.com>
Date:   Fri, 27 Jan 2023 11:12:59 -0500
In-Reply-To: <78E46DCB-AAAD-4996-98B2-B85087226DFE@oracle.com>
References: <20230127120933.7056-1-jlayton@kernel.org>
         <D439961A-3E64-425F-8385-E5179325576C@oracle.com>
         <869327c01b6cc76d02b0dbc1c0e3a1170fd04dd4.camel@kernel.org>
         <78E46DCB-AAAD-4996-98B2-B85087226DFE@oracle.com>
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

On Fri, 2023-01-27 at 15:35 +0000, Chuck Lever III wrote:
>=20
> > On Jan 27, 2023, at 10:30 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2023-01-27 at 15:21 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Jan 27, 2023, at 7:09 AM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > We had a bug report that xfstest generic/355 was failing on NFSv4.0=
.
> > > > This test sets various combinations of setuid/setgid modes and test=
s
> > > > whether DIO writes will cause them to be stripped.
> > > >=20
> > > > What I found was that the server did properly strip those bits, but
> > > > the client didn't notice because it held a delegation that was not
> > > > recalled. The recall didn't occur because the client itself was the
> > > > one generating the activity and we avoid recalls in that case.
> > > >=20
> > > > Clearing setuid bits is an "implicit" activity. The client didn't
> > > > specifically request that we do that, so we need the server to issu=
e a
> > > > CB_RECALL, or avoid the situation entirely by not issuing a delegat=
ion.
> > > >=20
> > > > The easiest fix here is to simply not give out a delegation if the =
file
> > > > is being opened for write, and the mode has the setuid and/or setgi=
d bit
> > > > set. Note that there is a potential race between the mode and lease
> > > > being set, so we test for this condition both before and after sett=
ing
> > > > the lease.
> > > >=20
> > > > This patch fixes generic/355, generic/683 and generic/684 for me.
> > >=20
> > > generic/355 2s ...  1s
> > >=20
> >=20
> > I should note that 355 only fails with vers=3D4.0. On 4.1+ the client
> > specifies that it doesn't want a delegation (as this test is doing DIO)=
.
>=20
> I used a NFSv4.0 mount for the test.
>=20
>=20
> > > That's good.
> > >=20
> > > generic/683 2s ... [not run] xfs_io falloc  failed (old kernel/wrong =
fs?)
> > > generic/684 2s ... [not run] xfs_io fpunch  failed (old kernel/wrong =
fs?)
> > >=20
> > > What am I doing wrong?
> > >=20
> > >=20
> >=20
> > Not sure here. This test requires v4.2, but the client and server shoul=
d
> > negotiate that. You might need to run the test by hand and see what it
> > outputs. i.e.:
> >=20
> >    $ sudo ./tests/generic/683
>=20
> Then, these two failed only for NFSv4.2 and are not run for other
> minor versions. For some reason I thought this was an NFSv4.0-only
> bug.
>=20

Ok, that's expected. I should have been more clear. 355 only fails on
v4.0 only, but 683 and 684 require v4.2 to run and fail.

The cause of all 3 failures are the same though, and this patch should
fix it.


>=20
> > > > Reported-by: Boyang Xue <bxue@redhat.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > fs/nfsd/nfs4state.c | 27 +++++++++++++++++++++++++++
> > > > 1 file changed, 27 insertions(+)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index e61b878a4b45..ace02fd0d590 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -5421,6 +5421,23 @@ nfsd4_verify_deleg_dentry(struct nfsd4_open =
*open, struct nfs4_file *fp,
> > > > 	return 0;
> > > > }
> > > >=20
> > > > +/*
> > > > + * We avoid breaking delegations held by a client due to its own a=
ctivity, but
> > > > + * clearing setuid/setgid bits on a write is an implicit activity =
and the client
> > > > + * may not notice and continue using the old mode. Avoid giving ou=
t a delegation
> > > > + * on setuid/setgid files when the client is requesting an open fo=
r write.
> > > > + */
> > > > +static int
> > > > +nfsd4_verify_setuid_write(struct nfsd4_open *open, struct nfsd_fil=
e *nf)
> > > > +{
> > > > +	struct inode *inode =3D file_inode(nf->nf_file);
> > > > +
> > > > +	if ((open->op_share_access & NFS4_SHARE_ACCESS_WRITE) &&
> > > > +	    (inode->i_mode & (S_ISUID|S_ISGID)))
> > > > +		return -EAGAIN;
> > > > +	return 0;
> > > > +}
> > > > +
> > > > static struct nfs4_delegation *
> > > > nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid=
 *stp,
> > > > 		    struct svc_fh *parent)
> > > > @@ -5454,6 +5471,8 @@ nfs4_set_delegation(struct nfsd4_open *open, =
struct nfs4_ol_stateid *stp,
> > > > 	spin_lock(&fp->fi_lock);
> > > > 	if (nfs4_delegation_exists(clp, fp))
> > > > 		status =3D -EAGAIN;
> > > > +	else if (nfsd4_verify_setuid_write(open, nf))
> > > > +		status =3D -EAGAIN;
> > > > 	else if (!fp->fi_deleg_file) {
> > > > 		fp->fi_deleg_file =3D nf;
> > > > 		/* increment early to prevent fi_deleg_file from being
> > > > @@ -5494,6 +5513,14 @@ nfs4_set_delegation(struct nfsd4_open *open,=
 struct nfs4_ol_stateid *stp,
> > > > 	if (status)
> > > > 		goto out_unlock;
> > > >=20
> > > > +	/*
> > > > +	 * Now that the deleg is set, check again to ensure that nothing
> > > > +	 * raced in and changed the mode while we weren't lookng.
> > > > +	 */
> > > > +	status =3D nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
> > > > +	if (status)
> > > > +		goto out_unlock;
> > > > +
> > > > 	spin_lock(&state_lock);
> > > > 	spin_lock(&fp->fi_lock);
> > > > 	if (fp->fi_had_conflict)
> > > > --=20
> > > > 2.39.1
> > > >=20
> > >=20
> > > --
> > > Chuck Lever
> > >=20
> > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
