Return-Path: <linux-nfs+bounces-13854-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C887FB3031F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 21:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8187A52E4
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D92E88B7;
	Thu, 21 Aug 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="e2ZuNlVD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF872DFA2A
	for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805495; cv=none; b=bm3yRLhUUgL/UAHX+5oHlfEnN3Cc9z1Pt6VAEF6zKwaBoxVGgKulBP6wqFmRbVt4LFwVAtCDm/kHfVjMz0GUw9i9IXoSijGYJYgdE7ZCeDM8NR2aDDiVQuFo6YxHBeXaHVjv2NUzaX06Svht3fGqzMvml3+txoE4ORGA4EQwz0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805495; c=relaxed/simple;
	bh=iE0VCQJCLj4fbvW9SwFTNJOZl/tIxxg7ndwt79dqwGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOKWv4l0lgBJSYXfskOxx9LABxjzUY/GZgloawm4TM8iLdhQWQA/AzwIz6GgbmDSflylWcj/ttS+jURGAfd4fiFBWaFEiArfVT8sLZZFTRz1k8m4dRBXRIHqy0AGQDlbocrZavkJ2U/z7cEOntfGKPZFJOEN/XVM6fznd5Fc6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=e2ZuNlVD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3352212fefdso11551361fa.3
        for <linux-nfs@vger.kernel.org>; Thu, 21 Aug 2025 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755805491; x=1756410291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eChMy8KfY+ck1orzuw0SXSasC7DwnnxndUMKaFGdrqg=;
        b=e2ZuNlVDEFmx6kE7ily9jMrsvo2+iBsdjQlSNeFlbu8P8lijqNgEPcIoF7YHJtWT0T
         X6tX6Xky1DMWRm7UXNsGjiBiLZrf/X63Y36u71+T1bTRf36AATia1o/3Mu85TPWbgWh3
         9UECEVNXNBZEimUGBTglyf3LTt1Ultm0Zk4m7omFCdKxRm0McveKH/QGUuAm2440A0HI
         lCwkz+/o6D4+2VkzyxgRlQpn/xfEhk6kQYp8E4tg6rrDFfM408bqfVUJrnO9FS1P4Zph
         WiJqxZFjrVxFCCDbavDLXvI3dO8u2st6DrBNYDZjjB+urYdrqpZmgnmR1xE9bNAU5PB4
         Jgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755805492; x=1756410292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eChMy8KfY+ck1orzuw0SXSasC7DwnnxndUMKaFGdrqg=;
        b=uC+ADF82DrXlLAIoXl3g8kfSC+mHGZnZAkgeeFO3PCkHaeg3OzpfoSR106rkjfo9wF
         nQxVJSBK/u7JMZVHaRL0BV1bH7oueaCu78oVgexnwD6IaiLkbkYkI9sLy7aIuX4vTRW+
         QJ+jZJArPuSjbxyP6FJ7yUUSNp3e6jT+LADPTwo2k1XG3o+W0g/f+E49oHbSiI7buM0d
         CBLWSNwMfEWxPR4339hhXyR/bnNRvMUNdM4dvTodu1CfPz9EzpHtphGga3iQI5hhaYCt
         FioVdCe7mgWlkP4UlEfuMIozBz+wHnjVeTOJAW3ZU+HOOUUeT0eMOm1n7pFiATGRPkI5
         H/vw==
X-Forwarded-Encrypted: i=1; AJvYcCX7wZs3X99I0VoSUDXPGQ8eEkfiPS3AmxNenwHseGarOzCxp/otlwYZX5uge/U2BwnkQTEgx8O5eq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8uPhtruGcFnAqIGW6dnHFzj1M14+5vXV1NczOG4W9iJxVv5n
	pNIRysiGsKFI+i+9eWTUkKkQFUy2Mvw21FSIP3tFgGAIz8WUGwOSslBNbOai/o4eyn5cvmUeEHg
	hOzAxj8xmkCm3l3wjxpCQhS5yu6DNeck=
X-Gm-Gg: ASbGncvX82MURcGRAwKwg9IKV2YmyHMYippFGzsjHgXb2iPZE1EeNkEtTBwr5aY/Ub6
	RHQ2t6zLyRMNqtx8znzsh5tRkCcylKJOIgwosjRu4KV3IHHqWauGFXGcq2XYW/wxPr99JtaNA5f
	F0WGwLxvZWhvWe65gy4xVYgYWKtcxuGsZrdGCxvYuiWaNWHS/QFA4gAH4yRz+kGj7W2PQN2LG+8
	x6lbkqH84cGjhVRwZrkqLLY1Xbw2Loyn88hks1jeg==
X-Google-Smtp-Source: AGHT+IEP6IIwcraNqIk2prAt3XkLwt7crVa1JKEluNo6EFsYO0+zj6nc1jxt7Ur9gCAHAKUW0p+ZFkJjEjiyNOm9pTI=
X-Received: by 2002:a05:651c:378a:b0:32f:3e83:4379 with SMTP id
 38308e7fff4ca-336510276e6mr604641fa.38.1755805491404; Thu, 21 Aug 2025
 12:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812160317.25363-1-okorniev@redhat.com> <12407545-2fd9-43ac-8766-4fe8a1343b68@oracle.com>
 <CAN-5tyEJPk5RtC7SAFxUotgh4vaytmOyaZyY5Jp+UxYAk_tDdw@mail.gmail.com>
In-Reply-To: <CAN-5tyEJPk5RtC7SAFxUotgh4vaytmOyaZyY5Jp+UxYAk_tDdw@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 21 Aug 2025 15:44:39 -0400
X-Gm-Features: Ac12FXy2_eB221DJxo81dfMGEQpUPtopBy8zsLbOrwfdi7H2owsLQ3JgxTfSNUo
Message-ID: <CAN-5tyGEX6jJ3qqwqLpqP2B=P5EHgvk5KY9UVtjoe7+9gRUu4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nfsd: nfserr_jukebox in nlm_fopen should lead to a retry
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, neil@brown.name, linux-nfs@vger.kernel.org, 
	Dai.Ngo@oracle.com, tom@talpey.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 3:28=E2=80=AFPM Olga Kornievskaia <aglo@umich.edu> =
wrote:
>
> On Thu, Aug 21, 2025 at 3:18=E2=80=AFPM Chuck Lever <chuck.lever@oracle.c=
om> wrote:
> >
> > OK, let's reset this discussion.
> >
> >
> > On 8/12/25 12:03 PM, Olga Kornievskaia wrote:
> > > When v3 NLM request finds a conflicting delegation, it triggers
> > > a delegation recall and nfsd_open fails with EAGAIN. nfsd_open
> > > then translates EAGAIN into nfserr_jukebox. In nlm_fopen, instead
> > > of returning nlm_failed for when there is a conflicting delegation,
> > > drop this NLM request so that the client retries. Once delegation
> > > is recalled and if a local lock is claimed, a retry would lead to
> > > nfsd returning a nlm_lck_blocked error or a successful nlm lock.
> >
> > If this patch "... solves a problem and a fix is needed" then we need a
> > Fixes: tag so the patch is prioritized and considered for LTS.
>
> What fixes tag is appropriate here? This is day 0 behaviour but it's
> only a problem since additions of write delegations I believe.
>
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  fs/nfsd/lockd.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> > > index edc9f75dc75c..8fdc769d392e 100644
> > > --- a/fs/nfsd/lockd.c
> > > +++ b/fs/nfsd/lockd.c
> > > @@ -57,6 +57,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f=
, struct file **filp,
> > >       switch (nfserr) {
> > >       case nfs_ok:
> > >               return 0;
> > > +     case nfserr_jukebox:
> > > +             /* this error can indicate a presence of a conflicting
> > > +              * delegation to an NLM lock request. Options are:
> > > +              * (1) For now, drop this request and make the client
> > > +              * retry. When delegation is returned, client's retry w=
ill
> > > +              * complete.
> > > +              * (2) NLM4_DENIED as per "spec" signals to the client
> > > +              * that the lock is unavaiable now but client can retry=
.
> > > +              * Linux client implementation does not. It treats
> > > +              * NLM4_DENIED same as NLM4_FAILED and errors the reque=
st.
> > > +              * (3) For the future, treat this as blocked lock and t=
ry
> > > +              * to callback when the delegation is returned but migh=
t
> > > +              * not have a proper lock request to block on.
> > > +              */
> >
> > s/unavaiable/unavailable
> >
> > Since 2020, kernel coding style uses the "fallthrough;" keyword for
> > switch cases with no "break;".
> >
> > Although, instead of "fallthrough;",
>
> I'll add that.
>
> > you could simply remove the
> > nfserr_dropit case in this patch. That would remove the conflict with
> > Neil's patch (if it were to be postponed until after this one).
>
> I can re-send the patch with the fallthrough added on top of Neil's patch=
.

Scratch the fallthrough. On top of Neil's patch no fallthrough it
needed.  Content is the original patch, just rebased.

>
> >
> >
> > >       case nfserr_dropit:
> > >               return nlm_drop_reply;
> > >       case nfserr_stale:
> >
> >
> >
> > --
> > Chuck Lever
> >

