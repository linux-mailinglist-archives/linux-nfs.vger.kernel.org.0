Return-Path: <linux-nfs+bounces-8636-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFF09F580E
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 21:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0279B188D8FB
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2024 20:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA541DA10C;
	Tue, 17 Dec 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="bJQMMGaf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D31E14885B
	for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468465; cv=none; b=gq6RwwoYrAT5+gicJQIZgeo/g/8zN0q4zqsAc1IEacjbb0WnEyJceyRQ1hXpgRsYb4YimmEag5fbZZ64FVeE7l1x3Vejp0E7kkHc0+P1alaAdHIwiGEJFg8AEV7lGk32RdkfjODySDUV69XQY5S2bAt9XTImS8adR0tEyRjxvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468465; c=relaxed/simple;
	bh=Udj+RuHho6Ebp1HG4taiF/jkE+YlK4Cn3Irl+k6qX8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRFlrybEmEf5hXTzXx5dAJjt5rM2ZK/BQJQmOmj5xAx6M3j5Z4Z5081pRfXRLC3omkjJdoyboLL72uyfxroIrTs0RU9CDBPVO3Ck5KWpjIB87X6/OtiMhQ57kUNc5uzcuIabX47S2/r2fQfQjC+QLjGbV+VcUgYkiLAiShdAG5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=bJQMMGaf; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30229d5b1caso58307911fa.2
        for <linux-nfs@vger.kernel.org>; Tue, 17 Dec 2024 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1734468461; x=1735073261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmUuuLGa8J4nOLoshhu6/qIm3JQKU7eprruOS5Dfsaw=;
        b=bJQMMGafysXC8R5Yo+jYpMxZyLt83mQd9k0apAwzZ2+S/FAe38e3eC0ga+UBuZYL0s
         GJShzVswGR9FEyT2T6h7nq7tF0yElLMJ7UNbNMhucxrUaG0IH4SqAjMgd0yiTZwXM5WI
         o8XKQr5crJE3VBA4pbcXKK0/vCbcOSI+oRxorhIImuGcILrymva6uaG+xNWFBRaKXD7r
         X2/zwACoFCa638v3QOhZV99zT7itvefwKfjOKsqPyeXChIYhBwGjXSjVnVYbiOo7ZsO+
         PUdc4fQpZ71rSWSFWBsHbh5f/dL8frb6j5V6mLph0oxX+JE0+q3C4QgNZifOL3WfcGvZ
         cd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734468461; x=1735073261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmUuuLGa8J4nOLoshhu6/qIm3JQKU7eprruOS5Dfsaw=;
        b=orymi0Ua+jW4byEyStoC4/dgtLaXIWinn/JMQL2XnAMPgn5jaZsp9A7pWMcwgJHkvx
         JlgJ25CIHxREwDqTu/S10atHRCBdg6qnP7EyRC9JDcnufYCmlJadnbi6gQhBx21exOZy
         HMguf1Fa2hIdtv0SCA24tI0leIj8IPdBXmNXhTqRydslcS/+9S49jumFnrYcRp5ECtRK
         8axEUckKbeHX1qJpGLE4Xi0OyRSe6t2Ta+VfyzhOzGlYSrOPpvGdsm4Rx7MgCnjBstkz
         uxJAIRXODZ2UZekGB+tfwU7VGmX+SBuV7wwjDZN44MkqSUq83dqSkLbeA4osyhMVyZt0
         IYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfnOXvxRNfL3SgT4ClnBiav9Tv4+rXDuwl+aVSLcd/7JshQaALTZKIxI+Xbb3I/SkwtpbK3OriUVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKeLnkcXVSgbxlBIFWnbd1RYeRMQ92zRYYm7obFnW+/VaiNIC7
	r+zlmyroowqOPmKh+zPdeDwgB8FxtCn6D8O0fw7EB+EW9ASPr2EEvany2M5n0lmU1sn1isqo1p1
	a6ztT7u4yVr1d5pMpySwlhI+rLzE=
X-Gm-Gg: ASbGncvbaVskgBoaRZR3QSDkYPeMQ9fVm4vpCwo/fqcmD/M4sikZCwhEHIYd73RY2nh
	X/eXNmbVHuyTKw9sXa9IorPT/5gBpYLxBXmwx2yEDV1K0WT/djGNVs1/r4p0vrcFEgLgoSPQ=
X-Google-Smtp-Source: AGHT+IHrFwhFIiwoqbbyGNYk+IyPPFp2uMG3HZ755n4AdNKL9aXdF4H4UNkbcxOE3wnrZc7LpgYVc/VKZgYOP6zyV4g=
X-Received: by 2002:a05:651c:154a:b0:302:3356:7751 with SMTP id
 38308e7fff4ca-3044db51faamr1346651fa.40.1734468461114; Tue, 17 Dec 2024
 12:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217192742.97306-1-okorniev@redhat.com> <91943f72-aaa3-4431-aaa1-a6d9a6f13b3f@oracle.com>
In-Reply-To: <91943f72-aaa3-4431-aaa1-a6d9a6f13b3f@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 17 Dec 2024 15:47:29 -0500
Message-ID: <CAN-5tyETNF3VQXbc9+iD8PD079j96n7mNs9-=bdbtCz7uuo72Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD: fix management of pending async copies
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 2:45=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 12/17/24 2:27 PM, Olga Kornievskaia wrote:
>
> Needs a problem statement. I suggest something like:
>
> "Currently the pending_async_copies count is decremented just before
> a struct nfsd4_copy is destroyed. But now that nfsd4_copy structures
> stick around for 10 lease periods after the COPY itself has completed,
> the pending_async_copies count stays high for a long time. This causes
> NFSD to avoid the use of background copy even though the actual
> background copy workload might no longer be running."

Sure I can re-submit with this change in the comment.

> > Consider async copy done once it's done processing the copy work.
>
> Doesn't nfsd4_stop_copy() need to decrement as well, if it finds that
> the kthread is still running?

I thought so. So I tested it. kthread_stop() sends a signal to the
thread (thread needs to check kthread_should_stop() which we do) that
it wants to exit and then waits for its completion. That means the
copy thread runs its course and by doing so decrements the pending
count. Otherwise, I found out, we do it twice (and end up negative).

>
>
> > Fixes: aa0ebd21df9c ("NFSD: Add nfsd4_copy time-to-live")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >   fs/nfsd/nfs4proc.c | 13 ++++++++-----
> >   1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index f8a10f90bc7a..ad44ad49274f 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1347,7 +1347,6 @@ static void nfs4_put_copy(struct nfsd4_copy *copy=
)
> >   {
> >       if (!refcount_dec_and_test(&copy->refcount))
> >               return;
> > -     atomic_dec(&copy->cp_nn->pending_async_copies);
> >       kfree(copy->cp_src);
> >       kfree(copy);
> >   }
> > @@ -1870,6 +1869,7 @@ static int nfsd4_do_async_copy(void *data)
> >       set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
> >       trace_nfsd_copy_async_done(copy);
> >       nfsd4_send_cb_offload(copy);
> > +     atomic_dec(&copy->cp_nn->pending_async_copies);
> >       return 0;
> >   }
> >
> > @@ -1927,19 +1927,19 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> >               /* Arbitrary cap on number of pending async copy operatio=
ns */
> >               if (atomic_inc_return(&nn->pending_async_copies) >
> >                               (int)rqstp->rq_pool->sp_nrthreads)
> > -                     goto out_err;
> > +                     goto out_dec_async_copy_err;
> >               async_copy->cp_src =3D kmalloc(sizeof(*async_copy->cp_src=
), GFP_KERNEL);
> >               if (!async_copy->cp_src)
> > -                     goto out_err;
> > +                     goto out_dec_async_copy_err;
> >               if (!nfs4_init_copy_state(nn, copy))
> > -                     goto out_err;
> > +                     goto out_dec_async_copy_err;
> >               memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
> >                       sizeof(result->cb_stateid));
> >               dup_copy_fields(copy, async_copy);
> >               async_copy->copy_task =3D kthread_create(nfsd4_do_async_c=
opy,
> >                               async_copy, "%s", "copy thread");
> >               if (IS_ERR(async_copy->copy_task))
> > -                     goto out_err;
> > +                     goto out_dec_async_copy_err;
> >               spin_lock(&async_copy->cp_clp->async_lock);
> >               list_add(&async_copy->copies,
> >                               &async_copy->cp_clp->async_copies);
> > @@ -1954,6 +1954,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> >       trace_nfsd_copy_done(copy, status);
> >       release_copy_files(copy);
> >       return status;
> > +out_dec_async_copy_err:
> > +     if (async_copy)
> > +             atomic_dec(&nn->pending_async_copies);
> >   out_err:
> >       if (nfsd4_ssc_is_inter(copy)) {
> >               /*
>
>
> --
> Chuck Lever
>

