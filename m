Return-Path: <linux-nfs+bounces-7342-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E64C9A9365
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 00:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20351283E50
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 22:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FBD1E130F;
	Mon, 21 Oct 2024 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG6MpL1l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D51C9ECE
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550051; cv=none; b=c9obYZ0vqZIrsyu3disiYK2VbL4KVLCcxfivfR3AAw/x0TuTidD/tdLbgx0SuJxMq43t5icSdUnHsMAmZbd+505WA3BaeBLaJt0t8sZjE1CEP28+GWwNUlWDgwoTdRCnTUSULnTc7SQaGjZUL0gSGG1p6G9GgmHgbiT8QUi8lFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550051; c=relaxed/simple;
	bh=qi+pzw2TDyMJ8ivsL7OOqxlKgcv/jh1dQLtMzj3mcgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqAdCwXoyIefxPVv3OPNJWDqvMObf3y2Otbr2P4NlE2Ce3TQBNydDg2QcOQAMzDneeLnrCCb6SYqkXjkFoLwU3O7CosyhIN8ENhx3pv6r7KMK2Nq+aZKC4TiY9EAwNhfROObtIspKFp1jDjmFjdLfyR+VChT5PY1fK0LbJhEBsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG6MpL1l; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so6443098a12.2
        for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729550048; x=1730154848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7DzMa04FFNU3NmOhaXFkAaFinnGnaZWtr2dCgCU/5M=;
        b=JG6MpL1lRqKop6lULHrCBwC5HEs1W269j9+8N+/PPhbtQ9JWYjyIp05G3caHhmNwLw
         PQHWaZqBnHSDO/XRyv1hIp25zoaXKsSWXewDZRNWPv+KADtlCwREIbE6/x5yLzUAyoxL
         vBt9Be65Ub293Y9Hl/3SJRyV3DC1ii0HNiUxVZMMxyaZmbX066qXCyTc05H9jYR13wvo
         e8w8rcZP6rHuH4QQT2itdSYjKkmjqe+wsF5V9P+hDYhxonGd2Hlx6mH3Jc5ksKlOST8I
         wIk3hb6kSt9tGZgKn8e1n3V/LhTpt1WCot0MPvpkyMIZ8ZoL6bQ3Tj+rrmTUilq5LJHl
         HG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729550048; x=1730154848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7DzMa04FFNU3NmOhaXFkAaFinnGnaZWtr2dCgCU/5M=;
        b=gv72id2lCjkjKcBDBANQZBkNU4RSvTu+WYvqN38Vu6HduKUkbKzOqloo4wS4KVGZ5M
         sc3y0maaSMepS6coOXJH0IrmbRspo+xQGsbrCFRm4XLvUlr/CaFD9zEVfmnXH+L9HBEi
         sewG3eCSXlhFIyAxbdBnIiAMr9BKl6HpU1YrEInIkCa6DqF/Otgr7hVH6Zv2lkxoO5rW
         bAE/tSCbb0mtVssm5cvEfkuDIGLibXMywDEH0L0vNT0JFKjnQJZGPyZQuUz+/X4TwUCF
         cXKD9TzduGzqKH/4RdK6N2WX5sZ/YvWvCfHVKsFyW/jAOnRpdUcE5gcTs3+wNb8I6J6S
         C+fg==
X-Gm-Message-State: AOJu0YyucwOHQozriB2ZkvUmiFt8pBSiKQiEu1zIC7EyqWlTNqzdRiG/
	SfsVVXx8IEuxjv6779ANgnJna8XVPC2WXr6hjIMESOdTVfQCRdqTsiGCwrKpdCES3d3OXI65up/
	3ekne4NvecBlfEN7wd3l0kjLCOQ==
X-Google-Smtp-Source: AGHT+IGjTaRpY3fSxVz3iB2gYi74xeW3jfwm2wSEamnjE0HAdB47bAeGdDU+ZHXXDM6ZOUhqRi7KbdelBfAZ4X+CKg4=
X-Received: by 2002:a05:6402:4582:b0:5cb:6b2c:c175 with SMTP id
 4fb4d7f45d1cf-5cb7fcf72cemr349259a12.16.1729550048146; Mon, 21 Oct 2024
 15:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy4S0O28CcDGV43BWXegSZSPVEYgFKpaLxLSNSgjti_L5Q@mail.gmail.com>
 <0A2D2441-712D-4EE5-BFDB-E77108BB1A1F@oracle.com>
In-Reply-To: <0A2D2441-712D-4EE5-BFDB-E77108BB1A1F@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 21 Oct 2024 15:33:59 -0700
Message-ID: <CAM5tNy4jsSeAWQX43K9+6n=byvuGJF0o4enySTmdY-j=Y8BvvQ@mail.gmail.com>
Subject: Re: RFC: Dealing with large POSIX draft ACLs for NFSv4.2
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 7:45=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Oct 20, 2024, at 7:09=E2=80=AFPM, Rick Macklem <rick.macklem@gmail.c=
om> wrote:
> >
> > Hi,
> >
> > As some of you will already know, I have been working on patches
> > that add support for POSIX draft ACLs to NFSv4.2.
> > The internet draft can be found here, if you are interested.
> > https://datatracker.ietf.org/doc/draft-rmacklem-nfsv4-posix-acls/
> >
> > The patches now basically work, but handling of large POSIX
> > draft ACLs for the server side is not done yet.
> >
> > A POSIX draft ACL can have 1024 aces and since a "who" field
> > can be 128 bytes, a POSIX draft ACL can end up being about 140Kbytes
> > of XDR. Do both the default and access ACLs for a directory and it
> > could be 280Kbytes. (Of course, they usually end up much smaller.)
> >
> > For the client side, to handle large ACLs for SETATTR (which never
> > sets other attributes in the same SETATTR), I came up with some
> > simple functions (called nfs_xdr_putpage_bytes(), nfs_xdr_putpage_word(=
)
> > and nfs_xdr_putpage_cleanup() in the current client.patch) which
> > fill the large ACL into pages. Then xdr_write_pages() is called to
> > put them in the xdr stream.
> > --> Whether this is the right approach is a good question, but at
> >      least it seems to work.
> >
> > For the server, the problem is more difficult, since a GETATTR reply
> > might include encodings of other attributes. (At this time, the propose=
d
> > POSIX draft ACL attributes are at the end, since they have the highest
> > attribute #s, but that will not last long.)
> >
> > The same technique as for the client could be used, but only if there
> > are no attributes that come after the POSIX draft ACL ones in the XDR
> > for GETATTR's reply.
> >
> > This brings me to one question...
> > - What do others think w.r.t. restricting the POSIX draft ACLs to only
> >  GETATTR (and not a READDIR reply) and only with a limited set
> >  of other attributes, which will all be lower #s, so they come before
> >  POSIX draft ACL ones?
> >  --> Since it is only a personal draft at this time, this requirement
> >        could easily be added and may make sense to limit the size
> >         of most GETATTRs.
> > This restriction should be ok for both the LInux and FreeBSD clients,
> > since they only ask for acl attributes when a getfacl(1) command is
> > done and do not need a lot of other attributes for the GETATTR.
>
> Generally, I don't immediately see why POSIX ACLs need a restriction
> that the protocol doesn't already have for NFSv4 ACLs.
>
>
> > Alternately, there needs to be a way to build 280Kbytes or more
> > of XDR for an arbitrary GETATTR/READDIR reply.
>
> IIUC, NFSD already handles this for both READDIR and NFSv4 ACLs
> (and perhaps also GETXATTR / LISTXATTR).
>
> So I'll have to have a look at your specific implementation,
> maybe sometime this week. I can't think of a reason that our
> current XDR and NFSD implementation wouldn't handle this, but
> haven't thought deeply about it.
>
> It might not be efficient for large ACLs, but does it need
> to be?
Nope, it doesn't need to be...
Well, this in embarrassing (blush!).
It turns out it works fine for GETATTR of a large ACL (either the
acl attribute or the new ones added by the patch).

For the client side, I could have sworn I needed to do the
"fill in the page stuff" to get the large one to work for SETATTR,
but for the knfsd, it figures it out.

Btw, I was only able to get to about 60K, because the ext4 fs
I have on the server wouldn't allow an ACL with 1000 entries to
be set (replied with out of space on device).
--> I did get one with 455 entries to work and most of those entries
      were for 110 byte group names.

So, what can I say, except I should have tried it before I posted.
(One gotcha is that FreeBSD only handles 32 ACE ACLs, but
when you look at the packet trace, you can see they are all in
the GETATTR reply. Not an excuse, but...)

Thanks for the reply Chuck, rick

>
>
> > Btw, I have not tested to see what happens if a large POSIX draft
> > ACL is set for a file (locally on the server, for example) and then
> > a client does a GETATTR of the acl attribute (which replies with
> > a NFSv4 ACL created by mapping from the POSIX draft ACL).
> > --> I have a hunch it will fail, but I need to test to be sure?
> >
> > Thanks in advance for any comments w.r.t. this issue, rick
> > ps; In particular, I'd like to know what others think about adding
> >      the restriction on acquisition of the POSIX draft ACLs by GETATTR.
>
>
>
>
> --
> Chuck Lever
>
>

