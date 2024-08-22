Return-Path: <linux-nfs+bounces-5579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D971495B817
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 16:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3583DB23D18
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674B31CB330;
	Thu, 22 Aug 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kA7BTrdu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91E11C9EA9;
	Thu, 22 Aug 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336089; cv=none; b=rsAEGvTvN4OZ/PmRPZ2uLkHB17MgTlFjH5Hafpl5rLSHjpDO9qPx5Fzy4YEReqRGszjF1NfkO12+YZq9aWJK3mPyKfeVO4POVNolMshbtL2vvqKDxQyoxQfNPP+bbEvXxIADVzMiarYQtMEjTxnmmFwA/f2JrKQhG+Oapw2Ymlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336089; c=relaxed/simple;
	bh=ABrQ7oZj7HItZ++KBBLZhaOKkO4dlFdYO8a2+1zZoVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLXaw3ubgmptyALBA8xQuSAQJMRjFFD/tOcppM58kVzTCVt6LIu/kM1yq1uPfAHGg/Rjs0coIGwwwTLzfHyB/fUhJSj1UWp9t5kynljCi9+prSWQHnS7H6c+NTNWoLC9X1m5bR9WPITaLbNQhcGs1lWpaMdDhVuE+CdTN+RGfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kA7BTrdu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=khZNhpNB80qRXc7XUBOgMYS3wq0hh9NWDosI/OczzUc=; b=kA7BTrduAgNWa07m
	sBvyovpgWpiK4VUq+CwvQO4Ra8y3ixBCaTUoVjcpT3vkCHjVk23/t9YZVnCHAg040+hPDTpI0YsJ/
	adtQVxIAUcVYY1kA0d4oI7xD/zeDLBKXZ8sxZH0xguCnsSeeG5Yz6dY10d3I1sn0sZgWTWeMaWxCq
	B5DDVxiW0tPlfXZdHxqUC3/vKEvU6BRVsP6RoRsovdXx8Z4Tph5VQ9KAicmWZop0rbREo4YdlV+Md
	BYfsuGjHMm5CN4OI518R9K+8LP1O+XOJ5iRb0Pib6RfD0EzMAwDF3vwyjjhtMZDqgmIHH/bpgjepa
	hCABFnv6O4zi3TbkTw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sh822-000sVD-1P;
	Thu, 22 Aug 2024 13:39:18 +0000
Date: Thu, 22 Aug 2024 13:39:18 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, marcel@holtmann.org, johan.hedberg@gmail.com,
	luiz.dentz@gmail.com, idryomov@gmail.com, xiubli@redhat.com,
	dsahern@kernel.org, trondmy@kernel.org, anna@kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	jmaloy@redhat.com, ying.xue@windriver.com, jacob.e.keller@intel.com,
	willemb@google.com, kuniyu@amazon.com, wuyun.abel@bytedance.com,
	quic_abchauha@quicinc.com, gouhao@uniontech.com,
	netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 1/8] atm: use min() to simplify the code
Message-ID: <Zsc_hiWX9uvg_Oep@gallifrey>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
 <20240822133908.1042240-2-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240822133908.1042240-2-lizetao1@huawei.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:36:47 up 106 days, 50 min,  1 user,  load average: 0.01, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Li Zetao (lizetao1@huawei.com) wrote:
> When copying data to user, it needs to determine the copy length.
> It is easier to understand using min() here.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  net/atm/addr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/atm/addr.c b/net/atm/addr.c
> index 0530b63f509a..6c4c942b2cb9 100644
> --- a/net/atm/addr.c
> +++ b/net/atm/addr.c
> @@ -136,7 +136,7 @@ int atm_get_addr(struct atm_dev *dev, struct sockaddr_atmsvc __user * buf,
>  	unsigned long flags;
>  	struct atm_dev_addr *this;
>  	struct list_head *head;
> -	int total = 0, error;
> +	size_t total = 0, error;

Aren't you accidentally changing the type of 'error' there, and the function
returns 'int'.

Dave


>  	struct sockaddr_atmsvc *tmp_buf, *tmp_bufp;
>  
>  	spin_lock_irqsave(&dev->lock, flags);
> @@ -155,7 +155,7 @@ int atm_get_addr(struct atm_dev *dev, struct sockaddr_atmsvc __user * buf,
>  	    memcpy(tmp_bufp++, &this->addr, sizeof(struct sockaddr_atmsvc));
>  	spin_unlock_irqrestore(&dev->lock, flags);
>  	error = total > size ? -E2BIG : total;
> -	if (copy_to_user(buf, tmp_buf, total < size ? total : size))
> +	if (copy_to_user(buf, tmp_buf, min(total, size)))
>  		error = -EFAULT;
>  	kfree(tmp_buf);
>  	return error;
> -- 
> 2.34.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

