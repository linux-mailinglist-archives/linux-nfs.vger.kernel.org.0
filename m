Return-Path: <linux-nfs+bounces-13120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA45B08039
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 00:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF561C2716C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 22:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C277F291C19;
	Wed, 16 Jul 2025 22:09:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12EEACE
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703758; cv=none; b=Q/zL96VhaWkLBOklKRpllGELDJvn/twpo+0nN+2fKJZk5T661J4K3YyfcZBTqDZigMiBo4bDkLmqbOWNBNMgZCsO/gFYpts8dE2V0cIeOGRsWX1M60444sPVaEf7sDEz5JU5hqczrdftSPZrYuLlIevk00ubJOxkoXqY8H0uHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703758; c=relaxed/simple;
	bh=u0dEJiiUikGusMjAX+RbJZM9gTfc5MjfROK3iWr5RTU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WRntn9fEKnKUljGUIhBjlm5RoaJoEL+F0TWeLnRovHX3nySknEtgRISaMunz4OmyyhJCweL0Lm4UlutkU/q2iHbd+j0ylzolXhhgnqzt68WBqyfUwnGhkEOVU7A34j00LjR4KM1OXxyNjc63IimDKy4/K3i0SPcsJNvfBW6zEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ucAJK-002H7T-Gt;
	Wed, 16 Jul 2025 22:09:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Trond Myklebust" <trondmy@kernel.org>
Cc: "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix localio hangs
In-reply-to: <cover.1752671200.git.trond.myklebust@hammerspace.com>
References: <cover.1752618161.git.trond.myklebust@hammerspace.com>,
 <cover.1752671200.git.trond.myklebust@hammerspace.com>
Date: Thu, 17 Jul 2025 08:09:11 +1000
Message-id: <175270375199.2234665.7748991440226043304@noble.neil.brown.name>

On Thu, 17 Jul 2025, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The following patch series fixes a series of issues with the current
> localio code, as reported in the link
> https://lore.kernel.org/linux-nfs/aG0pJXVtApZ9C5vy@kernel.org/
> 
> 
> Trond Myklebust (3):
>   NFS/localio: nfs_close_local_fh() fix check for file closed
>   NFS/localio: nfs_uuid_put() fix races with nfs_open/close_local_fh()
>   NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file

That all looks good to me - thanks a lot for finding and fixing my bugs.

Reviewed-by: NeilBrown <neil@brown.name>

I'd still like to fix the nfsd_file_cache_purge() issue but that is
quite separate especially now that you've prevented it causing problems
for nfs_uuid_put().

thanks,
NeilBrown

> 
>  fs/nfs_common/nfslocalio.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> -- 
> 2.50.1
> 
> 


