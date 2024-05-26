Return-Path: <linux-nfs+bounces-3382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA38CF2E5
	for <lists+linux-nfs@lfdr.de>; Sun, 26 May 2024 10:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC974B21278
	for <lists+linux-nfs@lfdr.de>; Sun, 26 May 2024 08:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7610A8BFA;
	Sun, 26 May 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gOw5oCIQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259F20E3;
	Sun, 26 May 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716713754; cv=none; b=db2Q3gi0bUBjloSIGdAN7SJ+qyMFm4lObMh98Fae4l2g3bvkWHxlI3ADwy6qPV+xWWby7jWo17sEwP0kobRZPzJJqoYElDhCZQVgx7WvJxYxIEKEvR11GxIC47U+f8sPs0G1EHXFHF6XdeOVv/H9RUY9EEdE9O/FCN1bBJS5WrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716713754; c=relaxed/simple;
	bh=q95RI9MDo5gV6M5nrfXdCIpqiERZlKWhWNRkaZjO9yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUKgsyq3PzoKO6Uu8RL8kFQ85Sk8wSPucNrEef2cifQ+NKJ0PY6u+EFw7RgWkb+lmfDVxnxlxV+CxVgfRJ87Qzi2K4k7+nqph3IUu9WPIGimaMd/XGO9rkSFTFvJUjwOvW/4fuZnLCM3PgV+XERBB+aNA6XUJkBT0GrRP2kmJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gOw5oCIQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o5fN1py3K53ZyRsgQ1po2cph7J0Yga3zhzECAnBodXM=; b=gOw5oCIQOCVVj+76645UUx3Eyj
	gCL1ADzibvXvNk4duxrNskDQyUwNjVlqSkdGN/Qd2pOw/UsrvToWe3XDKa7KjVDuUT220RF4UA22x
	4lJt6M9sYjN18mwCPyXXMl9eijRw8U+8gxFgSZ6HCNFNacJwexw1P6K4SLPZtxanWM9/rNJwfML48
	DZ5oIR4rWC+ow85IUj1yGQLNVfdBPntHt2SQsikPraLCPyC+nDd3CcjOyErgfZL1zVg6cxsVhD9EK
	pLJh0ekdnzl2tDgt1gLsBIefxcIsKgps16qF76XyJNMFym/cWVfaP/V6GFoUe6+qF5TWMXB53hKgd
	dqywKt5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sB9fQ-0000000CNwx-3BE4;
	Sun, 26 May 2024 08:55:48 +0000
Date: Sun, 26 May 2024 01:55:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <ZlL5FEW2haiuXWNS@infradead.org>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 20, 2024 at 05:35:49PM -0400, Aleksa Sarai wrote:
> Now that we have stabilised the unique 64-bit mount ID interface in
> statx, we can now provide a race-free way for name_to_handle_at(2) to
> provide a file handle and corresponding mount without needing to worry
> about racing with /proc/mountinfo parsing.

What are the guarantees for the mount ID?  Is it stable across reboots?
If not mixing it with file handles is a very bad idea.


