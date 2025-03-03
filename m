Return-Path: <linux-nfs+bounces-10417-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD31A4C320
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 15:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDEA3A7090
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D52144BA;
	Mon,  3 Mar 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMw43K/W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194F2144A7;
	Mon,  3 Mar 2025 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011367; cv=none; b=c1WzbLsNBjcaOylykBUbyokAs0yhwI3Q5tFMGCDFHubnqMjqQnK3wEW1hi/hX2kiE2EuoLPcIXdC6BMWnb4LFW3TxoKFrJauh17DMmb5FmEI69XoT6s5zaJneUEV64APgEQpg10NQLpJljCTqix6of7aPjUBJGVDDzCJNm3dpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011367; c=relaxed/simple;
	bh=/UXL2rJW52FUBLTRrRMZTH46RpXodpUCmURoDu7I3t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFQ+c0P6pHp3PhU8TyVmFpDraYXm4qMImnJtPKb4wP4zFa5enSbxQHejmzY7s4TSeDjXo8Kvh5lMvrGW7AbIgz8dwt/mz4qWf6a8KGzpEhWCvE8Tg++18b27M+Uo6+GxjRZFkMeSp3Kg8ug/qt1S5/GRrA4TofCQNngBzSRTHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMw43K/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91A6C4CEEE;
	Mon,  3 Mar 2025 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741011365;
	bh=/UXL2rJW52FUBLTRrRMZTH46RpXodpUCmURoDu7I3t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMw43K/Wbzl2v9+btosaazyG50OrMjOYgSO8pvI8sya1M6ePOKj3F8ZQcuTZl9aUd
	 uQL6oviJwI5qEUP/68qK0rXnh5Bp2kr6sgAlNaUsGvt7lIyvBV41IC1Sb4pQCd8KEI
	 oVUgb5euXPdYat+zWshMJVwgd2ty8Ftkb/evDnIUoRjrZhCs/+9vMmhwklvdqD9geB
	 Hq/j0usyAacAjg9316vFxeIeN3rFWuic2aqAMNouyW9YGjq0dRvUHdpw58gFB5uUty
	 JTA+3Z6plwWsyo3smlZvG56chbd45iwT7XFg1biSgXe4iqlpseloG7ZRO7VTSJ9IMj
	 +7UgFhfCrQP2A==
Date: Mon, 3 Mar 2025 15:15:59 +0100
From: Joel Granados <joel.granados@kernel.org>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Joel Granados <j.granados@samsung.com>, 
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 3/6] sysctl/coda: Fixes timeout bounds
Message-ID: <u7q5rpzw6mohtnnhpa2j3u4photckmgllsl3noafnyfttepbui@rzmndu533xcv>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-4-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224095826.16458-4-nicolas.bouchinet@clip-os.org>

On Mon, Feb 24, 2025 at 10:58:18AM +0100, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Bound coda timeout sysctl writings between SYSCTL_ZERO
> and SYSCTL_INT_MAX.
> 
> The proc_handler has thus been updated to proc_dointvec_minmax.
> 
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  fs/coda/sysctl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
> index 0df46f09b6cc5..d6f8206c51575 100644
> --- a/fs/coda/sysctl.c
> +++ b/fs/coda/sysctl.c
> @@ -20,7 +20,9 @@ static const struct ctl_table coda_table[] = {
>  		.data		= &coda_timeout,
I noticed that coda_timeout is an unsigned long. With that in mind I
would change it to unsigned int. It seems to be a value that can be
ranged within [0,INT_MAX]

Best
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_INT_MAX,
>  	},
>  	{
>  		.procname	= "hard",
> -- 
> 2.48.1
> 

-- 

Joel Granados

