Return-Path: <linux-nfs+bounces-15835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC442C241D7
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 10:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DDB3BE789
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 09:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22AD32E136;
	Fri, 31 Oct 2025 09:13:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA8283FCE
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902022; cv=none; b=WW6tPNM9+X4C8FQRHI6lVsy6V1ICsTHE/wLJHwiJKKLi9/C4ZTlAttslDd4I/a/2pH/IyQ8kG455KveIVlrzzmWHp0/vQvsPw+5bxEn01EC0Nnvbg8jjdBa+uD0aKC0RpRZ1fwlm/ZxHD8tDHX3L/l6iSKFBTms90lPrRtztT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902022; c=relaxed/simple;
	bh=2qJjaGPHqyW8p1dVc45xhUZ0UHDhp7nVFiZxfM+niHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7HFMlxMkTCHrVoxbK/u/VKFrlWqvQBRXFg5zdrYppdDQEZIcWsRtpHrvO9szvasmp8pbQF4674G3MwqmUCK1kQD75CsDxc0z7s/Tl7P2AE6BYT9foAz0BwaIh6ajjwqezqP57gFlWwnKgY0ohF8Dh4/6RQum6oKq43ZFwTzo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DAF71227A88; Fri, 31 Oct 2025 10:13:36 +0100 (CET)
Date: Fri, 31 Oct 2025 10:13:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 09/12] NFSD: Handle both offset and memory alignment
 for direct I/O
Message-ID: <20251031091336.GA9475@lst.de>
References: <20251027154630.1774-1-cel@kernel.org> <20251027154630.1774-10-cel@kernel.org> <6dcab1145acd85e0d07c11ac09ba5d7e429a364e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dcab1145acd85e0d07c11ac09ba5d7e429a364e.camel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Jeff,

I've been trying to read your various replies, but could not find any
text after scrolling down a few pages.  Please fix your mailer to avoid
fullquots, and until then I'll have to ignore them.


