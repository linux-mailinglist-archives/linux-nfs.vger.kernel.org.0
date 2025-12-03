Return-Path: <linux-nfs+bounces-16864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F89C9DEF4
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 07:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D9B04E07BB
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 06:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C423EA8E;
	Wed,  3 Dec 2025 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F8wGiO5r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E700136351;
	Wed,  3 Dec 2025 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764743575; cv=none; b=N6qIa+s4cyx/Yv137VIyrWuJDSJ4AaBp3vyacWNAr5Sw62l5PS2p5nnYtv0o3dHzOkP4MTNCczOfxCkws9eDfhp6fN9bh9q3OjP/cUYZqREY/W9MQj0mq5I+1t91kHy14HvY70isXMtRbdvcR9BTrjcOSxEvV5qEiM9W2FrCQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764743575; c=relaxed/simple;
	bh=ab7gVqHTJ9oQMaZ4q9PbW5zQpxxLw+jDBtOIyA+DiiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfnLBovrGoYbWNvLiPrH2EDhna5Ndt97fSBDt+vhpO/C5ro3xGm4SVHkriWEkDFQWAjcuE8kIhX93YRD+D64Lh1zR+Ad0/pn95DauvEdbpYHJVKO7fVrPAYcuHMLZFVI5gUVfarKofotT8qSZeQf3fM5H75TJGdzmdZpZTYcN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F8wGiO5r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Q4Celb0Cx2Ef9zOuXbWuPB02TdKRuUDQhXX/E0hzTrg=; b=F8wGiO5rIx9I1q6c0WA/BVfwN3
	bd+BHOgNkrenzt8HxD78dpAgvMlPdYNTOEnF7jWHWOn9Ik4wqJeqHAmezyLp4HvTbQejkgSEv4gZ1
	ALtTFMJ+sSlVqq7G1j7ChsF7dftanyMkZy9pNmKkAr8yAQCXVb10zQImRJraGgXlwQhfJuaaMPUEM
	gGkW4JwSY1ZipHGUuK7KURXoVrnTtpGtYZq2vZsyggFJ7NQvVR+9MB3BLTlK/hcbVdA1HNZrOJJ6w
	9Koc5yskuMqwn3iZEUYDfmEBuiURZF0OrIMc+6Pc4b0TY/ymmA7Zd53F2Kj8vBD983SupKJ+KXggT
	Itu26AkA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQgPz-00000006BvS-3O1l;
	Wed, 03 Dec 2025 06:32:51 +0000
Message-ID: <cd05ee0d-18ad-43ba-b1c7-9ddc8a9afff9@infradead.org>
Date: Tue, 2 Dec 2025 22:32:50 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] NFSD IO MODES documentation fixes
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux NFS <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Mike Snitzer <snitzer@kernel.org>
References: <20251203010911.14234-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251203010911.14234-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/2/25 5:09 PM, Bagas Sanjaya wrote:
> Hi,
> 
> Here are fixes for NFSD IO modes documentation as reported in linux-next [1].
> 
> Enjoy!
> 
> [1]: https://lore.kernel.org/linux-next/20251202152506.7a2d2d41@canb.auug.org.au/
> 
> Bagas Sanjaya (3):
>   NFSD: Add toctree entry for NFSD IO modes docs
>   NFSD: nfsd-io-modes: Wrap shell snippets in literal code blocks
>   NFSD: nfsd-io-modes: Separate lists
> 
>  Documentation/filesystems/nfs/index.rst       |  1 +
>  .../filesystems/nfs/nfsd-io-modes.rst         | 33 ++++++++++++-------
>  2 files changed, 22 insertions(+), 12 deletions(-)
> 
> 
> base-commit: fa8d4e6784d1b6a6eaa3911bac993181631d2856

for all 3 patches:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy

