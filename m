Return-Path: <linux-nfs+bounces-23184-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RAWVMyM+T2rycgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23184-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 08:22:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C846D72D13A
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 08:22:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=UN7d6eko;
	dmarc=pass (policy=none) header.from=infradead.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23184-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23184-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C09C230151D7
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 06:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9132D3B42D6;
	Thu,  9 Jul 2026 06:22:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B83B71B8;
	Thu,  9 Jul 2026 06:22:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578129; cv=none; b=dNqJYaQ9rb3kON1YqD8RWPhF2lAn+lhId2SxZRJyQ/FFL4WkaomIGKqQ4s4qq4yQRM+ukUxZ4/Pne1jDw3rhfoToVDfE7ttFRgfid0UOepix6jHUPrb563WM1vP2cw7awbPRrVyGS0Ivfg4N4UMqzCMutwh9zFlHElMqusvDb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578129; c=relaxed/simple;
	bh=p5YWmUjKmZBDzAruaws7Z66qQssX09NRcDVD+6LKOGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q28G1CUf5Kn3ExRwkPIm6hYaJ1hctSL9y+UDHQnkG3/1IROVC977nN/lMwP78US6qCk2NrqdQcKPtg1brwa+hl6VT6vKHMWvwAbv+Co/NTynLp4Cz9zunwtjKXaGSo2dSvbKTsz+5r1ViYxabr1T1lyV/eUm6QP+DDHF+X7LeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UN7d6eko; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gF6J3GIPzB252v3fk/nA4luYZs9h9zFcInqUmdwDTgM=; b=UN7d6ekoveglcriPTF826Jme+X
	g4JvFxZB7+4fw3Gop5HMmI7YU3DZKH7Ston2ie0y5t53LPIkN1ui2qqT2ZJMoNMkgslveG7a+mI6C
	K+RaR5qVmnS91IaTnWbBLjLAPinHcWCPeiimcIqM9tdU344l3rsALhgAD1qYoFSvmsHGVtHf3ilo0
	autVEdHMv0GM1+KCJwtvBx/8qEG6pRtZTw8IbT4gMNv6wU3ID6EljEvTP3wVEawo+CTvdjWZ12XJG
	oF0KyloGsu+Y8v0bzI6DpI0LoFm2AMq/Sf+tO3djsXwJSM1Xu8lnbXOBuYbYevROtuIe95/x4Gd9M
	p7nfV2uA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whi97-000000018qZ-29YS;
	Thu, 09 Jul 2026 06:22:05 +0000
Date: Wed, 8 Jul 2026 23:22:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
Message-ID: <ak8-DbIaHk8awOaf@infradead.org>
References: <ajGGpDvzZdkGtSbN@google.com>
 <ajP8ZTTLYkICFTO_@infradead.org>
 <ajQ21kH1ZVajS2Y7@casper.infradead.org>
 <aj4iiD5C_yyLeb3U@infradead.org>
 <akevQfFVteCOD6LM@google.com>
 <akfAgy52s_Gch2KG@infradead.org>
 <akzsO_vmYX_7Umjd@google.com>
 <ak4A6IEmWNi27I2d@infradead.org>
 <ak44z-X-SKKhkBkg@google.com>
 <ak89YF6BS-iYf_e_@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak89YF6BS-iYf_e_@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23184-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:praan@google.com,m:hch@infradead.org,m:willy@infradead.org,m:trondmy@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anna@kernel.org,m:shivajikant@google.com,m:linux-mm@kvack.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C846D72D13A

On Thu, Jul 09, 2026 at 06:19:12AM +0000, Pranjal Shrivastava wrote:
> On Wed, Jul 08, 2026 at 11:47:27AM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jul 08, 2026 at 12:48:56AM -0700, Christoph Hellwig wrote:
> > > On Tue, Jul 07, 2026 at 12:08:27PM +0000, Pranjal Shrivastava wrote:
> > > > Ack. I see! Thanks!
> > > > 
> > > > Regarding the page_folio impasse, how do you suggest we proceed? Should
> > > > I expose and use get_contig_folio_len() from bvec? Or should I move the
> > > > NFS helper into the iov_iter lib? (or both).
> > > 
> > > Sounds like the best way forward for now.
> > 
> > Ack. I'll reuse get_contig_folio len and move the nfs extractor to
> > iov_iter for v3.
> > 
> 
> On a second thought, I guess I'd try taking a stab at writing
> iov_iter_extract_folios and handle the vmalloc / slab cases for kvecs. 
> I believe that would be the right way to go, unless I'm missing
> something obvious? Can I take a stab at it in the next version?

That does sound good, but it might get you into some longer discussions.


