Return-Path: <linux-nfs+bounces-23258-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UPfrBQF6U2oHbQMAu9opvQ
	(envelope-from <linux-nfs+bounces-23258-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 13:26:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 588797447EF
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 13:26:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lgFqAe2C;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23258-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23258-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1928F301CFAE
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F95376483;
	Sun, 12 Jul 2026 11:26:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A72D739C;
	Sun, 12 Jul 2026 11:26:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783855613; cv=none; b=LPDfUmgrQ7x05OzdAaRJoldbRugqnpDol3ol37Urp3Btk5aLb0HI9nRHhFXYZTNkTMygaE2SHDsWw0U/4bd7EFce6ujEMOhNLcyD4CBl/2ibSvZ5noyHwk7GZ1dh9LdX7vIe0vwd5mnZjsKZHIf4CuVGBIHHclINpt0teWSY5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783855613; c=relaxed/simple;
	bh=5meUdDzwydXQ3rn5I09AMKpb9ZGJt+ZElLq06IkrLBE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lEqHQHxEkYtNgRuY9vK09IEt/HDXSmPQtWHcSJotJSGJpUAJWGTH5nTCFCELhoP6qf9uX54hm5YDHrt/EsuiJiHFhArk1NRvR/1SLJ4iK5/GMEuQ3q/KEWQAw7NjOLVIWg+SLdge3KMDq5j4wOEpQ17/iB2Aw1lSLWYXWWvjZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgFqAe2C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1620A1F000E9;
	Sun, 12 Jul 2026 11:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783855611;
	bh=Sin8W3ZSdHD4q1m7BeezG3ErJ60L00G8/X/y0SdGqTc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lgFqAe2CIAhPszW7dLMvqr/QHmYXAz3go05mHZWk7bZTEA8XothagfswALI5CEJ+i
	 0/zcwFmx/MAUOlv2WC/s2epj24ecaWmboGbGvQFSdkK58uukgz+cR8GGOYWXCHQ2UQ
	 ZKH8Or6D2OdtehEd1jt2vcB+LrwffQROFEPVGjMCcHoZwOVQl75cb6nVcjzXwAc9CI
	 HaUN6hFMiEY2zLm5f1c1uZA2/oLkMFHGILLE6ifVt49j0qVxUnTpvSBzjAFj83prdl
	 EgQ7u5uBRLisFcNsfJQku5o7hx2GUEttIF240YZwZL+pN2JdzlSIQqfYsT2osBP/xC
	 xwxSzyJO8l3FQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, mkalderon@marvell.com, 
 zyjzyj2000@gmail.com, sagi@grimberg.me, mgurtovoy@nvidia.com, 
 haris.iqbal@ionos.com, jinpu.wang@ionos.com, bvanassche@acm.org, 
 kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com, 
 linkinjeon@kernel.org, metze@samba.org, tom@talpey.com, cel@kernel.org, 
 jlayton@kernel.org, neil@brown.name, okorniev@redhat.com, 
 Dai.Ngo@oracle.com, trondmy@kernel.org, anna@kernel.org, 
 achender@kernel.org, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kees@kernel.org, 
 michaelgur@nvidia.com, edwards@nvidia.com, phaddad@nvidia.com, 
 eadavis@qq.com, yishaih@nvidia.com, kalesh-anakkur.purayil@broadcom.com, 
 andriy.shevchenko@linux.intel.com, clm@meta.com, ebadger@purestorage.com, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 target-devel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, rds-devel@oss.oracle.com, 
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20260709055211.2498307-1-ernis@linux.microsoft.com>
References: <20260709055211.2498307-1-ernis@linux.microsoft.com>
Subject: Re: [PATCH v10 rdma-next] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-Id: <178385560887.1568177.15189396813808538811.b4-ty@kernel.org>
Date: Sun, 12 Jul 2026 07:26:48 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:mkalderon@marvell.com,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:michaelgur@nvidia.com,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:eadavis@qq.com,m:yishaih@nvidia.com,m:kalesh-anakkur.purayil@broadcom.com,m:andriy.shevchenko@linux.intel.com,m:clm@meta.com,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:
 samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.com,m:ernis@linux.microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-23258-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[ziepe.ca,marvell.com,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.org,kernel.dk,lst.de,samba.org,talpey.com,brown.name,redhat.com,oracle.com,davemloft.net,google.com,qq.com,broadcom.com,linux.intel.com,meta.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com,linux.microsoft.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 588797447EF


On Wed, 08 Jul 2026 22:51:29 -0700, Erni Sri Satya Vennela wrote:
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
> [...]

Applied, thanks!

[1/1] RDMA: Change capability fields in ib_device_attr from int to u32
      https://git.kernel.org/rdma/rdma/c/eebd08d91ddbd6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


