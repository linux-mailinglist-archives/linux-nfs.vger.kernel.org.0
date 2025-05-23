Return-Path: <linux-nfs+bounces-11868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBFDAC1AEE
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 06:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005163B3A1E
	for <lists+linux-nfs@lfdr.de>; Fri, 23 May 2025 04:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C6221DB6;
	Fri, 23 May 2025 04:23:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48DF204096;
	Fri, 23 May 2025 04:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747974193; cv=none; b=T+FpvxUqojosTXypbW/2eKyaX+UEJfA3tKPKxKGCdV+PrYkJ9pki7g0j1S5AckpFgEmDj4bZljlm/q9a2wlprp7hcHEvm467Kv6PvBMpHlpXAXWDAlEHn2paRcuQHMIOjCP1/nG0O2BowSComgVuM1ljVeTxZxWlbuy7xVvCEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747974193; c=relaxed/simple;
	bh=6eJZWbtERZJB88Pd/u5AKxzzQUN61sU2ou0z+3xai9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQjgv+jKRywlMVki3+dLo7u1BTsySlGOWm65pVRjAXA42IBolN5MSav0utSKTXgS8nOG1W+Oxkx97BIEUGEyFylyGgHij3BxQAgKEBgViQw5Zo7lhE5X0rmKb87Usa/+BWzF9Bw6IIViKPA1KZFnZ4SvcQcavAtozZADUr0IaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E183567373; Fri, 23 May 2025 06:23:06 +0200 (CEST)
Date: Fri, 23 May 2025 06:23:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	linux-nvme@lists.infradead.org,
	Matthieu Baerts <matttbe@kernel.org>,
	MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH v1 net-next 4/6] socket: Remove kernel socket
 conversion except for net/rds/.
Message-ID: <20250523042306.GB6344@lst.de>
References: <20250517035120.55560-1-kuniyu@amazon.com> <20250517035120.55560-5-kuniyu@amazon.com> <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 22, 2025 at 10:55:47AM +0200, Paolo Abeni wrote:
> https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/#t

Kuniyuki, please resend this with linux-nvme included to allow for
easy reviewing, for which lore unfortunately is not very useful.


