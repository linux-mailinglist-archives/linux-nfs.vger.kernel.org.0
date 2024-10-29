Return-Path: <linux-nfs+bounces-7557-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65F9B525E
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 20:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C661F23F84
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 19:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFEFDDBE;
	Tue, 29 Oct 2024 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="llWMiwyH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969C20604D
	for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228589; cv=none; b=GkY6hKV0+UHBN52tcANNpUscnO4ktphusz3mc6M0jxpnVvnOyZ8gJKEn80OkjVHw3T5vm8Ummv6AaDvxdjSLmV1SdKHykCPj1X6DhHYAcVurxbQEAoJ5A/rhsZSlewyYgMMYedS04lR46sCOzqi3KsiIrfkH86awCRSVfjCXtxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228589; c=relaxed/simple;
	bh=ksupjrg9nlwmsrtTL5/tqaAqh0hTHO8mAOPZZdbdIMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nP5+CWs9N5ClYNkdxBPsMgoEk0OkWURB7JPx9Th/Z5EkQRIRTSbSH6ZWutuyDmtC/1kBZHCjCNlYp+2SiBzmEuAg47R7Wh+ewKtur6aG+w9hV+cyttYo5mZ6793aYUH5toTYB2BNHEGoWTCKOvbOxPP3lgG5Pup7Dd2jhkZRlgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=llWMiwyH; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so1280021fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2024 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1730228585; x=1730833385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqRkF7pgW5aL61BtB8mO7ekNvbFH8EhFDDPQKJi27Nk=;
        b=llWMiwyHCuL2ZKr07nGbZd+Dnbpf0cb65oAkfCcmSX+kRFmbLJ/rKAkKY8J0H/i0Hu
         Zaz3BWPXWPpqmMCtbwYyFOdHefgioOp0P5kLhAQqBr6Zch02QEUpl8HLEZj6ySzDTB9C
         Ht9IMUG13XMeskr8Y2aPmmVdDh85MqJJ8tGD4np4BwvGRwlyuEeGBXlitCeGDyFAGuPc
         5bqBRgUsmZXXt3Jy2JxIm7IiNtd/z5KPhInJG0R8nh0Qsk4nNm/z9yEoLLZog++VA/MN
         P0a8D3HerAdTiHmEmbuwbfsElHZ1I1YBkx6YNDZg2KzI4xs7eT1/853BIpedTE5mhiNi
         c5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730228585; x=1730833385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqRkF7pgW5aL61BtB8mO7ekNvbFH8EhFDDPQKJi27Nk=;
        b=TC73HspCxwy49EkkX5lzGRFQZLoh41RagEWVpmCzo4n2fKMyWwI6lqnLtJjTxtzeFV
         eqlnYCM/LGuxiv5Et73DLf3bZ4zfjRAflhHIZ1R+8KYAQW0e0vpMq7NWzeNGno/i5GOS
         SpGR3iDGRRYTZJomO4x0EAk53HnicWl5vpy3mA3Wjf8wJd+nU0GOQf9rJrw83NfInDq3
         /B/BwucNH+XXHeJ7/KGnszXJ/RGVy9/JyPsTv6OupJPlZh1KMUtWXc9OMkOrsFuTS2ax
         s8HwS62yDxwMeMoB3OwpEzquGDgtOABbk4hoKUyUa5DJO5Q/gLBVU/XSsLA6vI1LEp5w
         khtg==
X-Forwarded-Encrypted: i=1; AJvYcCX2OwH6Ec64ORAbgF52wtpN/wcITJLbbxCVnVxbqPlBbXU7okC4dTynyzaS6wfVt0rM3Y1opPpLwEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoeRTawwfeWmIHSSLOKsLAPJJD/WK0BkmU9cC0Y3JjwNZGXpTC
	pfnahYXDLBQuraM/V6aTAjKb2MeM8N6sC9aNNVT0DUY3ftWwqdtLlkTBTyfEGGpNgRrALY0uocj
	3YgLx0zX97k1m/Uht3LedkAwvGRw=
X-Google-Smtp-Source: AGHT+IFPEe7F6JLJTIWCyFoTKlsiycKdDKUoKSAqcB189KjJbgv7yjl1buXc4D8CdCkXopTKhznOaW9qdWVGgazUEZ4=
X-Received: by 2002:a2e:bd84:0:b0:2fb:569a:5543 with SMTP id
 38308e7fff4ca-2fcdc80b29dmr11024211fa.19.1730228585057; Tue, 29 Oct 2024
 12:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026160237.4304-2-cel@kernel.org>
In-Reply-To: <20241026160237.4304-2-cel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 29 Oct 2024 15:02:52 -0400
Message-ID: <CAN-5tyHLTzt4O-gKasjxWgEJc3S9MZ7b=uACrmQX56kv+ibbXg@mail.gmail.com>
Subject: Re: [PATCH] NFSD: Initialize struct nfsd4_copy earlier
To: cel@kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 12:02=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Ensure the refcount and async_copies fields are initialized early.
> cleanup_async_copy() will reference these fields if an error occurs
> in nfsd4_copy(). If they are not correctly initialized, at the very
> least, a refcount underflow occurs.
>
> Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY ope=
rations")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index b5a6bf4f459f..5fd1ce3fc8fb 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1841,14 +1841,14 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
>                 if (!async_copy)
>                         goto out_err;
>                 async_copy->cp_nn =3D nn;
> +               INIT_LIST_HEAD(&async_copy->copies);
> +               refcount_set(&async_copy->refcount, 1);
>                 /* Arbitrary cap on number of pending async copy operatio=
ns */
>                 if (atomic_inc_return(&nn->pending_async_copies) >
>                                 (int)rqstp->rq_pool->sp_nrthreads) {
>                         atomic_dec(&nn->pending_async_copies);
>                         goto out_err;
>                 }
> -               INIT_LIST_HEAD(&async_copy->copies);
> -               refcount_set(&async_copy->refcount, 1);
>                 async_copy->cp_src =3D kmalloc(sizeof(*async_copy->cp_src=
), GFP_KERNEL);
>                 if (!async_copy->cp_src)
>                         goto out_err;
> --

No more warning after this patch when we hit the copy limit.

Tested-by: Olga Kornievskaia <okorniev@redhat.com>

> 2.47.0
>
>

