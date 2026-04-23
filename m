Return-Path: <linux-nfs+bounces-21044-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDWNLW4u6mmVwQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21044-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 16:36:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80989453C93
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 16:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A845830BC9AB
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2223ED6A;
	Thu, 23 Apr 2026 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQJZqMbZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60891A680E
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954574; cv=none; b=pRryUxBmTwB6Ao+gH9JtgsGj8R4Kie9PyG7bYlRqC8/lZYH3gZ1YpEwuKIUaZMkREcfjLhJ2q6f+9XCqJjzJAolCPTYzzLceU+GtvOJ1MMh2gHO70ffvfFDxf/AqtPuNjwg/Na6t2tMM1uaZavViE+FJujOT72eAg4pEurvDP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954574; c=relaxed/simple;
	bh=XOg8hkYym7dvyTLQ7VkpMzs+QIVwUv7RkaHJzHOfgxw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYiy6ccZLHWWEOX+pVOZZyeBzIJjP6qLgQvqljnE0iyGNygNKGSWRHQbvSX5TdbtANnD++t4HcQ8oOTi9ji7oqKCnZZp7yL8AGG27Ve06vqgmM3HxNpBi0Kj/Sx0FEM+2iBh0AxANJ7BzAy/qGPmSudolBoGLoTibsYHZi5fHiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQJZqMbZ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-66f747175d8so3241923eaf.0
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776954572; x=1777559372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AK3ezXGh5Qc5kw1Wwdz/Am9391J2galVCo8Om2s3yR0=;
        b=aQJZqMbZ8ppdzRpAlno51uziW3MojXv3PzSKhBbBkGtg7kCH9Ems1lCQMWKbxud8Ny
         wNXiBAjt5JKTKhk7IxoTVZ3h9vY0jYj3VA4YhZsbzzxp4tPpmgJFHreBjj2fwiiesHYJ
         mExPGAdt8VkDM6mF4jRbg32LFw5ChIzzQvNPQjp/woMXhOTrIOvLdPRWbONXqeU1wO8D
         qNf4a/fAXotmw57oYLnTt8kH/eBJbE1eLQpvXTYZrbaAtAGtyzrJSiGUopWi/6cckTKk
         WHLghWyF9vkIpjAmRNyZ5WEpaP8IhM9TzOXfXTi5oKZgXn9KrrfAu64W5O86Aj+fOEij
         2VMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776954572; x=1777559372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AK3ezXGh5Qc5kw1Wwdz/Am9391J2galVCo8Om2s3yR0=;
        b=HdTIYZMiYwd6H8R/BbgDPW0sItVDLjmyk+m6y2BUnO8Z/GGdtM506KGOLTxWb2vu+U
         RjHWZlVjdIxB07aSE3G/HyP77tQHL1UbcwJoet716IoDBJuUSJrala/PNIl6Qx+GxwTm
         pg3U/pDhwj6kBGojyr5YS0icZ0PtBRp8LLcKWRQPPuJh/MNj0tMcqkPYmM34XppBZr2i
         lMv9NS8TH09V5KF03VJGEq6vNxcJoQcgNeUTxaZMHPQEMGuRyLLNYbMZY7oTBV28yZbm
         RHLCldERbDJk8gd1cvAwlBMYl3tvu5Ut+bGlQJPKdUSs9UezLrODDUedfFFE7O3nuo5k
         U9ng==
X-Forwarded-Encrypted: i=1; AFNElJ8V1D/v7JPj91PtLxnd+yVSrYnjMdqVZRjvD4+CBavC+HWJsvA19ZsU8T6f3iww/uHlHs95ARvDzUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXjhTg0i0G2GLW/7XebFq6bhTESU7RQF0sgShMHXTvSLUZWyB
	6QTyiEGppfmpRI3VSagzI6QqUhiLpGACyZoysZCgA7N820IT1kHQDB/y
X-Gm-Gg: AeBDiesM59r4WLlFx/MP4VXV4/Z5cGnbYoFeJwpEhkUgDgctph+lg6AKOWPPgdjfob/
	8t7dC09lgIjRbRTP/sMlGS+h5Pgn/VB8Qm/KMMM7d75KzHO0t2XY0CeTnU9PYV0L6dVh9s46ZYZ
	AF3c2YR3BW8HkCNdbQQPNlQosz4E+ednexHYxyMo9dVsWxIDIgHBWALYF6ZrkZyrs/A6XkmcsUz
	mYIwRXO1jymzU8L8wN6gkEX+kS1IEHZaPYPQwobz/Y1tXYdyrYjgglwp5icz2keHbvdCuWRuPvA
	pwRGyXMEv4K8gTup+Shrv3G2mnhetDWY3PHWzglqH9raYpN9qe/sSAJ42fFKesiNNghE4Q9Tfek
	3/V9K7cAgnFvnXjsFnk/s1cOOSGjZeXFi9y5X/a3SMiK6O6059LuRDqx2uhD0Gzu9nzw07snr+s
	O58fko9ZXKdTlUa3xwh0MBzVy63fgsc6ClKOfAet7c1hHSC7IA5vA=
X-Received: by 2002:a05:6820:809:b0:694:83f2:27a7 with SMTP id 006d021491bc7-69483f23412mr10323457eaf.28.1776954571535;
        Thu, 23 Apr 2026 07:29:31 -0700 (PDT)
Received: from localhost ([2601:647:6701:9440:8c31:af41:6344:1d96])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c05ca16e2sm10176379fac.15.2026.04.23.07.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:29:31 -0700 (PDT)
From: Thomas Haynes <loghyr@gmail.com>
X-Google-Original-From: Thomas Haynes <loghy@gmail.com>
Date: Thu, 23 Apr 2026 07:29:29 -0700
To: Anna Schumaker <anna@kernel.org>
Cc: Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, 
	Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] nfs: don't skip revalidate on directory delegation
 when attrs flagged stale
Message-ID: <aeosOBEN-RWr1_Ae@mana>
References: <20260418190301.3661-1-loghyr@gmail.com>
 <20260418190301.3661-2-loghyr@gmail.com>
 <32c25063-3b89-4d00-87c5-3334327586c3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c25063-3b89-4d00-87c5-3334327586c3@app.fastmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21044-lists,linux-nfs=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,oracle.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loghyr@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80989453C93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 09:37:21AM -0800, Anna Schumaker wrote:
> Hi Tom
> 
> On Sat, Apr 18, 2026, at 3:03 PM, Tom Haynes wrote:
> > On a local directory mutation (rename/create/unlink) the client marks
> > CHANGE / MTIME / CTIME as invalid in NFS_I(dir)->cache_validity.  When
> > a subsequent stat(2) enters __nfs_revalidate_inode() and finds a
> > directory delegation held, the function currently early-exits and
> > returns the cached (now stale) mtime to userspace without sending a
> > GETATTR RPC.
> >
> > Keep the early-exit for the fast path, but take the RPC when CHANGE,
> > MTIME, or CTIME are already marked invalid.  The delegation alone is
> > not a guarantee of cached-attr freshness once the code itself has
> > flagged the cache as stale.
> 
> Is this a problem only for the attributes you've flagged, or do you think
> it would be a problem for size, nlink, or mode attributes as well? I'm asking
> because we have NFS_INO_INVALID_ATTR which includes all of these attributes
> which might make this a little more generic rather than carving out an
> exception an attribute at a time.

Hey Anna,

Agreed on at least size (and probably atime), which means a little
more generic would be a good thing.

Tom

> 
> Thoughts?
> Anna
> 
> >
> > Assisted-by: Claude:claude-opus-4-7 [bpftrace] [tshark]
> > Signed-off-by: Tom Haynes <loghyr@gmail.com>
> > ---
> >  fs/nfs/inode.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index 98a8f0de1199..936bc329f462 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -1390,7 +1390,11 @@ __nfs_revalidate_inode(struct nfs_server 
> > *server, struct inode *inode)
> >  		status = pnfs_sync_inode(inode, false);
> >  		if (status)
> >  			goto out;
> > -	} else if (nfs_have_directory_delegation(inode)) {
> > +	} else if (nfs_have_directory_delegation(inode) &&
> > +		   !(NFS_I(inode)->cache_validity &
> > +		     (NFS_INO_INVALID_CHANGE |
> > +		      NFS_INO_INVALID_MTIME  |
> > +		      NFS_INO_INVALID_CTIME))) {
> >  		status = 0;
> >  		goto out;
> >  	}
> > -- 
> > 2.53.0

-- 
---
Tom Haynes <loghyr@gmail.com>

