Return-Path: <linux-nfs+bounces-17520-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 127BFCFB5F3
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 00:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 389F430006ED
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 23:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7486D317704;
	Tue,  6 Jan 2026 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+H+Amk1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B67313283
	for <linux-nfs@vger.kernel.org>; Tue,  6 Jan 2026 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767743061; cv=none; b=Dzw9OR3ny0PUoMVq9Cc8bcx2xAhgcsp+NdfBh1/WbAGcQ4ZXIb/ZVzie1TIA/Txus9BXAYIuh+KTU6E0xdymFKVzeShP0SCfgQ00HOmjuzokh76Re8SaLXHzYCw2Ju/rH6VbqUTK6fBNBmv+n8W+yVUEgMn0BYjqZm8k6hkxoe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767743061; c=relaxed/simple;
	bh=4oIBw8vquVvkC3JSkAxhLFrQxF7OfwD9hi6LKxFsZzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPrJOUNi/pPbetCEb/DuHgl40E0aR/ia+BbLxVMHChMpszb7SM1mAN3+ba2PvtEs7pe1/4EohhNtEF72Qj1Ecu56vcYo2OyuaNvaKF5HSGk88BFs/GAZsNv01x27Uz5ALJOf3JA19FeU5n1DYVJF2G8glt4mj542VL1qJyts4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+H+Amk1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso2352408a12.2
        for <linux-nfs@vger.kernel.org>; Tue, 06 Jan 2026 15:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767743054; x=1768347854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlV06R+ePSmgAvtLnRpm9eK8uOIviZZ52WXgAw6QoxI=;
        b=T+H+Amk18fVMjKFlCH4dTMYteFxJCYEDxtvJkM85USYpgVQ3xmgSNKb5sY/D7XKkJC
         28XYkT9kHRTJsdr3mp6PsS1ERvw22+exX/3C2YDbFXu1glPjrbiYUD+58a2jqTD2EBKW
         K/z8Nk3tCSRY2OS4GZzyZRsFWA6ML5ag/VwrX4Wi2d3M2zDOdF121Fb6XQ5zW/pfMLBy
         vThUtrpbQUTd4al2Wmz8OlS7q3TCgWc6EZ8nawo2OvUGyi9e3F7qD44Hgmmx8Irtlxh+
         Uzq+15FQ6H7op1k10yIhWIeey9bEFPO+feRKShhI8pQ4lwe9Yw+HIXJOxK7xy8d++VF7
         J+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767743054; x=1768347854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VlV06R+ePSmgAvtLnRpm9eK8uOIviZZ52WXgAw6QoxI=;
        b=eBRatttACLqk2s1UIu+rRVz3NPGw8VNmIiN6WM2pybZOMDAwM4eZt0DGIU2UXrPhp2
         6AHmHVJ2Dvbsp5ayU3N90aLSCfshQgDs2UZzBwTUeKBXj0ndYS48tKndzjjPMG/5+rae
         f0mtr+iWCK0+2YPFTj3HjWaw2F3mT95NCHF0DET7KAg5zIh0n7z62goXQQf4z2bkq9PM
         8TVPxUopjgLBeSoxXeIOahyxwEG2ZNEgJLDYTvUA1SwlYxNVtkwGyEDfKK0apzxLPbyM
         6uSshWYVI0+Pvq+w8a1RpHIp58lecXoUrgFAKOA2jItNt+Z5TSiyklyAfJ77kqZGezEr
         F0KQ==
X-Gm-Message-State: AOJu0YzpgbYtVEXPMivcOChkBMwxA+b9OYMb+9RmWPTAWX5s5rnlmiLJ
	jfqxVICEXyxY9nvqaUsKLVL1aKoMnaqo3/Ks+XBbwYT58PSSgWNNZfWSRGeymNdu14B4SP1O0mJ
	t6cO9ctywpsotYihNKPvp/f6+/pMkMmFSLCE=
X-Gm-Gg: AY/fxX4gtwMKjbNS8MIuA5wlACn/p0eIjjU9MqvfknKsCDVX3H9S+yBh6Rm/gbNipdO
	Cs2+9Pnr8QB7+fSkAwGEnayG3mWqh+Dl6lTTLy9RHviNaj3LfjFkV0TRdicy+EK1Q3YGxPcqSIA
	fPZyB1jWtQbR/mVADOuU1SBg/AlNMlCxPQMCY9HW4Avw7VbHoCKQFiX0LuUzKotQq5vQ6SSC2WV
	sSx1X/I+TX8MMDtDNfV/0Bqm5G+qHRsBRak5nY4guLArQlEXpPWB3yED+/GvFGeHmFxjRHCFLKd
	Kn2J4I2CNhK6++t1qd8jVP186IA=
X-Google-Smtp-Source: AGHT+IFl5qWyEcA5dlE1Dp5y5vyGjF2k3RRy0Y6Pc5a4lLjaWHK57oqTHJWZHBd376OTKezCbds+SSWVvxnT6fHRF5Q=
X-Received: by 2002:a05:6402:42c7:b0:64d:498b:aeec with SMTP id
 4fb4d7f45d1cf-65097df8139mr654186a12.12.1767743054342; Tue, 06 Jan 2026
 15:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4Waqfaqu7kgtnSNrdyR0jBSzJ76tMTbGJPq4HGbBKHiQ@mail.gmail.com>
 <679b3c2a-b70c-4364-a362-fa5eefbf3af3@app.fastmail.com>
In-Reply-To: <679b3c2a-b70c-4364-a362-fa5eefbf3af3@app.fastmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Tue, 6 Jan 2026 15:44:02 -0800
X-Gm-Features: AQt7F2qyPO-AZclRnwenZqVDTO4EKW6sQT7B9GLxn13vxNBDLTYd9btFJOTqsbE
Message-ID: <CAM5tNy5KjQSgRxiOiFHe_3ZCu5v8-ibQ8GfDkscVohLNjgnABA@mail.gmail.com>
Subject: Re: Limit on # of ACEs in a POSIX draft ACL
To: Chuck Lever <cel@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:37=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Tue, Jan 6, 2026, at 11:02 AM, Rick Macklem wrote:
> > Hi,
> >
> > When I did the POSIX draft ACL patches, I mistakenly
> > thought that NFS_MAX_ACL_ENTRIES was a generic
> > limit that the code should follow.
> > Chuck informed me that it is the limit for the NFS_ACL
> > protocol.
> >
> > For the server side, the limit seems to be whatever the
> > server file system can handle, which is detected
> > later when a setting the ACL is done.
> > For encoding, there is the generic limit, which is
> > the maximum size an RPC messages can be (for NFSv4.2).
> >
> > For the client, the limit is more important, since it sets
> > the number of pages to allocate for a large ACL which
> > cannot be encoded inline.
> >
> > So, I think having a sanity limit is needed, at least for
> > the client.
>
> The Linux client does something special with ACL operations:
> the transport/XDR layer allocates the pages as the reply is
> read from the transport. It already does this for both
> NFS_ACL and NFSv4.
>
> I don't think there's anything different needed for this case.
There may be a better way (and I coded this some time ago),
but I needed an array for the page references, so I could free
them.

If you take a look for NFS4_ACL_MAXPAGES in patch #8
for the client stuff, you'll see what I mean.

NFS4_ACL_MAXPAGES is calculated from NFS_ACL_MAX_ENTRIES
and IDMAP_NAMESZ in patch #3.

I don't think the client code "grows" the page array, although you are
correct that it adds pages as required.

Maybe one of the NFS client wizards will have a better way
of doing this?

rick

>
>
> > If there is a sanity limit, I can see having the same
> > one as the NFS_ACL protocol will avoid any possible
> > future confusion where an ACL can be handled by
> > NFSv4.2, but not NFSv3.
> > (The counter argument is NFSv4.2 is the newer
> > protocol and, maybe, shouldn't be limited by the
> > NFSv3 related NFS_ACL protocol.)
> >
> > To be honest, NFS_MAX_ACL_ENTRIES is 1024,
> > which is a pretty generous limit.
> >
> > So, what do others think w.r.t. a sanity limit on
> > the # of ACEs.
> >
> > Thanks in advance for any comments, rick
> > ps: When wearing my internet draft author hat, I
> >       lean to "no limit in the draft", since that is what
> >       the RFCs do w.r.t. NFSv4 ACLs, but that doesn't
> >       mean implementations will handle any number
> >       of them. Maybe I'll add a sentence to the draft
> >       noting that the limit of # of ACEs is server file
> >       system dependent?
>
> IMHO generally speaking, implementation guidance is reasonable
> to put in an Internet standard, especially if it directs
> implementers to address a subtle security issue such as a
> denial of service.
>
> Something like "Client implementations should be prepared to
> handle ACLs with many ACEs and large 'who' fields."
>
>
> --
> Chuck Lever

