Return-Path: <linux-nfs+bounces-14840-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C4DBB11FF
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 17:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039BA179341
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE281FCCF8;
	Wed,  1 Oct 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhyWwqSH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E82045B7
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333349; cv=none; b=gYqwSIEB89F3PqCzoLFeMqVyyJkj++cqLs7CUlestTFiwqwd6mQ5IRyzuXXaIsHDBduks1Eu0j9iUC3SKYMGpBWNBQIWhIKSXAPYVp3XIU1VCSPMY9FMFp2lSY3krkzmOzyOnT9axAfxr/6sgj70Zv5+73Zs9mUlqV7/nN7GAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333349; c=relaxed/simple;
	bh=XwthDmNjZOVOip85brGRBVh5c6oQ574jn8cOVUPRqMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=I0PRZrJVR8pyxG68Lbw2GPjVbKm1ZUBrrMlj0kNa2HrQZBui9UJNnKqZXhpd87w8+DtxRgBCmGrZAt106cGdgVlYhM81XLj2VawQkkluLT01QUIzRXGnsZ2+WVwrgLmfw2lwMSdwM423oIVF9NH6dvpfwwb3cEwsmtR58UbNruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhyWwqSH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so9191a12.3
        for <linux-nfs@vger.kernel.org>; Wed, 01 Oct 2025 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759333345; x=1759938145; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLYH1ITzgWr0wLx2rtJ4tavPx2V4I25urxKsZIyeVSQ=;
        b=AhyWwqSHZok0bG4yPUPkQEfe4dt3Qfpp6QBtG4FRA+8+xWoWYFuVwOc9o1pvA2RLCs
         rgnYYi/n2BPNPZzZ/HLBDI8U8ep4ckpXMQbwQFa4uxj6ZLMJQanBsj87MzOGCPDlebQn
         +LmNrXXxdXiXugYujZvAE9laGbk/clqIxgEzuEvrE/XQSY+MtMyUrpPByuSIX4H79pKr
         SfltEzDwZXqdjITFmml8AOEuycpdsGAZ6CTwHE0oOcFcqk+mWOe3bg+9eN57z5rlOlD3
         vA4hgX5PUmihmVXf4D0Gn90nxfeLgNUO3/8+6rEfWSkchbKHdamWz5waKegLPiooX3ve
         j2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759333345; x=1759938145;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLYH1ITzgWr0wLx2rtJ4tavPx2V4I25urxKsZIyeVSQ=;
        b=EJX52vUlbOzVy54CKoluhTIMbrwaFqL1T10FVhIz5UlmGcvzbjMQsBiTlSybZ35CDf
         WRfUTmkgU/1l9uRQKCPZjnrygsguoFHrAOLVd+dXbZP8dFOL6+lOGjEzg4gnc19+3WS/
         gwQteAxolCJ2JD6Svj2HHxLCrTOumU+xD41/6lCW4riX8fJHSMHQZIQKaGiJbZhGTktA
         mXLg39ysd4/yaILbS9yZ0uXxBygMbZZu9SqhvCfgJKvj0B8W3t8SQnZbNMaykliDTPbV
         zelx8y5vUzuRHrn5TG7JDciqAWYUJ792oyKEeMZuxzAgDAKZGx11DNprAe+4Vzf9QEhf
         S9mg==
X-Gm-Message-State: AOJu0Ywx2Ff0GsO2ap90rKsgsRY7YdK+oW1VKVExNSR52NZV0XFkSMcE
	idtlRo7EP5u7J8b3B0p5n+0mToA75rlTucJV/tAKycOUqZeBxS3T7mPwaJIe7Kx2BcGOTshiuUs
	d6ZN6WqqCLv2FnRGrw1xn2mMgHcnXVVd0vg==
X-Gm-Gg: ASbGncthdrRP4RJU70dHIf0uqQzHM3QeFKxW899d7ndWryy28CFxaOuKXlOXQ/r+XbJ
	7suHdAO5KWpWgqwioSpBjg01NwhacGL8n7LEcoZThXGhdFXET9Bg11aXVt5vdEf4lD/qweK8V3K
	jaKMyXOijo1yEnn6kUmYiadSCq7eVIdOX3HeRQOUTuu2THlJkmZ3C0jTt9uokCNEcYNfwhwtn70
	OXLu/3MBJRX3TtP9lazr2sWaN6nQcU=
X-Google-Smtp-Source: AGHT+IEsvvcRBNsfJcmmwfSXM4QuRWqCcuYnDrLUI6fudT5GEogrS/ITMVEHtR8/qd9HJfnuGcKEaAPw3oKqKAwzJIg=
X-Received: by 2002:a05:6402:27c9:b0:634:b5aa:dbca with SMTP id
 4fb4d7f45d1cf-63678ba7104mr4849369a12.6.1759333345411; Wed, 01 Oct 2025
 08:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001132431.9882-1-cel@kernel.org>
In-Reply-To: <20251001132431.9882-1-cel@kernel.org>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Wed, 1 Oct 2025 17:41:49 +0200
X-Gm-Features: AS18NWACGK44sHzQnrw6use9y2UCUqTOCcbYx1uA1NKAsT-Uv8Dzlfur9F0y9Jk
Message-ID: <CA+1jF5r0-dd0-VKG8W0DbeJZBhFV9-yQ2dsVEh+ZQcgkPATNPg@mail.gmail.com>
Subject: FATTR4_WORD1_TIME_CREATE support in NFSv4 client still missing? Re:
 [PATCH] NFSD: Update comment documenting unsupported fattr4 attributes
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 3:27=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> TIME_CREATE has been supported since commit e377a3e698fb ("nfsd: Add
> support for the birth time attribute").
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfsd.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index bdb60ee1f1a4..6812cd231b1d 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -395,14 +395,13 @@ enum {
>  #define        NFSD_CB_GETATTR_TIMEOUT         NFSD_DELEGRETURN_TIMEOUT
>
>  /*
> - * The following attributes are currently not supported by the NFSv4 ser=
ver:
> + * The following attributes are not implemented by NFSD:
>   *    ARCHIVE       (deprecated anyway)
>   *    HIDDEN        (unlikely to be supported any time soon)
>   *    MIMETYPE      (unlikely to be supported any time soon)
>   *    QUOTA_*       (will be supported in a forthcoming patch)
>   *    SYSTEM        (unlikely to be supported any time soon)
>   *    TIME_BACKUP   (unlikely to be supported any time soon)
> - *    TIME_CREATE   (unlikely to be supported any time soon)
>   */
>  #define NFSD4_SUPPORTED_ATTRS_WORD0                                     =
                    \
>  (FATTR4_WORD0_SUPPORTED_ATTRS   | FATTR4_WORD0_TYPE         | FATTR4_WOR=
D0_FH_EXPIRE_TYPE   \

What about the Linux NFSv4 client side patches for
FATTR4_WORD1_TIME_CREATE? That support is still... not there.

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

