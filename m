Return-Path: <linux-nfs+bounces-2019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F080E85986B
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 19:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79195B20DBB
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 18:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1987C6EB78;
	Sun, 18 Feb 2024 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ISdQ4O5u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624BA1E86B;
	Sun, 18 Feb 2024 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708279582; cv=none; b=l2tBgWxUqWCYDolO1I3b47cjM48SaPBfyGppwFldZDXsT+QEsomSVepnL3Tjq5aCvbB3YfeKpDZ0GuG3jzvcOC5Ju+DH1RSg4L0Ed8phWZ8oTP56+dGJN8r+it0lW3Pj4m09pOKec4CUlXCg4kUxIXGF1qj5vCKBawmJDO4Ru34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708279582; c=relaxed/simple;
	bh=u5+y9oI9AVN9aE1l3KrHl3HzVCIh5feOYrt/X/ZQ2sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5oj7DQuo0b/2dC/TbquyGPSYYlpNP9RJgik+3Giw/I0GXw37xrlQBNGMU73WHapPdFZdEcknqnFH0cohmzKNcCgvXm6cIdXST5lJGfxi6e+UrKbVGO8eMXNhv0n9N5hYEdkrG4zlxDJcZojghDHxymFjKZXs1TxaTeswo8syZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ISdQ4O5u; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [46.242.8.170])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9D7C140F1DC0;
	Sun, 18 Feb 2024 18:06:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9D7C140F1DC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1708279569;
	bh=KW4P3G5i9vLcFjWHy/0+GdaEaDc/+xMgKKN0udLRMcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISdQ4O5udkItjLi90MuDEm24FFFnxmGDgUJDhf57gxOdByqOID23b2mrQmTbx+NAg
	 QyjHJw27ZblTX5S6Scao06PXWIMhmU5Lae+RQYoDblVWd0bBrzi4X0rs7+4Flie9QS
	 sXGYOATB4qYmz7SV6Gu8k1aNo0Uy17AIQK6m2a54=
Date: Sun, 18 Feb 2024 21:06:09 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Aleksandr Burakov <a.burakov@rosalinux.ru>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, 
	linux-kernel@vger.kernel.org, Tom Talpey <tom@talpey.com>, 
	Olga Kornievskaia <kolga@netapp.com>, lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] nfsd: fix memory leak in
 __cld_pipe_inprogress_downcall()
Message-ID: <d6ac2546-cf4e-43c3-bc41-b62a61141339-pchelkin@ispras.ru>
References: <20240216134541.31577-1-a.burakov@rosalinux.ru>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216134541.31577-1-a.burakov@rosalinux.ru>

Hello Aleksandr,

On 24/02/16 04:45PM, Aleksandr Burakov wrote:
> Dynamic memory, referenced by 'princhash.data' and 'name.data', 
> is allocated by calling function 'memdup_user' and lost 
> at __cld_pipe_inprogress_downcall() function return

It is not actually lost. If nfs4_client_to_reclaim() fails and thus
returns NULL - this error case is already properly handled.

If nfs4_client_to_reclaim() succeeds then reference to the memory in
question is passed to crp->cr_name.data and crp->cr_princhash.data
correspondingly, and crp->cr_strhash entry is added to the list associated
with nfsd_net. In this case the memory is supposed to be freed by
nfs4_remove_reclaim_record(). See comment for nfs4_client_to_reclaim().

So I think the patch just introduces a double-free.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 11a60d159259 ("nfsd: add a "GetVersion" upcall for nfsdcld")
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> ---
>  fs/nfsd/nfs4recover.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 2c060e0b1604..02663484782d 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -850,6 +850,8 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
>  			kfree(princhash.data);
>  			return -EFAULT;
>  		}
> +		kfree(name.data);
> +		kfree(princhash.data);
>  		return nn->client_tracking_ops->msglen;
>  	}
>  	return -EFAULT;
> -- 
> 2.25.1

--
Fedor

