Return-Path: <linux-nfs+bounces-11900-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7E1AC37CF
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 03:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E531890733
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 01:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E257F7260E;
	Mon, 26 May 2025 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmUxhgdA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9C3594B
	for <linux-nfs@vger.kernel.org>; Mon, 26 May 2025 01:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748224077; cv=none; b=PJL9jxZXUifKnNSvoxAbxMESyEzL0teZ2ggha/asarglifi6Hn1OCwSo6J54lVF+nPpLrsJ44kYPiyjw7N0reHudFKtkvwKZDIhshWiK/MpesOKR8Xx+VAyjtxnjb1CXkbZJrtEqGEUQ39YJg9Z2JktlwzvGR+ocCbO43OS69/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748224077; c=relaxed/simple;
	bh=+pBNSX97zUvuUBbDMai9IgfoWtflPHP9VZ6OMG92yuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lx2RJ+WeLrcwgfufmx6Y4hipc0C7+EhIp0nsajZ/aAzhBoSNICyo/7ulUeOLuYsVtgfWRveQvFFtJEPpApjh5vmXvl5eZAn95vnlpozorzQSxK1LS3yMrpAkEH3MgvkXvX/o/A11yd/GgFo6EiBmu3yaQnSlCd5EGErxnj2XuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmUxhgdA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6045b95d1feso2187495a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 25 May 2025 18:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748224074; x=1748828874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJtqG+zxOm58izKgO3GrlOqANJRWvKyyVn9R0oYl4Sw=;
        b=kmUxhgdAcBkLoZHJhF40y/2+A6qNhA/6iok/mLEOGjooam0YbVf1qIOPybYyB72CtM
         2IqGcSajpqjIFiAg8AuMVoEINfRYxOiyYljbDHHGaVJfj1B6kUUnjKlh+c1IVXLcWHH1
         HP9UoS9CbXo27bd6oF5KnGqppgUOvvwmiFImUaHBsnTlb4FhWNtLR1XFB2uY2Yn4dMO7
         QB71SSY2oNZG00zAALy5dQlttkk5Hs+ual0+HrTUo5wlO9xSFsqBuY6RPSish4P+EdiJ
         gNXCvFjJpK9IBj7AY0dylqVwegOPHKVKYpAe88z1kB7mnGt48OTB73I81Sr+3BNmLKpR
         PRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748224074; x=1748828874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJtqG+zxOm58izKgO3GrlOqANJRWvKyyVn9R0oYl4Sw=;
        b=eB589rWhfdsF7aFTKKQ9ch1kNOYtVl2/MoHlyUdLW8J/ebeU2yyOd3SEabIEQUZqgq
         lZPv4hKQVdYWfcGkG8XfVwMrEQReMcxQd2ifYaPx2LTrfh5ATPKo1hWlRBLUt5hBIPcp
         IJg1SvoZbbkQrV9DlzGwZ7+XOmWmsf7lYflukfOMCyUksKEgiRT1vncv/pDLk5PG5AXD
         WcPnYaLZwcNzwWbaBNc1G29l9F96YNB9vSfKZHOBuBoFQtBo2r2ndNC1zv2znreDgjTZ
         6BS74LHoffu0Nc48vEYUOhIMlTBDf/JG56fpBHnB7e9IM519fwX2xoNhazoXEbESJpjX
         6gvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV42h5y0IP6LLNvKl9o6DdDy6lZfRa2KgIhh5VnS9vsEn4Nmf9eRcAmUtHCFsxLY0GX0y6yJL13F2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbcCwkiRXNjIxMs2HqbSDcyFqUOONOHy/jkWQk5gaPEqaniaK0
	hLW/rDcbWO3Fzc8Xv4ggd9qm3qZxB0ZwLzLB3r3RGv7PHfv70XmymK8YTAg4RH5ZYhNLZ48OIhl
	2543QU7CUlGxgPMR04ZDkSJ736bw6Dw==
X-Gm-Gg: ASbGnctBzXJXKUj7f4+icYpCrVmJ2SoMK44kJtVjhRwfGHqc75VJE4tJ5kvZaiDkxN2
	7ve9gxbSYKfpuKpVkKiH1XyFH3MjFrCHJrlHu2n9+VJlJT0jw7A+BpSFS2OqE+CNX6N0XoDMUtg
	A8ekmaPsTLPbsdZYJ5jUgHMAne4OzwpWfhsIddEQJdxOWNZlA3TeRbqRP+zOPLTFo=
X-Google-Smtp-Source: AGHT+IFTJb9UucygiMFo98kwY/6a2Ls3LCF9blDRlyQCxxRoN2efd3zsyoXDijkacYhtC1UD+2Ce7HOrl8yZjHj3Z18=
X-Received: by 2002:a05:6402:1d4a:b0:604:5cae:4031 with SMTP id
 4fb4d7f45d1cf-6045cae45c9mr4007418a12.28.1748224074077; Sun, 25 May 2025
 18:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d539c502-e776-460f-852c-8af9722ad9f8@oracle.com> <174821817646.608730.16435329287198176319@noble.neil.brown.name>
In-Reply-To: <174821817646.608730.16435329287198176319@noble.neil.brown.name>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 25 May 2025 18:47:42 -0700
X-Gm-Features: AX0GCFtRzWMqSG5v597BSbobk3quWIvna-YevmWg-cvSkOY2dMHCOI6Wcy7QIcs
Message-ID: <CAM5tNy6ZJwSV9tmsyPHDjp3rLVFw6=dhs3ojxORqLNNnurGtFQ@mail.gmail.com>
Subject: Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 5:09=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
>
> On Mon, 26 May 2025, Chuck Lever wrote:
> > On 5/20/25 9:20 AM, Chuck Lever wrote:
> > > Hiya Rick -
> > >
> > > On 5/19/25 9:44 PM, Rick Macklem wrote:
> > >
> > >> Do you also have some configurable settings for if/how the DNS
> > >> field in the client's X.509 cert is checked?
> > >> The range is, imho:
> > >> - Don't check it at all, so the client can have any IP/DNS name (a m=
obile
> > >>   device). The least secure, but still pretty good, since the ert. v=
erified.
> > >> - DNS matches a wildcard like *.umich.edu for the reverse DNS name f=
or
> > >>    the client's IP host address.
> > >> - DNS matches exactly what reverse DNS gets for the client's IP host=
 address.
> > >
> > > I've been told repeatedly that certificate verification must not depe=
nd
> > > on DNS because DNS can be easily spoofed. To date, the Linux
> > > implementation of RPC-with-TLS depends on having the peer's IP addres=
s
> > > in the certificate's SAN.
> > >
> > > I recognize that tlshd will need to bend a little for clients that us=
e
> > > a dynamically allocated IP address, but I haven't looked into it yet.
> > > Perhaps client certificates do not need to contain their peer IP
> > > address, but server certificates do, in order to enable mounting by I=
P
> > > instead of by hostname.
> > >
> > >
> > >> Wildcards are discouraged by some RFC, but are still supported by Op=
enSSL.
> > >
> > > I would prefer that we follow the guidance of RFCs where possible,
> > > rather than a particular implementation that might have historical
> > > reasons to permit a lack of security.
> >
> > Let me follow up on this.
> >
> > We have an open issue against tlshd that has suggested that, rather
> > than looking at DNS query results, the NFS server should authorize
> > access by looking at the client certificate's CN. The server's
> > administrator should be able to specify a list of one or more CN
> > wildcards that can be used to authorize access, much in the same way
> > that NFSD currently uses netgroups and hostnames per export.
> >
> > So, after validating the client's CA trust chain, an NFS server can
> > match the client certificate's CN against its list of authorized CNs,
> > and if the client's CN fails to match, fail the handshake (or whatever
> > we need to do).
> >
> > I favor this approach over using DNS labels, which are often
> > untrustworthy, and IP addresses, which can be dynamically reassigned.
> >
> > What do you think?
>
> I completely agree with this.  IP address and DNS identity of the client
> is irrelevant when mTLS is used.  What matters is whether the client has
> authority to act as one of the the names given when the filesystem was
> exported (e.g. in /etc/exports).  His is exacly what you said.
Well, what happens when someone naughty copies the cert. to a different
system?
--> It is true that verification will show that the cert. is valid, but is =
it
      valid for that client system?
     (Not checking the reverse DNS name makes the check somewhat weaker,
       imho. Now, is having the IP address in the cert. and checking
that stronger.
       Well, maybe. The hassle is that the certs. all have to be replaced w=
hen
       some network type decides to reconfigure the LANs or move the system
       onto a different subnet for some reason.)

Another way a cert. can be protected from being moved to a different client
by someone naughty is adding a passphrase to it (the -aes256 option on
the openssl command line when creating the CSR). The hassle is that
someone has to type the passphrase in when the system is started/rebooted.

There is no perfect solution (or security is not a binary value, if
you prefer), so
I chose to provide as many options as I could, so that sysadmins could choo=
se
what works for them. (Of course, they need to understand what is going on a=
nd
documenting that can be a challenge.)

rick

>
> Ideally it would be more than just the CN.  We want to know both the
> domain in which the peer has authority (e.g.  example.com) and the type
> of authority (e.g.  serve-web-pages or proxy-file-access or
> act-as-neilb).
> I don't know internal details of certificates so I don't know if there
> is some other field that can say "This peer is authorised to proxy file
> access requests for all users in the given domain" or if we need a hack
> like exporting to nfs-client.example.com.
>
> But if the admin has full control of what names to export to, it is
> possible that the distinction doesn't matter.  I wouldn't want the
> certificate used to authenticate my web server to have authority to
> access all files on my NFS server just because the same domain name
> applies to both.
>
> Thanks,
> NeilBrown

