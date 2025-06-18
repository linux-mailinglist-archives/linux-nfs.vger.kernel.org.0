Return-Path: <linux-nfs+bounces-12565-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4534ADF6C4
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 21:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C02E3B453C
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 19:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573B71F4CAE;
	Wed, 18 Jun 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqIRjIM3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB74258A
	for <linux-nfs@vger.kernel.org>; Wed, 18 Jun 2025 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274603; cv=none; b=fVgacORNwX4xV4wKV965kXxUhmwh9GLsGy3XXgnrPjjs+U4HS6VjCklUt0SozxLYAsB4OrOX5n7KCkhj2R9TD8TIF4k6qAQdHXwFXrvJhw9IfiXdTSs2ZbgSGKuYmTPGkdTt2t7TAgDye7xb4Gdd3nFBJcQzJRhp9AQrThU7E3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274603; c=relaxed/simple;
	bh=+1j7RmFdQw/QY/iSt+naLzXW8B5Lwq+AvfrdjFRpi1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYTJ/mtqpM3vcdbPoWT15DAIH3SDj8zozhElRllvTOOJ6JIlKeeGEDjnPimCxEvUxwfOpNZLoLvsM3RadVTG+hc7qM1EhHZv3EcuKzE5XeQGL6DdUkYUpu2YA/dIbULYFvENrqyD64FaFjitcRvAGGc4lSERsB1aKwsgJ+O0sGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqIRjIM3; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40791b6969bso4627389b6e.3
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jun 2025 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750274601; x=1750879401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a47aaBGgE3F89r3NU+nOXfxZ2x5HyogQEoM49jqwEQQ=;
        b=NqIRjIM3oUzjX3TPbOcAjMsn+vcoLzRrvVl0HmhaxnGaK9jwEJoGVwwnXv2Is+p3az
         jkFWxDkTOjJR4GXVlW6R6HAjeCw30lf9bbeMwIZAMNAVb6rH1/Lan5YasSxtqWoF4nVl
         CYQVSRYkZXh2WGlKKwfS/+5QFaP1RpHIO6Sp7brsl/wzBrLAC79chZwQj0jB4qr1fGMz
         MUEUP3abZr3TCOZTMRJk29yb0PjLzFCsze6uxpg5rqc4hLdMBb/bHW8jq7MTOGpny9EF
         JO+ezqeCaHcLEx0FuC2fps2xwTSQd/oxOkQoSgq0QDwkeNgGtUsRofDDyvSS18aPXk0d
         NUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750274601; x=1750879401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a47aaBGgE3F89r3NU+nOXfxZ2x5HyogQEoM49jqwEQQ=;
        b=Dts3Db4tc69nIekRkdOnUsrNAopnY4VQDSkKPUn7ZD1LLBuyk15gBpVXbJNKEM+tR7
         a+RTfKGIp84v+Fo0jL+WYdT/meGV+hWkWYNp5mlLFEEf7aYYOP2Sxq2wIz+GjyWvl+zU
         OQ5d1UTAH+cc6mmdxa77/Jmy+G0QUixH5LSad2dLCBxb58OTyZIuekhsBVr38rAAkVgt
         XYJotM6L8BPSiXLQY3brjiL0b6KQQuanazpuOrxdy2ou9azR22SQeW7i/fKmU7M9O/HS
         XdEmw/2f4IWrzmMiobDiNTX6ggjqMvFF2PDl22rRBPqfjB5rxMTVCzrlo2D4d6HgAFUJ
         GB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXEytpdteKambUISG40yOvNEVoOHl2pGXwa7KnFHhEE/W9i83hboOaYWNWCX1wy1mscXA6Xt5qgis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7d6BlNkaer+HbSK1g9NBtkPgKxcyrwvqmB/vkm6IeI2QHGUqi
	xv9lNdHm0JxsdVPdgArc1YTPxqRP4nXLgZDeeEw8gG2bfBQ+bAE1Ms2dV1GUS6A4BEopd/bfv7r
	m1FKTXEOwr9M2/gXdpOWom/mSL8X7QmRiJSm57aA=
X-Gm-Gg: ASbGncsatLNUiX2iqLTNXjmQAdmr2tBBUa9vKj2s+cBI/nAG52N8cvMK7ycX1VQ+r7E
	6W5dhEisNChenuYut3XPSLJ9/j8M2f140gmu5q7UwOxtgc5XBBQp4tc9DBLeISdryBMmOksG7ch
	HoinhjIAGhdHGwbwQlAmdiVNfwhFVhEtBmjizQ3sGARMk=
X-Google-Smtp-Source: AGHT+IG+AHaEAPi1stAWOln5PBQMb6iATcD1wHJTT3Y3zfc2DnTTmUdS0KamsGTAk92P1F4+ROidSBOgfm+/VuNsjfU=
X-Received: by 2002:a05:6808:1791:b0:40a:533c:c9cb with SMTP id
 5614622812f47-40a7c2777f0mr11016242b6e.38.1750274600822; Wed, 18 Jun 2025
 12:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618125803.1131150-1-cel@kernel.org>
In-Reply-To: <20250618125803.1131150-1-cel@kernel.org>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Wed, 18 Jun 2025 21:22:00 +0200
X-Gm-Features: Ac12FXyVvkDNNgd5-WP2JPTmCWB9FGaRq4S0x8GIrwpQRY3OTSZ1Rf_CWOQfoAQ
Message-ID: <CA+1jF5pJQePnFWWT7G5T3RXwcmwNyfo=phaXaUB0v7Br6yrgdw@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert "NFSD: Force all NFSv4.2 COPY requests to be synchronous"
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 2:58=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> In the past several kernel releases, we've made NFSv4.2 async copy
> reliable:
>  - The Linux NFS client and server now both implement and use the
>    NFSv4.2 OFFLOAD_STATUS operation
>  - The Linux NFS server keeps copy stateids around longer
>  - The Linux NFS client and server now both implement referring call
>    lists
>
> And resilient against DoS:
>  - The Linux NFS server limits the number of concurrent async copy
>    operations

And how does an amin change that limit? There is zero documentation
for admins, and zero training or reference material for COPY, CLONE,
ALLOCATE, ...

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

