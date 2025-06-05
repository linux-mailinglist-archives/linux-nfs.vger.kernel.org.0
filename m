Return-Path: <linux-nfs+bounces-12119-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20083ACE8FB
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 06:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C80C188DF10
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 04:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D064217AE11;
	Thu,  5 Jun 2025 04:28:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2588842065;
	Thu,  5 Jun 2025 04:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749097722; cv=none; b=DyKW00iRyYyb0Go6BUSinMdOHgYyHBrHhl3ScIo/wqnYOmNql9eYHU1g0ikRhjaS5ip5U1EZK7hAQyeg6w2PbndfQbG/cPTA3U91hwENOOKWXLApH+LMlv40/m0oVY6O3xaGkubodUg/t9PCwnhskbI7cf8k3r9vywytsMlxmHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749097722; c=relaxed/simple;
	bh=2MGsmkciwCxIaAtGlkvT/KpYQKqj9us+j22Hpgiwc9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OX1KZjjnBz+601A3RBwbHh3WHxWHl/OmLqPKHp9LJHadPI0pzTskNlSdZEG6XM02h6wsdEWUGoi94slyX/KDbI0xhWDE7yDSI0HdJG4h+fTKl4eLupArMS7D/oTBpM3JAC7sS8nKOGWlrxc4hRP/Lt41Neg+VTQalI5006ym2P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E62668AA6; Thu,  5 Jun 2025 06:28:36 +0200 (CEST)
Date: Thu, 5 Jun 2025 06:28:36 +0200
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
Message-ID: <20250605042836.GB834@lst.de>
References: <20250603045021.GA8367@lst.de> <20250604182020.126258-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604182020.126258-1-kuni1840@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 04, 2025 at 11:20:17AM -0700, Kuniyuki Iwashima wrote:
> > So the simple scripted renaming was not worth it.  Maybe I misunderstand,
> > but based on the reading we should basically have about a handful
> > callers of the non-__kern variant left.  Or is it a lot more?
> 
> Yes, after this series, only 2 sock_create() left, one in sctp and
> another in core.

Sounds easy enough to rename then, and doing so is useful go guide
people away from it.

