Return-Path: <linux-nfs+bounces-18461-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DzcB8sGd2lGawEAu9opvQ
	(envelope-from <linux-nfs+bounces-18461-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 07:16:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 869ED8468D
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 07:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 836BE3008E0A
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 06:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E317264614;
	Mon, 26 Jan 2026 06:16:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4E1F4C96;
	Mon, 26 Jan 2026 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408199; cv=none; b=EpKI1xTPRjbw+qoydwaxxiIi0d+HacKcbE9XCT+N247krwq3xJBbRbHB6qAslhLCf+A3CYMFg+8Yy2DMojmRWH/0Jj7Jzqro1kmGBCW01WBy0zEIfJ/FTnBh63jkw4enuhRltFRePZnaD9aVv5QpbqrGT5xzvbUuQus8h60+qXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408199; c=relaxed/simple;
	bh=H8usAyYShw9VZh93jk9hy5ByqZbJztMBu96NhNHXrqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWHHjaN6f1+/Kv3ISQe9JYZUn58TcfY29JiaQptWtRRkFRrwW7XDLrOUqsuotGTAB2CsozwbFTac+8aAuvbvU33ftpFpG1DB7H1hogJoS2N60W3DqhLTu4EkMn+1QK8bOWgQ3iC73nipwdEPRe6ng4ffHtM+Ta0gNnHh61hFbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3FE1B227A88; Mon, 26 Jan 2026 07:16:32 +0100 (CET)
Date: Mon, 26 Jan 2026 07:16:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 3/5] RDMA/core: add MR support for bvec-based RDMA
 operations
Message-ID: <20260126061631.GB1638@lst.de>
References: <20260122220401.1143331-1-cel@kernel.org> <20260122220401.1143331-4-cel@kernel.org> <20260123063622.GA26025@lst.de> <9a8a0671-29a2-4220-8d38-361a6718b7ea@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8a0671-29a2-4220-8d38-361a6718b7ea@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18461-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,nvidia.com,kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.950];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: 869ED8468D
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 11:47:46AM -0500, Chuck Lever wrote:
> On Fri, Jan 23, 2026, at 1:36 AM, Christoph Hellwig wrote:
> >>  	for (i = 0; i < ctx->nr_ops; i++) {
> >> -		struct rdma_rw_reg_ctx *reg = &ctx->reg[i];
> >> +		struct rdma_rw_reg_ctx *reg = &ctx->reg.ctx[i];
> >
> > Jumping ahead here - why can't the sgtable be stored in ->reg
> > without renaming?  Is there case where need it, but the rest of
> > reg?   In 
> 
> I think the answer is yes, with bvec, both fields are needed at
> the same time. My preference is to go back to the early form of
> the structure without a union, since there are API consumers who
> access the reg field directly. Let me know your thoughts.

What I don't understand is why it can't be added to
struct rdma_rw_reg_ctx.  Are there any uses of the new fields that
don't have that allocated?  If yes, just adding the new fields outside
the union seems to cause the least churn for now, although I'd still
want to clean it up later eventually.


