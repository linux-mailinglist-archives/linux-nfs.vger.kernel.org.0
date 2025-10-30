Return-Path: <linux-nfs+bounces-15789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC00C1FA8B
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 11:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912913AD0AE
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 10:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1FE351FB5;
	Thu, 30 Oct 2025 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8qhkkMP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BDD350D42
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821695; cv=none; b=FkVb9uD5AD89LtqpdEA8jP/Q8z803/9SuUyjlfIdFK/5HmqjgZGloZRFVNlkU2CmVNRpq5WHbhR9G8ijJglR2R4kEaGMrAzSzY3XO8TPLPdG0jWVX8iPFp/uwOJ55WvD8zgUjjtjzIMSauDQnCq29BaQ0BpaWKo/X03EYVeDqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821695; c=relaxed/simple;
	bh=VsKvI4I90AqwEMhIC0vBzRF7w/0kfOEiYackbXTlZ7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=h5PEVSuCoErNSgBJ4gCPrutdEXCWvOPqOTQ88X+rFQIiq3TabEjVOm8al51NRgaE1OzHjxjXC87FxoWREeOP5wm1C/5TRuOWG77lYdd4eR7JvxC3gPYGrMQSXbVyylgQxb6EuX7w1WwWsrG2QI8+xOB3rVleMypxOmZ7SN/XVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8qhkkMP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so1594150a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 03:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761821692; x=1762426492; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsKvI4I90AqwEMhIC0vBzRF7w/0kfOEiYackbXTlZ7U=;
        b=Z8qhkkMPcfN6HwKu6KI4aG/qAMPoLh8DPtMVsRbGgn4iDcUvbVjDyO1wsrlJhz4QHh
         /DPoI4qYT9Ai5agDUOaFI4HhBBcmyNLNSweU8SBeKiz8heO5mR77b5vM1TQ0kM1mCegT
         U359iBCytNClCHwhYIJ1g0nEuwzOWHhl4+y+zTTNTnGZprhxN2MYF23WrBo9i+rcDO+0
         /bjqR3HSluRF1gFyuwDKToXvv4zNQyXgtLZZL2+JeFMm1HZ9Fl0i9OIBfAFqGMM9opQF
         vCI7US984/6rntVUq1QAp+5j/Rqs78FgxCPxZpwd/B0hZ3cjrv3LDT11EYbJpBXA9Goi
         IJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821692; x=1762426492;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsKvI4I90AqwEMhIC0vBzRF7w/0kfOEiYackbXTlZ7U=;
        b=Tddb1Hyh0VyGvB3FLwXCrKE9hya+fhPv5if5xOCeD4iPXCe0ftwJ7x3TAG7zKkwjgH
         xEgtv+2GyOLW+/jT920PwGxau7T6A23XvxCo4W87eaEJq5OglrHz1+2l2zsl21MPcTYc
         NVohOLsWaQ88RI3kzejpqFl36glFEsS3LPFIkjmywHmju+s/B0eWFKGw4nJD1IFsMkHp
         H0FiXkFAaRMwjxqNHh5YjPb9ccddStvqeK6D91f58UIgJYUVsTG1fVHwNsmUIoVXpcBt
         +HTJMY480s+jqrRfslOQNOEELXKlzRgreSOQ7XaHI+KBXgSthMKsgB5G1MekoAExnyoR
         Wp/Q==
X-Gm-Message-State: AOJu0Yyvm+a7wY/7f01aoLKGKfmcFK367CfpHQNLmnhIVZR6H4ddBp3g
	uJqAD7FcldnvYElnUuF4g4T7yxIxqFmjj4aSi2+abZQwsTwdTL2sREKpAniCxCikQsKRFhLlSoa
	ugniX9VG+XGZX+a1lGxTnEdSb1EWweE4MfrNe
X-Gm-Gg: ASbGnctw7ZmVUwWbtN69WzTAR/+4TBlR0798rb9897Fc4n93gb054wjD7PukAy9+8pp
	ik/OHUrNUpt1fce+dtJIXV3RRfPOJ8if+9Egm4kVnhSlcLzwtF7Ju+nptDcRypDpfwEKnWRxJWb
	PgwsnfYkQmKJAhi91YGFCqpoG/7EXWSHSmHeGRw2nIhWv3KSHXsgO4+bOy6R29hRTxUCLGwe7JE
	5F/M0zBWMZYwWNGG6TC1cdMKi4EXVJCYClbg+1w+57lbwh8H4cT0FO65OQ=
X-Google-Smtp-Source: AGHT+IEYgr/Xg3fvWK5xW90x3bEPli0Z8IzX9jiSMoo67IfLhrlnSj8vq45YMInta2o/5tWOkq7tZ0YskPchvj2hcBQ=
X-Received: by 2002:a05:6402:35cd:b0:639:4c9:9c9e with SMTP id
 4fb4d7f45d1cf-640441a9304mr5139974a12.10.1761821691749; Thu, 30 Oct 2025
 03:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1759357733-64526-1-git-send-email-dai.ngo@oracle.com> <CA+1jF5rAMkb44Pu8XGDnu9WUE54sHVf5TurMsQXfrUrmu0Ojjw@mail.gmail.com>
In-Reply-To: <CA+1jF5rAMkb44Pu8XGDnu9WUE54sHVf5TurMsQXfrUrmu0Ojjw@mail.gmail.com>
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Thu, 30 Oct 2025 11:54:15 +0100
X-Gm-Features: AWmQ_bkesHrSVkRW_NRZJH73xKln0uU7qYBmIJvJs8IYo8eMejO5JHBHxM6VusI
Message-ID: <CA+1jF5ovASc6zVHE7HA7MumKnpzvadGw_vyjV+ELttxv5tCCTQ@mail.gmail.com>
Subject: Re: READ_PLUS broken in Linux 6.12, worked in Linux 5.10! Re: [PATCH
 1/1] DIO: add NFSv4.2 READ_PLUS support for nfstest_dio
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 10:22=E2=80=AFAM Aur=C3=A9lien Couderc
<aurelien.couderc2002@gmail.com> wrote:
>
> On Thu, Oct 2, 2025 at 12:29=E2=80=AFAM Dai Ngo <dai.ngo@oracle.com> wrot=
e:
> >
> > From: Oracle Public Cloud User <opc@dngo-nfstest-client.allregionaliads=
.osdevelopmeniad.oraclevcn.com>
> >
> > Check for nfs_version >=3D 4.2 and use READ_PLUS instead of READ.
>
> FYI READ_PLUS is **BROKEN** for sparse files. It was working in Linux
> 5.10, but as soon as we switched to Linux 6.12 it reported only data
> and no holes in sparse files. We're back to Linux 5.10 and cannot
> upgrade because of this.

Is there any bug tracker where I can post this Linux NFS server bug?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

