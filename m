Return-Path: <linux-nfs+bounces-4153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C047E91088F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740741F21436
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC5F1AD3F5;
	Thu, 20 Jun 2024 14:37:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7D1ACE8B
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894265; cv=none; b=Pb+yyw5Tf0+jqxGReXQIVaNH7T6xnFMb8uZJQAk59X5WS4FkHuA3Q4fDv9XGxrRVCRmuXx7b7I631RHluGZzKHdPRkZuN9fmeqzK5948zDmlmRotW9Lc/P7GTvsMwafXBoINn76xoQCXQtHnjDeACf7+TsGMz+vAzw8sGGrZI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894265; c=relaxed/simple;
	bh=qnU+57h6CsEwOQTV+47ru0eYWkZy7R2cv8wV1GCGCh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HelUKQbyxCSf6BerrGQ+RNz7atWbquV2InU1UfDONwPGkKXDglqD1V6Ep1ngeSstBys+FaVlESU3EKEeMHd3lc23Y+tDIQHDmbbbzqHbp1jiHJS0yyPT5drmZL/bmaRj5hiVb4s4OLi6C1g6h1SpzUuD6Zz4EF4LvbzUcPlPHQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 872C868AFE; Thu, 20 Jun 2024 16:37:39 +0200 (CEST)
Date: Thu, 20 Jun 2024 16:37:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>, cel@kernel.org,
	linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <20240620143739.GA23005@lst.de>
References: <20240619173929.177818-6-cel@kernel.org> <20240619173929.177818-9-cel@kernel.org> <D3359408-4D02-415A-9557-19A6EFE5DDCE@redhat.com> <ZnQ927sF7oRT+KmF@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnQ927sF7oRT+KmF@tissot.1015granger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 20, 2024 at 10:34:03AM -0400, Chuck Lever wrote:
> > No good ideas yet - maybe we can use a flag set within the
> > nfs4_deviceid_lock?
> 
> Well this smells like a use for a reference count on the block
> device, but fs/nfs doesn't control the definition of that data
> structure.

The block device actually has multiple refcounts, up to three
depending on how you count.  I'm not sure how that would solve
anything here, though.


