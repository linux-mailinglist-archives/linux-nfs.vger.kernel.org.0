Return-Path: <linux-nfs+bounces-6611-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EB697EDF5
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 17:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64070B21940
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02113145B01;
	Mon, 23 Sep 2024 15:17:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mta05-relay.cloud.vadesecure.com (mta05-relay.cloud.vadesecure.com [195.154.80.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066480C0C
	for <linux-nfs@vger.kernel.org>; Mon, 23 Sep 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.80.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104629; cv=none; b=PM06XtXhUMFpgng2b8M002PTbKSeDfU3fRTpgkcgxLaWepcl+U/CgTy5l7POF7rP5wRqAn0yaMMhTJAcHS6KJtKU7xKBvtKe10fKqosdOxpSFx9pJ004DSaysADhsDjSfptcH/qRDgL/lp1MHVHenGXVIpJs+5KlEls8yZLMsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104629; c=relaxed/simple;
	bh=QopnpuAJYyZFrti3to9ikLu+Yd6buu8gy3QFtjLUtoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKYz5cFbLoZJVyi57sfUSnS+m+49zN9ksSrZjqnMIHp9hKUaXheR4zN1X+CYGofyrzJ22tcfKzpKffR9m/6JOmu2ckSel+fXzusSeW8p59ax6E0svhK0qIVbCqL6VzutvrIspJGRfYF8M5hNRkHs0QM9JAXIu5YnV5vk3WZq69Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu; spf=pass smtp.mailfrom=minesparis.psl.eu; arc=none smtp.client-ip=195.154.80.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minesparis.psl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minesparis.psl.eu
Received: from smtp-out-1.mines-paristech.fr (smtp-out-1.mines-paristech.fr [77.158.173.156])
	by mta05-relay.cloud.vadesecure.com (vceu3mtao01p) with ESMTP id 4XC5yj0XHKz7Qy5;
	Mon, 23 Sep 2024 17:10:21 +0200 (CEST)
Received: from z-smtp.mines-paristech.fr (z-smtp.mines-paristech.fr [77.158.173.137])
	by smtp-out-1.mines-paristech.fr (Postfix) with ESMTP id 01FECC0BDE;
	Mon, 23 Sep 2024 17:10:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id EEF541C00EE;
	Mon, 23 Sep 2024 17:10:20 +0200 (CEST)
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id LjONW1vVkJrc; Mon, 23 Sep 2024 17:10:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTP id 90FC21C00F4;
	Mon, 23 Sep 2024 17:10:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 z-smtp.mines-paristech.fr 90FC21C00F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=minesparis.psl.eu;
	s=9f5ccecf-24a0-4eb3-a015-b6ac3b07c299; t=1727104220;
	bh=QopnpuAJYyZFrti3to9ikLu+Yd6buu8gy3QFtjLUtoY=;
	h=Message-ID:From:To:Date:MIME-Version;
	b=b38M8FVu/Jk617PJCcdqiWW9eP6BkS4Skq2noPl7IhNpnJYQYP1KRqabMrJKjiPve
	 wHsdPBvafBwJg7BsEwvLD1d4yRdfI8K+ufyzlOhMucS6E+JHJ3N9+mKFAtt9RiLxJH
	 tktMR7Eun/M9E8zU3YuyR66UK+D0m8XlVHX/Y040vKxVFj8GuHVCwWtEU6JJHIErl6
	 80ECJDANDh8b+M1AwTCc/jYhAu6/mL/uhhaRx1C9M2wXZzYacBvhv18PEJmDochW77
	 ia6ZJms/EK3CftiSBG8HnntxDW0/or2P0ySkcGsXPXzS18peWx6C0RlimekRb+YANC
	 ai+YoLmemtojQ==
X-Virus-Scanned: amavisd-new at z-smtp.mines-paristech.fr
Received: from z-smtp.mines-paristech.fr ([127.0.0.1])
	by localhost (z-smtp.mines-paristech.fr [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rKF1jSjwFDTq; Mon, 23 Sep 2024 17:10:20 +0200 (CEST)
Received: from hive.interne.mines-paristech.fr (nat2-sop.mines-paristech.fr [77.158.181.2])
	by z-smtp.mines-paristech.fr (Postfix) with ESMTPSA id 58D6A1C00EE;
	Mon, 23 Sep 2024 17:10:20 +0200 (CEST)
Message-ID: <97b895a1955bfe8b6377edde714a70511a79c153.camel@minesparis.psl.eu>
Subject: Re: nfsd endlessly in uninterruptible sleep (D state)
From: =?ISO-8859-1?Q?Beno=EEt?= Gschwind <benoit.gschwind@minesparis.psl.eu>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date: Mon, 23 Sep 2024 17:10:20 +0200
In-Reply-To: <F7F4ADA9-9EEC-4607-A695-BB953FF91C8B@oracle.com>
References: 
	<29d539955368d357750e17bd615e2ae5f10e826a.camel@minesparis.psl.eu>
	 <F7F4ADA9-9EEC-4607-A695-BB953FF91C8B@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-VRC-SPAM-STATUS: 0,-100,gggruggvucftvghtrhhoucdtuddrgeeftddrudelledgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftvedpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeuvghnohpfthcuifhstghhfihinhguuceosggvnhhoihhtrdhgshgthhifihhnugesmhhinhgvshhprghrihhsrdhpshhlrdgvuheqnecuggftrfgrthhtvghrnhepkedugfegueeljeejffeiheeuleeufeefleevkeffuddukefhfeevheettdefgffgnecukfhppeejjedrudehkedrudejfedrudehiedpjeejrdduheekrddukedurddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdpmhgrgihmshhgshhiiigvpedutdegkeehjeeipdhinhgvthepjeejrdduheekrddujeefrdduheeipdhhvghlohepshhmthhpqdhouhhtqddurdhmihhnvghsqdhprghrihhsthgvtghhrdhfrhdpmhgrihhlfhhrohhmpegsvghnohhithdrghhstghhfihinhgusehmihhnvghsphgrrhhishdrphhslhdrvghupdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0


Thanks I will have a look

Le lundi 23 septembre 2024 =C3=A0 13:22 +0000, Chuck Lever III a =C3=A9crit=
=C2=A0:
>=20
>=20
> > On Sep 23, 2024, at 8:20=E2=80=AFAM, Beno=C3=AEt Gschwind
> > <benoit.gschwind@minesparis.psl.eu> wrote:
> >=20
> > Hello,
> >=20
> > In some workload on the server side I get nfsd in uninterruptible
> > sleep
> > and never leave this state. The client is blocked endlessly, until
> > I
> > reboot the server.
> >=20
> > How can I diagnose/analyze the issue ?
>=20
> When NFSD gets into this state:
>=20
> =C2=A0$ sudo echo t > /proc/sysrq-trigger
>=20
> Then examine the kernel log to find the back trace
> of the blocked process. If the cause isn't immediately
> obvious, then post the back trace here on this
> mailing list.
>=20
> --
> Chuck Lever
>=20
>=20


