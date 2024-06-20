Return-Path: <linux-nfs+bounces-4117-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561790FBFA
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 06:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4931C22B5B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 04:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B431EB2C;
	Thu, 20 Jun 2024 04:36:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CCC1CD2B
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718858172; cv=none; b=W71FKpT20cNG8MzjRnGAsGOCp/kGRuIFEIlE8xYwC/MQDsbqJF6njTjeEhuuI53jPhEn2ZkBychrtqmm0W4OS4Zk9LkjmN/urLQpKoDedfuqkHbiAMPDzUOCOaNNkhDGa30hCXVVkl2WZweg+iqP7Zzcj0OxlDJBrOv1T1wlMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718858172; c=relaxed/simple;
	bh=SmXob1U4VyMfLPAyDym/T1JOPDSm+dn8NWAvwrbcMos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRa7b3imWH2cPJom2JMGO3HPjgFteK2ISNPF4mtuieeeaX2iuSQBXDZslLR6AVaLEMq5l/p6I4sYww1MhIeTOSLJRSgCgEmCkPh/DouUL9plWdABaGsUQxQ/x/1eAyyY0I8Kdh6vZMRn0XfAzYwFOQBCst0Glqqb6DNXtqomwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C7A9B68BEB; Thu, 20 Jun 2024 06:36:05 +0200 (CEST)
Date: Thu, 20 Jun 2024 06:36:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 2/4] nfs/blocklayout: Report only when /no/ device
 is found
Message-ID: <20240620043605.GA19613@lst.de>
References: <20240619173929.177818-6-cel@kernel.org> <20240619173929.177818-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619173929.177818-8-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 19, 2024 at 01:39:32PM -0400, cel@kernel.org wrote:
>  	if (IS_ERR(bdev_file)) {
> -		pr_warn("pNFS: failed to open device %s (%ld)\n",
> +		dprintk("failed to open device %s (%ld)\n",
>  			devname, PTR_ERR(bdev_file));

I'd just drop this one entirely.  Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


