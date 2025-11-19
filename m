Return-Path: <linux-nfs+bounces-16523-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4006C6D936
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 10:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A63A02DAAE
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC1333727;
	Wed, 19 Nov 2025 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b="RKccREBy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.novencio.pl (mail.novencio.pl [162.19.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DF33344E
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543061; cv=none; b=ajLvUDghYkAkavTDiRTM78qswfah7TKquUA71okagHy1rwAWbC5b01rdEXLpKySsMvoOl1gTiIMep53tHHkzuE4gT5vIlcsyncv9HIrAFLYQSP1GPHEn0AKrZqI7Kx65vdFsS3LY/ryb+uUJVvixmq+437zkXn+bd/+0cf/468o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543061; c=relaxed/simple;
	bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=qJ+8f2Kl//yugHp2zNCQCa5XCCgbBTnwhfh5jz7b1/KtspCglOJJv+HHA9xtadCSA5jdUnk7xXRYkSeM5roW/9M21SonMOaa8CarMYI5NY9rBZ3zDKqkDZMvTzTV9hBTHjY+Ebyto+OuJT5baEGR5/81XomLxnciaxWsdxD1Z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl; spf=pass smtp.mailfrom=novencio.pl; dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b=RKccREBy; arc=none smtp.client-ip=162.19.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novencio.pl
Received: by mail.novencio.pl (Postfix, from userid 1002)
	id 9EA0224BE2; Wed, 19 Nov 2025 08:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novencio.pl; s=mail;
	t=1763542584; bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Date:From:To:Subject:From;
	b=RKccREByE6pT/NVsW8e8N/3suMiPWk6ik5sjNq40uqAoj82WtiRYyQWv9OjW1dmjg
	 emLDSOmI9pHuP2FiFSFYifjfbXXXARr3dweWCSwmfEeRqHET6cZD2TStBXemuEL6kx
	 DWojeOmp66f+3UC6QqNcEjgrAgTdl2iaFgPnmlPKQPVSJlIiMrLOsUVJUSw4dnxVJJ
	 Z3kZIIunl50Nnc6ASJXAALzxdAM1ksIGHJFAQgGMud06uKDmse9Kf/ebfRRDb5o8P+
	 0n1prosuDb9TyUdlpIRV+cl/wqSo4F5wyGa8f/eQbADDBVHlNtFDopUXCY1rW1R43h
	 77Fy/mOnGMOQg==
Received: by mail.novencio.pl for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 08:55:55 GMT
Message-ID: <20251119074742-0.1.5y.z3dg.0.k3yfrmb2pc@novencio.pl>
Date: Wed, 19 Nov 2025 08:55:55 GMT
From: "Marek Poradecki" <marek.poradecki@novencio.pl>
To: <linux-nfs@vger.kernel.org>
Subject: =?UTF-8?Q?Wiadomo=C5=9B=C4=87_z_ksi=C4=99gowo=C5=9Bci?=
X-Mailer: mail.novencio.pl
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

pomagamy przedsi=C4=99biorcom wprowadzi=C4=87 model wymiany walut, kt=C3=B3=
ry minimalizuje wahania koszt=C3=B3w przy rozliczeniach mi=C4=99dzynarodo=
wych.

Kiedyv mo=C5=BCemy um=C3=B3wi=C4=87 si=C4=99 na 15-minutow=C4=85 rozmow=C4=
=99, aby zaprezentowa=C4=87, jak taki model m=C3=B3g=C5=82by dzia=C5=82a=C4=
=87 w Pa=C5=84stwa firmie - z gwarancj=C4=85 indywidualnych kurs=C3=B3w i=
 pe=C5=82nym uproszczeniem p=C5=82atno=C5=9Bci? Prosz=C4=99 o propozycj=C4=
=99 dogodnego terminu.


Pozdrawiam
Marek Poradecki

