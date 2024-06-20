Return-Path: <linux-nfs+bounces-4148-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B971D9107C7
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724C8281040
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB98F17554A;
	Thu, 20 Jun 2024 14:15:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38F111A8
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892927; cv=none; b=aV8k4JyUmHtcFINLj7arRINyJjUHpzTv24wSsE2B6AEu//rPOvdKtXmMEbnFcYHBP9Llbq1LiW6gpingvsitsoj9sOps9R766iU4FxQ0jGqV2Jm/XJEdfdBeBeBlYRsrG2LeW+cZMX4Lr7sUthSIMfY/5BOMGdkzjs0La+mfM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892927; c=relaxed/simple;
	bh=++8ZYBuYHpAILHEUdH3aahd6uJqwYnD3sMsj6FN3Dto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUU7OcYqsqXLUbB6eugKOW+RrZ18jmfa2nbFe8V+URVgV8nLlAxVfT8sHNZa79cTimAGfKm9C9CmgArbaSDpplBDQHCTG565pAbJFHRlnZQnACiRUMzX9j2eKVM8IklK7geG3wOLSepNBu2iBoTvhv6a7zmOe0PIu3SJkvX8qtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C7ED468AFE; Thu, 20 Jun 2024 16:15:20 +0200 (CEST)
Date: Thu, 20 Jun 2024 16:15:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, cel@kernel.org,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <20240620141519.GB20135@lst.de>
References: <20240619173929.177818-6-cel@kernel.org> <20240619173929.177818-9-cel@kernel.org> <20240620050614.GE19613@lst.de> <3859730C-40EC-4818-9058-D74E4153623B@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3859730C-40EC-4818-9058-D74E4153623B@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 20, 2024 at 09:52:59AM -0400, Benjamin Coddington wrote:
> On 20 Jun 2024, at 1:06, Christoph Hellwig wrote:
> 
> > On Wed, Jun 19, 2024 at 01:39:33PM -0400, cel@kernel.org wrote:
> >> -	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
> >> +	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0) {
> >
> > It might be worth to invert this and keep the unavailable handling in
> > the branch as that's the exceptional case.   That code is also woefully
> > under-documented and could have really used a comment.
> 
> The transient device handling in general, or just this bit of it?

Basically the code behind this NFS_DEVICEID_UNAVAILABLE check here.

> >> +		if (d->pr_reg)
> >> +			if (d->pr_reg(d) < 0)
> >> +				goto out_put;
> >
> > Empty line after variable declarations.  Also is there anything that
> > synchronizes the lookups here so that we don't do multiple registrations
> > in parallel?
> 
> I don't think there is.  Do we get an error if we register twice?

Yes.  That's the basically the same condition as the one that made
Chuck create this series.


