Return-Path: <linux-nfs+bounces-9797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE54A230D7
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 16:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA3E164180
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5C41E98E7;
	Thu, 30 Jan 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="N8PIOJGR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA91E9B23
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738249748; cv=none; b=ZUrTWCYliNidzw0fTtzp4M1MYOfsaT25DU65Ayb2PueMwqMl5fhycQFkKdonlLOs6Lgp2BhZDhg7iCsMU9u1HtAtIXnf+cuBWKzhz5UCUmj3R9i8u/TGDLmLzHSgtaPm8V0Ky/tpWPpF1hvZDup46rmocM6qq4phL43rHFSyY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738249748; c=relaxed/simple;
	bh=3BdXoukq2UUsuL6ggUaE8Q1n/wNgfi+h5H/th9gx6Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmH+lvQfUKCpg+AxrZJsrXnfnTZ/7PXbQses2Gp8w5XRPW8MskIDLS6Yf+4pm8AkYyhjYsvWo+NJxKnktwxBOtHovS1dINcnO/AGs1uPuoqh0ZjkuDmZcT/+wMD8Gi+wo+2pG05JjHDrtr/o3Hkk0DDvpn5PmmKOeCf/JlA5bmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=N8PIOJGR; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30738a717ffso7680711fa.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 07:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1738249744; x=1738854544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BdXoukq2UUsuL6ggUaE8Q1n/wNgfi+h5H/th9gx6Vs=;
        b=N8PIOJGR9rh54mSafhTbYOsXPkb3KR1UaYOjntdoo0ptwQ2ebWLE1Me16oln9Crap4
         0k7hc9RN5VrzPlRL7Fvw5DXEWyYz5Qrj1w8MDPtrg+xeHopGUxj0d/AKEXLI93w8BUvf
         rh3dTYryjOkb+/QSJlY6xeM85VYJNKXi+lbXYHIOADPcStbuneJbG+b3107n13qLZ5hM
         Lr7L/19zKVCUYuTuU6UuxBmVhP6PK7KD8WqL0srVrlCmstKtPzn5GzFTmJvwCw9MJ4bv
         FE74CLqd6frPijhZnJZ+M9KsqZ8OTfX+mSWrfQ6gAv+QuCjNZC/k0pv/L11cldFscJAH
         MR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738249744; x=1738854544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BdXoukq2UUsuL6ggUaE8Q1n/wNgfi+h5H/th9gx6Vs=;
        b=chEiUHK755+9CZNHMRHXK/fOqAg8kzz5YTvYgDLYUGP/RV00g4ThaiKPtXSUsjsmPo
         aTkF4rdh28waZ3T0AlDssaBntRwbNIow0+KBLI6rbbG52ZmCA6HMPBhsbMRlmmo02y/y
         p3n4Lkyt70gQXccT1yneiq4BiqOm3pEp0XRTOodAO7NqSAvgNk4+nLw41hVcE0VVOGW4
         c8Yitrxxl7RO8RIkttKkQWidIp+QrhqxR4b7wV8jttp8DXjTpmB2l9zg49C82FwmHDfW
         XKy3WMVQ6/uGNouYRf8VMpnblBWZaOWEwEL3J1LYf1+tYHg2/k/8VlYzDn2JWRypkF6n
         /vwg==
X-Forwarded-Encrypted: i=1; AJvYcCWira3h+WMV5/rlmjsUPLOFq8WwUfZ1N2Mm1lMVqwQBI2ruLAPgokE/LFgXr/S3VJ7oablvAkoXgBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRyZok4LqJ8MRTkEzeorBHQbOnrTHqIzjHerWFqBGA/xGn/hq/
	tY0SnWFrKEE3xdoVGLJWBkVL7QiWFnd/JLoscNp+BWc9nLsR4JW4b/nL2dtmOXPbP2P1zDgx1Dl
	wSK2GXlXki//dvswM3Rbe/eIeySdiFNaz
X-Gm-Gg: ASbGncvmzcTGxP9b0DPfzNV8tYSILte+Klkvjmvuhae1F31YJodeMJp5D6WRKJRqAeP
	/+RUfFnJXdb4j+ydk4FRpKDaMbPXLZPNunEULzs7soSM2BxLbOpvLKrLkMhsukBcvLnAxL6TSpD
	v4/QNaLenWJRBGU+Ol6wUYmzeviHdsGA==
X-Google-Smtp-Source: AGHT+IGfqAHUg3G9VYUPY4dMVrNDgikPZlVpHf1H53vycGfFjHaJESuDPa+ukhWUtk3Z3DEexTsniLWKkUKpgu6Gcis=
X-Received: by 2002:a05:651c:504:b0:2ff:a7c1:8c55 with SMTP id
 38308e7fff4ca-3079694a78bmr29543121fa.28.1738249744251; Thu, 30 Jan 2025
 07:09:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org> <20250130-b219737c1-e23b3cbd7a5d@bugzilla.kernel.org>
In-Reply-To: <20250130-b219737c1-e23b3cbd7a5d@bugzilla.kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 30 Jan 2025 10:08:52 -0500
X-Gm-Features: AWEUYZmHqLGrXwROMMd5LYQ2occIiaKrf5oDK1j-oCkKx6HUL_ZJC3uqm0ERspQ
Message-ID: <CAN-5tyFeGvihaucNL1rPPhbkxM04gMfOvDz04V0+-05mLbCS4w@mail.gmail.com>
Subject: Re: warning in nfsd4_cb_done
To: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Cc: jlayton@kernel.org, trondmy@kernel.org, cel@kernel.org, anna@kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 9:09=E2=80=AFAM Chuck Lever via Bugspray Bot
<bugbot@kernel.org> wrote:
>
> Chuck Lever writes via Kernel.org Bugzilla:
>
> I recommended a separate bug because this looks to me like the CB_GETATTR=
 reply handling path needs some attention. I'm not sure the problems here w=
ill result in the hanging symptoms seen in Bug #218735.
>
> First issue is the explicit use of NFS4ERR_BAD_XDR in the CB_GETATTR repl=
y decoder. Should be EIO instead.
>
> Second issue is the CB_GETATTR reply decoder does not seem capable of han=
dling a non-zero status code in the reply.
>
> Third issue is whether NFS4ERR_BADHANDLE means the server requested a CB_=
GETATTR for the wrong file, or if it is an expected situation.

Isn't this because 6.12.x is still missing the patch "NFSD: fix
decoding in nfs4_xdr_dec_cb_getattr" that just went into 6.14?

> View: https://bugzilla.kernel.org/show_bug.cgi?id=3D219737#c1
> You can reply to this message to join the discussion.
> --
> Deet-doot-dot, I am a bot.
> Kernel.org Bugzilla (bugspray 0.1-dev)
>
>

