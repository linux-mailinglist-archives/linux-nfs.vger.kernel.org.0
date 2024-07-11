Return-Path: <linux-nfs+bounces-4791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E44692E1AD
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 10:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1D71F21759
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C7158845;
	Thu, 11 Jul 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSPGvOY1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705B156C78
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685429; cv=none; b=XuDGetlul/XxYDkXsKCtmMMX5MWJDCPBm+jaHDibFMZtRFk7IkybTcXXrZKd49J6NcHaxUVXRBW9qsPzvXPtRFDVt1swxjf9izCB7YWrHgTmz3TwWXiiWyyVH9RULFPVKtvVGzNb7EFitoNReKWhfSNVt5pwW+Z9clcsoLcsHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685429; c=relaxed/simple;
	bh=4Dm1S647QuhG52yFRcxmuqg1+0TnPt6TATZPM1rme5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pepfsyushp3L/eUj8raAWGsncyV0LLW8LPC/SufUh0CwNgRIydTBxg2NAZODOqGJ+O8ofU3/SmZRAf09eKSzSJSTQ0EL7+YDc27iRAzdaAC1mDvhF2IXJh1NefeY0kLdnmn8mL5NC5m/5D1ETNh4VQfARbqyjy+f/Canze1UY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSPGvOY1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720685426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TdS0Wy1DckswTB4YcmRy7IeL16kEGLWFdsx2mwsFU2k=;
	b=DSPGvOY1BrbYANXqYugwGPTwABg70Vu/Mj0tmva7kzFHyDd2ygZIgpfDeDGFmihpTSvYLu
	Xp4XAOlCRk09YXbeCoRg4uty6mrFLiI8wG56ce03ZMUXFrEI9ESG2Y7x+9dlJA6c+E99z4
	E0XcMBPCVivFtn1gcQvRkBFIzPWh0ws=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-cstQrRBGMiqPxN6vghAI2Q-1; Thu, 11 Jul 2024 04:10:24 -0400
X-MC-Unique: cstQrRBGMiqPxN6vghAI2Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367b340057eso110269f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 01:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720685423; x=1721290223;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdS0Wy1DckswTB4YcmRy7IeL16kEGLWFdsx2mwsFU2k=;
        b=ahr6jE6zxwQWvOv3gAdHc4t3WDenkLuHRo/V069MqtU/CAEDTKSHI19q2SopLfq1gu
         k8reaIl8CsetDacJWg0B87d8jUTUPCYVIvmd6mkhK3qt4X2w6NxGIUpTp4sB2zjcU71x
         iDVexJYhjLtVX6o5nhTdDIgLdtjXDsC3Gd6Dq8hazUHzBOM8+/087KnsV0qayuOFV1Oh
         suDzxceZEOwDXQBa/GmOIil59wya5/hu+Cq72HUWbPPu281s6f7KayJSrriybjf/bv+X
         RV76Z7PPQAc14MyxCUjJcSoRxBPXsGIXSgLOMlCKQNLunvicfgsgRdMpInnx/ajZDj8S
         sQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl+txSRs2tevk3t1mxKHU/9YTlM6vYKH9W3HI3EM7lfPgA30pRvxwnmTte9l8MlRFRsMXFG+h/Jr4ph9AtKQEu30HnK6w0+1I2
X-Gm-Message-State: AOJu0Yys0sm+RfKC115HkwhIfXe5J5BMlL6qj6T4GodWKRFw677cEbLZ
	JBG7bn1ZShw82h1nCl9UJy9ZMc/GfJjD2pJtgizKk6eaD4BtG+2fyuF347kOImTOkcF5th/woSU
	j0FuqV7yTLZpA6LbTsDplByAIEi4T2LE7lePvsF5sVscs6GDGbv31iltPHg==
X-Received: by 2002:a05:600c:4455:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-42798351f5cmr10881125e9.3.1720685423540;
        Thu, 11 Jul 2024 01:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElzM+sw870rfkPgePYVooHaTzeUqLqwFgyMQq+O/JDnO1UafyZgXlm0FRqsiFZiWGuVUnSVw==
X-Received: by 2002:a05:600c:4455:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-42798351f5cmr10881015e9.3.1720685423155;
        Thu, 11 Jul 2024 01:10:23 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1710:e810::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266a38f5a5sm145105145e9.43.2024.07.11.01.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:10:22 -0700 (PDT)
Message-ID: <056562ebdab1add954ad19b3d78d9d5736a81190.camel@redhat.com>
Subject: Re: [PATCH net v3 resend] net, sunrpc: Remap EPERM in case of
 connection failure in xs_tcp_setup_socket
From: Paolo Abeni <pabeni@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org, Lex Siegel
	 <usiegl00@gmail.com>, Neil Brown <neilb@suse.de>, Daniel Borkmann
	 <daniel@iogearbox.net>, kuba@kernel.org
Date: Thu, 11 Jul 2024 10:10:21 +0200
In-Reply-To: <d8656bf85a142aae001e4275fcbc195fa2da8473.camel@redhat.com>
References: 
	<9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net>
	 <d8656bf85a142aae001e4275fcbc195fa2da8473.camel@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 10:22 +0200, Paolo Abeni wrote:
> On Thu, 2024-07-04 at 08:41 +0200, Daniel Borkmann wrote:
> > When using a BPF program on kernel_connect(), the call can return -EPER=
M. This
> > causes xs_tcp_setup_socket() to loop forever, filling up the syslog and=
 causing
> > the kernel to potentially freeze up.
> >=20
> > Neil suggested:
> >=20
> >   This will propagate -EPERM up into other layers which might not be re=
ady
> >   to handle it. It might be safer to map EPERM to an error we would be =
more
> >   likely to expect from the network system - such as ECONNREFUSED or EN=
ETDOWN.
> >=20
> > ECONNREFUSED as error seems reasonable. For programs setting a differen=
t error
> > can be out of reach (see handling in 4fbac77d2d09) in particular on ker=
nels
> > which do not have f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -e=
rr
> > instead of allow boolean"), thus given that it is better to simply rema=
p for
> > consistent behavior. UDP does handle EPERM in xs_udp_send_request().
> >=20
> > Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> > Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> > Co-developed-by: Lex Siegel <usiegl00@gmail.com>
> > Signed-off-by: Lex Siegel <usiegl00@gmail.com>
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Neil Brown <neilb@suse.de>
> > Cc: Trond Myklebust <trondmy@kernel.org>
> > Cc: Anna Schumaker <anna@kernel.org>
> > Link: https://github.com/cilium/cilium/issues/33395
> > Link: https://lore.kernel.org/bpf/171374175513.12877.899364290808201488=
1@noble.neil.brown.name
> > ---
> >  [ Fixes tags are set to the orig connect commit so that stable team
> >    can pick this up.
> >=20
> >    Resend as it turns out that patchwork did not pick up the earlier
> >    resends likely due to the message id being the same. ]
> >=20
> >  v1 -> v2 -> v3:
> >    - Plain resend, adding correct sunrpc folks to Cc
> >      https://lore.kernel.org/bpf/Zn7wtStV+iafWRXj@tissot.1015granger.ne=
t/
> >=20
> >  net/sunrpc/xprtsock.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > index dfc353eea8ed..0e1691316f42 100644
> > --- a/net/sunrpc/xprtsock.c
> > +++ b/net/sunrpc/xprtsock.c
> > @@ -2441,6 +2441,13 @@ static void xs_tcp_setup_socket(struct work_stru=
ct *work)
> >  		transport->srcport =3D 0;
> >  		status =3D -EAGAIN;
> >  		break;
> > +	case -EPERM:
> > +		/* Happens, for instance, if a BPF program is preventing
> > +		 * the connect. Remap the error so upper layers can better
> > +		 * deal with it.
> > +		 */
> > +		status =3D -ECONNREFUSED;
> > +		fallthrough;
> >  	case -EINVAL:
> >  		/* Happens, for instance, if the user specified a link
> >  		 * local IPv6 address without a scope-id.
>=20
> The patch looks sane to me. @Trond, @Anna, are you ok for this to go
> directly into the net tree?

FTR, I think it's better to have it in today's net PR, so unless
someone scream very loudly very soon, I'm going to merge it.

Thanks,

Paolo


