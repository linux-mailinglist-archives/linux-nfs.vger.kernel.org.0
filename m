Return-Path: <linux-nfs+bounces-12065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D447CACBF59
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 06:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F42A3A4A1E
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 04:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12D18FC91;
	Tue,  3 Jun 2025 04:50:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043872631;
	Tue,  3 Jun 2025 04:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926229; cv=none; b=CEKfkmmX5eYgIBW5GCkEMT353WAe2MdUhgFuxOI/0myCyvVytC07q4NnInosmf0S73xDl4imuMbLHREogYe/lcVMHcFGYLQj4weyk/lhGlyt6H3G75I2RyNkEIVcARac1aj1PZHpuZ4/LAF45No5KTJXjf9UVblPvozEqBYP0VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926229; c=relaxed/simple;
	bh=u90nOkhWzrRxs5VJ6WUhA3H3LIjV1LJj9WX3+NpQjLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCFTspXESyEDthCHgJl9Gdlb7aQ6OpYPqrIhgUvBpY2A6qlI5i/7ebbRO/QR2u9tbeyD8wPYK50DKmlGJHOdWQMFCSRGhHauAiGDUVb0xwKOWJCongJEPWTOwH9Mck6ChiirFP6FkRkf6sa0cPC1jynsd6PP8aiTtqHQLR1soGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F14468C7B; Tue,  3 Jun 2025 06:50:21 +0200 (CEST)
Date: Tue, 3 Jun 2025 06:50:21 +0200
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
Subject: Re: [PATCH v2 net-next 6/7] socket: Replace most sock_create()
 calls with sock_create_kern().
Message-ID: <20250603045021.GA8367@lst.de>
References: <20250602050949.GA21943@lst.de> <20250602215314.2531309-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602215314.2531309-1-kuni1840@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 02, 2025 at 02:52:47PM -0700, Kuniyuki Iwashima wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 2 Jun 2025 07:09:49 +0200
> > On Thu, May 29, 2025 at 08:03:06PM -0700, Kuniyuki Iwashima wrote:
> > > I actually tried to to do so as sock_create_user() in the
> > > previous series but was advised to avoid rename as the benefit
> > > against LoC was low.
> > 
> > I can't really parse this.  What is the 'benefit against LoC'?
> 
> It was a kind of subjective opinion whether the amount of changes
> was worth or not.

So the simple scripted renaming was not worth it.  Maybe I misunderstand,
but based on the reading we should basically have about a handful
callers of the non-__kern variant left.  Or is it a lot more?

