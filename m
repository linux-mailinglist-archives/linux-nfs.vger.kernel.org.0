Return-Path: <linux-nfs+bounces-2399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6874E88028D
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 17:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23825285537
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A24C8E1;
	Tue, 19 Mar 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Bjc+xpQA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276EF9E4
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866473; cv=none; b=Kymcejy//AcGb0mcrqa00Glnp8ljDqYkGytCN7mJ3EW3Fqg0piAL5Q7rgI7i1VxUQbJyMuByHElmeRckw/CQVyBlAlKavxdD+uXPNZclUT06q12rgSLjrwdCxhA+NAg53jkMX+x6K4m4oi3f4jssaPXaBiaSmlftb75W0OTCmAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866473; c=relaxed/simple;
	bh=nRp7+YyTBHw31NX7xj7EtsXhg3dkAR+p6w1ZMt+sOEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThEpqmgwh85lGDivYXOnw1GbijIkET8zgTgFNC7ANOMoAyn1Dcr6FhulTKQMdkgphbhmzfnXCc6/sY0QBYN5xhOcsZ4LmkFG7TnWAS/l7XadJNGxcqoT+JOmuFUtAL8Ph4fYHdTYepw0yhKUv7jyRjoKOLWCqh7KHbyTrsCesKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Bjc+xpQA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56ba6e3c3e8so361492a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710866470; x=1711471270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=931BN8XdKyOBXgviRQCefbI6odUP2QsuOngK2FvcTOs=;
        b=Bjc+xpQAwY3z3fbUSs5mWFZqOgAsXiWOfTt2fETf32xVt5LGMFFT8BlXOVa1nShF4e
         u3hKGCc3sXooS8tjsd1KJrhLeAY0AsQHmlDDydrwglGH1JSvNWnPALsWFn98NxkI4Uc4
         VoScTVzsNWKZM++T29YZIQ9ySLCKZz1WGzusQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866470; x=1711471270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=931BN8XdKyOBXgviRQCefbI6odUP2QsuOngK2FvcTOs=;
        b=OxDE97UW1mT7nTrLhuB6LB2762B8h1bNJpy/UWDoxJQwvfwouDg8ApiYlwWDi5kU4u
         ttz8sAGrR3DFtdv1T3UviI6iNogDxnoJ/UW+n0nACBGW8fJFqPJimuPltCHTr/tUSCHm
         EnpKQ5zC07Dx3c4sFkUoVySIwBMfIIaT3clEVe3qdX9H0DdButYN8PbLCTRZACh6SEBM
         zRLc0o4asMDVohxkyXQlOFKNYUsDuSeJbuWhJM7nQhU3w2M7Q2Z6w5+k0wXgOhtemJg0
         02eECAH5QUVOEULECV3rsdnY3NeO612ScBoYomZFUShQDnr4SLisjARNd1NLaoGhIZ2J
         xNBg==
X-Forwarded-Encrypted: i=1; AJvYcCVlCuaE5LjKrxHiYVQrV4ihKeCpwAhdUy+l9I2urelkhwL38hA0wgJr3pfr5Gpvwbm96H3hOi5X57+hQF9nU9i5vIiOuA7fpc4J
X-Gm-Message-State: AOJu0Yz+t0Wl7o/4RFf0pDpGrGoBOz7D5FzqHD29F4Fyq/64yT73Z5PN
	pi+J00AGd+bS+64Oi5ji6chBKgfdALh+2Y6EpwPuaCPqb1ZjjGdi6SDncDsqrr9MscM9unCp+vw
	lc3dr+lz4+JlMEaM8vJVOYVefvR/UMNcgU7e9Tg==
X-Google-Smtp-Source: AGHT+IFDeEEaIOtSBG5DGppYGHWRw4rXZqpgILKwzYCMW4SSXhcYWj+KFRDuw5xeuXxFLrQ0w0/J7Jaydr+ESekL/l8=
X-Received: by 2002:a17:906:70c9:b0:a46:6bb8:1ec4 with SMTP id
 g9-20020a17090670c900b00a466bb81ec4mr8429584ejk.76.1710866470240; Tue, 19 Mar
 2024 09:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1668172.1709764777@warthog.procyon.org.uk> <ZelGX3vVlGfEZm8H@casper.infradead.org>
 <1831809.1709807788@warthog.procyon.org.uk> <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
 <651179.1710857687@warthog.procyon.org.uk> <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
In-Reply-To: <CAJfpegsUYUwp2YNnCE3ZP+JtL0whgQ=3+wcsBABGXH9MjXC0zA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Mar 2024 17:40:58 +0100
Message-ID: <CAJfpegsCBEm11OHS8bfQdgossOgofPcYhLTFtw7_+T66iBvznw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	netfs@lists.linux.dev, v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 17:13, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 19 Mar 2024 at 15:15, David Howells <dhowells@redhat.com> wrote:
>
> > What particular usage case of invalidate_inode_pages2() are you thinking of?
>
> FUSE_NOTIFY_INVAL_INODE will trigger invalidate_inode_pages2_range()
> to clean up the cache.
>
> The server is free to discard writes resulting from this invalidation
> and delay reads in the region until the invalidation finishes.  This
> would no longer work with your change, since the mapping could
> silently be reinstated between the writeback and the removal from the
> cache due to the page being unlocked/relocked.

This would also matter if a distributed filesystem wanted to implement
coherence even if there are mmaps.   I.e. a client could get exclusive
access to a region by issuing FUSE_NOTIFY_INVAL_INODE on all other
clients and blocking reads.  With your change this would fail.

Again, this is purely theoretical, and without a way to differentiate
between the read-only and write cases it has limited usefulness.
Adding leases to fuse (which I plan to do) would make this much more
useful.

Thanks,
Miklos

