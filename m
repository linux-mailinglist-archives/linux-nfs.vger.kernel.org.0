Return-Path: <linux-nfs+bounces-17122-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A93CC56C0
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Dec 2025 00:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DA3F30021FB
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Dec 2025 23:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8F32D45C;
	Tue, 16 Dec 2025 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Cm2pGcZI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA872F25E1
	for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765926225; cv=none; b=WURQ5aIkL0UQuJcSjsYJFpopR6aTQEaGJ8bdJ5uwdLexOGUjyeUaCFDRgt5+zHVREO7tvAyDvEimw9nJp2LU88V3AcMqajs9P96/elPFAnb9B3tfgHV6pezTwop+SEsEjcHI/GGFAXacsegXZFoha5j5nlsdZK7QyCZPV385BqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765926225; c=relaxed/simple;
	bh=aYuR7WGfuY3rI74yDcaZKdqPTtf0QgmL0q0Bk7KJA3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwKqcQGs5HkLs/znkAcUz+lNfiBTfezduqT4eT5zZn5qypi4WCkWbi4PvPkabkR46JwtZdNVxO896c/dRw0WiJwYoFX+MqyXJLG8LXvIVZyPWJchvlPj9v6uQzwWLBSMGNFjss12HQuINFREThkZ3zlvhkho4FJt8YiEar4UMng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Cm2pGcZI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so6523057b3a.2
        for <linux-nfs@vger.kernel.org>; Tue, 16 Dec 2025 15:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765926223; x=1766531023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=999Ra5nNIcgIyecT2HDRGeInlGpnYwvVkDULmVpZ2ng=;
        b=Cm2pGcZIDI03EnW6hmNbgt6BYu+9iC5EW84p5aWlDNzZd10+dCnIbiXc1dD9FOehkp
         jJQq6vFWnye9szPbT6YWlX0froPI8atmpt+5Jo2HITbWZ3lCfr92hyBFSnByDx22CZJ4
         qaVZlOIVC4k0JA01NMrMei6ZmaRSLbLQHeTRYXwFVMxFSI/9ru96UMyfvfzp4mMJPOWy
         NfRnjpk2ZYWnEC+J/iGU5IAEpxRO4CluLt43Gkt2Fta+V3Gc0asECmH8ICSQo92gYC/w
         g2xorw11k82G7KBJqtb0dS2JiKJo+1Ku4ljT6d1eg/hGaPpLLbEpbj2/TGBz+ACoC+Ud
         tBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765926223; x=1766531023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=999Ra5nNIcgIyecT2HDRGeInlGpnYwvVkDULmVpZ2ng=;
        b=sMnnqlXsX5jwM7BjYaWzcHbkDh1lkjK7hHDPHw9tefQoFEqqGlnYWehTBOmVjuk0f1
         fVJ/t8hsFTHWj2g+FWCvubza+/pKgdQz+K3eMATh3q0gSDXqtNyz8F04+1ilprlfikjm
         QBPrjWQ16xQdzM/Pcer56Brc6GlGIwNCwCTEfVJ2k4P7OPLkjhSsOYFuRAORmBjg+8a7
         5ChObaItihhKZVzag0TWnmy0+bl2VDnVtaAJ1irRNtwgTkNePLiy93Hxo0f91NkebeEb
         8pGmzh7YnbpxQIdH9sLQ7esqwNjE5sUYKkR/05UIL1FBO4GbrYq7wUmr2HhvEnC0PkfJ
         8GSw==
X-Forwarded-Encrypted: i=1; AJvYcCVM6+sYJkokpa1QUDvBUiG2sD8XB2qVUyhn8GCO8Wmj5Rsc1+L/f9aSLD+B+wZjLfAPHosE3hcsnqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TS3p3RWqhk+4youiegnGqfMmzSHgBNIBj275ATxj314Gz0cJ
	NwcBLrw/7LNWiXSXi2DFctpBXdJVv2poB6vvMGqzYBJrIENUY1f3iyTPPN2MrkmAqpDBPpj5wQz
	0PAVTG0NgKwC+pIjq9TqF+P0WApK00DfXhZt6b9TF
X-Gm-Gg: AY/fxX6jHsyg8AgQe2Rx14s0h6TF0yspgD5UK9yz8va1leYLgtCauvHehakQo+zv41E
	3pf8Y27kbNEizUwuvgp4BgPCzrUxZn577S+LRzYaQGqA7Y1hSK/yaNpDHWFCmxKxcUxsYQ85rui
	vwQeIVa3lW2WK/PyWlEvURllz1aFHj8gZiXu7cuJIsfRl5uXEcCxawgweMuvwLkMhZZ+P1NKc90
	X6tCxf9toRBl5II2iDW7uy/fYpYX9NWj6DBOsC5XrX0UwtuCLnqoK7zI4Z3u051jViE1Wc=
X-Google-Smtp-Source: AGHT+IHpfmnNU4elY2Ty5ORWz89amfg/6YivUBJr0NnncINJP9IfPfNCTIcEYB/tPEGFhORURxurKR9zfHVNkpEBtEY=
X-Received: by 2002:a05:6a20:12cb:b0:35f:aa1b:bc09 with SMTP id
 adf61e73a8af0-369adfb3079mr16047640637.17.1765926222635; Tue, 16 Dec 2025
 15:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203195728.8592-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20251203195728.8592-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Dec 2025 18:03:31 -0500
X-Gm-Features: AQt7F2rZw2j91MpBSQ41cc9ZofVCToHErlufY-3uD0Xl6tB9kNjXs4RkNaSU8XA
Message-ID: <CAHC9VhTnf_3QQCeWicRqANdeBgaHctSid3pTu-0iVc3BsFrtwQ@mail.gmail.com>
Subject: Re: [PATCH] nfs: unify security_inode_listsecurity() calls
To: Stephen Smalley <stephen.smalley.work@gmail.com>, anna@kernel.org, trondmy@kernel.org
Cc: okorniev@redhat.com, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 2:58=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
> security label") introduced a direct call to
> security_inode_listsecurity() in nfs4_listxattr(). However,
> nfs4_listxattr() already indirectly called
> security_inode_listsecurity() via nfs4_listxattr_nfs4_label() if
> CONFIG_NFS_V4_SECURITY_LABEL is enabled and the server has the
> NFS_CAP_SECURITY_LABEL capability enabled. This duplication was fixed
> by commit 9acb237deff7 ("NFSv4.2: another fix for listxattr") by
> making the second call conditional on NFS_CAP_SECURITY_LABEL not being
> set by the server. However, the combination of the two changes
> effectively makes one call to security_inode_listsecurity() in every
> case - which is the desired behavior since getxattr() always returns a
> security xattr even if it has to synthesize one. Further, the two
> different calls produce different xattr name ordering between
> security.* and user.* xattr names. Unify the two separate calls into a
> single call and get rid of nfs4_listxattr_nfs4_label() altogether.
>
> Link: https://lore.kernel.org/selinux/CAEjxPJ6e8z__=3DMP5NfdUxkOMQ=3DEnUF=
SjWFofP4YPwHqK=3DKi5nw@mail.gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  fs/nfs/nfs4proc.c | 38 +++-----------------------------------
>  1 file changed, 3 insertions(+), 35 deletions(-)

NFS folks, any thoughts on this?  We'd like to clean up the
security_inode_listsecurity() interface (see the Link: metadata
above), but we need to sort this out first.

--=20
paul-moore.com

