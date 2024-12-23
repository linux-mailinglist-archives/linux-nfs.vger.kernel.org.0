Return-Path: <linux-nfs+bounces-8714-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 696429FA90D
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 02:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1E6188591F
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Dec 2024 01:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0C14012;
	Mon, 23 Dec 2024 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkOZEIhZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CADD528;
	Mon, 23 Dec 2024 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734918317; cv=none; b=a3+WoduHaVHa2gEGG9KELQ8y44DcmPuZ9y7k/8uVMm3s2gRyy+Z5JtJl026VCbmJPI/7tmbyYQX5P/9YSZjXDwy177HPUEooTCbkE3LNFTZMPedcl1j9R1etKFy+F3MoidKoeMrZVWduWZqORyV7DUlf8oumyECYAaO6b1/lCeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734918317; c=relaxed/simple;
	bh=IADwT1ASv5b+mEyXyPpKE7q0AQti0JeRagF2Sd8iMHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKGiXdNxbytliElXxJ2z1aKOaYy6KqS45FOneV2zExxOuyfwXTA+N7PgpNJgOaEp6DSpj1H3swtMU5W4oQZ5CnaNWuzGcqJkPK2AQ0c50vrP/NopvL7EPxqbXQSl7FY72WZbHkns7pSR8asqWyVFet9vK2kZ6aEQ7kZZjbXaW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkOZEIhZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso5282862a12.3;
        Sun, 22 Dec 2024 17:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734918313; x=1735523113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcqVitReAslD1wR2ijx9sy1BWVMCeFwMMt/XKmiiD68=;
        b=TkOZEIhZlBMu+dIjXQZOoO0vucPHn/DSgXHvV7wjFZTPZM6Y94jswk9c52xOFNgoO1
         dzBJVaFw72UU/o5IA13Fhh/vN3FBJAhr6avzXHLola5yWa15q0BuIy7fSQLSCKVV7wTY
         ZKERvzzgdUY0Z3U+WVQ41BjbUsMPiq4DZKNYuiM9CR5WGLaaPBfjMY8ZbQtjvYQOwQ6P
         tdDLnmchxLeQsC2AbFsnIy84CslwaD0D+tJrK0dNWiYrmJHjtvcdLZRAic6uFL5kbEcm
         zMhorVMVdvXKbzM0/T5jbjO44Lkc46TjB8+s01XmtYLHxt4kP1i4Xul5BXHfm30mMr7Z
         Bb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734918313; x=1735523113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcqVitReAslD1wR2ijx9sy1BWVMCeFwMMt/XKmiiD68=;
        b=qMkOtAuGnkAVFGd7/6mVKNPnlten13sJ9c7PbojmbLfhuV03DsxydamGTdC4dptd9W
         1UnC9F7zyh/shnkbJbp6Bi3gllEOJW7//pZelCopCez776mkAXsHM0MpEwYItAowrGZ0
         AxhETRUcrZO27ClGzdpTFK8BlkIZ9mfbZcomy3TIgRMePGfC5DrCd4364VfehHPRL+H+
         4ywqg4XH3MCDvSOp1Z8kCUNtXsNPAEaY5XwnTLz8caovtMOZdYwpADaa7WTm1k576Zrz
         9BcgTXaWMoItwr4ZnyBN/PmLwiTI/JnLSEAYd82QxFzuRjC/JylHwIPsgG1UuzdVBHsk
         mB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYRN4Zi0E8rp9PwAjvcIfvEOY2kTxy/yy+gjFSwc/Fg3qYAU2J2W670gpo8U150z9hGrklQdTRhws=@vger.kernel.org, AJvYcCWk+u5p+x5rUmKgsrlDOOPM3+zU8m4fIctS8YkDWh0vKM9qWUhL5knsAkkGodrCUpluncLCqmQQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmN2PwSTDRkM8V5csrqxs1urBoBSMlHP0IeU+VRw+V+bLU2tq
	0UK8q4o4rELCGCorY8GGEVXCH+14YGI6MOYyouoxi01qhxlMXoFxa5O/+criJLgdmeFMB+ii2H3
	09G77BTYXISpE4I2KZlijzJhXWQ==
X-Gm-Gg: ASbGnct/rK6kk46XAp7dSOZbM6X5fA9pMWJEILpnQleH3Gwmbhwc1j9eoM9YhdvaWGe
	dVX1WJ2Y0O4Jj7I/q3Ddhh9T9Hey19enYQxb+2/PCGVpzJNdm8q8IM6gtPraDWksjcfi4
X-Google-Smtp-Source: AGHT+IEMuLk2jG/lnPkFEUYsFU9hvAfGnT30j3+pWAske5Pk58u4aLftQ7yBHAGASlihgaZcjiswCt8gEHTyGHsGISM=
X-Received: by 2002:a05:6402:4023:b0:5d1:3da:e6c with SMTP id
 4fb4d7f45d1cf-5d81dd8ea06mr11802526a12.10.1734918312696; Sun, 22 Dec 2024
 17:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223001005.3654-2-cel@kernel.org> <CAM5tNy4EYVuWXVzAwmrFJ=Sa5CnhLOZW40=gtFZka9gHzkxtwQ@mail.gmail.com>
In-Reply-To: <CAM5tNy4EYVuWXVzAwmrFJ=Sa5CnhLOZW40=gtFZka9gHzkxtwQ@mail.gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 22 Dec 2024 17:45:03 -0800
Message-ID: <CAM5tNy7FzBSyV1t90cvvB=wFJdJbEnRUBF8J=_dWA+aBZSb1Jw@mail.gmail.com>
Subject: Re: [RFC PATCH] NFSD: Encode COMPOUND operation status on page boundaries
To: cel@kernel.org
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	J David <j.david.lists@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 5:25=E2=80=AFPM Rick Macklem <rick.macklem@gmail.co=
m> wrote:
>
> On Sun, Dec 22, 2024 at 4:10=E2=80=AFPM <cel@kernel.org> wrote:
> >
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > J. David reports an odd corruption of a READDIR reply sent to a
> > FreeBSD client.
> >
> > xdr_reserve_space() has to do a special trick when the @nbytes value
> > requests more space than there is in the current page of the XDR
> > buffer.
> >
> > In that case, xdr_reserve_space() returns a pointer to the start of
> > the next page, and then the next call to xdr_reserve_space() invokes
> > __xdr_commit_encode() to copy enough of the data item back into the
> > previous page to make that data item contiguous across the page
> > boundary.
> >
> > But we need to be careful in the case where buffer space is reserved
> > early for a data item that will be inserted into the buffer later.
> >
> > One such caller, nfsd4_encode_operation(), reserves 8 bytes in the
> > encoding buffer for each COMPOUND operation. However, a READDIR
> > result can sometimes encode file names so that there are only 4
> > bytes left at the end of the current XDR buffer page (though plenty
> > of pages are left to handle the remaining encoding tasks).
> >
> > If a COMPOUND operation follows the READDIR result (say, a GETATTR),
> > then nfsd4_encode_operation() will reserve 8 bytes for the op number
> > (9) and the op status (usually NFS4_OK). In this weird case,
> > xdr_reserve_space() returns a pointer to byte zero of the next buffer
> > page, as it assumes the data item will be copied back into place (in
> > the previous page) on the next call to xdr_reserve_space().
> >
> > nfsd4_encode_operation() writes the op num into the buffer, then
> > saves the next 4-byte location for the op's status code. The next
> > xdr_reserve_space() call is part of GETATTR encoding, so the op num
> > gets copied back into the previous page, but the saved location for
> > the op status continues to point to the wrong spot in the current
> > XDR buffer page because __xdr_commit_encode() moved that data item.
> >
> > After GETATTR encoding is complete, nfsd4_encode_operation() writes
> > the op status over the first XDR data item in the GETATTR result.
> > The NFS4_OK status code (0) makes it look like there are zero items
> > in the GETATTR's attribute bitmask.
> I can confirm that this patch fixes the test case I have, which is based =
on
> J. David's reproducer.
>
> I also think the analysis sounds right. I had gotten to the point where
> I thought it was some oddball case related to xdr_reserve_space() and
> saw that the pointer used by GETATTR's nfsd4_encode_bitmap4() was
> 4 bytes into a page, for the broken case.
> (As an aside, it appears that "%p" is broken for 32bit arches. I needed t=
o
> use "%x" with a (unsigned int) cast to printk() pointers. I doubt anyone =
 much
> cares about 32bits any more, but I might look to see if I can fix it.)
>
> Good work Chuck!
>
> >
> > The patch description of commit 2825a7f90753 ("nfsd4: allow encoding
> > across page boundaries") [2014] remarks that NFSD "can't handle a
> > new operation starting close to the end of a page." This behavior
> > appears to be one reason for that remark.
> >
> > Break up the reservation of the COMPOUND op num and op status data
> > items into two distinct 4-octet reservations. Thanks to XDR data
> > item alignment restrictions, a 4-octet buffer reservation can never
> > straddle a page boundary.
> I don't know enough about the code to comment w.r.t. whether or not this
> is a correct fix, although it seems to work for the test case.
>
> I will note that it is a pretty subtle trap and it would be nice if somet=
hing
> could be done to avoid this coding mistake from happening again.
> All I can think of is defining a new function that must be used instead o=
f
> xdr_reserve_space() if there will be other encoding calls done before the
> pointer is used. Something like xdr_reserve_u32_long_term(). (Chuck is
> much better at naming stuff than I am.)
> --> If your fix is correct, in general, this function would just call
> xdr_reserve_space(xdr, XDR_UNIT),
>       but it could also set a flag in the xdr structure so that it can
> only be done once until
>       the flag is cleared (by a function call when the code is done
> with the pointer), or something like that?
I take back this latter bit w.r.t. a flag. If the function only
allocates 4bytes,
it will never straddle pages and cause problems.

My suggestion would just clarify that "long term" pointers can only be
used for a 4 byte (XDR_UNIT) allocation.

rick

>
> Anyhow, others probably can suggest better changes that would avoid this =
trap?
>
> Good work, rick
>
> >
> > Reported-by: J David <j.david.lists@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfs4xdr.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 53fac037611c..8780da884197 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -5764,10 +5764,11 @@ nfsd4_encode_operation(struct nfsd4_compoundres=
 *resp, struct nfsd4_op *op)
> >         nfsd4_enc encoder;
> >         __be32 *p;
> >
> > -       p =3D xdr_reserve_space(xdr, 8);
> > +       if (xdr_stream_encode_u32(xdr, op->opnum) !=3D XDR_UNIT)
> > +               goto release;
> > +       p =3D xdr_reserve_space(xdr, XDR_UNIT);
> >         if (!p)
> >                 goto release;
> > -       *p++ =3D cpu_to_be32(op->opnum);
> >         post_err_offset =3D xdr->buf->len;
> >
> >         if (op->opnum =3D=3D OP_ILLEGAL)
> > --
> > 2.47.0
> >

