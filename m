Return-Path: <linux-nfs+bounces-13134-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E0B09135
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 18:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59926A46394
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2D92FA64E;
	Thu, 17 Jul 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRNPk1Bd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98ED248F7F
	for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768041; cv=none; b=gX2mX1+s2K6sxk8MVxkZdV2cqaf9Wqr8rUPoaSDdGggdtlc+rFz+evzpZEZnyPsY3UittnbzdolZbUl/pkrI5PqHCjEKdM5+pvy0PvClDo1ccstjykErY+4Oh0+UIx+yxrvrKpYEYkQmRgzcxNsETHeTQdiIJiApb0E21mlnLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768041; c=relaxed/simple;
	bh=k8XrmpooTdxHaUOSSyhs2NkGScbRWzBhaOGq1mhVYYw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkFx8r15Okd6/BuKCCvZclSGMgDu95pVdz5zENzxSk8/o8NxUzWqaV0YpmQjmKVk4imoGlz+uwUFnNL7ZJ6jMv8uMbm+RdnNaGvAa25YRk+NuyLsFgGJAQRapoLyDvNygqF0Aq0bKhe93CFW3vzMcdxRZY1yfFn4A67b8pjh5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRNPk1Bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76AFC4CEED;
	Thu, 17 Jul 2025 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752768041;
	bh=k8XrmpooTdxHaUOSSyhs2NkGScbRWzBhaOGq1mhVYYw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZRNPk1BdCV2CfoC6Wv3Wm5JmiU7fkzmzUfRyK3aLsmVBklDa45oPtZeVAXd+lGAVT
	 dhNwnsRk9CMUYUjgA7hKZoJIzMGg2fjGmhXbGNTzx4Pw8MTe0hvR6C3MxiPgvuYJ2a
	 spOwfF7FfZHX4S0lV7dXUaigwa3iDZUlMvxVHSFpsPkRWBMsHWr4NNXmC1j5kFFZbU
	 U72QhmAb6JP4W0VPsWRQK3NfB5brd+54UKXnygig2ddF/OrMIslcY+G6yezAZXa/WS
	 ZM9MfDEzZKkUgRWELrBKOgWajVwXPFaQK12A7bCVjFVpcUDG6Izv/e/kfSdyB8b9tS
	 MrpGCafEIZ/MQ==
Message-ID: <2ec3e240e811d9881f1513acaa06aff508bb996c.camel@kernel.org>
Subject: Re: [PATCH 4/4] NFS: use a hash table for delegation lookup
From: Trond Myklebust <trondmy@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Anna Schumaker <anna@kernel.org>, Jeff
 Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 17 Jul 2025 09:00:39 -0700
In-Reply-To: <20250717051315.GA27362@lst.de>
References: <20250716132657.2167548-5-hch@lst.de>
	 <202507171246.w67NRPWN-lkp@intel.com> <20250717051315.GA27362@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-17 at 07:13 +0200, Christoph Hellwig wrote:
> So nfs4 can be built modular, and delegation.o is built into that,
> i.e. we can't call into deletation code from clone_server.
>=20
> Back to passing a major number to nfs_alloc_server?

Why not just build a small wrapper in fs/nfs/nfs4proc.c that does the
allocation after calling the regular nfs_clone_server(), and substitute
that into the nfs_v4_clientops.clone_server callback?

>=20
> On Thu, Jul 17, 2025 at 12:35:07PM +0800, kernel test robot wrote:
> > Hi Christoph,
> >=20
> > kernel test robot noticed the following build errors:
> >=20
> > [auto build test ERROR on trondmy-nfs/linux-next]
> > [also build test ERROR on linus/master v6.16-rc6 next-20250716]
> > [If your patch is applied to the wrong git tree, kindly drop us a
> > note.
> > And when submitting patch, we suggest to use '--base' as documented
> > in

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

