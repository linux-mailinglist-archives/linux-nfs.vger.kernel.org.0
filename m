Return-Path: <linux-nfs+bounces-4114-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 761B990FAD5
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 03:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232451F22B57
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 01:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E53EAC6;
	Thu, 20 Jun 2024 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lbLv6lOK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE634D51A;
	Thu, 20 Jun 2024 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718846418; cv=none; b=uj+x1sQJCoQJMbQ3xF5qS1VJbpzi/ojR2WzkVSUBV2drzkLg7HW+LU20UPvIYpSCwu0eu/TI/nBHE3JyP4LSm01bVWkQ01j3HaShChZzEE7p3Gm0ihvbgwPW2T9kl4Nc9lhlQTiSrziskH7ByDvXJW5RJDwAeHJlOlrWPvSi89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718846418; c=relaxed/simple;
	bh=bJXYMr4QXimk4q4LQjamqjErXLeD3MERsKZSARFMAYM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ef2YbYYyzu0bcRGuK7uqyCBu9vw0lPeSCtcRLkdFU3KH1aOSqLbMWWFuqeHllk1ev0Z/brxt/yefa0NOi2UbIGNTdZkNV9vW8Xhv1LlH2kQCC2KbxEIVrG6Yn7v+lAz04+naOP47/iZqaMiiLEIheXHdsURBLli3GWQtxg8G+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lbLv6lOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C62C2BBFC;
	Thu, 20 Jun 2024 01:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718846417;
	bh=bJXYMr4QXimk4q4LQjamqjErXLeD3MERsKZSARFMAYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lbLv6lOK8F/j4jt0rCkWllzrJ0BueRMY3j24nX6IQVNjBb8R0XRXeO+BTJmN9GgzT
	 VxeYYYQRCMKtItVqOPzP6nfKfxE04IqzS5te6nEbbOwM8BygqGiAnL+17AEYACNCf7
	 Q8GGFtrzO2QQpVjd8iSACuit5Ep6nzUSzNkF6/qQ=
Date: Wed, 19 Jun 2024 18:20:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
 linux-nfs@vger.kernel.org, anna@kernel.org, chrisl@kernel.org,
 hanchuanhua@oppo.com, jlayton@kernel.org, linux-cifs@vger.kernel.org,
 neilb@suse.de, ryan.roberts@arm.com, sfrench@samba.org,
 stable@vger.kernel.org, trondmy@kernel.org, v-songbaohua@oppo.com,
 ying.huang@intel.com, Matthew Wilcox <willy@infradead.org>, Martin Wege
 <martin.l.wege@gmail.com>
Subject: Re: [PATCH v2] nfs: drop the incorrect assertion in nfs_swap_rw()
Message-Id: <20240619182016.9e255f676792dde69a995974@linux-foundation.org>
In-Reply-To: <CAGsJ_4yp1u7fbXCSmu-mKhOP9SnCZXrC857LJHpHQOB3yC+MQg@mail.gmail.com>
References: <20240618065647.21791-1-21cnbao@gmail.com>
	<20240619052740.GA29159@lst.de>
	<CAGsJ_4yp1u7fbXCSmu-mKhOP9SnCZXrC857LJHpHQOB3yC+MQg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 19 Jun 2024 17:34:27 +1200 Barry Song <21cnbao@gmail.com> wrote:

> On Wed, Jun 19, 2024 at 5:27 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Jun 18, 2024 at 06:56:47PM +1200, Barry Song wrote:
> > > Fixes: 2282679fb20b ("mm: submit multipage write for SWP_FS_OPS swap-space")
> > > Reported-by: Christoph Hellwig <hch@lst.de>
> >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > A reported-by for the credited patch author doesn't make sense.
> 
> Andrew, could you help remove the "reported-by" in the commit log?
> Alternatively, would you prefer that I send a v3 to drop the "reported-by"?

I made that edit.

