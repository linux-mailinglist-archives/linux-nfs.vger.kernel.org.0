Return-Path: <linux-nfs+bounces-17227-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 050F9CCE873
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 06:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B27DA3035D21
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 05:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474402C08C4;
	Fri, 19 Dec 2025 05:24:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF62C237C
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766121884; cv=none; b=TT8eiIF1oUZHVJ8RUQNyBLIQ4qL5AkHGkVFb5G3xhOhbfX1olalPayJflRGwYAm74gPdXQm+WT2lhRRq4UnWA4titm/DjqR+Nq3w994mgwCi2Vv3mCjNkTHsNm9BZyLD+HXYNjXx4P/1mJ7CtQeWztTxAZlEvNLiifxz1Dne3sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766121884; c=relaxed/simple;
	bh=PlgwhZJDX5rlZfrnasBvMsSycpYUgNiG4dVsU9n4S9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn0qeFaIDI/IwWi/YW2jcPCbar7uy+Q3BlW1Mx0Ci/oHTyN3OlaOPwrC6EKvoIO3r/WNGsoU31tKPxf6N2WU+Brq0zir3iCWMXxaL7NOlkAQWJDY591MZYGc2ZaXNhNH2fflEG0pFk7VtCiRj1WVyTYxMc9DyggeNbCOlHBtZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0208B227A88; Fri, 19 Dec 2025 06:24:36 +0100 (CET)
Date: Fri, 19 Dec 2025 06:24:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Dai Ngo <dai.ngo@oracle.com>,
	jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com,
	tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] NFSD: Add infrastructure for tracking persistent
 SCSI registration keys
Message-ID: <20251219052435.GB29411@lst.de>
References: <20251215181418.2201035-1-dai.ngo@oracle.com> <20251215181418.2201035-3-dai.ngo@oracle.com> <20251218093434.GB9235@lst.de> <ecc09cc9-a0c9-499d-9d47-e90aa1f1815d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc09cc9-a0c9-499d-9d47-e90aa1f1815d@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 18, 2025 at 11:00:52AM -0500, Chuck Lever wrote:
> > But taking a step back:  why do we even need a new hash table here?
> > Can't we jut hang off a list of block device for which a layout
> > was granted off the nfs4_client structure given that we already
> > have it available?
> 
> My question is: how many items will this table need to track,
> on average? at maximum?

A good question that I do not have an answer to.  In my experience most
NFS deployments actually use exactly one export per client, and I don't
think I've seen a production deployment with more than a dozen exports
mounted on a single client.  Then again I'm usually pretty well shielded
from the worst enterprise deployments, so who knows especially in the
days of containers.  Multiply that by the number of clients.


