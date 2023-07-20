Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B875B2C5
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 17:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjGTPeB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 11:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjGTPeA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 11:34:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB850272E;
        Thu, 20 Jul 2023 08:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 813DB61B56;
        Thu, 20 Jul 2023 15:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295A4C433C8;
        Thu, 20 Jul 2023 15:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689867188;
        bh=c+ZVWxgh/CXsH1c2vchK7aDDzJLtNw5gn/vP1LDRfrk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ss0zSK6F0+4lGy54qqR1dvx6YnED5rmrZaLh5EMf0WvrtKYiZ5aOFQEcoV3HF56y6
         gJxR1V0HYFFZvj+XHxGBK/U8zHuOa+GwFfuc3V0KU6lbvy5whQv96ZQiFbyiIbsS3Z
         KO+MXOnS8JuTMJf0L1ThvssfCTff5R1pW3ui+OVQD/NbTUg+KGogsnoYNBeTvT6tys
         nkOmDh+i5aWzLua+aIshQwTIk06CX1OigMhfKic9ABGXJSB1KIX1btXzQjnDazjIX+
         x0DjilsZFVpTLvZVpF0sxcYABtgCXzTJu4c71p2Y7olUzhyQBsjx81o4BPwhFOFaGw
         ZwUnP0JrprvQw==
Message-ID: <061f2b988de3da1dac32ecb3d8ac76319065b51d.camel@kernel.org>
Subject: Re: [PATCH] nfsd: remove unsafe BUG_ON from set_change_info
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boyang Xue <bxue@redhat.com>
Date:   Thu, 20 Jul 2023 11:33:06 -0400
In-Reply-To: <4B067A0F-93E3-435A-A32B-B17BC07D4606@oracle.com>
References: <20230720-bz2223560-v1-1-edb4900043b8@kernel.org>
         <4B067A0F-93E3-435A-A32B-B17BC07D4606@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-07-20 at 15:15 +0000, Chuck Lever III wrote:
>=20
> > On Jul 20, 2023, at 10:59 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > At one time, nfsd would scrape inode information directly out of struct
> > inode in order to populate the change_info4. At that time, the BUG_ON i=
n
> > set_change_info made some sense, since having it unset meant a coding
> > error.
> >=20
> > More recently, it calls vfs_getattr to get this information, which can
> > fail. If that fails, fh_pre_saved can end up not being set. While this
> > situation is unfortunate, we don't need to crash the box.
>=20
> I'm always happy to get rid of a BUG_ON(). But I'm not sure even
> a warning is necessary in this case. It's not likely that it's
> a software bug or something that the server administrator can
> do something about.
>=20
> Can you elaborate on why the vfs_getattr() might fail? Eg, how
> was it failing in 2223560 ?
>=20

I'm fine with dropping the WARN_ON. You are correct that there is
probably little the admin can do about it.

vfs_getattr can fail for all sorts of reasons. It really depends on the
underlying filesystem. In 2223560, I don't know for sure, but just prior
to the oops, there were these messages in the log:

[51935.482019] XFS (vda3): Filesystem has been shut down due to log error (=
0x2).=20
[51935.482020] XFS (vda3): Please unmount the filesystem and rectify the pr=
oblem(s).=20
[51935.482550] vda3: writeback error on inode 25320400, offset 2097152, sec=
tor 58684120=20

My assumption was that the fs being shut down caused some VFS operations
to start returning errors (including getattr) and that is why
fh_pre_saved ultimately didn't get set.

>=20
> > Move set_change_info to nfs4proc.c since all of the callers are there.
> > Revise the condition for setting "atomic" to also check for
> > fh_pre_saved. Drop the BUG_ON and make it a WARN_ON, and just have it
> > zero out both change_attr4s when this occurs.
> >=20
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2223560
> > Reported-by: Boyang Xue <bxue@redhat.com>
>=20
> checkpatch now wants
>=20
> Reported-by:
> Closes:
>=20
> in that order.
>=20


Mmmmkay. So I assume the URL should go in the Closes: field then?

I'll take out the WARN_ON_ONCE and resend, once others have had a chance
to comment.

Thanks!

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/nfs4proc.c | 30 ++++++++++++++++++++++++++++++
> > fs/nfsd/xdr4.h     | 11 -----------
> > 2 files changed, 30 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index d8e7a533f9d2..e6f406f27821 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -380,6 +380,36 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> > return status;
> > }
> >=20
> > +/**
> > + * set_change_info - set up the change_info4 for a reply
> > + * @cinfo: pointer to nfsd4_change_info to be populated
> > + * @fhp: pointer to svc_fh to use as source
> > + *
> > + * Many operations in NFSv4 require change_info4 in the reply. This fu=
nction
> > + * populates that from the info that we (should!) have already collect=
ed. In
> > + * the event that we didn't get any pre-attrs, throw a warning and jus=
t
> > + * zero out both change_attr4 fields.
> > + */
> > +static void
> > +set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
> > +{
> > + cinfo->atomic =3D (u32)(fhp->fh_pre_saved && fhp->fh_post_saved && !f=
hp->fh_no_atomic_attr);
> > +
> > + /*
> > + * In the event that we couldn't fetch attributes from the
> > + * server for some reason, just zero out the before and after
>=20
> "From the server"? Is it only likely to fail if the exported
> filesystem is an NFS mount? Or did you mean "from the filesystem" ?
>=20
>=20
> > + * change values, after throwing a warning.
> > + */
> > + if (WARN_ON_ONCE(!fhp->fh_pre_saved)) {
>=20
> Maybe you should clear ->atomic as well in this case.
>=20
>=20
> > + cinfo->before_change =3D 0;
> > + cinfo->after_change =3D 0;
> > + return;
> > + }
> > +
> > + cinfo->before_change =3D fhp->fh_pre_change;
> > + cinfo->after_change =3D fhp->fh_post_change;
> > +}
> > +
> > static __be32
> > do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cst=
ate, struct nfsd4_open *open, struct svc_fh **resfh)
> > {
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index b2931fdf53be..9e67f63c5f4d 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -775,17 +775,6 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)=
;
> >=20
> > #define NFS4_SVC_XDRSIZE sizeof(struct nfsd4_compoundargs)
> >=20
> > -static inline void
> > -set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
> > -{
> > - BUG_ON(!fhp->fh_pre_saved);
> > - cinfo->atomic =3D (u32)(fhp->fh_post_saved && !fhp->fh_no_atomic_attr=
);
> > -
> > - cinfo->before_change =3D fhp->fh_pre_change;
> > - cinfo->after_change =3D fhp->fh_post_change;
> > -}
> > -
> > -
> > bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rq=
stp);
> > bool nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, struct xdr_str=
eam *xdr);
> > bool nfs4svc_encode_compoundres(struct svc_rqst *rqstp, struct xdr_stre=
am *xdr);
> >=20
> > ---
> > base-commit: 070f391ca4d48e1750ee6108eb44f751a9e9448e
> > change-id: 20230720-bz2223560-9c4690a8217b
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
