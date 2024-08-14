Return-Path: <linux-nfs+bounces-5359-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67BF951B55
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 15:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705621F23BC3
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 13:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F091AE05E;
	Wed, 14 Aug 2024 13:04:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F701E49F;
	Wed, 14 Aug 2024 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640669; cv=none; b=RYZebXP0nwoFFY3fM2QQJg2eCtFQtvnVXt2+fCbc+mh7ZPz/fLwfxF7E7A1ghODUm6sPKo3KVAVqne7FnCZX+BIEq5+CTsLBkVR3bq5FuiiA9d5+eYQn7q+OxwwxdgnaPcjQ7t8FracBeuLIbgVFxAvp+XK1LAVUO73+FuAbMBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640669; c=relaxed/simple;
	bh=zRtvFb72abn21/txqJ1vA3pPA3SGJXGw6lBXXGMyMPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVtrxdgBmfYjh+WB4DHj29KplqkikykZPl9SZKzxfGSAG4qPmet+OOlrPWlXwrQ7laXN0y2CqxOB/C8wVP/jltuB6PM/57h3y2IDmZwTBLacaWV4mFBLw2DS8VJNOHzcCbkdAX1ajKIRUsojxLOfge3wrCOkjBKbknyeb2dOw+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB885227A88; Wed, 14 Aug 2024 15:04:15 +0200 (CEST)
Date: Wed, 14 Aug 2024 15:04:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nfs@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [nfs]  49b29a573d:  filebench.sum_operations/s
 -85.6% regression
Message-ID: <20240814130415.GA24468@lst.de>
References: <202408081514.106c770e-oliver.sang@intel.com> <20240812112145.GA15197@lst.de> <ZrsBlLtc5g4WbuP2@xsang-OptiPlex-9020> <20240813064955.GA14163@lst.de> <ZrsEaIEbjpT80P9/@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrsEaIEbjpT80P9/@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.17 (2007-11-01)

> sorry I don't have many details. not sure if https://github.com/filebench/filebench/wiki
> is helpful for you?

Not too much.  Especially as I'm not sure what you are actually
running.  If I run the workloads/randomrw.f from the filebench git
repository, it fails to run due to a lack of a run statement, and it
also hardcodes /tmp.  Can you share the actual randomrw.f used for the
test?

Also do you run this test on other local file systems exported by
NFS, e.g. XFS and do you have numbers for that?


