Return-Path: <linux-nfs+bounces-17461-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6299CF60AE
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 00:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A881B30549BA
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 23:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216D82EFD95;
	Mon,  5 Jan 2026 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsUkLbdV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE82E7165
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767657382; cv=none; b=NNiUf8sYBMhH8wR/j9HXZOMiIwjgbCFkNv7BGBCVk7blJNieMcchTFzR53JyIB1U5issuQc9aZSZ0YSNHcf81PaUOCbHvYd//pVSXm7qPPTAOv/sZUgQm2DCDQUQQNWGRtfiTqsGkmmERr6oOF7EtJHdhsxcJDjBbjb7A2hNn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767657382; c=relaxed/simple;
	bh=0HWnWGGc3e1QN1+1l16ESh54JwFwW/02PRrNWIboD6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgPEMw3t2i/i8dWsuOT+TyCPCDJmJPIHyAngCMNMqw+cUmDobQLE+pA95CdTJ01cj9mcpwBEJNidEBaFIjW1HcdFfS6sze/AqiRcWMv4t+k9uh07L5xbH6YKzEln1CG9psBsV40dzqvsEHJVGKx28XwD+6QX9TmUl0sLI/hrPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsUkLbdV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so632973a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 05 Jan 2026 15:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767657379; x=1768262179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4jI7zQgIo9UyGUqM9A4Y1ZQMUx/8qCytAQM+0oReCo=;
        b=KsUkLbdVoANHkHsVDjQ8Z6nWSplBaBgl4qqDl8x41iJNEUkvdh17zY12MKSunFXdiZ
         U7kY/bfv8RnFG87z8+BMDzxmSlSptBKWrkBzzO8/o64NUISciwTN3jIPKtz/BgYuJO9x
         31Lk0Xw+5u7jo1cwisH0PbdKdg5WuzMjSIA93FIIfPJRnyHtMZv9WMJEXpkPjgaBBxPA
         HZL6LkLCnieyQwswsEQnIBrrj+xNybsUrS/2S1wBB9NRqPXssZ6SM5jTSZNb6v2NNbet
         QLvbPcV8yEJI6G/uqWhHkefIz9DoKBarSlbYK0VnVO3p1mI2m9SvG3SmbWcNXQkjrGCm
         WEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767657379; x=1768262179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s4jI7zQgIo9UyGUqM9A4Y1ZQMUx/8qCytAQM+0oReCo=;
        b=Zej9jWtZRg4N14dMBwm92TEXqUPvaf1SJ+lO+UPXtLbop19sRxY+4r00uXQqKQPKnA
         zgrZadwBAqZKF/kmyj1MQWrzQiHBEx9F5UzSu+lPYqc6O1IAYOJkRSfoG/Td1p1xqRNt
         VSMZuEv2Yyf3Ko273S5zq2JO+KT9ziP//BHwszFhzNzzMz9WgEe706/drHKYfxjVbucc
         YgC04n7HWMUsGkpbJhWOfOrND2v4mXPCuBMr6sJIJPkFZnhQU845rO6z6DBhm6zhUxxM
         UYAxRw8Vt1X4LFY7ZmHMVUlYgwY+0fD5WJhfPqfeeGPxtUsQoSZOaWB+vUr2mN1CJpn/
         pBVg==
X-Gm-Message-State: AOJu0Yw8L11fwWX5tx9vOZ5moxndksFQIRBFlFgYNSLwH+lptNT1MftJ
	8qZBNBFIySv61SvGb3XD9rTfnYDoX57V8D8BK4g3SKdJInJhVEIDqh+bLKPQAwRyWrr8n2pw8Mh
	voS7SkqbMMLMCmQVTA8oiQC1KHF4VfyrJS5s=
X-Gm-Gg: AY/fxX4EQodk/91gGAIxL0rnN+Lg7dZWpaMIkhKfb3K96uHBVlyYqn+uj7o3I9TuDh7
	iz/TzJ0sZzGCHkZ9LwJm7phpJxFOYDepAB9bnO9lgqRI62i3vUGKgLLYpOMR6s9j8A1AvH3IE10
	6fqo2dSEsu5VMWi/+7l8KgJDaBiySjFM52D6OWsnyXcmON3O/maBXf/bfD9lENam52r65gZenCY
	drVfDAuvr5BrbxTwTFew+WnSsgkxnh4kEjNq0viq/+5Dmu021R9Np+h1qzzape5ZI4PylI691UY
	0shDcicQKWKDOthIelVTu7u0sQ==
X-Google-Smtp-Source: AGHT+IHg99YZ9XHHTV6ReHStLG0TqWhJD9kcuAPlAtOkyRxq9ujWUmzEOrPyn1VuBg4LNYvun1shAs/DVdLSkensHDo=
X-Received: by 2002:a05:6402:8da:b0:64d:1fcf:3ed0 with SMTP id
 4fb4d7f45d1cf-650795625e4mr856579a12.17.1767657378518; Mon, 05 Jan 2026
 15:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103234033.1256-1-rick.macklem@gmail.com> <20260103234033.1256-8-rick.macklem@gmail.com>
 <a4b591f9-5240-4aaa-9022-bfa4b8dc37ac@oracle.com>
In-Reply-To: <a4b591f9-5240-4aaa-9022-bfa4b8dc37ac@oracle.com>
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 5 Jan 2026 15:56:06 -0800
X-Gm-Features: AQt7F2pQff8_cIg37KUey629R5e0BSFMiahAad7O4ZKbv4KHTx07yA3ObCnIgIo
Message-ID: <CAM5tNy5G4GVeJDZ8OvDnMsqOz-uGkH=k6LVx5kUqQ1_0UZ4Y6g@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] Set SB_POSIXACL if the server supports the extension
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org, Rick Macklem <rmacklem@uoguelph.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 2:02=E2=80=AFPM Anna Schumaker <anna.schumaker@oracl=
e.com> wrote:
>
> Hi Rick,
>
> On 1/3/26 6:40 PM, rick.macklem@gmail.com wrote:
> > From: Rick Macklem <rmacklem@uoguelph.ca>
> >
> > Check to see if both the POSIX draft default ACL and
> > POSIX draft access ACL are supported by the server.
> > If so, set SB_POSIXACL.
> >
> > Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
> > ---
> >  fs/nfs/super.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > index 57d372db03b9..aa0f53c3d01d 100644
> > --- a/fs/nfs/super.c
> > +++ b/fs/nfs/super.c
> > @@ -1352,6 +1352,11 @@ int nfs_get_tree_common(struct fs_context *fc)
> >               goto error_splat_super;
> >       }
> >
> > +     /* Set SB_POSIXACL if the server supports the NFSv4.2 extension. =
*/
> > +     if ((server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) &&
> > +         (server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL))
> > +             s->s_flags |=3D SB_POSIXACL;
>
> Just a heads up that server->attr_bitmask only exists if the kernel is co=
nfigured
> with CONFIG_NFS_V4=3Dy, so the compiler will complain about this:
>
> fs/nfs/super.c:1348:15: error: no member named 'attr_bitmask' in 'struct =
nfs_server'
>  1348 |         if ((server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT=
_ACL) &&
>       |              ~~~~~~  ^
> fs/nfs/super.c:1349:15: error: no member named 'attr_bitmask' in 'struct =
nfs_server'
>  1349 |             (server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_=
ACL))
>       |              ~~~~~~  ^
> 2 errors generated.
>
> You'll probably need to either move it into NFS v4 specific code or hide =
it behind
> and #ifdef.
I think hiding it behind an #ifdef is the obvious solution.
(Why would anyone not want NFSv4;-)

(I cannot see how the NFSv4 specific code gets called when the superblock
gets set up. I know that the generic superblock code cannot call anything i=
n
the NFSv4 code. Already made that mistake and ended up with a cycle in
the module dependencies.)

I can repost the patch in a couple of weeks.
(I have limited access to the Linux system I run at home until end of March=
.)

If you happen to be inspired to do so, you are welcome to fix it.

Thanks for letting me know, rick

>
> Thanks,
> Anna
>
> > +
> >       s->s_flags |=3D SB_ACTIVE;
> >       error =3D 0;
> >
>

