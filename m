Return-Path: <linux-nfs+bounces-11761-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5B9AB9570
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 07:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BB23A7BAB
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 05:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98578F3E;
	Fri, 16 May 2025 05:16:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D95182;
	Fri, 16 May 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747372596; cv=none; b=s40B2wkSL5zX9NeNDPKver+j1uf19CBI6wpcNIK9Ta3PyJ3w3MlZUT97RA3n6g6rUxiVFvXqUMTl3zKSPUKybeQDLXJssN1Zxw2W59+LjSNFXU1ZIt6I+ks5TH/Ume9NBJ75ed/lTlfjhoeVeO6l1PkfqQ0NO2dYLvDtA4EzxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747372596; c=relaxed/simple;
	bh=1C8QSlgQEmoRK2cS1WzQXGhutZuGK+KyKiDw8Q/W4C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WR4ZOycMrcPPOQ0ltxJzg8jrNTUb4d+1TIw/R7/QdmREtsBPSGYtA/+0YX4O3kLGIr4SxRwB2mDU1lfZYIRlC4Yy2wUkLW+DVOMqcnXIftLWvkrCdTPqqNdZN0bwYszTl0dC14NDtW/tIptVBZldeCx+5DPgLfx9uxCEnRnZucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A6AC68AA6; Fri, 16 May 2025 07:16:30 +0200 (CEST)
Date: Fri, 16 May 2025 07:16:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: support keyrings for NFS TLS mounts v2
Message-ID: <20250516051630.GA13495@lst.de>
References: <20250515115107.33052-1-hch@lst.de> <79477eac-ba92-4d2a-9905-f5250e7e95bc@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79477eac-ba92-4d2a-9905-f5250e7e95bc@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 15, 2025 at 08:31:23AM -0400, Chuck Lever wrote:
> > Note that for now the .nfs keyring still needs to be added to
> > tlshd.conf, but that should go away with the handshake enhacement
> > from Hannes.
> 
> Just curious: Is there a downside to shipping a default /etc/tlshd.conf
> with the NVMe and NFS keyrings already added?

That's probably a good idea for the current situation, but doesn't
resolve solve the overall problem of having to add every new service
there.


