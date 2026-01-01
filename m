Return-Path: <linux-nfs+bounces-17394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DBACED76B
	for <lists+linux-nfs@lfdr.de>; Thu, 01 Jan 2026 23:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC0FA3003F94
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Jan 2026 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808A282EB;
	Thu,  1 Jan 2026 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9AFUpLR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A61F37D4
	for <linux-nfs@vger.kernel.org>; Thu,  1 Jan 2026 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767306982; cv=none; b=D+ghBmOUSL6oplPFwVyUZwvAkYCapDjhbtyiGXKK3ww8ncYoLrN7xn5M29xyfDTih9fx45kIfQa0dm4hqP0HACddUf+aWwokGIQgXxMJ9tqkyTuNnDLk8/Dt0/ADuEQjG6nmThhl6t/+r76SkIHbyel6DQr44Zo5BHZAHCVwMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767306982; c=relaxed/simple;
	bh=0i/nlOBt8mhijDLycWFgPgZAszwxe4EJY/lfHnPnqN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+P7qhr/FIHbUnzDULw2JrwrWoxMSq0h7SHLdZ+DCOBVVTkcUBco8N273DCRIpvmGVYhknV79iZCZZPyOyhdIVoNISGhL/rfxPRSZkjk5N8rDCE2jBgn3Kt6CsuhJ7dT3jSfg12z4FSM8urXSbs7k2V+YxiIa0ovrDqRaZGa+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9AFUpLR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b832522b47cso773848366b.0
        for <linux-nfs@vger.kernel.org>; Thu, 01 Jan 2026 14:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767306978; x=1767911778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i/nlOBt8mhijDLycWFgPgZAszwxe4EJY/lfHnPnqN8=;
        b=W9AFUpLRBouCns702LgzOAMHEZECRE/v9Y7SQgli8dQEG1UsvKkEkWUfXW/lMLaH50
         Ecz4fHHPFvI2PHqwvWrHOOoFpwAZ514V8RfYjdx9NtuPO+/AKycN8AYHHg1mMO4z7T/W
         j9mW+bkCGx7QS3x4D3VfHp7kLp6ADLAq3KGTXL7fRi8g3UXPWMRJOQtd2o8wIfWLK4nZ
         30E1TJyURZtTsxOAJJ4OmAKDk6j/vgljNXrl6zP3Gi/7aMMWcbUnq+p9UEl/j/aKpt+b
         DHLZhOr90WqDZC0ARc9VsG0+ubKl5X7SKQ1upAgTJ9KjlKK6c8qFJzBlxmjpfh2X8vCm
         ABqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767306978; x=1767911778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0i/nlOBt8mhijDLycWFgPgZAszwxe4EJY/lfHnPnqN8=;
        b=lQLFUBqdxAZT5l3nes6HYL3j93OkHqbiVA+/yIdvjEuQ0NqH2B0phF0JwjND3yBxSP
         TpbME2qhIuZLNP+vLhtUEc7cBkpGg+RAuwPhdET2HSRO5D5FbA4rMYHArGsxu2/1ZssU
         tT5xsPi/a/A46aTosxPEGpwoBKDfTcwHjbknVP390/Hgi/H8iza8UVnuxYHxAT0KE8wN
         CCGnpmufh7yVB5/lmegtuP02+ydBcdf/EwTftHcGYycLx1lDelNUAyF7MiF08C+nxXfd
         7dZ1iCuzkKbTum+XZ0cvI9Oh9u88c+KujvSsAtKf1mLJB6Nms9wPka4JuTEqsYFtR0ei
         35uA==
X-Gm-Message-State: AOJu0YxGxqRVhh9lywxEowUpv8BMFgDQ4ECNZiP59TWv9555dUNmxp17
	EhIGj5xGNhTV8k99GCm9EE0o8dTEZDPgnk8Ozqe4MUDJKp+6I4XCmrMo7LBxWnqAqlJ/jgRDrqX
	eIZojr5IpFw24b1Euwcx8PJhsXEn3ow==
X-Gm-Gg: AY/fxX4c/6mhV0Ir7thcGv+kvgiVs7HDn6PmU32KUsQAMLN1yOFE4CjyQnJzxu+dDIJ
	N6KjNzljl8xtEk8x9K8viQHE7mIbwo48xPp0nKg/LAUKx/xD/LtqkJKK3bjRSWvNDTyZYd9Yqrc
	Zm/WTI7GEC3PXclyKdnUBgdvyjNs2SHVf5yAjNMV20Fif/nyoFeRD/WJZ13iPSp0bcqAKX+Sjv7
	GOMfkSnZpXa1kPpYhg5qWhezArRwr1gv9lJsAYOwf4mNLArdftlWYBItZag4PqWo/Dr5Xuk1npv
	2DAuErkn4smQZZdYTWUknVanDmU=
X-Google-Smtp-Source: AGHT+IE4Be+OibB1bdo80uy22QkFb0xuvvOel/Nx/u/jFdbCWa0I6j5V/4RplAkYlZJZ66y/iKNMSYpGE/mqm0uTRoU=
X-Received: by 2002:a17:907:c02:b0:b73:7184:b7d3 with SMTP id
 a640c23a62f3a-b80371f3a9bmr4559804566b.58.1767306978257; Thu, 01 Jan 2026
 14:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM5tNy7QEoa1iE6Cu6Q-aOSzEodQoHF9z2AUwdq7sSnUS5XamA@mail.gmail.com>
 <4291447f826bb3206cc7f9d083998066f7b5471d.camel@gmail.com>
In-Reply-To: <4291447f826bb3206cc7f9d083998066f7b5471d.camel@gmail.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Thu, 1 Jan 2026 14:36:05 -0800
X-Gm-Features: AQt7F2oikU9ErFt_VtU8gq5v-_QxlcgPAeNmP3EJr3-e44T9TWkhFrUppA9rE7o
Message-ID: <CAM5tNy5eq8C3iu6-=LHvTC1-4BdEQ+f28Tr41Oj7mJj5FXBDpw@mail.gmail.com>
Subject: Re: RFC: No NFS_CAP_xxx bits left, what do I do?
To: Trond Myklebust <trondmy@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 10:06=E2=80=AFAM Trond Myklebust <trondmy@gmail.com>=
 wrote:
>
> On Thu, 2026-01-01 at 08:48 -0800, Rick Macklem wrote:
> > Hi,
> >
> > I'm trying to clean up the client side of the NFSv4.2
> > patches that implement the POSIX draft ACL extension.
> >
> > I need to set a "server->caps" bit to indicate that the
> > NFS server supports POSIX draft ACLs.
> > (There is currently NFS_CAP_ACLS, but it is set when
> > the server supports NFSv4 ACLs.)
> >
> > The problem is that it looks like all the bits are used,
> > when I look at nfs_fs_sb.h.
> >
> > What do you suggest I do?
> >
> > Thanks for any comments, rick
>
> See the function nfs4_server_supports_acls().
>
> NFS_CAP_ACLS is really just used by the NFSv3 acl code at this point.
>
> For features that are implemented through new NFSv4 attribute types, it
> is better to check server->attr_bitmask[] directly rather than add new
> bits to server->caps. For one thing, that means we don't have to keep
> several different sources of truth in synch.
Thanks Trond. I just made nfs4_server_supports_acls() global so it
can be called from nfs_get_tree_common() to optionally set SB_POSIXACL.

Have a happy 2026, rick

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

