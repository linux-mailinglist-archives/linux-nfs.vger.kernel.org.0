Return-Path: <linux-nfs+bounces-13567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F5B21613
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 21:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D8362678D
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Aug 2025 19:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C1A2D876C;
	Mon, 11 Aug 2025 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Sy8d3DIL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598ED2D8765
	for <linux-nfs@vger.kernel.org>; Mon, 11 Aug 2025 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942359; cv=none; b=D7vZzFTD2xqfGuz9h1CJNaqYQ2mcgRqZUQbZunyu4EsUXq5f6JXc9Cv34vbBGn2l9U8AwFH6Ztgc5ChwTTCxn435XIxQf79X3RCb8P/GfAE5uXQoWhth9UNAzQv4AuliEWoEia1jl4Su+DH4pWtY3HbSogDr54lYW92qL5tN/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942359; c=relaxed/simple;
	bh=bnUOp1RALrV/HDT7jusMCfrydaTyMhYGf7JdnZju4XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ1ELgbejV3aUhzf8KjXNFrNrErHcRgWTHUMubnWUIU9dU8FP7zUzGMX4qtgoCSflPZJwYqBxPzuC1XxORZu7/oNKxffabQKxZz4ai1eYAfVPLsvvza/fohle8E6mZixIeL5Us+N6a0sN2l7DU899YN3NWGg7EHvI5zaqk9rJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Sy8d3DIL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3323afe4804so39188651fa.0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Aug 2025 12:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1754942355; x=1755547155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhVTZZvsC8soqGyI0EjOtPD2OdS+TZAraLynNora6jY=;
        b=Sy8d3DILEpQh+9G2NrYP2H3DCLNki8U19LcyYUwvQy7fA/J/xcWkgLexc3WHLyvA9a
         hSgCiarDpeRSeFBVNUXxX1o9foT3+BdKdcHPucB1GiIMqb1QtojxaqCY2OgYOet1mMje
         49BcMBH6gdbzqL4qFbGIKWUDGnper00gfIYFJ3hz+GzELgpRkXn5G1MGcp50+RujwS36
         QLfLK9dejqSpYgO8++BzPSJEK4j2hCfNA6wKmnWVtqtb49xtcRilrGjdX0A6suNocVlA
         oIm5r2ZUsyAjygyIBSaNRUM1moOncUXDimh9v7meShE3vi5fDzcVLyYxWEq1TVJEDsEu
         /BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942355; x=1755547155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhVTZZvsC8soqGyI0EjOtPD2OdS+TZAraLynNora6jY=;
        b=u0S3bRhN6Ui5XyJu9MVC2t80pikIMx1giXiIvsPrWTgCBBeXqdH6QFUp3UCBC8T7Xa
         kC+eC3oJ8kLKBcnICbFM9YwxRthrttE2VUmbFCot5VVnDGP4075i416igX93uJ378r8T
         kUw3noyIuGdPuxOzsPdSguPmBYJaWYXnMHM4z3jwoPZT3OP2Es1HDSxQi9nmao+GJlke
         sKiUES+2ZG1M26UMRj1AdgZyJk7RKqujHaY3uVmIW8cv8fGu2qEpHhVapIrE1yNwj6v+
         pIl6CaCr0AcbFoKkNrlTMg0EXs5OQHllVHWc9CiSI+35JeagjsL3kfYgcyyAJjuOH08s
         4uZA==
X-Forwarded-Encrypted: i=1; AJvYcCWGyfYEoAZ83CLv/GK6y3FbYEDtug01Z9OQaf2kImaBb+HS05jhZoDOfbrmCqirayUZW6COfeDxXJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSbGcstWDrAvNtT37EKgWHzWb9PZftwntS5WYbYL4j8Y7cpdV
	+OK9//oEk6cXmClfbkrx50zVPKmCmdORYfBf5aOdTLaGNv3vLq//D5tpZ+CwqdBwi6f2xydqJrp
	KsHtYW6VKxjg74bxbyyHyd6q+3k61ayY=
X-Gm-Gg: ASbGnctqhOSQOquB9wjpoj8n0CQ2oQnxBbXh9z9VPEgR69VUnFkLvfUb/WDbM0K76PI
	/kEJzXnYh/Nww7Vzc+PItja4F96iOfslSHqBw/hEs2d3KOq0lSeljb9ku1/sATIx4vJsYMRA3zG
	xoEgn82t5YPyd1/OrXxiYuF44ppap2dzI7vtuQm4qsVUsfNG5IqU+OqPWg3VrVBHv9NljqTUjtg
	f8SOfzyo9oFrjdmWY4K+poqNTKw8c0ktqLmnulhGQ==
X-Google-Smtp-Source: AGHT+IFtUrH3p5sfljw9jdMa3rPiV1Ugyz4DNEIhOtdOd0PJlul84kRnuA4FU6NubO2M0xtAPfKyqwRghiKR8Kk/lWs=
X-Received: by 2002:a2e:751:0:b0:32f:1df5:aca1 with SMTP id
 38308e7fff4ca-333a21f4833mr29741971fa.22.1754942355116; Mon, 11 Aug 2025
 12:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811181840.99269-1-okorniev@redhat.com> <20250811181840.99269-3-okorniev@redhat.com>
 <dffafd607b30e170939af01e054a9652c9ac6f30.camel@kernel.org>
In-Reply-To: <dffafd607b30e170939af01e054a9652c9ac6f30.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 11 Aug 2025 15:59:03 -0400
X-Gm-Features: Ac12FXxql8BAV2Lso0tlOYTfXR8023oOuX_ryS8Jmw-XpFz4IDAn-th1XoGzV_w
Message-ID: <CAN-5tyEZAMNAzWtAvqhRJpJacNZSO7ahGOGiRCncjsY8jPn3ag@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] lockd: while grace prefer to fail with nlm_lck_denied_grace_period
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neil@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:42=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2025-08-11 at 14:18 -0400, Olga Kornievskaia wrote:
> > When nfsd is in grace and receives an NLM LOCK request which turns
> > out to have a conflicting delegation, return that the server is in
> > grace.
> >
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
> > +                     return rpc_success;
> > +             }
> > +             return nlm_drop_reply;
> > +     default:
> > +             return rpc_success;
> > +     }
> >
> >       /* Now try to lock the file */
> >       resp->status =3D nlmsvc_lock(rqstp, file, host, &argp->lock,
>
> ACK to returning the right error code in this case, but you may want to
> do this differently if you agree with me on patch #1.

I'm not sure what is the suggestion from the patch#1. Unless the
suggestion is for the server to return "denied" and then also for the
client to implement handling that error by retrying? So I wonder how
would that go? Should the client retry indefinitely or how long should
be waiting to retry the request instead of failing...

And also I'm somewhat uncomfortable in changing the client's
interpretation of the NLM's "denied" error code.


> --
> Jeff Layton <jlayton@kernel.org>
>

