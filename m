Return-Path: <linux-nfs+bounces-21639-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ1sG5KSB2pU9AIAu9opvQ
	(envelope-from <linux-nfs+bounces-21639-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 23:39:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C8F5583F9
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 23:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFFD1301739C
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 21:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB1C2620DE;
	Fri, 15 May 2026 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqYXqz6j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5513909B7;
	Fri, 15 May 2026 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881165; cv=none; b=s61gM42UH+WLvBkAL/oNUkEqIvuyPpftZpUtz2TTXkiWNX7QAYgz3ixO9ZNpvTmMm+8B7+VQykfMf+KZ5iwwWMlR0a3QUVUmLZCduE+MpyIv5oyF+ldZdQxQ+FH9i0YIPkeQkw4lN4tPkPw5n2/L7I0g3W78b56vN9y0eX2Sbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881165; c=relaxed/simple;
	bh=wwcDdCeF4pm4mGrrWBsOTYshZ5RcMGSW49jkfYnyQ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HduDaZ4M02upWn/OUNm1lhR9KJHFTkTVdSph9Bfv4OAYvXCOObNfQElvr+y6WP0E/Ala0QJBPCBz2j+U0fkZAt0sRC1HNFU6xM28GiSbCSqUR8Kq6b16Dqn6Evl/KMevnlFppkROrLwF6itzpVnsFBIJPgtqJbEsWCPxT5f8tY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqYXqz6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F8CC2BCB3;
	Fri, 15 May 2026 21:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778881165;
	bh=wwcDdCeF4pm4mGrrWBsOTYshZ5RcMGSW49jkfYnyQ9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqYXqz6jQ97LTHCcKUC+GkRBqJdFdAoB55MmpQUJH43qB5SI4FW6+UbsawI250Z/S
	 eKctgmddqw9Y8CYa9Wbb8sSAfzRcyEMJDCYUFgFPg+swcHhRCCCmH8xi1DXmUfNfQ9
	 +1Zpsj4J/rqse/lr1bK+0Yobwrh9dzWOwsrFIRpaw7ZOa+OSZQVlctlDZtrA/37/Sa
	 F85BCUWXdgthYq3b/eNrE133U+4VMw8wwNxTaelce4T0ZwxRe81NOkIwjXimLxH0HQ
	 EYtDbvfCePsnU7CbY4QvIusjKqn/feESI0bMZ4BEfRduLRCaAGwnpZcKNSPANllE2A
	 DnxZYAtLqA2ZQ==
Date: Sat, 16 May 2026 07:39:14 +1000
From: Dave Chinner <dgc@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <ageSguSyf2kBY33a@dread>
References: <20260512172238.2495085-1-dai.ngo@oracle.com>
 <agQhzg-0aeISwOGW@infradead.org>
 <961eb355-2f52-47a0-9399-e050a4e535a2@oracle.com>
 <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
 <20260514002513.GQ9555@frogsfrogsfrogs>
 <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com>
X-Rspamd-Queue-Id: E0C8F5583F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21639-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dgc@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 10:19:14AM -0700, Dai Ngo wrote:
> On 5/13/26 5:25 PM, Darrick J. Wong wrote:
> > On Wed, May 13, 2026 at 10:28:31AM -0700, Dai Ngo wrote:
> > > IMHO, I think we still should fix xfs_fs_map_blocks() to avoid any overhead
> > > and complication in ext_tree_insert having to handle overlapping extents.
> > I don't know enough about the nfs blocklayout code to say for sure, but
> > it seems like you want to upsert the mapping returned by
> > xfs_fs_map_blocks into the "ext_tree" right?
> 
> This is currently done on the NFS client side by ext_tree_insert(). The
> question I have is should we enhance the server side by passing '0' to
> xfs_fs_map_blocks() so the client does not have to do the work of
> handling the overlap extents.

I think you've all missed the optimal solution to the problem. 

The problem is not the use of XFS_BMAPI_ENTIRE on the first mapping
call, it's the use of it on the -second- after the first call didn't
return a range that mapped the -entire- request range.

Hence the second and subsequent calls need range trimming so that
they don't overlap with the first range that was returned.

IOWs, we keep the use XFS_BMAPI_ENTIRE for the first mapping call
so we retain the optimisation that minimises the number of pNFS
client mapping calls needed, but if it needs to make a second call
we drop the ENTIRE flag and append extents trimmed to the range
being asked for (which doesn't include the first extent already
returned).

That was we get large extents reported most of the time, and in the
corner cases where we have a race like this one or an extent
boundary lies in the middle of the requested range, we will get
correct, non-overlapping behaviour.

Best of both worlds, yes?

-Dave.
-- 
Dave Chinner
dgc@kernel.org

