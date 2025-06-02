Return-Path: <linux-nfs+bounces-12017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539A6ACA8C0
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 07:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360E63A67DD
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 05:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D625F150980;
	Mon,  2 Jun 2025 05:08:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789C2C3266;
	Mon,  2 Jun 2025 05:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748840904; cv=none; b=b8sIgE6szOdYWQGk6uXymwCSK/GZmndJ5YNqoWQDn9b7sEDQmiZiuiDsZGWGsQmG2UXRgP6fVxrlWAra1MUzYSTdnq3gb7pEPOdBfyRWzbbTsHw24vRWJNaicQZwUDKCJaC9k6/kZgZ0hWw0Xkgz2uBzPLQ0OTlTHlbUEXv3PuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748840904; c=relaxed/simple;
	bh=/khSDaQuzQ6CIf7NeRL4A2ijMe2HAkVY85ZYkN/uVrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McFcvJCIPrsn4NdopKwi2jXZ+dyTLk1fWchg5bJ98axflcNKbrZjdPG7nlwQGeAn/kkCQmbk52YvoTabg4hVRzFIgJEfL3AEiZ3kxsIzY0Vy0qKtzEUove81mAUxevDAYVSqNQCF/aqZpXrdXraZkBuS48uxbPMYUDoqFUtu5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2BB768D0D; Mon,  2 Jun 2025 07:08:17 +0200 (CEST)
Date: Mon, 2 Jun 2025 07:08:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, chuck.lever@oracle.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	jaka@linux.ibm.com, jlayton@kernel.org, kbusch@kernel.org,
	kuba@kernel.org, kuniyu@amazon.com, linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
	pabeni@redhat.com, sfrench@samba.org, wenjia@linux.ibm.com,
	willemb@google.com
Subject: Re: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Message-ID: <20250602050817.GA21900@lst.de>
References: <20250526053227.GD11639@lst.de> <20250530025401.3211542-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530025401.3211542-1-kuni1840@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 29, 2025 at 07:53:41PM -0700, Kuniyuki Iwashima wrote:
> In the old days, sock_create_kern() did take a ref to netns,
> but an implicit change that avoids taking the ref has caused
> a lot of problems for people who used to the old semantics.
> 
> This series rather rolls back the change, so I think using
> the same name here is better than leaving the catchy
> sock_create_kern() error-prone.

Ok.


