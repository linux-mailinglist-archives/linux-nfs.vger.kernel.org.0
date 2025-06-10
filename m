Return-Path: <linux-nfs+bounces-12233-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0ECAD2CBE
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 06:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11CE16AFC3
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 04:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E113020E711;
	Tue, 10 Jun 2025 04:35:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C821D7999;
	Tue, 10 Jun 2025 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749530104; cv=none; b=hlfXjU2WYmK2FWX6WdDvrIt6ztt+2IACW0RTg3OfyAX1OgRaVyA5eBYLoGOS6wGYavU9azNvSJwHRCp/oGNsFxgG+nvBnW7mjWeYFNY8kR5viox+FAJPZDChwwtdGbfYZVicuXnNz8jH3KtRtktL5T2+TLE6xd/0smX7B8cD7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749530104; c=relaxed/simple;
	bh=DmSqb4RyrJEUfQc38zpgEXHaWPa4Afjzig3KPbwxgxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a64aZq6ynbTllKFDPjPFpRr6cu6qCxMG2ESywJ1W9ArQMQsMlvQgQ07PyM0iC889YxeJN0RHZLPWqfixO8A3ye80AMiqehgyyUzRgC4z6r7nxMhFCo7maPmm5acOHBz0tCyhmy6lDRJ8LFGxdP0uQMd3XgLk+X+desWXz2P1mpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E026968C4E; Tue, 10 Jun 2025 06:34:51 +0200 (CEST)
Date: Tue, 10 Jun 2025 06:34:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
Message-ID: <20250610043451.GA24571@lst.de>
References: <20250515115107.33052-3-hch@lst.de> <c2044daa-c68e-43bf-8c28-6ce5f5a5c129@grimberg.me> <aCdv56ZcYEINRR0N@kernel.org> <692256f1-9179-4c19-ba17-39422c9bad69@grimberg.me> <20250602152525.GA27651@lst.de> <aEB3jDb3EK2CWqNi@kernel.org> <20250605042802.GA834@lst.de> <aEMbvQ7EekwPHQ8c@kernel.org> <20250609040143.GA26162@lst.de> <d34245cfc6c3dcf86969682e7c35a131c6100d47.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34245cfc6c3dcf86969682e7c35a131c6100d47.camel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 10, 2025 at 12:28:49AM +0300, Jarkko Sakkinen wrote:
> On Mon, 2025-06-09 at 06:01 +0200, Christoph Hellwig wrote:
> > On Fri, Jun 06, 2025 at 07:47:57PM +0300, Jarkko Sakkinen wrote:
> > > Ah, ok this cleared it up, thanks! Just learning these subsystem,
> > > appreciate the patience with this one :-)
> > 
> > I'm also just learning the keyring, so double checking from that
> > perspective is also always welcome..
> 
> After quickly studying tlshd, my understanding is that the ".nfs" is a
> "vault for transient stuff" passed to "keyrings" configuration option.
> After that serials within that vault are passed to mount-options
> defined in 1/2.

Yes.  I'll try to make it more clear for a resend, and I also plan
to write documents for using TLS and thus the keyrings with NFS and
nvme.


