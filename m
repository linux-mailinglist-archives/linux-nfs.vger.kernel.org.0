Return-Path: <linux-nfs+bounces-5697-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF3895DF83
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 20:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0736B2823E7
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 18:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CA4502B;
	Sat, 24 Aug 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKIpS0GN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5253FB3B;
	Sat, 24 Aug 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724523319; cv=none; b=NFWUJS/6tvqBmbxC0mwLz2X4mvXUZOm5BVIlBFef/uTLeBf2YEVXvsH/ZBEvEjzpey6XBX6gIU5w0cBRzNzMvXKr9mygLphnhSNoktwG9gPslUIeuwzZzjK34JL8CvAaRXcB0tcxioPd2/OFRd6zLMXwfYFD/KRfPHulDbEJB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724523319; c=relaxed/simple;
	bh=sjJQln9Ngxamkv/SG+PYpnJkFmUncRbooMQn/Dxb6Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnZbly+mMOi2/2eTFohTpAe29seeCsxVPSuUbLUcux6A4FCzvjLn5X0R11F5ohJtGLrftmUvLaeBal3jmFt5lSkqe8OUn1kuyDvEygcGiBvmeT8fwcYdOJyVR/mEQzDkvuajSxrHIzAaWMh12s7bnKhouwj3wMkTviLbysCqy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKIpS0GN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085D4C32781;
	Sat, 24 Aug 2024 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724523319;
	bh=sjJQln9Ngxamkv/SG+PYpnJkFmUncRbooMQn/Dxb6Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKIpS0GNjAKHZhZBMuNhx1z7GLZxgdyRZiwHA6jAHapdtsuzCzckwfO/mnWl5hEhg
	 8nnkQ9MiWKks2Q+lURzELNhTKLaw47SsLmIaNzRiVoJqV+iQ9G6+4hnv4rzuDD8PUa
	 QFoAGSXBmyjSUgqTdIJqtgbCQ9kgc6rTaFAy+GHYLdGvxYb2Ow4SJw5a9wTG0t5WTS
	 IM5ytHM2FgQWVog4FecJ03qlfW8+XsC7rAuFY5R3Zhdk3FCPaKa6W1j3lwM3zmnBJ4
	 /yAJgDdda6oD1ersuDYEZAO1tuN4QWUF9cLT20yRrCIi3OeY88bO1KofHElUmnVCdp
	 2IUlJ5rAPoORA==
Date: Sat, 24 Aug 2024 19:15:11 +0100
From: Simon Horman <horms@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, marcel@holtmann.org, johan.hedberg@gmail.com,
	luiz.dentz@gmail.com, idryomov@gmail.com, xiubli@redhat.com,
	dsahern@kernel.org, trondmy@kernel.org, anna@kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	jmaloy@redhat.com, ying.xue@windriver.com, linux@treblig.org,
	jacob.e.keller@intel.com, willemb@google.com, kuniyu@amazon.com,
	wuyun.abel@bytedance.com, quic_abchauha@quicinc.com,
	gouhao@uniontech.com, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 2/8] Bluetooth: use min() to simplify the code
Message-ID: <20240824181511.GS2164@kernel.org>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
 <20240822133908.1042240-3-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822133908.1042240-3-lizetao1@huawei.com>

On Thu, Aug 22, 2024 at 09:39:02PM +0800, Li Zetao wrote:
> When copying data from skb, it needs to determine the copy length.
> It is easier to understand using min() here.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

However, I don't believe Bluetooth changes usually don't go through next-next.
So I think this either needs to be reposted or get an ack from
the maintainer (already CCed).

Luiz, perhaps you can offer some guidance here?

> ---
>  net/bluetooth/hidp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 707f229f896a..7bf24f2993ba 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -294,7 +294,7 @@ static int hidp_get_raw_report(struct hid_device *hid,
>  
>  	skb = session->report_return;
>  	if (skb) {
> -		len = skb->len < count ? skb->len : count;
> +		len = min(skb->len, count);

I am slightly dubious about this check, given the different types involved.
Is using min_t appropriate (I don't know)?

>  		memcpy(data, skb->data, len);
>  
>  		kfree_skb(skb);
> -- 
> 2.34.1
> 
> 

