Return-Path: <linux-nfs+bounces-2058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C1786139D
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Feb 2024 15:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBE04B20FE7
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Feb 2024 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F050F7F7D3;
	Fri, 23 Feb 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="i8RNYpJg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E8876039;
	Fri, 23 Feb 2024 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.122.41.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697339; cv=none; b=S8gjVUhvzCFOfB3ohzzXEE/3ORPh+19UMk79MIyhx4t8CT4mTkpHfYBmnUv9x0mmWZgWJX2hqj/xvaXh3b1yYMgiBfbby05oJCG9oAgt1oERFP6eBztC5xQS1QPoUbPanPGRFmgcuizmpcPxOtmEnXq6zwmTF9uJ+XoArGymiTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697339; c=relaxed/simple;
	bh=guPgw7BLwj7dlZ3/rIsnuD4FCPiualIsytSxFaptjZ0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QwlAs9en4s9m2DWsu5ApIueuQZiEtq6oM0h26enQ9nhfLA/kxXs/yKbAquw4VL/4IyYKjYmAxbFBtIfkOux0BDM4NMQO9sV+srEnKAH6KocPAVi7Pv2fhDf7OSxkcHj4vVsQgYCgUKRk6M5qZ8sZtKDAlCn2RCEEplsXp+slP24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (1024-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=i8RNYpJg; arc=none smtp.client-ip=212.122.41.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=mail; t=1708697335;
	bh=guPgw7BLwj7dlZ3/rIsnuD4FCPiualIsytSxFaptjZ0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=i8RNYpJgaSpgZmxBL3kvwtslvBRS6HMlx2aqNHowiEe7h1S4vcE1z7V9mjWTlzT3Q
	 ld7s3BnpYFBNHg4F+ygIhXVryHSa5ByhNIywCX2pCxkFDr8/HICAbe6xGnjsRe4Ral
	 LEEEtbLNcxSlF5iZzcHNhBh37r9bxCkx8cZg1/zA=
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: nfs4_schedule_state_manager stuck in tight loop
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <8B04DA70-ABEF-44A4-BBA7-60968E6CFA10@flyingcircus.io>
Date: Fri, 23 Feb 2024 15:08:35 +0100
Cc: linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <01DFAB47-5AFA-42C2-965B-5A14C331B0A6@flyingcircus.io>
References: <8B04DA70-ABEF-44A4-BBA7-60968E6CFA10@flyingcircus.io>
To: linux-nfs@vger.kernel.org,
 chuck.lever@oracle.com,
 jlayton@kernel.org

Addendum:

I=E2=80=99ve checked kernel changelogs since then but didn=E2=80=99t =
find anything that I could relate to this aside from *maybe* =
dfda2a5eb66a685aa6d0b81c0cef1cf8bfe0b3c4 (rename(): fix the locking of =
subdirectories) which mentions NFS but doesn=E2=80=99t describe the =
potential impact.

We=E2=80=99re running 5.15.148 now and as it=E2=80=99s been another 2 =
months there might be the chance of another lockup in the near future ;)

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


