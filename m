Return-Path: <linux-nfs+bounces-22938-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OdUSEkIARmrOHgsAu9opvQ
	(envelope-from <linux-nfs+bounces-22938-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 08:08:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4316F3AEF
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 08:08:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=YWiewdux;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22938-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22938-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C6693014657
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 06:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1EA36B054;
	Thu,  2 Jul 2026 06:03:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DDC22332E;
	Thu,  2 Jul 2026 06:03:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972226; cv=none; b=ZutVD2I3ae+UafbhdW1EfQ/AVzjsQBIVxg76hLsepp8SR+iYKPczlgVqe7g1Uo8pTssjisYD5PzAmdHY3HA86lD5eEkkY4Ie5XTrFinqgSA2jQhNdBJDbojTFSK891SYxSBCiYjUfNsGi6UMa/RKvf6oB4ajiQJfFwxpd2lRAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972226; c=relaxed/simple;
	bh=P+Dfz57Duebop7W0Y9UL+IO/oLzMA4pZeLlFNiZ1qcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGhLQf7d4jYDd9Ok/N33wwQCcwPg+M+hbWObElistJumR+6eIhy6GDSN8m64tTNCiubeIr+hGjjiizhTD/YgIcp3xV50SWjiL/lc0jIC0Lhz8liZGpnRor6aUwnLSAa4l0NvBPu4YNAUqCZkVdVp0nNSlgMNVTd5bqYcHQYXeOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YWiewdux; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3C67320B7169; Wed,  1 Jul 2026 23:03:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C67320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782972223;
	bh=PYV85AvFz4rVWO3U/hhUvMvhuqB8LpaELOR2jS/qchU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWiewduxaLuWS7rWYB1zlKBpG5aA+R24KUAH3I597I72uX/KPA1VykdQbrEWWP7Np
	 ZMXqOfd63PnLfEHvY9exzPQkrEBt5b65twR2m+gfSW+EACtewSCu18K92iq1eEb6eo
	 23jCh8m24d9IZdFNVnC3LvCe85f6mAfC0hsWpNZs=
Date: Wed, 1 Jul 2026 23:03:43 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	mkalderon@marvell.com, zyjzyj2000@gmail.com, sagi@grimberg.me,
	mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
	bvanassche@acm.org, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
	linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
	trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, achender@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, markzhang@nvidia.com,
	andriy.shevchenko@linux.intel.com, ebadger@purestorage.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v8] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <akX/P/0TiSQ38YdS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260619203107.606359-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619203107.606359-1-ernis@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,marvell.com,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,linux.intel.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:mkalderon@marvell.com,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:markzhang@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.
 com,m:jgg@nvidia.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22938-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,linux.microsoft.com:dkim,linux.microsoft.com:from_mime,sashiko.dev:url,samba.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A4316F3AEF

On Fri, Jun 19, 2026 at 01:30:39PM -0700, Erni Sri Satya Vennela wrote:
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
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Acked-by: Stefan Metzmacher <metze@samba.org> # smbdirect


Hi,

Just a friendly follow-up on this patch. The Sashiko review mentioned a
low-priority item, and I'd appreciate any guidance on whether the change
is needed.

https://sashiko.dev/#/patchset/20260619203107.606359-1-ernis%40linux.microsoft.com

Thanks,
Vennela

