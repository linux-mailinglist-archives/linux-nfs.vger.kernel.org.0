Return-Path: <linux-nfs+bounces-5040-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E48CC93B791
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 21:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A8B7B211B5
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 19:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDCA4D8B9;
	Wed, 24 Jul 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="jyztWeUg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D1161924
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721849411; cv=none; b=Ycfi2qRxRARMaGy53dCHqtPBm4VDmrRmG2yrZo+hfHoIp848qZNQ5I1nmGGK02M57IGCzPTjkVvvfGPE2k+P2wfwh2QyvFYH8BbkOSoP3gz+3nAxt+Q33qkyN80mZgeEe1ZEqGGnxfh6YmDgYPOq08dqY49ZZ7tuwN57Ayq/1f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721849411; c=relaxed/simple;
	bh=C2sO7dqXw1jKtQzg3n9d5rMRpP04G805g7bJib7MfWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvkUlhsjGgfEO1yNIoFkPQguBtHASf8riFveyKYt/XwIjGYkMEl6Bt2keOCsO5FwOdrOKFNSUVcc7knLgKfOf1HUjYe0gTwczdv6sw5gu+FFLyZXvzHf80CRh2hMyVwTSM6qgbonfi6vi5mZt9dIVIkyg1eSymeIg1cttnv5Uco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=jyztWeUg; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef302f5dbbso184901fa.2
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 12:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1721849408; x=1722454208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fka3TkL8rRapKbveK2mgG8w8xF9/AxS+3TvYRTWR1YI=;
        b=jyztWeUgFbOorGGk6pZR7Es3JoPv5lY6m7Tr0/RjsoYqEx/W3LUOIyIvzJmZH/H4Y3
         4V0aPZcVNAk69qLutWKn3/WceXDPxUok0QbGlYvOeHB+aQQWC1DVGI3cEbXWRo3+wqBf
         Q54G2rfQqXR23ZjvpaQn6Oq/mGxJnSno+fFxZyR/LYTjrJG1QXBt2XeLD2lfy93dfCsS
         1jaA4LTN0rwl4DPfxnA7iTUN+zowWC6RYY6OOr8os5H4vMdVPnmJGkiRKQHg2eswGPLH
         dmLY9jXE/Za/kwK/ifNs03WNH9zcNyTMdwPHz1nyma15jBg6Zfd3dkBV+p6QYbeXjFmh
         FXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721849408; x=1722454208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fka3TkL8rRapKbveK2mgG8w8xF9/AxS+3TvYRTWR1YI=;
        b=HpiuNt7kpm8NVNjWq2EEZEHgSjqMqxGRc4htKdFHKa5gu4llW3MUejOp2oXrTugh4q
         ooy00UAlL7kB6TLwhIYU8UDHZM7ViWSg+Czo3f6Z2fXyqCAti0aR3WIGXb+BxtFE5lMC
         glJrdKhLK++f5ySVbiP+zg1/bg8cd1jkd1DBqpVOmS8w3uAR5G/EKTPDl+Qu761qGtrg
         2xKnLZoI3BiJgLKrTeP1O8T6vfDGVEir7tFV8Gcsjo6tlNE0KdufaK8ZHfRwpLCff4Ao
         bjmDFDk+DfIHb+/+UL/rBXgjA2OuARdWiog3bsIec0B2YvFi3rVqAbA+GvnvyqIeT2c8
         E3BA==
X-Forwarded-Encrypted: i=1; AJvYcCUwxUzx8iZ2ulQrfG0UfOCxz7kcqn+oDsIByZI8ToxGlBS87FbsBWZSHRKHzDczJvTYcez4qwfI5jhxqC4NyrcMlsbyssd8wqBX
X-Gm-Message-State: AOJu0YyK2bzjFZantnJuJM831GecnjLHkkZTxW7dKet8bkuY2VlJNfn8
	HXgC4NWdr8LOrdBOFvqThEZvJFxc5+d1iShMEampkEkZSylZa4NCU4uzaXF3ipJ7mhnAAjbyenH
	5y3Kx4tP8hzNg2fSPuW7RkoyqW+wq3Q==
X-Google-Smtp-Source: AGHT+IHJ53kXaobjnDjGyyDXz3E9xCZ1Fuq75WbMtoDEfH+gKHssnROsPKPVEKCK6JwKiD1+JVcyqxFnesdAMMUsW3w=
X-Received: by 2002:a2e:2205:0:b0:2ef:2e5d:3703 with SMTP id
 38308e7fff4ca-2f03c602db5mr569841fa.0.1721849407534; Wed, 24 Jul 2024
 12:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724170138.1942307-1-sagi@grimberg.me> <20240724170138.1942307-2-sagi@grimberg.me>
In-Reply-To: <20240724170138.1942307-2-sagi@grimberg.me>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 24 Jul 2024 15:29:55 -0400
Message-ID: <CAN-5tyF4fjD4sGDx7CTnYWuCcOLsX3dSQpiPyLNNQAM1Hd5TJg@mail.gmail.com>
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <dai.ngo@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 1:01=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
> Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
> stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
> Stateid and Locking.
>
> In addition, for anonymous stateids, check for pending delegations by
> the filehandle and client_id, and if a conflict found, recall the delegat=
ion
> before allowing the read to take place.
>
> Suggested-by: Dai Ngo <dai.ngo@oracle.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  fs/nfsd/nfs4proc.c  | 22 +++++++++++++++++++--
>  fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfs4xdr.c   |  9 +++++++++
>  fs/nfsd/state.h     |  2 ++
>  fs/nfsd/xdr4.h      |  2 ++
>  5 files changed, 80 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 7b70309ad8fb..324984ec70c6 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_comp=
ound_state *cstate,
>         /* check stateid */
>         status =3D nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->cur=
rent_fh,
>                                         &read->rd_stateid, RD_STATE,
> -                                       &read->rd_nf, NULL);
> -
> +                                       &read->rd_nf, &read->rd_wd_stid);

Now I can see that this patch wants to leverage the "returned stateid
of the nfs4_preprocess_stateid_op() but the logic in the previous
patch was in the way because it distinguished the copy_notify by the
non-null passed in stateid. So I would suggest that in order to not
break the copy_notify and help with this functionality something else
is sent into nfs4_proprocess_staetid_op() to allow for the stateid to
be passed and then distinguish between copy_notify and read.

> +       /*
> +        * rd_wd_stid is needed for nfsd4_encode_read to allow write
> +        * delegation stateid used for read. Its refcount is decremented
> +        * by nfsd4_read_release when read is done.
> +        */
> +       if (!status) {
> +               if (!read->rd_wd_stid) {
> +                       /* special stateid? */
> +                       status =3D nfsd4_deleg_read_conflict(rqstp, cstat=
e->clp,
> +                               &cstate->current_fh);
> +               } else if (read->rd_wd_stid->sc_type !=3D SC_TYPE_DELEG |=
|
> +                          delegstateid(read->rd_wd_stid)->dl_type !=3D
> +                                               NFS4_OPEN_DELEGATE_WRITE)=
 {
> +                       nfs4_put_stid(read->rd_wd_stid);
> +                       read->rd_wd_stid =3D NULL;
> +               }
> +       }
>         read->rd_rqstp =3D rqstp;
>         read->rd_fhp =3D &cstate->current_fh;
>         return status;
> @@ -990,6 +1006,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_comp=
ound_state *cstate,
>  static void
>  nfsd4_read_release(union nfsd4_op_u *u)
>  {
> +       if (u->read.rd_wd_stid)
> +               nfs4_put_stid(u->read.rd_wd_stid);
>         if (u->read.rd_nf)
>                 nfsd_file_put(u->read.rd_nf);
>         trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index dc61a8adfcd4..7e6b9fb31a4c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8805,6 +8805,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state=
 *cstate,
>         get_stateid(cstate, &u->write.wr_stateid);
>  }
>
> +/**
> + * nfsd4_deleg_read_conflict - Recall if read causes conflict
> + * @rqstp: RPC transaction context
> + * @clp: nfs client
> + * @fhp: nfs file handle
> + * @inode: file to be checked for a conflict
> + * @modified: return true if file was modified
> + * @size: new size of file if modified is true
> + *
> + * This function is called when there is a conflict between a write
> + * delegation and a read that is using a special stateid where the
> + * we cannot derive the client stateid exsistence. The server
> + * must recall a conflicting delegation before allowing the read
> + * to continue.
> + *
> + * Returns 0 if there is no conflict; otherwise an nfs_stat
> + * code is returned.
> + */
> +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> +               struct nfs4_client *clp, struct svc_fh *fhp)
> +{
> +       struct nfs4_file *fp;
> +       __be32 status =3D 0;
> +
> +       fp =3D nfsd4_file_hash_lookup(fhp);
> +       if (!fp)
> +               return nfs_ok;
> +
> +       spin_lock(&state_lock);
> +       spin_lock(&fp->fi_lock);
> +       if (!list_empty(&fp->fi_delegations) &&
> +           !nfs4_delegation_exists(clp, fp)) {
> +               /* conflict, recall deleg */
> +               status =3D nfserrno(nfsd_open_break_lease(fp->fi_inode,
> +                                       NFSD_MAY_READ));
> +               if (status)
> +                       goto out;
> +               if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
> +                       status =3D nfserr_jukebox;
> +       }
> +out:
> +       spin_unlock(&fp->fi_lock);
> +       spin_unlock(&state_lock);
> +       return status;
> +}
> +
> +
>  /**
>   * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>   * @rqstp: RPC transaction context
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index c7bfd2180e3f..f0fe526fac3c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4418,6 +4418,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, _=
_be32 nfserr,
>         unsigned long maxcount;
>         struct file *file;
>         __be32 *p;
> +       fmode_t o_fmode =3D 0;
>
>         if (nfserr)
>                 return nfserr;
> @@ -4437,10 +4438,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp,=
 __be32 nfserr,
>         maxcount =3D min_t(unsigned long, read->rd_length,
>                          (xdr->buf->buflen - xdr->buf->len));
>
> +       if (read->rd_wd_stid) {
> +               /* allow READ using write delegation stateid */
> +               o_fmode =3D file->f_mode;
> +               file->f_mode |=3D FMODE_READ;
> +       }
>         if (file->f_op->splice_read && splice_ok)
>                 nfserr =3D nfsd4_encode_splice_read(resp, read, file, max=
count);
>         else
>                 nfserr =3D nfsd4_encode_readv(resp, read, file, maxcount)=
;
> +       if (o_fmode)
> +               file->f_mode =3D o_fmode;
> +
>         if (nfserr) {
>                 xdr_truncate_encode(xdr, starting_len);
>                 return nfserr;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index ffc217099d19..c1f13b5877c6 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -780,6 +780,8 @@ static inline bool try_to_expire_client(struct nfs4_c=
lient *clp)
>         return clp->cl_state =3D=3D NFSD4_EXPIRABLE;
>  }
>
> +extern __be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
> +               struct nfs4_client *clp, struct svc_fh *fhp);
>  extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>                 struct inode *inode, bool *file_modified, u64 *size);
>  #endif   /* NFSD4_STATE_H */
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index fbdd42cde1fa..434973a6a8b1 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -426,6 +426,8 @@ struct nfsd4_read {
>         struct svc_rqst         *rd_rqstp;          /* response */
>         struct svc_fh           *rd_fhp;            /* response */
>         u32                     rd_eof;             /* response */
> +
> +       struct nfs4_stid        *rd_wd_stid;            /* internal */
>  };
>
>  struct nfsd4_readdir {
> --
> 2.43.0
>
>

