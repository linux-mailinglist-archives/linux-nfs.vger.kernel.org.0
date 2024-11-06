Return-Path: <linux-nfs+bounces-7730-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387509BF7EB
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 21:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A32FB22A12
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 20:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900EC20C010;
	Wed,  6 Nov 2024 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="cKRy88Rg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8003320BB5E;
	Wed,  6 Nov 2024 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924446; cv=pass; b=JEOEfjViaHSOlyx4vkESdfAVAKhGhvJPs057k5NKT+wi6ArrdPjc+mVWt1EK78fA1VjVFP82PhF9g+bJRVzf2eh3C/93fauDORc3UF80tc0EGW6YPMKyRYfNbEpbcHM9IQj/GVKnx+VO2Am+RuO2len6OmcEakmoDEVnPPavvCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924446; c=relaxed/simple;
	bh=rBQHWtkz/Ui+XebkeUm4wexmgRPBsPn7T2/0TEjcn4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=f8HtLifa5gXDwrqud6hsD1n83jjaYuyOqSrB0rxHGyxazUBQyxOCQc0xpj9uV0Y1fvZoRBsl6lXSbKHaTphFrfRJPLqyRUPou9L+EV2Qnh3VVVo+KY47OxSkS2JWF226m7CMTNtuc+M5KpC6KMuaUUCEx7RQH7f0pBXtdzuA/ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=cKRy88Rg; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7F6FE4E2889;
	Wed,  6 Nov 2024 20:20:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (trex-5.trex.outbound.svc.cluster.local [100.107.241.67])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 34D4D4E70E1;
	Wed,  6 Nov 2024 20:20:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730924438; a=rsa-sha256;
	cv=none;
	b=3nT81WLyvqdrKEdq+2z7lXYrodSJRn+W/jgr4Q6kJTbjC9FCe40ZXnTOVfwhYG6VxICifr
	l//BVuaf9hI+P/7gt545ABYNT/6A5J+m9DZMXd+GoMKU5Ve+fL9d6rftKBByFayP35H8tw
	rooI7Ij3mNf8tovG2oRLR7h1S0k7jyfH/X7vkyNoNI4Wouz/4iU/nH2ctsRAXlJ3xD/Qah
	CpqmtKUXO0vsvRfjWKCkYSDQHN3YrK8pwMflwK+PC84igcRCl24HZQW7TlV5+SsbkIe4vM
	ruwzHYmO89JPLB/0nYd5cJAEXmnyDO8zoxSVYNmozxlaFzCk62Ga1PZVTf+73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730924438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WY2anYNfn8k8GJEnwFB8BFpcgKAjDtQGklhTaZXRZV4=;
	b=8ZfrXGSslbK6yGVtEgaxbNXk7xW2pBCFx/rsC5Xf7VrnWMsCr0JRTL/HVPmcJnILL9fsY2
	q861ZsasAfZ41oaVFbfhajrHBFki1zKTXfOUOUv5vXi8XjLNfkAERv7E0ekLk3N23trnri
	JW+1v5Xu3kY+4qQfyjUIxtfQpThAlqiqACR/bRjPciLEY2HuFyzmyQxsAgRhXU/wtclYtn
	NNxY3BXCa1lA4QOuumSG+pUSJ1FnmZ/V7JxjXbVjbMfr0nvkUpkjlpIyC0SuUlc+oOZqq2
	NcpQZ9/+TBPm7KknJri8XfETLGAsWbRd8JwdTMYXKTVsiFVQjiRHPeVI45uCeQ==
ARC-Authentication-Results: i=1;
	rspamd-8b6b4986c-82rpl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Thread-Little: 4092f92d69ff1877_1730924438424_569367905
X-MC-Loop-Signature: 1730924438424:960644043
X-MC-Ingress-Time: 1730924438423
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.241.67 (trex/7.0.2);
	Wed, 06 Nov 2024 20:20:38 +0000
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4XkGmQ0HlPz61;
	Wed,  6 Nov 2024 12:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1730924438;
	bh=WY2anYNfn8k8GJEnwFB8BFpcgKAjDtQGklhTaZXRZV4=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=cKRy88RgOEDs4Rx6whPnEtqT4fdY/inbH4a/tYSNZYn0EVpU/+B9cV6PCfIbhJKmT
	 53KEaxP1a8kqW6jUJ90Cy41LrxtZr6aUAMPszfGEKAOkpT3GrrxOeSuYPRFtRhqq/z
	 5PtHMnq8NmO079PLVWKph8LzoQx5ZtOW2uVKuQgjPw4QxY9fP0OYxnTO4y64KJW7Wc
	 2JTcuijjq8QGll2cTTqp+jHJbQLHuV3SALuA4Ru5v1+O2pdlrMh1ilP2iYjAehzRMl
	 16LDkX+0Q2afBTfFKypBWAarVxmWeTr/Pw0DWisVfgMMHAfMlmZaU0FDnsQZm4zVVe
	 kN+s50usc+yQw==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43158625112so1946035e9.3;
        Wed, 06 Nov 2024 12:20:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQTl634XFeg0Gin5kN0ulMoj/ZJXUYC/qnslmW8Ai6F8owHdeZbbESDH9XDL9BBDP9jcgFIXdTRe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIPf78pKVrPaCuZqrxEBi7nfvsFaEdo8M2YMBkx3Wfvu/+fJuD
	WCtM3/jWY+lLFoKrXOrtlbz90UOvg+Fe7OBn/1tqtkQrEPSksH8bEh9xTChkKZjT0IAA3tcGdbD
	2qg3IlLIbk9zB9rSZXqIr61Pu5uE=
X-Google-Smtp-Source: AGHT+IEfW5V9bBuD6U2TxP0vhjN/8Z2Cb2s26E+5dRJhqyDqQ9MwyQn2tqPXIVStSLx6o3Fy7jDPS1fnV0VCanUIlUk=
X-Received: by 2002:a05:600c:4f13:b0:428:1b0d:8657 with SMTP id
 5b1f17b1804b1-4328327ec47mr167830195e9.22.1730924436758; Wed, 06 Nov 2024
 12:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106024952.494718-1-danielyangkang@gmail.com>
In-Reply-To: <20241106024952.494718-1-danielyangkang@gmail.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Wed, 6 Nov 2024 21:20:10 +0100
X-Gmail-Original-Message-ID: <CAKAoaQnOfAU2LgLRwNNHion=-iHB1fSfPnfSFUQMmUyyEzu6LQ@mail.gmail.com>
Message-ID: <CAKAoaQnOfAU2LgLRwNNHion=-iHB1fSfPnfSFUQMmUyyEzu6LQ@mail.gmail.com>
Subject: Re: [PATCH] nfs_sysfs_link_rpc_client(): Replace strcpy with strscpy
To: open list <linux-kernel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:49=E2=80=AFAM Daniel Yang <danielyangkang@gmail.co=
m> wrote:
>
> The function strcpy is deprecated due to lack of bounds checking. The
> recommended replacement is strscpy.
>
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
>  fs/nfs/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index bf378ecd5..f3d0b2ef9 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -280,7 +280,7 @@ void nfs_sysfs_link_rpc_client(struct nfs_server *ser=
ver,
>         char name[RPC_CLIENT_NAME_SIZE];
>         int ret;
>
> -       strcpy(name, clnt->cl_program->name);
> +       strscpy(name, clnt->cl_program->name);

How should the "bounds checking" work in this case if you only pass
two arguments ?
Per https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
|strscpy()| takes three arguments...

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

