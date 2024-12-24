Return-Path: <linux-nfs+bounces-8757-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEC59FB7F4
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 01:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15061884A7D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 00:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1BB367;
	Tue, 24 Dec 2024 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X86qlDzn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B718D;
	Tue, 24 Dec 2024 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734998829; cv=none; b=MmKs1xycQWJcZ6rmkduOcQNw+BVkEP3tmJlBhLMclNcWbeN2SjhTnozoaq7QyBeS3aBQtG0TdYwABYcbPQb8xMQChg6HqNKYIrvkqNhSshXtMucmKWkBGbSuOogPgSeu2QENUt86sokwPQEBMCvdQoOQ5C6v9GIeaTt/W/1XciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734998829; c=relaxed/simple;
	bh=Xhig4yjzCXQSuPEmJy/IOpdcXFCQoMkKEqtoDg1Ku/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b45JvnGRwesbgTEUyai5Qa7BJRKfafOTzmRvMqErHTVXLdgF6EbyxAFXkjOd0qR7/kUtcM1QMDxqfrQcb89LKbKTbALtSpgmBJeP4BajnQaDHXlb7jaxRuKXwbBTFGCr6gynuSHW1fBdFjWFnQpBDdzjJcNRnUi/PqbJdnvR+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X86qlDzn; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso8740171a12.0;
        Mon, 23 Dec 2024 16:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734998826; x=1735603626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lMU+hQtbnunvlQNknpF6Gcl4rHXPH30K4I/D3Bk1Ik=;
        b=X86qlDzn3eTMOOXJnZ9Y2Bl4pza5lZ+2W0AsSN+18tLFwXvbtB06DZWEIfMnC7eXr3
         6a3FuAkbe+9C9hg6NJpcSP/IXLqUR373ppMMogvUOe1y2WkQtIYsAP09dWVc6avgxG1L
         9tALdb8+08wY04T7QduVZG+MOBfLsdyQsVt9eCCu0dsC8JFM2G33wrePMh54DwTpoWOT
         ee7D5ZbX1Tr3esHT6iEZEk/EiJPw0qwbV369zYxhiV4zXk8YXnTP2Q6a8e2DlVV/zYun
         atmMkRQ6eYrPPC05pvU7vQoVYUCHRsYEu80moCxhPeU4FxJQNi1s/i6Meq7q7rzLz/Oa
         Bmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734998826; x=1735603626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lMU+hQtbnunvlQNknpF6Gcl4rHXPH30K4I/D3Bk1Ik=;
        b=bCVW3EXj20e0o2TMmrBb0ewej6qZ3T/xrd1iKauCkeNvS2JSMOAUFtoNFLPjWQ+roy
         V9bJzSnrQBIgTmhz2ynD1TpnkQ86vxqgQl/OT9Vo+FB4VnIiIYbYqtET76xLUr8oUCh0
         G3mE1c2pSfHk4gKx8LkSSVKm8C5b2xjQLhXYuarVyMdo1odiemHsFOFoo/r8O7jLDK8l
         QSlkKcKo+SYFULPqv8Ycxhtp4Q92bny52R/52VmmhaihVZK0mDoIGSm8MdlBu2AyEouz
         zqR5ayyb57+VzlRd3ZWilF0/qk2pBPPIUK24nngqvikk60u4WjIuTPTf3QqTtDjswvIW
         fBBA==
X-Forwarded-Encrypted: i=1; AJvYcCUxnr7gVRkWXoNxgR93fr807OVVMP9rr++4XVlL3axsqbl7UsdrBeBVfWKwH0Rq+WWz/cki0kb1zxc=@vger.kernel.org, AJvYcCWfsmxRLzAm7BIfFS8ToTqwGH3s3UBNdgf0G1niqUYUq760vXgzc1TOc1YiDyFUvtRnEeuJ64E/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywou7UVGJ0rn71w2ILapga5xYre34qGVFq0yVKG9FTH/YczTm8o
	eJjlXPLjJGZog0EHVQO30u5/osm7ORGD4dz4z2f3vm4L7j70+6i94TsCSTzJHP2TT1h+kOMgRUU
	YVm6KCaNoOWZFQIxGLPhpjlN3PA==
X-Gm-Gg: ASbGnctJ8IQfsWNGPrXv/8tQrysUPsYxgqu7b/SjaEmq++Kep+I78xnLljnDh3GX3du
	Y6fAJ7GLmerQbXHiP318apFFbzmdn4Lz2y7yMaCICMVSB04FVkGGXrcn3kQPZhri3FTU1xw==
X-Google-Smtp-Source: AGHT+IEkUCccwpx98cGyBa26102/uNic63XZiVjc6A2Ca12R+xC7iT3UPSMgagN20xBViaS/grxWrBtg+YNaO99j+4g=
X-Received: by 2002:a05:6402:2802:b0:5d2:723c:a568 with SMTP id
 4fb4d7f45d1cf-5d81ddf3ba0mr14964076a12.10.1734998825486; Mon, 23 Dec 2024
 16:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223001005.3654-2-cel@kernel.org> <CAM5tNy4EYVuWXVzAwmrFJ=Sa5CnhLOZW40=gtFZka9gHzkxtwQ@mail.gmail.com>
 <3d0804bb-ecc7-4507-9247-1d0dd8305073@oracle.com>
In-Reply-To: <3d0804bb-ecc7-4507-9247-1d0dd8305073@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 23 Dec 2024 16:06:55 -0800
Message-ID: <CAM5tNy7iZdhJ_f6uZbAkthdXiEBg7nj-yQyUxfKx1gFy5qiW5Q@mail.gmail.com>
Subject: Re: [RFC PATCH] NFSD: Encode COMPOUND operation status on page boundaries
To: Chuck Lever <chuck.lever@oracle.com>
Cc: cel@kernel.org, Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, J David <j.david.lists@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 6:31=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 12/22/24 8:25 PM, Rick Macklem wrote:
> > On Sun, Dec 22, 2024 at 4:10=E2=80=AFPM <cel@kernel.org> wrote:
> >>
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> J. David reports an odd corruption of a READDIR reply sent to a
> >> FreeBSD client.
> >>
> >> xdr_reserve_space() has to do a special trick when the @nbytes value
> >> requests more space than there is in the current page of the XDR
> >> buffer.
> >>
> >> In that case, xdr_reserve_space() returns a pointer to the start of
> >> the next page, and then the next call to xdr_reserve_space() invokes
> >> __xdr_commit_encode() to copy enough of the data item back into the
> >> previous page to make that data item contiguous across the page
> >> boundary.
> >>
> >> But we need to be careful in the case where buffer space is reserved
> >> early for a data item that will be inserted into the buffer later.
> >>
> >> One such caller, nfsd4_encode_operation(), reserves 8 bytes in the
> >> encoding buffer for each COMPOUND operation. However, a READDIR
> >> result can sometimes encode file names so that there are only 4
> >> bytes left at the end of the current XDR buffer page (though plenty
> >> of pages are left to handle the remaining encoding tasks).
> >>
> >> If a COMPOUND operation follows the READDIR result (say, a GETATTR),
> >> then nfsd4_encode_operation() will reserve 8 bytes for the op number
> >> (9) and the op status (usually NFS4_OK). In this weird case,
> >> xdr_reserve_space() returns a pointer to byte zero of the next buffer
> >> page, as it assumes the data item will be copied back into place (in
> >> the previous page) on the next call to xdr_reserve_space().
> >>
> >> nfsd4_encode_operation() writes the op num into the buffer, then
> >> saves the next 4-byte location for the op's status code. The next
> >> xdr_reserve_space() call is part of GETATTR encoding, so the op num
> >> gets copied back into the previous page, but the saved location for
> >> the op status continues to point to the wrong spot in the current
> >> XDR buffer page because __xdr_commit_encode() moved that data item.
> >>
> >> After GETATTR encoding is complete, nfsd4_encode_operation() writes
> >> the op status over the first XDR data item in the GETATTR result.
> >> The NFS4_OK status code (0) makes it look like there are zero items
> >> in the GETATTR's attribute bitmask.
> > I can confirm that this patch fixes the test case I have, which is base=
d on
> > J. David's reproducer.
>
> May I add:
>
> Tested-by: Rick Macklem <rick.macklem@gmail.com>
>
> ?
Sure, if you'd like. I have now tested both versions of the patch.
I suppose I'm more well known as rmacklem@uoguelph.ca but they both work.

>
>
> > I also think the analysis sounds right. I had gotten to the point where
> > I thought it was some oddball case related to xdr_reserve_space() and
> > saw that the pointer used by GETATTR's nfsd4_encode_bitmap4() was
> > 4 bytes into a page, for the broken case.
>
> May I also add:
>
> Reviewed-by: Rick Macklem <rick.macklem@gmail.com>
>
> ?
Both patches look fine to me, although I do not understand the code
in __write_bytes_to_xdr_buf(), so I'm not sure I'm the guy to review this s=
tuff.
I do understand that a xdr_reserve_space(xdr, 4) is safe, since it is impos=
sible
for it to straddle a page.

I'll leave it up to you.

>
>
> > (As an aside, it appears that "%p" is broken for 32bit arches. I needed=
 to
> > use "%x" with a (unsigned int) cast to printk() pointers. I doubt anyon=
e  much
> > cares about 32bits any more, but I might look to see if I can fix it.)
>
> On Linux, the %p formatter emits a hash instead of the actual pointer
> address, for security reasons. There are ways to disable this -- see
> the "no_hash_pointers" kernel command line argument for the big hammer.
>
> (Documentation/admin-guide/kernel-parameters.txt)
Thanks for the info. The "pointers" did throw me off for a bit;-)

Thanks, rick

>
>
> > Good work Chuck!
>
> Thanks!
>
>
> >> The patch description of commit 2825a7f90753 ("nfsd4: allow encoding
> >> across page boundaries") [2014] remarks that NFSD "can't handle a
> >> new operation starting close to the end of a page." This behavior
> >> appears to be one reason for that remark.
> >>
> >> Break up the reservation of the COMPOUND op num and op status data
> >> items into two distinct 4-octet reservations. Thanks to XDR data
> >> item alignment restrictions, a 4-octet buffer reservation can never
> >> straddle a page boundary.
> > I don't know enough about the code to comment w.r.t. whether or not thi=
s
> > is a correct fix, although it seems to work for the test case.
>
> The most correct fix, IMO, would be to use write_bytes_to_xdr_buf()
> to insert the op status once the operation has been encoded. That
> API does not depend on an ephemeral C pointer into a buffer.
>
> The most performant fix is the one proposed here, and this one is
> also likely to apply cleanly to older Linux kernels.
>
>
> > I will note that it is a pretty subtle trap and it would be nice if som=
ething
> > could be done to avoid this coding mistake from happening again.
> > All I can think of is defining a new function that must be used instead=
 of
> > xdr_reserve_space() if there will be other encoding calls done before t=
he
> > pointer is used. Something like xdr_reserve_u32_long_term(). (Chuck is
> > much better at naming stuff than I am.)
> > --> If your fix is correct, in general, this function would just call
> > xdr_reserve_space(xdr, XDR_UNIT),
> >        but it could also set a flag in the xdr structure so that it can
> > only be done once until
> >        the flag is cleared (by a function call when the code is done
> > with the pointer), or something like that?
>
> Well there's no limit on the number of times you can call
> xdr_reserve_space(XDR_UNIT) and save the result.
>
> It just so happens that, with the current implementation of
> xdr_reserve_space(), reserving up to 4 octets returns a pointer that
> remains valid as long as the buffer exists. For larger sizes, that
> doesn't happen to work -- the returned pointer is guaranteed to be valid
> only until the next call to xdr_reserve_space() or xdr_commit_encode().
>
> The only reason to use the "save the pointer" trick is because it is
> more performant than write_bytes_to_xdr_buf() (go look at what that API
> does to see why).
>
> So the whole "save a pointer into the XDR buf, use it later" trick is
> brittle and depends on an undocumented behavior of that API. At this
> point, the least we can do is add a warning to reserve_space's kdoc
> comment. The best we could do is come up with an API that performs
> reasonably well and makes this common trope less brittle.
>
> I'm auditing the code base for other places that might make unsafe
> assumptions about the pointer returned from xdr_reserve_space().
> nfsd4_encode_read() and read_plus() both do. Probably the SunRPC GSS-API
> encoders do as well.
>
>
> > Anyhow, others probably can suggest better changes that would avoid thi=
s trap?
> >
> > Good work, rick
> >
> >>
> >> Reported-by: J David <j.david.lists@gmail.com>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>   fs/nfsd/nfs4xdr.c | 5 +++--
> >>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> >> index 53fac037611c..8780da884197 100644
> >> --- a/fs/nfsd/nfs4xdr.c
> >> +++ b/fs/nfsd/nfs4xdr.c
> >> @@ -5764,10 +5764,11 @@ nfsd4_encode_operation(struct nfsd4_compoundre=
s *resp, struct nfsd4_op *op)
> >>          nfsd4_enc encoder;
> >>          __be32 *p;
> >>
> >> -       p =3D xdr_reserve_space(xdr, 8);
> >> +       if (xdr_stream_encode_u32(xdr, op->opnum) !=3D XDR_UNIT)
> >> +               goto release;
> >> +       p =3D xdr_reserve_space(xdr, XDR_UNIT);
> >>          if (!p)
> >>                  goto release;
> >> -       *p++ =3D cpu_to_be32(op->opnum);
> >>          post_err_offset =3D xdr->buf->len;
> >>
> >>          if (op->opnum =3D=3D OP_ILLEGAL)
> >> --
> >> 2.47.0
> >>
>
>
> --
> Chuck Lever

