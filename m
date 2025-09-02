Return-Path: <linux-nfs+bounces-13980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3475EB40A6E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 18:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A671737B5
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9C0306D49;
	Tue,  2 Sep 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="m9VeAeMF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FDA2E0922
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830084; cv=none; b=qbxdd3osS1HCtITW1MnNvvy8rVG764kDW5Os+1dFtcIs7iaNS2WqlKmrg5oCdazyQGg59jJyryBfC4ZLXMZLBihPsgR25AAGsu3md8HYoA7+2Dd3/ALR0n95QNV78GhauVShf0LEpqNi71E2x6wkKEk+NCxwDayxIc8z+9mlQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830084; c=relaxed/simple;
	bh=3pam+aie+3WbD3JgnR+EaGBQjbLVCrLso0jJHUenFkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhqXrHmidx8g7HB78/ydAwgHHy9QBA6btIO6EFiav65mCJekYxP9Mo45Q0Vrj6pcmgI29BlHDJxBwn+CUJJhaOE3Wq4GVCDbi5DGCxL5wXJmjID2+nK5mmgm9nIXtgUuONQjzhgBnEePRJ6gaP/h6II6tciREGPU8IURBsQDE1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=m9VeAeMF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f687fd3bdso5555556e87.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Sep 2025 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1756830080; x=1757434880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xIRuMf9z53y6u8VC38GbF/N/vn7uA3kL0z8laQAy5A=;
        b=m9VeAeMFyGCyPDgWRTzdIFpzzN7622kxlSBGAfpdEKuF/i4wBh+Vh/tGS1XMZcM7hY
         1Y/qii1WGWXhPKmaH/va8FEVrvzi3w+6x/XpryXfkHdhgBXlHpUhHZZ4yIoe1E8DkDL9
         y5jnxUNfz302z8YKCooB7cgvGZpuw6WRW9jmGUeOfXWt7x5eNo6wY2kBAQ6bLt5TPApr
         aotLCwQrbx3kY4wkwi0oWVpN56+bWRe1PpQlL1A/h1N4YVA/viYgY2qpXj3NU15qNr/o
         OUs+2ONn5ci36NCuXgnbV/AxyPtMtlFKej+g2aJtHcdVvIYAiAtm+NSlos4YkEeDnwgR
         Du4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830080; x=1757434880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xIRuMf9z53y6u8VC38GbF/N/vn7uA3kL0z8laQAy5A=;
        b=pKfJwrH7rtl3STenjbQDGoJ2ghyWJ+AgB1XSbooNDvl6RdizzwHb5+tyf81VcvjA0b
         wAcW45NSqOa/mmDDhzlrjh0Zsp0Y/A/3PbYtnALUJ+vxY91oyR/bV25XKJZWiKZN/tW5
         U7rtSj2HlzpDys3RP6Hpa0vi2qTvV6G4n8vlAmu/pK4XTFFnVG/2H6kHTgvVArcem+5w
         6IxDRLZUizTnb25H6M6kdJEUq47RiQTrop5KE2YSgzx59I2LE+LMU8ke3wQKt7SbM875
         oTx2OZb5Jvv53kFlCve7HKpYCUKpVeVOT1idaS8nSwSpCK/VBqVHEDE6Mzh3scOCz0Y5
         RzFA==
X-Gm-Message-State: AOJu0Yyzp2bg6utNru5vjQIgYvqJX61Z0OcrT9iFgFCCdSNhkQzO4nrB
	CYNyblIqt8MnQ4IaBYe+hoXp33Sd0WVLeP5I9LekverHk89ANObXGHhF2OJvl3/DsA0VODdpZCD
	VJ74smbBaHdxa72O2oAVE5s+hSZEeRfA=
X-Gm-Gg: ASbGncselsVCrTvowNhBuxLQwm7NTSbQv9CTA2SUIMpEMMY/HDkwnDXXeXWW4x7/rFM
	PZb3ei18Gjv/nA7Nc8D8261tssByhToE+2LwK6N7JcwUvuO5NeHLe/ZI5UBMfjL90k6zUuWbKIN
	/H1LcgtRGLHp/cusGJQhMXchdy/T+F0xSPy0n4JuYXJQIvuJg/EqDsXNmi9wcfU837rD8i6rWG+
	yDdMH7CXnnLRQOufHqhtbQhECKQgICVOgDzEhneEHJy1u2uu45J
X-Google-Smtp-Source: AGHT+IFEQMhlBEujKMnaWcKJLzpGP7rUh/dh3D3DWbt64xu1wrIoXx8a0fW0wdS6Dal752XPRLdc8Sg61u6ZdGXDkcU=
X-Received: by 2002:a05:651c:1545:b0:337:ed76:7212 with SMTP id
 38308e7fff4ca-337ed767a08mr13692951fa.40.1756830079791; Tue, 02 Sep 2025
 09:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <966f4d30-16f6-4a11-8d6c-1d6102781e71@gmail.com>
In-Reply-To: <966f4d30-16f6-4a11-8d6c-1d6102781e71@gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 2 Sep 2025 12:21:07 -0400
X-Gm-Features: Ac12FXxYm6ktIG4ymhEEj58T-Earg_cjv4SSilPH8644XTK8HRATawJIvH0y3Wo
Message-ID: <CAN-5tyGHKCt0KhTt2jKNdx77H3RcgY-xPKwkL4udvciR99=rrw@mail.gmail.com>
Subject: Re: [PATCH] xs_sock_recv_cmsg failing to call xs_sock_process_cmsg
To: Justin Worrell <jworrell@gmail.com>
Cc: linux-nfs@vger.kernel.org, smayhew@redhat.com, trondmy@hammerspace.com, 
	okorniev@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 8:27=E2=80=AFAM Justin Worrell <jworrell@gmail.com> =
wrote:
>
> xs_sock_recv_cmsg was failing to call xs_sock_process_cmsg for any cmsg
> type other than TLS_RECORD_TYPE_ALERT (TLS_RECORD_TYPE_DATA, and other
> values not handled.) Based on my reading of the previous commit
> (cc5d5908: sunrpc: fix client side handling of tls alerts), it looks
> like only iov_iter_revert should be conditional on TLS_RECORD_TYPE_ALERT
> (but that other cmsg types should still call xs_sock_process_cmsg). On
> my machine, I was unable to connect (over mtls) to an NFS share hosted
> on FreeBSD. With this patch applied, I am able to mount the share again.

Thanks for the catch Justin. Indeed, the client fails to return an
error in case it receives anything other than TLS DATA or TLS ALERT.
Could you tell what kind of TLS message the FreeBSD server is sending?
Either a network trace or turning on tls_contentype tracepoint should
show what type the client has been receiving.

> ---
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> --- a/net/sunrpc/xprtsock.c     (revision
> b320789d6883cc00ac78ce83bccbfe7ed58afcf0)
> +++ b/net/sunrpc/xprtsock.c     (date 1756813457481)
> @@ -407,9 +407,9 @@
>         iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
>                       alert_kvec.iov_len);
>         ret =3D sock_recvmsg(sock, &msg, flags);
> -       if (ret > 0 &&
> -           tls_get_record_type(sock->sk, &u.cmsg) =3D=3D TLS_RECORD_TYPE=
_ALERT) {
> -               iov_iter_revert(&msg.msg_iter, ret);
> +       if (ret > 0) {
> +               if (tls_get_record_type(sock->sk, &u.cmsg) =3D=3D TLS_REC=
ORD_TYPE_ALERT)
> +                       iov_iter_revert(&msg.msg_iter, ret);
>                 ret =3D xs_sock_process_cmsg(sock, &msg, msg_flags, &u.cm=
sg,
>                                            -EAGAIN);
>         }
>

