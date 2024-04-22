Return-Path: <linux-nfs+bounces-2923-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E7F8AD8A4
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 01:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D91B282BC6
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A28A1BF6FA;
	Mon, 22 Apr 2024 23:01:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D51CF9B;
	Mon, 22 Apr 2024 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826891; cv=none; b=DDatGKEw7uAXEIVtrybmQMckoTWGDzihixYS/v/yGc9TSvd7fnId5ylHNe0tES6PlLYvPYeJfAFkJDFQ9TK2tV4UWDZXhoLaCX9mx7A/qNQN+GXN0vNS7DcRxsurZK8N1ZIdC0if0RAgtG8J1rukKqT/Iz+VVpbkCWInIkNF/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826891; c=relaxed/simple;
	bh=Kn/X7LXt1iZwCxzFJZ37XYQ5DBemw1641eh3Gy1yxh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNL/r37CzvumY7/JasIFynS8r5GOYkBQ7Hi4hDyrRIbWTbvBLv9zs+ZKE/5dPsEK02XsLtkg+o7qQ5UUIapAyalgCunax6svzN00iV1EX26dfro+U6CVxYB8lPe4/9adwq6rU1oPbnYAAjN902f0Hl9D+NPZ60MKX1k0jzd0BrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.96)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1rz2ER-000ZXO-02;
	Tue, 23 Apr 2024 00:33:51 +0200
Date: Tue, 23 Apr 2024 00:33:50 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Jeff Layton <jlayton@kernel.org>
Cc: Anna Schumaker <Anna.Schumaker@netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
	Josef Bacik <josef@toxicpanda.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nfs: keep server info for remounts
Message-ID: <ZiblzgAJ5M38dPh8@akranes.kaiser.cx>
References: <20240414170109.137696-1-martin@kaiser.cx>
 <d12c4998028014829713093ceccdbb521e34f05c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d12c4998028014829713093ceccdbb521e34f05c.camel@kernel.org>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote Jeff Layton (jlayton@kernel.org):

> On Sun, 2024-04-14 at 19:01 +0200, Martin Kaiser wrote:
> > With newer kernels that use fs_context for nfs mounts, remounts fail with
> > -EINVAL.

> > $ mount -t nfs -o nolock 10.0.0.1:/tmp/test /mnt/test/
> > $ mount -t nfs -o remount /mnt/test/
> > mount: mounting 10.0.0.1:/tmp/test on /mnt/test failed: Invalid argument

> > For remounts, the nfs server address and port are populated by
> > nfs_init_fs_context and later overwritten with 0x00 bytes by
> > nfs23_parse_monolithic. The remount then fails as the server address is
> > invalid.

> > Fix this by not overwriting nfs server info in nfs23_parse_monolithic if
> > we're doing a remount.

> > Fixes: f2aedb713c28 ("NFS: Add fs_context support.")
> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> >  v3:
> >  - rebased against linux-next from 12th April 2024

> >  v2:
> >  - rebased against linux-next from 26th February 2024

> > Dear all,
> > I'm resending this patch again. The problem that I'm trying to fix is still
> > present in linux-next. Thanks in advance for any reviews and comments.

> > I guess that we're taking this path for remounts

> > do_remount
> >     fs_context_for_reconfigure
> >         alloc_fs_context
> >             init_fs_context == nfs_init_fs_context
> >                fc->root is set for remounts
> >                ctx->nfs_server is populated
> >     parse_monolithic_mount_data
> >         nfs_fs_context_parse_monolithic
> >             nfs23_parse_monolithic
> >                ctx->nfs_server is overwritten with data from mount request

> > An alternative to checking for !is_remount_fc(fc) would be to check
> > if (ctx->nfs_server.addrlen == 0)

> > fs/nfs/fs_context.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)

> > diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> > index d0a0956f8a13..cac1157be2c2 100644
> > --- a/fs/nfs/fs_context.c
> > +++ b/fs/nfs/fs_context.c
> > @@ -1112,9 +1112,12 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
> >  		ctx->acdirmax	= data->acdirmax;
> >  		ctx->need_mount	= false;

> > -		memcpy(sap, &data->addr, sizeof(data->addr));
> > -		ctx->nfs_server.addrlen = sizeof(data->addr);
> > -		ctx->nfs_server.port = ntohs(data->addr.sin_port);
> > +		if (!is_remount_fc(fc)) {
> > +			memcpy(sap, &data->addr, sizeof(data->addr));
> > +			ctx->nfs_server.addrlen = sizeof(data->addr);
> > +			ctx->nfs_server.port = ntohs(data->addr.sin_port);
> > +		}
> > +
> >  		if (sap->ss_family != AF_INET ||
> >  		    !nfs_verify_server_address(sap))
> >  			goto out_no_address;

> Doesn't nfs4_parse_monolithic need the same fix? 

Sorry for the delayed response. It took me a moment to set up a test with nfs4
(busybox mount has no nfs4 support).

The nfs4 remounts do not fail for me. The mount syscall goes into
nfs4_parse_monolithic and 

   if (data->version != 1)                                                                                             
      return generic_parse_monolithic(fc, data);                                                                       

branches off into generic_parse_monolithic before the server address is
overwritten (this is what breaks nfs23).

Best regards,

   Martin

