Return-Path: <linux-nfs+bounces-18228-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ad0DQuWcGmZYgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18228-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 10:02:03 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C9054015
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 10:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5DAD506540
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2871A47B435;
	Wed, 21 Jan 2026 08:57:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF8147B428;
	Wed, 21 Jan 2026 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985852; cv=none; b=GmIneNPAhsF4cI5l8MaDwcf9pnTk99HbryinGc7GRQUeDBGeELhL+zQKkNk/8b7xqifAwSaFUgJ/8z2aekjXSq5T1uBbXWYZxEjPebovIEg0yP80tWkfNWMvlSrDI59gOoVgDsf3giNRfZuHw5vfu/WmbOz8IO5QKBMPLzvegPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985852; c=relaxed/simple;
	bh=+Zp5QW66yuDTlQt723imYEQ44amxK86yXzHXrI4WGh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpK9yAXhNsCPNAqvryIg2EceShRD7bgqfVwyTDz+O8JfxQ0vzxBWa8wesWrtzB6cTz18sq65sE1wJlzfospXXQ01dKl2T8XMr55w/8FEo6Pj09o5nPdDUOFy/e7fvO8Fy1bH2O9UtcuQ09D5if3N+AeG+vvDNDpNLxJs5bleguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C7C1227AAA; Wed, 21 Jan 2026 09:57:27 +0100 (CET)
Date: Wed, 21 Jan 2026 09:57:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <cel@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260121085727.GD16458@lst.de>
References: <20260120143124.1822121-1-cel@kernel.org> <20260120143124.1822121-2-cel@kernel.org> <20260121084217.GA16458@lst.de> <20260121084840.GX13201@unreal>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121084840.GX13201@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,nvidia.com,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-18228-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 02C9054015
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 10:48:40AM +0200, Leon Romanovsky wrote:
> > > +static int rdma_rw_init_map_wrs_bvec(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
> > > +		const struct bio_vec *bvec, u32 nr_bvec,
> > > +		struct bvec_iter *iter,
> > > +		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
> 
> Don't you both think these functions take too many arguments? It might be
> worth introducing something like "struct rdma_rw_init_attrs" and passing
> that instead.

Not sure that buys us much.  Having a {bvec_table, bvec_iter} tuple
OTOH might be a nice general data structure.  Not really for this
series, though.


