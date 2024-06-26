Return-Path: <linux-nfs+bounces-4314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6ED9177FA
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 07:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170E41C21A62
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 05:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECCA28DDF;
	Wed, 26 Jun 2024 05:19:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86922089
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379187; cv=none; b=E6Di9B1m/zfYR6yj7K+cIIJe2pzVZHmuydH839hJ68vV/GPqOs3XeEELZhioo8DWuqYe0xwILCKnTHTiHnmt7Ud0afiQ6QMkp9vjxLur7HVkeWbmN0aEJhUUbKKylT58nWDQCV8tzbuDQs1tMjWrvNnz9/rmn1p8Lu3nFnOXwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379187; c=relaxed/simple;
	bh=iUUzvYZ4SoLSY3hvdjvk1/RIUiOVuEeQvNd8GXF8x8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWo0db5KN9Te492WNa/mdZllhpXWEExvzdwRbxR0sqHBUQzgpOGSPRkBZ7ci/79kFJAJh21EvPd9BJH3CeZo1Q9qCHNR55fzQwvuvW3UAxl1jvn7+L/mjQa8ZNdKFkAxwvX/bTkNJYDlhAGrK91975rEzX+OEKCHeYOIB+TpxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 23CC368BEB; Wed, 26 Jun 2024 07:19:42 +0200 (CEST)
Date: Wed, 26 Jun 2024 07:19:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 1/3] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <20240626051941.GB21996@lst.de>
References: <20240625200204.276770-5-cel@kernel.org> <20240625200204.276770-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625200204.276770-6-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 25, 2024 at 04:02:06PM -0400, cel@kernel.org wrote:
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

The first signoff always needs the be the author, i.e. you.
I don't think you really need to credit me for this at all anyway.

The change itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

