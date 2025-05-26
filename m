Return-Path: <linux-nfs+bounces-11904-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BCDAC391D
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 07:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87683A48F5
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 05:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66131C3BE0;
	Mon, 26 May 2025 05:29:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C34136349;
	Mon, 26 May 2025 05:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237354; cv=none; b=B7BQok7YMx75PYt6rVK3hftbHCGZZCUmrnqrfENZka1VCIvSxGSFLWrsBMRLqSqHURLJ5q7+dO/3B//DXvWaoce8XjJAS2wSf4pMVucDiotnaU6wh92Ygz/RrFnfB8EWocuBIvFZV7IbV4HZhMtSdvXUkZsQ74c0RLgkLjtZKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237354; c=relaxed/simple;
	bh=c5kCNwzp7mRb4bVIduIDpbFy9A0+F11PkLSgJFti7Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dflJ8ZTzNBBA0Eo+0SLy1YbEVgpVUW1IsUZDTZY1e/MiKfgyE5YMMmt531Q5sdKQB7DRPRzocrhaHk9VSDORG9MN8fIVzjlGVaw3jLwKSmiaIuurY7oQ6Uia64ljqCJCYuDKehDyCqd3Dj07nQ+fvSshxi87hcfbeKlMQO9TfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DF8068AFE; Mon, 26 May 2025 07:29:07 +0200 (CEST)
Date: Mon, 26 May 2025 07:29:07 +0200
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
Subject: Re: [PATCH v2 net-next 1/7] socket: Un-export __sock_create().
Message-ID: <20250526052907.GB11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com> <20250523182128.59346-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182128.59346-2-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 23, 2025 at 11:21:07AM -0700, Kuniyuki Iwashima wrote:
> Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
> sock_create_kern"), we no longer need to export __sock_create()
> and can replace all non-core users with sock_create_kern().
> 
> Let's convert them and un-export __sock_create().

The changes looks good, but the commit log including subject line
is rather confusing.  What you do is to replace all uses of
__sock_create with sock_create_kern, which works because
sock_create_kern just calls __sock_create with the last argument set
to 1 as those callers do it.  This then allows marking __sock_create
static because all outside users are gone.

Please state that, i.e.

Subect: use sock_create_kern insteadf of opencoding it

Replace all callers of __sock_create that set the kernel argument to 1
with sock_create_kern, which is the improve interface for that.
Mark __sock_create static now that all users outside of socket.c
are gone.


