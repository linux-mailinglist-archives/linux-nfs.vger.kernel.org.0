Return-Path: <linux-nfs+bounces-5899-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BB9963683
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 01:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAB71C21147
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007741AC433;
	Wed, 28 Aug 2024 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="xFvgCuNI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24756647
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889548; cv=none; b=nEk2hvspzIeN/61K+iFEzQCeoVz0OXnJSpeOnfckItSnc/JGWClPFlJAHlB+rZJep663bV96qpkBfEzz4HAB6d/H9p8eejYD29iZQD8/MCiimT1mJ7zzhSA1jEFgvC7zjdB8V2H6oa7LPglal0hQZbVlMm091q7fNtNQ77Kru+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889548; c=relaxed/simple;
	bh=HMYfC/hI9S7Sen9hqERBXwkm2HY3AHiQThzMVQy+2nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtazsNwnURLGHp6ATyDLyfVTf7ZuqB6X83tlMAQQ8eZXIP8MWOPy5SdnpxK/RJ3GXylHknt6Kqp50vKHiM36Ao7d1Vf8Lg7fZSYjTlyI8OgK25iY+WV95Hsj3TOl2mA76N6a4UxJEcp2HgW9Ugbd+Xs2Fk0bVimh3NdZENcVQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=xFvgCuNI; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id jNaTsado6qvuojSZ2sh5nv; Wed, 28 Aug 2024 23:59:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id jSZ0szNXRX56wjSZ1sA2F2; Wed, 28 Aug 2024 23:58:59 +0000
X-Authority-Analysis: v=2.4 cv=MY6nuI/f c=1 sm=1 tr=0 ts=66cfb9c3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=7T7KSl7uo7wA:10 a=ZI_cG6RJAAAA:8
 a=VwQbUJbxAAAA:8 a=G7Ig5-h-x50up4Ig-zsA:9 a=QEXdDO2ut3YA:10
 a=CiASUvFRIoiJKylo2i9u:22 a=AjGcO6oz07-iQ99wixmX:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gwdyghKD5k5c4CmERZykpZYJC0ag0Sw3dcYPpvLrdIM=; b=xFvgCuNIWC/Sg1fvGEywaCv1mi
	iYaQCsEvOtKAzDiYAKtDkWBpKYp7CnJ4+4d4TTDo4I+alED8eaP9S2hrhlI4Ovgw+Snq40TPCLCy8
	nBv2gnEtiXixU4AfjYjLRo6YEqkRRr3X0WJtVl9beaU/rCH4iG+UOsWy5rLMCGjiQC0mX+k5/9W2u
	tLQoeq7Es0zmm/qtkcdXxPX5BvDOucjJvQM+cE1J+TKrAq/w6Fm3USeZ0roXQvd87rnzjblrpOsM5
	5XFMQteyzyX2aZG733D7NRsmHE/g8vU/PPeslFlm/bqOz82QHa/956dNNgyF/NPXah5IZnNA4IELL
	bm7NNutw==;
Received: from [201.172.173.139] (port=35262 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sjSZ0-003R6C-0Z;
	Wed, 28 Aug 2024 18:58:58 -0500
Message-ID: <bde519c9-c95d-4275-a89b-50e628446206@embeddedor.com>
Date: Wed, 28 Aug 2024 17:58:56 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSD: Annotate struct pnfs_block_deviceaddr with
 __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
 tom@talpey.com, kees@kernel.org, gustavoars@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240828214254.2407-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240828214254.2407-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sjSZ0-003R6C-0Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:35262
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI0EJFYgr739tznYI7zLNClq0EzSgAm5HXUDqUiZSsc5RAu1+DflNGWIn+sTb/q32wC6ZTrq/TEQGy752RV7YhcV1CsmHSUSmjllfXwmJqEsqlzIFFuI
 cYwTt0jYsPB0Af8cTYxEzRQMt6BU0erEPuyQn1xlhDc+s1ymztQ5YgeoJB0xotSEjEtflZ5yGKURrcHFezDnmAoovyhic/VC180=



On 28/08/24 15:42, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> volumes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Use struct_size() instead of manually calculating the number of bytes to
> allocate for a pnfs_block_deviceaddr with a single volume.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Looks good --`nr_volumes` is updated just before accessing `volumes[]`.

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   fs/nfsd/blocklayout.c    | 6 ++----
>   fs/nfsd/blocklayoutxdr.h | 2 +-
>   2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 3c040c81c77d..08a20e5bcf7f 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -147,8 +147,7 @@ nfsd4_block_get_device_info_simple(struct super_block *sb,
>   	struct pnfs_block_deviceaddr *dev;
>   	struct pnfs_block_volume *b;
>   
> -	dev = kzalloc(sizeof(struct pnfs_block_deviceaddr) +
> -		      sizeof(struct pnfs_block_volume), GFP_KERNEL);
> +	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
>   	if (!dev)
>   		return -ENOMEM;
>   	gdp->gd_device = dev;
> @@ -255,8 +254,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>   	const struct pr_ops *ops;
>   	int ret;
>   
> -	dev = kzalloc(sizeof(struct pnfs_block_deviceaddr) +
> -		      sizeof(struct pnfs_block_volume), GFP_KERNEL);
> +	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
>   	if (!dev)
>   		return -ENOMEM;
>   	gdp->gd_device = dev;
> diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
> index b0361e8aa9a7..4e28ac8f1127 100644
> --- a/fs/nfsd/blocklayoutxdr.h
> +++ b/fs/nfsd/blocklayoutxdr.h
> @@ -47,7 +47,7 @@ struct pnfs_block_volume {
>   
>   struct pnfs_block_deviceaddr {
>   	u32				nr_volumes;
> -	struct pnfs_block_volume	volumes[];
> +	struct pnfs_block_volume	volumes[] __counted_by(nr_volumes);
>   };
>   
>   __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,

