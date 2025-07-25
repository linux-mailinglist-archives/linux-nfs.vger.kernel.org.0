Return-Path: <linux-nfs+bounces-13247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E813B1278E
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Jul 2025 01:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9064B587FA0
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jul 2025 23:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002E25A2C2;
	Fri, 25 Jul 2025 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4fcou9p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783712E3712;
	Fri, 25 Jul 2025 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753486782; cv=none; b=IaCuw5TI+O4qojLLdyRgPQizC4+hfLePrPCYkhg+Rk6z4OBdRXLeJcSH8gJ27wJDjVZ+WTLlOZVQ3bDgQ8Pdgg5m6grPIxr8Xhnt6J6tWg7Ao+08rX+WEPGfO7YT1G07sp8Pv7aebSytK4noBFKwXZOgggIN+ctcrXYsgPjwSgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753486782; c=relaxed/simple;
	bh=QAJhBZEKBi+fXfmFPtavuboHfYxCAoLnW4kc0GrNjWc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/E02Jr7FMq2OEvc5fu5R9NdtxKCGH8PzhgP/dFYMgWF7s8xldps8L9Yj3Y+KAkJ+6hWamWoAr+sNlQQyG+nVAVrDDva9tjJ2e9gROGmOFedOTSEb2gzGvAtD9GwEZQs5nHaxkPzr7j3bKfTl9gc70OaBFPW2fsm1m3wrUPaMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4fcou9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC11C4CEE7;
	Fri, 25 Jul 2025 23:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753486782;
	bh=QAJhBZEKBi+fXfmFPtavuboHfYxCAoLnW4kc0GrNjWc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P4fcou9pG2F3wksl49IJ1yM/FFU+GtbaLNJTZnVnDCqWzW+eDxvZ23dNUOQY1Rwik
	 4zkUbFxjc20KT2xFgQNLtUcB+l/gMKBH5jJZ0ZH2u3vFm8un4u2EkU5bTgOmQYA54S
	 9s87BcQbA6xDFhxCvHfU4hFVa7lNottOA8dIjLyVXfgEesmBOrTfqhSSu2V9PrzrVy
	 UmiYahWHq4cU2MQpuCgqxQgoLrPpRXzbUNdp1KfcJnCQV9fPdcZQBODXAl1BPJhHDR
	 mM1D59TAsuB5npJcRWBVpQusA704r9fSpYnmP64CZAwwiZxqCiSWg1b+Gsl+tmEKCY
	 yNSeu1xISOYmg==
Message-ID: <5e4699efd908ba40cf08e8900701108d09a590cb.camel@kernel.org>
Subject: Re: [PATCH v2] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
From: Trond Myklebust <trondmy@kernel.org>
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-nfs@vger.kernel.org, Anna
 Schumaker <anna@kernel.org>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 25 Jul 2025 19:39:40 -0400
In-Reply-To: <697350c4-f54a-4197-96f6-45ed53f08a4a@omp.ru>
References: <f769ad67-fc6b-4101-8bdc-8b41eba73a21@omp.ru>
	 <8244b3f4-ea69-46ee-9ba2-6711f516f00b@omp.ru>
	 <697350c4-f54a-4197-96f6-45ed53f08a4a@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-25 at 23:19 +0300, Sergey Shtylyov wrote:
> On 7/2/25 7:47 PM, Sergey Shtylyov wrote:
> [...]
>=20
> > > The nfs_client::cl_lease_time field (as well as the jiffies
> > > variable it's
> > > used with) is declared as *unsigned long*, which is 32-bit type
> > > on 32-bit
> > > arches and 64-bit type on 64-bit arches. When
> > > nfs4_set_lease_period() that
> > > sets nfs_client::cl_lease_time is called, 32-bit
> > > nfs_fsinfo::lease_time
> > > field is multiplied by HZ -- that might overflow before being
> > > implicitly
> > > cast to *unsigned long*. Actually, there's no need to multiply by
> > > HZ at all
> > > the call sites of nfs4_set_lease_period() -- it makes more sense
> > > to do that
> > > once, inside that function, calling check_mul_overflow() and
> > > capping result
> > > at ULONG_MAX on actual overflow...
> > >=20
> > > Found by Linux Verification Center (linuxtesting.org) with the
> > > Svace static
> > > analysis tool.
> > >=20
> > > Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > > Cc: stable@vger.kernel.org
> > >=20
> > > ---
> > > The patch is against the master branch of Trond Myklebust's
> > > linux-nfs.git repo.
> > >=20
> > > Changes in version 2:
> > > - made use of check_mul_overflow() instead of mul_u32_u32();
> > > - capped the multiplication result at ULONG_MAX instead of
> > > returning -ERANGE,
> > > =C2=A0 keeping nfs4_set_lease_period() *void*;
> > > - rewrote the patch description accordingly.
> >=20
> > =C2=A0=C2=A0 Forgot to say that I had to adjust the patch description t=
o make
> > it clear
> > that the overflow happens on 64-bit arches as well...
>=20
> =C2=A0=C2=A0 Gentle ping!
> =C2=A0=C2=A0 Anna, do you agree with this approach?
>=20
> > [...]
>=20
> MBR, Sergey
>=20

NACK. If you're going to bound check the lease time, then you can at
least make it a sensible value, not a random number chosen by some
peddler of silicon.

48 days (a.k.a. 2^32/HZ_1000 seconds) is not a sensible value for a
NFSv4 lease, and 571 megayears (a.k.a 2^64 / HZ_1000 seconds) even less
so.

Just bound it at 1 hour. If some use case turns for making the value
larger than that, then we can consider making the limit configurable.
Even 1 hour is a long time to wait for a file lock or delegation to
expire when the client that held it dies.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

