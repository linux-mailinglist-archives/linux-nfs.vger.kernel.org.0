Return-Path: <linux-nfs+bounces-15036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE637BC2513
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Oct 2025 20:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476F719A3C18
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Oct 2025 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC301F4606;
	Tue,  7 Oct 2025 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fszqNOqg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263143A1D2
	for <linux-nfs@vger.kernel.org>; Tue,  7 Oct 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860243; cv=none; b=SjEiy4QnZ7WzpMU7skLOckAMahkqgNWRIYxXlgOE6qCjDZ0A1lTBwhBkY68wH4YriJE10ZN4hP2M2JOxDnL1QDzCnTUw+i/FEQMhpFX5OoTfKZ83UuHFIusoZaho//vjpY8AC9sjpMjJkDYrST2c7NVv728iGGXEJIv468UKq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860243; c=relaxed/simple;
	bh=irbIGtUHkla8Ee+QodLUZf2nxI8tQYc5FQlPUmSc/7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNMlMpgJqtF0xSHor9lOYVrmGQKs9I56kSHoSSAE5ucC5koe/MYgJgJTGZBuXfCW57A6GTvEbRMuQhs6S9fy4SCSPjtsQLSU7FpYTiKvFLfW4Cl+rDcXjfNKxprrDAbeYydtFh4m3UG7q8pAjXzRRoQ4smxjx3PGC5PkgBm/68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fszqNOqg; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so12116399a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 07 Oct 2025 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1759860239; x=1760465039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FEsOjYws0RCtmGpSVPdZCIsOUQwPG418EtakfdXSgE=;
        b=fszqNOqgNMPmR+x7lZFGEjYhg71ZnJhwRtBKOI5cAC0Mt7/iQg1BJUlbyIENnWfdKK
         WJwvHMnLrZP4DfKUTqA5JhNcQeAJXuhx97CzkGgaZZjhEarRbxq6rixTqfNJwLi33Myb
         92/6xkCsAEbInJdU2/QV7LtVxjgA9zlCeiN2yg23cM6+k0Zc1Cqt/JX02bo8FT2QygoW
         /KoHugF07FUtTjhz71vuzo0nBRrKNJyJ6C+Eg178Vd1+GOnNcfQSry3dVjgSRFs+7+t0
         zR1YdJZrExSlnyozMjKigv9zYkj64bVURmL7wSsUn1ShBMuIFLtgJai2jMnEz+P/E+7j
         qqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759860239; x=1760465039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FEsOjYws0RCtmGpSVPdZCIsOUQwPG418EtakfdXSgE=;
        b=me5649ksm174pC9Vi5qOWwClWdv3aRWmxgwSVD+GGDC0vzBz6HniGhj8GqhaKg91lc
         y0XYAKzrYhQTR7q0KsiKAz173z/vQ9aYRfe/fy+41Vdke5Wvf2mWUyqRyI2hpaREPVzE
         1NrRCcxrJDBj5l4jElpM8KIWDYppPPfbM+omJ+OHLFjGQA734pNKovGnrJ9oX+SsnT+l
         qxijgRYPXhYVnxqf/ScZd7OoCwPFUSKOgeiADpacIRoFtFhJAtb1t8nUeIxWXQVU2m5C
         Z+l8k9osYXQNuz3mEExoRjN/ENv5sAIQK2d1bE1QAYlJuRYC69OHJIqcnY7LpzB7MvdS
         45DA==
X-Forwarded-Encrypted: i=1; AJvYcCX6WgA7bqKvB6ev2jcY73OFWJ/RjNFWSjlQKKEaQQnOGLmWMu3tCDW+5HNCkSfOXbvJ69a+EnfrmKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb1nKS0N2NpZ+74aOyGej4Bj5tA6ulzpUnS2UTeDep6+9GM5cF
	Mgb8/xalbSLOip43o71Xz+14RHs2mb0yGd3p6OR3O2TZat9gqVU62/JkvUssefZzZMVyIVkFO8Y
	2vD3/zb8qMimTiHQHYyPw/PpoyLk2REALWZnO3BAq+Q==
X-Gm-Gg: ASbGnctD+o+716VALCecMzpN20xjR2ZZgqSQEiIFG93YcLhSFf8rwOg/DJHvqacpp7R
	NSjyME+ARqM5nKJDkXPMz1cqN1jqF8auykHQ87OSc5ZyaARFnITO2nGkTZsctrmJdF1Af5xIj1/
	OxFbybHrctZA1wvdNVYYQ+sBwldtVdh8b3QDPNMLKD1h2WkrBNDXRnFyEi4m9+NywLO9l3Pagmf
	xlNVv81/dbeJLapeh0Ni8xNJ7qo4uTZFAZjPVAg0qA=
X-Google-Smtp-Source: AGHT+IGdgjsjmLAqUzPUIEfeHQeH6xNuWcSZRKB6PuzB2STF0BUlEw0q/GT6SqxpWsXyvXiMXmHAiDtU/JLa13maB3c=
X-Received: by 2002:a17:907:7290:b0:b45:a03f:d172 with SMTP id
 a640c23a62f3a-b50acc2f5bemr63469966b.57.1759860239475; Tue, 07 Oct 2025
 11:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924162050.634451-1-jcurley@purestorage.com>
 <aOUeDCzouBMwjalF@kernel.org> <aOUonNQRjYBpYcrD@kernel.org>
 <aOU7Yc8RnF4Eq65C@kernel.org> <aOVQORJe8DkQrHH4@kernel.org>
In-Reply-To: <aOVQORJe8DkQrHH4@kernel.org>
From: Jon Curley <jcurley@purestorage.com>
Date: Tue, 7 Oct 2025 11:03:23 -0700
X-Gm-Features: AS18NWBpcA6d1eLK6geeQcgBWD9Y2WXul0d-3wtCmwMc7qHpwOzkvX0ki3JLWdk
Message-ID: <CAHeb9+=4VRG58bxbcvdgusZw0rBxYwkRZJe8juVa-O1ptLNeMg@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4/flexfiles: fix to allocate mirror->dss before use
To: Mike Snitzer <snitzer@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM, thanks for fixing this.


On Tue, Oct 7, 2025 at 10:39=E2=80=AFAM Mike Snitzer <snitzer@kernel.org> w=
rote:
>
> Move mirror_array's dss_count initialization and dss allocation to
> ff_layout_alloc_mirror(), just before the loop that initializes each
> nfs4_ff_layout_ds_stripe's nfs_file_localio.
>
> Also handle NULL return from kcalloc() and remove one level of ident
> in ff_layout_alloc_mirror().
>
> This commit fixes dangling nfsd_serv refcount issues seen when using
> NFS LOCALIO and then attempting to stop the NFSD service.
>
> Fixes: 20b1d75fb840 ("NFSv4/flexfiles: Add support for striped layouts")
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
> v2: checks for NULL return from kcalloc() and remove one level of ident i=
n ff_layout_alloc_mirror
>
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayo=
ut/flexfilelayout.c
> index fedd7d90e12f..b7d2c0ef25fe 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -270,19 +270,31 @@ ff_layout_remove_mirror(struct nfs4_ff_layout_mirro=
r *mirror)
>         mirror->layout =3D NULL;
>  }
>
> -static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(gfp_t gfp_fl=
ags)
> +static struct nfs4_ff_layout_mirror *ff_layout_alloc_mirror(u32 dss_coun=
t,
> +                                                           gfp_t gfp_fla=
gs)
>  {
>         struct nfs4_ff_layout_mirror *mirror;
> -       u32 dss_id;
>
>         mirror =3D kzalloc(sizeof(*mirror), gfp_flags);
> -       if (mirror !=3D NULL) {
> -               spin_lock_init(&mirror->lock);
> -               refcount_set(&mirror->ref, 1);
> -               INIT_LIST_HEAD(&mirror->mirrors);
> -               for (dss_id =3D 0; dss_id < mirror->dss_count; dss_id++)
> -                       nfs_localio_file_init(&mirror->dss[dss_id].nfl);
> +       if (mirror =3D=3D NULL)
> +               return NULL;
> +
> +       spin_lock_init(&mirror->lock);
> +       refcount_set(&mirror->ref, 1);
> +       INIT_LIST_HEAD(&mirror->mirrors);
> +
> +       mirror->dss_count =3D dss_count;
> +       mirror->dss =3D
> +               kcalloc(dss_count, sizeof(struct nfs4_ff_layout_ds_stripe=
),
> +                       gfp_flags);
> +       if (mirror->dss =3D=3D NULL) {
> +               kfree(mirror);
> +               return NULL;
>         }
> +
> +       for (u32 dss_id =3D 0; dss_id < mirror->dss_count; dss_id++)
> +               nfs_localio_file_init(&mirror->dss[dss_id].nfl);
> +
>         return mirror;
>  }
>
> @@ -507,17 +519,12 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
>                 if (dss_count > 1 && stripe_unit =3D=3D 0)
>                         goto out_err_free;
>
> -               fls->mirror_array[i] =3D ff_layout_alloc_mirror(gfp_flags=
);
> +               fls->mirror_array[i] =3D ff_layout_alloc_mirror(dss_count=
, gfp_flags);
>                 if (fls->mirror_array[i] =3D=3D NULL) {
>                         rc =3D -ENOMEM;
>                         goto out_err_free;
>                 }
>
> -               fls->mirror_array[i]->dss_count =3D dss_count;
> -               fls->mirror_array[i]->dss =3D
> -                   kcalloc(dss_count, sizeof(struct nfs4_ff_layout_ds_st=
ripe),
> -                           gfp_flags);
> -
>                 for (dss_id =3D 0; dss_id < dss_count; dss_id++) {
>                         dss_info =3D &fls->mirror_array[i]->dss[dss_id];
>                         dss_info->mirror =3D fls->mirror_array[i];

