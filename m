Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8899B7429BB
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 17:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjF2Pd4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 11:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjF2Pdz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 11:33:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9F10EC
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 08:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86E0C61578
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 15:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DFAC433C8;
        Thu, 29 Jun 2023 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688052833;
        bh=Xj47LTbryp4ADKBwuWDRo7f/aKj1nY9LP51uX6T2fww=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pc63cYyv0o8ISRNZ+kwBpobm3WhaM5xvDJeEHsNT02V1N74J3BhfIiDrkn/WjnSeH
         fPSWU2FnDzk0lrvxfT6XBHdAtpVNk7WC6cDqULYjGLdGe47VhIE53/Pqlmt9njMzdk
         zp6xf6RcIew0g7rGCtt+whj01Ad/4mJQAFNjK7Bhl6Sun6KAjb4YvUClm81TGhWmQx
         HKktbfCWkJYqnYf/WtlAr2J5PDUV9SEWncHInyntgAN8Bxpr/S8tPxORLv/P12z56u
         hv285/ebGjORWiWEq9g+jA2vY1wYfpTILbaBYGP9Et4N+MPsz+GJPcAjrj9bq4vLzM
         Ektb/JzT60FPA==
Message-ID: <a5a19a607f2d879800155b8d8e483d7f7081a92a.camel@kernel.org>
Subject: Re: [PATCH v6 4/5] NFSD: allow client to use write delegation
 stateid for READ
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date:   Thu, 29 Jun 2023 11:33:51 -0400
In-Reply-To: <ZJ2dBnw2PZOMB0oQ@manet.1015granger.net>
References: <1688006176-32597-1-git-send-email-dai.ngo@oracle.com>
         <1688006176-32597-5-git-send-email-dai.ngo@oracle.com>
         <ZJ2dBnw2PZOMB0oQ@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-06-29 at 11:02 -0400, Chuck Lever wrote:
> On Wed, Jun 28, 2023 at 07:36:15PM -0700, Dai Ngo wrote:
> > Allow NFSv4 client to use write delegation stateid for READ operation.
> > Per RFC 8881 section 9.1.2. Use of the Stateid and Locking.
>=20
> I'm wondering if this fix should precede 2/5 to prevent breakage
> during a bisect. Jeff, what do you think?
>=20

Good point. Probably the patch that actually makes it actually hand out
write delegations should=A0be the last one.
=20
>=20
> > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 16 ++++++++++++++--
> >  fs/nfsd/nfs4xdr.c  |  9 +++++++++
> >  fs/nfsd/xdr4.h     |  2 ++
> >  3 files changed, 25 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 5ae670807449..3fa66cb38780 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -942,8 +942,18 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> >  	/* check stateid */
> >  	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current=
_fh,
> >  					&read->rd_stateid, RD_STATE,
> > -					&read->rd_nf, NULL);
> > -
> > +					&read->rd_nf, &read->rd_wd_stid);
> > +	/*
> > +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
> > +	 * delegation stateid used for read. Its refcount is decremented
> > +	 * by nfsd4_read_release when read is done.
> > +	 */
> > +	if (!status && (read->rd_wd_stid->sc_type !=3D NFS4_DELEG_STID ||
> > +			delegstateid(read->rd_wd_stid)->dl_type !=3D
> > +			NFS4_OPEN_DELEGATE_WRITE)) {
> > +		nfs4_put_stid(read->rd_wd_stid);
> > +		read->rd_wd_stid =3D NULL;
> > +	}
> >  	read->rd_rqstp =3D rqstp;
> >  	read->rd_fhp =3D &cstate->current_fh;
> >  	return status;
> > @@ -953,6 +963,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> >  static void
> >  nfsd4_read_release(union nfsd4_op_u *u)
> >  {
> > +	if (u->read.rd_wd_stid)
> > +		nfs4_put_stid(u->read.rd_wd_stid);
> >  	if (u->read.rd_nf)
> >  		nfsd_file_put(u->read.rd_nf);
> >  	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index b35855c8beb6..833634cdc761 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -4125,6 +4125,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp,=
 __be32 nfserr,
> >  	struct file *file;
> >  	int starting_len =3D xdr->buf->len;
> >  	__be32 *p;
> > +	fmode_t o_fmode =3D 0;
> > =20
> >  	if (nfserr)
> >  		return nfserr;
> > @@ -4144,10 +4145,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *res=
p, __be32 nfserr,
> >  	maxcount =3D min_t(unsigned long, read->rd_length,
> >  			 (xdr->buf->buflen - xdr->buf->len));
> > =20
> > +	if (read->rd_wd_stid) {
> > +		/* allow READ using write delegation stateid */
> > +		o_fmode =3D file->f_mode;
> > +		file->f_mode |=3D FMODE_READ;
> > +	}
> >  	if (file->f_op->splice_read && splice_ok)
> >  		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcount);
> >  	else
> >  		nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
> > +	if (o_fmode)
> > +		file->f_mode =3D o_fmode;
> > +
> >  	if (nfserr) {
> >  		xdr_truncate_encode(xdr, starting_len);
> >  		return nfserr;
> > diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> > index 510978e602da..3ccc40f9274a 100644
> > --- a/fs/nfsd/xdr4.h
> > +++ b/fs/nfsd/xdr4.h
> > @@ -307,6 +307,8 @@ struct nfsd4_read {
> >  	struct svc_rqst		*rd_rqstp;          /* response */
> >  	struct svc_fh		*rd_fhp;            /* response */
> >  	u32			rd_eof;             /* response */
> > +
> > +	struct nfs4_stid	*rd_wd_stid;		/* internal */
> >  };
> > =20
> >  struct nfsd4_readdir {
> > --=20
> > 2.39.3
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
