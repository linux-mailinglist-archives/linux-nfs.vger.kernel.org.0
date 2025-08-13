Return-Path: <linux-nfs+bounces-13629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B12B24D96
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Aug 2025 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101623A9896
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Aug 2025 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AAD269CE5;
	Wed, 13 Aug 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="diSLPbC3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73226B96A
	for <linux-nfs@vger.kernel.org>; Wed, 13 Aug 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099170; cv=none; b=MruyZsoeM5yGuk4xnO567r7hLfwTdGSWpdf4ILhQUccw7rNNeKFBO8JSncRKTUnGNA1InWk26IEwW4iu7x0iRrsgVjTAoczrtP3HZvxejfY0PP4K9ZUs83SQjOFMaOEVivmyHTAL/89vTME/pYP/Qfpmm8cKZ5IQz6ewagvVDYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099170; c=relaxed/simple;
	bh=9cqKp+6ZJHc7UrtDrtMW6QwmODnUA6vxHOCwI19rHVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETGS8dvb1tqNUUpO7wYfllh0VTs8LM9aGAvbCbw5mO00v4s28JILoGK0NCgcpN0aDsETNgGJS8LdpThFem6E0HhKcpp5m+nVYJZMf9VooASTo0q3ThAmYcT0RYidTTPRk+vbHkValvUN9JD7BKDFQvi7hH449xAqoiQD7yHz5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=diSLPbC3; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-33211f7f06eso73517291fa.2
        for <linux-nfs@vger.kernel.org>; Wed, 13 Aug 2025 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755099167; x=1755703967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpBZJj5xeYwWbXPUUKamXlvzv1JMtGpX+2XzBN8p43E=;
        b=diSLPbC3Cea2C28kzt3lPLQXdftJl5acGB6jNtWVcJRjKfVnwnXZPhBYJRCw2KRUwW
         GH2CZN/tmdg6cgUd559BT1x3/D385VBZHlOtm/tyCTOmYcqjSNiKJQIb3xhmHPBAN+cu
         0oKJgE7NjFxSwlK+xhS4axqZqcDf+T1U1US/MBll4fiNKMbVu45zUxd657EZS10EJkro
         Cd3DdYKn0XdGTa5QM55B2RhlZ0NApJ2zc5XXuyKxcuNuc352IPIrYb7Z2pYomSVYtB1K
         d525+glQ0nPknAqSP8CrNxDtc9vGtWOXr6QYF4+UPVmSD92DqMAdmS4vJsy1LIQ5/eCS
         w6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099167; x=1755703967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpBZJj5xeYwWbXPUUKamXlvzv1JMtGpX+2XzBN8p43E=;
        b=ITrG6FmVyLdZnXUBq8xDl+yF9J6W8KRInzj/7rJCcLsO2lRZ0/7LKsaw1NOIz+C7bP
         Pav3597CRDdlkjFyFXYc3bAzxzA0mSltzkTri4QkBEubGtBRyu0punw3my4f2l8QVkyu
         sEqF7gKaqpxESTrfCTV8e0SmFE+nK8bYdRYbfxVeepKd44kfkIRFWO2Si7YyDS4oJ49A
         Z7CaYmXePMYGBwIBIHfXpDS3cGO8VCqpz6ViRW39kMTMH0IIkCiB47lG7LCz/7GIsHiO
         P7QYBSev4zXhgeDthqFE5FKVz3mys+mTDicIx4WzWAZocpp9+u70FJjYBDWGOFXLeVXi
         YSYA==
X-Forwarded-Encrypted: i=1; AJvYcCUVcM/SH1fmHWmQQLhLUQIdztNh5i9Ki9zmzgmUCJEVWYjyCMOK9gy+syoxY80B64HkvUUGPDJJaUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKIlseojbYkTVGWEp9sZ+cZnWcN2Fhyr7RVUY/dRC8+RfRuLQP
	apwMvEV+/og9tVzJh0hTkps1b57KO0h2D2xqMaNfTtngSRH/OSygZmQT8Rk2RyxH9VTk8RW7Fbj
	M59lB7eDmGrw8RDi5qo9aDNrc46VYmiWJgpYP5+w=
X-Gm-Gg: ASbGnctTilPrywBRMuLfWqAEXp0DBZX6d0K1hkX96FKsLtA5x6oLxihTws7GdC+pXuq
	02GjXAKap6GbEU973tTJLtZ6nH8flLFTyVSiGGzM8vIGo6GHaxXQSNRQwwZ7Uh4GhXyVsGnUgT8
	cOCfv6CbWuQKqXcd1yKu5lZ+DBzHeESekb2e9UUfKaTKhNerfDzf0H5ekItOhQqpaeoJINCNekA
	fzB69JwIm+zehO3PQww17WCb49oVMwUSQqMl1Z9+w==
X-Google-Smtp-Source: AGHT+IHbN4/wjxvdQRABa3ZRZRvaVba0DUR/+5XvH1C9BqZoubQ5VMhloyjVkMoax1qGxVddFjbCi92VIlcigqXHgj0=
X-Received: by 2002:a05:651c:b12:b0:332:4e34:a55 with SMTP id
 38308e7fff4ca-333e9b32e52mr10938651fa.20.1755099166838; Wed, 13 Aug 2025
 08:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812160317.25363-1-okorniev@redhat.com> <20250812160317.25363-2-okorniev@redhat.com>
 <175504259409.2234665.8366862194585275180@noble.neil.brown.name>
In-Reply-To: <175504259409.2234665.8366862194585275180@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 13 Aug 2025 11:32:35 -0400
X-Gm-Features: Ac12FXxSm6qEVDkwaxUXS6_kATH60F1wpihVGa3UefdVkWRb5v_vLFny3gBIPrs
Message-ID: <CAN-5tyEammkfv3QGwe5Z38q1nFAxYV=REFDN++3XrX7Lni+H0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with nlm_lck_denied_grace_period
To: NeilBrown <neil@brown.name>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 8:05=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
>
> On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
> > When nfsd is in grace and receives an NLM LOCK request which turns
> > out to have a conflicting delegation, return that the server is in
> > grace.
> >
> > Reviewed-by: Jeff Layton <jlayton@redhat.com>
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/lockd/svc4proc.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > index 109e5caae8c7..7ac4af5c9875 100644
> > --- a/fs/lockd/svc4proc.c
> > +++ b/fs/lockd/svc4proc.c
> > @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct=
 nlm_res *resp)
> >       resp->cookie =3D argp->cookie;
> >
> >       /* Obtain client and file */
> > -     if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &=
file)))
> > -             return resp->status =3D=3D nlm_drop_reply ? rpc_drop_repl=
y :rpc_success;
> > +     resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &file)=
;
> > +     switch (resp->status) {
> > +     case 0:
> > +             break;
> > +     case nlm_drop_reply:
> > +             if (locks_in_grace(SVC_NET(rqstp))) {
> > +                     resp->status =3D nlm_lck_denied_grace_period;
>
> I think this is wrong.  If the lock request has the "reclaim" flag set,
> then nlm_lck_denied_grace_period is not a meaningful error.
> nlm4svc_retrieve_args() returns nlm_drop_reply when there is a delay
> getting a response to an upcall to mountd.  For NLM the request really
> must be dropped.

Thank you for pointing out this case so we are suggesting to.

if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim)

However, I've been looking and looking but I cannot figure out how
nlm4svc_retrieve_args() would ever get nlm_drop_reply. You say it can
happen during the upcall to mountd. So that happens within nfsd_open()
call and a part of fh_verify().
To return nlm_drop_reply, nlm_fopen() must have gotten nfserr_dropit
from the nfsd_open().  I have searched and searched but I don't see
anything that ever sets nfserr_dropit (NFSERR_DROPIT).

I searched the logs and nfserr_dropit was an error that was EAGAIN
translated into but then removed by the following patch.

commit 062304a815fe10068c478a4a3f28cf091c55cb82
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Sun Jan 2 22:05:33 2011 -0500

    nfsd: stop translating EAGAIN to nfserr_dropit

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index dc9c2e3fd1b8..fd608a27a8d5 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -735,7 +735,8 @@ nfserrno (int errno)
                { nfserr_stale, -ESTALE },
                { nfserr_jukebox, -ETIMEDOUT },
                { nfserr_jukebox, -ERESTARTSYS },
-               { nfserr_dropit, -EAGAIN },
+               { nfserr_jukebox, -EAGAIN },
+               { nfserr_jukebox, -EWOULDBLOCK },
                { nfserr_jukebox, -ENOMEM },
                { nfserr_badname, -ESRCH },
                { nfserr_io, -ETXTBSY },

so if fh_verify is failing whatever it is returning, it is not
nfserr_dropit nor is it nfserr_jukebox which means nlm_fopen() would
translate it to nlm_failed which with my patch would not trigger
nlm_lck_denied_grace_period error but resp->status would be set to
nlm_failed.

So I circle back to I hope that convinces you that we don't need a
check for the reclaim lock.

I believe nlm_drop_reply is nfsd_open's jukebox error, one of which is
delegation recall. it can be a memory failure. But I'm sure when
EWOULDBLOCK occurs.

> At the very least we need to guard against the reclaim flag being set in
> the above test.  But I would much rather a more clear distinction were
> made between "drop because of a conflicting delegation" and "drop
> because of a delay getting upcall response".
> Maybe a new "nlm_conflicting_delegtion" return from ->fopen which nlm4
> (and ideally nlm2) handles appropriately.


> NeilBrown
>
>
> > +                     return rpc_success;
> > +             }
> > +             return nlm_drop_reply;
> > +     default:
> > +             return rpc_success;
> > +     }
> >
> >       /* Now try to lock the file */
> >       resp->status =3D nlmsvc_lock(rqstp, file, host, &argp->lock,
> > --
> > 2.47.1
> >
> >
>
>

