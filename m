Return-Path: <linux-nfs+bounces-8756-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBED9FB7ED
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 00:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9290D163497
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 23:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AFA1953A1;
	Mon, 23 Dec 2024 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWMDMJMf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA3187858
	for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2024 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734997616; cv=none; b=nkRZKDItn+Ov0j/E4wG+IlF6uP95gne5pGg4139huH8IL+a2AIhNcLE6OoY7YDrqHzFcpztZ6h49SXUEaZK2Lv6jG0KW+pXfwrl8IE1qwUVMpXQyRzxmu/A2Qfwgfu9CzwPLH5et3eLGk0Mkq6heRwyIpPUJi6nMdfwKnuQFGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734997616; c=relaxed/simple;
	bh=gAOx0KRgkNBvkgaab79M0UnsNDYIII0Vx8OuNN91yTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJlOsafjl8G4KTE5xzilqDChr730kEdy0cQYWa7SxahkXpViu/BvI9rnAgYexPQxCdrGGv8DXdj+A3Cq404+RhJ0l64cGIEKjUPqcbfhzAHUxSnnxNu7veRzFgteUGwlyAm2WqZgM4/yPzNYoQUhuES2CbU5nzKEEU6dXbFwEvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWMDMJMf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so1663270a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Dec 2024 15:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734997613; x=1735602413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQusQ5mvnqmXQ5B6qTIj1CPfsMZ76FMrdU41LKeielA=;
        b=OWMDMJMf1Rk/A7sCKDLm52R6MEKO0gJJfo2rdgBqxWobzf8E7zwpjDZX2/iWRpg9h8
         UmFbemg/DJ6rCA9kXUCLiOHUA3DV3DkJtlpkikYynKOOIEKuWUNc5928LFA3DQaMdCWS
         1YUET/SVKKt5GfxDzmkp5SBEJFQmNOIxxctYyC47cnRukUJ+Ka4qyFjs/KTuTBfkiNYt
         4pzic1pGGSMPIT+m7pW14ld7BmJ+G2znfi1HHda+/GZ28q4hlveA0jMH87QQBSpwi/bi
         VGNL0/353wH1Q43kK8a79oWVqCrbx+mshy1PO/eLYvAFUSgZ8yAuKjTGCEu321gNnHH+
         PqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734997613; x=1735602413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQusQ5mvnqmXQ5B6qTIj1CPfsMZ76FMrdU41LKeielA=;
        b=QPVYe+DYte55+BEhbj8q3pE3RnCmR2gPJaJYLZvGFUDgPTl6i/5TaFmPKz1KML94Ab
         a0PkNIejw+Xgp8IeIivwuBIZ0XPWf7gEy8lm1Cl8gRMG1d8ZWUcc7fW5MmmQTcA3GoLc
         RIUO7RlUlUhcL0rRyGtnOmGryf6Qrg7N8xjnI0SLOEUY4i69/OlLrnpf9u644dr1ZU11
         O0grGfBzE1KzoFR8Y8p1VD9Q1w4Xzh1/5cMQ58uefpsFE0sITmv0pFPtyE3/sJ1ryfM1
         ZRkQTWcr56txvzPHey9/l4pjkoHpedkTBwbzPpB9ElhljntLog1JwFchmz2fhDCBB+OT
         RcTw==
X-Forwarded-Encrypted: i=1; AJvYcCVub5u6WwvBaLgZnexY1A/ZEH27qTdVYqt1vfhd66dmsFuJ+vH+S23TRS0qpzRyMkSpnvIZC6vRT+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOrWPGRY1dKyr5Z6HvI/MS/aFiDLNhyCusaRK7W+ii5hTioer
	bTN86o7OJQaPfZ95tdREbyljrG9KV4wbH7cHCUC/fMJsNzIs29pNXg2gTyBiljIzHKKOku6Ak9q
	PaKyySNaYv6eaKow3ODrY3oRb8w==
X-Gm-Gg: ASbGncu2ZjrPq2Ka5c28pRc1qtO4sfnv3jKmgE20L0v4wOrwOzEzeuYPy+o9+HRrNJS
	GJlLDMdJ2K4yh3QnXwHUQMQ6DDz+AOafZHiyiPYgmK1huCMlmq3g+n33YGJEsrGJnuxZ3IQ==
X-Google-Smtp-Source: AGHT+IFcZ0qOBMxAdrVZesIsV0fSYTIv8sb30hZGiYYC52VL03+qLWubOda5lnMJRGsDXmS6YFoAm01KdcRnZrDw2cc=
X-Received: by 2002:a05:6402:13c8:b0:5d4:3761:d184 with SMTP id
 4fb4d7f45d1cf-5d81dd7f3b0mr14075460a12.10.1734997612998; Mon, 23 Dec 2024
 15:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223180724.1804-4-cel@kernel.org> <20241223180724.1804-5-cel@kernel.org>
In-Reply-To: <20241223180724.1804-5-cel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 23 Dec 2024 15:46:41 -0800
Message-ID: <CAM5tNy6AefX=E8Z8M=i7HxqZNQJubOj97-roKG=AWuX6bFRSUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] NFSD: Encode COMPOUND operation status on page boundaries
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	J David <j.david.lists@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 10:07=E2=80=AFAM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> J. David reports an odd corruption of a READDIR reply sent to a
> FreeBSD client.
>
> xdr_reserve_space() has to do a special trick when the @nbytes value
> requests more space than there is in the current page of the XDR
> buffer.
>
> In that case, xdr_reserve_space() returns a pointer to the start of
> the next page, and then the next call to xdr_reserve_space() invokes
> __xdr_commit_encode() to copy enough of the data item back into the
> previous page to make that data item contiguous across the page
> boundary.
>
> But we need to be careful in the case where buffer space is reserved
> early for a data item that will be inserted into the buffer later.
>
> One such caller, nfsd4_encode_operation(), reserves 8 bytes in the
> encoding buffer for each COMPOUND operation. However, a READDIR
> result can sometimes encode file names so that there are only 4
> bytes left at the end of the current XDR buffer page (though plenty
> of pages are left to handle the remaining encoding tasks).
>
> If a COMPOUND operation follows the READDIR result (say, a GETATTR),
> then nfsd4_encode_operation() will reserve 8 bytes for the op number
> (9) and the op status (usually NFS4_OK). In this weird case,
> xdr_reserve_space() returns a pointer to byte zero of the next buffer
> page, as it assumes the data item will be copied back into place (in
> the previous page) on the next call to xdr_reserve_space().
>
> nfsd4_encode_operation() writes the op num into the buffer, then
> saves the next 4-byte location for the op's status code. The next
> xdr_reserve_space() call is part of GETATTR encoding, so the op num
> gets copied back into the previous page, but the saved location for
> the op status continues to point to the wrong spot in the current
> XDR buffer page because __xdr_commit_encode() moved that data item.
>
> After GETATTR encoding is complete, nfsd4_encode_operation() writes
> the op status over the first XDR data item in the GETATTR result.
> The NFS4_OK status code (0) makes it look like there are zero items
> in the GETATTR's attribute bitmask.
>
> The patch description of commit 2825a7f90753 ("nfsd4: allow encoding
> across page boundaries") [2014] remarks that NFSD "can't handle a
> new operation starting close to the end of a page." This bug appears
> to be one reason for that remark.
>
> Reported-by: J David <j.david.lists@gmail.com>
> Closes: https://lore.kernel.org/linux-nfs/3998d739-c042-46b4-8166-dbd6c5f=
0e804@oracle.com/T/#t
> X-Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 53fac037611c..15cd716e9d91 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5760,15 +5760,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *=
resp, struct nfsd4_op *op)
>         struct nfs4_stateowner *so =3D resp->cstate.replay_owner;
>         struct svc_rqst *rqstp =3D resp->rqstp;
>         const struct nfsd4_operation *opdesc =3D op->opdesc;
> -       int post_err_offset;
> +       unsigned int op_status_offset;
>         nfsd4_enc encoder;
> -       __be32 *p;
>
> -       p =3D xdr_reserve_space(xdr, 8);
> -       if (!p)
> +       if (xdr_stream_encode_u32(xdr, op->opnum) !=3D XDR_UNIT)
> +               goto release;
> +       op_status_offset =3D xdr_stream_pos(xdr);
> +       if (!xdr_reserve_space(xdr, 4))
Maybe XDR_UNIT instead of 4 for consistency, but I don't care which you cho=
ose.

>                 goto release;
> -       *p++ =3D cpu_to_be32(op->opnum);
> -       post_err_offset =3D xdr->buf->len;
>
>         if (op->opnum =3D=3D OP_ILLEGAL)
>                 goto status;
> @@ -5809,20 +5808,21 @@ nfsd4_encode_operation(struct nfsd4_compoundres *=
resp, struct nfsd4_op *op)
>                  * bug if we had to do this on a non-idempotent op:
>                  */
>                 warn_on_nonidempotent_op(op);
> -               xdr_truncate_encode(xdr, post_err_offset);
> +               xdr_truncate_encode(xdr, op_status_offset + XDR_UNIT);
>         }
>         if (so) {
> -               int len =3D xdr->buf->len - post_err_offset;
> +               int len =3D xdr->buf->len - (op_status_offset + XDR_UNIT)=
;
>
>                 so->so_replay.rp_status =3D op->status;
>                 so->so_replay.rp_buflen =3D len;
> -               read_bytes_from_xdr_buf(xdr->buf, post_err_offset,
> +               read_bytes_from_xdr_buf(xdr->buf, op_status_offset + XDR_=
UNIT,
>                                                 so->so_replay.rp_buf, len=
);
>         }
>  status:
>         op->status =3D nfsd4_map_status(op->status,
>                                       resp->cstate.minorversion);
> -       *p =3D op->status;
> +       write_bytes_to_xdr_buf(xdr->buf, op_status_offset,
> +                              &op->status, XDR_UNIT);
>  release:
>         if (opdesc && opdesc->op_release)
>                 opdesc->op_release(&op->u);
> --
> 2.47.0
>

