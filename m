Return-Path: <linux-nfs+bounces-8006-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D249CE17A
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 15:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B971F21965
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991BA1CD1F1;
	Fri, 15 Nov 2024 14:42:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta05-relay.cloud.vadesecure.com (mta05-relay.cloud.vadesecure.com [195.154.80.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54D41CEAD6
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.80.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681750; cv=none; b=D57hFWY6idsX2+6KRpDPh0cdxQyefeDXNz17mXXe48pY44MbuOkEj7QttahFIcHiajQo3OvJvB1AHkxNsd79Z1/85EblnJdgH7B3XssZWkQuoWcNrNiosKGpZoVlXOE6bWO0HB+NtDQU0hqgJjtvfIU20GRbDuymAnVNEeUbpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681750; c=relaxed/simple;
	bh=l1M7cm03NO+T5ZkCqBifIASIvguQ98ve+JzF1ipPqH0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=usfnjEwousw+XusQABgx/UihcDFZ5iEeV2YS0C7hdFDq+T7JYKwg4biG+k99PerTLe4hkPYUTYq3q6dTw587L++sA+tZB+zswjQ9QBkXQZ0ff4yLa+4T+StOvM8fD3OsxXgJ4PZoCJIFt9tXqdvydc3dH1KeZI5eTiyj41d11qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu; spf=pass smtp.mailfrom=minesparis.psl.eu; arc=none smtp.client-ip=195.154.80.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minesparis.psl.eu
Received: from smtp-out-1.mines-paristech.fr (smtp-out-1.mines-paristech.fr [77.158.173.156])
	by mta05-relay.cloud.vadesecure.com (vceu3mtao01p) with ESMTP id 4Xqfhy4ST8z7Wx8
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 15:36:18 +0100 (CET)
Received: from z-smtp.mines-paristech.fr (z-smtp.mines-paristech.fr [77.158.173.137])
	by smtp-out-1.mines-paristech.fr (Postfix) with ESMTP id 7F16FC0FBB
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 15:36:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id 7A11C1C00C7
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 15:36:18 +0100 (CET)
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 4nmm0biS2T4D for <linux-nfs@vger.kernel.org>;
	Fri, 15 Nov 2024 15:36:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id 212A31C00CD
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 15:36:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 z-smtp.mines-paristech.fr 212A31C00CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=minesparis.psl.eu;
	s=9f5ccecf-24a0-4eb3-a015-b6ac3b07c299; t=1731681378;
	bh=l1M7cm03NO+T5ZkCqBifIASIvguQ98ve+JzF1ipPqH0=;
	h=Message-ID:From:To:Date:MIME-Version;
	b=zOyc7ad8kXPkowUWjIRVX8CzR8JPYpULOOShfB4Cwzj6kTPbGRKwj+kjM3y43OvP5
	 zQoUOhOO5jJhvDa8g9MwQmp54c4BxVCQGNTYVAb1anXWgNTpkLXU9CYF4J0ODPcmby
	 52mwLcXEhga2AvjH7cSTlcBjxTrjWKCqZdHHH5WIXkWfGriLBazs//QtGZYLhgVGR5
	 AoaPWZLrIc2pxGso/mKHA9UZSMF4qoWgVG6E0Mo1lUSvuZwj3XXkGdXN0KWep/FCF6
	 U1r2afIw/q8Prg+bxRzt4DS51/G87WoP3W33WNbkh3cE89ckFH7OM5F0G9I4yOfx+s
	 qdXe2kJP8f5HA==
X-Virus-Scanned: amavisd-new at z-smtp.mines-paristech.fr
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BGcnoazMlnT3 for <linux-nfs@vger.kernel.org>;
	Fri, 15 Nov 2024 15:36:17 +0100 (CET)
Received: from [192.168.113.194] (unknown [78.242.104.88])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTPSA id BFBB81C00C7
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 15:36:16 +0100 (CET)
Message-ID: <2137355dbbaa27bd546a6b6b870796b48627e69f.camel@minesparis.psl.eu>
Subject: Re: Some users permision denied with kerberos+gssproxy+nfs
 4.2+winbind
From: =?ISO-8859-1?Q?Beno=EEt?= Gschwind <benoit.gschwind@minesparis.psl.eu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date: Fri, 15 Nov 2024 15:36:14 +0100
In-Reply-To: <926432c774f2e03711783265ebb0fae0b94d7122.camel@minesparis.psl.eu>
References: 
	<926432c774f2e03711783265ebb0fae0b94d7122.camel@minesparis.psl.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-VRC-SPAM-STATUS: 0,0,gggruggvucftvghtrhhoucdtuddrgeefuddrvdeggdeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfevpdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegvnhhofphtucfishgthhifihhnugcuoegsvghnohhithdrghhstghhfihinhgusehmihhnvghsphgrrhhishdrphhslhdrvghuqeenucggtffrrghtthgvrhhnpeegieduheevueehuefgtdetjeduieevhfegvdfgffegfefhveekieeukeehffefffenucfkphepjeejrdduheekrddujeefrdduheeipdejkedrvdegvddruddtgedrkeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdpmhgrgihmshhgshhiiigvpedutdegkeehjeeipdhinhgvthepjeejrdduheekrddujeefrdduheeipdhhvghlohepshhmthhpqdhouhhtqddurdhmihhnvghsqdhprghrihhsthgvtghhrdhfrhdpmhgrihhlfhhrohhmpegsvghnohhithdrghhstghhfihinhgusehmihhnvghsphgrrhhishdrphhslhdrvghupdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0

Hello,

It seems that using touch on "permission denied" folders fix the issue.

Perhaps it's force the update of some permission cache ?

Le vendredi 15 novembre 2024 =C3=A0 10:46 +0100, Beno=C3=AEt Gschwind a =C3=
=A9crit=C2=A0:
> Hello,
>=20
> Usually after few days, some of my user get permission revoked to
> where
> they have the permission. The issue does not affect all users and all
> clients at the same time. As instance an user can have access granted
> on host1 but permission denied on host2, Moreover an user1 can have
> all
> his permission working properly, while another user2 get his
> permission
> revoked on the same host.
>=20
> After a reboot usually everything work fine for all users.
>=20
> It seems that the user are not map anymore to the right one because,
> the user can read directory with "755 but not private one, i.e. with
> 700. Moreover he still have write permission on at less some
> directory
> with "755".
>=20
> What I can do to fix this issue without annoying user that have
> correct
> permission ?
>=20
> I tried to restart nfs-client, nfs-server, rpc-nfsidmap, winbind,
> gssproxy without success.
>=20
> Thanks by advance
>=20


