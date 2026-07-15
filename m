Return-Path: <linux-nfs+bounces-23321-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qymqJa4PV2oaEwEAu9opvQ
	(envelope-from <linux-nfs+bounces-23321-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 06:42:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BF475A7FA
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 06:42:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23321-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23321-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E7413041A2A
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 04:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72394757EA;
	Wed, 15 Jul 2026 04:41:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470F325B0AC
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2026 04:41:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784090499; cv=none; b=EzbnqjJwofPCG8ek24zUI0Mve+cWwIk1I/twVcqmECSzYlPSrg5rN1TyRf+DLcH6JOoijJ8b+PWPsuBU/8rZlLiVmz9f7My4+EB4+jwjDVkXcqF+4h+fpH7kgt3EcDbbvy6q04EzvHtRZcdz7a5oXwFZermISCAVdYi4vtz60QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784090499; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd+SXouNxEWAN0v4LBLKO0y04m1zG8qDzJ7zi9iEpl7NbC+5SNoXxYDpSp4UkAkrjwL48FHa/PS4sDhPmuaf+iFGznTwR2CdoCLzcEEGi9LELvL+tHyQDy6t/U+FHx8TA8ca2mWm+V/6S+HwrU5DzoQt2a+Z0GSp/kB/aw+q26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id E1A5C68C7B; Wed, 15 Jul 2026 06:41:33 +0200 (CEST)
Date: Wed, 15 Jul 2026 06:41:33 +0200
From: "hch@lst.de" <hch@lst.de>
To: Nate Prodromou <nate@prodromou.com>
Cc: "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
	"anna@kernel.org" <anna@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFS: fix delegation_hash_table leak when
 nfs4_server_common_setup() fails
Message-ID: <20260715044133.GA16065@lst.de>
References: <SA1P220MB14925066FEE37CAC1C083DEBC8F92@SA1P220MB1492.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1P220MB14925066FEE37CAC1C083DEBC8F92@SA1P220MB1492.NAMP220.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nate@prodromou.com,m:trond.myklebust@hammerspace.com,m:anna@kernel.org,m:hch@lst.de,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-23321-lists,linux-nfs=lfdr.de];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:from_mime,lst.de:email,lst.de:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19BF475A7FA

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


