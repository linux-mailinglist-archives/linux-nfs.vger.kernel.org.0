Return-Path: <linux-nfs+bounces-4131-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D920290FD5D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 09:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63181B2464C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 07:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DBA42ABA;
	Thu, 20 Jun 2024 07:14:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8268142058
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718867640; cv=none; b=GP/60OuYzHkPtJA8VO3J6HU3wO9w8msApYLdpA/UNq3QIaVdtUVFNb9L4A12HRBNd/A9HyhSiPVfmm+wv9h/96bWrDvL4/nC2XLkqzUXctCl1HM+sC/cK105xmmH7Ju0m87cI6yp1MrCVr63lfSpeGLeLYME1AdNwv3vHzYfmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718867640; c=relaxed/simple;
	bh=dkxXONUJxK+YgN/BoQzA6nKRDvO716SRbRZhjtaUK00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvxVbITCmmVSu5DI3QMwl57l+Ns3/RjvpB9OFRIkMSjvO2/g4jEg831H2naeUPVOZQ2yCgq9joBFl7IEhr0KOThwEMqTK2rHU/KykFdP+PSdM35mHrsbEk6Tpld3k2MT4UXZZH41yfJir1y6Y6yBsBJQAsTGSKaud7H88yrxeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D07A68B05; Thu, 20 Jun 2024 09:13:54 +0200 (CEST)
Date: Thu, 20 Jun 2024 09:13:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	trondmy@kernel.org, anna@kernel.org, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: remove dead code for the old swap over NFS
 implementation
Message-ID: <20240620071354.GA23317@lst.de>
References: <20240615080827.1239935-1-hch@lst.de> <975db363-b830-499b-89f8-9d843da47427@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975db363-b830-499b-89f8-9d843da47427@moroto.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 17, 2024 at 05:06:52PM +0300, Dan Carpenter wrote:
> Hi Christoph,
> 
> kernel test robot noticed the following build warnings:

Seems like this is a pre-existing condition.  But it is indeed a bit
silly.  In fact the whole nfs_page_to_folio thing is a bit weird,
pages always are folios as well, so storing a union of a page and
folio in nfs_page doesn't make a whole lot of sense.  I'll look
into cleaning this up in a follow on patch.


