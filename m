Return-Path: <linux-nfs+bounces-7856-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 425479C414F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 15:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70D01F225A3
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9230A1BC58;
	Mon, 11 Nov 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKm+vjkJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED01E481
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336993; cv=none; b=dKdkVzsljK3ucXBbSLsux5pGw+7BP5w6KJwvMI/gFP4+B5Wj2sA6wxCqoY0p3XnryrvbEEsgD/N4UAiDSVm2TIcjSWAMfVz2JMK3lG5TGYBPMjGGrQ2JU9ik4zJi6tijHBX3A1g+m2zKXwMBu3WvvMzEx1i9Nc82wIWByQYu2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336993; c=relaxed/simple;
	bh=+kX4NZBvK82p8QY0+zmG42Vh9m3Z7c/7fNxZwuVEdXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBVkJUSKC/Z7IK2QYBk7sOm5Y1/Zp8Slejdq2/l57I2b+gbd/LaYzIa22+SDILLKoZT5ecQOHsNsqe0X6gY+rzXmK8HYk2E3bczOJGzxRN5bjbR/wu8IHaRzmwYCy7AjgdI/mvueWUbKXHytNoJt/yoabhHZe7pSGKrY3Sp1YQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKm+vjkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6B6C4CECF;
	Mon, 11 Nov 2024 14:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731336992;
	bh=+kX4NZBvK82p8QY0+zmG42Vh9m3Z7c/7fNxZwuVEdXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKm+vjkJai9Oyvnm75KelYT1/XXJiWniJBJBv9Dw8N2ZSQB8OpBbicZz0QY9uRn9/
	 bvN62wybc3bouG4U9nixd6ZyfcJOKhsqfD3v0WBzrITSfNXAscmOjcXQtWIt4Tl6bL
	 Ge2kqxW3RiVWe9pzFvapr+zXSLVc6zLly3Eo1/T9WlxrPQE+HCzoFRcvnqQuY3KVyN
	 HYC7Hj3xZ7155N+ssgrgJRVD4nxK/9XIkzVufKPjayTEo4T4zLC/xsHsRNADSVu18R
	 M3M10eJA0UPjY1lIk1EwivHMiNJTG9Y5InSBBsV4YyAhxf0eZBTj2T73FCRGrv5boC
	 S98k/wwQz/W9w==
Date: Mon, 11 Nov 2024 09:56:31 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [bug report from fstests] BUG: sleeping function called from
 invalid context at fs/nfsd/filecache.c:360
Message-ID: <ZzIbH03ILpAIADHq@kernel.org>
References: <20241111125711.7ux6eywuk7nxo5hl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <d6dcf462ab4cb1fa3fd8393bb607ad2205d4ff09.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6dcf462ab4cb1fa3fd8393bb607ad2205d4ff09.camel@kernel.org>

On Mon, Nov 11, 2024 at 09:02:38AM -0500, Jeff Layton wrote:
> On Mon, 2024-11-11 at 20:57 +0800, Zorro Lang wrote:
> > Lots of fstests cases fail on nfs, e.g. [1]. The dmesg output as [2].
> > I tested on linux v6.12-rc6+, with HEAD=da4373fbcf006deda90e5e6a87c499e0ff747572
> > 
> > Thanks,
> > Zorro
> > 
> 
> This looks wrong:
> 
> static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)                            
> {                                                                                                   
>         /*                                                                                          
>          * Once reference to nfsd_serv is dropped, NFSD could be                                    
>          * unloaded, so ensure safe return from nfsd_file_put_local()                               
>          * by always taking RCU.                                                                    
>          */                                                                                         
>         rcu_read_lock();                                                                            
>         nfs_to->nfsd_file_put_local(localio);                                                       
>         rcu_read_unlock();                                                                          
> }    
> 
> nfsd_file_put_local() calls nfsd_file_put, which can sleep. What
> exactly is the scenario that you're guarding against with the RCU read
> lock?

nfs_to lifetime vs nfsd unload.  But anyway, this was fixed in the 2nd
patch of my recent LOCALIO series that I posted on Friday, see:

https://lore.kernel.org/linux-nfs/20241108234002.16392-3-snitzer@kernel.org/

Would be good to get this in before 6.12 final (Neil gave his
Reviewed-by last night).

Thanks,
Mike

