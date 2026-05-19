Return-Path: <linux-nfs+bounces-21694-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFb1LI4GDGodUAUAu9opvQ
	(envelope-from <linux-nfs+bounces-21694-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 08:43:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7BD57845A
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 08:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C5B3301CEF1
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 06:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BD9388373;
	Tue, 19 May 2026 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uMd1d7bG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8F320CD1;
	Tue, 19 May 2026 06:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172241; cv=none; b=NobZNpzYdUxcy0QHk7bRlC82oa3l6R6u4YRfDuEZIQ3yE7cSpv/ZwiI1EU86nRZy/VP0x2R5ybaoZWHXo/bUBBkrBTqXAUg0UFUMdG9cDauDxz262kqhqIZidsTD8YlRZmreYt/eLo0tBPZmd4eoqG2OUuJprWENjDgWA6Nn/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172241; c=relaxed/simple;
	bh=xLAlEyVJjznWZTrFyh93caOES0WRTjEyDleACNebGBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITgTuIz84qaWMC5MDNIm6i9z7kfWmjhKOqh73FG3O1/mehBE8HXZeX8/Vol3CokaH5svdFU+UK+EC737rLdpBJ626MKedoPCCtCVP9QSvshUaVh8jpEHnRL2K83VeOg6MHiVebywAgJklVJfoJoCtQSJvNegidmuW17ZjdApiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uMd1d7bG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DTsq3YybtPCTcONnROVePslNe++MYvP355QbI5+eeWk=; b=uMd1d7bGjp/ODh+GRc6gJRS6bf
	2ZOnwF+jSH3J2gavrn6VeOO1j2eHhK6BWp+z51R2t1GurmTiG91KQp04ELtIIy86pmpEeczSxEHDO
	DUe/yz4C1UIs+AD3seqDhY079IT6jclbuPF7ilQlYgnuc+0OjID58kmqdMidH/odBSFuxKd4EKFTU
	g4c9CmZowIMP73XnDu4yN4dnaY4w07Okw4wQq24B/7FGgCyiJtuzEbEhFFNx7Fr8IIr5N3/UIjgkg
	qJ9Gj0sGMJhXjQlJV2HSRVTJ22gBXI9vDAgG83CmdWtuPda7POx67R5Gpo+d9Cb0Io9f5nG1Ztf+x
	kvwM/xhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPDyI-00000000LXr-0YO8;
	Tue, 19 May 2026 06:30:30 +0000
Date: Mon, 18 May 2026 23:30:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <agwDhixPAAA0-cTa@infradead.org>
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
 <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
 <20260514002513.GQ9555@frogsfrogsfrogs>
 <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com>
 <ageSguSyf2kBY33a@dread>
 <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
 <agqfBPRWXQDR2ImG@infradead.org>
 <606c4cea-70d2-4601-9db2-611cd35c3687@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <606c4cea-70d2-4601-9db2-611cd35c3687@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21694-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AE7BD57845A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 12:55:17PM -0700, Dai Ngo wrote:
> As shown, the file map changes. Entry# 7 and 8 before the NFSD calls
> merged into entry#7 after the calls. So there must be some activities
> that cause the map to change. I don't know whether the activities were
> triggered by NFS or something in XFS or the block device layer.

Hmm.  We only insert layouts (and search for conflicts) after calling
->proc_layoutget.  So this might be racy against unwritten extent
conversion, or other writers, which is a bit of an issue.  I guess
we need to fix nfsd4_layoutget to insert an in-progress layout before
calling into ->layouget.

> However, based on this data I think it's better to change the bmapi_flags
> from XFS_BMAPI_ENTIRE to '0' to address the overlap issue.

We absolutely should be doing that as I said from my first reply.
Still trying to understand what is going on here at a higher level,
though.


