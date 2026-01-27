Return-Path: <linux-nfs+bounces-18531-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAtTDFNQeGmipQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18531-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jan 2026 06:42:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7039024A
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jan 2026 06:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 498C13012C4F
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jan 2026 05:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE07328626;
	Tue, 27 Jan 2026 05:42:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7C2DC77B;
	Tue, 27 Jan 2026 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769492560; cv=none; b=RnCt6HlzXq31X4dgWOmU8QioNejmCd2DPpzHMOMAP61RZDnWHMCqxbF3ItgI4tt0DduaJ2nMiWynJt71g2sLe2PTheDgbdzWXaLYlhDuOYPLzPvXwGht+gIputfZPaEqsd+uNgT68MRzLUzA/yHalU6DP3+FxpX8g8xk7bedHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769492560; c=relaxed/simple;
	bh=HTxesvmW3c3OqXkag0HEXuCFk6DGEWTrTMgYKzuvZp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DawsNPkzv7gQ8v3ktnMPmkqZOEERmMQeWNcMHjWMMCpIexkycTPJ+820nbmEoZ3vlWD76nnRlGKTIivNLnoimyfFYetcPCQsbqjx1PeLtNkSfBZOswqHRPOOroH14HFAGM4e1PK6/JxU4AKL00Y3hsoLRl8rdKKXq4wCY2xYit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B62B227AAE; Tue, 27 Jan 2026 06:42:36 +0100 (CET)
Date: Tue, 27 Jan 2026 06:42:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 3/5] RDMA/core: add MR support for bvec-based RDMA
 operations
Message-ID: <20260127054235.GB24998@lst.de>
References: <20260126181414.105062-1-cel@kernel.org> <20260126181414.105062-4-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126181414.105062-4-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-18531-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: AA7039024A
X-Rspamd-Action: no action

> +		struct {
> +			struct rdma_rw_reg_ctx {
> +				struct ib_sge		sge;
> +				struct ib_rdma_wr	wr;
> +				struct ib_reg_wr	reg_wr;
> +				struct ib_send_wr	inv_wr;
> +				struct ib_mr		*mr;
> +			}			*ctx;
> +			struct sg_table		sgt;
> +		} reg;

I still don't understand why the sgt is not in
struct rdma_rw_reg_ctx.  Right now that is allocate a little bit
later than the sgt initialization and freed a tiny bit to early,
but that seems to be easy to fix.

Doing so would reduce the memory usage for the common non-registration
path, and significantly reduce the churn in the patch.


