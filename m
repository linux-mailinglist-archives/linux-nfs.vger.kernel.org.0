Return-Path: <linux-nfs+bounces-15893-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA165C2B7E8
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 12:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17CD3B5E8C
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 11:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2E305074;
	Mon,  3 Nov 2025 11:45:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0D305076
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170312; cv=none; b=tHzu4HsdwCzYhEU/ZeNQuZ/NOAE9oFQBIJfznT29TXqnwNx7t530ss1hUKh2SD0bkWteKk7uZh/8pVM1kte1DwPbgzZP8tPDnIa60g+s18EzBrboG4W8YTnthoetejrbIpKfD5s8c4enM6rnYqrMtjhRorYHkkQyd0Y3F9oNRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170312; c=relaxed/simple;
	bh=XqB4zZ9KVfBvw6zlp32s/ae+W+8XLvoHxoL+i4fv9Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuM8obNJUXg4Fw0rktiLbPBBMNjaJMaJ7MOCyS8WIXAajP5Hxj/mMzMoWxww3mgS5SG3h0uc405IXEtddx02vnufORCUfzJ6iWzeX3AlFUP3AQBo6DogRIhj/784oXnoBrkAO33j+3PrZc1giWykh2/Dmvim+eImc85Cqw0x1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52A81227A87; Mon,  3 Nov 2025 12:45:01 +0100 (CET)
Date: Mon, 3 Nov 2025 12:45:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] NFSD: Do not fence the client on
 NFS4ERR_RETRY_UNCACHED_REP error
Message-ID: <20251103114500.GC14852@lst.de>
References: <20251101185220.663905-1-dai.ngo@oracle.com> <20251101185220.663905-3-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101185220.663905-3-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 01, 2025 at 11:51:34AM -0700, Dai Ngo wrote:
> NFS4ERR_RETRY_UNCACHED_REP error means client has seen and replied
> to the layout recall, no fencing is needed.

RFC 5661 specifies that error as:

  The requester has attempted a retry of a Compound that it previously
  requested not be placed in the reply cache.

which to me doesn't imply a positive action here.  But I'm not an
expert at reply cache semantics, so I'll leave others to correct me.
But please add a more detailed comment and commit log as this is
completely unintuitive.


