Return-Path: <linux-nfs+bounces-7573-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC279B6546
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 15:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854FC2810BE
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0D21EE037;
	Wed, 30 Oct 2024 14:08:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5941EBFEA
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297309; cv=none; b=GJt7YmZs62T5RrLsFqopJkBbkT1wXxjC+dVdJ1SmDyZ3sEWQT3zO09Pk0gAbtJ6vdFLMn6jtMP/rz06B3mWt4oSCCrzhsUJZ/IN4aqQJycsjIyG53wRBzRKR6226hZjbZRmPg//+ry9k1zFVjdc2vcgP0L7zX1ZFEoVWytEBuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297309; c=relaxed/simple;
	bh=drylkkSfzKD04luDecWNeki8s31o8DcSvvifmA3HMAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLtUqmOpj+SF32GunTK9kzrBcd/o+qFkSYhT+/I36bD9/QhsrKujai+LXpbzS/J6m/WSnCCkKU8zHC7fj9smjvBfdeGp5utJtIfTC0gNa0Y7ezd6IEuOhgIYN7cZIg/xOTwPvcATYHxwJVLDz9YaBaicLRgxA4K9Z2AC+ZkK1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D4264227AAE; Wed, 30 Oct 2024 15:08:23 +0100 (CET)
Date: Wed, 30 Oct 2024 15:08:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] dm: add support for get_unique_id
Message-ID: <20241030140823.GA29475@lst.de>
References: <f3657efae72f9abb93d3169308052e77bf0dbad6.1730292757.git.bcodding@redhat.com> <20241030135214.GA28166@lst.de> <ABD563AE-C7F3-43C2-A698-479C7D5924BF@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ABD563AE-C7F3-43C2-A698-479C7D5924BF@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 30, 2024 at 10:05:03AM -0400, Benjamin Coddington wrote:
> Match each other in a multipath device you mean?  No, this will just return
> the first one where get_unique_id returns non-zero.  Can they actually be
> different, and if so should we return an error?

That's what I've been wondering.  IIRC you can in theory create a
kernel mpath table for any devices you want.  multipathd only creates
them when the ids match, but do we want to rely on that?  It might be
perfectly fine to say if you break you keep the pieces, but then
I'd expected a comment about it in the comment.


