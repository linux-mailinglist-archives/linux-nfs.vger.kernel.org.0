Return-Path: <linux-nfs+bounces-10897-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBB4A71508
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 11:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9061737BA
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 10:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4C91C860B;
	Wed, 26 Mar 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLRwdikh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D871C6FF6
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985610; cv=none; b=kFLqRJYPfEAPmQKRr7A3idtiK/K9y+XXfp/NtE1zb9iO7EBdYq9E4fizr++VK2YXdpFaPbDsjrQIDCzM5Zg4Vr5sHUE+kTvK0BSSzkHDQgkgAovO6R9+wYzuMx/CyuuHhgUkVh7j6xe/W3OAutXu/d536UCKtWhOImDmAn2Lrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985610; c=relaxed/simple;
	bh=ySsCThZkjmEYHGJ45ws9iyiFSwDiFG7hGy/d5UEdtM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4+dgUZSR9wM/SEwsNkWqaUf8X6Lkmg2pc0sM9TlEi4PAvhSD4akTwIex7ENTLESQt9QeF+4JqY4z7ormpbcn6+AMXidot9WkYawEYWdqswZvuCr8QG0h1PpieORrYAxZfinjh+9La8gwXL68BGC/ZVcaYZJVJ3T9uOCtFWghk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLRwdikh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742985607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aqceiAqyvwZoDbLhYD6Qza3w8B/f9j/ztgic6tWUpw=;
	b=JLRwdikhmETocYpYp6QqzMGz92/xoYFUemrBiH51CyMb1GsdBolTq7aH6w2c/icMgoAzCr
	93L8k+seVzNeZh+Xd9I0lLSFM1DyPA4SrE8/fxLNjVqIbVgfwKcKt4zkgL/hr286IbQ8oI
	BsTcJ+88e6tukWYlhCdzek9R75hA8OY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-zg8AR11jMxCYMa2OxHWjdw-1; Wed,
 26 Mar 2025 06:40:04 -0400
X-MC-Unique: zg8AR11jMxCYMa2OxHWjdw-1
X-Mimecast-MFC-AGG-ID: zg8AR11jMxCYMa2OxHWjdw_1742985603
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 319171800349;
	Wed, 26 Mar 2025 10:40:03 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F260C30001A1;
	Wed, 26 Mar 2025 10:40:01 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 6/6] NFSv4: Treat ENETUNREACH errors as fatal for state
 recovery
Date: Wed, 26 Mar 2025 06:39:59 -0400
Message-ID: <4E6693BA-38E4-4BC6-94E0-50E38446BE93@redhat.com>
In-Reply-To: <ea44b46c7546579386d8d9e1a2b62c152534b6cc.1742941932.git.trond.myklebust@hammerspace.com>
References: <cover.1742941932.git.trond.myklebust@hammerspace.com>
 <ea44b46c7546579386d8d9e1a2b62c152534b6cc.1742941932.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 25 Mar 2025, at 18:35, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> If a containerised process is killed and causes an ENETUNREACH or
> ENETDOWN error to be propagated to the state manager, then mark the
> nfs_client as being dead so that we don't loop in functions that are
> expecting recovery to succeed.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4state.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 272d2ebdae0f..7612e977e80b 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -2739,7 +2739,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
>  	pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
>  			" with error %d\n", section_sep, section,
>  			clp->cl_hostname, -status);
> -	ssleep(1);
> +	switch (status) {
> +	case -ENETDOWN:
> +	case -ENETUNREACH:
> +		nfs_mark_client_ready(clp, -EIO);
> +		break;
> +	default:
> +		ssleep(1);
> +		break;
> +	}
>  out_drain:
>  	memalloc_nofs_restore(memflags);
>  	nfs4_end_drain_session(clp);
> -- 
> 2.49.0

Doesn't this have the same bug as the sysfs shutdown - in that a mount with
fatal_neterrors=ENETDOWN:ENETUNREACH can take down the state manager for a
mount without it?  I think the same consideration applies as shutdown so
far: in practical use, you're not going to care.

Another thought - its pretty subtle that the only way those errors
might/should reach us here is if that mount option is in play.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


