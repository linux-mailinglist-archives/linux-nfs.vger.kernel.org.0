Return-Path: <linux-nfs+bounces-22197-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF6oGyWhHmquDAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22197-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 11:23:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2538262B63B
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 11:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E57130240A1
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11F63CCA02;
	Tue,  2 Jun 2026 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbFO37gP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF013CDBC0;
	Tue,  2 Jun 2026 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392133; cv=none; b=JuG/vWgp1/y4pmAqm+iXNHaZn+neKZT9b4jhIoo8djEvLrSqNT+XMwPRqj3KwciE3XP1LARXs8sRKvE7Aw/02JTm/j4XSVwqaNaHmtP5B0xQGmn4lBMnb5EEI7vglmW1/jyW0b8mBuvUXXuMs8x/cl3jt2moXtY32Hr9Vikmsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392133; c=relaxed/simple;
	bh=qx9Oyz913PcMyr3DRCcFWEjLHUEyxDQo5cOmQloCccg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4GxKcz0uzbOUmzxB8ojqWonB6E5OTA2PoF4+U3qKfbiP7ZsmcPqAF2YxKS3Tl0l7bdXw9Yn1jlRN0EsgJVrFgKKoYV7qs5O4Za6GuuW3nIZg2T4XcFFCjUS8aLivFEvSd0Qxb9I4LuSIWZHUwqOKZScCtgYwKD9w/iIUxowetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbFO37gP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780392132; x=1811928132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qx9Oyz913PcMyr3DRCcFWEjLHUEyxDQo5cOmQloCccg=;
  b=LbFO37gPZtpEIBpRoMN5RwwLulYWOSEGXShacFCKfeYh8ohbWJyVRpc4
   Ko7vfb+5NSUmPQmRBISimrX0RYwZzh1mM14WJRAp5r0zYkb695T8+X3vJ
   D9TzSGQRZon4CYheKURZhJ7t1W7hWctPZcSIixldtC2T3E5US1q5xmCKs
   YLoEYnl2tgBReC6kaWeG5dih+2a0iDOMHSe6vKJF4B0th19jcG8ofg/2r
   i09lY0VhR9TabnknHOG3c/oQKTbb9SLH3YS3orNfy/NRQsdqNqmmpZH+4
   G/bWSd0pFa3KFx0bAIYdOb6+qamToLv8pJ4EP/F+FfT/i14f+tCpFuC+Y
   Q==;
X-CSE-ConnectionGUID: fnJgRrf9SomqyMin/LHf8Q==
X-CSE-MsgGUID: ipooZghzQIeT8N7ZT9JXQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="103833897"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="103833897"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:22:11 -0700
X-CSE-ConnectionGUID: 6MlgT1ArRse4ecPJiJxjWQ==
X-CSE-MsgGUID: dpH2w+yIR4iKpkksHiG1RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="281963145"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:22:01 -0700
Date: Tue, 2 Jun 2026 12:21:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
	sagi@grimberg.me, mgurtovoy@nvidia.com, haris.iqbal@ionos.com,
	jinpu.wang@ionos.com, kbusch@kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	kch@nvidia.com, smfrench@gmail.com, linkinjeon@kernel.org,
	metze@samba.org, tom@talpey.com, chuck.lever@oracle.com,
	jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, trondmy@kernel.org, anna@kernel.org,
	achender@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kees@kernel.org, ebadger@purestorage.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <ah6gtquGDMvEXjcb@ashevche-desk.local>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
 <5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 2538262B63B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22197-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[linux.microsoft.com,marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim]
X-Rspamd-Action: no action

On Mon, Jun 01, 2026 at 08:51:40AM -0700, Bart Van Assche wrote:
> On 6/1/26 2:25 AM, Erni Sri Satya Vennela wrote:

...

> > -	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
> > +	sdev->srq_size = min_t(u32, srpt_srq_size, sdev->device->attrs.max_srq_wr);
> 
> min_t() shouldn't be used if there is an alternative available. For the
> SRP drivers, please make sure that both arguments of min() are unsigned
> instead of using min_t().

Ah, I just answered in similar way against v5. I also mentioned clamp() there.

-- 
With Best Regards,
Andy Shevchenko



