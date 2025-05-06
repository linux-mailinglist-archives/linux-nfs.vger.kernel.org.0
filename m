Return-Path: <linux-nfs+bounces-11532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFB6AACB3A
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 18:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44ED498174A
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C6286431;
	Tue,  6 May 2025 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="kP9DmpqJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D4283FCC
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549471; cv=pass; b=p3Rx8u7zamy/7PVnOb/pcc5gwS/HVri1rsXkYlAOFziMEYBxIEkkcHV+6lj7yiqiGqz63DY9WlxVEgJanjWRUNglcl6H9Pyip1hIst9FJzy9pQNNaMI/7QDWgC+u9DIfLQsgSLQK81wzQMLbeDT2TIHR9l/nP63Ust3Nmgn4q20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549471; c=relaxed/simple;
	bh=BWCujVjU3ZDGSrzpIci52fk2TpJHFA0QNdoybgrb7xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bMSUThGhfD4pA0PZ6mVMT5MmglY2hSbJ8qxDLegLBfVsdovU3+9aPfAfoMWEmgXcbeCXfEF4nRSTXBHj58mRAOH7eLRzYTm0qK2gCcLW3FaC1IqSVdqKeUsv2jEq6D6vpKDF7qTnJWgaHlCl6fcoV+fQI4JEMKo8htDI8ik7xE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=kP9DmpqJ; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D24C481526
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 15:11:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a296.dreamhost.com (trex-6.trex.outbound.svc.cluster.local [100.106.221.95])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 809FF83CD8
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 15:11:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1746544277; a=rsa-sha256;
	cv=none;
	b=4mfve0GlhkzsXR60Xbbn6laN459keTZp+sSFiTmZla6qbHBJGANU5nyqKy5tqEgruPGYxi
	gJu43HB8mgbxZoUTa5Y6NkMQdeZ+Pjd+I4eMryZExiZI+TJl/f7D51c5SWVmK+ubkLkYOJ
	PVRzu4k+Gt1de45pSIf5pSYGdH4l3kYh1TcyHoR0oB9Hj6H6thcihx/T1JJWauad1K2UWl
	lp6l/sV6Xg230RAE1UG9v7qbyYCu5jy9yUcvA+njK5EWaDHEeRsRvFAbeSeZYXkYUenAIz
	aSMXDRE+Acv6BbfkOQ8by3uaWW1nb05Bj3RkoItDNNoXNaMRLaoOppR7pNbx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1746544277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6TRxSjfeJM0ZA871Fsc/CGXXTvzJM6CyHDWup/G2ImI=;
	b=amH4aRG21A5wW47AHA7mVm0de0hOd/4zMUxzAB2Evff4t5hIxuCvXtCpYWiKFGIaNYjlFw
	v5BkLeWv9D+LIgwTDUE9p+Fhd/i9XJHGO3LFlnK0fO+r2r7qbJGpwimPfYW7Uxu/KBTymw
	d5/6OWRMghU+0nxFEZUEfhs/0yhah6oDcwv/H30cmylGz70sxrzCdWf6seQ8/xG59bIIYv
	YkpEkA5xZVOsFpm3GgcU7IIMu+DnKGN1yDxj2MoNOqoaR1O5yHlnuCDPT7HveKABrsSDqY
	rkLKZEyx4Dp85bPuMWN7VcnS0SrY0UoHfSTdNSgZyuwYl2VSySuNCwnyt7inhA==
ARC-Authentication-Results: i=1;
	rspamd-5bd676bfcd-lbch5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Bored: 3cbd265e2ef030dd_1746544277730_1014760053
X-MC-Loop-Signature: 1746544277730:2123283733
X-MC-Ingress-Time: 1746544277730
Received: from pdx1-sub0-mail-a296.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.221.95 (trex/7.0.3);
	Tue, 06 May 2025 15:11:17 +0000
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a296.dreamhost.com (Postfix) with ESMTPSA id 4ZsMKx1mx3zQp
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1746544277;
	bh=6TRxSjfeJM0ZA871Fsc/CGXXTvzJM6CyHDWup/G2ImI=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=kP9DmpqJD+Z257/LnXNarvV3OQBcAWwjhbevkt/Uxnr+fEhwVgRldPqGI1/uidcGN
	 8kCAdgbEt7ObXeIC7IP25Q+b2FWCpACwbl3AecZK+v8TQIhcB8pF8QiVXDHVhS3nfc
	 2gPHY06eY4oIY0mBq41lGWn440Q5nu80WZbkculg0qm/57BTzwPydqzlURTkpNsUo6
	 vQSOVp+58TTN2/FGoiT/7fDieZrb1O5xMPaV9hYCArTLSXpXcv7yL9LqTO6qpYWJrf
	 eRNfItIOwO3+n1xA/h27Akl2LZ5MKFecGa5RDun8cCDxP+PNCkBEPWcum4RlMnY34f
	 pIBgxB904wCbQ==
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a0af41faa5so426171f8f.2
        for <linux-nfs@vger.kernel.org>; Tue, 06 May 2025 08:11:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YyV7gX5urkIGijyaBcWKDZHyYUpUrKRVl17G4KgbznZoTP6ZKLv
	gDwNFTq5L1emgEZ6NTtkSeiRsWERBWFr7B8LxxWyLyvYBB4Ev1ioC3g84ZdJiV6YcDV7n8QOiNF
	Yds9oUSaUM23BtVNyd7Ubztx9Jac=
X-Google-Smtp-Source: AGHT+IEvuPKRP8mwNDCjF3SWCF/lAkA1M/jV1dqiQ5YcNSxVQnZpbo5WLsNykGBZ5PXRCsqaXcNc07TYKx8A5IFC2ss=
X-Received: by 2002:a05:6000:250d:b0:3a0:b448:e654 with SMTP id
 ffacd0b85a97d-3a0b448e769mr74940f8f.47.1746544275612; Tue, 06 May 2025
 08:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506150105.11874-1-cel@kernel.org>
In-Reply-To: <20250506150105.11874-1-cel@kernel.org>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Tue, 6 May 2025 17:10:39 +0200
X-Gmail-Original-Message-ID: <CAKAoaQ=2F+_-s_yCTgxbCZALB2J-gjVGP7roU5DfrBP-dtZ0aQ@mail.gmail.com>
X-Gm-Features: ATxdqUGSuFFx1u2F0oBL7Cbkl4lcr92nIDuVWszWM0DVps8AMa71IcH6MVCreUg
Message-ID: <CAKAoaQ=2F+_-s_yCTgxbCZALB2J-gjVGP7roU5DfrBP-dtZ0aQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:01=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> RFC 7862 states that if an NFS server implements a CLONE operation,
> it MUST also implement FATTR4_CLONE_BLKSIZE. NFSD implements CLONE,
> but does not implement FATTR4_CLONE_BLKSIZE.
>
> Note that in Section 12.2, RFC 7862 claims that
> FATTR4_CLONE_BLKSIZE is RECOMMENDED, not REQUIRED. Likely this is
> because a minor version is not permitted to add a REQUIRED
> attribute. Confusing.
>
> We assume this attribute reports a block size as a count of bytes,
> as RFC 7862 does not specify a unit.
>
> Reported-by: Roland Mainz <roland.mainz@nrubsig.org>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> X-Cc: stable@vger.kernel.org # v6.7+
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index e67420729ecd..59d186ea11dc 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3391,6 +3391,14 @@ static __be32 nfsd4_encode_fattr4_suppattr_exclcre=
at(struct xdr_stream *xdr,
>         return nfsd4_encode_bitmap4(xdr, supp[0], supp[1], supp[2]);
>  }
>
> +static __be32 nfsd4_encode_fattr4_clone_blksize(struct xdr_stream *xdr,
> +                                               const struct nfsd4_fattr_=
args *args)
> +{
> +       struct inode *inode =3D d_inode(args->dentry);
> +
> +       return nfsd4_encode_uint32_t(xdr, inode->i_sb->s_blocksize);
> +}
> +
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  static __be32 nfsd4_encode_fattr4_sec_label(struct xdr_stream *xdr,
>                                             const struct nfsd4_fattr_args=
 *args)
> @@ -3545,7 +3553,7 @@ static const nfsd4_enc_attr nfsd4_enc_fattr4_encode=
_ops[] =3D {
>         [FATTR4_MODE_SET_MASKED]        =3D nfsd4_encode_fattr4__noop,
>         [FATTR4_SUPPATTR_EXCLCREAT]     =3D nfsd4_encode_fattr4_suppattr_=
exclcreat,
>         [FATTR4_FS_CHARSET_CAP]         =3D nfsd4_encode_fattr4__noop,
> -       [FATTR4_CLONE_BLKSIZE]          =3D nfsd4_encode_fattr4__noop,
> +       [FATTR4_CLONE_BLKSIZE]          =3D nfsd4_encode_fattr4_clone_blk=
size,
>         [FATTR4_SPACE_FREED]            =3D nfsd4_encode_fattr4__noop,
>         [FATTR4_CHANGE_ATTR_TYPE]       =3D nfsd4_encode_fattr4__noop,

Looks good to me -  Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

