Return-Path: <linux-nfs+bounces-12019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9DAACA8C7
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 07:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7383B5024
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 05:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A583B17A303;
	Mon,  2 Jun 2025 05:09:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490614885B;
	Mon,  2 Jun 2025 05:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748840994; cv=none; b=HRjvDLrIWQsxe/+fMyN9IR6hzh8ZyzqYXJmapkD3+JWtVCpUM83y2jyH9ZId4hip+IVRnjpYo6RQwy9+2PqnOi8Iasrpcr8Zp+QHnc4AACOuVaUMB3yASQhLmWS4in9c0smo0BUy107NHzdBf1ksCEmrK8cNXSssQV92hmzzcWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748840994; c=relaxed/simple;
	bh=E1p7UkyRJ0iYWkz1qzjrSokLw/WovlvkB9nMobt64C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHPTszWfzD2R5eEPhyOxi5/0aw1D+RqL/ZxEtykJr+XQCzrIK85kSjVpvTU6nxugzc4KnXN1x8ZRHpgqO/CMhE7aJZX7WWM1BVdQliO6jvW6ACGUkeV4t/muMTS1zcb/KJ1YempIZtskzgfET1PaG1jZrgC+fjS5k8R3SAh3Ar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8509768D0D; Mon,  2 Jun 2025 07:09:49 +0200 (CEST)
Date: Mon, 2 Jun 2025 07:09:49 +0200
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
Message-ID: <20250602050949.GA21943@lst.de>
References: <20250526053555.GG11639@lst.de> <20250530030308.3216933-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530030308.3216933-1-kuni1840@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 29, 2025 at 08:03:06PM -0700, Kuniyuki Iwashima wrote:
> I actually tried to to do so as sock_create_user() in the
> previous series but was advised to avoid rename as the benefit
> against LoC was low.

I can't really parse this.  What is the 'benefit against LoC'?

