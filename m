Return-Path: <linux-nfs+bounces-15496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3DDBFA092
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 07:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D5E94E03AB
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 05:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37272D7DD5;
	Wed, 22 Oct 2025 05:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OWbM6yvM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16F19F41C
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 05:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761110185; cv=none; b=XnyBat2K8Jcs8vVDD1vPjM3AabOhfHVjhDW2xV2VThTGI90tiv17OfrL1jTNsxqbwWWCX8brIXLF/VFuDMc2JDw9iB78sc2L6DVkoFBFvXfKSpiv4ELO/eWmNeRZXx8WMZdjJH9V9awIaFk7GqBIwAch2IiTg09lz3TKwAlZG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761110185; c=relaxed/simple;
	bh=SjSNUZ0BClGduBwZuVoqxRoL4qjczQb+dsw4SC4V5Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IleqjryBKzidWyCUqhVhXGbezVkqYTDCeOr8JIeuyKUQpqdq8zwqZFX7l45jUW0jRvfh5P2op16YttsEweycYc41VSJG0L73pTa50/ebSiqmofmWK2i9Kips01HAVJRXWw7V98hUMs6uL5bahf0r1HzDelocfhJkqiEXk9zGEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OWbM6yvM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6GVdD8XGxu3MZ0jWaF4CePfiqSeyzsuggFNpUQNzcg0=; b=OWbM6yvMYr3Cuh4KM1e9CqMPUb
	xFnn2+JL1pTxSVocvpf97L5hf27X3PNDUE+/zlpMvdCoO+SaKymViU5Bq5gGYQYbARMrpfTxwyrVx
	Yj2CghweF7Be2vLPYXNyZ2eLj8zYiYI8k2qiSvgdRZKZr5ItMvXM07SB0buOI8H7M01IT5kAPEO/D
	hqluQQPzmHbPEdGkGTpYkOpNS8ZOJp2LF97fEn6B09zd9OWC8ZLDTW/Tvnj8rTBYRBCXAVJkdm4Jq
	GRy2XDnF/4CCpq5ohZK9EHopNSl/3+x8zL2Y8WzNok6kayMCD2vSSPa8uNgEhT+dpsC6BLExmYr+G
	Yl5vxHug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBRCt-00000001Vn6-3zmm;
	Wed, 22 Oct 2025 05:16:20 +0000
Date: Tue, 21 Oct 2025 22:16:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPhoow9Z-r94b5AL@infradead.org>
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org>
 <aPXihwGTiA7bqTsN@infradead.org>
 <a5f3911ae6b65c70e1fd897bdd4f3e651decb196.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f3911ae6b65c70e1fd897bdd4f3e651decb196.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 21, 2025 at 07:24:42AM -0400, Jeff Layton wrote:
> Responding to a WRITE with NFS_FILE_SYNC flag set means that the data
> the client wrote is now on stable storage (and hence the client doesn't
> need to follow up with a COMMIT). This patch is using DIO for the
> aligned middle section but any unaligned ends use buffered I/O. If we
> want to return NFS_FILE_SYNC here then all of the data and metadata
> need to be on disk when the reply goes out.
> 
> Don't we need IOCB_SYNC here in this case? Otherwise, the server could
> crash while the metadata is still in memory. When it comes back up, the
> client could see stale timestamps. Maybe that's not fatal, but it seems
> pretty sketchy.

Why do you care about the timestamps which in NFS AFAIK aren't tied
to the data writeback in any way?


