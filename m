Return-Path: <linux-nfs+bounces-4788-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 984E992E0AC
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 09:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1AA1F22A27
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 07:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0BC83CC8;
	Thu, 11 Jul 2024 07:18:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2613E881
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682295; cv=none; b=RYl+GWVcBv8lTkCIVqQ51+Jtozb74wQFzz+EZjCRuqiPlrfsL3nfjeESRVOdhSe221t7k6lHNNtS88LEexjIQjF8FVFZ+VH34D3Iel8G3hNfhHZReNII+/XYVmZEG6dNhfnAv/p79kPUJ9J0LFMs5JgCeN3SwodjwVMUU+4FSfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682295; c=relaxed/simple;
	bh=KllAOKsnVVrxOMa7P+2nJMy0YOhKNTe+/Yghg+XCe88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Stz6T9I8alk64dUb6bXeVD77oqXKnJ0aFGPpxEodbmmQbqmZZM8HKMlAbOo4xqIvS4UCEMqOij22PVRoXKWcufxrCta4AYVoSGBYFD+H5RYaxHmAWBayHNulrLa+jwBDd3kH+hBIqbSIfg0JXk5Y7yuvy9RmYf1/naIAvtTn1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9344F68BEB; Thu, 11 Jul 2024 09:18:09 +0200 (CEST)
Date: Thu, 11 Jul 2024 09:18:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: trondmy@kernel.org, anna@kernel.org
Cc: chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfs: pass explicit offset/count to trace events
Message-ID: <20240711071809.GA8753@lst.de>
References: <20240711071703.65793-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711071703.65793-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 11, 2024 at 09:17:02AM +0200, Christoph Hellwig wrote:
> lead to kernel crashes.  E.g. when running xfstests generic/065 with
> all nfs trace points enabled.

Sorry, this should read generic/095.


