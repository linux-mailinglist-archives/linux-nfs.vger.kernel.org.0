Return-Path: <linux-nfs+bounces-11709-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C677AB61F3
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 07:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE481788FF
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 05:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B643BBF2;
	Wed, 14 May 2025 05:05:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F2326ADD
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199151; cv=none; b=OEyLZ83+erjq68YvYGl4ufXDOh3ekJEOeIE7tynG5MvHm3nS62IMhvcdm4kPrSUbj7Lr8PnBVW104ebHsmgLKGOSprzzsfLaD8QaKaFls3DvY4YFAa7VDsEEn7tAgSiafmZ2WoPGQ1vMHIsiwloetS+4BriEkSt5ZahXjs5QowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199151; c=relaxed/simple;
	bh=1kkMJOhG9Do8L2ZrJ9cj4XV7fSJDBo1OzBeblR6EGOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt56wkatEgQsCt3lIFadQkSTgO7gdf2W4y0S5fD9qV8FcFE0/ClRTt0GIZzZJTqGoOj/eOQHYb4ZTl2o/G/ghaXP7TtXjaYEvrWG1GyzAtn4ZV//DJN1su3UFP5L6gMWnqct5VhCag0tNT4cjeQI5dweaoYNbeZxoDAxA0I3gmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9656A68AA6; Wed, 14 May 2025 07:05:44 +0200 (CEST)
Date: Wed, 14 May 2025 07:05:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] sunrpc: simplify xdr_partial_copy_from_skb
Message-ID: <20250514050544.GB24101@lst.de>
References: <20250513085739.894150-1-hch@lst.de> <20250513085739.894150-3-hch@lst.de> <758fc947dcd2e153c814a4b498bdaf953a46386c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <758fc947dcd2e153c814a4b498bdaf953a46386c.camel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 13, 2025 at 07:15:37AM -0500, Jeff Layton wrote:
> > +	bool		no_checksum;
> 
> The change is reasonable overall, but I'm not a fan of having a
> negative boolean like this (i.e. one that starts with no_*). Can we
> reverse the sense of this and call it "must_checksum" or something?

I can invert it.  It just seems like the normal case should be no-flag
one, but either version will work just fine.


