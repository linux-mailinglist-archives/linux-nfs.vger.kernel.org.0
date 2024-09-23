Return-Path: <linux-nfs+bounces-6598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE41A97EB84
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 14:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6AA1C210B6
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21201974FA;
	Mon, 23 Sep 2024 12:28:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx02-out.cloud.vadesecure.com (mx02-out.cloud.vadesecure.com [109.197.246.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C7433D6
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.197.246.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094504; cv=none; b=Y5lHexSrBo5naibiO5BLZUEXWa90AkgYfC1hZYb+Z1gYjo4urioKGAYGRhKVtJTb7VWqEtbMXwHrZaJZ+16CzcMV732gCTHEUqYkuZuHlHmm4xmOuZ6y2IU3RVwdedvUX+uwNB2fkugYF/G1xWYhUuWoaHK52FsVNZRtv1ycrKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094504; c=relaxed/simple;
	bh=qqnqQ30HoG/XM1h0NhjiYkpfo6f9D9dAvp09gOW3/uw=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Q03MnarcfqzwNM2BWAHO3fbATITbFNysIAqaQ0KUiAPsgxpn0OQ9IDDl2a2HDVRFzg1W4sfDq3rVRYt0jw/LxQnrpZDboZ5i86+iMVS1vvamKY5Da8mKbN21ffPEAuFVtbmkYZ8+MdtSR+2F3YqgSHeC9ttmalUiAVX+2i9h8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu; spf=pass smtp.mailfrom=minesparis.psl.eu; arc=none smtp.client-ip=109.197.246.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minesparis.psl.eu
Received: from smtp-out-1.mines-paristech.fr (smtp-out-1.mines-paristech.fr [77.158.173.156])
	by mx02-out.cloud.vadesecure.com (vcfr1mtao02p) with ESMTP id 4XC2C00Kndz1tgT
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 14:20:44 +0200 (CEST)
Received: from z-smtp.mines-paristech.fr (z-smtp.mines-paristech.fr [77.158.173.137])
	by smtp-out-1.mines-paristech.fr (Postfix) with ESMTP id CF69CC0BDC
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 14:20:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id C3F851C00DE
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 14:20:43 +0200 (CEST)
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wdorPcRfcYeo for <linux-nfs@vger.kernel.org>;
	Mon, 23 Sep 2024 14:20:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id 419CD1C00FA
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 14:20:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 z-smtp.mines-paristech.fr 419CD1C00FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=minesparis.psl.eu;
	s=9f5ccecf-24a0-4eb3-a015-b6ac3b07c299; t=1727094043;
	bh=qqnqQ30HoG/XM1h0NhjiYkpfo6f9D9dAvp09gOW3/uw=;
	h=Message-ID:From:To:Date:MIME-Version;
	b=evtr9y7aqHrEKw+47z4jtxXSSLVHqmz5Qiu0B+Sx3kRdgx7rPfb1/D1tu/KzmpNLA
	 fKkg7EvvJVmMN4sXUu0Int6BJUruBpLKirYnAbOjmx+8Jw5la+VFKriSewRJS7V6JN
	 2hjzA1juzZxzFSwUspCUFOhSE5jgCARICTRF5M2Zlz+yxLsVZWz8WCWC8kzizjq3zf
	 8I/ANE8ZmFMlzS5XAT7yyMHFjb/tgQhKWrhX6TvsVSKqlc47SMPczw4VfR5Ddp60oH
	 hR7yrrP5rdpqX1cmHReoWE/FPB85CsCt1QgUpY3OVK7h8V1x1cPxdKr9/tcXoJB14C
	 hbXzIPUzQuplw==
X-Virus-Scanned: amavisd-new at z-smtp.mines-paristech.fr
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YFBNF29WPYN2 for <linux-nfs@vger.kernel.org>;
	Mon, 23 Sep 2024 14:20:43 +0200 (CEST)
Received: from hive.interne.mines-paristech.fr (nat2-sop.mines-paristech.fr [77.158.181.2])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTPSA id 09B7A1C00DE
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 14:20:42 +0200 (CEST)
Message-ID: <29d539955368d357750e17bd615e2ae5f10e826a.camel@minesparis.psl.eu>
Subject: nfsd endlessly in uninterruptible sleep (D state)
From: =?ISO-8859-1?Q?Beno=EEt?= Gschwind <benoit.gschwind@minesparis.psl.eu>
To: linux-nfs@vger.kernel.org
Date: Mon, 23 Sep 2024 14:20:42 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-VRC-SPAM-STATUS: 0,0,gggruggvucftvghtrhhoucdtuddrgeeftddrudelledgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftvedpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvffftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeuvghnohpfthcuifhstghhfihinhguuceosggvnhhoihhtrdhgshgthhifihhnugesmhhinhgvshhprghrihhsrdhpshhlrdgvuheqnecuggftrfgrthhtvghrnheptefhveeviefggffhuedtvdegieffvdehgffhgedvhefftdfgheduueevtdehuedvnecukfhppeejjedrudehkedrudejfedrudehiedpjeejrdduheekrddukedurddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdpmhgrgihmshhgshhiiigvpedutdegkeehjeeipdhinhgvthepjeejrdduheekrddujeefrdduheeipdhhvghlohepshhmthhpqdhouhhtqddurdhmihhnvghsqdhprghrihhsthgvtghhrdhfrhdpmhgrihhlfhhrohhmpegsvghnohhithdrghhstghhfihinhgusehmihhnvghsphgrrhhishdrphhslhdrvghupdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0

Hello,

In some workload on the server side I get nfsd in uninterruptible sleep
and never leave this state. The client is blocked endlessly, until I
reboot the server.

How can I diagnose/analyze the issue ?

Best regards

