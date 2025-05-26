Return-Path: <linux-nfs+bounces-11906-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1000AC3938
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 07:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691DD3AF584
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 05:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AE11624DD;
	Mon, 26 May 2025 05:32:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B372615;
	Mon, 26 May 2025 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237554; cv=none; b=d9S1slyiMrXRxwVCj3/61M7oAwfa72at8lowMW0Md/P4Y/7U5WfwYMSv+DoQo3qG6u9JUzcNW8WBzw1QlZSMWMGD+JKEmGY4Jh0B2irnW++I5t8FDhihWb4zhYR/aO1x4E5ihPNVC1GFyqMLs6e0NX6rccgrPPuPCeMqTV3HLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237554; c=relaxed/simple;
	bh=fMRkF8AfefPrI6NUZxCj3qwHPr4ein4h0Rz3CZPlDAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTJOcVfnOzBwlyhmpPE6PuQQ6K+XtS0ThuVNnEH9K3MurWh2irflnylYkvgpOLGM6WKArJgR+C+klWusv9M1NNNVw/pYMg1UGnexy4XiQ/si3Iu23BTuJtHPQxzHWz2XElGiX+ARC+WOqQO7z7MjanHGyhr/0YtwrBLvPKMW/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 494D968AFE; Mon, 26 May 2025 07:32:27 +0200 (CEST)
Date: Mon, 26 May 2025 07:32:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Message-ID: <20250526053227.GD11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com> <20250523182128.59346-4-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182128.59346-4-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 23, 2025 at 11:21:09AM -0700, Kuniyuki Iwashima wrote:
> Let's restore sock_create_kern() that holds a netns reference.
> 
> Now, it's the same as the version before commit 26abe14379f8 ("net:
> Modify sk_alloc to not reference count the netns of kernel sockets.").
> 
> Back then, after creating a socket in init_net, we used sk_change_net()
> to drop the netns ref and switch to another netns, but now we can
> simply use __sock_create_kern() instead.
> 
>   $ git blame -L:sk_change_net include/net/sock.h 26abe14379f8~
> 
> DEBUG_NET_WARN_ON_ONCE() is to catch a path calling sock_create_kern()
> from __net_init functions, since doing so would leak the netns as
> __net_exit functions cannot run until the socket is removed.

Is reusing the name as the old sock_create_kern a good idea?  It can
lead to bugs by people used to the old semantics.  It's also
not really an all that descriptive name for either variant.  I'm
not really a net stack or namespace expert, but maybe we can come
up with more descriptive version for both this new sock_create_kern
and the old sock_create_kern/__sock_create_kern?


