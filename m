Return-Path: <linux-nfs+bounces-21020-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA4+AMqr6WkxgwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21020-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 07:19:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B25D44D398
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 07:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C2563026890
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 05:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD893314AE;
	Thu, 23 Apr 2026 05:19:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7AD2AF00;
	Thu, 23 Apr 2026 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776921542; cv=none; b=Ov75x+wVonpTlxJlNoKwC1Xfpomwtu6iBWC0FnNs4+YqeAp2d9KDEa3THfkAm3jKSOepVKXs03kcvyK0D2bxNqm3BuLshy3DZtZwWTvHE6PYSo12I8JRV//Tzhee4aFsY4Lx3OWZkQN2VS6UDaUB/frTKL0mv5ER1ytNRemVfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776921542; c=relaxed/simple;
	bh=pvxp33B8cWcXWn5ImyQ23eqkmxf7tdx74HxzPnzzlVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKG7Pa+bd/ryrEbRFpjNd1hmuMlD9B8/M5oTF/BKvz/9czLcN37zgimebG+e0ti6vwlcUx16Z/ogeb0tBIy3+D0mVkrKCg/IlYQNlRR7iNBoKqcI1VK4fMcUjpGW13c2sOm9v19XmmWt0qWllsVL0Ze0oi/rMU9LLiX6TGfzdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7302168B05; Thu, 23 Apr 2026 07:18:58 +0200 (CEST)
Date: Thu, 23 Apr 2026 07:18:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Werner Kasselman <werner@verivus.ai>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] pnfs/blocklayout: cap total parse operations in
 volume topology
Message-ID: <20260423051858.GD27929@lst.de>
References: <20260421100338.1227152-1-werner@verivus.com> <20260421100338.1227152-3-werner@verivus.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421100338.1227152-3-werner@verivus.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21020-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B25D44D398
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 10:03:44AM +0000, Werner Kasselman wrote:
> The recursive-descent volume parser materializes a separate device
> tree node for every volume reference.  When CONCAT or STRIPE volumes
> reference the same child index, the parser re-parses that subtree for
> each reference, causing work exponential in nesting depth.
> 
> Cap the total number of bl_parse_deviceid() calls at
> PNFS_BLOCK_MAX_PARSE_OPS (1024) to bound CPU and memory consumption
> from server-controlled GETDEVICEINFO topologies.

The OPS naming is a bit odd, these are called 'volumes' in the specs.
Which isn't a great name, but it generally helps to stick to the
spec terms.  So maybe rename the constant, and also add a comment
explaining the limit to the code?

> +		int depth, int *remaining, gfp_t gfp_mask);

Also use unsigned here as well.  And maybe we should group the depth
and ops into a struct instead of adding more and more parameters?

Otherwise this looks good.


