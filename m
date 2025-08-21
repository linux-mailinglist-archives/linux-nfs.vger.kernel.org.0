Return-Path: <linux-nfs+bounces-13853-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF726B302E3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 21:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56021AC53C7
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17545205E25;
	Thu, 21 Aug 2025 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="BqGPHeku"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A8C1F948
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804534; cv=none; b=tcZvbUBmNsaoepatZsQZecS4aV/KJxsVui3gtD5/DSnJAFNPoijBisqd0jw2y0Jnx6SMewrMthHJuGI1lcOPHBQZZVwkvfhpPVBHS3iEmmbs4aY6THmBfGncjbfeRCKBeXYW5kDfVr0Dpr6l818/V8I3CQyii4hasD17+dJryjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804534; c=relaxed/simple;
	bh=aw9kiJlaVQgR5OYUIoGnJQ/3v02AwstuDq3QZAA6SAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlmSk6YSC/dcX7yqR3kBMHGG75A6z9lF1tmYe//b67f6IwN5D1tfxlPIc54JSVCBvrNrJWoB3Wno+snkqFkuMi9gl3gVLBq/IZp8MyaNNBUBz6BjyF8JGpkDevaOusdQA1mXu5L89x+V2EF1ANVnNTw6l1ZLb6rbUqK/rq6pEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=BqGPHeku; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3354b208871so8564021fa.1
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755804530; x=1756409330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbwwQS3hn9UPuhiVBEw4YpTAC6i8IuIkkcFtJZylXJE=;
        b=BqGPHekub9djNEoCzopmD0GiLIe63S7FoY3WtIUTDRguZo6UJXQplkNKF8jNzKsBdK
         0NhqDEFgNeQK7oF9k1eN0dXPXYFrZsBpdEg1OA5+fTsO20W5HUqOWEMrQVYQnnLan+nA
         krxtlm4KXzXYJnwbG+vlq/TmzXAC4tuFodgKKJxI2tbv0AgCD58+YTVoIumpxeIpCzV/
         keS3Yk+Q2ZwrlLteNL+hC5ix5gE22a/xqbQi3mEPDhFi34OH2oHoEZKa+TK5BPKQV2f8
         YQvz6L5DJHtUp/OVGxXdXq4gROi8f6RXKnkwaeWzICZ9yYBSjbNUhzyhQi9JOyWTXDM1
         SHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755804530; x=1756409330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbwwQS3hn9UPuhiVBEw4YpTAC6i8IuIkkcFtJZylXJE=;
        b=N0vQKkaNVl7C9fubg1iFPArVQbEqmTQnMYt4ieH9mhiVFVADKf1fB8E8uu6LoMv0ZA
         gjYFYLtA480H5mYziRHTxOGj4+UvsVyVRHVqOUcukgEj7+WkWG9vZcAG30m1esoHhgb/
         w8GaPATOBYpENNXN6p6eMrahZ7QiLBbejNOUyzsreID5eUSuPPtoyUeKTiyYl2RIw7Xx
         Rx17mj765PiRKd01zJhvm+qrwUiVdKNHClHqKD23pvMX1WZkEdKaEc1U/ZIs43ZRRaNM
         r6lXRfC7X1VRMZ2rnA+DmN4yOkr0SocZMnWWhQ+FvrIXbWzYeZJVC0aLJtFwd1QqZ6Cw
         gl9w==
X-Forwarded-Encrypted: i=1; AJvYcCXNZhhrWre/5lk4aaNX/+hbYN/9FZlE/JYhX5Wxs1/0WKHlndv/EDQ4WoFJDbRo2vtmsWwX5EX0NiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwvpJJ8X6v2/UhRkabK0WMjIiaXL32ljTtb0RQEgYKxIDtm+b
	zsotdN7YXwSc291mwpQykvd3h92hNp9ZgC106ibplErDMVb8rFcfzJMqCHXQ/kHczox/Z3Maeia
	7HF8yHDVKq3Dzb6b0FSN8Ks6Cx7vn1k8=
X-Gm-Gg: ASbGnctHXR8KVZ6hZJxMKeQHZtJ4lQ8oG4ljgg/ijhWHbAZl+8mz5F4zCNojSbM6RIg
	PPMx/SdiQO/2s93khdmR3Udrs0+40v3Q2WRTclrtbheJYL6a8YThM3Mc44umJJnO0y8QtdYBhBv
	nXPspk2Fd3CIyRwOrsieSav6zsQ9ZtM2Ek2ho3zFVj2OUfcqnG2/qaawa9RyPkc50VaZ6PFCm7P
	lR3rj4p42mVNs+zydn5yZz4iJT2sxHuwC6Ta/X43A==
X-Google-Smtp-Source: AGHT+IH+aAAVWcDBtNSRwSkzNkxvIqK2Yxkq3MwiwCDM+kJeaep+jDANMOilYySEPHz832t5Prthd+vAxNgPZVwR+SU=
X-Received: by 2002:a05:651c:1111:b0:333:d2e3:6c01 with SMTP id
 38308e7fff4ca-33650f8621bmr630111fa.30.1755804529878; Thu, 21 Aug 2025
 12:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812160317.25363-1-okorniev@redhat.com> <12407545-2fd9-43ac-8766-4fe8a1343b68@oracle.com>
In-Reply-To: <12407545-2fd9-43ac-8766-4fe8a1343b68@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 21 Aug 2025 15:28:38 -0400
X-Gm-Features: Ac12FXyQh706v8B8h9VEGXsKhfEQIT7CXtccUMYUau6-CYIpz3NGd1hZlw1_fnI
Message-ID: <CAN-5tyEJPk5RtC7SAFxUotgh4vaytmOyaZyY5Jp+UxYAk_tDdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, neil@brown.name, linux-nfs@vger.kernel.org, 
	Dai.Ngo@oracle.com, tom@talpey.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 3:18=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> OK, let's reset this discussion.
>
>
> On 8/12/25 12:03 PM, Olga Kornievskaia wrote:
> > When v3 NLM request finds a conflicting delegation, it triggers
> > a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
> > then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
> > of returning nlm_failed for when there is a conflicting delegation,
> > drop this NLM request so that the client retries. Once delegation
> > is recalled and if a local lock is claimed, a retry would lead to
> > nfsd returning a nlm_lck_blocked error or a successful nlm lock.
>
> If this patch "... solves a problem and a fix is needed" then we need a
> Fixes: tag so the patch is prioritized and considered for LTS.

What fixes tag is appropriate here? This is day 0 behaviour but it's
only a problem since additions of write delegations I believe.

> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/lockd.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > index edc9f75dc75c..8fdc769d392e 100644
> > --- a/fs/nfsd/lockd.c
> > +++ b/fs/nfsd/lockd.c
> > @@ -57,6 +57,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, =
struct file **filp,
> >       switch (nfserr) {
> >       case nfs_ok:
> >               return 0;
> > +     case nfserr_jukebox:
> > +             /* this error can indicate a presence of a conflicting
> > +              * delegation to an NLM lock request. Options are:
> > +              * (1) For now, drop this request and make the client
> > +              * retry. When delegation is returned, client's retry wil=
l
> > +              * complete.
> > +              * (2) NLM4_DENIED as per "spec" signals to the client
> > +              * that the lock is unavaiable now but client can retry.
> > +              * Linux client implementation does not. It treats
> > +              * NLM4_DENIED same as NLM4_FAILED and errors the request=
.
> > +              * (3) For the future, treat this as blocked lock and try
> > +              * to callback when the delegation is returned but might
> > +              * not have a proper lock request to block on.
> > +              */
>
> s/unavaiable/unavailable
>
> Since 2020, kernel coding style uses the "fallthrough;" keyword for
> switch cases with no "break;".
>
> Although, instead of "fallthrough;",

I'll add that.

> you could simply remove the
> nfserr_dropit case in this patch. That would remove the conflict with
> Neil's patch (if it were to be postponed until after this one).

I can re-send the patch with the fallthrough added on top of Neil's patch.

>
>
> >       case nfserr_dropit:
> >               return nlm_drop_reply;
> >       case nfserr_stale:
>
>
>
> --
> Chuck Lever
>

