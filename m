Return-Path: <linux-nfs+bounces-8713-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6CD9FA8EE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 02:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5619D1885AE3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 01:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A1D529;
	Mon, 23 Dec 2024 01:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoxXPCAw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4F21392;
	Mon, 23 Dec 2024 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734917158; cv=none; b=Cle2filclrdGPzx32xpRzQV7YdKWslrlbuuK0kLVREUhBLhgIizXHoMK8YnCSPwnqfUUjtzjcmrhxIkJNZUF73Fq54u0uY627uONH/gpb3bGUPaJwn/dV1QATyS5cFLs4aV9xOBqHhgHueHsJsHSYRAgdzbViKh506dCLHxX8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734917158; c=relaxed/simple;
	bh=x2bjMp4sTZykqhC5FyeiB5Ii8bANLSEBFAcT4YhXf7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obCxX5Ae+GxAFPmgUgaW+sc6q82rU03bGVxI6S3pTMV7jwIMwgVcnXoo6PMEamnj0fMZ2TGqb24dYxT8QP8cTcPOUF0QDYWip9rsMCfA2iv7X/82DNDrUzTeQeyDmM+O2IOXH1waEVzhiFtgp/Wul+pr/bgy4XK2nuAZG6aMRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoxXPCAw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so667591766b.2;
        Sun, 22 Dec 2024 17:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734917155; x=1735521955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef3IYew/4vIpmOnh7wyKSv5r1he/b1poVeFHkaQc+5c=;
        b=UoxXPCAwfKWCU5lOaMuxkBNMGqHgLPLrHoROh+m3PRzu2P/Oz0q/Pu3tjsu089s8+l
         K7N4U3dBIViKp4xVZmYhr5Z0AXiH2oNJ5auW4ijEH/VHj/Mfx17vxvWA4O+QH0DaYPqV
         S/0CD9qdCCF3w2bpjR99Uv3bAACqlMxZ0rgOjgET3ukKdbWiH6C+VWhwxWwX4ncgd288
         xjeC7DsL0qnZOjpgzWmv6N6jyT7C9dB71QAOTU2GCpBBDlKYMpUWUAKddHVbaPXt0kW6
         6qs6ELqAEtFTlbsC2ylwLLKqpzhSHX26EgSuwAvZzdAHEVwnsHvwgDbRdur8gsynjHw7
         2JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734917155; x=1735521955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef3IYew/4vIpmOnh7wyKSv5r1he/b1poVeFHkaQc+5c=;
        b=eIIdyEly5T6s+XreFg4J3r+CCqGqChhV+Vu6ZHdbN1sQfUoz2oRGafA0MWYW4/3fBy
         UC/NlAlGfzwbDcP0F+e0dbwTnZi6i4sTnRxrMKMMtRiNDLH8RdqKfeBF87oSl26uBZmo
         d0bD3ZeCUrirZ2WWwAAe6WDMGJD6y4tMDYeEbkUi73S/k53/jU6lLXH5nmAuStSdd6qu
         s7qlH8MuwYeXDK4VNmrFCqrmV1ZjhBqkL2RIoZU/SIGsYN7obgB7FTDMNslEAOGApYB8
         pMjooYqkEzo9n5lDYiNov398bJ0nTHxVcicU117/Vhnm9UnGMoKmMbW7YfZrvgvQ3WkX
         jsNA==
X-Forwarded-Encrypted: i=1; AJvYcCU3uYr49QY9C7IVh5eLyJHjoTvGIQQnHjiJw+VA6WCbwhv2N33FwaEegSS7lbPIqCYr7g1QSYL0@vger.kernel.org, AJvYcCUTuNAi0abKQ/nbemfT6wbVRfKwgpxvggnnB5W6OOs11FceQS5WABYVhOjlmvn82eF+5ciDJBsZIUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9bTYsPu8MSXA2zhRxFXtsTPVfF4OnwvdxnzzbbpHJ3+SQvUN
	Eot1jfvL1IhC/8E6nev5oiC7vH2sYt6BsxcbkoQubROVYXUpOzaGiKgDSa7Fj25CxV0oHhA6bCe
	u2LhX7x61eQ1gobm6C2buaFILVd8s
X-Gm-Gg: ASbGncsXPTwtTdgzaTvj+9EXTXo1ClGZuT47T55/Ay+S+ONIrLcYCDjCJi6TXescG+W
	kAG03wfyteLk2t8GWOa3IGb06r5W1u8N30wc4ErUpzyNYlrSBI1WGsmByIYYWiJLUWLEt
X-Google-Smtp-Source: AGHT+IH8GT6UY+t9fqj2oJsOn37Rw/AjBBU0rx1t9eCobMYU50OVDNhmk4tAUTjEAVfNi7t7+bTVEvZVr50krJTqFM8=
X-Received: by 2002:a17:907:97d2:b0:aa6:90a8:f5ff with SMTP id
 a640c23a62f3a-aac347cbdf6mr1053417366b.50.1734917154291; Sun, 22 Dec 2024
 17:25:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223001005.3654-2-cel@kernel.org>
In-Reply-To: <20241223001005.3654-2-cel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 22 Dec 2024 17:25:45 -0800
Message-ID: <CAM5tNy4EYVuWXVzAwmrFJ=Sa5CnhLOZW40=gtFZka9gHzkxtwQ@mail.gmail.com>
Subject: Re: [RFC PATCH] NFSD: Encode COMPOUND operation status on page boundaries
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	J David <j.david.lists@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 4:10=E2=80=AFPM <cel@kernel.org> wrote:
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
I can confirm that this patch fixes the test case I have, which is based on
J. David's reproducer.

I also think the analysis sounds right. I had gotten to the point where
I thought it was some oddball case related to xdr_reserve_space() and
saw that the pointer used by GETATTR's nfsd4_encode_bitmap4() was
4 bytes into a page, for the broken case.
(As an aside, it appears that "%p" is broken for 32bit arches. I needed to
use "%x" with a (unsigned int) cast to printk() pointers. I doubt anyone  m=
uch
cares about 32bits any more, but I might look to see if I can fix it.)

Good work Chuck!

>
> The patch description of commit 2825a7f90753 ("nfsd4: allow encoding
> across page boundaries") [2014] remarks that NFSD "can't handle a
> new operation starting close to the end of a page." This behavior
> appears to be one reason for that remark.
>
> Break up the reservation of the COMPOUND op num and op status data
> items into two distinct 4-octet reservations. Thanks to XDR data
> item alignment restrictions, a 4-octet buffer reservation can never
> straddle a page boundary.
I don't know enough about the code to comment w.r.t. whether or not this
is a correct fix, although it seems to work for the test case.

I will note that it is a pretty subtle trap and it would be nice if somethi=
ng
could be done to avoid this coding mistake from happening again.
All I can think of is defining a new function that must be used instead of
xdr_reserve_space() if there will be other encoding calls done before the
pointer is used. Something like xdr_reserve_u32_long_term(). (Chuck is
much better at naming stuff than I am.)
--> If your fix is correct, in general, this function would just call
xdr_reserve_space(xdr, XDR_UNIT),
      but it could also set a flag in the xdr structure so that it can
only be done once until
      the flag is cleared (by a function call when the code is done
with the pointer), or something like that?

Anyhow, others probably can suggest better changes that would avoid this tr=
ap?

Good work, rick

>
> Reported-by: J David <j.david.lists@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 53fac037611c..8780da884197 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5764,10 +5764,11 @@ nfsd4_encode_operation(struct nfsd4_compoundres *=
resp, struct nfsd4_op *op)
>         nfsd4_enc encoder;
>         __be32 *p;
>
> -       p =3D xdr_reserve_space(xdr, 8);
> +       if (xdr_stream_encode_u32(xdr, op->opnum) !=3D XDR_UNIT)
> +               goto release;
> +       p =3D xdr_reserve_space(xdr, XDR_UNIT);
>         if (!p)
>                 goto release;
> -       *p++ =3D cpu_to_be32(op->opnum);
>         post_err_offset =3D xdr->buf->len;
>
>         if (op->opnum =3D=3D OP_ILLEGAL)
> --
> 2.47.0
>

