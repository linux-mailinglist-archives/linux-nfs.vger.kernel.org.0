Return-Path: <linux-nfs+bounces-7551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABDE9B4B8E
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 14:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3730D1F227A9
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D105B206E88;
	Tue, 29 Oct 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB49cGr8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9555205132
	for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210261; cv=none; b=tenGl6sH6ZJUjDDoeUF+1UUOTTw3cfOufxrnJqKaZ2k87vHKyjegqJLUgH4U8z17b/M7z7FVV7hxgyaTXd9dNGwHyQeCW6lEr5QPlzYaCHPHWCET/PnBjiZbW+YNLO9VMpTWSPS/IfyRLLeb0fJSFtA47BKXVJdMcYNm5UuEH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210261; c=relaxed/simple;
	bh=rugsyP6K7WSGnYw5UhaboXgFMEC8fitCZFTMBWjqhG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nlIvZVu/7P47+h0MFDUmUkA26g1IHKJeRrxv55y8xsUKRZg7/hzEU0bu0miPENB5pSioFZ2961tkYLdwlgwHYo1/JQqPPZdN9NTgqYn7yDMPSIXHGX1e28IcMafodCF31kZ4H8a2OYFpz0TTUSx0JchT8pPZ0enQYC+rgyctSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB49cGr8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso805936566b.1
        for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2024 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730210257; x=1730815057; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Pc1qtBK7RCrO+7NpDxu0CrKbG5JCwHhYjlzR8jpx8g=;
        b=TB49cGr89ND4QOEIz34d1GL1oHtwQmfSK50cKgn4ZZPrR/NqX5pwp6Cbf2v/kdXwh7
         /wCfji/0A1ChtJHdR+rdhJT8W48js7+E13WOACaVKfnIfjSnOK5c4A3TcXS36mg7IYVA
         6PgE6LmnMWh75mHllMowX6+dXN4T20xbVt8YWEfdqfFv+O+FjPaKx9FAfkna+U2vMdY0
         B1DHXt+lqGKWnsP7vdYxt+MBGeH9hMuFNkoWKP6qt3UVdOdblpe0LeyLalXFckg7KV+z
         1FRHRH9E1Tx4aqK1cCAuakv047aS4+Y19ni0nMkmoRj0b3wXvPg0XFZgSQNmw+kafA7L
         +X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730210257; x=1730815057;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Pc1qtBK7RCrO+7NpDxu0CrKbG5JCwHhYjlzR8jpx8g=;
        b=jhCJcAS6itu2YC4rMrgdFhAdB7i4h81VzdYlN6fwtnoS1vWK9+Sf+8e6ThvEk0QHH2
         x/MfCcmtBLkb70JWFvYGycqKYB4YpDkdjQYC9nAJTDMBfdJFfn+teHRBrgVpVtc1OZyl
         U31T6GaDTbp9nPNbqxnnrOzBG4Ro+rBsHvxbYu5qFbGx94jQxq5uaiMnEqahB9++vNy4
         talFQG3ho6ETr8WsyXWoH8sQxkOJdBJLYrKkdIAhpAnm/GGMMJ0mSn38vQbfqtVsve/V
         qehDoT4mvGjVdigJqbCE/QE+Iu7TUhLmYHrUfrbCnJQgkY1vxkqe6J72bfC2IG2UlRZN
         yDHg==
X-Gm-Message-State: AOJu0YxDmHtT0XwYwxLp00KgDl+9FOk8ck/6lFFnmQJxEugj90mSS12P
	wQd0KPk9z5mSDB53mC1ynbbcOvq6r0QPqMhj3CVzY1KcgY4E8rkokezDsI1JbOMOs+3DEud8tnC
	36qH7hjXUJTAEQBFvLpnJWg28EFxcBQ==
X-Google-Smtp-Source: AGHT+IEZry0CcTTteL7x6OP2siEYvIj82WYTa3HtS5EIR5f5AUfQLCZfGixVnOakmiDR+yj/W3328OBletUcwyDLGF0=
X-Received: by 2002:a17:907:948b:b0:a9a:835b:fc8e with SMTP id
 a640c23a62f3a-a9de6330780mr1202512466b.54.1730210256469; Tue, 29 Oct 2024
 06:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023152940.63479-1-snitzer@kernel.org> <20241023155846.63621-1-snitzer@kernel.org>
In-Reply-To: <20241023155846.63621-1-snitzer@kernel.org>
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 29 Oct 2024 14:57:00 +0100
Message-ID: <CANH4o6Pi13aEtQW5-vmuJiuCNzx6tjn1+v=pLUpVMuffX-WkPA@mail.gmail.com>
Subject: Re: [PATCH v3] nfsd: disallow file locking and delegations for NFSv4 reexport
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 5:58=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> w=
rote:
>
> We do not and cannot support file locking with NFS reexport over
> NFSv4.x for the same reason we don't do it for NFSv3: NFS reexport
> server reboot cannot allow clients to recover locks because the source
> NFS server has not rebooted, and so it is not in grace.  Since the
> source NFS server is not in grace, it cannot offer any guarantees that
> the file won't have been changed between the locks getting lost and
> any attempt to recover/reclaim them.  The same applies to delegations
> and any associated locks, so disallow them too.
>
> Add EXPORT_OP_NOLOCKSUPPORT and exportfs_lock_op_is_unsupported(), set
> EXPORT_OP_NOLOCKSUPPORT in nfs_export_ops and check for it in
> nfsd4_lock(), nfsd4_locku() and nfs4_set_delegation().  Clients are
> not allowed to get file locks or delegations from a reexport server,
> any attempts will fail with operation not supported.

Are you aware that this virtually castrates NFSv4 reexport to a point
that it is no longer usable in real life? If you really want this,
then the only way forward is to disable and remove NFS reexport
support completely.

So this patch is absolutely a NO-GO, r-

Thanks,
Martin

