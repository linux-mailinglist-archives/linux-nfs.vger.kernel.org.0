Return-Path: <linux-nfs+bounces-14787-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C26EFBAA42A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 20:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D7F7A3B03
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C650227EA8;
	Mon, 29 Sep 2025 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQr5i309"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A919F13F;
	Mon, 29 Sep 2025 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169499; cv=none; b=oaeJinlPDvdeLmBvM+u9uZoTJsGPFanW9hZu5F4CAENyRwsFF1Egp0O6etmVmRlY3zrDiBkwWCOjXde0w9oFkNopYbNyX7zcab1f561iNEHkmrbiWId8oJRgk3ZLak7I1F7V4qR1gBDZTJ+QBVC62ryT0S5dqqzeMoP0MPhg1lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169499; c=relaxed/simple;
	bh=hdu3bhlrEme+478yUOK9/20Sy8ERLhlKWPwSRnRLSQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKYXkqYCVllyIwaD60G251K3rLxtqGW+7MmCvEHnsXL3OaeDiXSPMNHYs0j1G/CMNCDtoq7Hpr8YJBDTYS4tC7f0m2F7vh3mC9QKZ6r0j4dzd67daSS7JLea1ZASKhtMx3gFR4apsabfooKeXB1AvKH13l4DjuBDPOgZL9GZQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQr5i309; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA192C116B1;
	Mon, 29 Sep 2025 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759169499;
	bh=hdu3bhlrEme+478yUOK9/20Sy8ERLhlKWPwSRnRLSQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQr5i309rHVagQVHkwfV0DACT6ByO9f71g3zX7T5rvSmYlXQKaQ5pJEjW12ZsCGlW
	 rc/I8sF7AA9FC5H2PrJNS4Y/V1iB3L6h+ogaZoVUgf+uAFJLoVSJU6h+O/x1RRgQBy
	 crUkdhtuSqXzsK0VxPipJnbdYCx5UXFldLR7jzr/p3VjaH4a/KTzTn/AY9afemDMDw
	 QK/ISDX4Ql8pul2CVqko2BBZndh/T15gpnl25P4SbDXhnyJdWPfpJ19CQM4TgAEoUt
	 mnTKCjRIV4BJSvKipkCGKKxH5fHD24BVuP26ol2XYvN3MhkeMujYGU7uWKvXvbArZE
	 d2XbC7hs2MYtw==
Date: Mon, 29 Sep 2025 13:11:34 -0500
From: Nathan Chancellor <nathan@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2] nfsd: Avoid strlen conflict in
 nfsd4_encode_components_esc()
Message-ID: <20250929181134.GA685251@ax162>
References: <20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org>
 <175910219642.1696783.1969092567455681202@noble.neil.brown.name>
 <4614aeaa-f366-4b53-afb4-ae6747589d05@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4614aeaa-f366-4b53-afb4-ae6747589d05@oracle.com>

On Mon, Sep 29, 2025 at 09:05:15AM -0400, Chuck Lever wrote:
> On 9/28/25 4:29 PM, NeilBrown wrote:
> > On Mon, 29 Sep 2025, Nathan Chancellor wrote:
...
> >> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> >> index ea91bad4eee2..9fe8a413f688 100644
> >> --- a/fs/nfsd/nfs4xdr.c
> >> +++ b/fs/nfsd/nfs4xdr.c
> >> @@ -2640,11 +2640,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
> >>  	__be32 *p;
> >>  	__be32 pathlen;
> >>  	int pathlen_offset;
> >> -	int strlen, count=0;
> >> +	int str_len, count=0;
> >>  	char *str, *end, *next;
> >>  
> >> -	dprintk("nfsd4_encode_components(%s)\n", components);
> >> -
> >>  	pathlen_offset = xdr->buf->len;
> >>  	p = xdr_reserve_space(xdr, 4);
> >>  	if (!p)
> >> @@ -2670,9 +2668,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
> >>  			for (; *end && (*end != sep); end++)
> >>  				/* find sep or end of string */;
> >>  
> >> -		strlen = end - str;
> >> -		if (strlen) {
> >> -			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
> >> +		str_len = end - str;
> >> +		if (str_len) {
> >> +			if (xdr_stream_encode_opaque(xdr, str, str_len) < 0)
> >>  				return nfserr_resource;
> > 
> > I probably should have said something earlier, and this is definitely
> > bike-shedding material, but .... "str_len" is not a whole lot nicer than
> > "strlen" (or "i") ...
> > 
> > 
> >    if (end > str) {
> > 	if (xdr_stream_encode_opaque(xdr, str, end - str) < 0)
> > 
> > ??
> 
> "len" is actually the typical variable name used in such cases. But I
> didn't want to bug Nathan for a resend.

If "len" is truly preferred, I do not mind sending a v3 with such a
change. I had only kept "str" in the name because there is also
"pathlen" in this function.

Cheers,
Nathan

