Return-Path: <linux-nfs+bounces-6894-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 595DB991CBB
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 08:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B33281D84
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 06:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1CE15531B;
	Sun,  6 Oct 2024 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSNwCGAL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6BD4C9D;
	Sun,  6 Oct 2024 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728195607; cv=none; b=TtUDZZ/Z/oKVmDvpQoFhPyqfq2TiHabEjyz3q8bfR3OcoLSWuz4mX9SiLB/FGrOK1MIo8fV/GQkXOsgV83gYTrF9W9+bDIwKVNDgDphdrbWeYg117uK+p0ZRVMONq97cjE5ttRMQG0EsCsbDulqz0YrAOo3TXDF1p8pR4gN2q3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728195607; c=relaxed/simple;
	bh=ISn3j8Mn+nA+MuUG1L4BUJycEOBAsSmC5oQgT7HThaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOWHWg7Y+gd+pDz7/7redw9ZCiSRW8VaojJyioYR93+NxGWWpZ6n+/up/6xW1CsymuPjVIdFR3PHkiy24I5jDx30aIn0WFqakRmz5IUNv4DTC8YfCYG03Vh5MUGIbmR8AHPOdPMK2+TdN5SonLZmxLAzDjGf6GcCX4uaD6iks+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSNwCGAL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so7791927a12.0;
        Sat, 05 Oct 2024 23:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728195604; x=1728800404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISn3j8Mn+nA+MuUG1L4BUJycEOBAsSmC5oQgT7HThaI=;
        b=gSNwCGAL7zt+SBlT2333cIrWhAqhHdUa4TXnKl7aI5powAZwtVMtB2jrhPWdssE7pV
         eZN6nDPhJ/PUL5paBl65FXHp2ZFFQr54Mkj4Gy4MBKeF+32s6EdTkUIyzLZLEftLrJzM
         dIMfHS/P6g4sHCrJ3iQFWqX8wLpOg+JaQPXR6j2uiUOwuqWCo+XhwkL8wmKQgmn2ZOuF
         BrBdSPhHeKcKkTMRrwRM323yEEWG/mvuLspTnDh9XqP0H5Rf7kZO9eVOjswC6Q2ucNW5
         DEgNNyvICwSDd8BI1oPww45Gh7meiAM/fFzUPOPaNVB0hAuo4ism0iEw3J33NkdO+7vX
         XeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728195604; x=1728800404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISn3j8Mn+nA+MuUG1L4BUJycEOBAsSmC5oQgT7HThaI=;
        b=W4fZBQSLkn3xQbmzw+VWV8U2y42vT2lDHi4oYiiqvgq19ShDxEJNINthP2cQ3t6Asx
         0C1vW9kS7UG/m+hOnnJr/dBDtzZvvZOWAHvuogFc0PLSRBQDs3CjK6sbHMu8uJDPkXz9
         sfKFCSKJPcpmZfxgER3bJt5EaUYkPtoYnvpvxMtUscDGbPjouzlotlLxx0vqJqO8vFFa
         fZ86nsGCnHOMxGoipGTzOkrvKzF31SZNkKuaq+o2Jb9vDdNSEk3OUpYHYKWSE0qlrci1
         9179LVhDQjqppXla2Q2H7rhvXUlDm2OHYbetuMcPDwYjDMqVyosue6cFe1c8rDc5ZA3u
         533A==
X-Forwarded-Encrypted: i=1; AJvYcCUCOt61GB+b7FlJ8hKU0H5o6xjzGJm+3/6BeZXtJcjzQILUyUvjU14odJj6UvqkJQkqa3ypfQuNod69tGk=@vger.kernel.org, AJvYcCXPa9XMh+kr9B82N/kayum5op+OHYSzN07CKQq5UeAz7tfPMY7IBamVpYCYh+286MPyliLT0+PmsEys@vger.kernel.org
X-Gm-Message-State: AOJu0YzWN6DCpQsjOTsK3XyLu8itB+lmiqVqtEvvcW93M0e/ZEBmXH2+
	AbuzZmsjC8rvtfOqDowktZAvAp8qKwbMMoZLkPt/MOucaMgu2pIFXOJof7kPvJcBRvPwx5Rksek
	OZVM8RRKJ7wK+AkLoAYQwDXEEGHo=
X-Google-Smtp-Source: AGHT+IHLmKYhibWbPE6q9uesx6oy/T3sgRy11XIngKNXE26QEwKp8tXA3tuKRc34A3dfiFkKIl0QPri/UgJGBzKc6sc=
X-Received: by 2002:a05:6402:2682:b0:5c5:b90a:5803 with SMTP id
 4fb4d7f45d1cf-5c8d2f2dfe4mr8909053a12.7.1728195603921; Sat, 05 Oct 2024
 23:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912221523.23648-1-pali@kernel.org> <Zumizr3WnA+XY9ge@tissot.1015granger.net>
 <20240917161050.6g2zpzjqkroddi22@pali> <Zu3K34MHFUYNaRfu@tissot.1015granger.net>
 <20240920192941.l2fomgmdfpwq7x6p@pali> <20241005150843.4ac6nugo7yusz2m6@pali>
In-Reply-To: <20241005150843.4ac6nugo7yusz2m6@pali>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 6 Oct 2024 08:19:00 +0200
Message-ID: <CALXu0Uf0fnVgJq5ehMHnn-My9OvVjCVBR3v3MdEEJ8WxKAZYTQ@mail.gmail.com>
Subject: Re: [PATCH] nfsd: Add support for mapping sticky bit into NFS4 ACL
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Oct 2024 at 17:08, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello Chuck, have you done more research on this as mentioned?
>
> I think that this is really useful for non-POSIX clients as NFS4 ACLs
> are not-POSIX; knfsd is already translating POSIX ACLs to non-POSIX
> NFS4 ACLs, and this is just an improvement to covert also the
> POSIX-sticky-bit in non-POSIX NFS4 ACL.
>
> Also another improvement is that this change allows to modify all parts
> of POSIX access mode (sticky bit, base mode permissions r/w/x and POSIX
> ACL) via NFS4 ACL structure. So non-POSIX NFS4 client would be able to
> add or remove directory sticky bit via NFS4 ACL editor.
>
> Of course, nothing from this is required by RFC8881 specification, but
> specification also does not disallow this for NFS4 servers. It is
> improvement for non-POSIX clients. POSIX clients would of course not use
> it.

Have you tested this change against the Windows ms-nfs41-client
(https://cygwin.com/pipermail/cygwin/2024-September/256473.html) and
OpenText NFSv4 clients? They do use NFSv4 ACLs extensively, and might
break if you abuse NFSv4 ACLs

Ced

--
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

