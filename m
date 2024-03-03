Return-Path: <linux-nfs+bounces-2145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC91786F50F
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Mar 2024 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56368280C8B
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Mar 2024 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E537C153;
	Sun,  3 Mar 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh3Flypp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79935BE5A
	for <linux-nfs@vger.kernel.org>; Sun,  3 Mar 2024 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472069; cv=none; b=DFxcX650FGXPIx58HaUs2hfw8Z+E3E0crg0rPIZx6uoKynZE49rHzJItrMNA3smRxYZGBl0rAju2Fa6/nGKJgZw4QQuPEL12eycyaCk4Y/I4mASBeZUmT9FpQL9MuQHlZ556KZxgYgZ6hy+ZYu5sZkCYaqTuzgBb2lApypTUA1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472069; c=relaxed/simple;
	bh=iV7QVPVKoLCI/4B0IVnfyjJ02EwBmNFAkhUkSUqYSHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEuAypqyRPq3PFW30cMJRQNN8iLUx62VyfJVLhQwhx0yzML1KlNegpKr5Km1Nk56YExCQslTxpC1nmAebyHtlAnKWrRTDrLEFNNHQKSXYK2QpPPLnQSKhBSUvjtNzToKX9REsmBRIyFo6i7oEra0IkgRvD7S+a0APJIHvnScoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh3Flypp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so7826275a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 03 Mar 2024 05:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709472066; x=1710076866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PIfucSkgaTGcrb1oFSjHalmDfrVvqXkL0owFOqzthI=;
        b=bh3FlyppPrvrmn2Dg1dY0ilQF2DVdF9NbDfW+TrLSpkuaSFecrbYieP0ullaOZhLk8
         Xq3O49eqvnhDYZDml95nulfEu1Asi514cotGvFYKXfp+qlmbi1e7PpLi5I3MS3OycH4p
         kF9XIXWgnQkprb785HeNlnKgM5x2CBsCloFSmzzpaT+cuaVgO7x6mNfhRsjH0s2cKXIq
         h2XhnaPTDWRfgHwnXfWTY9rRclxZmn18G/9oLul3vutb85rTUMj4OqMD+0IaQcpHf92v
         kZ2ph/GYbpNXxVc66MQJ6AX9PnTBrmwIbPJzIiYizKnx2C7c4a+SEE9kXwfwSqs7yhwP
         kaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709472066; x=1710076866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PIfucSkgaTGcrb1oFSjHalmDfrVvqXkL0owFOqzthI=;
        b=Vsnzp2V2to5KoZu9yi1L6xqjuWEI6oZoiedIbFvepmAENSoY10N6CElSGbrXvUsWVH
         dDm5Zaoqk0NzrdjrytiBVVt/3Jh5WuoBIoKG4XC917Y+dwcCWl5J9WckLU4QbWQgkrOZ
         UHCjGqqsMiIpBmFCDOCpVCTe8PO86IntjIxJ/1Nik7To9/lvkx9Y0Nbuq7MBPnNZSAgy
         a82zfFz8Nm5KP0U0CkCghytG8boV75iIXPWJEkhWSJS5ddRhXLgz7jPREXVCkpDlLSf+
         gC52QNXlcVKq1tFqy4tDN78PSzfw0dh3DC+1g2QW1ELBf9xZUNad0tTE2aZmyYNjFdOR
         9c6A==
X-Forwarded-Encrypted: i=1; AJvYcCXc+5Ta/MrjMimsDSqbcyWq85fDoQEQk3szpkVDtjbVfhKWlhjEJFZe5YJOyHWeUtYWa2J8XK/J6XviEwVTKEOtWxTs2GauLgW5
X-Gm-Message-State: AOJu0YyOOCtNCKHUcqrBC/i3iSspmymEAInR+5HzAsQxrDtrUfPSO0D5
	J6bOQ8etdHurui5E7lw8m/IMel0GcfuzLDQzdeRrB3Coytj535XMbBWizY/p/JNE5eZmmu0rkLd
	ttsHHfdmWObmJgRSAXa/qw5/rvpQ=
X-Google-Smtp-Source: AGHT+IGnYLGIT/RPmXlNYdipYB9itB8WlC8ev40rrsgU4xurOevP8GjS9u2E/xI2sr69/iXuWeVcDfXUjbTYzlryw1Y=
X-Received: by 2002:a17:906:f0ce:b0:a44:50bb:8cc2 with SMTP id
 dk14-20020a170906f0ce00b00a4450bb8cc2mr6174045ejb.28.1709472065726; Sun, 03
 Mar 2024 05:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228100957.659-1-chenhx.fnst@fujitsu.com>
In-Reply-To: <20240228100957.659-1-chenhx.fnst@fujitsu.com>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Sun, 3 Mar 2024 14:20:54 +0100
Message-ID: <CANH4o6OK3EFRQxAKMyNXBrvWCJOg4ccJ7th+F1PFsDjF3pPnfA@mail.gmail.com>
Subject: Re: [PATCH] exports(5): update version information of "refer=" option
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 11:12=E2=80=AFAM Chen Hanxiao <chenhx.fnst@fujitsu.=
com> wrote:
>
> "refer=3D" is a NFSv4-specific option (as per RFC 7530 section 8.4.3).
> Other client version will ignore this option.
>
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>  utils/exportfs/exports.man | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
> index 58537a22..c14769e5 100644
> --- a/utils/exportfs/exports.man
> +++ b/utils/exportfs/exports.man
> @@ -445,6 +445,9 @@ the given list an alternative location for the filesy=
stem.
>  filesystem is not required; so, for example,
>  .IR "mount --bind" " /path /path"
>  is sufficient.)
> +
> +This option affects only NFSv4 clients. Other clients will ignore
> +all "refer=3D" parts.

refer=3D should also have examples for IPv4 and IPv6, right now there
are zero examples

Thanks,
Martin

