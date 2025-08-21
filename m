Return-Path: <linux-nfs+bounces-13858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 067ECB30347
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 21:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39717AC3DC
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A803451D8;
	Thu, 21 Aug 2025 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="XEp6gucs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C016F0FE
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806285; cv=none; b=PFKuKa2TwXl9O47EnIADECppKZSbTxZ0bseAbohMv9v/fwsa88slA676R560dLOPVaAVDVynUxeB+EYq2aXXiMiKnh8e9xycYGo2fwzRnB8JCuX1Gsu50fos34r0XKw0hOo1X8awfE/EJSVwjBQ+A96NzKZe9efIayO6vZSeuB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806285; c=relaxed/simple;
	bh=Pg30aWa6RZqOFf9ISq5DQToszswFGjRAAh4nqgEzuO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqtY4EDB5NjG4RpqIu/6WK2QZOIHDPuNIGhr4ENY+Na8BUsv+f6KYzKvNFFwnj/ypcevSMoaVe2h0a9AIQX+2KOo+c14wS7hYI20nWO2D38pxHL7WK8V22xlotI/eZY2NBMtvvXV8T0CNyHJSZtLg4vxnxMu0v1paQIR8O2KQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=XEp6gucs; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55ce5090b1cso1344053e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755806282; x=1756411082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBVmnSz2LGJoBBKzNkcN2YThB3fLFOWWNSSquWa/JSA=;
        b=XEp6gucsXeFeyoABoGYLzgyNE05q0/hegQhY7tCFjUYOg5c3mU94vyXw7IPAY2kfUJ
         eBsF38S5bE9PfGegonhWgXsnZBdO+rzYJxGY+BF6Q3U5YSphy6qDDiZIXG5xxFpnUbnN
         53wYw/HAtw2wA2fppmizUsKAGyK87s0isnSPN/CuP788kjAnorg1PAhKhLKo4x6EK6p6
         MGPY8oUyhUxn20k8zkD58sp7cOi5Kaj7fVX6b6IwdwtchJLP3FzfI6yGC+ttCYmZhs5m
         haTUZLU4tO8sbAdo8rrTnbWDEUT+RbLqxP6dJ1oj8aRI5VMZzTiOK8zMBUMVgGNrLjUw
         E8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806282; x=1756411082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBVmnSz2LGJoBBKzNkcN2YThB3fLFOWWNSSquWa/JSA=;
        b=GUzsyrNTWkmQTYeokjDh6TLddfDIb0KLLGaipNC0XGQfTIkvSsCa7YgPNkZhRqzMFV
         ONkz1JaWU/likNfwjsa7OGJTkMV95FgexoH7GiHYaipl3tHZpDO8hXJzOUvRv7pMHeyP
         y98cfs1bWPXPorW0ZoYcRGBi8wYcgkiCNSKIBYwzU+jPjrmupioEV61WTQ7Ijoh83mBy
         ARVfEeqi6Cjeg4of4GQHb4eWw3hMhcu9OTV6Z6OjzwFARMKzKMUMbA7TZcbeeyQI/wJ8
         u6rv8awnKnJSQpioA7Us/TImyR0lyVheKyTGVH+O4QkNrBqkXiXWmYgMwZJyOKDqqQvS
         qxHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdBBHl9Dlc66z/0pSW0GU+9f/22AoDKVfut2FESuL0KgcfSWpF9i+CLIfxk17CbenTkjcCcf3tet4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyasw8HwAgAfYjq5NvfZsxwbc34Dcs1izt9bfKZv56FeQfKCOwi
	TqScb6fXUH44enhV2DSFleMAfoVJ3ibdWd9M8Bk06k/foLYP+Gn2tLozLr6lNpA/Hc7RjlCMn+4
	6a01HMttdTh24ZL2X5ezC74xBK+enqQU=
X-Gm-Gg: ASbGncvkGQpMiA+6ZjXjqxfVufk0AumcBPhaiw2TFohRcB3oH2KX32xLGU2zgegpRND
	ybouexgfYhqQ+jq3Kj06y8mFqOJxF8l+D0JKIABstbhULErZajU31HyFSzBwl3avwRdHgeL6q3a
	vRAa8hEqUwzrZ54B2gJwqEt2GK43SVYANWQoJG3ppQRMxhixIR2eRnQSiWWTvcHsgo3waTYzIQK
	WRTPmgbRCUVVSaG2lw9mKzwpKkpLJbza79NJZ6GfA==
X-Google-Smtp-Source: AGHT+IHcfsO+f0Kdmr/HOcrl0e+bvA/0IlfnplTa0gGIOF9Asszmi0ASctYnqijBMor+vHeZiwIWwyR4TBTocJnvpuE=
X-Received: by 2002:a05:651c:150b:b0:32b:50c5:2593 with SMTP id
 38308e7fff4ca-33650eb00bfmr1144701fa.18.1755806281449; Thu, 21 Aug 2025
 12:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812160317.25363-1-okorniev@redhat.com> <12407545-2fd9-43ac-8766-4fe8a1343b68@oracle.com>
 <CAN-5tyEJPk5RtC7SAFxUotgh4vaytmOyaZyY5Jp+UxYAk_tDdw@mail.gmail.com> <d097a22e-fe04-42e3-ad3f-b69a056b5434@oracle.com>
In-Reply-To: <d097a22e-fe04-42e3-ad3f-b69a056b5434@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 21 Aug 2025 15:57:49 -0400
X-Gm-Features: Ac12FXyV-8b0AL2Qx6CkgDEFn_jMt8I0mBVS0xyZ5E5fIMk9Mao7jMEr5Pg5L-w
Message-ID: <CAN-5tyF40+MyE0sr3uCFyGtgUXtzVWKDzWvTRnQ94-Nq5w9iJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, neil@brown.name, linux-nfs@vger.kernel.org, 
	Dai.Ngo@oracle.com, tom@talpey.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 3:45=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 8/21/25 3:28 PM, Olga Kornievskaia wrote:
> > On Thu, Aug 21, 2025 at 3:18=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >>
> >> OK, let's reset this discussion.
> >>
> >>
> >> On 8/12/25 12:03 PM, Olga Kornievskaia wrote:
> >>> When v3 NLM request finds a conflicting delegation, it triggers
> >>> a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
> >>> then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
> >>> of returning nlm_failed for when there is a conflicting delegation,
> >>> drop this NLM request so that the client retries. Once delegation
> >>> is recalled and if a local lock is claimed, a retry would lead to
> >>> nfsd returning a nlm_lck_blocked error or a successful nlm lock.
> >>
> >> If this patch "... solves a problem and a fix is needed" then we need =
a
> >> Fixes: tag so the patch is prioritized and considered for LTS.
> >
> > What fixes tag is appropriate here? This is day 0 behaviour but it's
> > only a problem since additions of write delegations I believe.
>
> How about:
>
> Fixes: d343fce148a4 ("[PATCH] knfsd: Allow lockd to drop replies as
> appropriate")

That sounds fine to me.

> Suggested-Cc: stable@vger.kernel.org # v6.6
>
> (I'll remove the "Suggested-" when applying the patch)

I will re-send original patch with the Fixes and Suggested-Cc added to
the commit message.

> >>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>> ---
> >>>  fs/nfsd/lockd.c | 14 ++++++++++++++
> >>>  1 file changed, 14 insertions(+)
> >>>
> >>> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> >>> index edc9f75dc75c..8fdc769d392e 100644
> >>> --- a/fs/nfsd/lockd.c
> >>> +++ b/fs/nfsd/lockd.c
> >>> @@ -57,6 +57,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f=
, struct file **filp,
> >>>       switch (nfserr) {
> >>>       case nfs_ok:
> >>>               return 0;
> >>> +     case nfserr_jukebox:
> >>> +             /* this error can indicate a presence of a conflicting
> >>> +              * delegation to an NLM lock request. Options are:
> >>> +              * (1) For now, drop this request and make the client
> >>> +              * retry. When delegation is returned, client's retry w=
ill
> >>> +              * complete.
> >>> +              * (2) NLM4_DENIED as per "spec" signals to the client
> >>> +              * that the lock is unavaiable now but client can retry=
.
> >>> +              * Linux client implementation does not. It treats
> >>> +              * NLM4_DENIED same as NLM4_FAILED and errors the reque=
st.
> >>> +              * (3) For the future, treat this as blocked lock and t=
ry
> >>> +              * to callback when the delegation is returned but migh=
t
> >>> +              * not have a proper lock request to block on.
> >>> +              */
> >>
> >> s/unavaiable/unavailable
> >>
> >> Since 2020, kernel coding style uses the "fallthrough;" keyword for
> >> switch cases with no "break;".
> >>
> >> Although, instead of "fallthrough;",
> >
> > I'll add that.
> >
> >> you could simply remove the
> >> nfserr_dropit case in this patch. That would remove the conflict with
> >> Neil's patch (if it were to be postponed until after this one).
> >
> > I can re-send the patch with the fallthrough added on top of Neil's pat=
ch.
>
> If you agree that this fix is appropriate for LTS, then Neil's patch
> needs to be rebased on top of this one to facilitate automated LTS
> backporting.

I believe this fix is appropriate for LTS.

> I can drop Neil's patch from nfsd-testing and have him submit a
> rebased one, once this one is re-applied to nfsd-testing.
>
> >>>       case nfserr_dropit:
> >>>               return nlm_drop_reply;
> >>>       case nfserr_stale:
> >>
> >>
> >>
> >> --
> >> Chuck Lever
> >>
>
>
> --
> Chuck Lever

