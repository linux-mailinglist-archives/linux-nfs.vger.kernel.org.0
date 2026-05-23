Return-Path: <linux-nfs+bounces-21858-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBFABmiNEWrHnQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21858-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 13:20:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5125BEB07
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 13:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D30D3011BFD
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638CD388889;
	Sat, 23 May 2026 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amtVA1oW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8CC388378
	for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779535012; cv=pass; b=Vd3c5YZxgHdZjITuGz8ViPmawi0fFPM1nDzJ+hI8MFlKxsigiEIG/KoaXTWrrPx3EHARCZieWd9aeAIk1QqvYpTcvXvv2X5MAys/GSJ4XfskNYk0NQBFG38MAmwbtcwx76gQjUOARjSs6OO4thU1YNhwJKcBV8oL6rXJTPuBqpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779535012; c=relaxed/simple;
	bh=NypGMlp3cyhLiUYrJBvQ/DxQ//zQTlSSSmvew8byhDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNsJxMS/b2QQXh4GSjrTPZIG0y3Om8fZ5z8O439J7qJ6g2+JG/WPz/VapHqZiC0+iTFAnxMO7wl+0ImBAT7loi2OnPPeuNTRGLpu4zIQC8cMsK10a2nyVxf+rFmsPb1yifgiSzVTcMs+A5fxlBmr13Ps8DtzfK15dWGq14NZFoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amtVA1oW; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65dd9b25829so6456536d50.3
        for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 04:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779535010; cv=none;
        d=google.com; s=arc-20240605;
        b=JMhdsx3WZL2QkNrxy+ZVlQGvO9C6ybrYSknOLGBm8vf6KrXOEkkM1t17fUAKIspIgt
         O5sCeShNSMmgZATjHGVQOmmORmiq7+UsxQgmzJ2s9YCfCODEDUjyVG7DTUvcwpOH7wz2
         UTkvDEfG3g5ySh9Fa5rELYhCLnTV9vimtbqiuT6LYWgjrf4esQaI8sm2Z5lzuByn8eY9
         4bGWBJ0eCslJO+vogTljrppEwvqY0ECDTLG5kd9oiz1D0LIhCxpTYtv1emJeTyW5AiXN
         NhtwTMRNL6c+ND7kF9VShrdKj3KHiox9ZswtktX8KBilKYnyinyTxNdVUMyLeKMyAZKE
         EYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SdF6tpQVLDhXweuUd49vYyzxySvvSzPJQt+DpMGXwZI=;
        fh=AhMbZhFrhPGCs/H8JjEaGZokb2ghDJLaaLQkTkQz48Y=;
        b=YfOjO3HzipntvMdUZDNQVzjl9rBr5bc2sqtrPCiJxBM/zvs9Axaj7eF/um54/bHSfW
         /C68DuHGukM2DiFloDaHNBfenEOWWdxJr2eWvEXoCcegwL59Q8NxHp+c+jTZy54K5uxR
         iFvCIGoePErtLqnzOy+C82oU6iEeBYBWNoZoEiYiF/e7Sg0ZOOg6uasIEdzuJuRFYjE1
         hvYdls+P8yGB8Z1FUqfPhRJehMFdniVN2xeu4VEXrkbBue8VYUtAjMW62EFvTnxWUYzZ
         wcTbFPCFAzQIcBEWyKqzc75tQ6PYSqAxiwx430hwSfl2uC9Ob4SuGhPYPJPMpqcBWH9e
         eNUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779535010; x=1780139810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdF6tpQVLDhXweuUd49vYyzxySvvSzPJQt+DpMGXwZI=;
        b=amtVA1oWQuwPwEDiftcxPHNm8z9z/6MfaFGXc+GAc2TXErUvbx2LO/WBrmvMQHXIF2
         ivW1lnrY5tJwowYBzl77t52YOdc04AeTJHm9CgZNipPu+jwwR/llL9sP6W/vEihRTlyY
         TGXchZUXOSJuGjMY8lHEyK8Ui5e6zdIIIq1SNjpNing4uMV356++TrbZQESUVUhfeVx0
         sFhimYDQRhHuaxkg5hK1QhJJVr6PO40sYzD/e7d3suz0CmgWtgcY0IZC5ecQ5yGWq0tS
         dPvw+0AiW8yEZzybk3D96U68pclSz6kwH2ZXN/ExeV0SDw0OJGZeotpiwRvOsE2A9iEA
         1dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779535010; x=1780139810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SdF6tpQVLDhXweuUd49vYyzxySvvSzPJQt+DpMGXwZI=;
        b=WhrfNAtE5uqv/Qu8N3ym/u1BqZ3/NApr8iIYCjy0NZs4QoMU45FQUwEfxODhkPdq2u
         Qh5W9XFIIgK2AN5nnUS1Bz5EgcZOGob7QyJsktpfKspDEyai+323rvLuNAQLx7FC3thu
         UT+svJbzd05xxm53JNU+bxYlW8F2ZDiFVhE7ywGLRW9RsFsP3Rbcemh54Ha8wiM+EZZF
         d9yA0FP7qeADEh4cH+JslG+IYeH2Teydz5YL1DXDOCicAmOoNxgBGyBZnggknksbKdqK
         RwY4kAhzyLpmBAvEIqktRrL6859RXJQxX7X02jjgVa3wVDKgXzTpOP9f1TpU1sHpN6Yd
         o0bw==
X-Forwarded-Encrypted: i=1; AFNElJ9J8kX3X01ZaEWUgD+hOGNVvV0P3+5d+5Xz9gbehy38GoR2th6zjgihi8k7ezeI1WECFrj0hbJWcZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJV/HskFbgkcYWJ+UySqLHHizt7vSTMLkilz315V+Y+aHPVXqR
	Ibaoj+CyhxqER4OOUcsDOYtc+tvx5qfBNSTWdKKrDXMrykdJZaBU83VhKeQ9aRhtPuJgTgGpIVh
	sbtEiQRlxfroHK/gSnH01CuiP5Ar1T7tQc9ksz57qQQ==
X-Gm-Gg: Acq92OHCFlPdvggz/85j7U862G67mbvA4DXBGOAxqgQZVJOg9PUaZAYSEIvlT5SB59i
	rTfkkcH2cxRhIi9jDazXrvG5tLszaA97o08nAaDmAQNMPu3tCEV8sW0RcPsbgY/OZJAjBVMEOVM
	GdzOFQhg1mOuuR0zYjZyIfa47dMg8TKj8aQbl3uBasmQvTrcMtkISseiDYL+gOAuaYgm3r/2RRs
	ihKWQyLzhKj0enhXRBn4EV9I4veuMy5UR8j1W68pYAqm+Cpw7BPkpT/rdYyN+/1vBPdqIKg46io
	OlEPtXNiAQrGgWeQU33wkNIUs9SS5VOgdOCpjKjdyAfkZxg=
X-Received: by 2002:a05:690e:2502:10b0:651:b40a:d6ce with SMTP id
 956f58d0204a3-65ec96397dcmr5360494d50.14.1779535010085; Sat, 23 May 2026
 04:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523014203.2462827-1-michael.bommarito@gmail.com> <bdf9ef246acd34862588e525c0e9a5fe47f37955.camel@kernel.org>
In-Reply-To: <bdf9ef246acd34862588e525c0e9a5fe47f37955.camel@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 23 May 2026 07:16:38 -0400
X-Gm-Features: AVHnY4KN9_u1yHXF207YL-qGc1v-Djsk1UgFkB57Gpz3aXTtJwExcu0t4k1JkdQ
Message-ID: <CAJJ9bXzjm=-CezSy5x=sHAmsersT6osb9rCk7x39xg=CLU42Nw@mail.gmail.com>
Subject: Re: [PATCH] lockd: pin next file across nlm_inspect_file lock-drop
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21858-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 6A5125BEB07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 7:05=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> Sashiko seems to think there is a regression here. See:
> https://sashiko.dev/#/patchset/20260523014203.2462827-1-michael.bommarito=
@gmail.com?part=3D1

Yeah, the predicate check is a real regression.  I'll fix that and send a v=
2.

The other one  is a separate issue (nlmsvc_create_block).  I never saw
that path fire in my harness, but will send a separate patch if I can
get that to light up.

Thanks,
Mike

