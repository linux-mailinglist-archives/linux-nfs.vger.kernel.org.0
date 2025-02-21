Return-Path: <linux-nfs+bounces-10279-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAE6A40073
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 21:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E403AA4AE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 20:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3423520DD63;
	Fri, 21 Feb 2025 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qs/tNZAE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813EB1FF7CC
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168640; cv=none; b=cy5xSRgDE2qTy6IIBvVJFmbaXtuuUAleEPB++Rn/nMtYJz5K1PHcZwxsri95Ztw+I49c1z/ESFoxgVnf/HQuYTYgrASdO3c7+XnMfv9hHsqW2NO2uZFc4MyKQ7Vlf6Qv4NQiOiSACt2aVcNOjuJSJiN5/ttBWbOykKmXUyu5XDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168640; c=relaxed/simple;
	bh=0rsFWbfgTiXpPgGhvo6Vd//Moya6c6WGDhf5n+zOyIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5RYKd0Gee8jntofIXRg7s2qACIJAy0Y8fMTENH72h7QLW+MLf5tO6klfmLYZNptbUmIbNphK5XZoHgDHJpmG9XAyE67M8c0q+Csiv+2Cr1830iI/00AOQJ3fBhwIybiiUM6Qc2B7DUWx1bHLXxGRwed1uqlgU6JKQ+jDh/VBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Qs/tNZAE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f8c58229f1so22593287b3.0
        for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 12:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740168636; x=1740773436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaCf3Nlma4jhclSMBPLprOYEntDDJimnOy91mE59VbM=;
        b=Qs/tNZAELsqHuQ7+DOuWIUa5E2F2cNm7wjrC3bBftcjEn8NoXIFKcXiwf6VAOIe3Fq
         Lxuey9wekDZTb0w3IqyICX0+GnSJJemN9Rj1bi1An4V7FbdFzT6OWW/ZL37zwqeSpvRy
         iQPz9aiqExWVgXnRsW7tXYH8tYXJ+/c1jhd8/fCn8KopSOkGoAXWDklHK9kA9AvSD5Ix
         IY3q4FSRZvVfV4s7iB6NLPsi/F/lsFCZIJfXX9H1fC3tjcUM4kjpFNrFTw+0uLyLOeQP
         6p9D2/mKlKy3VYTqVxBjDWJcdFCKrZPIGPKkRUFV8eH44A2pls1TAK9UXJI+vSTYY4fD
         XyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168636; x=1740773436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaCf3Nlma4jhclSMBPLprOYEntDDJimnOy91mE59VbM=;
        b=kwbTmSwu9ZzekXEOm4+5uXH+lyABLvwgu+ZjGicwpvwX1KkyEs6ktH2Qg/9kdIkPVY
         AIXmM3idxfDGYQx4Qo2s6BqDLCk9XSA23VVi0Z4xnsM5GY3ICkGUJKBV1rK2dmmn8KB2
         UzvjIsEF1jEK9oPOHIKhEnDwJS74uk40NMbizoMcFpUMLYUuw7hC95/JfeAQetkt42bD
         srj1dRB8lAaOLLYvAin/wId74Ri2WSnYC0zCOk62l+q8TE418JXX+SQhVhRH/4vRg5xo
         2J0H663WqS2gIFMPo7UzLSSvd7C54npntpNnat8OgAXPn1rcWsc/dVcMwODMl59XOfEM
         Z8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYXusolI78io0cS2MAKqPvZ+SwYJFFbAJ2WXkJLn43zwdZ5nwQaUSBlNnR7d65lrZvbwA5SD21k0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wLbHDiZuxWZfx9TApEfVL3/QYien4bgxm0RP3i3yUxikYmCJ
	OFRJTXR7F5U9FcOrfHGm8s2K73j0yY/MWnVm1QUSdW58IPusA+OuE63cOLR5ZSgNVW3mWwrC84+
	etUJHI/keRj4mcaoTzGIDyMsnpDP6kAM4OZkjTu2iajhG2eA=
X-Gm-Gg: ASbGncsqKtC6tOBj61OEGKIDymzcsx1+yT2M2Jb+2U/Q6ggam6xGA9sK9dFI+QX4VPr
	qVu2x0WZFteTqBzmG8u+8/fe1NiLzcAFqpdTppXo9QNEd18NSlMOfS+nRgwxcIH8VFlOtrtF7sa
	wltEGHtAo=
X-Google-Smtp-Source: AGHT+IGJ6WUSGWMlvQaaMBPornBmHZRLTtYmy+VqAG/63ZzTIy7EnyeaK4tR60QDpG/AdAkgnXUMxu4c+oIbQpmtkDE=
X-Received: by 2002:a05:690c:6a0b:b0:6fb:5d74:959d with SMTP id
 00721157ae682-6fbb78e24b0mr86105137b3.1.1740168636452; Fri, 21 Feb 2025
 12:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250220192935.9014-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Feb 2025 15:10:24 -0500
X-Gm-Features: AWEUYZlovKsb92mRh54zinleno1McLdTKKAdDUJL3DfgkvZ0swMtLqj-gMAvJmQ
Message-ID: <CAHC9VhTXzweNA+h37ZBMjymbuar32tmr4aa9Qphk8JM4ya+y0A@mail.gmail.com>
Subject: Re: [PATCH] lsm,nfs: fix memory leak of lsm_context
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, 
	casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:30=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> commit b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
> did not preserve the lsm id for subsequent release calls, which results
> in a memory leak. Fix it by saving the lsm id in the nfs4_label and
> providing it on the subsequent release call.
>
> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  fs/nfs/nfs4proc.c    | 7 ++++---
>  include/linux/nfs4.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)

Now that we've seen Casey's patch, I believe this patch is the better
solution and we should get this up to Linus during the v6.14-rcX
phase.  I've got one minor nitpick (below), but how would you like to
handle this patch NFS folks?  I'm guessing you would prefer to pull
this via the NFS tree, but if not let me know and I can pull it via
the LSM tree (an ACK would be appreciated).

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index df9669d4ded7..c0caaec7bd20 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -133,6 +133,7 @@ nfs4_label_init_security(struct inode *dir, struct de=
ntry *dentry,
>         if (err)
>                 return NULL;
>
> +       label->lsmid =3D shim.id;
>         label->label =3D shim.context;
>         label->len =3D shim.len;
>         return label;
> @@ -145,7 +146,7 @@ nfs4_label_release_security(struct nfs4_label *label)
>         if (label) {
>                 shim.context =3D label->label;
>                 shim.len =3D label->len;
> -               shim.id =3D LSM_ID_UNDEF;
> +               shim.id =3D label->lsmid;
>                 security_release_secctx(&shim);
>         }
>  }
> @@ -6269,7 +6270,7 @@ static int _nfs4_get_security_label(struct inode *i=
node, void *buf,
>                                         size_t buflen)
>  {
>         struct nfs_server *server =3D NFS_SERVER(inode);
> -       struct nfs4_label label =3D {0, 0, buflen, buf};
> +       struct nfs4_label label =3D {0, 0, 0, buflen, buf};
>
>         u32 bitmask[3] =3D { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
>         struct nfs_fattr fattr =3D {
> @@ -6374,7 +6375,7 @@ static int nfs4_do_set_security_label(struct inode =
*inode,
>  static int
>  nfs4_set_security_label(struct inode *inode, const void *buf, size_t buf=
len)
>  {
> -       struct nfs4_label ilabel =3D {0, 0, buflen, (char *)buf };
> +       struct nfs4_label ilabel =3D {0, 0, 0, buflen, (char *)buf };
>         struct nfs_fattr *fattr;
>         int status;
>
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 71fbebfa43c7..9ac83ca88326 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -47,6 +47,7 @@ struct nfs4_acl {
>  struct nfs4_label {
>         uint32_t        lfs;
>         uint32_t        pi;
> +       u32             lsmid;

I don't think this is a significant problem, but considering that
lsm_context::id is an int, the lsmid field above should probably be an
int too.

>         u32             len;
>         char    *label;
>  };
> --
> 2.47.1

--=20
paul-moore.com

