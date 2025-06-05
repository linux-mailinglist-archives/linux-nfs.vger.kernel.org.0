Return-Path: <linux-nfs+bounces-12117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D26ACE879
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 04:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561AD3A9E53
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 02:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C121B4153;
	Thu,  5 Jun 2025 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XST2irsD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F34315A;
	Thu,  5 Jun 2025 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749091840; cv=none; b=DpyFdsyVOQ79qSTgHjwdTCbiloj4+TAgKkMCA7wmKNV7KaUy4/VKA+Z9rlAIHJx7oeRykqFEI6iujb5zPW4XAtfRWqU2aO+/QwowtvXhNwslxmT1h5fTu9l3izPpcdNN7Ja1zn2zoWBSqDhMSqmANyOOQG9db2V9p/gcy7oxkw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749091840; c=relaxed/simple;
	bh=a0lA6W01R2d3Gmb2vP4nAHBWwF2STpi2fu87B2V21c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHKv/BF/+qTtyr5/B2i0RmnbEBQSxhfESCzKEM1DbFRpb0WOZhmyM5dR1UfMOLxuEkDj88Bm4nipnZ3CjCsqzqTcY1f84bC3v3aQqFusQQWfdP/bJydWVVbTa6KOnPeYDwXQeXKxAZbAfunN3q2n21ojnJV8yTY3sLbfQsNZeVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XST2irsD; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476a720e806so4386011cf.0;
        Wed, 04 Jun 2025 19:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749091838; x=1749696638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TszH0hbfOo48Nx+Sd/ljYNEfxo2zQCreYc54y4+hX1k=;
        b=XST2irsDUNoXQf1gIcSfVWgjSLEVMwCCFVwELILw1kx/jX0ThZC+O9xSfjaeA9tr8I
         VA6kva2N5CSHM5IrnhLrS3u/82xwxRO8DleIs/dRtxYmfpOycvfry+A/zUmc4cSgwD3I
         UPfwUe3hlPV2TP2JcI68XVUmAVQgK6yP3itpKrBFaodw6Wq+EwiwjpoM/sRnpK33m5B1
         djvIpKAnyXrowcOOlPOICuOaZCrSO/WKWbJORJT59E9pdSHURfbXiAL1mQ/VfIMGFlaS
         1DKC+eAKq++3U4EJn2XIcOtF78Dq0S9l6bJ2zfeZlMa0IwlNx5yCRde6z89hxRribu9z
         YjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749091838; x=1749696638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TszH0hbfOo48Nx+Sd/ljYNEfxo2zQCreYc54y4+hX1k=;
        b=dBynZpp8HIdUIV94a06lvJrjQIX+iZ5TWVMjmiDbHh0aWI2XX5zx+mmkLOFuVQ4baP
         cXs/1XwY0emh7+N0y/r9C4tkIUCnIhuX84XTDOJbnRUIpY9yrNUsXqDrt+HrXS4FQau0
         IAa1c3mmkseEMISmtdRLy0FbLXOjH4suxc+Q+Xecfs9qyUIi4gOqLjcpTFglfjJehKdF
         Obtn8X37VFVc0LwcvlFwC3Uaqub5CgVPjJtvsyOntO1f0VFS/z5oxwob56pIgKFTavaV
         NjVL/+gnd9SvbB9QtggB52f8zaQQObxu+WQmXQgvtvjwdJqbcBjekEMXMAWaHJeM2AAf
         ZGGA==
X-Forwarded-Encrypted: i=1; AJvYcCUi3Xipi1yebs7M+LHdRet9Z/hqekPh+ozIAlAPaIZwMJrENMAK4Rj1MYCYygpHmD4Dr9QryA5m2hmk@vger.kernel.org, AJvYcCWqi+JlwBH+zofGixPkKO78L9CLH7rVC+3/cJsPEVnwDJYtrKpkqZjIrfA70ZKw2RocBHm58TKde0gC0TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjLB0KITRN2Mey74282SIyZkAh2+xlTyWB96i1aYiQ/9pteQaN
	LzGqOOgO53dLcymQzdLzvaCqatU/oqb/CwannkiySERpAoBiAyMKXiwJ8KbSuiRUGeNXBJNz6Gh
	1WrkeWGUVuHq2XHYXpMEjd1owQH3xeHI=
X-Gm-Gg: ASbGncucYhuSp6kfakg2QnGYAaEHtxbfS9YBU71uFRwONQ7BOyiH40Yn7vh/cMEnw91
	0fijSBKWe7A39JG3HtBco8UTK1Q3/4pIP63IbLWmkXxfSUvX0DQaQT1YhsUr42I0BjWEn/nyYeB
	FG73XhqTLTpHKqElx4FwTY4kI4nk9PnLl/+UTpbAOSgi8=
X-Google-Smtp-Source: AGHT+IGyPSRFffvnJ94uVKh8wE6ujjAeqWJS1x4BZTCbP+QFhtzsndUYiALZ9ZDytT6yCtI5W08uwkboUZeuG0lRC2Y=
X-Received: by 2002:a05:622a:410a:b0:4a4:4da5:8b55 with SMTP id
 d75a77b69052e-4a5a688be84mr81253291cf.28.1749091837149; Wed, 04 Jun 2025
 19:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-testing-v1-1-e28a8e161e4f@kernel.org>
In-Reply-To: <20250604-testing-v1-1-e28a8e161e4f@kernel.org>
From: lei lu <llfamsec@gmail.com>
Date: Thu, 5 Jun 2025 10:50:25 +0800
X-Gm-Features: AX0GCFuwn0UYns3XiHPhlUCQ_zxWymZcS0BQFNWljKG_oprk8ZsjwY8-CnxikX8
Message-ID: <CAEBF3_Z_J6b4xJwM6k_SX4EjEGvOAmRTH1_KLd+1fk_027LWVQ@mail.gmail.com>
Subject: Re: [PATCH] nfsd: handle get_client_locked() failure in nfsd4_setclientid_confirm()
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 12:01=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Lei Lu recently reported that nfsd4_setclientid_confirm() did not check
> the return value from get_client_locked(). a SETCLIENTID_CONFIRM could
> race with a confirmed client expiring and fail to get a reference. That
> could later lead to a UAF.
>
> Fix this by getting a reference early in the case where there is an
> extant confirmed client. If that fails then treat it as if there were no
> confirmed client found at all.
>
> In the case where the unconfirmed client is expiring, just fail and
> return the result from get_client_locked().
>
> Reported-by: lei lu <llfamsec@gmail.com>
> Closes: https://lore.kernel.org/linux-nfs/CAEBF3_b=3DUvqzNKdnfD_52L05Mqrq=
ui9vZ2eFamgAbV0WG+FNWQ@mail.gmail.com/
> Fixes: d20c11d86d8f ("nfsd: Protect session creation and client confirm u=
sing client_lock")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> I ran this vs. pynfs and it seemed to do OK. lei lu, can you test this
> patch vs. your reproducer and tell us whether it fixes it?

Patch works for me, the issue is fixed.

Thanks,
LL

> ---
>  fs/nfsd/nfs4state.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d5694987f86fadab985e55cce6261ad680e83b69..d61a7910dde3b8536b8715c2e=
ebd1f1faec95f8f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4697,10 +4697,16 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>         }
>         status =3D nfs_ok;
>         if (conf) {
> -               old =3D unconf;
> -               unhash_client_locked(old);
> -               nfsd4_change_callback(conf, &unconf->cl_cb_conn);
> -       } else {
> +               if (get_client_locked(conf) =3D=3D nfs_ok) {
> +                       old =3D unconf;
> +                       unhash_client_locked(old);
> +                       nfsd4_change_callback(conf, &unconf->cl_cb_conn);
> +               } else {
> +                       conf =3D NULL;
> +               }
> +       }
> +
> +       if (!conf) {
>                 old =3D find_confirmed_client_by_name(&unconf->cl_name, n=
n);
>                 if (old) {
>                         status =3D nfserr_clid_inuse;
> @@ -4717,10 +4723,14 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>                         }
>                         trace_nfsd_clid_replaced(&old->cl_clientid);
>                 }
> +               status =3D get_client_locked(unconf);
> +               if (status !=3D nfs_ok) {
> +                       old =3D NULL;
> +                       goto out;
> +               }
>                 move_to_confirmed(unconf);
>                 conf =3D unconf;
>         }
> -       get_client_locked(conf);
>         spin_unlock(&nn->client_lock);
>         if (conf =3D=3D unconf)
>                 fsnotify_dentry(conf->cl_nfsd_info_dentry, FS_MODIFY);
>
> ---
> base-commit: 5abc7438f1e9d62e91ad775cc83c9594c48d2282
> change-id: 20250604-testing-8d988ff48076
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>

