Return-Path: <linux-nfs+bounces-10128-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C139A3629B
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 17:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4409D3A9815
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2025 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B3626738A;
	Fri, 14 Feb 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="GFmZS64Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C09263F2E
	for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548726; cv=none; b=ioESAbsN90ePmuyUykxgFGX/DI7G5kjbGIvRcVsLXQg1TjLqbhgg0zbLPMqU/cSS6opWTCi+w/5LizaJrwvnC+aGgyHqTBfg5b+81+U+4WEajXlA9GnezfU1Fyy8/E8p3iSIr7SziLpFM55uvhjP5lkrwHCpgcNMNTHoyxFASjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548726; c=relaxed/simple;
	bh=df3m1DQgNk4DKxl1qdWJ5Z6rD11OrdFTEewc+9SI4Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BskxIQupB2aY+a/ruY4uSd9RPhYPYLvlqFaeQNde2sz9jEUPicfjcokXQ7r+XVKYWRG1QvkP3GB4Vv3Ylqz4ZeWY1WFQVLfAcjjmTs3vwe5a3j7Kef3AE743b7UmNd4vguPg8q/fN5Ff0cWDTPqn382Kh1x2EAUJSH+eTdVpgV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=GFmZS64Z; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30737db1aa9so21755771fa.1
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2025 07:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1739548722; x=1740153522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2CTbUd8eargW8yhhRYlpuc3DFClzXKMCw4CStjqJrk=;
        b=GFmZS64ZqfDuZrgg+LdTjiUmIbhVaUUDcWq283owc9D0mcQEx5Nkg+Otn+y2rfelI4
         wVzu8roXc7B0LfeONBjsJnm/qC5YXPhdfQNPbWifWvvefxpIK3RxbJNIb3VesxTqJZj6
         zkfmfiZgGkk1I3iDfnMWF9jqyzpSCiZ8vBLQUKe3WoQ4PrZfO8fYl7aukV0kiYcZIO5y
         yKM1t370s+nGp17fNTykngt8NFcXU6IbY/PhDQ3TRVuUnfpPrX7hoZ/kWL5lcEsK3/z4
         wf3xVoYmh0y3a+/YBzKeA5Ao3FvDuepyBYMASKPq2LacvzN+qtj4Er7bGv5p2X6wVYnl
         q1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548722; x=1740153522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2CTbUd8eargW8yhhRYlpuc3DFClzXKMCw4CStjqJrk=;
        b=QrA5Dl8DaJ+ZQq6UfSWYoIkLleKuusD87KkEBZtyES/ayBcDiuaVYzHIdYxO89LTfr
         kaiUgLrofLwA95A1fAf5qR/hv9YfPvdqrWhOwydmur7doP0XLOd2MF1HLnrX1OywdZ+E
         FdDMMV0u3MykR4Z9caLUN30AdpGe4JsJiGgJZaBigDf2JGtF0nKqtdFxjvGHyS37UvHm
         NP1Y2yp820fuVv8LwZupQYtmYkhha1HIB3H0uCDi1xbY4joiIZqJq6M3rzWM/DyFZN2H
         qQKfthOUilkdNcWUmB+I+qNU144zc2CwDt1MOjMSUZdX5odg9iwwvs0NHVGlZ8cQh2zk
         C4BA==
X-Forwarded-Encrypted: i=1; AJvYcCWnKpYXSRb70hiMMcXcdC9FeTqkUOn9/V2B2+6crQPj2s6yk6OlxivRmoftDczD6hgoxDpM3+YXZ0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy21pb2bDnivfr92jRVM+DT7A5bHDg/rVGnJzOuAk9qLmEq3QJb
	iKugJShVSoNT7SIRgNkRoC2e5qIg9Db6D+lM+KjK32WOhlL6T8ytsm3IurJsf4sqSa8g8CzUpR9
	GSrM9ZpLZ1S9/F04a7/doHpG9YvU=
X-Gm-Gg: ASbGncuskM1cAK+uIX2FVJlOZj9qgMugNSLTKqrV5bCE3ly4wFTyM2Qj7MOjZLxSQqD
	s55MFDpwswyefgX/EvEr1fCc1A2f6TtXmive5WLvemFpE1905DB8fra5MOgVw8N2V7b+vN3xxIn
	W90Ir49ULSXGU5y5BCglTpROZcuDPwtw==
X-Google-Smtp-Source: AGHT+IFS/Wn81zRBERxzR+bzUODHcumjOXzJ3KJTHM5UFeLoYcetcbuLWW8SlIzeYSr+dG3HQz6SGOd8YT2ciXHHs6Y=
X-Received: by 2002:a2e:a90a:0:b0:308:e26c:8928 with SMTP id
 38308e7fff4ca-3090369c744mr40590871fa.1.1739548722272; Fri, 14 Feb 2025
 07:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213154722.37499-1-okorniev@redhat.com> <c65ebd14-f7e1-45a8-9bc2-211440977ab0@oracle.com>
 <CACSpFtDjqhgmFO=pTY1ErZEhQZNgewo9ao+RuuGY3hm9CSqcqA@mail.gmail.com>
 <3966bb3b-50da-41e6-b097-704c56154f21@oracle.com> <CAN-5tyG9Z0yuCTSpG+-RCXXijt0q32XiLYFOvwhJXxcb=npkkg@mail.gmail.com>
 <1c361680-d315-4b7b-8418-bd2743c049ee@oracle.com>
In-Reply-To: <1c361680-d315-4b7b-8418-bd2743c049ee@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 14 Feb 2025 10:58:30 -0500
X-Gm-Features: AWEUYZnqP3HWTU3qcnJwN9ZW8ULv-3DmJpAa7VGgRQf794XH9eZvYKcL_SqztaY
Message-ID: <CAN-5tyEH-eNbWKg5_DV7Q_MeA5AeJ=w95VLCJTt+UuK2Ammc=Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfs-utils: nfsdctl: dont ignore rdma listener return
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, steved@redhat.com, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 10:43=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 2/14/25 10:38 AM, Olga Kornievskaia wrote:
> > On Fri, Feb 14, 2025 at 9:24=E2=80=AFAM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >>
> >> On 2/13/25 12:30 PM, Olga Kornievskaia wrote:
> >>> On Thu, Feb 13, 2025 at 11:01=E2=80=AFAM Chuck Lever <chuck.lever@ora=
cle.com> wrote:
> >>>>
> >>>> On 2/13/25 10:47 AM, Olga Kornievskaia wrote:
> >>>>> Don't ignore return code of adding rdma listener. If nfs.conf has a=
sked
> >>>>> for "rdma=3Dy" but adding the listener fails, don't ignore the fail=
ure.
> >>>>> Note in soft-rdma-provider environment (such as soft iwarp, soft ro=
ce),
> >>>>> when no address-constraints are used, an "any" listener is created =
and
> >>>>> rdma-enabling is done independently.
> >>>>
> >>>> This behavior is confusing... I suggest that an nfs.conf man page
> >>>> update accompany the below code change.
> >>>
> >>> Do you find only the rdma=3Dy soft-rdma case confusing, or do you fin=
d
> >>> that when listeners fail and we shouldn't start knfsd threads in
> >>> general confusing?
> >>>
> >>> It was always the case that if rdma=3Dy is done, then any listener
> >>> created for it does not check whether or not the underlying interface
> >>> is already rdma-enabled. This hasn't changed. Nor does this patch
> >>> change it.
> >>
> >> Not saying the patch changes the behavior. But you have to admit the
> >> behavior is surprising and needs clear documentation.
> >
> > Sure we can document the behavior of the any listener on a soft rdma
> > interface as it's used by the knfsd. But is it guaranteed not to
> > change, as the behaviour is controlled by the RDMA core not NFS?
>
> I'm talking about documenting the opposite. Something like:
>
> When "host=3D" is present, the network interface named by this
> configuration setting must be present (and when "rdma=3Dy", that
> device must be RDMA-enabled) in order for server start-up to
> succeed.

Ah that case. Yes, I agree.

> >>>> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> >>>>
> >>>>
> >>>>> Fixes: e3b72007ab31 ("nfs-utils: nfsdctl: cleanup listeners if some=
 failed")
> >>>>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>>>> ---
> >>>>>  utils/nfsdctl/nfsdctl.c | 4 ++--
> >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
> >>>>> index 05fecc71..244910ef 100644
> >>>>> --- a/utils/nfsdctl/nfsdctl.c
> >>>>> +++ b/utils/nfsdctl/nfsdctl.c
> >>>>> @@ -1388,7 +1388,7 @@ static int configure_listeners(void)
> >>>>>                       if (tcp)
> >>>>>                               ret =3D add_listener("tcp", n->field,=
 port);
> >>>>>                       if (rdma)
> >>>>> -                             add_listener("rdma", n->field, rdma_p=
ort);
> >>>>> +                             ret =3D add_listener("rdma", n->field=
, rdma_port);
> >>>>>                       if (ret)
> >>>>>                               return ret;
> >>>>>               }
> >>>>> @@ -1398,7 +1398,7 @@ static int configure_listeners(void)
> >>>>>               if (tcp)
> >>>>>                       ret =3D add_listener("tcp", "", port);
> >>>>>               if (rdma)
> >>>>> -                     add_listener("rdma", "", rdma_port);
> >>>>> +                     ret =3D add_listener("rdma", "", rdma_port);
> >>>>>       }
> >>>>>       return ret;
> >>>>>  }
> >>>>
> >>>>
> >>>> --
> >>>> Chuck Lever
> >>>>
> >>>
> >>
> >>
> >> --
> >> Chuck Lever
> >>
>
>
> --
> Chuck Lever

