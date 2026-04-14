Return-Path: <linux-nfs+bounces-20839-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGncClac3mlrGQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20839-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 21:58:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3383FE2F1
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 21:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BC64304F2D2
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Apr 2026 19:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BA731E84C;
	Tue, 14 Apr 2026 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dwl/jY3e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E7313550
	for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2026 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196512; cv=none; b=inj8vhtPTPmW/T6ftjqF9khi1tM9rPM5Qh8BYfEf6RvmFjeMJpx8tlmysCgaN2Fv8aMyPEFKZxjaZiAhb7KjQ4ARn7+OQKfmM7BIFSTISEIusoQJPKZODW/4/MVh2zOQJVf9IrfDdc8xmu0lxxvEqZNFw15KIR/UtJy80JwBFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196512; c=relaxed/simple;
	bh=3ETI8HKv9k/TPaQz9XPknmRZjF+FWe7OX48i2/NIqzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACvT1R8hHoonY8E9FOcq871cD0Ks1KAs5N3wWFx8gSxxg8wo8JcxykT6NRhJFt6g3JDQmKFo6TsHbFadoS09ob3zP9ZZdW2gKfEZguFto/Ddn4fQdhGlPHt+RTEQtS9gqGUMUEonk5lsOm9sCUvBFU+ZDbvgFuCIpdwULW+NE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dwl/jY3e; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b46da8c48eso105755ad.1
        for <linux-nfs@vger.kernel.org>; Tue, 14 Apr 2026 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196509; x=1776801309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QO0gZN5Jlax1WzrFygkCLAFn07nYmDrZ2OOY4+ScRfI=;
        b=Dwl/jY3eMbqvLIivOCbBVVsmLHPghzjfCCZ8qg0wXHrad/s5f+DDnlcqMHWqq545Fm
         CyIjTtioAqk4QXGi2zG7NTZ9FMC8dzP/4B22mwmlsRapzbi0ehPyfS4W8MhPV9ViKWDS
         ZZSI07coqSOl0WJ9rHGx583AgAtbnlU9+PrXN+tLVq3J5urIYbvk41E81Fr4cfXNDQg/
         +EAguPJ5RoDg6uzSzMk466RWhoWLdvImtA8VyYNvzmxNnl7zpVYJFSCwH9DYn1VokMy4
         j4Dbx/4ao2sPHRgcvPUgA/gIXRwR9PMSaphG9G7h6Lt6+L1dRt7dBKqOrn+yyUmA7AaE
         Jd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196509; x=1776801309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QO0gZN5Jlax1WzrFygkCLAFn07nYmDrZ2OOY4+ScRfI=;
        b=Y+4r7/qALKaODfSHdyvi/VXEScCKdwg9NNeG0fDOUqInZzQYSResSE69s7pKNVD03p
         Mcb3hBFlr+O2gTyJnymbtXUlfqVek5zqYupgjLvbiC9pQUEzJwWMvLGERX7jil8RH0nB
         1p6lhWDqgPzUBAWHaJIhGUnwPWzewDy/N4XqrF7c2I5s/d1cen2fA4TsYssl8pdNEEw5
         mywCdUBTtl3LbatKRC+fZ15Rt/jOWiuLqdNvH3SLj0ejyQBI2jvsY4QjNFgwo08aFcgg
         nmojhpDCs/iyTMIZcXaCY2YSDe6Rm1vUaUUx7FckIH511KsXWn1wo77UXITwUs4KNXK8
         uIxA==
X-Forwarded-Encrypted: i=1; AFNElJ9KCe+cyyfeKgv9iwuA7YSjSdBj2HqxCdTf7d0HY+h32ixxxVGvreTTVuhBsKzKrwCkpUzj9FtOmyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziGOubcCH0RtrgqyUvoBLtXtpxnz3/voiiaJS6SiTKNXzArdma
	I2xG2GT6VE76Ya06gOxfdfQsTypFPkhAem4qh17fwMVNkX27r3+HEj28MkJM8hgbnQ==
X-Gm-Gg: AeBDietElpPzcP1WpUdjqGpeR6ysPom1c/t0p+aDkoD1ap856AbFUpvZWtsQ4lx9YzK
	eEVeRryzt+fuo3z4O2XH26/Z31+s9knI2vLI+jZyFNO3HWA7eIowN4uOTAs+SegVvZed+lB/Jo/
	KkLT5zw+XfIXIByl/2mYQv30kHMJa29NyFWLogTSNnwikxKqGcIOXIRl7hepejCj0OCiMWYaT05
	gKo1ybuSUQDhzaqZzlzReAyaRgz2QO8m/bbKprRWmYeWu1CD4SC5/1rYZzifdeg/SovFa7LRZQm
	Z2aTnQ/r/qIvK3neIWIgFYG3yODKSkj/sqBLmwYFhtpFzBhs8DZAqqjrC2BpTVC9UIOD83A4DXN
	V8URULrLn0PbYZSxh4Qc2kD81Ky4B7C06KUrD1rTpk+AADssvCAsFbfzS5U3gfGNMOEZBarquZY
	vhgcILjbp/TzZupbY8TjRYnqOb4kELpV8P59gQ3hXL4s15mCtGddOmO9miOhOphmJ1pKOf3CDxQ
	6HzwN/T9nQdiWGd0Q==
X-Received: by 2002:a17:903:1b44:b0:2b0:9a61:9d9 with SMTP id d9443c01a7336-2b476b8d66dmr54735ad.9.1776196508458;
        Tue, 14 Apr 2026 12:55:08 -0700 (PDT)
Received: from google.com (174.188.87.34.bc.googleusercontent.com. [34.87.188.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd0830459sm37324a91.6.2026.04.14.12.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:55:07 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:54:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>, edumazet@google.com,
	Paolo Abeni <pabeni@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Tom Talpey <tom@talpey.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	NeilBrown <neil@brown.name>, Dai Ngo <dai.ngo@oracle.com>,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] nfs: add NFS_CAP_P2PDMA and detect transport
 support
Message-ID: <ad6bkyA1ItA8ou9i@google.com>
References: <20260401194501.2269200-1-praan@google.com>
 <20260401194501.2269200-3-praan@google.com>
 <791991c2-1e8c-4041-9674-94acb4fe483c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791991c2-1e8c-4041-9674-94acb4fe483c@app.fastmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20839-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C3383FE2F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 09:11:04AM -0400, Chuck Lever wrote:
> 
> On Wed, Apr 1, 2026, at 3:44 PM, Pranjal Shrivastava wrote:
> > The NFS server capabilities bitmask (server->caps) is currently full,
> > utilizing all 32 bits of the existing unsigned int. Expand the bitmask
> > to 64 bits (u64) to allow for new feature flags.
> >
> > Introduce a new capability bit, NFS_CAP_P2PDMA, to indicate that the
> > local mount is backed by hardware and a transport capable of PCI
> > Peer-to-Peer DMA.
> >
> > Update nfs_server_set_init_caps() to query the underlying SunRPC
> > transport for P2PDMA support during the mount process. If the transport
> > (e.g., RDMA) signals support, set the NFS_CAP_P2PDMA bit in the mount's
> > capabilities. This allows the high-performance Direct I/O path to
> > efficiently determine if it should allow P2P memory buffers.
> 
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index be02bb227741..f177cf098d44 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> 
> > @@ -725,6 +727,12 @@ void nfs_server_set_init_caps(struct nfs_server *server)
> >  		nfs4_server_set_init_caps(server);
> >  		break;
> >  	}
> > +
> > +	rcu_read_lock();
> > +	xprt = rcu_dereference(server->client->cl_xprt);
> > +	if (xprt->ops->supports_p2pdma && xprt->ops->supports_p2pdma(xprt))
> > +		server->caps |= NFS_CAP_P2PDMA;
> > +	rcu_read_unlock();
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_server_set_init_caps);
> 
> Is the transport even connected when the NFS client does this
> test? If it isn't, xprtrdma and the RDMA core have not chosen
> an underlying device yet.
> 
> Note that, even if this logic /is/ correct, if the transport
> connection is lost the transport will reconnect automatically,
> doing the RDMA CM dance again and possibly resolving to a
> different device. The NFS client layer will be none-the-wiser
> and the NFS_CAP_P2PDMA flag setting will be stale at that point,
> and quite possibly incorrect if the new connection's device is
> not P2P-enabled.
> 
> (Basically this is what happens when an RDMA device is removed).
> 
> So this detection has to be done as part of xprtrdma's connection
> flow, and it needs to set a flag somewhere in the rpc_xprt. The
> NFS direct I/O code path then has to look for that flag before
> choosing the mechanism/flags it uses for each iov iter.
> 

Ack. I agree, so should we start with an inital cap and then update it 
in the event of a transport change / disconnect? Or shall we populate 
the cap only when a transport is connected?

Thanks,
Praan

