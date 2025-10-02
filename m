Return-Path: <linux-nfs+bounces-14915-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D90BB48D1
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Oct 2025 18:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E03A19E49F8
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Oct 2025 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DEA258EE1;
	Thu,  2 Oct 2025 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFfaaFam"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD91E3DCF
	for <linux-nfs@vger.kernel.org>; Thu,  2 Oct 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422872; cv=none; b=njPDERpSdZR27aAbFMzBhMomJ78A6RFLKdCJbevX4LKFoQLWeeGWHu9N2nCP8c7AUSjQoE6Vpwt9hDihfGqFoMFUCtxxTrblyjUcZZOK+zIb6HrY9M9ruzrQyekJWQ9dacoN/KT1KeJazOMG7TfBHEbTRPkY1ehV9tIy8kapJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422872; c=relaxed/simple;
	bh=fGguhpT7IgvglU+qAdxcPIRBHXDqk1IkZ8vybHBBm5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOAaT/1MnGVKs1Uyli2zX2TKqrfXpW4c42oKR6mDgfnJrNNjpGOYAfQUzLQQtxuDrEVNpZvENYMOOev7pFSbQSCO1+2OR4tPsCl0wb9qidJyDvlA5fgN43jnrpkhnvZRAcdeQ1i/TuZ3PkQwzwF3yoo5oP+PfDl7TI8AAYwAZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFfaaFam; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32e715cbad3so1341133a91.3
        for <linux-nfs@vger.kernel.org>; Thu, 02 Oct 2025 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422870; x=1760027670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2UfYRxGzNxrQ2qs6TtkGEU3FLI6Jd+w06orCnzGatM=;
        b=aFfaaFam9GZuvcpNytBe6nCrsjKZcxm2rUOJ9dBCEOmObBVVU2rEUT2oGJzfmlhBN6
         ySG15ZZsrzgYdFEC4gk4OnO2n3Jy053Wy+XH37fxO88kG2zHbygQv/i86k3Z8KJFi13u
         sv+51okCZXf4we/QXaKbTDytQZBhbtWOUOmb90yHX14Y1E0ODUiCktSJCIWal77jpEcE
         mijtYTRZZhNqPgIFX4VQetxs0i9d6BgVwpFbzj9CMA4It2czodcz0W5wSvYLjbc4vE07
         YP0e5dathqRri7V1ENptxwU0CUJ/vK3ny9bELSMOG8R0F0YuhOQLiXE/j/Wkjxx+izFx
         PWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422870; x=1760027670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2UfYRxGzNxrQ2qs6TtkGEU3FLI6Jd+w06orCnzGatM=;
        b=Ov2LrM2Zh18lhHZbzZK7YbsVGnlbeYBaRyn77eSk8y5nUAN4Q5p/oI1HxmXfjPtGvP
         F+rjpMWNEdFcHQKKGmZmk082WOa+OykF7pVhFieHYj3STyUmtcY1qNGVCdnHyE9XPktp
         uvqkDVuTY9GB1DQ5pVtprtL7rGk1w53iT7T2VlkQm8RZbfsyiRanYSlxpa0sY5NOooqb
         O4ajTaZ0TOve158E3bBA/ERpRre5PXrYnB7wN47PfOvKivRTVC+ruqZsB4Tp9V16Zvwf
         nfalrAwE67YAxm6+hBOuCK/pExeL2xJAInRebiu/jDqoIFkm+pD4sacg93BfRcRnn6Fi
         FjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL6VEhiMWA33Mpd8Cq7S2b7fcVTr2tQoKrj9Dgk5e4t8ZYlvfBtdTbD4FG3ohQTLrBWt7i7aKMac4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjavfgs6I8eyRSREDtaVO2xVT7CyKLtlTCRBnDCFVch7oO6w4
	19YXXzBvbek9whTV8PZBMPsWydva4GW3VTFATKxnTfednrjORfrwKoE6kyN4hUR3cXc/qrvVTFS
	EK2XSAhCILrvSPlqSTIS26wx1MYIZdIP53xrc
X-Gm-Gg: ASbGncuWsjvZ/K86gi193r6U3lyesPnIpP7cswFobUqveaBDxekB74eqAfeM+AP4zaN
	H+lABIIBtUSH1nPS+zhCZVPmmyrVBy1XS9q0wD+y3ONR1oD6cJaDF6RUv/k7D5szfMorO0ONg64
	VmTk6Xpuxtlc2bFBU72SVIMHQHnIpYGmYYpDE1dX5rCq0+MVp1IJXXQCQr7iXTpfYKHxM1yZkjP
	RcXsvx7ZELEoAqlhmWcX5RPQm4zwZ4=
X-Google-Smtp-Source: AGHT+IHA4YMWpNdOvXOtTq8jjHEsELFUK5lRMi9fJJxYrNV+xsmoyOw0B7OqWw9zUEuaF8fO7qTd4lW0CFRLYC90Xes=
X-Received: by 2002:a17:90b:2248:b0:330:4604:3ab6 with SMTP id
 98e67ed59e1d1-339a6f0782fmr9106133a91.18.1759422870310; Thu, 02 Oct 2025
 09:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002140052.15502-1-cel@kernel.org>
In-Reply-To: <20251002140052.15502-1-cel@kernel.org>
From: tianshuo han <hantianshuo233@gmail.com>
Date: Fri, 3 Oct 2025 00:34:18 +0800
X-Gm-Features: AS18NWDp95C67tA52_pZNZbdLXRfxtaLu94DSyn9TN32g9_sv6l8PNL2QfElhXk
Message-ID: <CAG=tWCT_28vLpHm0Br4_m4eMEr9EU+QFiTapG04HtrpvuUoL9w@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "NFSD: Remove the cap on number of operations
 per NFSv4 COMPOUND"
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Tianshuo Han <hantianshuo233@gmail.com>

I have tested this patch and can confirm it resolves the vulnerability
I reported. Thank you very much for including the attribution and for
addressing this issue so promptly!

Best regards,
Tianshuo

On Thu, Oct 2, 2025 at 10:00=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> I've found that pynfs COMP6 now leaves the connection or lease in a
> strange state, which causes CLOSE9 to hang indefinitely. I've dug
> into it a little, but I haven't been able to root-cause it yet.
> However, I bisected to commit 48aab1606fa8 ("NFSD: Remove the cap on
> number of operations per NFSv4 COMPOUND").
>
> Tianshuo Han also reports a potential vulnerability when decoding
> an NFSv4 COMPOUND. An attacker can place an arbitrarily large op
> count in the COMPOUND header, which results in:
>
> [   51.410584] nfsd: vmalloc error: size 1209533382144, exceeds total
> pages, mode:0xdc0(GFP_KERNEL|__GFP_ZERO),
> nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
>
> when NFSD attempts to allocate the COMPOUND op array.
>
> Let's restore the per operation-per-COMPOUND limit, but increased to
> 200 for now.
>
> Reported-by: tianshuo han <hantianshuo233@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> X-Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c  | 14 ++++++++++++--
>  fs/nfsd/nfs4state.c |  1 +
>  fs/nfsd/nfs4xdr.c   |  4 +++-
>  fs/nfsd/nfsd.h      |  3 +++
>  fs/nfsd/xdr4.h      |  1 +
>  5 files changed, 20 insertions(+), 3 deletions(-)
>
> Changes since v1:
> * Patch description updates
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f9aeefc0da73..7f7e6bb23a90 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2893,10 +2893,20 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>
>         rqstp->rq_lease_breaker =3D (void **)&cstate->clp;
>
> -       trace_nfsd_compound(rqstp, args->tag, args->taglen, args->opcnt);
> +       trace_nfsd_compound(rqstp, args->tag, args->taglen, args->client_=
opcnt);
>         while (!status && resp->opcnt < args->opcnt) {
>                 op =3D &args->ops[resp->opcnt++];
>
> +               if (unlikely(resp->opcnt =3D=3D NFSD_MAX_OPS_PER_COMPOUND=
)) {
> +                       /* If there are still more operations to process,
> +                        * stop here and report NFS4ERR_RESOURCE. */
> +                       if (cstate->minorversion =3D=3D 0 &&
> +                           args->client_opcnt > resp->opcnt) {
> +                               op->status =3D nfserr_resource;
> +                               goto encode_op;
> +                       }
> +               }
> +
>                 /*
>                  * The XDR decode routines may have pre-set op->status;
>                  * for example, if there is a miscellaneous XDR error
> @@ -2973,7 +2983,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>                         status =3D op->status;
>                 }
>
> -               trace_nfsd_compound_status(args->opcnt, resp->opcnt,
> +               trace_nfsd_compound_status(args->client_opcnt, resp->opcn=
t,
>                                            status, nfsd4_op_name(op->opnu=
m));
>
>                 nfsd4_cstate_clear_replay(cstate);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ad2c45658c46..c9053ef4d79f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3902,6 +3902,7 @@ static __be32 check_forechannel_attrs(struct nfsd4_=
channel_attrs *ca, struct nfs
>         ca->headerpadsz =3D 0;
>         ca->maxreq_sz =3D min_t(u32, ca->maxreq_sz, maxrpc);
>         ca->maxresp_sz =3D min_t(u32, ca->maxresp_sz, maxrpc);
> +       ca->maxops =3D min_t(u32, ca->maxops, NFSD_MAX_OPS_PER_COMPOUND);
>         ca->maxresp_cached =3D min_t(u32, ca->maxresp_cached,
>                         NFSD_SLOT_CACHE_SIZE + NFSD_MIN_HDR_SEQ_SZ);
>         ca->maxreqs =3D min_t(u32, ca->maxreqs, NFSD_MAX_SLOTS_PER_SESSIO=
N);
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 6a56dca6fb04..230bf53e39f7 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2488,8 +2488,10 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *a=
rgp)
>
>         if (xdr_stream_decode_u32(argp->xdr, &argp->minorversion) < 0)
>                 return false;
> -       if (xdr_stream_decode_u32(argp->xdr, &argp->opcnt) < 0)
> +       if (xdr_stream_decode_u32(argp->xdr, &argp->client_opcnt) < 0)
>                 return false;
> +       argp->opcnt =3D min_t(u32, argp->client_opcnt,
> +                           NFSD_MAX_OPS_PER_COMPOUND);
>
>         if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
>                 argp->ops =3D vcalloc(argp->opcnt, sizeof(*argp->ops));
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 6812cd231b1d..8ffed4f0b95f 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -57,6 +57,9 @@ struct readdir_cd {
>         __be32                  err;    /* 0, nfserr, or nfserr_eof */
>  };
>
> +/* Maximum number of operations per session compound */
> +#define NFSD_MAX_OPS_PER_COMPOUND      200
> +
>  struct nfsd_genl_rqstp {
>         struct sockaddr         rq_daddr;
>         struct sockaddr         rq_saddr;
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index d4b48602b2b0..ee0570cbdd9e 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -903,6 +903,7 @@ struct nfsd4_compoundargs {
>         char *                          tag;
>         u32                             taglen;
>         u32                             minorversion;
> +       u32                             client_opcnt;
>         u32                             opcnt;
>         bool                            splice_ok;
>         struct nfsd4_op                 *ops;
> --
> 2.51.0
>

