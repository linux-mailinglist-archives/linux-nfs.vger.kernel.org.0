Return-Path: <linux-nfs+bounces-3571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCA08FD2F4
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 18:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8AD2811F7
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jun 2024 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D97079DE;
	Wed,  5 Jun 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="WxJdjSB0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE667155A4D
	for <linux-nfs@vger.kernel.org>; Wed,  5 Jun 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605071; cv=none; b=rIOZiMMvPQImoNtocp9YR1oxerQaGUZsi3mzZ9s5Rh2CBuN+yNrxwJQ/VJXEL83a9oO5InRlkeXIwXVWAzv16Ks10Lx9MQ3Cn+Faeb3GXOQKxHFR5C7N0l718dhWbzY6YUXYRQltCtOavDFhSSJBP7pWdxrQnifccUiWB7f8CUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605071; c=relaxed/simple;
	bh=zJjkYApEyvblK8pH15PFceKRR+2eoUJckgORzNrtyOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1GSOs8f83zQfYnOoeEDpMoP8c83nqupYycAgPJMcRq9P9r2ARwo6ropetD5VaGruhNow8oFlnwxHnu7JaL8MYOQ7plTnZHmH/3limq5M34b6MPwiL84xzbin0rZzunhLl+haKgxpsVnk4i3GJI+itvKtv/nfYCrUaLnwCHJI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=WxJdjSB0; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eaa0075fefso5235481fa.3
        for <linux-nfs@vger.kernel.org>; Wed, 05 Jun 2024 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1717605068; x=1718209868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJjkYApEyvblK8pH15PFceKRR+2eoUJckgORzNrtyOk=;
        b=WxJdjSB0BbDyZ3Whwzx3Z4Rea1ZAuUdInLSsp4rLGO9ZtT7+k2kV9lghIFqZ2dNtLR
         8ySbaS4w/fgFUlkRzsWKoa7fDhjwxiQh2Ovkar7cM/2tEW3k8Mpzi1kO51gjAITTPP0D
         +eP1D1HB3hGTcdCT73umGQ9vhxu1zc943U3foM24QZY74TXBDct/UXZIrcHOEzkZ3P5K
         t7pjtchYmD8aBviZR9BO1RabQV5XhxFekFf/9GHEE3HNrzofoOzLsmS0Zx1asPX2027B
         0fjuuADPA6lEG61IBin5FUDqnV5NQ2MXTNcyGHm+qNA0H/x/thsCwMowcwjdzlx1LVrF
         Tz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717605068; x=1718209868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJjkYApEyvblK8pH15PFceKRR+2eoUJckgORzNrtyOk=;
        b=qUnuV3r4B4N+RSiRtUgA4yjABTuSbSevN7wwWMQ0ddNVp4746Z5IsM1bzUUOtI2uB4
         CKxTykrHd0TfrwXQLCly9GekIoYhjwjKZpThIwHyhaEAYiij21YAcl1Z7GxtAY1WEQhl
         NDCj5By7/WVfzwglRttqpuI0rgFaLupkAHF1rRQvvcQ54nr5H9AGHzbexLFSOM8U43QR
         GtHEc1qfXWzV7kc5MF/Wrum6wBG9zcJabwk+fwTiIBR1TRzY6yplP4uhFy82fpG//T7F
         xnlcz7nytHftF77V1Hl6PcttqzjkbXeecmwKESbltJqjiZES11aEyeJ9iS3F/BsARed/
         BXjg==
X-Gm-Message-State: AOJu0Yz0/40UU+BxMWxQa0K7iOQmq7FOkQ4Z+rcMk/kJPCBTE5Y2CcGp
	gxJMa60LSF9rcC4crjkgHOAjiwPz0jegizvvzCpRnEw6z6cV005LnWkm9V/45lZVCNcjLFQtpCB
	94TLBNz1Vd4dg6xSzluukKohkfzJHmA==
X-Google-Smtp-Source: AGHT+IHOylmI/HBxJOAhVvDHP1UTNcJ9aBvgUiA49PENMOTljvAuFu0sv3awjFuGs2d0cAn8ch6b0xMyATNhM1+Ypt8=
X-Received: by 2002:a2e:3318:0:b0:2e4:c5fb:f3ed with SMTP id
 38308e7fff4ca-2eac7a91d4dmr14763191fa.4.1717605067734; Wed, 05 Jun 2024
 09:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-5tyHghLR_eSoPq_z18_XvdySKNrWpPKjuAd2c97KKqYGjFg@mail.gmail.com>
 <6E31172E-8991-43E2-A9E0-88FEAEDDA00B@oracle.com>
In-Reply-To: <6E31172E-8991-43E2-A9E0-88FEAEDDA00B@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 5 Jun 2024 12:30:55 -0400
Message-ID: <CAN-5tyFVWm_p4tT1VYfmVxktsycn4K_v_KH_BKyzJ80-1rnmZA@mail.gmail.com>
Subject: Re: NFS with TLS on 4.0
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 11:37=E2=80=AFAM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
> Howdy -
>
> > On Jun 5, 2024, at 10:34=E2=80=AFAM, Olga Kornievskaia <aglo@umich.edu>=
 wrote:
> >
> > Hi Chuck,
> >
> > I noticed an interesting behaviour by the linux server. If I were to
> > mount the linux server with vers=3D4.0,sec=3Dsys,xprtsec=3Dtls, acquire=
 a
> > delegation, and trigger a CB_RECALL, then it is done with gss
> > integrity. Why is that? I thought callback is supposed to be done with
> > the same security flavor as the forechannel.
>
> The CB_RECALL is using the same flavor and principal as was used
> for the SETCLIENTID. That is all that the NFSv4.0 spec requires.

Thanks. For some reason I thought "do state operations with krb5i was
4.1 thing and not 4.0". But I can see now that this started with the
client doing SETCLIENTID using krb5i (even though mount was sec=3Dsys).

> Remember that xprtsec=3D does not specify a security flavor.
>
>
> > But then also callback isn't done over TLS. Should the callback be
> > done over TLS (and it's a future implementation to do for
> > client/server)?
>
> The NFSv4.0 backchannel could be done over TLS, sure.
>
>
> > Or is this a spec restriction/limitation?
>
> The NFSv4.0 spec doesn't know about TLS, so it doesn't take
> a position about requiring it.
>
> Unless there's an interoperability concern, IMO standards action
> isn't necessary. We can definitely say, though, that a prudent
> NFSv4.0 server implementation would choose to try TLS if the
> forward channel used it, and a prudent NFSv4.0 client would
> require the use of TLS on the backchannel in that case.
>
> The Linux implementation does not do that yet -- TLS would
> protect both directions of operation for NFSv4.1 and above,
> but for NFSv4.0, it doesn't.

Thank you for the clarification. Not sure it is worth the effort
(given we've been discussing deprecating 4.0 anyway) but it answers my
question if it's a question of implementation or spec.

>
>
> --
> Chuck Lever
>
>

