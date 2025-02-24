Return-Path: <linux-nfs+bounces-10311-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458DBA421C2
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 14:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88F53B02AD
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Feb 2025 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCDD24EF81;
	Mon, 24 Feb 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdZEcMlN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9224EF7D;
	Mon, 24 Feb 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404470; cv=none; b=Q1CMnkFUlSQELtPnHjunFnpEpHGng6vlmepLwU3tl0+hwwCXSO8VDO4CEOdarhQTSL4jqBTbezmU2pLT3W0ujce1AtavQaepjDg0pFOeHQuptF8xpUAGOX/GrvJp/wL43eAaJu9eWP6pmexIpN8Hr8M534UuPomyF1aGvPHHxmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404470; c=relaxed/simple;
	bh=SvBnxw/XZz/WJPddbKqh/lOJdzpZ372yLfQQGTkJXiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XakA4BiXtJBYd/yFsDt2HNhF8dtp+GzOe7VLM065KIU0qAxkAxku03NYiMBFo1vKPGXJHvOXlkGWBk91Q/QWlQ8/ShIw0V0cRmtFmyg8Ei1KGiN5bflwITruwyxS86HSjFRniH1Q6cYr0mbvIThuhRtH7YyB3t/SdZua5cWgyf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdZEcMlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1184C4CED6;
	Mon, 24 Feb 2025 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740404469;
	bh=SvBnxw/XZz/WJPddbKqh/lOJdzpZ372yLfQQGTkJXiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdZEcMlNjm4qlOm1gtQWFby41SiZBRVKdgf9N3HiucDIQGrgCv/dj35QrP/Ox9trY
	 0blvkIb1JS5KKshjzLgkxN+VEJRrsr3jv6rZapjalnk9npL/YhK5z7yZu+kpyhg3Ei
	 GbNishKojUclov0ff1rk2tKLyb2FUZKlcBx/CKfacfwPjYeViZlB3wiZITYqn4sSSF
	 hg+V7m481i8qCa5Rpz2de+mlVrSmcsSAIxMEffBUh2gNINJLyxvtb5lUUBN3Sm1nb2
	 2ZlDYwzeDiJ7zYmYUG8J5ALVKfYCWbx+TLcpWRE8WKy/9gmYnXIsy4TfvDl5gjxg0N
	 nSGgNY7IV6FFQ==
Date: Mon, 24 Feb 2025 15:41:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Joel Granados <j.granados@samsung.com>,
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 5/6] sysctl/infiniband: Fixes infiniband sysctl bounds
Message-ID: <20250224134105.GC53094@unreal>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-6-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224095826.16458-6-nicolas.bouchinet@clip-os.org>

On Mon, Feb 24, 2025 at 10:58:20AM +0100, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Bound infiniband iwcm and ucma sysctl writings between SYSCTL_ZERO
> and SYSCTL_INT_MAX.
> 
> The proc_handler has thus been updated to proc_dointvec_minmax.
> 
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  drivers/infiniband/core/iwcm.c | 4 +++-
>  drivers/infiniband/core/ucma.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Leon Romanovsky <leon@kernel.org>

How do you want to proceed from here? Should I take to RDMA repository?

Thanks

