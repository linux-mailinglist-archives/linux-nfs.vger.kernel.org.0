Return-Path: <linux-nfs+bounces-10278-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECACA40063
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 21:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9693A7D8C
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005B51FBCB9;
	Fri, 21 Feb 2025 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RkJrZFTe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300801FCD0B
	for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168401; cv=none; b=mwp9/QryJPtiyObdczwOVFAwFKH1/1KBq1CX8SbuVzHOOuCf6n5mSxfn4PD4CghcMNTICY9MgF/JmwL3apLgWv+0xzUbQKESiEqAHv9Hl81H21/urYj4PXhsAU3KWBGv9o2L3HoUp0THpo7j6o9hUslyPlBcNR0dzKZqtl9xg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168401; c=relaxed/simple;
	bh=9Z/mN2YSF6eh8sXWEhYPPWlb7NMi1cNsA4ai6y2hDz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrO76w5VbkbVQQFBgNH35OOmt3oUdPP4LywZid19SCcuQ6W6clEuEbq6sbAhKAqS+5Y4fNBFAiLeEATDPzAxKeMWTbXfPNYfgEUkY0ftkqPu0US9n/shix6x1BsYX91BfhZidI1f649phkKiXTsNA/nayTqJx640gUaD7zeE8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RkJrZFTe; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f6c90b51c3so23666747b3.2
        for <linux-nfs@vger.kernel.org>; Fri, 21 Feb 2025 12:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740168399; x=1740773199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAkKzhCP2EY8GRlMH17ObQbxqg/W96HoszdnirU+/Jw=;
        b=RkJrZFTeQB5lWwsfllhiTRJ/YNpRaL9xE1cby7AO/Relrlr8e1VPNzGXNCWXTibMlt
         3X3u9LEdQbA6jzwp5o6R2vhMrERPr+CfPYsLv6OGRMehgmmlaTGBnicmw9Vr2fo2acQM
         GwqKcpihjt3zuldjzr+YUOH85Z1WT99bJ7QFFun9pIrv7wpit4EnZDAIBrCkyrdwNdK5
         B3M72707OcYnIBPy33p7OWcAsOuKKpGgea4vVCAYZ+XmmAjV0Nsw/cV+DJ4+dUQ74dAf
         dZuuYXTQHm1L5QB4bCwy0Zi4tHrjS0RhlEgQvqj3zCkZvpJVNwDThEnyM/kzyHDzg4AP
         Jldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168399; x=1740773199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAkKzhCP2EY8GRlMH17ObQbxqg/W96HoszdnirU+/Jw=;
        b=j+GDtO/MNfpHLPOxdup6vXlVK4pqUraxG9SYL1jVLmZIPY460oYbBu7l1uZerRX7sh
         CLe1ggDq+lbj+nWMbiwAQlnr3EVfpf6DwwnprJ0sxqyfyQc/AhLjLgVo5IG2oXwKMiLm
         SVz6WSq3DwBdBzOyB0lcZoJlgF/WElrXTUldh1SH6y2UDom0QyvEUBZaAt/h15OPQKg6
         XVrlmdhq3+0ra0INj+ENLLYiigzjz74qRSVA1rXuORUlx2sA+jAK5SfrPdIqT2APCoUc
         Rgqp7aCfypMKrUTQKzaCgbZBYG0S499OZcUdwT8UY5qPOeHquOdgALTqRo/PYDiEktm2
         zs4g==
X-Forwarded-Encrypted: i=1; AJvYcCWpnFa12Vx7kVwUNhY1FAHTJwxXGnsG+bnW6HG6hWi0sR3q2kxOMZDUYU0IuLsSdlOhqW+/KyHO+4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyocUfobzPrNwQYJcS+geNbDzGc2kK9gjnjDnW4DUDQGQeaiMS8
	x5sAMSSzE/1YgDPZO/Qvni0bPFAze7M+ZIZ+I9fUMDYK6EiR3Un4fBqZp28m9OJhFgoYkP9Eo4L
	Kr4LIQKiKhct24HEdYWgneGyvC8s5CcO4OfxZDlXnxYLhBPGQKw==
X-Gm-Gg: ASbGncuel5O+T2oC9OAKuIQhXcwcDv8UYSCWLWBhmSjgT1xt+s+AnA1y4ZezmgswU74
	UjsXtV1Dosqxu8pZi08NflIv4omfGYXS8tlU9V/AJwe8MQCtKWqRc0heAjRapcKBZpe+hRfRMWS
	cxFPLV+bc=
X-Google-Smtp-Source: AGHT+IH+bi1IQ67FGfvj6F36iu81ZfMYdTISAGG3tReWwtD8h4lwBO6Mc2ZXwk8ymaJD8f9gOn7AxN97v2x7wWA1TlE=
X-Received: by 2002:a05:690c:6c05:b0:6f9:acb3:4434 with SMTP id
 00721157ae682-6fbcc286578mr44334477b3.19.1740168399103; Fri, 21 Feb 2025
 12:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8.ref@schaufler-ca.com> <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8@schaufler-ca.com>
In-Reply-To: <d5fa8ace-8bc4-4261-bf34-c32e7c948bb8@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Feb 2025 15:06:28 -0500
X-Gm-Features: AWEUYZkqEWxJ97T2jz81KFUtk_fM7bnmKZyBYz1-HDNB-UBQ9ufxy2B7oyLLnZg
Message-ID: <CAHC9VhS-QHMz4Lza2WDXwt6sh6s03U+-12RcaPGJYVLBBprT7Q@mail.gmail.com>
Subject: Re: [PATCH] lsm,nfs: fix NFS4 memory leak of lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	LSM List <linux-security-module@vger.kernel.org>, 
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
>
> Fixes: b530104f50e8 ("lsm: lsm_context in security_dentry_init_security")
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/apparmor/secid.c | 2 +-
>  security/selinux/hooks.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I'm sorry Casey, but Stephen's patch seems like a much better approach to m=
e.

https://lore.kernel.org/linux-security-module/20250220192935.9014-2-stephen=
.smalley.work@gmail.com/

--=20
paul-moore.com

