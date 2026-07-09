Return-Path: <linux-nfs+bounces-23186-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0i5oDgddT2rufAIAu9opvQ
	(envelope-from <linux-nfs+bounces-23186-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 10:34:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1039672E56C
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 10:34:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=aqOnfrwo;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23186-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23186-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AD1F3079BAF
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513D3F39F5;
	Thu,  9 Jul 2026 08:32:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726E3F0AA2;
	Thu,  9 Jul 2026 08:32:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585929; cv=none; b=HQU+JByDWN0ZUxM2hpFxjTTy6xy3UFRi3ocgG7VLL85N9qhmgKVz5IFKPCFAHx+o45DPAok/DSr8lbOPOMV1foCxZUykeSNYptFu+G90Vyie94bWmg9gVFEC2NtTJ8P0yvlAT7GccBKJs2FM1mFfRwnZfPT8pDEX2l8ULNaDRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585929; c=relaxed/simple;
	bh=tesK+oxJqsB49auQK1mjbbrkVhdKYiJrkTlVS/W/lOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUlGTkLU892zJ5Qa+yiQZDRttOPY2a1+3aqzbioimmj1xxIEFb/OWBK1+IDhbHj1iv1BELPevDC1MWUFpWXJ+8gpj2Ek1sItm1tr+KupLysW8IRdG3H83tf6KL2c5+IcUu9j4H5LVww1VDUjVwmTGic/XnmdAlScmrIe1nTEmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqOnfrwo; arc=none smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783585928; x=1815121928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tesK+oxJqsB49auQK1mjbbrkVhdKYiJrkTlVS/W/lOU=;
  b=aqOnfrwohYy6CTM21w0/xYpfju7bldEWmMf6w21+t4qqXOqOE4CQYOxT
   mtCUZvh/AFq8A94AwTISTwKfI9iHSYgsMIDrG/9m77Zue8ztpIJg6dcKn
   pNSeRVAnb7VHQwXVtBLt397GRbJIoky8Q5r66zJzUmii0MJGPlskUeat+
   GzJIgEZ2XiYZekzgvV14D3wbuSxw7efEmLOlPkMerDYf7xsXVcd8fMrZ6
   +Q9Uos46xhv/KA3yxY0agP5RssREnPhcVpviJQkFrG+huLVKtzhzQ+9e2
   7PVrzzCfuXm2EeRyKHcevH0SUkD8fJtyxEUo4NrJwhIiSp6cVAGNS7K+P
   g==;
X-CSE-ConnectionGUID: S70fGcBKRVCq58yHvozo/g==
X-CSE-MsgGUID: M+a8V2EeSFmcx3HSXaTIfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83373170"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83373170"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 01:32:07 -0700
X-CSE-ConnectionGUID: EEXzGbqiQH+fSuwG0kIRwg==
X-CSE-MsgGUID: Ubkrz2plSRGEjKFky/y1TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250537941"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 01:31:57 -0700
Date: Thu, 9 Jul 2026 11:31:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	mkalderon@marvell.com, zyjzyj2000@gmail.com, sagi@grimberg.me,
	mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
	bvanassche@acm.org, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
	linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
	cel@kernel.org, jlayton@kernel.org, neil@brown.name,
	okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
	anna@kernel.org, achender@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, michaelgur@nvidia.com,
	edwards@nvidia.com, phaddad@nvidia.com, eadavis@qq.com,
	yishaih@nvidia.com, kalesh-anakkur.purayil@broadcom.com,
	clm@meta.com, ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v10 rdma-next] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <ak9ce4PaJ5n89zW9@ashevche-desk.local>
References: <20260709055211.2498307-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709055211.2498307-1-ernis@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23186-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ernis@linux.microsoft.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:mkalderon@marvell.com,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:michaelgur@nvidia.com,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:eadavis@qq.com,m:yishaih@nvidia.com,m:kalesh-anakkur.purayil@broadcom.com,m:clm@meta.com,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.ker
 nel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.com,m:jgg@nvidia.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,marvell.com,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.dk,lst.de,samba.org,talpey.com,brown.name,redhat.com,oracle.com,davemloft.net,google.com,qq.com,broadcom.com,meta.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_GT_50(0.00)[50];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ashevche-desk.local:mid,intel.com:email,intel.com:dkim,linux.intel.com:from_mime,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1039672E56C

On Wed, Jul 08, 2026 at 10:51:29PM -0700, Erni Sri Satya Vennela wrote:
> The capability counter fields in struct ib_device_attr are declared
> as signed int, but these values are inherently non-negative. Drivers
> maintain their cached caps as u32 and assign them directly into these
> int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> negative value visible to the IB core.
> 
> Change the signed int capability fields to u32 to match the
> underlying nature of the data. Also update consumers across the IB
> core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> are not forced back through signed int or u8 via min()/min_t() or
> narrowing local variables.
> 
> The nvmet-rdma consumer of max_srq clamps it against
> ib_device.num_comp_vectors, which stays a signed int, so that site
> uses min_t() instead of min() to handle the signed/unsigned mismatch.

Assuming the functionality is left untouched, from code perspective LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  int ipoib_cm_dev_init(struct net_device *dev)
>  {
>  	struct ipoib_dev_priv *priv = ipoib_priv(dev);
> -	int max_srq_sge, i;
> +	u32 max_srq_sge;
> +	int i;
>  	u8 addr;

This can keep the reversed xmas tree ordering.

...

>  static int srq_size_set(const char *val, const struct kernel_param *kp)
>  {
> -	int n = 0, ret;
> +	unsigned int n;
> +	int ret;
>  
> -	ret = kstrtoint(val, 10, &n);
> +	ret = kstrtouint(val, 10, &n);
>  	if (ret != 0 || n < 256)
>  		return -EINVAL;

Side note (perhaps another patch?)

	ret = kstrtouint(val, 10, &n);
	if (ret)
		return ret;
	if (n < 256)
		return -ERANGE,

> -	return param_set_int(val, kp);
> +	return param_set_uint(val, kp);
>  }

...

Have you considered also replacing min_not_zero() or do some refactoring
around there?

-- 
With Best Regards,
Andy Shevchenko



