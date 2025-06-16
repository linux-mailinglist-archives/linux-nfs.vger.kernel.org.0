Return-Path: <linux-nfs+bounces-12475-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB36ADB06A
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 14:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6770B3B2689
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F2226C3B7;
	Mon, 16 Jun 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mYlxNq8v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608392E425D;
	Mon, 16 Jun 2025 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077523; cv=none; b=YvV374hNCRyGpU9Lcve2em/xH+NVj+kQ+D6IIxII+q5vkVTRHwcSv9MOTfpQC2Iu17Nq/15HN11C58y+EAITUKWDAqYsrwdw0aacOk1rLaVtlsJ/rPl5yd55M8phUCAlqBgAbE3m97/oKiW7smOkxbN2AqG8LTXaT/CqXuA7lF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077523; c=relaxed/simple;
	bh=2ltqlIIBn25aFGJE9jGIf2VIx9huWL+caCyv3dej7nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSfc24/eNw6DsbZr9T1Cbap6pJT3APyL7BmP2S6rvOnXlwbVWY0MRFvYErKw5p9/dBfHBi7cJCYWJytDATlgQpdul/lcjpG81W4GmPDfpKiQUchCgaSdmRnRjWLYQzuIP3xh/O1/QciCPWreffRhNFWEwiJGVzfcCuiAMqgkInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mYlxNq8v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TcPoAt1CeMGYOo6rX61gaUIr0rent+VeY0L7mJmvlmU=; b=mYlxNq8vlNWVFTO7qTFyWsZnqJ
	2HEfvpx59cecshEdtYm7JdUIk9JE00UbsIfortKC8NbT+FGqNOZKhU6RV65bTcdvLGdLZM7TVx8as
	CHgk9djPWdYGK76ttZEpVmlm7RjXcWW5pF6z6xSgyalQ8LevfxBWn/NZaOcCQOEn2ZfLdgY4HlmPN
	l3RQnh+dj6/T+fU4pqaiI5jDnhNb4ZTherGINrAVHVRfV03WPlky60W70zQL7azMs/HBV3dGtHa29
	RL3H3xCSyyUGMHPneJl7zQy4OjsZassSGtHzNBlGMj19LESf81/qMYHBP/uaUUaNNgH7QSuM07s/4
	kc5puskg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR96l-00000004ORm-0qY2;
	Mon, 16 Jun 2025 12:38:39 +0000
Date: Mon, 16 Jun 2025 05:38:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH] nfsd: Use correct error code when decoding extents
Message-ID: <aFAQTwpSSJtDUmu8@infradead.org>
References: <20250611154445.12214-1-sergeybashirov@gmail.com>
 <5c8c207c-0844-492f-99e0-48b874b5404a@oracle.com>
 <2eq26bzisytieyfvad46uz5lr55msw6fdzs57lp5lcjmguuod2@nr2aryd6qaau>
 <b6ba7275-ceab-4619-9e5b-a886daf34689@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6ba7275-ceab-4619-9e5b-a886daf34689@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 12:29:51PM -0400, Chuck Lever wrote:
> On 6/11/25 12:24 PM, Sergey Bashirov wrote:
> > I also have some doubts about this code:
> > if (xdr_stream_decode_u64(&xdr, &bex.len))
> >         return -NFS4ERR_BADXDR;
> > if (bex.len & (block_size - 1))
> >         return -NFS4ERR_BADXDR;
> > 
> > The first error code is clear to me, it is all about decoding. But should
> > not we return -NFS4ERR_EINVAL in the second check? On one hand, we
> > encountered an invalid value after successful decoding, but on the other
> > hand, we stopped decoding the extent array, so we can say that this is
> > also a decoding error.
> 
> On first read of Section 2.3 of RFC 5663, there's no mandated alignment
> requirement for bex_length. IMO this is a case where the implementation
> is deciding that a decoded value is not valid, so NFS4ERR_INVAL might be
> a better choice here.

Section 2.1 of RFC 5663 says:

Clients must be able to perform I/O to the block extents without 
affecting additional areas of storage (especially important for writes);
therefore, extents MUST be aligned to 512-byte boundaries, and writable
extents MUST be aligned to the block size used by the NFSv4 server in
managing the actual file system (4 kilobytes and 8 kilobytes are common
block sizes).  This block size is available as the NFSv4.1 layout_blksize
attribute.

While it would be nice to state this again in 2.3, the language looks
normative enough (TM) to me.

