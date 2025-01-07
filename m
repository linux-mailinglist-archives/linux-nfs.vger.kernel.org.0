Return-Path: <linux-nfs+bounces-8951-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B7A04A45
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 20:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F8F165840
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 19:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476C01DE889;
	Tue,  7 Jan 2025 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dimebar.com header.i=@dimebar.com header.b="Fl1ER7Ts";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U1Q5fOuK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7E225D6
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736278312; cv=none; b=l//WljkcP1r7LeLzVTXhvD/mYUDZWdfMO5crFqUIS4LKjHBGBDP3x6YgcoI7AVFBcbSsB9FOHMA1KiYegBn2Ta01V09HSUt/Lh7QiDmL1aYnlK0tAWVdRamdUWvmP31xMYJr7XBZ/ZQrLmul7/XsEb5n4gn1+6Zoe1n5ZCVfPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736278312; c=relaxed/simple;
	bh=/xSHFVoGgG23v2SMpqU6VFc10ChS6NSFoe2wZ9B/3aY=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=kzRHwTXMSHwMdAJ9hQQtTSeEdG5SZ40/9Af/PODW4Dpkvf2fOf9RWV8BMfA3HI6gl+AuXvtbyIN8n1hVjqQ9HT8Ujfxq+S2YKt6q27xkN6VSpuueXTenjuDLFJuvIMHob3Li0Ssnr5UeXdErZPse4XdCdfHaINlnsV1AsQOPYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dimebar.com; spf=none smtp.mailfrom=dimebar.com; dkim=pass (2048-bit key) header.d=dimebar.com header.i=@dimebar.com header.b=Fl1ER7Ts; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U1Q5fOuK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dimebar.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dimebar.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id BFBB51140130
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 14:31:48 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-10.internal (MEProxy); Tue, 07 Jan 2025 14:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimebar.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1736278308; x=1736364708; bh=fGTKkzDNKn
	9+ZAl1HcXGx+ogk7UrKwlIoPeCKBehpWQ=; b=Fl1ER7TsAP1XmsZPmR/V9Gdp7E
	bLcnNnBVzhgZ04G/hFXLcsVAYQuAb2fwkzfsnAOJrhzQzsc/Wa2Z1b9xLmG37PrW
	f/GKugCAyINT13Pp9aSTVoVDQbecl0BEEhSGlnzJzsn7J0BdABpcG97CxwDQ/8Ij
	arHOR/OhZ6UGsJ7Vquvj4XoiHFAvOINBM8TDDwxT7/+4MmMiolX3oEKsNE7TOAOQ
	e6XapHPqwU8O7ct6+4Js8qqALt8WP5L2jWAhSvxjQ+uaL2DO5d3kTeAnAUrN68xY
	ecMovPbr0XDm14NhaaizxHKzsEBgNnK++MyjhXrmQt0dRiJ+pamyQvuVMhXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736278308; x=1736364708; bh=fGTKkzDNKn9+ZAl1HcXGx+ogk7UrKwlIoPe
	CKBehpWQ=; b=U1Q5fOuKRTuRTH1wlV3Y2fwWpLgaiRx3SqtbvEfIQql/Yf4Jv0d
	ndaqeQmRHGtrov2hDLXLJ9i7Xb2QoWPW3YL2w5xPRIeP7fL3i3Dp52EFn8oY/7QU
	e3uPElR0ZgGaQICrTH1UsjZB2n9JWkpnbrEYwscufam+K5Hrs1/LNjR+MQttlbno
	CDvp0jwUOx3i1r+/1yMCmq756qVVTK1qHBwDefSduEcAxQFZ6CmhKQcZyLKkYx+P
	waOPIPqC59GpFoFE+tKA5OYMZ6GvWWv/K0zrtuaotgeTBDmZHWg1DsHBOOs7l4EU
	V0po+PGQ14Zvr2t0nQ5yyC2TI4+K7R+C+pA==
X-ME-Sender: <xms:JIF9Z9EFv63ukEdgArQbE6p8V2xg6L3WBW2hHBCMCFIr8taDdJAR7Q>
    <xme:JIF9ZyVcMXwOWc7RV0uiPrj-R4a8T5J9mLOZYzNjxsIoThXpnsVeVkdGsTNUFGMko
    whR8-YwwjlMx7Oh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkufgtgfesthhqredtredtjeenucfhrhhomhepfdfrhhhilhhiphcutfhofihlrghn
    ughsfdcuoehlihhnuhigqdhnfhhsseguihhmvggsrghrrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetfeetfedtkefgffeigeeuvdevgffhteffveejfefgvdeujeefveehvdfgleet
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlih
    hnuhigqdhnfhhsseguihhmvggsrghrrdgtohhmpdhnsggprhgtphhtthhopedupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:JIF9Z_LRSTkBDxED4TkCRnV4DqpJFEXTDLiF-skx6jiMtZ5BAFnJ7Q>
    <xmx:JIF9ZzE8CWMkVQl9tBtHwSI8P0r5dZW6pwBD0k8lRUnu4Em-O8fy0A>
    <xmx:JIF9ZzVrcq7qaMLliRufHXn0DrTGBDpBu7XmUCHeYE4qSZ6R9rwFSg>
    <xmx:JIF9Z-Pfy175JRxPAFtEGOp449eS996iUpZVV1ftOlZ4frryxNeufA>
    <xmx:JIF9Z6AOtWYVN-_o8uG6S-TiaCcOEFaPxFIEVrwj-o7MXhr_4BbUmOVI>
Feedback-ID: id0b949ab:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4B40E18A0068; Tue,  7 Jan 2025 14:31:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jan 2025 19:30:02 +0000
From: "Philip Rowlands" <linux-nfs@dimebar.com>
To: linux-nfs@vger.kernel.org
Message-Id: <12d7ea53-1202-4e21-a7ef-431c94758ce5@app.fastmail.com>
Subject: Regression for client nfs_compare_super with NFS_SB_MASK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kernel 6.1.120 / 6.12.2 and others recently changed the definition of NF=
S_SB_MASK which is used by nfs_compare_super to find existing superblock=
s.
   nfs: ignore SB_RDONLY when mounting nfs
   [ Upstream commit 52cb7f8f177878b4f22397b9c4d2c8f743766be3 ]

As a result, we now see mount options shared at the superblock level whi=
ch should not be shared, such as ro.

Steps to reproduce on Fedora 40:

mkdir -p /export/{stuff,things}/dir{1,2,3,4}
echo '/export/stuff  *(rw)' >> /etc/exports
echo '/export/things *(rw)' >> /etc/exports
systemctl restart nfs-server

mount -t nfs -o ro,vers=3D3 localhost:/export/stuff  /mnt/stuff
mount -t nfs -o rw,vers=3D3 localhost:/export/things /mnt/things
grep -w nfs /proc/mounts

# note that both mountpoints are ro, despite the explicit ro/rw options
# reversing the order of mounts gives a different result

I don=E2=80=99t fully understand the previous problem report regarding r=
epeated mounts with different options to the same mountpoint, but by rol=
ling back the specific patch, we no longer see the above unintended-ro i=
ssue.

Is there a reason that NFSv4 mounts don=E2=80=99t seem to trigger the bu=
g?


Cheers,
Phil

