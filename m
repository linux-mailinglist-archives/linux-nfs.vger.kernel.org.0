Return-Path: <linux-nfs+bounces-10764-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD8EA6CB97
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 18:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A921732C7
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 17:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CFB14D428;
	Sat, 22 Mar 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Xf3uad7G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA642AB0
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742664009; cv=none; b=JaT5bdaOQpl+Cy42+gpyIxERDT9HetlML2laB4reMVpCLiAxhQ7rKzRjbGtw1VqNseZRZo2rQB4f5Dq2AL/7t8dQHWTbvNSCIQSM4+mo631+n594L5xkg+3lYE0Y6R5f3tnycFPLnpK/80NCHtpDsvgOpr5ZQwpRK6C7Jh7mWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742664009; c=relaxed/simple;
	bh=jMZa4qt3+OyRiqFTURRaX4H0Vwt9jgcIDLIGJVIAjnw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKp9WqLMqzYbZ4+zh3XIK1Ya1IVA58HGcEuM9Ybm84zJLM3fFnoFhzXjnjk1uHQPq4aURmhVKKKycT6xcBJEkoiTLhyuH0f9rusS5BNwq2Hk6iveA/kYezUzJ+2w5H2H9LdZi8cFks042FGmAH+U7mb+HirEmflGfXEI9cd80vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Xf3uad7G; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742664005; x=1742923205;
	bh=jMZa4qt3+OyRiqFTURRaX4H0Vwt9jgcIDLIGJVIAjnw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Xf3uad7Gf+O93RuN3iXVQbE+tnPG4FkIX1dw/5QBsqWRk2ownHU8Fri65BvSCWtWA
	 xvQZ4REjjjNg3oOSrb7hgXf1agpmUbMpUETY6CNrGgmu1nDfvbAAilqV8cxqfhB1wt
	 oAkV5syb36NSwffnmd5wTHjNKQtmQ+oqNAoxycQdRgtpSVxbJaEGzTyz9K3QK0C8qI
	 xWOkP3sAiilS0brJ0A/Sefqj8V+M+jkzA9qMX11JQBH6VrJUmycfqpfXQdLpPF2B13
	 Ec/VBV2uGAyA1AXfqEbmUhZZusQT6HoRf0OGZbJ7frp0zPyiDjZFSN2XFuxxkjlAUl
	 eYijs5mR0hh/g==
Date: Sat, 22 Mar 2025 17:20:00 +0000
To: Chuck Lever <chuck.lever@oracle.com>
From: John <therealgraysky@proton.me>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: kernel panic when starting nfsd on OpenWrt with kernel 6.12.19
Message-ID: <yW5ewBN3-dAMHSq9KmbFRPRt_fK0FTmuqclUbu4K1kZPcfB6DmXRPOVC_OAwh1waQz2Of0qUDqxQ3YL-NBULF9H6-HMdVjixFAad20f5sUY=@proton.me>
In-Reply-To: <0cd73138-baa7-4cd7-a6ed-7c5eefed495f@oracle.com>
References: <xD3JWWvIeTEG7_-UtXFNOaGpYHZL9Dr4beYme8ebQZiBvaBcTu3u7Q9GxE7cJrGRYsfTjC2BPxBTuyl1TijqjUP8_nC4tpcfekVKuBtDp68=@proton.me> <0cd73138-baa7-4cd7-a6ed-7c5eefed495f@oracle.com>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: e4df11acbb9ed9ef7474991c3482ad5aa0c2c7b1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Saturday, March 22nd, 2025 at 10:49 AM, Chuck Lever <chuck.lever@oracle.=
com> wrote:
>=20
> I recommend bisecting between 6.6 and 6.12.19 to locate the culprit.
>=20
> When you have that information, open a bug on bugzilla.kernel.org under
> Filesystems/NFSD and attach your information there.

Wish I could, but the way OpenWrt is designed, moving from one kernel branc=
h to another is major undertaking often requiring months of tweaks 1,000s o=
f patches, Makefiles, config files, etc.

I have been reading up on NFSv4 and am wondering if there is a way to simpl=
y disable the callback function. Could that work-around this crash?

Unfortunately, OpenWrt's nfs-kernel-server package does not ship nor use so=
mething like /etc/nfs.conf. At the link below you can see their init script=
 to start nfsd. Many thank for any ideas.

https://github.com/openwrt/packages/blob/master/net/nfs-kernel-server/files=
/nfsd.init

