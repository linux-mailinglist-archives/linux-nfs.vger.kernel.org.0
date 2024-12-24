Return-Path: <linux-nfs+bounces-8764-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BAB9FBFCC
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 16:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5854B164DF3
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D4E193409;
	Tue, 24 Dec 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWVYMe8n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF437E9
	for <linux-nfs@vger.kernel.org>; Tue, 24 Dec 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735055444; cv=none; b=ZgTJVEkPawkPP49rRKzsiUZ9t/efUkCXjRuxPWCR/6SykS0wRi6KWdWGqBlVfccWmyl14XgC32ZBVxy9DSXyfBYQiwBngX3J0d/FSRjY5+OuJ0PskE2p1tKAbJc5rX0cRGtMCwoAPNTcX0Whxb21a/TevyL/qO9Sx/+HqsTZYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735055444; c=relaxed/simple;
	bh=Dj5BS4Eg731qYqHzU+ABTnF913k1pA4aq0ni/31BOos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUSIsRfMB0/k9kp1aFeAnBw08Ssvh3ExIY/CgyBfRWni37uZG5YH0YErFJqip/L5XiFz179ewWsIgdlbeJs4AybLDaq5qAHRjGDLPggpsWvOzNIe0xM9wqpgrdhiHrDRuOmTSxfJhWUPomyfg2KsZhcaJ5waKPPeBmRk86LxA1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWVYMe8n; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so2606608a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 24 Dec 2024 07:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735055441; x=1735660241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on+l0rbuxlVJjAZqY9ZfDQ5mpgtb3G8XjRzhicpxpzE=;
        b=DWVYMe8nhNm7YjhsLtx/3n9REpS7CZmh/GFlUJuG51qTiWw01WbX2KU+NlLiCyzSZT
         oYUififSoWANFMZZFiftF1SD6p9ghgL/mKCAMh36X6s1LxL/DARa+vhSB+o6+7UE618s
         duBteKbldymP3HSHCHs0AnRtyLLfxQsjIrIpdJep6MNkytmeZdlGiK9M2Ue9s/NftYE4
         akUehza8dEZI5MZ9JjYE9jiwwkvgH6aHRkoYtbOA+1jM5t3OOO/znV22a9KXufCxBFwk
         xNqylD+5822KfHxoXZCkByqyWwINInyXdQShX72Imsv5bYgGTh3q3e8eSlphFnAWK104
         AFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735055441; x=1735660241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=on+l0rbuxlVJjAZqY9ZfDQ5mpgtb3G8XjRzhicpxpzE=;
        b=YIt9mcsF69Mq8+5HEJVyMfkhUf2MDFAILrTZBqjp/L/zm+HvWBXddL4JkuowVEsJ3L
         j4pFP4i6W6qeSwpvaUFy+i8e+d36vogFeu+p0QpJiehchfyoJshNMUw7U9s3JGgF/Nq2
         sAvhoTQdnb8mI51u5wEzh8iaamEeVKQtresmf/ZKKRJzI+PHe/cl4c8h9TGEFC9TjGPy
         Mh7e5Q2kEMCtzJfMTlMV8vU7fKWsXTOjX6WJaBNx5rCs8lQzNB1zQrevh1HX8dI+eiKJ
         pwbp5op12IIgNWWry6sJ2bRUNLPdQ9ib0oLh+SFvz2qXmI3crz1cegUerwSKGEaCoBpf
         vNJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhw98ASWXgLxLgJvflOeTRdADlVsmkUUvqVzP5MEMQ28Fa+TndIJV8Y6IotbmvIiy43Nyn3VtHudk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4eeWK2RmYabpsHIrGL3uGhBnfcHOR0xN3GdxvPETsFpQ2sv7
	IVgTM2L6o/WkoRjpWRVM9pJY8xtZBnDFqm9PJNE5ifGexMqzw9uI05ul8vsoQei8++RCqg6EHYE
	M3DYtzyzQRIugWOXGhqVQjUs5gQ==
X-Gm-Gg: ASbGncvM5EVmE/ffuzHy5Pww4sV/p3foihw6mMhMGodOz+J/kV4xu5N/t8EBCTo4F2j
	S6fpXHyTALdmMeuIfUkFyV517DlOLXUb4iGBiBCKWjZAhXO/pkwAW2GxKt0HjQ1C3JIF0Nw==
X-Google-Smtp-Source: AGHT+IFEXEg7Osycb0aWGdTiv3FkHG1BReRQw2L71xa6NDoFPgKW9bS7COdDIYjbXbcy8VT2LdLGFzCs6jbHwIjwc9c=
X-Received: by 2002:a05:6402:510d:b0:5cf:e894:8de9 with SMTP id
 4fb4d7f45d1cf-5d81dd548c6mr14425287a12.3.1735055440633; Tue, 24 Dec 2024
 07:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223180724.1804-4-cel@kernel.org> <CAM5tNy74=vqdSaciOKus0SeU4eBB+Vb-TzKO060t1RSdAQYGxQ@mail.gmail.com>
 <7daa45c2-13c4-4617-9f9e-7be5ae607b4a@oracle.com>
In-Reply-To: <7daa45c2-13c4-4617-9f9e-7be5ae607b4a@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 24 Dec 2024 07:50:29 -0800
Message-ID: <CAM5tNy5t5GeW+x=_dtZ1akQA_B9NyrGk6TkVnVkLXh443Q8OJw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix XDR encoding near page boundaries
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 6:16=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 12/23/24 6:22 PM, Rick Macklem wrote:
> > On Mon, Dec 23, 2024 at 10:07=E2=80=AFAM <cel@kernel.org> wrote:
> >>
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Build out the patch series to address the longstanding bug pointed
> >> out by J David and Rick Macklem.
> >>
> >> At least during NFSv4 COMPOUND encoding, using
> >> write_bytes_to_xdr_buf() seems less brittle than saving a pointer
> >> into the XDR encoding buffer.
> >>
> >> I have one more patch to add (not yet included) that addresses the
> >> issue in the NFSv4 READ and READ_PLUS encoders.
> > It also looks like there is a similar situation in nfsd4_encode_fattr4(=
).
> > It uses attrlen_p (only a 4byte xdr_reserve_space(), so safe for now.
> >
> > You might just regret choosing to not wire down the "safe to use
> > xdr_reserve_space() for 4 bytes" semantic, but it is obviously up to yo=
u.
>
> I'm 100% behind the idea of making it hard or impossible to code
> things the wrong way.
Righto, sounds good to me.

>
> But I'm not sure what you mean by "wire down". I can't think of a way
> to enforce the "only 4 octets or less" rule -- just having a helper
> function with that name documents it but doesn't enforce it.
Agreed. By "wired down" I was simply thinking of defining it as
required behaviour. Documented by a comment update or similar.

I was being a little "tongue in cheek" when I made the comment,
referring to all the work involved.

Good luck with it and have a good holiday, rick

>
> My plan is to replace the obviously unsafe call sites immediately,
> document the desired long-term semantics, then replace the other
> "safe for now" call sites over time.
>
> I've found a few other potentially unsafe server-side callers:
> * gss_wrap_req_integ
> * gss_wrap_req_priv
> * unx_marshal
>
> I consider these "safe for now" because the reserved space is guaranteed
> to be in the XDR buffer's head iovec, far away from page boundaries.
>
> I'm hoping that no-one introduces new unsafe call sites in the meantime.
> We should be able to catch that in review.
>
> That also buys some time to come up with something better.
>
>
> > rick
> >
> >>
> >> Changes since RFC:
> >> - Document the guarantees around pointer returned by xdr_reserve_space=
()
> >> - Use write_bytes_to_xdr_buf() instead
> >>
> >> Chuck Lever (2):
> >>    NFSD: Encode COMPOUND operation status on page boundaries
> >>    SUNRPC: Document validity guarantees of the pointer returned by
> >>      reserve_space
> >>
> >>   fs/nfsd/nfs4xdr.c | 20 ++++++++++----------
> >>   net/sunrpc/xdr.c  |  3 +++
> >>   2 files changed, 13 insertions(+), 10 deletions(-)
> >>
> >> --
> >> 2.47.0
> >>
>
>
> --
> Chuck Lever

