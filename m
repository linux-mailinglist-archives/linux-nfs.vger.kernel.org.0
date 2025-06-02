Return-Path: <linux-nfs+bounces-12018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3DBACA8C3
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 07:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4570189AB8C
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 05:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8267170A37;
	Mon,  2 Jun 2025 05:08:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2144C63;
	Mon,  2 Jun 2025 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748840939; cv=none; b=IG/ug4378HemN5xpIZgrXJGsTEIgoCk9X3RsZ9PoJe/sRa6b3rbfdytlUqvWCBBC1dJzEbEVO4poN7tn4fmM1ZKz+FbHB2VyZTV2xfSziJw8OYVc0Akx/XhhRlj8EHm+Ib0t7Ryqqs/iJgkDoZZih9tioyZZ/MMWrGOABXAOq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748840939; c=relaxed/simple;
	bh=yzrom5iPYKdwUyT5O0sBeYff4RBxymZlVqu8qXgaEAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtaFCTsCR03Vyj758/1ctcPzXzsy/upNrJbT53iBitYxxxekcLAUkN8uh4tYti2UCyrP08Xs0JTamfzVd0kGYo1GfxGNv1Uc3G3SPwF+5xJBGW1YNU/8jrVsbqg0asGayQLqsllG1O4eB+74tNVxQDbcVRP7nlPCd7uYLlLBsaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D39F68D0D; Mon,  2 Jun 2025 07:08:54 +0200 (CEST)
Date: Mon, 2 Jun 2025 07:08:54 +0200
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
Subject: Re: [PATCH v2 net-next 5/7] socket: Remove kernel socket
 conversion except for net/rds/.
Message-ID: <20250602050854.GB21900@lst.de>
References: <20250526053321.GE11639@lst.de> <20250530025937.3214873-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530025937.3214873-1-kuni1840@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 29, 2025 at 07:59:33PM -0700, Kuniyuki Iwashima wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 26 May 2025 07:33:21 +0200
> > On Fri, May 23, 2025 at 11:21:11AM -0700, Kuniyuki Iwashima wrote:
> > > Let's drop the conversion and use sock_create_kern() instead.
> > 
> > Please send a patch per subsystem that is converted to make the
> > commit log better and help with bisectability.
> 
> Do you mean splitting this patch into per-subsystem patches
> within the same series or sending non-netdev patches separately ?

Please send them in the same series for now.  I think they can go
in together, but without splitting them out it's hard to even get
all the reuqired attention.


