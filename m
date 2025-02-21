Return-Path: <linux-nfs+bounces-10275-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8476BA3FDDD
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 18:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D3B19C41DE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDB724E4C6;
	Fri, 21 Feb 2025 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3Nvul3m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD9B2500B1;
	Fri, 21 Feb 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160154; cv=none; b=a95TN3lkaTSzyeP/sfVZfrr7sZ6xhJFusj2X4pFkglMs2As1hKqdZEk7LhAgQB2vGR9MQPWdA32wvOWMO51aDL4G+bKXznIHm4RkIZChea/9hXqJH5eTjFL1ZoMJZ+ZZjKOo8uiKatwEYo2Z3NqYKUParMZuahKZ4OIdieS5RZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160154; c=relaxed/simple;
	bh=u6nJOmyp7izbHBs1CCPil5A43HTqn8YbD4gxDNwomI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZxCA+UtMx4hHgWUuO/K53EScXIqxD7mNqINjgtx7IGih3wSKUr6L9eLkDKVwb5P9Iph85H7JvHAmmLTN887fXnfzPWgD4b1TD7faP+4sEgWIwknt9U9TmIOeYQbE86g+V53SLD6QGkgLy/ec8hZY3LZCaT2KwpZj0w0Yv7QP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3Nvul3m; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so3979364a91.2;
        Fri, 21 Feb 2025 09:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740160152; x=1740764952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWPuj2YhQgRJTeYbcKezIFAIYdS2JuroZzEFPOXslew=;
        b=a3Nvul3mFJYkglMpXuGXpIB1G6aEX+tPilgAqWprScWsjoNAaNs6c39a++b2GU58rK
         jyzIGRqZAj5R57x9L/uOmx5WQvFz5l3CBmsc/vlHdoOqB8LqokkZ0eNoxxqjy9cwVfHx
         e8w41AbpuX42tzq6CQNDj0HQwoKY0S1WS4wdMpbo3aDFEb++JFHPOd8MDkbNrdFKSFzh
         UZDBd+EB6ZdWhqenMlPJK2BW4cTmhBHcJXLexPannbcL7hYZp4zLXWrKtixfn8kuqpNb
         fm3nEFUq4QZSI455bwycX8NvQN6qoSqVSiHS2/ys0Mf3Z+7IAEGJaIN9ogZBT/2NG/SG
         bBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740160152; x=1740764952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWPuj2YhQgRJTeYbcKezIFAIYdS2JuroZzEFPOXslew=;
        b=IGll6yzqRr2H+WPNBSkwULIdZHQRYAL6rthTY28MjnWQbt9J6p6SrsyWKBR6yLF165
         h8v3KBvoyWw6u8DXJVGOcLvLvxM/YaHusMX7dS+wm/g0GeIAeBYk/4Q7dwGEouEY5eLa
         n+dgAjCrMV/ZnQ8G/vfQBrKXpIVpUd121ZX1l9LbjWoCfrMXhg7vKZ3VchlJ9rzZAFEN
         eVasaXn9alJGYSdySEmuVc2aFFy/7GxUenqxKGx7END3+82zVYfj11Yy5hYbzIBC7qZY
         Al6moqxC1UHmZrb/TqMsBVs0wH4zplSqBOUxH1dz3puNOC/gwnkSI/VwaZwdYylTvydZ
         003g==
X-Forwarded-Encrypted: i=1; AJvYcCWd1YSCk9tdrTWzn8fHRjAJ2nykEaE21Q7IRY9tk9B5tOn0iVESj3CgGtWn3M/S7ydQ2RQi0x0oeS0=@vger.kernel.org, AJvYcCWwJ9WA583uQlP14Df9G30lTgscktSwb59weYm7QKu4/YuXVNE0RBcB69smA9qnMSIq/qHdVOM1gZXyqQ6h0E1ZULyZReaZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFbGwK8J/BebebV299Rv9JIUcIXTebOrxH4+YBn/rum29Q5tr
	sKBJKs0r9rn6qdVRu6BMOXtNr7WWNQxkpLG6YGJv1kVnTFcBR8LRXIXO1+U62OKAo2VL8MC2Oea
	2Q1YgV8YKX8EE/mBIUJLtJZ7RmLnpCA==
X-Gm-Gg: ASbGncs/pAxWhqsp69vGzaTtu3u/Y6rH/nk6jEtDTYLm/PZmOZYASIoYNfPcu8uMzoc
	02bFN/wrKUy9RXj6x4h+zD7UzHhbdRGnMGTETqax0x7ElwvPJXR8JxcT+bOgGNH0i2IJhuI0q0p
	lWHN6ie6E=
X-Google-Smtp-Source: AGHT+IEzL7k5s+6YpsRZE1VViRmEv4KUYpe6rKQpR6A7WIoTL1KC1p8B/26pxLNEyVPyTTXjqCFyUAfAdU5/K+AZ7KU=
X-Received: by 2002:a17:90b:1c90:b0:2fa:13d9:39c with SMTP id
 98e67ed59e1d1-2fce78ad73cmr7885485a91.14.1740160152475; Fri, 21 Feb 2025
 09:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8.ref@schaufler-ca.com> <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8@schaufler-ca.com>
In-Reply-To: <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Feb 2025 12:49:00 -0500
X-Gm-Features: AWEUYZk83rDJfBrv7Ag4KlCoFsWZxKW0ondb4Ts6QG2MiSbGqfIf9yWBUDqzqls
Message-ID: <CAEjxPJ6SnFnp773P-OP9VDjgs-D7XOC9Ygfk_MexKs9UdX73dw@mail.gmail.com>
Subject: Re: [PATCH] lsm,nfs: fix NFS4 memory leak of lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, LSM List <linux-security-module@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 10:59=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> The NFS4 security label code does not support multiple labels, and
> is intentionally unaware of which LSM is providing them. It is also
> the case that currently only one LSM that use security contexts is
> permitted to be active, as enforced by LSM_FLAG_EXCLUSIVE. Any LSM
> that receives a release_secctx that is not explicitly designated as
> for another LSM can safely carry out the release process. The NFS4
> code identifies the lsm_context as LSM_ID_UNDEF, so allowing the
> called LSM to perform the release is safe. Additional sophistication
> will be required when context using LSMs are allowed to be used
> together.

Shrug. This seems less safe to me but I will give it a try with
SELinux labeled NFS tests.

>
> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/apparmor/secid.c | 2 +-
>  security/selinux/hooks.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> index 28caf66b9033..db484c214cda 100644
> --- a/security/apparmor/secid.c
> +++ b/security/apparmor/secid.c
> @@ -108,7 +108,7 @@ int apparmor_secctx_to_secid(const char *secdata, u32=
 seclen, u32 *secid)
>
>  void apparmor_release_secctx(struct lsm_context *cp)
>  {
> -       if (cp->id =3D=3D LSM_ID_APPARMOR) {
> +       if (cp->id =3D=3D LSM_ID_APPARMOR || cp->id =3D=3D LSM_ID_UNDEF) =
{
>                 kfree(cp->context);
>                 cp->context =3D NULL;
>                 cp->id =3D LSM_ID_UNDEF;
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7b867dfec88b..b89d3438b3df 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6673,7 +6673,7 @@ static int selinux_secctx_to_secid(const char *secd=
ata, u32 seclen, u32 *secid)
>
>  static void selinux_release_secctx(struct lsm_context *cp)
>  {
> -       if (cp->id =3D=3D LSM_ID_SELINUX) {
> +       if (cp->id =3D=3D LSM_ID_SELINUX || cp->id =3D=3D LSM_ID_UNDEF) {
>                 kfree(cp->context);
>                 cp->context =3D NULL;
>                 cp->id =3D LSM_ID_UNDEF;
>

