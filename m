Return-Path: <linux-nfs+bounces-22332-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nfzeNtfDI2qrxwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22332-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 08:53:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D6B64CC22
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 08:53:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=KEzT5ARs;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22332-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22332-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4281304EBA4
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jun 2026 06:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C2130FC33;
	Sat,  6 Jun 2026 06:50:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC607279792;
	Sat,  6 Jun 2026 06:50:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780728636; cv=none; b=pt2goQqdwv0fjPwuq+FSLnhegUbeefZXbX2lxc2EYXyDjtcEOoLWDlsrsjbjF2K5zkgnBnTjnOmwGQRDtEzXV5HBGGcg7+/J1odONGY6F0rTRHIPr3BVMUlfWLmLjo1aVv9gbvpEGdSGpOv3+KNzkO5I4mSrNhx0ePZqiiA0xy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780728636; c=relaxed/simple;
	bh=ASMxGY4gAKSv+Sd0n3ZxR7MzaocXG9g17duQbi24vfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huMcXgsP+8wGscazLKPP6kwBabOsFKMX52R+0hxPRMkHwyOoT0qsZSvh598lZ1tHvVht6yYI10G3r1ZDnJCByMQJjJsnFiKD+dpADK167hQ2izlFtgMpv926rHup3htPjkDThO3UQNjY74UMiaIZfDdaws7HsWm6PZcOpvjI74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KEzT5ARs; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 2E00E20B7168; Fri,  5 Jun 2026 23:50:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E00E20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780728620;
	bh=tH653NbSmWShhrqHO75KERtMHsrIkCDX+cA3uzofLOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEzT5ARsTUjn6reKkrwdJaP7fkQibLP6EKL9DaShkDrim6pD7moeJVUPAXAFqlZiQ
	 OnfLBe62DFRgqYAS5Yd48xXb3yUZCG/vEiTDp6IzwMs+lyR4jmyZXx4wy/jztlHm0R
	 gddWF2Cgp+XOPCA6cSrjf9I2QsnfupBBairNheVA=
Date: Fri, 5 Jun 2026 23:50:20 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>, mkalderon@marvell.com,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	zyjzyj2000@gmail.com, sagi@grimberg.me, mgurtovoy@nvidia.com,
	haris.iqbal@ionos.com, jinpu.wang@ionos.com, kbusch@kernel.org,
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
Message-ID: <aiPDLFM0xYlDYQFc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
 <5d3cac2b-4011-49c5-a142-55c85d38e90f@acm.org>
 <ah6gtquGDMvEXjcb@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6gtquGDMvEXjcb@ashevche-desk.local>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:bvanassche@acm.org,m:mkalderon@marvell.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.com,m:jgg@nvidia.com,s:
 lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22332-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[acm.org,marvell.com,ziepe.ca,kernel.org,gmail.com,grimberg.me,nvidia.com,ionos.com,kernel.dk,lst.de,samba.org,talpey.com,oracle.com,brown.name,redhat.com,davemloft.net,google.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,vger.kernel.org:from_smtp,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27D6B64CC22

On Tue, Jun 02, 2026 at 12:21:58PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 01, 2026 at 08:51:40AM -0700, Bart Van Assche wrote:
> > On 6/1/26 2:25 AM, Erni Sri Satya Vennela wrote:
> 
> ...
> 
> > > -	sdev->srq_size = min(srpt_srq_size, sdev->device->attrs.max_srq_wr);
> > > +	sdev->srq_size = min_t(u32, srpt_srq_size, sdev->device->attrs.max_srq_wr);
> > 
> > min_t() shouldn't be used if there is an alternative available. For the
> > SRP drivers, please make sure that both arguments of min() are unsigned
> > instead of using min_t().
> 
> Ah, I just answered in similar way against v5. I also mentioned clamp() there.

Yes. I'll be incorporating those changes in the next version.

- Vennela
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

