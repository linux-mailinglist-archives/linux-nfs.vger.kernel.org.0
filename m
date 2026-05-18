Return-Path: <linux-nfs+bounces-21658-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNIpE1SfCmpJ4QQAu9opvQ
	(envelope-from <linux-nfs+bounces-21658-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 07:10:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A18B5565E5B
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 07:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A7613035825
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 05:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51172E3397;
	Mon, 18 May 2026 05:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="044z8NyB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D6388375;
	Mon, 18 May 2026 05:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080967; cv=none; b=qAx2VBgZ1EUMc0ViYcjHcy78m5eycP2pwY2BCeYviiwWNmm/P+enPs2tCY7HymBPf6Fg6yywgZY0Rz8I/C4A53lOdRJmMbFhshWZQ4jN8BC2MaIcwEyI2XJotSpbgIsqUoOWpqciTwTU7E6BFCfzhWdswjHZdCWjIjWEuyIWEtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080967; c=relaxed/simple;
	bh=qdMldoAsz2iPtSWy2Bg8VQjEeGMh7zRhVkIWtYd18Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD1iBk7SlLTzGr3zP4tUDOI84WcOVOP1qgfFeNPzWU/M0DIPlSsyQJ0qqAf6kU5lrk4LmKh2vpUHXRbXTTJ6XlADLQjwL+laQLaxIxEeAzowVvCdUxioNz2idqhPI5eq/iLl8ESaMZ3FMzDyPW3PUkflJbCkDG32QL1rL/CnAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=044z8NyB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+9q3Gn1xB4yvMdhZoDuMQXYjWl9PeKTDXMHyMD0vuhc=; b=044z8NyBspJpzDWMe1bt8L1Bvb
	JaKnmt/GvF19j0BpyViMcqk73o1jRuonpW5zTBXt8/+dhkYfVfe/NffCUXykz9Gw72BTFM4fRJNmk
	jd041c+5sE0FLY1xLBjfmhB/H0SBt4N9m4nnIMUid6g38JQik/Eicu9LR//sPI6Z84hPBHga+07aV
	T5OXfLGgRcWHlQSTH+LBt3/Z1QS6P37iOaV7sDuNZiMg1U6E5uBxwpQwoqGBMg4f3HuOmi1eWtl3X
	wJjzfZfGUFleAJ6URUd/Gi6rV0rCSb1BguyFYmWicPUZM/LPTCVLXHVTGPbtKG0sujMnMv+QMvPq7
	bg2WDtvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqEG-0000000EE4S-1MaB;
	Mon, 18 May 2026 05:09:24 +0000
Date: Sun, 17 May 2026 22:09:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Dave Chinner <dgc@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <agqfBPRWXQDR2ImG@infradead.org>
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
 <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
 <20260514002513.GQ9555@frogsfrogsfrogs>
 <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com>
 <ageSguSyf2kBY33a@dread>
 <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: A18B5565E5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21658-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 07:14:29PM -0700, Dai Ngo wrote:
> Currently the map_blocks() API between the NFS server and XFS does not
> provide a way to specify whether XFS should use XFS_BMAPI_ENTIRE or '0'.
> xfs_fs_map_blocks() just uses XFS_BMAPI_ENTIRE.

And that is a good thing.

> On the first mapping call, NFS server always specify the whole file
> range that requested by the client in the LAYOUTGET.
> 
> So if xfs_fs_map_blocks() can not return the requested mapping range
> with '0' on the first mapping call then I think using XFS_BMAPI_ENTIRE
> in the first mapping call makes any different.

Yes.  Still not sure why we get a second call that overlaps with the
first one in a single layoutget operation, though.


