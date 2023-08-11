Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A77779606
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Aug 2023 19:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHKRWe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Aug 2023 13:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHKRWd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Aug 2023 13:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D0B30C1
        for <linux-nfs@vger.kernel.org>; Fri, 11 Aug 2023 10:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4FB866A1C
        for <linux-nfs@vger.kernel.org>; Fri, 11 Aug 2023 17:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B622DC433C9;
        Fri, 11 Aug 2023 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691774552;
        bh=z+OtJyLxEybXBY+N5VdlSt9vdB7ylCCs2yezcMhjqq4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dy6afLswjuqxGDE1XsT/muVZFccRFjnee5LACXAiKpTrgUW9hlR8GDcu38eOrIFIr
         5otKlA2VZuSDPugYDkVC4voWWslhR/wNDnarrOKA92k7QHSo0ZODNn2Sxhe8jOE5JA
         j5zyZgdeVEhvhGN3FqKO9m3o3Mi+kL6YCkL0QKaEeDxxD1A5AWbAjYh93S7fo6wDDC
         AhhEJ4ETcsWYTtQNeGZXsnUTTKW5XZEs2zX94GV5tcMlxSybr1ACapgUrQqQX1woVr
         I9xCIY6g8rW7rgbpkZJwb/HLyTflS5Bs2TY0iS1NNWoB+DyJjAe9jlR8j0GUh2x/cH
         ls94jc4CoZJiQ==
Message-ID: <6756f84c4ff92845298ce4d7e3c4f0fb20671d3d.camel@kernel.org>
Subject: Re: [PATCH v7 2/4] NFSD: allow client to use write delegation
 stateid for READ
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 11 Aug 2023 13:22:30 -0400
In-Reply-To: <1688089960-24568-3-git-send-email-dai.ngo@oracle.com>
References: <1688089960-24568-1-git-send-email-dai.ngo@oracle.com>
         <1688089960-24568-3-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-06-29 at 18:52 -0700, Dai Ngo wrote:
> Allow NFSv4 client to use write delegation stateid for READ operation.
> Per RFC 8881 section 9.1.2. Use of the Stateid and Locking.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 16 ++++++++++++++--
>  fs/nfsd/nfs4xdr.c  |  9 +++++++++
>  fs/nfsd/xdr4.h     |  2 ++
>  3 files changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 5ae670807449..3fa66cb38780 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -942,8 +942,18 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_comp=
ound_state *cstate,
>  	/* check stateid */
>  	status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_f=
h,
>  					&read->rd_stateid, RD_STATE,
> -					&read->rd_nf, NULL);
> -
> +					&read->rd_nf, &read->rd_wd_stid);

I think this patch is causing breakage with pynfs. WRT3 sends a READ
operation with the zero-stateid. On earlier kernels, this works, but a
linux-next kernel=A0rejects this with BAD_STATEID.

nfs4_preprocess_stateid_op seems to assume that if cstid is set, then
it's a copy operation and anonymous stateids aren't allowed. Maybe that
test should be something besides checking cstid =3D=3D NULL?

> +	/*
> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
> +	 * delegation stateid used for read. Its refcount is decremented
> +	 * by nfsd4_read_release when read is done.
> +	 */
> +	if (!status && (read->rd_wd_stid->sc_type !=3D NFS4_DELEG_STID ||
> +			delegstateid(read->rd_wd_stid)->dl_type !=3D
> +			NFS4_OPEN_DELEGATE_WRITE)) {
> +		nfs4_put_stid(read->rd_wd_stid);
> +		read->rd_wd_stid =3D NULL;
> +	}
>  	read->rd_rqstp =3D rqstp;
>  	read->rd_fhp =3D &cstate->current_fh;
>  	return status;
> @@ -953,6 +963,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
>  static void
>  nfsd4_read_release(union nfsd4_op_u *u)
>  {
> +	if (u->read.rd_wd_stid)
> +		nfs4_put_stid(u->read.rd_wd_stid);
>  	if (u->read.rd_nf)
>  		nfsd_file_put(u->read.rd_nf);
>  	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 76db2fe29624..e0640b31d041 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4120,6 +4120,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
>  	struct file *file;
>  	int starting_len =3D xdr->buf->len;
>  	__be32 *p;
> +	fmode_t o_fmode =3D 0;
> =20
>  	if (nfserr)
>  		return nfserr;
> @@ -4139,10 +4140,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp,=
 __be32 nfserr,
>  	maxcount =3D min_t(unsigned long, read->rd_length,
>  			 (xdr->buf->buflen - xdr->buf->len));
> =20
> +	if (read->rd_wd_stid) {
> +		/* allow READ using write delegation stateid */
> +		o_fmode =3D file->f_mode;
> +		file->f_mode |=3D FMODE_READ;
> +	}
>  	if (file->f_op->splice_read && splice_ok)
>  		nfserr =3D nfsd4_encode_splice_read(resp, read, file, maxcount);
>  	else
>  		nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount);
> +	if (o_fmode)
> +		file->f_mode =3D o_fmode;
> +
>  	if (nfserr) {
>  		xdr_truncate_encode(xdr, starting_len);
>  		return nfserr;
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 510978e602da..3ccc40f9274a 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -307,6 +307,8 @@ struct nfsd4_read {
>  	struct svc_rqst		*rd_rqstp;          /* response */
>  	struct svc_fh		*rd_fhp;            /* response */
>  	u32			rd_eof;             /* response */
> +
> +	struct nfs4_stid	*rd_wd_stid;		/* internal */
>  };
> =20
>  struct nfsd4_readdir {

--=20
Jeff Layton <jlayton@kernel.org>
