Return-Path: <linux-nfs+bounces-16184-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5F9C40990
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DE33BBF4C
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697252F549F;
	Fri,  7 Nov 2025 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshua.hu header.i=@joshua.hu header.b="F1yQAeD0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7C2DF143;
	Fri,  7 Nov 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529608; cv=none; b=iYOIHDr7XuMjsZ3NFesDyozqD9mm5O8KTk8Lb4mpF8UFDqQYcaRB/yfBenO1YaWJe6sQ/la2YAJFqDVbhdKCHZCAYx8SjgtcMQ8AkkESkhESjhIjeGD85APBZym3sRvVG6N7HRwEcn0zAWpIQU4+r8y794kQe+Tm80r54ZqSBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529608; c=relaxed/simple;
	bh=kjg383YF4V5gMKJkRMwdf6DMCJZdUCNBnKqt93sK2ao=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gydnd6xzuacd7kjJL8OuP8ifYepAN17JpDj+cm34LvwIcZPj//QolgyByxfBO1YW7X0QHdg3FPcUC4PmgHzQ1M8IkXC1DCo1RD3gPJjGw9QwCUVnR+8S0QHhXylLYPn5LRejaoF4fZXMKxAN6XCVGpTNgcxxIgQC3UVB7OG+jjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=joshua.hu; spf=pass smtp.mailfrom=joshua.hu; dkim=pass (2048-bit key) header.d=joshua.hu header.i=@joshua.hu header.b=F1yQAeD0; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=joshua.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshua.hu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=joshua.hu;
	s=protonmail2; t=1762529591; x=1762788791;
	bh=kjg383YF4V5gMKJkRMwdf6DMCJZdUCNBnKqt93sK2ao=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=F1yQAeD050Bkaz5EIV8HsIHdiGqDeXgGGGCJTXiV+kpWIbJc9/vWT2i/+OPCZsyJK
	 SmrbHf2NfgO/4rRM44KMyRa2UsEhNOM0gtA+U3jYujTmvFKP6C6kzqaArZOUvLF3kc
	 8oc0ArWMX/1HHTX4EegART3LWs/TkC28qa+WEoYRWwZsLICVMWxnk4uRXNRO164kMI
	 usRxPm8JtO7B3qQe5xbw8URqeDEi3XFX2arnIsE16O6yOu2Mzk9fNHO3lexy8GHpgp
	 kzL5HRUGrMBJMq4VPaZeg7P92ZXKCuKpJjeJ9fwTwgodCsw3brmtw3QW6+dJxVtCyr
	 QB/vSuV40bcyQ==
Date: Fri, 07 Nov 2025 15:33:05 +0000
To: Chuck Lever <cel@kernel.org>
From: Joshua Rogers <reszta@joshua.hu>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Joshua Rogers <linux@joshua.hu>
Subject: Re: [PATCH 1/3] svcrdma: use rc_pageoff for memcpy byte offset
Message-ID: <XGrEQAquPtPkXsfrTIl7DWn7XiZ60-155zIIzZHtUshCNeOd8eeAMcm4NgGu8PQK03PLynLPzfc33pEpGN3f2lzGuFBOocvb_YFo1y4WuJA=@joshua.hu>
In-Reply-To: <5bbbbf82-a44b-4093-9119-c221f9e8f9a1@kernel.org>
References: <20251107150949.3808-1-cel@kernel.org> <fxcda7FkdbPG_fttyXlSupjn11fncefYSlmcpQVVhEqZtDujhBlOxPADG_Havmcju29ZqPMXVwmMI980FtUVWs9jDUYiy-JWbaClISNNwQk=@joshua.hu> <5bbbbf82-a44b-4093-9119-c221f9e8f9a1@kernel.org>
Feedback-ID: 126372902:user:proton
X-Pm-Message-ID: d58b71d5e95144e7ed5713ba9a57fd9ae6b37508
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sounds reasonable, or "Found by Joshua Rogers with ZeroPath(https://zeropat=
h.com)", but I have no problem with either.

thx

On Friday, 7 November 2025 at 23:30, Chuck Lever <cel@kernel.org> wrote:

>=20
>=20
> On 11/7/25 10:23 AM, Joshua Rogers wrote:
>=20
> > Apologies: is it possible to slightly change the commit msg to include =
"Found with ZeroPath"? As this bug was, indeed, found with a tool called Ze=
roPath. If not, it's OK, thought I'd ask.
> >=20
> > Thank you.
>=20
>=20
> Patch description in my tree now reads:
>=20
> svcrdma: use rc_pageoff for memcpy byte offset
>=20
> svc_rdma_copy_inline_range added rc_curpage (page index) to the page
> base instead of the byte offset rc_pageoff. Use rc_pageoff so copies
> land within the current page.
>=20
> Found by ZeroPath (https://zeropath.com)
>=20
>=20
>=20
> > On Friday, 7 November 2025 at 23:09, Chuck Lever cel@kernel.org wrote:
> >=20
> > > From: Joshua Rogers linux@joshua.hu
> > >=20
> > > svc_rdma_copy_inline_range added rc_curpage (page index) to the page
> > > base instead of the byte offset rc_pageoff. Use rc_pageoff so copies
> > > land within the current page.
> > >=20
> > > Fixes: 8e122582680c ("svcrdma: Move svc_rdma_read_info::ri_pageno to =
struct svc_rdma_recv_ctxt")
> > > X-Cc: stable@vger.kernel.org
> > > Signed-off-by: Joshua Rogers linux@joshua.hu
> > >=20
> > > Signed-off-by: Chuck Lever chuck.lever@oracle.com
> > >=20
> > > ---
> > > net/sunrpc/xprtrdma/svc_rdma_rw.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/=
svc_rdma_rw.c
> > > index 661b3fe2779f..945fbb374331 100644
> > > --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> > > +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> > > @@ -848,7 +848,7 @@ static int svc_rdma_copy_inline_range(struct svc_=
rqst *rqstp,
> > > head->rc_page_count++;
> > >=20
> > > dst =3D page_address(rqstp->rq_pages[head->rc_curpage]);
> > >=20
> > > - memcpy(dst + head->rc_curpage, src + offset, page_len);
> > >=20
> > > + memcpy((unsigned char *)dst + head->rc_pageoff, src + offset, page_=
len);
> > >=20
> > > head->rc_readbytes +=3D page_len;
> > >=20
> > > head->rc_pageoff +=3D page_len;
> > >=20
> > > --
> > > 2.51.0
>=20
>=20
>=20
> --
> Chuck Lever

