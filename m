Return-Path: <linux-nfs+bounces-11590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C9AAED0C
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 22:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E003A21F1
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7CA1C5D5A;
	Wed,  7 May 2025 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b="ViXq37RV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697BD23DE
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649664; cv=pass; b=kVtrBcEkP7i2S46WUTjywOJz2tuvKp8OAz5q1ybF1TajccObYVPpQqwo2XLWmeG5/k7SX+qvcI46ZrAMxH22KJV99uei/WpycKzOMK9rIeemFKfD+KNKy1dxruLeHrEAcHy1vhTEIYqXLGIU0KDrkVWa3MkOCBQZ8xXfSCdyFIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649664; c=relaxed/simple;
	bh=mTwpYr9B60QWMQ4P9ojQ+hU7pPDUIUuApmRD3KVpUPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=q3uMoe+rltnJtdb6M9vVKpadTZpb48GqmMiuVW7k+Pl8We3FCr7xmmd6KDmCsYKBBih4q3KRWSbKM4gtXds1ZwfP0jB89QQhq2qO1pWZ+MVWWI1Hy+oed+ta4IBvv7mKsUGpQ0OjQaE6pKY5frrlQuRbysJL2oFsrp4p5d8R0H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=nrubsig.org; dkim=pass (2048-bit key) header.d=nrubsig.org header.i=@nrubsig.org header.b=ViXq37RV; arc=pass smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3A4EC8A677C
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 15:56:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a279.dreamhost.com (trex-4.trex.outbound.svc.cluster.local [100.118.80.50])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E4B9C8A673F
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 15:56:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1746633406; a=rsa-sha256;
	cv=none;
	b=KN+4n21jj26xVs91uCNT5sTzUo4EqGOtBgtOhhvQ8eTOPFPic5l8eNDZhx/tmKqhgysMqy
	aMtdV4NeFQJ2XloUVNAxHtZ+XpXbfKm7gypcu1XGBWKuhup1ejGT+PjVykwbBEbTERWsQN
	wezz15LNbNrBfBC3Wu7hq6/CmIeGeIKQbDLrX8ZlUMRKP1ZIR3bx1unEcXVs7A8VSQzFWW
	HWCs4o2nrMaTpA6Ru4rfqMW3WNY4+blhbgUbPMCKWAwIxqdjB7sLlOiEB8Ms+dYrwmWwLy
	basJqPATYE2X5otUa5W/cPTR8yZ0Q7Wp9A3Wj+n+1VQIo/UClPcCtLzpS3Fygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1746633406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=v8gx4gJe1o8YNeVnivObQi9txqp6pPWvJVYwnpW/BlM=;
	b=NwFY1HfW4CzLJo+kYoK7K+wM5aCW9qZEfir8FV1Y/qKwPKlWRsma2TTASPCiKFaEA5feuZ
	BIog6LsWMYJZRe+kbXmhPJXhUaq4LthaudghKmDKEtOkN9E6cKE1bzrgg+sBqEIV5Hz7gm
	DR6k4SRR6v0le5SeHQZe9Psq5OF69GvVdcQOhXRoLcL+wEfkC+xCrhxWgPWWNjmDoTAyUv
	C9AZrTELQmReo/XCu3HGbsEJxHrSEzw0wfXT2w0qSm/TWWB4Ud2KrCpaj+QCcREd7wQbqW
	0hZYTjE85d1ypyCl6/ETQakezCxl0rjyByhaVREjLp4kKpwn2pHjPaUzWp9NJw==
ARC-Authentication-Results: i=1;
	rspamd-597fb754dc-frzgg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=roland.mainz@nrubsig.org
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Average-Ruddy: 2f42eea666baba49_1746633407137_4099749588
X-MC-Loop-Signature: 1746633407137:2225206610
X-MC-Ingress-Time: 1746633407137
Received: from pdx1-sub0-mail-a279.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.118.80.50 (trex/7.0.3);
	Wed, 07 May 2025 15:56:47 +0000
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a279.dreamhost.com (Postfix) with ESMTPSA id 4Zt0Hy2JMwzM4
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1746633406;
	bh=v8gx4gJe1o8YNeVnivObQi9txqp6pPWvJVYwnpW/BlM=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=ViXq37RVHVoibAa4OB4GQvFCh+EPVVE6d82Uq2YB66bl3qJwoUKp24mZNqySvxRox
	 H4YMrSn/zFtn42oZ6eoDntxvQ8ml8oeLlI9RbzRYxyYWmNTURbUM/neOPl1DlmLyx4
	 7bb7+9CBqPX3sqj3ScEM7pwTFAeHqMdi2ERMsbr1xz8W+c9KQNMTCpK11wmmSu1Nsa
	 NrugzC7UYkldK/dYSV7jD8DdiAFu619u/svxaocN1wsJd9pTyhnB3wSXH5JoKhyct6
	 reSaA07bRc8+VYFCzgLfNYAZxMVtoFFvi6zPh04cyDrlBicuwRdsbPZiHxTHns+V0c
	 Zjj16Eu8WEFYA==
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0b9303998so59755f8f.0
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 08:56:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywhd3R82LRSbLVhiucpHSixd5eB/DYQ7PxeG8d7hIcD/bac5z95
	6DWrAMurw5PhZ4MVLJuTdr3aVL5+BWT7vrPakHM2foGXQywVvvwsSDrt9DGpp0gept1Bb/ldgBQ
	f6WTVha5Ot/adFYSDJSc+Kn/J64Q=
X-Google-Smtp-Source: AGHT+IFoTi2eEwAEuN7KYMSnxaAfTpgMp6gUzoUBbf8rIj5dq09hoGEqA5YGz1IqK441HD475f6tY2D8/QErtU34l+0=
X-Received: by 2002:adf:ea08:0:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a0b992096amr32667f8f.18.1746633404694; Wed, 07 May 2025
 08:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507144515.6864-1-cel@kernel.org> <b73ee4d1184e91b540edaeb22d939fea852d482e.camel@kernel.org>
In-Reply-To: <b73ee4d1184e91b540edaeb22d939fea852d482e.camel@kernel.org>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Wed, 7 May 2025 17:56:08 +0200
X-Gmail-Original-Message-ID: <CAKAoaQnYU26bJ=1qXW--KKTJrdcJ6OcnyxfpVEwSk66jfA1NmA@mail.gmail.com>
X-Gm-Features: ATxdqUE6rQiuEw4denmleShxwhcVOVRAMUmMpoZynsxuBvoIzPOEWcM4S5ziQzU
Message-ID: <CAKAoaQnYU26bJ=1qXW--KKTJrdcJ6OcnyxfpVEwSk66jfA1NmA@mail.gmail.com>
Subject: Re: [PATCH v3] NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:34=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Wed, 2025-05-07 at 10:45 -0400, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > RFC 7862 states that if an NFS server implements a CLONE operation,
> > it MUST also implement FATTR4_CLONE_BLKSIZE. NFSD implements CLONE,
> > but does not implement FATTR4_CLONE_BLKSIZE.
> >
> > Note that in Section 12.2, RFC 7862 claims that
> > FATTR4_CLONE_BLKSIZE is RECOMMENDED, not REQUIRED. Likely this is
> > because a minor version is not permitted to add a REQUIRED
> > attribute. Confusing.
> >
>
> Isn't CLONE itself an optional operation? It wouldn't make sense to
> REQUIRE this attribute on servers that don't support CLONE, so I think
> it makes sense that it should be optional. Anyway, I'm just being
> pedantic.

AFAIK (unfortunately) *everything* in NFSv4.2 is optional, basically a
NFSv4.1 client or server can claim NFSv4.2 conformance by implementing
just protocol minor version negotiation... ;-(

Would a protocol minor version check suffice in this case ?

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

