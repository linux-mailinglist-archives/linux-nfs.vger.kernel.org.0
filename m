Return-Path: <linux-nfs+bounces-5311-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AB694EBB1
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB8A1F22361
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFF4171099;
	Mon, 12 Aug 2024 11:21:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01819172BD5;
	Mon, 12 Aug 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461711; cv=none; b=QucA4zIBet+HJ8SHHEaKW2vANKwQdOBV05ZF061cR/GRt2XaHH/OPJEKnDXyrPr0d/HwewkVQZMK9gmT7cXwImxr2Lx5LVASDi8jVH/aVBhpTEt6f1M8zIluaz1W5rKlCP0lbv89LjYkICqGL97rqBeElEXaR4EvHiI3mj5s8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461711; c=relaxed/simple;
	bh=JEAcUDiiRJfm7r4BogGFwgYSGu9zFNqbBUn/yER2DZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqJnrTJd4CuuX3yDbHBUCpHXIoK6nax1V3fQ9f5FN3pqzCCCepZ8pHQYWTJJuffFqTzvmQQJvW2k458ShYTECY4rLO8mlfI0hBWf0Gy38cHSLL91KdbMD+CupbhFFNzfYAzgByK92qUMfIMTrCMeAkfAMB2wstf2rQA/XqdKYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 23445227A87; Mon, 12 Aug 2024 13:21:46 +0200 (CEST)
Date: Mon, 12 Aug 2024 13:21:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nfs@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [nfs]  49b29a573d:  filebench.sum_operations/s
 -85.6% regression
Message-ID: <20240812112145.GA15197@lst.de>
References: <202408081514.106c770e-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408081514.106c770e-oliver.sang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 08, 2024 at 03:35:20PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -85.6% regression of filebench.sum_operations/s on:

I'm not sure what operations this measures.  But if it is what I think it
might be, does this regression go away with the following commit (which
already is in mainline)?

commit 39c910a430370fd25d5b5e4b2f4b24581a705499
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri Jul 5 07:42:51 2024 +0200

    nfs: do not extend writes to the entire folio


