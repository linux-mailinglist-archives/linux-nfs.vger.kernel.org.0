Return-Path: <linux-nfs+bounces-2633-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95A2897B75
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Apr 2024 00:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9371528B0CE
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Apr 2024 22:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE04138494;
	Wed,  3 Apr 2024 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="d2Imvi/b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD89156987
	for <linux-nfs@vger.kernel.org>; Wed,  3 Apr 2024 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182303; cv=none; b=ksv9m8sidTKkdlyuZ3RL+edEBc/CVS7DTkq2cpbcHzRYKaXddDRQFPmZRSsxZMPn5PP3Qi/7DhxLig0LnHOYF23SV5HembnJuZGVSpkJNoP8mMhl6TTjOMvT/M4HKTzU+10bEcbAtdKrEovIW8OX/2t3y4uCMJ9O7XKeA1IimG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182303; c=relaxed/simple;
	bh=WIB6N0+ro9wwJRgZrFb3cmseapPM8ZIsPFiWTTuerxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNll+uwI3LRi9MTZ+63l0tsBtxhAKwlBdDOn/cjLUqoQN4aW0ApKhQYoMc9D8ISlm3gxb1haqAKOK6ESOog1DUZbxTjXt/awWh7+nSdQQgft+UBa78ZYUC7hOk6/dCpC2dXS4JEyr84+8Zc9Zbp03BP8nFR66n44dKkh8aFl8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=d2Imvi/b; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id rsjvr9SOus4yTs8pRrNKrB; Wed, 03 Apr 2024 22:11:33 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id s8pQrPpNLEKyls8pQrvWPA; Wed, 03 Apr 2024 22:11:33 +0000
X-Authority-Analysis: v=2.4 cv=Bombw5X5 c=1 sm=1 tr=0 ts=660dd415
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4VnFru8p6tJF5H7f7NqpSA==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=drOt6m5kAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=jdHS4qDDNQt1OS4QkXsA:9 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
 a=AjGcO6oz07-iQ99wixmX:22 a=RMMjzBEyIzXRtoq5n5K6:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WWVro7cWydSO/uOEVxaGOi3jrLoa0beeMTA3tm6Z6pg=; b=d2Imvi/bmi7TayGjpxTc9DFtEN
	EafRKSpi8ipQCngDq1nOFjts1a3KKiKH1BAwLu9Hdb7Xlq3u4BEM3qdlOnljHFhWwU1p/VhHsGg87
	K4hOpZ3FIfZTzWVdD9L8L0NAbTgQwhXVXvmM1hurvUXClBUXWgO76YcM5v+tGooBKgIg1UE+l8Ykr
	10bO0N/eYyvjAfhJqxM+XBuoUsFTvEB5j030dv35MkP7oS5Hm8F50DiuDhQd3uD6giaHCMtehHCN7
	BIs+qFl5Yx9HJbr29WpIdlE1e7NWmFrtcQ5b3A3QGg+pyf9vxlEV+pKBLqJm9lmrTE8tziaYnhg6A
	JFvYB/FA==;
Received: from [187.184.159.122] (port=22874 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rs8pP-002b0h-2c;
	Wed, 03 Apr 2024 17:11:31 -0500
Message-ID: <01167882-2e6c-4504-8c9e-825ecd268411@embeddedor.com>
Date: Wed, 3 Apr 2024 16:11:22 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Set file_handle::handle_bytes before referencing
 file_handle::f_handle
To: Kees Cook <keescook@chromium.org>, Christian Brauner <brauner@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240403215358.work.365-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240403215358.work.365-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.159.122
X-Source-L: No
X-Exim-ID: 1rs8pP-002b0h-2c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [187.184.159.122]:22874
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDTQdipf18cQHs43XsswBhylC1/xNK8OGTtS+IfflXxyouxxd53U3MCDmLD3TC4GmbjkPBl0QXtagyAk8RUJVagPMjuJ47joij6p1H6+Tkxya283Lxni
 TBU5CvIGK1dvcjyYVpUP92ncmjARvxzq6VvgROA+GsstKfiaC/a0pMcvseMkUYnhNRqxxqJjGr/O8e4PIckZqZ8Yqw7cfQAdvOU=



On 03/04/24 15:54, Kees Cook wrote:
> With adding __counted_by(handle_bytes) to struct file_handle, we need
> to explicitly set it in the one place it wasn't yet happening prior to
> accessing the flex array "f_handle".

Yes, which (access to `f_handle`) happens here:

  48         retval = exportfs_encode_fh(path->dentry,
  49                                     (struct fid *)handle->f_handle,
  50                                     &handle_dwords, fh_flags);

> 
> Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks for catching this!
--
Gustavo

> ---
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>   fs/fhandle.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 53ed54711cd2..08ec2340dd22 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -40,6 +40,7 @@ static long do_sys_name_to_handle(const struct path *path,
>   			 GFP_KERNEL);
>   	if (!handle)
>   		return -ENOMEM;
> +	handle->handle_bytes = f_handle.handle_bytes;
>   
>   	/* convert handle size to multiple of sizeof(u32) */
>   	handle_dwords = f_handle.handle_bytes >> 2;

