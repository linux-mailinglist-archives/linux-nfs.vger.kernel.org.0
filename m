Return-Path: <linux-nfs+bounces-5522-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 233D195A0C9
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 17:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39F21F23389
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C8A79F4;
	Wed, 21 Aug 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0QYw1ViK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B01E522
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252425; cv=none; b=AG+nirPtJaaZipswPs3zQlwqyxfoXX4PJpRRppqh5PtEtMJD4ogHL6WSuY/OtA7EsjQWqXq+7x1DrtL9GtNiod26D9heN11LLUZxvd4atnBMxcTEaBRyGFZ+0fYvSz5gAcTe0/SPuahaXbrxK2yOSsahvVIeetIKxrQs48s7o3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252425; c=relaxed/simple;
	bh=ElvlVSj6gmAMylbg7IWWxU4R7SKSjOTgKlwfsv+H3xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoYGfgVAstviXhehMZoYah6tQrjjDCX/Ro5Ri5gQ3pYShWp+fZB23DrHApnPtSQfjUoJbcqgIz54iLYooz4A9g2MPHoqwDWk0+Q0clp7A8U/UYH2gn+GxzvEKMGr/7eIj7CU7fChVVYAbtsPFAmLvFge7r31ZgFSWUh1qV3cC3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0QYw1ViK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4FL9TY89FJg4H2vJAT59zMGji74dhlYArPhROBAgpaU=; b=0QYw1ViK60WgXeG8obpzI0v6P5
	qN+vvlifsKJA2YhTCWiT7N9g0Eg2MNNEZ58FSbtksf5QN46lr436YOT4/TF5SfEUNGscao+Y9iMDw
	vILn0nooEcXm+EwhBYLK4iZExeDev8HaDbFVo/dn1Vooc8IJqlaZaqm2s+I796BsQYPdcRikfZtla
	okYlq+x2NGqNxwb/h5+Vg09bjSRfoPNIzinR8WRSq9WdO+0cmn/sNPsHa3N5wObGt4BrMhJWNFJq/
	HYfAlFN4HZNx/wGH8237/FWAT3mfKoapftEGLYt4v4DfiHJLzJOVguLw193RoRp95Jbbp8wGqWLfu
	oP1GaEUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgmou-00000009PPP-26Do;
	Wed, 21 Aug 2024 15:00:20 +0000
Date: Wed, 21 Aug 2024 08:00:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 2/2] NFSD: Create an initial nfs4_1.x file
Message-ID: <ZsYBBPF98kHVaJQn@infradead.org>
References: <20240820144600.189744-1-cel@kernel.org>
 <20240820144600.189744-3-cel@kernel.org>
 <6a3d9288fdeb6409dca7c2ceedf249d3b40a7d97.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a3d9288fdeb6409dca7c2ceedf249d3b40a7d97.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 21, 2024 at 10:22:15AM -0400, Jeff Layton wrote:
> I'm not sure of the best way to work around this, unless we want to try
> to split up nfs4.h.

Can we just replace the structure definitions with the generated ones
ASAP in one big patch?  And then only do the marshalling code piece by
piece as needed/wanted?

> 
> Also, as a side note:
> 
> fs/nfsd/nfs4xdr.c: In function ‘nfsd4_encode_fattr4_open_arguments’:
> fs/nfsd/nfs4xdr.c:3446:55: error: incompatible type for argument 2 of ‘xdrgen_encode_fattr4_open_arguments’
>  3446 |         if (!xdrgen_encode_fattr4_open_arguments(xdr, &nfsd_open_arguments))
> 
> 
> OPEN_ARGUMENTS4 is a large structure with 5 different bitmaps in it. We
> probably don't want to pass that by value. When the tool is dealing
> with a struct, we should have it generate functions that take a pointer
> instead (IMO).

Yes.  Probably marked const to clarify that it isn't supposed to be
modified.


