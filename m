Return-Path: <linux-nfs+bounces-7537-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBEC9B3743
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 18:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988851F222A5
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C5A1DF268;
	Mon, 28 Oct 2024 17:01:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx02-out.cloud.vadesecure.com (mx02-out.cloud.vadesecure.com [109.197.246.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953E13AD11
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.197.246.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134918; cv=none; b=A9PQZHIl7mP2rdGTTY9mlMCBycUi2yaKdOuBKtTnuCobkE0OS0c5s0fealT5frRFDHQK5/QCgvD1q4guMcXoey9XqioG9p9JX+Opnr2JzNm680+5oFoWweVGShbDQjXrZIsjdmudUb4ORbCIFyp0Sb/g8AYc0ajbXN+TKoBZlBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134918; c=relaxed/simple;
	bh=Bl7wa791/1KKkEEhs16Lbnn4k7qotyGVyuHasMPv9C8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rj38niQRMvHPScx2TxvuxR0s+mo8n8x9TSmAPSKLIPnQjOYiKMnDe2uOYp/UzzU1zq8//hxM8Voywl6jLGeyQZ9J6V6vZfaDoeqFXG5fBUKMJmMvFnDuY99e6RDkbqZIKb6i1Ep5sELTJkuQFH3BxzfltoPZbFLMTEiFnHLOhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu; spf=pass smtp.mailfrom=minesparis.psl.eu; arc=none smtp.client-ip=109.197.246.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minesparis.psl.eu
Received: from smtp-out-1.mines-paristech.fr (smtp-out-1.mines-paristech.fr [77.158.173.156])
	by mx02-out.cloud.vadesecure.com (vcfr1mtao02p) with ESMTP id 4Xcfn95tjSz1qjN;
	Mon, 28 Oct 2024 18:01:49 +0100 (CET)
Received: from z-smtp.mines-paristech.fr (z-smtp.mines-paristech.fr [77.158.173.137])
	by smtp-out-1.mines-paristech.fr (Postfix) with ESMTP id BB5ACC0BDC;
	Mon, 28 Oct 2024 18:01:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id AD0641C010F;
	Mon, 28 Oct 2024 18:01:49 +0100 (CET)
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 76u3ssyd-ojm; Mon, 28 Oct 2024 18:01:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id 541B11C00CE;
	Mon, 28 Oct 2024 18:01:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 z-smtp.mines-paristech.fr 541B11C00CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=minesparis.psl.eu;
	s=9f5ccecf-24a0-4eb3-a015-b6ac3b07c299; t=1730134893;
	bh=Bl7wa791/1KKkEEhs16Lbnn4k7qotyGVyuHasMPv9C8=;
	h=Message-ID:From:To:Date:MIME-Version;
	b=RDKwI0N5rhIee0e3DNYKCXXSaiS4UpoUvaT/5VGlypkgXxPMT2KQpHglZ5bIj0sXK
	 wInMjOLVV1XBD2umaTtOt+3D/8L0pu9H4SkmUh4YOsvYAMeXTkLRk4kA9bt+XWjdkW
	 c8x7OgmoiOP22Tdh3bvqs3yuoRbPXnsv8hsXmTYpugZWKIH844M5Nie1a03G2Fs8k5
	 HgHr91v1HfPauhJQo6zJr3Y+N7LdM2iZoCq+pBi7/gPreAZKwBKQahIFD83LcSBIdR
	 jNQXjCUYj+N0t+hsA6K5M9vGgH+OWXI43hq7svB3zDs5OsxBCE/fsOhHpFyrWW+zFk
	 oTmDs0pHgNj/Q==
X-Virus-Scanned: amavisd-new at z-smtp.mines-paristech.fr
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nFFAFIPw2x5r; Mon, 28 Oct 2024 18:01:33 +0100 (CET)
Received: from hive.interne.mines-paristech.fr (nat2-sop.mines-paristech.fr [77.158.181.2])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTPSA id E45C31C00AE;
	Mon, 28 Oct 2024 18:01:32 +0100 (CET)
Message-ID: <a4db98210dddb49b8810721b9c699a4d1c4915c1.camel@minesparis.psl.eu>
Subject: Re: nfsd stuck in D (disk sleep) state
From: =?ISO-8859-1?Q?Beno=EEt?= Gschwind <benoit.gschwind@minesparis.psl.eu>
To: Tom Talpey <tom@talpey.com>, Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date: Mon, 28 Oct 2024 18:01:32 +0100
In-Reply-To: <509abdda-9143-40da-bbf2-9bfdf8044d4c@talpey.com>
References: 
	<1cbdfe5e604d1e39a12bc5cca098684500f6a509.camel@minesparis.psl.eu>
	 <4A9BFCA9-7A15-4CA7-B198-0A15C3A24D11@oracle.com>
	 <f7aec65eab6180cf5e97bbfd3fad2a6b633d4613.camel@minesparis.psl.eu>
	 <509abdda-9143-40da-bbf2-9bfdf8044d4c@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-VRC-SPAM-STATUS: 0,-100,gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftvedpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeuvghnohpfthcuifhstghhfihinhguuceosggvnhhoihhtrdhgshgthhifihhnugesmhhinhgvshhprghrihhsrdhpshhlrdgvuheqnecuggftrfgrthhtvghrnhepkedugfegueeljeejffeiheeuleeufeefleevkeffuddukefhfeevheettdefgffgnecukfhppeejjedrudehkedrudejfedrudehiedpjeejrdduheekrddukedurddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdpmhgrgihmshhgshhiiigvpedutdegkeehjeeipdhinhgvthepjeejrdduheekrddujeefrdduheeipdhhvghlohepshhmthhpqdhouhhtqddurdhmihhnvghsqdhprghrihhsthgvtghhrdhfrhdpmhgrihhlfhhrohhmpegsvghnohhithdrghhstghhfihinhgusehmihhnvghsphgrrhhishdrphhslhdrvghupdhnsggprhgtphhtthhopeefpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghr
 rdhkvghrnhgvlhdrohhrgh
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0

Le lundi 28 octobre 2024 =C3=A0 08:46 -0400, Tom Talpey a =C3=A9crit=C2=A0:
>=20
> Was the client actually attempting to mount or unmount?

The servers were running for a while, thus, as far as I know my setup,
there is no ongoing mount or unmount. Moreover none of the clients were
rebooting, starting or shutting down.

>=20
> Tom.
>=20
>=20

--
Beno=C3=AEt Gschwind

