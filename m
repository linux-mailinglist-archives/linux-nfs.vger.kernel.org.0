Return-Path: <linux-nfs+bounces-10769-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658BEA6CBE9
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 19:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB5B3B130A
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Mar 2025 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E914C22F3B8;
	Sat, 22 Mar 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GgS0urfs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch [109.224.244.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100D1C84B6
	for <linux-nfs@vger.kernel.org>; Sat, 22 Mar 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742669910; cv=none; b=kTnYrmaZnY0vk14lHkR7ls+TiDhWZ6NosaZClPHvoqjn2KMJpaUxnWaZirU7vOXzhERfsXAegAvsI1bIkZmHa0szBEuaM5mAlqKAfeST5tj4sc169G+MGB/APa5cFeJkXLVURyUxEH1eGZ9l18ap855OxuUB4kG/qltU7sCpQHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742669910; c=relaxed/simple;
	bh=AQehVEGcHQlNtoNiVD+cDMG2JFMx+buNTLzFo+pJI0E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcnd9Zk3ABLYj/FRNI/HAGoftE11S+gYb3vlkQ3Lc7wzbbVA79cgTnoWRQf/HfUtJ9E85LKphOmIhfxZ0/m2qpWGOxSEijPPMlQDvx8oUkdcmzHykvUXMdBxkdlNEAXQt0Lq+zIC3KhWu1v6g4CnllF+eaI/JzviQcX0/HK2m2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GgS0urfs; arc=none smtp.client-ip=109.224.244.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742669536; x=1742928736;
	bh=AQehVEGcHQlNtoNiVD+cDMG2JFMx+buNTLzFo+pJI0E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=GgS0urfsd3ow57RM+0p6Ips7sY9lfNOUVbWa7IlEmtYCPBZ/9eD8MU+3noLWN2Hei
	 hiqZKzLl6nbkOdHRWDWVb1K0ho0QeOWuDy+rPPVZqHWay2gY6T7nx/BMU0os2zhIzn
	 feyASNSYOqN2LHz1QMPdVcovJo3SJbQpEVxUMfAon8s65PXEwZC2itwtprDhnPIm/A
	 40asZX68ZcBtJDfsQeGTGIrn+p3WGEWZ4y84vs2ygbXXOzxpF9JMpFLuCv/vImnfm0
	 +9MsAj5AQuBGbpo3DELVw5xHjF5gRnwL72JSe/EPS2VlGqid6F2KolZJyiLuxxtLdF
	 Tj48t2F94JH0A==
Date: Sat, 22 Mar 2025 18:52:09 +0000
To: Chuck Lever <chuck.lever@oracle.com>
From: John <therealgraysky@proton.me>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: kernel panic when starting nfsd on OpenWrt with kernel 6.12.19
Message-ID: <aftSYzYb2wDE8d8Q_6_jph3l5F2XfBHwu8PA6UBHPO4lq8UtgdpUoGk_YQcd1upHD4ynl1B5LWzPytWanWx2-JGJ11rCmZVKgrdF3y-pUuY=@proton.me>
In-Reply-To: <75ec06ad-7472-4e83-a20e-28543ec2909d@oracle.com>
References: <xD3JWWvIeTEG7_-UtXFNOaGpYHZL9Dr4beYme8ebQZiBvaBcTu3u7Q9GxE7cJrGRYsfTjC2BPxBTuyl1TijqjUP8_nC4tpcfekVKuBtDp68=@proton.me> <0cd73138-baa7-4cd7-a6ed-7c5eefed495f@oracle.com> <yW5ewBN3-dAMHSq9KmbFRPRt_fK0FTmuqclUbu4K1kZPcfB6DmXRPOVC_OAwh1waQz2Of0qUDqxQ3YL-NBULF9H6-HMdVjixFAad20f5sUY=@proton.me> <75ec06ad-7472-4e83-a20e-28543ec2909d@oracle.com>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 4d1879361cfa4f3d3ccaa3421b7649d68c08035e
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Saturday, March 22nd, 2025 at 2:06 PM, Chuck Lever <chuck.lever@oracle.c=
om> wrote:

> If this is a "product" kernel then you should approach the distributor
> first. I do not have the hardware, the binaries, the .config, or a
> cross compiler for whatever "Hardware name: iKOOLCORE R2Max/R2Max" is
> (guessing RPi ?)

No, this is the vanilla kernel + OpenWrt project patches. No vendor involve=
d. Also, both of the machines that are experiencing this bug are x86/64, no=
t ARM.

> This:
>=20
> nfsd4_client_tracking_init+0x39/0x150 [nfsd]
>=20
> suggests that your distributor (or LTS) might be missing a fix
> for recent crashes that are due to incorrectly setting
> CONFIG_NFSD_LEGACY_CLIENT_TRACKING. I'm thinking of perhaps
>=20
> de71d4e211ed ("nfsd: fix legacy client tracking initialization")
>=20
> in particular, which does not appear to have been applied to
> v6.12.19.

I applied this commit to my image build and found no bug upon starting nfsd=
 with 6.12.19. I will comment the bug report[1] with this info. Many thanks=
 for pointing this out, Chuck!

1. https://bugzilla.kernel.org/show_bug.cgi?id=3D219911

