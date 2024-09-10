Return-Path: <linux-nfs+bounces-6374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E1973E5C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 19:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF3D1C20F2A
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2024 17:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BCF1A00F4;
	Tue, 10 Sep 2024 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lm1qDsnn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E881A0B0D
	for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988416; cv=none; b=TKncAf5obIDDVSEWEwyNQfsEPfA88rmS2EYJs2Nr4bK2NO+kgviYhKL3rJ26xH7YeUPRwVYkI/aaLf4+Z+jS54Rh8F8+gxX5hZ2iGch1VJCvl3QXXBRSeQvZgdjsx0D1M3Jh+TZtV4hVZl5EFRzuDnzhnnfGVjGYGGFuVfH0Wh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988416; c=relaxed/simple;
	bh=n4zZaevy8DK6c9QDGJzAyp6jF0uMBsOhi8OfhVq6138=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcAM+XOVFDhDVujrS0JV8o2GkCEfbhnfmFyI1k7R38iS+kF27SlgoMd5lPxhdA/qBCV56LLoGemkUN2iBuBxVvhkiXcU9VQjkYNZovxx/BDgxGclvtYte7z3IspwPn2owRzG2dekJGnwSDpj/A5pEQ/RP2PyaMurOHWP8HiVEsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lm1qDsnn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725988413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RXH2sS5iclmDvWYqk9mvzPNJZ9viOAgQZIm7N1DXqk=;
	b=Lm1qDsnnhrbQ0N0sidh+xVnZnOVPZ1+64w2zP4r9Tnnsj+MDt6ksLDz1QEh8SBV3LNukaV
	UWS4Rdzvzl6nC1pwyzGTMqvPULqQ9x8Aduym/S0aYZe3g7FpEI9Og0anDIJvDz3EBsN7Rf
	w9UL2qplzq21OPYZKWLe3PdIYSskmRg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-gaQ5stB-NHKF4fUj7ul12g-1; Tue, 10 Sep 2024 13:13:30 -0400
X-MC-Unique: gaQ5stB-NHKF4fUj7ul12g-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53654420f0cso948040e87.0
        for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2024 10:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988408; x=1726593208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RXH2sS5iclmDvWYqk9mvzPNJZ9viOAgQZIm7N1DXqk=;
        b=g/tFzydZik8eTe5bEyh0pKnW2iY0ZVXjyL3hwvFAGHkUe8Xi/1BBxhdFXVzSnA3I5u
         pSk2GiLMyX2qn/DY7Iwq9UPHlqAZNjHxtEJomSBSiMSSOOuSNSS13VyMv2r14SrgWNIQ
         CxIEPlBXedYjQVX52QjJm45SFDjyC49sZJigjBPJP6kjsrc0D3PbclniaLUx7LE7dkrk
         IjB6UB+lbtCSqvC+x1NUL9elKt+F9dRRQ6GK79VNCS7zN4CR+5AoPIdj4sE7QFKVNhAY
         VP7KYHle1qgTqVBkRspX/jpBWORDT+PdT7C/88SVNfCTi+bz0imxcRBmzc+3KrT32Rbw
         rfpw==
X-Forwarded-Encrypted: i=1; AJvYcCUNjSIEB/D+kjYzUlYtLXUsG08UvRJeKimdhPAFDo7nYmMDzNNV8QTDNIzq09Hz7EylWq2rwieR5jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymRPCDd1XPgPvvRQO4bc07d0kZ/V5C3F0itUYjOobJy80nGJ9h
	D45eALoVsFx41J7767CuyzUGsWuzqfjXIiFrfBA/NJnySg25Scemg9/3jpnQNvoWNJuEMPyTwqd
	JY+3ELjNU3zi4fba5PrhTvL1eG5NB83pJOBVo91LE1eiTiV8uVogqwn6tGhdC7Vqdodoi38oTF9
	1wcut9AykUlJLDF8ZSHXId4b/8Mb51UBev
X-Received: by 2002:ac2:4e07:0:b0:533:ad6:8119 with SMTP id 2adb3069b0e04-53673b5f064mr172029e87.14.1725988408510;
        Tue, 10 Sep 2024 10:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7ySxuNWPQGln69KgqCAVhtOxPzmcFRNPXTjKg1h6ROp6mcK5RDm1KHgp+4i8j7FgQQ7/bGi2Y7FFjJpCceEI=
X-Received: by 2002:ac2:4e07:0:b0:533:ad6:8119 with SMTP id
 2adb3069b0e04-53673b5f064mr172012e87.14.1725988407935; Tue, 10 Sep 2024
 10:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823213352.1971009-1-aahringo@redhat.com> <20230823213352.1971009-2-aahringo@redhat.com>
 <B38733D3-6F54-42DF-BD5B-716F0200314F@redhat.com> <1490adc3ae3f82968c6112bb6f9df3c3f2229b04.camel@kernel.org>
In-Reply-To: <1490adc3ae3f82968c6112bb6f9df3c3f2229b04.camel@kernel.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 10 Sep 2024 13:13:16 -0400
Message-ID: <CAK-6q+g4jgeLRQy5WeUHeKGtT0y_anSO=u6cxWxXFiUuEji=7Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] lockd: introduce safe async lock op
To: Jeff Layton <jlayton@kernel.org>
Cc: Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com, 
	trond.myklebust@hammerspace.com, anna@kernel.org, chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2024 at 11:45=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Tue, 2024-09-10 at 10:18 -0400, Benjamin Coddington wrote:
> > On 23 Aug 2023, at 17:33, Alexander Aring wrote:
> >
> > > This patch reverts mostly commit 40595cdc93ed ("nfs: block notificati=
on
> > > on fs with its own ->lock") and introduces an EXPORT_OP_SAFE_ASYNC_LO=
CK
> > > export flag to signal that the "own ->lock" implementation supports
> > > async lock requests. The only main user is DLM that is used by GFS2 a=
nd
> > > OCFS2 filesystem. Those implement their own lock() implementation and
> > > return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
> > > ("nfs: block notification on fs with its own ->lock") the DLM
> > > implementation were never updated. This patch should prepare for DLM
> > > to set the EXPORT_OP_SAFE_ASYNC_LOCK export flag and update the DLM
> > > plock implementation regarding to it.
> > >
> > > Acked-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > ---
> > >  fs/lockd/svclock.c       |  5 ++---
> > >  fs/nfsd/nfs4state.c      | 13 ++++++++++---
> > >  include/linux/exportfs.h |  8 ++++++++
> > >  3 files changed, 20 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > > index c43ccdf28ed9..6e3b230e8317 100644
> > > --- a/fs/lockd/svclock.c
> > > +++ b/fs/lockd/svclock.c
> > > @@ -470,9 +470,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> > >         struct nlm_host *host, struct nlm_lock *lock, int wait,
> > >         struct nlm_cookie *cookie, int reclaim)
> > >  {
> > > -#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> > >     struct inode            *inode =3D nlmsvc_file_inode(file);
> > > -#endif
> > >     struct nlm_block        *block =3D NULL;
> > >     int                     error;
> > >     int                     mode;
> > > @@ -486,7 +484,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> > >                             (long long)lock->fl.fl_end,
> > >                             wait);
> > >
> > > -   if (nlmsvc_file_file(file)->f_op->lock) {
> > > +   if (!export_op_support_safe_async_lock(inode->i_sb->s_export_op,
> > > +                                          nlmsvc_file_file(file)->f_=
op)) {
> >
> > ... but don't most filesystem use VFS' posix_lock_file(), which does th=
e
> > right thing?  I think this patch has broken async lock callbacks for NL=
M for
> > all the other filesystems that just use posix_lock_file().
> >
> > Maybe I'm missing something, but why was that necessary?
> >
>
> Good catch. Yeah, I think that probably should have been an &&
> condition. IOW:
>
>         if (nlmsvc_file_file(file)->f_op->lock &&
>             !export_op_support_safe_async_lock(inode->i_sb->s_export_op,
>
> Alex, thoughts?

The question is here if we ever want that posix_lock_file() receives a
posix lock that has flc_flags and the FL_SLEEP set. As mentioned, may
"posix_lock_file()" can just deal with it and will not block?

This patch indeed broke it as posix_lock_file() will never see a lock
request with FL_SLEEP set, but I remembered that nfs is only polling
locks and "probably" never set FL_SLEEP?

Thanks.

- Alex


