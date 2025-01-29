Return-Path: <linux-nfs+bounces-9767-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37BCA2262D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 23:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06510165E24
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 22:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6871BBBDD;
	Wed, 29 Jan 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ioK5yUBk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59851B6525
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738189725; cv=none; b=X3hqwVW4t4dJkSwWoq+1pmJWdrO5tUhEmRoC5yllISKvRGtO251yAUaPseeC80F+RkRtxoAMX1UeWuxZlHKgc5qYIneN8Hnn0rkMx78HqCdGKJM9o0BYNYFhMufnK+Y9wp3d+wytdcZaK6Q7PEbJLwBab2tQAdKkhbcb+j5HexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738189725; c=relaxed/simple;
	bh=8khQSChqyr5mnL1ClKr0fqhMGXuX/1gnRulsmKVeDWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3pHZ/5cRF/y45ZIplx+kxkLa6zw4SWeRApOFqFqz0/bUu8n0JSAoB2PXh2yjaaFJgff15f22ApwDLddl1AhWr7c/zc+kwOemy7JggXdirDeUOqM4aP4aQ+et8EIQGVfsd3JF4KN+zPJNPNx9a9MYSUWR50R+hpLla7M8NGavd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ioK5yUBk; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-304d757a9c1so1124251fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 14:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1738189722; x=1738794522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvaeJh/HTpeIeDdAvc3wkSB/7S2UtcQxvKIzaRpGnRs=;
        b=ioK5yUBkAFafseVNJQ3Cc7DPyQi2zF+az/SzPWHCyj6C6yJPUkgxXixHAN631shXVF
         QWKNdT/Wsn1/s9aeRrYxZAn4Qrp4BqIzmPK5bpmq7L2zwiHwrYGXnHFiBz7tHpUXOrtE
         DU6OEfZwOew7Ecc9iqrogbMSpCslNp6oM+mhLN9Bj3iQXoKF2pjeJkzBZIePuFSOmRIH
         UHTCRCfP5wkaRN9uUOMH3XeK1St4ish9KT99piSvHwTOVBGZjJKbQWBQkK0psGGSBpO1
         4gXNBhIuB+VnoCbAgwnKIoSFexBwazc/0Bs+IWGL6pcaUJOrSMT+F0ZYs7zoC9g6EWJr
         vjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738189722; x=1738794522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvaeJh/HTpeIeDdAvc3wkSB/7S2UtcQxvKIzaRpGnRs=;
        b=SonAVBJu5MFRyZL1XdRyPYJNozkda1LdkVh+ydAezwqdnGLYS4KdX/cZ1UmaVcAB/t
         lGri36Nrecmzwu+bjmcZV/3we3avI8zhvU3pJPveZv/hhcMEQXxHjWL37BOm/jWHAyK5
         GS9+UH9WPR88vrWD8hkf+reIj/v1oiKWJ0Z327WUPF2MAjISwNkmW6hbymvbptpMd0GP
         o4ji3SZbXW6O0s7CtY2NaZhqDUHEJOoOWbW6gTHuJkPF7gG7Ua+VLgbv1uGhIqHoaUBP
         tY0PgTwhkLVKGsAFzQwrOuEfOEwAB+UwncWVxJ0QITxFzZAgBIzSWQtu/ctrncSap8XM
         +nBw==
X-Forwarded-Encrypted: i=1; AJvYcCURjdf4jojku1Cdqw1qX0rHnv5tl2iMGK3170DASmpQ+Ybn9PkEZ7J56MQ6cq8Q2aE4hxbbIZc5fCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxycHp019dkfmACA2W/IFn6P4Ty2lROUjqBeW9Et/5op70iJhOQ
	4VOxb/9vE68f1hEV0OAHbh2GAUubiX+V8wUJdEjHCsqV8uFcVG8G9/jtT14aOiW9/QOwKlpltYv
	+zb89ypPODw7+90OV/MUky07Oa0E=
X-Gm-Gg: ASbGnctZzYgQVnrkQ+2Gevn0Pq71P8Uhf2523aQ91H7WeDo5KSTA5Eznn+YQkQKi8ir
	vux8/5rQ9EKNL1ab6OJ4o0k4T3F83z3e9N/kFddXvKI6E6NMOVomsGFHeUihe0OI0jx/SoP0TPA
	==
X-Google-Smtp-Source: AGHT+IH0PdOD6++iqM17r9eWaCt4lmLlAKlImEOcyBB797s6lTlags5+X5+ZItd8Z7wFYwpvZI2guBVr5iib8NUrqJ0=
X-Received: by 2002:a2e:a5c3:0:b0:302:2097:392f with SMTP id
 38308e7fff4ca-307a10bada6mr3136881fa.7.1738189721319; Wed, 29 Jan 2025
 14:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738185446-7488-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1738185446-7488-1-git-send-email-dai.ngo@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 29 Jan 2025 17:28:29 -0500
X-Gm-Features: AWEUYZkfOamsDc2WYytU0IRQu7lsQpj8ORWPmNOCdTjg6TzocqF-UP8QYBsLwQk
Message-ID: <CAN-5tyFsAF_V2-unOm5ceenzMnPZxyrfKeGWctRsU4LLWB+JMA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD: fix hang in nfsd4_shutdown_callback
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 4:17=E2=80=AFPM Dai Ngo <dai.ngo@oracle.com> wrote:
>
> If nfs4_client is in COURTESY state then there is no point to retry
> the callback. This causes nfsd4_shutdown_callback to hang since
> cl_cb_inflight is not 0. This hang lasts about 15 minutes until TCP
> notifies NFSD that the connection was closed.
>
> This patch modifies nfsd4_cb_sequence_done to skip the restart the
> RPC if nfs4_client is in  COURTESY state.
>

Curious, does this patch address the problem seen/discussed in the
thread "NFSD threads hang when destroying a session or client ID" or
that is something else?

> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4callback.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 50e468bdb8d4..c90f94898cc5 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1372,6 +1372,11 @@ static bool nfsd4_cb_sequence_done(struct rpc_task=
 *task, struct nfsd4_callback
>                 ret =3D false;
>                 break;
>         case 1:
> +               if (clp->cl_state =3D=3D NFSD4_COURTESY) {
> +                       nfsd4_mark_cb_fault(cb->cb_clp);
> +                       ret =3D false;
> +                       break;
> +               }
>                 /*
>                  * cb_seq_status remains 1 if an RPC Reply was never
>                  * received. NFSD can't know if the client processed
> --
> 2.43.5
>
>

