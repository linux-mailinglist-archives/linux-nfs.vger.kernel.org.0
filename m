Return-Path: <linux-nfs+bounces-20759-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH5gCj501mkWFggAu9opvQ
	(envelope-from <linux-nfs+bounces-20759-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 17:29:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB913BE327
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 17:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBAD53036EC1
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDFD3D646D;
	Wed,  8 Apr 2026 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="URTLeKgJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2673D6462
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661905; cv=pass; b=DXzGP19UZbsfaYivZiR7D5y25afod6X5nAGB8MjMsKXr86aXmb8wvST1WDzxsd9hdmFLa8qp+3ZvESQFnwCCSziolg/bFgAsc1a2hvYenIj8PEZcc1+wAcHBJ6T97OPYHVkt+8UxX5IyPEAIdXxDQauxa9CmnSflisA0M3iTHHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661905; c=relaxed/simple;
	bh=LgE9puouhKgFPGBy/iIK7vehwu9BJk+fJ6X+vcdEdok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvNdQk1nVI7c3/TrM3MlQVIu6zVTOtNZnWWmwDB4pEgVJ0d1BrlqtobkRYD+mpCsD3cA247hEEljUwYjtylUwA6dT9Mu0/jxJBQgMCvaAB16BkpZ9KeASYQQayDEonUqfm8568QA7CQh0MDH/dQBGyuyrbrPgcYSESQGHZePbBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=URTLeKgJ; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a3be187ffbso1016249e87.0
        for <linux-nfs@vger.kernel.org>; Wed, 08 Apr 2026 08:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775661903; cv=none;
        d=google.com; s=arc-20240605;
        b=Qd9XuvU4HrjJzlw2luSOBwDgmkR30SxhKXf8U23dNyjEUXSBB5k3nPsIeCpQv5kgGj
         bmGFW7NRHxaNrp7TuIHgTx1AOHAngK2BgBanD0PZn+fnEvkENRic/epWOD3rhnrcAmzX
         X2aZ/Cc3SeFFPJiw4un+dQ3EuXgig+nsR+xXh6c6rbyOVBDbzlBe6ppp+t0ZfVFwWMd8
         SugGB7LIc/zVmS186dNJQ47Bp8GOp6uIUsVJqB9K5SFnpwpwUiOKD3QMeJhgx3UjBHTw
         RpTUtm+g9M82QLZAoVbo2Y50HjYhZOalihQzh25gL2baOk9mRA9bsPyBSFepQfF4lsMM
         97rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MAx74boWK5DBH4jbpZ71BiY1UUSW/x74a5MdjmyMyLk=;
        fh=vSTD0rdAp56C3IWLCiVhkbjhIpwIXG02sOt+YYSZrBI=;
        b=E3s9qi0C0st9emhXIWJympjBsraG+2gJ4l7gmTRUvBDdTXQNNsiBxY9rCSrOZNHQyy
         G0juGKGl0oMmfPnMAxQtjoaU0VqIS48V1KtnKx0qpD+Gs43ZVywJW0gCi5xM0RNtssl4
         0AEAj3WfuANeQGUvJ5ekn8tCMpfcpCMFGo6kHUMnmb1IZb+qTfgtOBBp/gmw2Cqn5Kj6
         GjaD0qfOFoFMPjsXrgEv5QKIn1VgkHfCgin7sBFcu5YCSbaVFIKxXXyO/85eEftsJhLo
         rnDfFEwGrUTpyXPi0NKKMLyI7Ka0Dwib1NVlidA8Epo+9lWVm3AKcdJN7JD3Cr1hGEvZ
         botQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1775661903; x=1776266703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAx74boWK5DBH4jbpZ71BiY1UUSW/x74a5MdjmyMyLk=;
        b=URTLeKgJZVMuN+BB6NpS+mwku+J52y76+rEzXWPa90NNFMaSAGpBcx6IC+4KI6hno5
         48TnKGraLCwfcZvB1WYI0vl0vYcUQHUUD6lMh3a22gX/xXfErtfuSWvpEImn+fxqvUq3
         ynT9lWkhPmiQSHCaWocAWD2m1Z85pFBKUiQgu6kQUePtk/od0wa9SwXR83sCln45LT9f
         L4KPmG4UYx35EWfE87TlRzFyc7HASRJQoYldrqqsTSIA6/aCcx1tXVc3J7F6ck+i9UVk
         rj9XxJbLGZ4rZvlk8+RvkNZwhAWyVvF9Zx6V+p0YntG9Kl+zb/vZIegXclVGDiatuLpt
         HcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661903; x=1776266703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MAx74boWK5DBH4jbpZ71BiY1UUSW/x74a5MdjmyMyLk=;
        b=pol6uIC6WvTsLegh6CGzCxV4WAotw+O0Isynd1A98m77lbl16t99OfqdI6x6tc2QT3
         Ko/w2ObDp/VQSvEJVK6x6c8CkpO+gqnUJez0l2iY/mEa2bjeh5I5PZFnJlBpzBfKR9mU
         qGbGHn7+h3TdJtADlY+al3pG4IZi3d041dAmpow8YwNGxLrK0SrMeua2hcYgRvlXnTt3
         6eOXFNHnsFkTVqR2+hzdlLyMo/u4+JlE0kqqyQvsSdl8kMWFM2ouh/mlm5swn/EVEOU6
         wtwsOYe3KcB7LWxYIbiyi3vR88aVpdM7iD8cgBdCNPOFQnQt9JahameZ4Y5DTz4xFsRw
         7cTw==
X-Forwarded-Encrypted: i=1; AJvYcCUZSVr67etm5XdXu9DJqrxjSxPwkhRCCFgZZcsPNvKP1W9Wd9KrExcuCcWzEUjvXhhMK1PqcmbOqHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ITfx6FWhHDDSmzKMEdNNp+ZVYoOZ9UXF0jVUQD7ZAKIvakeM
	ksEDoVFIyi7CkZxaDlcYiyLKH9Sin/eL3Nhl7tSmd7bKm/aFf9M1qUwQ+iAuwAW6AonlHUwub/Z
	B6A5a4GcMhsrMZwt/KMRiHQmRsem7voY=
X-Gm-Gg: AeBDieuCqAwp0rpzzmqy5Krn2MG896jEniRCeDAyQ1CoJYk8k8okwFwkkZidKX09jHi
	V6gXSoMsCKbK665zGCzdGNhwfqa6ksS+XHyuUnlj0Je2zx5QSib87TBV7OQHFw2/NlOjY5Vo50j
	RL/m4+fdW6/9qYMJgNjdv3AGsTfr+JRi0UPUtHoj1yoVbHuRUSb5ITTaWXX2bRfvrxs/E1rFhlR
	g615Uq1DEui9IfRXCgDhLRINbhtJj8fuV0pq4w6gsZ92Mkzup8wfLTcGfPKlcPO87bf+aCeEvYw
	6vesbNOkSoZRPu7IkyIx5WENHygA4ZRr8U1YNDmwUg==
X-Received: by 2002:a05:6512:10cd:b0:5a2:a70a:a9e with SMTP id
 2adb3069b0e04-5a2c8a95465mr10333930e87.3.1775661902380; Wed, 08 Apr 2026
 08:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407235038.55749-1-okorniev@redhat.com> <20260407235038.55749-3-okorniev@redhat.com>
 <c79b8e38-cc5c-436f-8145-2213dc1256c0@app.fastmail.com>
In-Reply-To: <c79b8e38-cc5c-436f-8145-2213dc1256c0@app.fastmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 8 Apr 2026 11:24:50 -0400
X-Gm-Features: AQROBzC0c2zoXAA-nTmXsG6Wd6gs0P5QouRryh6pvxb2_nMtSoeAz7XDVYfkd3k
Message-ID: <CAN-5tyG6JFJ=e9Jkmk0TnzvszWXVneDnDaceA_AOhDtK=ScVog@mail.gmail.com>
Subject: Re: [PATCH 2/3] nfsd: update mtime/ctime on synchronous COPY with
 delegated attributes
To: Chuck Lever <cel@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, neilb@brown.name, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20759-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[umich.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8AB913BE327
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 9:59=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Tue, Apr 7, 2026, at 7:50 PM, Olga Kornievskaia wrote:
> > COPY should update destination file's mtime/ctime upon completion.
> >
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>
> Should 2/3 also carry a Fixes: tag?

My bad. I guess it should be the same as the first patch. But I now
also wonder if the update should be done based on the status of
nfsd4_do_copy? But this is where I think nfsd4_do_copy can return say
ENOSPC but it would have modified the file as well. So I'm not clear
if we need to special case return values?

> > ---
> >  fs/nfsd/nfs4proc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index fb891e35ebe9..04d8d0d1ca7d 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2211,6 +2211,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct
> > nfsd4_compound_state *cstate,
> >       } else {
> >               status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >                                      copy->nf_dst->nf_file, true);
> > +             if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
> > +                            FMODE_NOCMTIME) !=3D 0)
> > +                     nfsd_update_cmtime_attr(cstate->current_fh.fh_den=
try);
> >       }
> >  out:
> >       trace_nfsd_copy_done(copy, status);
> > --
> > 2.52.0
>
> --
> Chuck Lever
>

