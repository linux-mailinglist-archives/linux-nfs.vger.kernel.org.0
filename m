Return-Path: <linux-nfs+bounces-18256-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO91JcMHcWmPcQAAu9opvQ
	(envelope-from <linux-nfs+bounces-18256-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 18:07:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 450A85A4D2
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 18:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25E1574D9CC
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92883EF0AE;
	Wed, 21 Jan 2026 14:57:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668D330B2B;
	Wed, 21 Jan 2026 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007434; cv=none; b=E99kNLb1qXRGXXeobHg8xIfyhsGWcMCrO15/Me1K100YzWjzvQwdL6q/ie4TCMoO/IVb8XFt1DDv7r20BA9HyGQ7XhK3pnFoAa23FbKzDmPJACHGsV9Jiyk+GTDCHTCY+k4Wk4fVh//tWioosuDqQKAfqpCyBwyJIEFzDmRVdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007434; c=relaxed/simple;
	bh=ceOlb/mlNBruqCDXStep/c8Nbx3gkhMatIGX7LDO06I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoluAPVc476LsHWhi8T8LROUEmZO2/qJaQyTLRk5TDSEYOBcklf5KwbxRzfWVj24IX1hC0MXpoPjsr59kfk3po5OTyOvSf7aQtpwND2UgRAty2vYiP+IfJ0Pjs7K10SA1vIApDPFt3OsbkGLq942SpfpyxiRIEnTZqgoE1Tuem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8056F227AAC; Wed, 21 Jan 2026 15:57:03 +0100 (CET)
Date: Wed, 21 Jan 2026 15:57:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/4] RDMA/core: add bio_vec based RDMA read/write API
Message-ID: <20260121145702.GA13953@lst.de>
References: <20260120143124.1822121-1-cel@kernel.org> <20260120143124.1822121-2-cel@kernel.org> <20260121085641.GC16458@lst.de> <9bfdde0e-efe5-4e23-b95d-6f70836ed59c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bfdde0e-efe5-4e23-b95d-6f70836ed59c@kernel.org>
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
	FREEMAIL_CC(0.00)[lst.de,nvidia.com,kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-18256-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 450A85A4D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 09:14:36AM -0500, Chuck Lever wrote:
> > 
> > I'd much rather have the callers pass in the bvec_iter, as that's
> > more useful.
> 
> "The callers" -- Can you clarify whether you mean that the API
> consumers would pass in a bvec_iter, or whether the iter is
> entirely internal to rw.c ?

I mean passing the iter from the API consumer into rw.c.  In general
that is the sanes way to deal with a collection of bvecs.


