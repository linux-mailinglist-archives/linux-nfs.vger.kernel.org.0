Return-Path: <linux-nfs+bounces-17338-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F6CE5360
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 18:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFB183001E0E
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Dec 2025 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7529E1DF965;
	Sun, 28 Dec 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpHMoGPp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906441D86FF
	for <linux-nfs@vger.kernel.org>; Sun, 28 Dec 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766941523; cv=none; b=rR3z/d5Af0RvHzdzQg6jT8ZnMqeyMihxCxCkGp8brW1ryofUlM5nFSO4bvoBSaK+4XBVD9Tn4yiZ/t2bzkmXe3GPn4aP2E15x6SY6XAzaSwikohcIeW5OJsujaf11p4laHyCmKUzHAwUXGor4Yi0JhccrTmbdwoKei9rm+mAncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766941523; c=relaxed/simple;
	bh=3DucbGtPZ5felzBOWpgi8qJAMXnk2PlVKt5A0DI2aZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrVgi9d/UB9wFnnLtxroRjVYf3gqWjGMt1/tFHUSeoJxkqIJn4hClJp0bNDaUyO/dTeehVSr8mOxaf52iExCSh0dND1Y6cCbPURB66LMNMy77+dC/AfDy/3x8xWGQzxTOpvieJElYm8Kg0cLZr1GUQGtd0Av41KMoB8Ph/rk86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpHMoGPp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b8e5d1611so10527903a12.3
        for <linux-nfs@vger.kernel.org>; Sun, 28 Dec 2025 09:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766941520; x=1767546320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XANfucacFTgLRA0k5oWd0No86MnElqAyTe2hgmnvD8=;
        b=gpHMoGPpIBimDIJaZ9iHLvBgPyd2MgGxYyyeRpHSeXZAXsHXf2T8FN5ptlZ9AfJvsb
         bYw6ia2RZ1/0ECsvxFLJ4qwsD4RsPV7Fkch+TOnmCQgiFf6Soaev6rj+5/ziWXlCOHdR
         Zuc75qgkhIvEevGdZTNRCGXGAl2YskmCVAbSmilz8xKymqwp+wsLDu/1pwmkFSgGGJED
         KZPJdhfECSLOK5od69cmhyoLFQSHnCKeW23n222g1r9+Hq/AoULrDPgnUd7H+sGki3Ao
         s8kKHlDLJYt84/crJRy1TN2llFM97HJdRomJAlcvTcCUOJtFvAB/8l1OYVhtRKsHzEbY
         joXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766941520; x=1767546320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0XANfucacFTgLRA0k5oWd0No86MnElqAyTe2hgmnvD8=;
        b=bitCxcTyBZsFmv0iiYwOfrNCU68bNFcKRoZ7e6fFM3EmY0HYd0oSkIDlmrQCwFU55e
         JorpvognyER889RQI/8Mt2k3U6S1utSULBIYCXKtjrs+YFfYPBuRsGu9YGo/LtBIVINf
         8loXXLahxVyxe2qycD+Lw9E1d70QJlnmUlHvf0/5DPwA8KU5QJHqETbbGdTYQ8zhaigB
         Vf30g7Dim9p8hiTtFj5XI4n1L1gjr4NJdMJQal9VgVTH8E57qT0iOleDdVBX6qZDJXfp
         qE3mlbvnF1XUav1+4d58D8yyilRjKQ4JrmtuC9fobyh5C43cEqSTOqJYgJb5Xqsy8lfJ
         icdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj8z+xE4X5In/wtRO/QR9d62Pw15jXoljR1g8vBfvy+OK1wlsdUL2k2rtOYR4gXb+bHaV960fshq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaRpnkqWN0LOvoIl9kpSoyCT90OCgOPv6qcvOKZMBrJsApdP7F
	ySZ2feRap7gmKRWKjw6crkgd+gVadZuVyjGfy9VN9rwkJp/a++F6HXs3UqJFIl03FQJ1fPLtSF2
	qGrS+ulToBljK6/kt3pfPWOOzx+kQWQ==
X-Gm-Gg: AY/fxX7ukNDnNy6TRBTFlAWxeV1Gr9Sxo3iXhq2nVpHXBK5eWGu8umVrAK+2fciF1Nl
	GptUUb2nsjeg4gNJ3O6mDgrNW+7iW7+HsNJPR6txyGZouay0XUhg93YTMb7NhaQBDmv9Wz15Cbo
	nZM/u5PNGwvfIAUJjrJkh6MuDzLzu6q7KCU0dXkTpzzECEivdaK2jAW6tBVrxs2diaa2U+vF1OJ
	QA18Tgp9iGN0XpmgHy3EZYNf7WWEGK5gHlrLNQM62eq5B2EMpxp3fsK0hJfXoLwmCQv489LMycV
	q+DPAGwoo52ahbDkWwD+/F2FUfo7nX8s2rc//w==
X-Google-Smtp-Source: AGHT+IFyutZBps6Z6yMfgVmMeuzjCUV3vXv7qLL9H8KvjW9DALo4tWDOqs8pfZDycvBssp/aVnfeC9vhx9oy7X4iMDI=
X-Received: by 2002:a05:6402:13cc:b0:64d:1762:9bb2 with SMTP id
 4fb4d7f45d1cf-64d1762a6bfmr22343162a12.11.1766941519566; Sun, 28 Dec 2025
 09:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com> <176687677481.16766.96858908648989415@noble.neil.brown.name>
 <A70E7B41-A5C0-443C-BD16-00E40F145FD2@hammerspace.com> <176690096534.16766.12693781635285919555@noble.neil.brown.name>
In-Reply-To: <176690096534.16766.12693781635285919555@noble.neil.brown.name>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 28 Dec 2025 09:05:07 -0800
X-Gm-Features: AQt7F2rl_NX4bN9SnIzdm18iN3EokydKnoRBdxm8-2k11KgOfKErokYndstpYLA
Message-ID: <CAM5tNy6Xk4KP6NhCYJA-S4HOorYDa3v7JBo7jq7dFpwvfFMOYg@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
To: NeilBrown <neil@brown.name>
Cc: Benjamin Coddington <bcodding@hammerspace.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 9:49=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote=
:
>
> On Sun, 28 Dec 2025, Benjamin Coddington wrote:
> > On 27 Dec 2025, at 18:06, NeilBrown wrote:
> >
> > > On Sun, 28 Dec 2025, Benjamin Coddington wrote:
> > >> In order to harden kNFSD against various filehandle manipulation tec=
hniques
> > >> the following patches implement a method of reversibly encrypting fi=
lehandle
> > >> contents.
> > >>
> > >> Using the kernel's skcipher AES-CBC, filehandles are encrypted by fi=
rstly
> > >> hashing the fileid using the fsid as a salt, then using the hashed f=
ileid as
> > >> the first block to finally hash the fsid.
> > >>
> > >> The first attempts at this used stack-allocated buffers, but I ran i=
nto many
> > >> memory alignment problems on my arm64 machine that sent me back to u=
sing
> > >> GFP_KERNEL allocations (here's to you /include/linux/scatterlist.h:2=
10).  In
> > >> order to avoid constant allocation/freeing, the buffers are allocate=
d once
> > >> for every knfsd thread.  If anyone has suggestions for reducing the =
number
> > >> of buffers required and their memcpy() operations, I am all ears.
> > >>
> > >> Currently the code overloads filehandle's auth_type byte.  This seem=
s
> > >> appropriate for this purpose, but this implementation does not actua=
lly
> > >> reject unencrypted filehandles on an export that is giving out encry=
pted
> > >> ones.  I expect we'll want to tighten this up in a future version.
> > >>
> > >> Comments and critique welcome.
> > >
> > > Can you say more about the threat-model you are trying to address?
> > >
> > > I never pursued this idea (despite adding the auth_type byte to the
> > > filehandle) because I couldn't think of a scenario where it made a
> > > useful difference.
> > >
> > > If an attacker can inject arbitrary RPC packets into the network in a
> > > way that the server will trust them, then it is very likely to be abl=
e
> > > to snoop filehandles and do a similar amount of damage...  though I'm
> > > having trouble remembering that damage that would be?
> >
> > Filehandles are usually pretty easy to reverse engineer.  Once you've s=
een a
> > few, the number of bits you need to manipulate to find new things on th=
e
> > filesystem is pretty small.  That means that (forget about MITM - thoug=
h
> > that is still a real threat) even a trusted client might be able to acc=
ess
> > objects outside the export root on the same filesystem.
>
> So this is only seen to be useful when for sub-directory export?
If this is the case, I'll ask..

If a malicious entity can perform RPCs on the server with faked file
handles, what stops that malicious entity from doing a
LOOKUP ".."/LOOKUPP at the root of the subdirectory mount
to get out of the subtree?

>
> >
> > This problem is further exacerbated when using kNFSD as a DS for a flex=
files
> > setup - the MDS may be performing access checks for objects that the DS=
 does
> > not.  Manipulating filehandles to a DS can circumvent those access chec=
ks.
I'm not sure why a DS is more vulnerable that any other NFSv3 server.
(Either the client can be "trusted" to access the DS or it is not. That's w=
hat
exports do.)

An additional concern I'll mention (not knowing how Linux handles this)
is that file handles (NFSv3 and NFSv4 persistent) are expected to be T-stab=
le,
which implies that the key cannot change for a very long time, including
after a server reboot (or even a server reboot after a software upgrade).

rick

>
> Not being familiar with flexfiles and don't know what that means -
> though I can imagine that pNFS could add extra complications.
>
> >
> > I can absolutely add more information on this for subsequent postings.
>
> That would be helpful - thank.
>
> Next question: why are you encrypting the filehandle?  Is there
> something you want to hide?
>
> Normally encryption is for privacy and a MAC (message authentication
> code) is used for integrity.  Why are you not simply adding a MAC?
>
> With pure encryption you are relying on the fact that changing (or
> synthesising) a filehandle will probably produce a badly formatted
> handle  - except that you are only encrypting the bytes after the fsid.
> So there is less redundancy....  Maybe the generation number is enough
> to ensure decrypted garbage will never be valid - by it doesn't feel
> clean.
>
> If we are using encryption it would be nice to encrypt the whole fh.
> Then you would have a single key for the server rather than
> per-export....
>
> As Chuck suggested: getting review from someone with crypto design
> expertise would be a good thing.
>
> Thanks,
> NeilBrown
>

