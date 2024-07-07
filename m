Return-Path: <linux-nfs+bounces-4696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC9929966
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 21:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75DA1F210FC
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505ED44C89;
	Sun,  7 Jul 2024 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldtWIgZh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6E2E85E
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jul 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720379156; cv=none; b=vFi8Vdkd547KEpnECiKKusbu3DKfJF3sOISo+qt1Q/WC6JFf8agFma6AtDTD/wWmvhmxeIQCt73rLC2h3A56o/4QKnUO5+F/MNpF1gftSB4qMO8L1yrrtDQLmYZTSjmcYCLbxyNTeLK/Gqsg7gZ8LPlWPDjHHjufS762mbOW+lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720379156; c=relaxed/simple;
	bh=zHVdhuiJhf9GRlGIGY+ExT8wOFrj66KlPTCE/udH7fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqM3ltBobqI94hZFau9UNG1IZhFLBUx2yDLylouSfNvd0HuM749w/+lvwr9CZiPhZbZ2sN7DICwp9o1LF0J2s5S9mvAF2GzaCjwrINzhrh0FEIqD1e6nJ0Z1rPde3YZB5eZDNceqPu7AP2eBabZayHilBEFy67nfDB9/QoDH4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldtWIgZh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-706524adf91so2585201b3a.2
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jul 2024 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720379154; x=1720983954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3QPJ8treiIUBZ37PU3CkfqQrJpqDb6HQyQwVbKVrXXc=;
        b=ldtWIgZhSbHs93dhkFEAMGOzennOHGzZilm0pEkpbDKgU0TFLVC+tQeFdMcO9Vc9gG
         AyQr9PlJiOt+5E+RBOGnW74Xdi0hkxjGTC9LA5m+rRfR7ZsyZEzwgbb27y1pFl7FxPwr
         ANajLAg6/G+M9hEA/ZM0maWlr4lLrhGjBb30PdQeErdlgnfOHBYl0ax/yaAyiqA35HwU
         UkvBm9YYz8Cm28LHMq/Y9W8ShJ7dNCNGGASUVVIVuvLR3Jv+hk5SNYQZcowpwrCINaQD
         rasretN7iMZXZmEmwRUUTTGUvnNYLSDh+Ca8ohXSpBmbhbj+dRzGvsb2VAaXN0/HuJOH
         bgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720379154; x=1720983954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QPJ8treiIUBZ37PU3CkfqQrJpqDb6HQyQwVbKVrXXc=;
        b=UH6tdOC6Jdoj03sO/atd8A8ZRoveXV3OlOi4FZ16L1aZCGwGXgRX7py4+uZH1WWuC7
         5bD9gPGLhMdZr6VIRr9Dx2L8EJrO7FHewqU+pJjxENYbM9GlnNR7B0/dB9GK93lzgaQP
         oeO24xfIMGD/Bx9QomNY8iVt1CaZeVufLPeMnkGThfNDSALRvCy+KNjVY/IJkWNR9EPt
         fX9sTqL//80q58+bwf8qpCp5YUxWs2t5hUhpO2e72B54Ub6z/P0w7vpPNgrYzGLye2Ml
         Alb3CH49TAuPreoddKPL58cbYPZGtO8QKJe1BqupboPnUH9nKkNaVgxxqOh/Ikr4LQkU
         6yeA==
X-Forwarded-Encrypted: i=1; AJvYcCVdg/MzA3p7/ZFgZBCv0Fu95rYWyzcd1dU5QsiQNcZLzCQI0Yh+WwtdZ7tDSlv8TABwl9DvyfHOxtcUt2D8lPbpPQ+S88MdO50d
X-Gm-Message-State: AOJu0Yx0pcMAExpCoDernZPjIRmOg28CkCI7k543t7H0OMnraoJx3H8Q
	vsdPW1bNpA/RsGoeOAfZBdI8h9yPy/R6EO6sKrrGy0bh+d2iHzSva93f+9HpC20gW7h12A9d99y
	tBulB4dkMTWQxi6xx9SYi68jkhprmuIo=
X-Google-Smtp-Source: AGHT+IHznxUFidbKHA9d6otajfnt89C98hKFhqXJMkyylGK3zi6cDQBYaXtCGgdJJNgcpYQaMqJfgvTS+S8OOapP9oI=
X-Received: by 2002:a05:6a20:734e:b0:1be:b30d:3b37 with SMTP id
 adf61e73a8af0-1c0cc74e919mr13809596637.36.1720379153790; Sun, 07 Jul 2024
 12:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706224207.927978-1-sagi@grimberg.me> <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
In-Reply-To: <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 7 Jul 2024 12:05:43 -0700
Message-ID: <CAM5tNy5WLTk6KbVwe4J8+0=ChhGQgXnK_Matt2Y1j_8W-0KR9g@mail.gmail.com>
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Jeff Layton <jlayton@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000057550a061cacfc84"

--00000000000057550a061cacfc84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 4:07=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2024-07-07 at 01:42 +0300, Sagi Grimberg wrote:
> > Many applications open files with O_WRONLY, fully intending to write
> > into the opened file. There is no reason why these applications should
> > not enjoy a write delegation handed to them.
> >
> > Cc: Dai Ngo <dai.ngo@oracle.com>
> > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > ---
> > Note: I couldn't find any reason to why the initial implementation chos=
e
> > to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it seeme=
d
> > like an oversight to me. So I figured why not just send it out and see =
who
> > objects...
> >
> >  fs/nfsd/nfs4state.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index a20c2c9d7d45..69d576b19eb6 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *open, st=
ruct nfs4_ol_stateid *stp,
> >        *  "An OPEN_DELEGATE_WRITE delegation allows the client to handl=
e,
> >        *   on its own, all opens."
> >        *
> > -      * Furthermore the client can use a write delegation for most REA=
D
> > -      * operations as well, so we require a O_RDWR file here.
> > -      *
> > -      * Offer a write delegation in the case of a BOTH open, and ensur=
e
> > -      * we get the O_RDWR descriptor.
> > +      * Offer a write delegation in the case of a BOTH open (ensure
> > +      * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY descripto=
r).
> >        */
> >       if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_=
SHARE_ACCESS_BOTH) {
> >               nf =3D find_rw_file(fp);
> >               dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> > +     } else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> > +             nf =3D find_writeable_file(fp);
> > +             dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> >       }
> >
> >       /*
>
>
> I *think* the main reason we limited this before is because a write
> delegation is really a read/write delegation. There is no such thing as
> a write-only delegation.
>
> Suppose the user is prevented from doing reads against the inode (by
> permission bits or ACLs). The server gives out a WRITE delegation on a
> O_WRONLY open. Will the client allow cached opens for read regardless
> of the server's permissions? Or, does it know to check vs. the server
> if the client tries to do an open for read in this situation?
I was curious and tried a simple test yesterday, using the FreeBSD server
configured to issue a write delegation for a write-only open.
The test simply opened write-only first and then read-only, for a file
with mode 222. It worked as expected for both the Linux and FreeBSD
clients (ie. returned a failure for the read-only open).
I've attached the packet capture for the Linux client, in case you are
interested.

I do believe this is allowed by the RFCs. In fact I think the RFCs
allow a server
to issue a write delegation for a read open (not that I am convinced that i=
s a
good idea). The main thing to check is what the ACE in the write delegation
reply looks like, since my understanding is that the client is expected to =
do
an Access unless the ACE allows access.
Here's a little snippet:
    nfsace4   permissions; /* Defines users who don't
                              need an ACCESS call as
                              part of a delegated
                              open. */

Now, is it a good idea to do this?
Well, my opinion (as the outsider;-) is that the server should follow whate=
ver
the client requests, as far as practicable. ie. The OPEN_WANT flags:
   const OPEN4_SHARE_ACCESS_WANT_NO_PREFERENCE     =3D 0x0000;
   const OPEN4_SHARE_ACCESS_WANT_READ_DELEG        =3D 0x0100;
   const OPEN4_SHARE_ACCESS_WANT_WRITE_DELEG       =3D 0x0200;
   const OPEN4_SHARE_ACCESS_WANT_ANY_DELEG         =3D 0x0300;
   const OPEN4_SHARE_ACCESS_WANT_NO_DELEG          =3D 0x0400;
If the client does not provide these (4.0 or 4.1/4.2, but no flags), then I
suppose I might be concerned that there is a buggy client out there that
would do what Jeff suggested (ie. assume it can open the file for reading
after getting a write delegation).
Ideally there would be testing with as many clients as possible (at a
bakeathon?).

rick
>
> --
> Jeff Layton <jlayton@kernel.org>
>

--00000000000057550a061cacfc84
Content-Type: application/octet-stream; name="xxx.pcap"
Content-Disposition: attachment; filename="xxx.pcap"
Content-Transfer-Encoding: base64
Content-ID: <f_lybx8t0k0>
X-Attachment-Id: f_lybx8t0k0

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
--00000000000057550a061cacfc84
Content-Type: application/octet-stream; name="yy.c"
Content-Disposition: attachment; filename="yy.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lybxayln1>
X-Attachment-Id: f_lybxayln1

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxzeXMvcGFy
YW0uaD4KI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1
ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxlcnIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKaW50
Cm1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKewoJaW50IGZkOwoKCWlmIChhcmdjICE9IDIp
CgkJZXJyeCgxLCAiVXNhZ2U6IG9wZW53IDxmaWxlMT4iKTsKCWZkID0gb3Blbihhcmd2WzFdLCBP
X1dST05MWSwgMCk7CglpZiAoZmQgPCAwKQoJCWVycigxLCAiY2FuJ3Qgd3Jvbmx5IG9wZW4gJXMi
LCBhcmd2WzFdKTsKCWNsb3NlKGZkKTsKCWZkID0gb3Blbihhcmd2WzFdLCBPX1JET05MWSwgMCk7
CglpZiAoZmQgPCAwKQoJCWVycigxLCAiY2FuJ3QgcmRvbmx5IG9wZW4gJXMiLCBhcmd2WzFdKTsK
CWNsb3NlKGZkKTsKfQo=
--00000000000057550a061cacfc84--

