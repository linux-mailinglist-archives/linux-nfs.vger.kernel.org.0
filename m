Return-Path: <linux-nfs+bounces-19014-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Rmr6GL+tlWnbTgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19014-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 13:17:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B4156491
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 13:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61790300C593
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Feb 2026 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412430FC32;
	Wed, 18 Feb 2026 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP/7Yct5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95A30BB88
	for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771417020; cv=pass; b=VmtJhWnTfwac7Xx0aNB5lZ+w8jjWd2ODwdtaUMqgJHIE3FaPlCegJ9dg3P6dIxTIOqF2lmPIpQ0Sg9RWm4u0Fu/uB4KrPFLV0i+FNd+K2l3m0ztIMP6cTn9fphXbae2ipzVxis4q929Flg+Ou/zmow+YWLoDxLfJkQWUtz4H3MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771417020; c=relaxed/simple;
	bh=SArX1+E5cSCm0gQ5hso7eAU0Toteb0ofYbqtpx4nQNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjmKp88lBnjF7Txx7BrsBFESItQOuEmBa07NyPSQyOQtOAbNpFqyETmmXI/1nn9ESpWonbnZkLNI2Furi8I+bPnfywoYfg6A5H6c2/LN8nywNhyMhUZPmX/WLzKEglEFhXCwFfXoG8nK+cIQcoGE8Z8vM2qC99PcSwF72iIWI4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP/7Yct5; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-566390e7db3so3830870e0c.1
        for <linux-nfs@vger.kernel.org>; Wed, 18 Feb 2026 04:16:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771417018; cv=none;
        d=google.com; s=arc-20240605;
        b=Ysvq7Y4miIpafpmibiBZz6fOaCOgp6KJ3fnj2MIWYTwiKfmnaAlB7OaYwY+AXfMaSV
         bhTjBxDTYUPcWOQN37ADBBsJRQyXbEEqPR3mH3y0UMPmGvcCcrzQxWcoxEgAgMRdJoOO
         7L4p2por0zCNwCK76n49oMkY2ugTkqzNdbSn9DZN1PXzEeINWfGvCvLB+Dc1dUQpxQZz
         x/Rnw1W08kW9I1xSZSJuIoH6T0+22jYcBYDU5ktTnOJtS311qF3AAO/UxKLHQCG1hftO
         YzXBeAUo8TIU4MKEMRMM3jiLJzW5wD7ooDdfOvXJb/YDf6XgB1n3arRp5MTVtoxYdn+J
         IIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SArX1+E5cSCm0gQ5hso7eAU0Toteb0ofYbqtpx4nQNk=;
        fh=sa8bhI85AhkvT2jVODSXG88nWt8uQ8YyMXWFKGyP830=;
        b=Vr5hR9YWWZYdv+pu6aNz3evrPCGYCS/y1OWpohZkvq1Hs2NeUXbXrbywdUDNTMgT6x
         NXlQY8edKXLXbLrMjO4X8EMJYotIZehVLcbuvhQ56ZttH8an9pb01M5CqjlFsw1YJ8aN
         WMjzHH9lEmQK4fW/MelmCizLdqYbSui0mq2OX/IA/ZpNbzaPUlf0iHMPEJQJfAoUZrwz
         ZZTEt0Iw57LfE5k74rExoSCH/hxFrGNcU0YSyLRtx6qK6m24xjGqD1hy9VG+dZ6b9I45
         pSUcXVezf7fXECZRTyhAgjTKqYS3DcY/Du2TvNn5s7AtLyWhHOnWL/8QQwYPqmU9Hy2q
         6U4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771417018; x=1772021818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SArX1+E5cSCm0gQ5hso7eAU0Toteb0ofYbqtpx4nQNk=;
        b=VP/7Yct53Z7PyTX9syVeQ90qFV2j4sIC/TRg6tKvnPDPX324avqH75XQA6PEodMeVy
         GI3KzpdL5xYjcDfhkI/I/NxlgZ3pmGZPECwK4zo0XbW/ZNl1Y7jElGpP43FIK3LZnx/d
         X3Di+cxKq57R0godEp+ZOcjkL3+eiyNxwGLjL/RyZ6RP5gieRhmOD7zdY3U/UlXKRmuc
         qVd7+QRb6rz+QPFhBpIwg0Fw4H0FaDIaFwszQnUn3Gh9Di54BpCS74KcEwLSwrPRbpwB
         yTf6xQw8RECTJC2gvMgxUEWyOpGM4WFBd9n4qrCxhCbpQhgALY1rFmrIypmwVdRq3Udt
         HFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771417018; x=1772021818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SArX1+E5cSCm0gQ5hso7eAU0Toteb0ofYbqtpx4nQNk=;
        b=Ieos25HzQ87476aiW9zbv0apz94OpSkDnDtCu9If9zfoCDRtL940De1Cck0uyscL/k
         l9lhi8C1KznmQRk+nVLLzaCA5Salk2CQiUl9kW9sKnewtoHYN9Djnjc0A3HWMrwLsV2i
         aPKciD7qGJGZI+T1GC9v/Y3DcmcNDU17O1ET4lEz2R2opaHshztTVmep83siH8KiWocH
         bVbuOrj9GYVx++kEkHGMItCSb8NaqskIpz9QxwYA/ixw1t0E63JxevOw6vMXBKwHBWcZ
         xTy1kunAE+boyQ+kRoLdE3MwlT5zElvnjKq1WPVPX8rIt1dLN0KZ5BqN1iippvuoN4x9
         YMZw==
X-Forwarded-Encrypted: i=1; AJvYcCUX2x/5T753jTMvoCJ0DSQbMxo18UL/HdNaG54sn8GadAJTUp7mc6Q+ZrWyp66pHGmJ46kuYkMoPlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDl88m4UffzRg31bew7A4rAWv3UGv3Q2TXgZNvsBP5RjD7ScjS
	EYh5KQR6duXFiDBSF6Kybeivnn5JE9ELpqf8j0KTXgc5Tds9ex/HohKcPBn63v3bqgqTUo0FTQf
	Ml+QIyzm5uwCmvF4PPccYO3k6grj8rL+47CG4
X-Gm-Gg: AZuq6aJsx0QE7a4FabgBuilQ/emr6elaBfLkTpElf6diY/Ibi1LrbNoGMB5p1+wOX2W
	/0Y+FkVwh4OKJZog5TOyaCX4Ebr75g8tkBnDTTx0YIo6Y63r+8bvFTDk6WVX1JtZGpmbTMyEn8U
	XsxR14kkfEvN+rdws7UBLJ4XMQewL7yrtyboqNPjWZrdlqlJfh31vyraoMely/2KH7qxY4kgWrc
	CWU/qFEsn1pVQZtYs+bHYSpz7jFDyz/wDotX24OSA+fUu2DrDhe43oqroCNJLe423KFE44MYoNn
	B7Wd0w==
X-Received: by 2002:a05:6102:c48:b0:5fd:a537:a778 with SMTP id
 ada2fe7eead31-5fe7fb9df43mr708244137.10.1771417017377; Wed, 18 Feb 2026
 04:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-3-seanwascoding@gmail.com> <f71cdfa7-25f8-487d-b727-39ae962401a4@lunn.ch>
 <CAAb=EJWNSvTHuUX862vLmA2s1uKO0vy_x9OSZ6VXqY9X-+JNsg@mail.gmail.com>
 <00ebdd77-d6ef-48f2-a25d-8d8b3c7dc7a8@lunn.ch> <CAAb=EJXQjraL=VEod0N8Pm5tuQ5UE9UbrdxdZQ+ArKVhDUT83w@mail.gmail.com>
 <a7c960af-ad60-4aef-93ef-f79657dbe4e5@lunn.ch>
In-Reply-To: <a7c960af-ad60-4aef-93ef-f79657dbe4e5@lunn.ch>
From: Sean Chang <seanwascoding@gmail.com>
Date: Wed, 18 Feb 2026 20:16:45 +0800
X-Gm-Features: AaiRm53ZMcBrHzDJddjETwail8piAZSuVmKqHIMqT5f7GzG0oLNBR4qZAVt0IcQ
Message-ID: <CAAb=EJUSEwrYrUWGcxwn+kQXAzzFO9_VHaVxAq738PtOYEraYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: macb: fix format-truncation warning
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19014-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D92B4156491
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 4:33=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > Given the other patches in there series, i have to wounder, is the
> > > diagnostic analysis correct? Or is the RISC-V toolchain buggy?
> > >
> >
> > I retry the different methods, I found that when I directly compile
> > the macb_main.c, it can trigger the same error, and I already prove
> > the different compiler will reach the same result, so it is not a bug
> > of the compiler.
> >
> > I also found that the x86_64 defconfig does not enable CONFIG_MACB
> > because it requires CONFIG_COMMON_CLK (which is also disabled by
> > default on x86), whereas the RISC-V defconfig has both enabled.
>
> arm and arm64 are much more similar to risc-v than x86. You should
> test with those compilers. However, make allmodconfig will get you the
> common clk code on x86. Most build testing is done with this
> configuration, including the netdev CI.
>

Thanks for your suggestion to use the "allmodconfig" before the build.
I running the command: "make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-
linux-gnu- KCFLAGS=3D"-Wno-error" W=3D1 C=3D1 modules -j$(nproc) 2>&1
| tee build.log" and "make ARCH=3Darm CROSS_COMPILE=3Darm-linux-
gnueabihf- KCFLAGS=3D"-Wno-error" W=3D1 C=3D1 modules -j$(nproc) 2>&1
| tee build.log", it throws the same warning -> [-Wformat-truncation=3D], s=
o
It proves that even if I switch to a different platform, like arm, arm32,
x86_64, riscv64, it still shows the same warning.

Best regards,
Sean

