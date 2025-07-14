Return-Path: <linux-nfs+bounces-13048-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F83B0401B
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 15:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BEF3A62DE
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 13:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB7825392A;
	Mon, 14 Jul 2025 13:31:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC3252912
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499900; cv=none; b=OCHCpAT8NBG9SkBPN/+T2SkiiU5OSryc6saFa0SdVLWpZ6HKXgiyJmH+KUK5IBVdNqVfZ6+3Pt/OHgqiVSto/oHiPXMC18x4RUjDUiS4lSFXjEFAB4jMQZvtnkUAX2GDEMtnFucwcCsWpTas6qrM1p2cqvTWJERIxHPub4rdn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499900; c=relaxed/simple;
	bh=pYM88Ni66gjseLNmt6rAVSJdrqXoZheEgK/zFTuVQvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOj8tz28+ofY8FBacQeZsAz3ncP2yFizbgLLXk3HeOiiBhFRBTjqd0VokOG0iRrVKWC9pSYiF25q2S25mVWrDiL9g3E8ZRknMHFdMneYAF35fvv3gElZA8/aGhDTsLZav6eRiffasWm6SJspgeWva28DIeitGOELpcs3fiUjIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F403227A88; Mon, 14 Jul 2025 15:31:36 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:31:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFS: add a clientid mount option
Message-ID: <20250714133135.GB10090@lst.de>
References: <20250714063053.1487761-1-hch@lst.de> <20250714063053.1487761-3-hch@lst.de> <cf337014-f8a6-44d6-8760-61663fef576d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf337014-f8a6-44d6-8760-61663fef576d@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 09:24:20AM -0400, Chuck Lever wrote:
> On 7/14/25 2:30 AM, Christoph Hellwig wrote:
> > Add a mount option to set a clientid, similarly to how it can be
> > configured through the per-netfs sysfs file.  This allows for easy
> > testing of behavior that relies on the client ID likes locks or
> > delegations with having to resort to separate VMs or containers.
> 
> The problem with approaches like this is that it becomes difficult
> to manage multiple mounts of the same server. Each of those mounts
> really cannot have a different clientid.

Having different clientids for multiple mounts from the same server
is the purpose and only reason for this option.

> For testing, why can't you use the per-container clientid setting?

Because having to create a container is a lot of effort when all
that is needed is just a mount with a different clientid.

