Return-Path: <linux-nfs+bounces-17885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ED9D20B29
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 18:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FCC9300B989
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D4B327C1D;
	Wed, 14 Jan 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRvwE28I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282D32BF3A
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413538; cv=none; b=FRnutDemUoV3jv38PuS1bvzLeMFs8IFP1G6iWm/Yv6fO3VTLSwDQee8md/bZrA+Zrr9h3oNChen0MsYZLMHs0SMKkT1SWY82Mcrf3/mqS2+MhJBdR7eKV3Yrq+PAJokA5Mgktfbd9PTuzkf21tqae7O3D5SPz1oK9PMiulSpdDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413538; c=relaxed/simple;
	bh=yWpDrIQWhEKP9JAmcupJ8D6CB2U/lTqd7ZDrYHveKM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTAt8C0dvQ5h6IWvJrpebAC4i2EQtj4fV0aCbhZsHeIRaAauB2nuvbJY1ft4tfKkGPCe1+IChnEoCsaYg71eGk412vd8TNBWg+XkHHg4i+CS901DcCOuwNxEjTCrSLoqt6RsOGhinj6Fd0+CpTmH0dtQIDT281qZhRDZe4y4ZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRvwE28I; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64ba9a00b5aso25116a12.2
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 09:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768413535; x=1769018335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWpDrIQWhEKP9JAmcupJ8D6CB2U/lTqd7ZDrYHveKM4=;
        b=CRvwE28IdVjH9TDH6dB8Us7j3fQ/OHtp+URPhd3kv9FaVQw8KMzJLhXmlm4jBzqebG
         6bq6oyGPNjDb41yl9tFXBVZcq3QDHqhGTni1gDNhuTa3gINO+NOJVrVVcMj/tp1Lbon/
         fhrv+jDscoRxKQGQWL47mGTg68s10PRprySXdXH5OS1tKmjNr+EGAQnx/HqoaaFXqaRV
         mHFivi+ntx8gIgggDrovfT1FDUCRi2/6OCX2TQvKIpIW2jlviECShQ9BzRmAZN7/9UHF
         CdO34AMlb7bgy/lIEdXzuXFj1Loj00HbU7P78E+w8bLBoZJc4FOJKGfhv7hTSkvkDNR4
         G5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768413535; x=1769018335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWpDrIQWhEKP9JAmcupJ8D6CB2U/lTqd7ZDrYHveKM4=;
        b=L/I4vEX9Hs1YdZ2JoSE+dBPq3KKXPW7Wc/IFEndqZfTEgVzpdqSfAHCdQVCVnlCIJ3
         uay2QFSrOOsyIH2KoNDfk3QHNrOU9ZYX+3FYzAffIl7GNcTnm97h+pwUTU14oLl6K/49
         oesayOfpUHBT55rMQd6JfMYrtoUQ7V0eUKy7dEP7JVEZ65xwxC4gqaUewxY/2EGWeRkd
         397RlSqJHPmOc816fr0GSukf0LGMUNkoPPebm+3CXRqkaO1PmHsOxIMO53ojfb1qwL1e
         JGPYrqPgGTSSPK9r5+3swzA09H2ZVi0HQw3e+2tT3D0HTSoVMRNiePFDPTPBPrX2ov/t
         vuyw==
X-Forwarded-Encrypted: i=1; AJvYcCX8677/jrWJJxxKHFMiz/m/UTPTWfa49q/XKNSXyPKKm3hwA6RF/fsUj96VP/6dQkI2gYPoS0G2F4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk6LkuuAM8whKjgSBOcav/Pr+o/9x4WBd5jg+Ivvd39Dmy1Asv
	NgN5ewdZrE5JJATAmcjPhxJ3lRcJhinQYShWsHJqXeRQXDARARiZvLFTlCKVr/fW7rPAefAA3qC
	nBXektLUrzOXF8Hmkq4tLpD00tZbMQbc=
X-Gm-Gg: AY/fxX5uuxrjwWRUhZo83YnOk1kYi0DcD8v+95vF2yaAwgcY8++noLMVc8OQecnSVrP
	bIlW54kOmemp3FG+8mEkt8SmdyGNijcS3dYuVXJhYyEDefN9i4DdBZDszaDynCAivI0lZwYvYZy
	ZPaXhpSu/Hg4SQ1DOOeL5lQqSV9uz1Jfxq/OWNY13OBJ5kbMGvnrB4HVMAKmdoW9zcgeYf5UTGi
	QZaW6J7CQYzq896Ae4Inq7gokfBbv2fO7dnvmkJjke0XfO3A8fPeR/KWp2CrP52G17qGshfNxbw
	UBLf7lLXT2iBnLXmAhUghnmwxj2xOg==
X-Received: by 2002:a05:6402:13c5:b0:64e:f50d:ec9a with SMTP id
 4fb4d7f45d1cf-653ec462b15mr2849227a12.30.1768413535030; Wed, 14 Jan 2026
 09:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-1-e6a319e25d57@igalia.com>
 <20260114061028.GF15551@frogsfrogsfrogs> <20260114062424.GA10805@lst.de>
 <CAOQ4uxjUKnD3-PHW5fOiTCeFVEvLkbVuviLAQc7tsKrN36Rm+A@mail.gmail.com> <cb5a8880-ed0c-495f-b216-090ee8ff1425@igalia.com>
In-Reply-To: <cb5a8880-ed0c-495f-b216-090ee8ff1425@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Jan 2026 18:58:43 +0100
X-Gm-Features: AZwV_Qh1UWpllsM24ezXDnsedohpjUB85HiNzPlW4l6pscviv_fH3BWANqTQD24
Message-ID: <CAOQ4uxh80eLc5jARydpayXMA7Wx8b__CR5BRLbkG5KjLy1j_sA@mail.gmail.com>
Subject: Re: [PATCH 1/3] exportfs: Rename get_uuid() to get_disk_uuid()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 5:38=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 14/01/2026 07:12, Amir Goldstein escreveu:
>
> [...]
>
> >
> > Whether or not we should repurpose the existing get_uuid() I don't
> > know - that depends whether pNFS expects the same UUID from an
> > "xfs clone" as overlayfs would.
> >
>
> If we go in that direction, do you think it would be reasonable to have
> this as a super_block member/helper?

IDK. maybe.

> Also do you know any other fs that require this type of workaround on ovl=
?

Not really.
There are a bunch of fs without UUID for which the mount options
"uuid=3Doff" and "uuid=3Dnull" were implemented.
I think we support index with those fs where there is a single lower
layer, so you could use the same trick, but not sure.

Thanks,
Amir.

