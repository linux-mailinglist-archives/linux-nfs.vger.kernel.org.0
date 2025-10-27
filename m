Return-Path: <linux-nfs+bounces-15653-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BE4C0CFCB
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 11:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42F3734C7BC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC82DCF6C;
	Mon, 27 Oct 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZzbI+A+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972142AA1
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561610; cv=none; b=eke+2XlULUtFQ4brLB/4aRVA/AN3aFlnswSFzkGL4YLr0E62prVciaul3P8vIrsnCWV8DKaNgrfrQdFOsuNcg3+Wlh5elFNOZ1Z2qaKNew0XFHvgIJjE3Bw9SaxEs/HB3LiXj0l2zS6IxEITNxDnfetr+YgbRqfAMjyvrt74yus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561610; c=relaxed/simple;
	bh=ALmAlyPrHzK47Cybn5T0pzI0o7FzMzoay3qtbdjcqUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFBf/VLAln+fjAZbqHZqt/pP5wCQkpEuTMq1ks04+eBT9JO1OI5Cf31jqcTWl58tS0AcKYrxmMMMWzo2idIU6wF5Yanl9oCtmJleLsDZ0jb2zYB3bUGHY/ASva1DWDo8CgHO2a9Fyst9oUlZVw/YHv2GyaNAnDZyPi/l83Of5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NZzbI+A+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RNOBKlN7DopnkHS0Jap+3cs8u//UU47E0DRl4JAwKNc=; b=NZzbI+A+1WA0ELOWz6wjIBKd1G
	btzjV4p8avijZknZa+w/iq4vRF4urh1ua5gXln70xlGPsGCJ8RsOJQLKeWhrxcCE5+F1b68yaUBeA
	o9fr76TSV8QuEP1dR5AOYw0zjbfUrotd+13WCwGw0xhC0f+D9pFFPYUu6E52C4xhjMxLdjjf6xOuJ
	54TDcxLAfaInJawgocdK9DRPrk5EjWExOVKAlXS8vcBRpxf8w3/amGZked+XJh45cpU8GuKsaGrvs
	GSQHHD1gakwPLOl01kXG1JqKHo9gfu/gJDZBozN6gGkGAfA9AQ1Bjp2XXGmvHAVpbh+/nacyrsieq
	4PIcoTdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDKdv-0000000DfxA-2QvX;
	Mon, 27 Oct 2025 10:40:03 +0000
Date: Mon, 27 Oct 2025 03:40:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 06/14] NFSD: Always set IOCB_SYNC in direct write path
Message-ID: <aP9MA_mYl_-q_yMV@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-7-cel@kernel.org>
 <aP8oeGDzWIDgWra2@infradead.org>
 <9093dd789a095e26eb90caa361469800b0b0f48a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9093dd789a095e26eb90caa361469800b0b0f48a.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 06:38:36AM -0400, Jeff Layton wrote:
> > I still haven't understood why we need for for sync writes with direct
> > I/O.  The comments suggest it has something to do with the buffered write
> > fallback, but even for that I don't really understand it. But for pure
> > direct I/O writes that are properly aligned there definitively should be
> > no need.  If there is a need for the fallback we really need to explain
> > it, as it's non-obvious and a performance issue.
> 
> The current DIO scheme has the server writing the aligned middle part
> of the range using direct I/O, but any unaligned parts at the start or
> end of the WRITE will use buffered I/O.
> 
> I don't see a need for sync writes with the DIO parts either, but the
> unaligned buffered ends need to be synchronous so that we know they hit
> the platter before we reply with NFS_FILE_SYNC. 

You also need IOCB_DSYNC for direct I/O to hit the media if you want
to return NFS_FILE_SYNC.  But I still don't understand why we want or
need to return NFS_FILE_SYNC to start with.


