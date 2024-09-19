Return-Path: <linux-nfs+bounces-6548-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 531D797C613
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 10:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193CD281E8F
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2D36134;
	Thu, 19 Sep 2024 08:41:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989C8198A30
	for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735296; cv=none; b=VTUhc6f7G2a1iM9ltvSZslmBCmlpeJzF7KOu0NfWBKB+hhBtp3AARxv9WLbV/71TPUqiC+ZXW/zeqQn8SXVNTfIrr5sNXE86Wjk0c+3N02srYQsBq+4+bjewojMFBwvxbxe06kZEzUhAsfBJkeH7WLHW1/WwBxzmC89zsoMKN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735296; c=relaxed/simple;
	bh=Ei8Bydk3fbQGAEo1dfHTjglWRXAVLc8m5LFOOyi+qYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xv7ec81m5cDciXhAYSpPVvGsuzgsdY/THLg1h/iZi7yWDtgnDc8KQRLf32FDnRdvzBbmEcV3XqnYuin/l1jZN78nfkkIRzqOaQPH6l9hzRvy4oc9eLeWFOphppSSZfxoxRRNpKkw3UDh2EaJvxFKoLXRkO/3Pth5YSxsh0eT2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 703721007;
	Thu, 19 Sep 2024 01:42:03 -0700 (PDT)
Received: from [10.1.26.35] (unknown [10.1.26.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0348D3F71A;
	Thu, 19 Sep 2024 01:41:32 -0700 (PDT)
Message-ID: <1d66e015-1ca7-4786-893c-9224ad0c7371@arm.com>
Date: Thu, 19 Sep 2024 09:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: simplify and guarantee owner uniqueness.
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
References: <> <02879298-7c13-41b0-a99d-1e0829a8886e@arm.com>
 <172670937352.17050.5443512085908242810@noble.neil.brown.name>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <172670937352.17050.5443512085908242810@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/09/2024 02:29, NeilBrown wrote:
> On Wed, 18 Sep 2024, Steven Price wrote:
>> Hi Neil,
>>
>> (Dropping the list/others due to the attachment)
> 
> (re-adding others now - thanks for the attachment).
> 
>>
>> Attached, this is booting a kernel compiled from 00fd839ca761 ("nfs:
>> simplify and guarantee owner uniqueness.") which uses an NFS root with a
>> Debian bullseye userspace.
> 
> This shows that the owner_id was always different - or almost always.
> Once it repeated we got an error because the seqid kept increasing.
> This is because the xdr encoding is broken.
> 
> Please apply this incremental patch and confirm that it works now.

Thanks, I've tested the below and I don't see NFS errors any more.

Tested-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> Thanks,
> NeilBrown
> 
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 1aaf908acc5d..88bcbcba1381 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1429,7 +1429,7 @@ static inline void encode_openhdr(struct xdr_stream *xdr, const struct nfs_opena
>  	*p++ = cpu_to_be32(28);
>  	p = xdr_encode_opaque_fixed(p, "open id:", 8);
>  	*p++ = cpu_to_be32(arg->server->s_dev);
> -	xdr_encode_hyper(p, arg->id.uniquifier);
> +	p = xdr_encode_hyper(p, arg->id.uniquifier);
>  	xdr_encode_hyper(p, arg->id.create_time);
>  }
>  


