Return-Path: <linux-nfs+bounces-21728-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O3JIp1yDWpUxgUAu9opvQ
	(envelope-from <linux-nfs+bounces-21728-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 10:36:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BD7589E46
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 10:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DDAB3020EB8
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2026 08:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B737B027;
	Wed, 20 May 2026 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C3qdrXdp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0831352A;
	Wed, 20 May 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265474; cv=none; b=eMUAzmh4pM0AC22DCIq6P1DAKuBtVh7btsMcggoXxC3pc0C+72tpyxvaraqWsvu+tthLFK0nohvZUm3MImNVka70AC4KeeN7M5E+Ungl1TTWHTrE1lTL19NpGciVwaCf642WPe6wEmJzTr0DdofoIXzk0GxbVoY1PelpNHxbJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265474; c=relaxed/simple;
	bh=r+QVAPKBzwJOTRXNU1NXUQU0eVlMPxJ+ayXxO7+rfs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0ULv7KnJwFduVsbTZsqwcp4c2PB/c9T+awHURXyUgJqCt2TAa7wdbOkmUlEl3S3aOfbLB3Z5XEtk/gMbz9ptJCrt3UswAoVdTdSO1QRMrR+ah3oNjQ4alwRiARfpFH14hEgn8Pkvsvb+ZxrjL40ZuBpwajURxHoktvOM4Vq5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C3qdrXdp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6IFC3wldLeo4x/t+xYgOODr2zcH9+Jthub9CBamxD8s=; b=C3qdrXdpZzKyBGmMNMUU7S89JJ
	MyWS6UOi83XhNUvWPxMkY3G0i77aO9rB6WOUtfiDRy49OSEQHOU7lOTHID+zd/kgVcbdAhKSobMKR
	Sq+nYQZM21HsXuii1DvC18bznzCd0CtiI1vTAjKhqV1DvBwppCM86+NUIFAcKwOiWOEx7R/iJmHMO
	ErxJa2FzzkxZUS5fciBjF2DPqjEqvBgSzFMeML6U6bmHCcB3qUHw8G3chxuwFFA1DaaIejZ+p88CZ
	VeorXwqV6eHKmZcdukJQIbQam/tKpLtrByDTV7l3YT/Gh7rJu/veHRIMBAeM72z3aWK1mxQnXA1CO
	HwrDgawA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPcEC-00000003x2M-0EtP;
	Wed, 20 May 2026 08:24:32 +0000
Date: Wed, 20 May 2026 01:24:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dai Ngo <dai.ngo@oracle.com>, Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <dgc@kernel.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: Re: [PATCH 1/1] xfs: fix overlapping extents returned for pNFS
 LAYOUTGET
Message-ID: <ag1vwFHoYatausLK@infradead.org>
References: <06d9b1ae-e46f-459c-bcb4-1a5ca4ded4b0@oracle.com>
 <20260514002513.GQ9555@frogsfrogsfrogs>
 <26365a46-bdac-4e8a-a951-de904c3e5606@oracle.com>
 <ageSguSyf2kBY33a@dread>
 <b9860332-7b1e-448e-869a-ad59d8d5b7c0@oracle.com>
 <agqfBPRWXQDR2ImG@infradead.org>
 <606c4cea-70d2-4601-9db2-611cd35c3687@oracle.com>
 <agwDhixPAAA0-cTa@infradead.org>
 <55c7c22a-8edb-4833-be3f-1f6555ba90ed@oracle.com>
 <20260519145949.GH9555@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519145949.GH9555@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,infradead.org,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_FROM(0.00)[bounces-21728-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 00BD7589E46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[adding Sergey, who wrote the code to allow multiple mappings]

On Tue, May 19, 2026 at 07:59:49AM -0700, Darrick J. Wong wrote:
> 1) xfs_fs_map_blocks only takes i_rwsem and XFS_ILOCK; it doesn't take
> the mmap invalidation lock.  Does that mean that pagefaults could wander
> in and mess with the layout?

Looks like it.

> 2) Now that NFS apparently can serve up multiple mappings at once,
> should ->map_blocks pass in an array element count so that we can do
> multiple iomaps in a single lock cycle?

I guess we need to do that, or revert the code to provide multiple maps
for now.

> 3) Do the reflink and realtime inode checks need to be re-assessed after
> grabbing the ilock since they can change?

Yes.


