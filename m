Return-Path: <linux-nfs+bounces-17585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979FDD00730
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 01:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C1A83025A6B
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 00:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4B39FD9;
	Thu,  8 Jan 2026 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx2UDBfv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ACA381AF
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 00:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767831414; cv=none; b=RYq3j399Gtt3iJ6fKCkJMnIWXvB0XWe0xPB4NBQREmu1IChoNrL9EFtmnK+kVCPg3AbgH1wiit+ol0Hr9PNKl1N+1j65S2u2fiE5AvChHTClJ5zCEwFfIUI7rTtYGZ9VOexzUJ/68+i+R2sHi5S5X7eQZhZk6IxIbFYoejgoRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767831414; c=relaxed/simple;
	bh=3qxbasS8DY70I0NI3AblZNS3DrQd5n9f2vgwSVqbHkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cm/faHvs39JKLFhPSDxw0N+295O/IWBQFmfYAPwU8e8gCmtF3JnkiDDh1FvRIhIvBGVIjv99+tCYoe+IWBRKoCy/YcEntzrQhIRdGs/NqZiosAzxkSPSTrbNmDSSsWzDTVG4zSHkp+tt/2HuNEZO1B1k47iv03RV87lETLFPHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx2UDBfv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6505cbe47d8so4220206a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 07 Jan 2026 16:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767831410; x=1768436210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbhFepmRR2JctJHjcUJVWdcNGhKu44Rxd57LmjTKtxs=;
        b=Kx2UDBfvl9V7Wf6iv5FlJpHn3HvGQ38rm4T/pgdMWVG3lFGXalgBshcWcTJYyexmgZ
         SQOTmvVYmwG0KAe9NNobMvZcwipvvB9AzB0x/4QxYFPmPrG4rI0FCLwFClg0Tzx5nVKm
         3EoBBXjOqeT6Z57bmx1yq1mRs2Sv65YrBKl1UMv74SFhopa0qn12JuV5n2UVpEM0ENTH
         mr7xMB/ng5mslFwwP729ttEjCe8gIdOaZjATB0jqjnhHkDCNxUAd6+OlFd0c+3Vcpf33
         Hn9DKk1XoRRe5jvHZ3sbLjyh7twDemdGJ6kyuzCAgUUhDtwBaUeOfY9o1FOg8wtI9LMx
         n1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767831410; x=1768436210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbhFepmRR2JctJHjcUJVWdcNGhKu44Rxd57LmjTKtxs=;
        b=GZnb+skHrZ8P1il6DW5Hsy+5drLinCCRQXx+cg4tYQcHi/gjxkuP0zUVyyJulsIC1/
         iF75TNimPmPBOnZBrllW46utF1mrD/fX9gHQC0mMCX0j1pRuzg2aNx1vwA6i3bNTlN3r
         ST1FTbM+C5vp15AFCXO7iRGqOL9hWdrqorFVDriHwqLS8/ZYUwFvTvRrGxkVImHR5BHP
         Fb1A/fn+7jt/XYi0SohOmmHWedCnTTqrWAuoPCZpEVNtDRdGUJWLS5ZIWln5uDmLTdID
         6rX6J1ltOG00g0P8K45sw0zTTXz12kCmHlfZY1u6oE3yqhfbeNneAyw92CUN+8XUSv0R
         q7tg==
X-Gm-Message-State: AOJu0YwWPtete9RYR6x5RDCgvSTHgmXJhEpWkO/17t2iozwZPQgAIoNP
	h/4QfoVHjgAL5CKuwKuwh2q7bVIj3eTY+lvzypUM1EztgIs2YsFMIvmvcTQ/9DIsM51hI2sL15t
	n1/E0xHHzxCRrazaQVldn2HsVrOOiPw==
X-Gm-Gg: AY/fxX7b2Yo8+ReRxsXdhiL9Swe2CYnMs9WGFVtwsv8aiAGpw9fSihjYfrrot2Kfjz1
	3TLCK3eq15zyUDFR/OKoQ1tfQAqizoryEXvGPoe1H6ToI6EL9lXZ1ienvAkNFa5a9k2s39Axo79
	rAjHITEN9ti+yUH5XXePN+m3eNdde/KLL5k1pajYqbyTcco+6e2VsVdZt63swtM+YHu9rtD0ug2
	PpNTUUqiTIA1aH8YaRDikNCINbqx/vZCLLsTIYTEmTpZVgPuMH7eJYAxZo1EdqU2cyugIlukvsi
	Og23Bz5Q8U+qsZCwNyrED57uqqMe
X-Google-Smtp-Source: AGHT+IHHY2k5OwwUypLSKM2fBU3vrsLhXY6JCf0ZXtmZ4LUEpvIE3caWBIUIlhemRz955PyFvBGjDt1JbQYByyE+fCQ=
X-Received: by 2002:a17:907:fd15:b0:b73:8cea:62bb with SMTP id
 a640c23a62f3a-b844532bb1amr441579366b.31.1767831409541; Wed, 07 Jan 2026
 16:16:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4Waqfaqu7kgtnSNrdyR0jBSzJ76tMTbGJPq4HGbBKHiQ@mail.gmail.com>
 <679b3c2a-b70c-4364-a362-fa5eefbf3af3@app.fastmail.com> <CAM5tNy5KjQSgRxiOiFHe_3ZCu5v8-ibQ8GfDkscVohLNjgnABA@mail.gmail.com>
 <31d5bce8-c4df-42e1-a1a7-37c5b9fc8078@app.fastmail.com>
In-Reply-To: <31d5bce8-c4df-42e1-a1a7-37c5b9fc8078@app.fastmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Wed, 7 Jan 2026 16:16:37 -0800
X-Gm-Features: AQt7F2og6M96iNYaB1ZPiOCa9cenY76xjFizP1F8-BfY81faXBbHcxgU2jDFtYo
Message-ID: <CAM5tNy7s_2wKt=MX+M3xu54MtPjir7Un4VSrvbt+hnetCcRpyg@mail.gmail.com>
Subject: Re: Limit on # of ACEs in a POSIX draft ACL
To: Chuck Lever <cel@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:14=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Tue, Jan 6, 2026, at 6:44 PM, Rick Macklem wrote:
> > On Tue, Jan 6, 2026 at 8:37=E2=80=AFAM Chuck Lever <cel@kernel.org> wro=
te:
> >>
> >>
> >>
> >> On Tue, Jan 6, 2026, at 11:02 AM, Rick Macklem wrote:
> >> > Hi,
> >> >
> >> > When I did the POSIX draft ACL patches, I mistakenly
> >> > thought that NFS_MAX_ACL_ENTRIES was a generic
> >> > limit that the code should follow.
> >> > Chuck informed me that it is the limit for the NFS_ACL
> >> > protocol.
> >> >
> >> > For the server side, the limit seems to be whatever the
> >> > server file system can handle, which is detected
> >> > later when a setting the ACL is done.
> >> > For encoding, there is the generic limit, which is
> >> > the maximum size an RPC messages can be (for NFSv4.2).
> >> >
> >> > For the client, the limit is more important, since it sets
> >> > the number of pages to allocate for a large ACL which
> >> > cannot be encoded inline.
> >> >
> >> > So, I think having a sanity limit is needed, at least for
> >> > the client.
> >>
> >> The Linux client does something special with ACL operations:
> >> the transport/XDR layer allocates the pages as the reply is
> >> read from the transport. It already does this for both
> >> NFS_ACL and NFSv4.
> >>
> >> I don't think there's anything different needed for this case.
> > There may be a better way (and I coded this some time ago),
> > but I needed an array for the page references, so I could free
> > them.
>
> Again, that problem should already be solved in the current
> code, although it's possible I'm missing your point.
>
>
> > If you take a look for NFS4_ACL_MAXPAGES in patch #8
> > for the client stuff, you'll see what I mean.
There is a declaration that looks like (this is in the client patch):
   struct page *pages[NFS4_ACL_MAXPAGES] =3D { };

NFS4_ACL_MAXPAGES is calculated as follows:
#define NFS4_ACL_MAXPAGES (((2*(3*4+IDMAP_NAMESZ)*  \
       NFS_ACL_MAX_ENTRIES))+PAGE_SIZE-1)>>PAGE_SHIFT
- I used NFS_ACL_MAX_ENTRIES. It can be another constant,
  but there does need to be a constant that is a limit for # of ACEs
  and 1024 seems to be a reasonable limit?

Yes, if you put in the effort, you could declare is as:
     struct page **pages;
and then do some sort of calloc() like thing to keep re-allocating
it a larger size, as required. (I do not think there is anywhere
else in the client code that does this dynamically?)

rick


> >
> > NFS4_ACL_MAXPAGES is calculated from NFS_ACL_MAX_ENTRIES
> > and IDMAP_NAMESZ in patch #3.
>
> NFS_ACL_MAX_ENTRIES is an NFS_ACL protocol constant, it's not
> related to any sort of implementation limit. So it is, IMHO,
> not appropriate to apply to either NFSv4 ACLs or NFSv4.2 POSIX
> draft ACLs. That's just me with my architect's hat on.
>
> The thing that is new about NFSv4 is that NFS_ACL ACEs are fixed
> in size because they encode "who" identities as UID/GID numbers.
> In NFSv4, "who" identities are variable-length strings. It's
> really quite impossible for receivers to guess how large these
> things are before they land in memory. (It might be better for
> the NFS layers to treat ACLs like directories, whose XDR
> representation has similar characteristics).
>
> As you pointed out, the file systems where the ACLs are stored
> are going to hit their storage limits far sooner than the wire
> protocol will become a bottleneck. We just don't have any good
> ways for the NFS layers to bound and sanity check incoming ACL
> streams though.
>
>
> --
> Chuck Lever

