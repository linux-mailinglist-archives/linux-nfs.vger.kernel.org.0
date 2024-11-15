Return-Path: <linux-nfs+bounces-8000-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F19CDBF1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 10:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C075B223D1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57741192D67;
	Fri, 15 Nov 2024 09:55:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01-out.cloud.vadesecure.com (mx01-out.cloud.vadesecure.com [217.74.103.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9D18F2DB
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.74.103.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664537; cv=none; b=b0bdl7PNP/2orZwMqjKRPFd4AVkFw7tVzIJYgyE5c32hfljEi4DISyVlRgUCikNa72awyJzhX7crXj1TTsQM+9MeNw7ZAH0l7Md9UP+qh22ce4Jf6jPOCaMEHAoyS0mpRsZXwCv6+NcDMqZOQmcF1/F5zG/o0eQHDLBW4E4e9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664537; c=relaxed/simple;
	bh=2BCehiVWkj39nsARlSLWzfwQ8ZFEYIFjJdsw2axTGgE=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=evDqqEBTUKjBBfmU+fim7/6kLSNtQn13RzBuwk4CvLvSzyfv4QtAF7/cRsujy553UX7JrLOm+w8gymiQRtn1cy26FidoUJaYHbCRayMbZJacJPFo13JVaU7Gt55ube5wr6BoD+DCks2RW1Ysa+0J9iY8VHfPCauEip0DQr9aEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu; spf=pass smtp.mailfrom=minesparis.psl.eu; arc=none smtp.client-ip=217.74.103.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minesparis.psl.eu
Received: from smtp-out-1.mines-paristech.fr (smtp-out-1.mines-paristech.fr [77.158.173.156])
	by mx01-out.cloud.vadesecure.com (vcfr1mtao01p) with ESMTP id 4XqXGr2ttpz1wV1
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 10:46:44 +0100 (CET)
Received: from z-smtp.mines-paristech.fr (z-smtp.mines-paristech.fr [77.158.173.137])
	by smtp-out-1.mines-paristech.fr (Postfix) with ESMTP id DFB5BC0FA2
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 10:46:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id D44151C0074
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 10:46:43 +0100 (CET)
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fg0Vnlz8FfL7 for <linux-nfs@vger.kernel.org>;
	Fri, 15 Nov 2024 10:46:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id 7D7891C00E1
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 10:46:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 z-smtp.mines-paristech.fr 7D7891C00E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=minesparis.psl.eu;
	s=9f5ccecf-24a0-4eb3-a015-b6ac3b07c299; t=1731664003;
	bh=2BCehiVWkj39nsARlSLWzfwQ8ZFEYIFjJdsw2axTGgE=;
	h=Message-ID:From:To:Date:MIME-Version;
	b=eKEnY5YDlWBvHyKlpZvJuV12Hjl7SLPRTEzSeSSEEfP4cDK0L0CFvRRsLkHsRM7Nn
	 BNbsaTk/mQl7vNtbKKYMzWcso1ze/Pl3e8PkiihKpWUpUiCqNuJCIMl4ygfvqI5bK1
	 G+PkthuvrQ3xh6wb6Hgvhc/31r+solR60CvvcmSp7jU/dttXW9jT/5/YDto24gpODJ
	 XR9W50vHbpH9B4PZOEccrEPmE4gcMRKFRmVC2utfWm4s3d6aJ4iucJxFx0a0nc7LK4
	 7N4bSf+yXLG+QEufuC258eHTEkt2ygKC2jcRs6GXZKpVJrHZdnzMmoaZNGlFQE+gvN
	 uZyHvFR7butyg==
X-Virus-Scanned: amavisd-new at z-smtp.mines-paristech.fr
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y8rIV8xq1z_a for <linux-nfs@vger.kernel.org>;
	Fri, 15 Nov 2024 10:46:43 +0100 (CET)
Received: from hive.interne.mines-paristech.fr (nat2-sop.mines-paristech.fr [77.158.181.2])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTPSA id 427391C0074
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 10:46:43 +0100 (CET)
Message-ID: <926432c774f2e03711783265ebb0fae0b94d7122.camel@minesparis.psl.eu>
Subject: Some users permision denied with kerberos+gssproxy+nfs 4.2+winbind
From: =?ISO-8859-1?Q?Beno=EEt?= Gschwind <benoit.gschwind@minesparis.psl.eu>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date: Fri, 15 Nov 2024 10:46:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-VRC-SPAM-STATUS: 0,0,gggruggvucftvghtrhhoucdtuddrgeefuddrvdeggddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfevpdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgtgfgfggesthhqredttderjeenucfhrhhomhepuegvnhhofphtucfishgthhifihhnugcuoegsvghnohhithdrghhstghhfihinhgusehmihhnvghsphgrrhhishdrphhslhdrvghuqeenucggtffrrghtthgvrhhnpeethfevveeigffghfeutddvgeeiffdvhefghfegvdehffdtgfehudeuvedtheeuvdenucfkphepjeejrdduheekrddujeefrdduheeipdejjedrudehkedrudekuddrvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhmrgigmhhsghhsihiivgepuddtgeekheejiedpihhnvghtpeejjedrudehkedrudejfedrudehiedphhgvlhhopehsmhhtphdqohhuthdquddrmhhinhgvshdqphgrrhhishhtvggthhdrfhhrpdhmrghilhhfrhhomhepsggvnhhoihhtrdhgshgthhifihhnugesmhhinhgvshhprghrihhsrdhpshhlrdgvuhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0

Hello,

Usually after few days, some of my user get permission revoked to where
they have the permission. The issue does not affect all users and all
clients at the same time. As instance an user can have access granted
on host1 but permission denied on host2, Moreover an user1 can have all
his permission working properly, while another user2 get his permission
revoked on the same host.

After a reboot usually everything work fine for all users.

It seems that the user are not map anymore to the right one because,
the user can read directory with "755 but not private one, i.e. with
700. Moreover he still have write permission on at less some directory
with "755".

What I can do to fix this issue without annoying user that have correct
permission ?

I tried to restart nfs-client, nfs-server, rpc-nfsidmap, winbind,
gssproxy without success.

Thanks by advance

