Return-Path: <linux-nfs+bounces-20684-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBeKBfiT1GknvgcAu9opvQ
	(envelope-from <linux-nfs+bounces-20684-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 07:19:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF0D3A9E05
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Apr 2026 07:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EFE53038F51
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2026 05:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71493358B8;
	Tue,  7 Apr 2026 05:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GoQvE2vM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C709271450;
	Tue,  7 Apr 2026 05:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539164; cv=none; b=cneYO6uYkQNT4S+6rEjac6jHv256caTXKOp9hKtkLmhfZ7r8msUy/hjcRqR7YaRpsfUQTtwAE/8fc4vI9PM1u9ah8Mrv6BAO7jaa/0+oTxCXsw5MqBSIiLInNS/xn7FuH8yc5SBcck2dL2H+XbOCdXetiOrLXTyFs5CZ7i8GBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539164; c=relaxed/simple;
	bh=UwMAOWyqd5eYJ1qgbGF2m6JitrZQo97YoP27HfvDHGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehOah1h7qd+vWIhsUJalO5103Tsn2PlgIdl0+yVGEkfsj8GlXHXUqF2RofOx8LVScn1KGyzZN8n4bI6f2TVv3p0AZYo8+wadJDMsoApPnvUWCHNmR789sR30hsGE6sTUO+/hQmR/Pd1M8uEroiS/snT+ZVJ404AtCAeopANVn2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GoQvE2vM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kYfX0e0sGJA1W1y/i1C2RTFkobNEnqp+InsvttluQ8Q=; b=GoQvE2vM5lWJEyexT/Xn4xo36y
	Gy+icEYkiOc/xUgQBskvd6d1swvJCsZr2pKip8TOFGo5MO5q9koV92v4XQa0CPz8gQgsYxJ5Tkb+I
	qOAMmT9CNeMLjzInKOKN2JNkC8GEenLnMkFniRPLOsaEugnrRkjW5tDsU/m5V3Xj69sy5hEQB8lK3
	FnQ7W+dbwh0AoPHPigt6T0ir468+a4g4XuEdV3upK+oJ67JMQgm38tN+BPL9q6itc87gyLcgxxoOb
	UE37IzYi+U0Qlp63i9gyssVJO/vs/WIOCuaI/4v/6hQxySnSqHLj/x4/+cGC/BY+09gibVg3J4NOF
	CDuAQLZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9yqK-00000005uGR-2fk7;
	Tue, 07 Apr 2026 05:19:16 +0000
Date: Mon, 6 Apr 2026 22:19:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm: add atomic flush guard for IOCB_DONTCACHE
 writeback
Message-ID: <adST1EjXCDKQxauf@infradead.org>
References: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org>
 <20260401-dontcache-v1-2-1f5746fab47a@kernel.org>
 <ac3-SU7BElHJVCEL@infradead.org>
 <629f21c6591903512eb2f3f3c4d6b14a9ac7b91a.camel@kernel.org>
 <adNJZBXeJomWmhdf@infradead.org>
 <a84788c9cb25deb928b126fc9368ab8e4e110deb.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a84788c9cb25deb928b126fc9368ab8e4e110deb.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20684-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: 6BF0D3A9E05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 09:32:58AM -0400, Jeff Layton wrote:
> > And that is called the writeback thread.  So what we should do there
> > is to make sure we queue up writeback on it for each dontcache write.
> > Initially queuing up a wb_writeback_work for each range might be first
> > approximation, although we should probably find a way to just increase
> > a threshold if going down that road.
> > 
> 
> Ok, I like that idea. I'll give that a shot and see how it does. I'll
> note that there is no way to specify an inode or range (yet) in
> wb_writeback_work().
> 
> Do you think it's sufficient to just call something like
> wakeup_flusher_threads_bdi() after every RWF_DONTCACHE write, or should
> I extend wb_writeback_work to allow for doing work on a range within a
> single inode?

I don't think we care about what exact data is written back as this is
not an integrity operation.  So just waking the flusher thread sounds
like the right thing, but we might also need a way to communicate
the higher writeback target.


