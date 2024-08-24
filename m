Return-Path: <linux-nfs+bounces-5696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E1F95DF77
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 20:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A66281CC9
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65724F8BB;
	Sat, 24 Aug 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsZ09d0H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEC52F70;
	Sat, 24 Aug 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724523138; cv=none; b=M2VA5i8BGNM4sWWoeMpaVWC75pCci9V+MR2EDh7ZbeLOhLPunn9Ksfz1p7JgMP4XiKPU28bU/b6HXDB3UTJlOjAosvLb10Wd7QwxJfLvSNAHl4cBH1Q89oPeHQKSQSb68igqPJYLEoGEbO/R2gvO9/F9Q04Q0vi1SDuwYbUymHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724523138; c=relaxed/simple;
	bh=ZdgRcAsuIdngHnmS5YA6uvXCDSVELyfVCl6vYGy9IlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QysK1We0OUezq/ZYsNHxejy6pCrX3jcmGOVisiHXmPvAOyyltkpxolCx5hEFUdzhkfw1X8/FRioU56gnXprHmD/kmIYxiMAsQJuRM7DDcWDII1OzHrYRZ4/5S6XpxX15lkDUHiBgrKIqosKAvBUg3EKEyaZl6XSMXi0RcrDYB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsZ09d0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC2AC32781;
	Sat, 24 Aug 2024 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724523137;
	bh=ZdgRcAsuIdngHnmS5YA6uvXCDSVELyfVCl6vYGy9IlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsZ09d0HCODeByT5KibHfaqGlIBFkVUkb3Y6Uxs5F3e+gx1ATfS9HWf/4XP+W5tRf
	 zoRGgRVnnMbpfUfxaUsqKWKyQKE9h2ajpUn1tcgTBI3qALeO9viI2j4Gc7pJLMGUdg
	 qOm/xZkIZ4gDRk1QUMdY0KWIFwjYLFmI6rPVrj4nre6+IJE+xzEdU78eRILXc5ZMZ+
	 m3AADS6EE5lmF2C/6WWwp5K13dXoHKOaTMj65EiHjwUKW/TEd67NZqcQGcAnIqxQua
	 nLuITYE4I8x97jKs83i8+9EuUIBaVRY6n9XI+C/h976xz+IcBpaCdL3h6b8iX1/jd9
	 KqyJ9fYWjyYyg==
Date: Sat, 24 Aug 2024 19:12:09 +0100
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
Subject: Re: [PATCH net-next 4/8] libceph: use min() to simplify the code
Message-ID: <20240824181209.GR2164@kernel.org>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
 <20240822133908.1042240-5-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822133908.1042240-5-lizetao1@huawei.com>

On Thu, Aug 22, 2024 at 09:39:04PM +0800, Li Zetao wrote:
> When resolving name in ceph_dns_resolve_name(), the end address of name
> is determined by the minimum value of delim_p and colon_p. So using min()
> here is more in line with the context.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  net/ceph/messenger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 3c8b78d9c4d1..d1b5705dc0c6 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1254,7 +1254,7 @@ static int ceph_dns_resolve_name(const char *name, size_t namelen,
>  	colon_p = memchr(name, ':', namelen);
>  
>  	if (delim_p && colon_p)
> -		end = delim_p < colon_p ? delim_p : colon_p;
> +		end = min(delim_p, colon_p);

Both delim_p, and colon_p are char *, so this seems correct to me.

And the code being replaced does appear to be a min() operation in
both form and function.

Reviewed-by: Simon Horman <horms@kernel.org>

However, I don't believe libceph changes usually don't go through next-next.
So I think this either needs to be reposted or get some acks from
one of the maintainers.

Ilya, Xiubo, perhaps you can offer some guidance here?

>  	else if (!delim_p && colon_p)
>  		end = colon_p;
>  	else {
> -- 
> 2.34.1
> 
> 

