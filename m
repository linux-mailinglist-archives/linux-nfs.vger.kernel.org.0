Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549124C2E06
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 15:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiBXOPX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 09:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiBXOPW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 09:15:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B53F2294FD8
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 06:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645712091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KfVrBmYIOLy9qEqBFvbQ0J6iX/OFf0t0rPT33y0wU9Y=;
        b=Med5YxeC9Hzgo80XBjsMt8EbX21n6snY8erv29M7rUNxqytzi+zMVCrnxHCAGSAMzeNQu1
        La/61wn/biuYwsZTy66aMdsvxrw7FGw40VHTQcpTRzd/WKO3b64F4S2IaQh1OUHxHR083o
        Qw1CFRztX5RE4Kpc1U6dSZDEWMRetgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-daPVagy7PX2tf55BdQMLhA-1; Thu, 24 Feb 2022 09:14:50 -0500
X-MC-Unique: daPVagy7PX2tf55BdQMLhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73A80804310;
        Thu, 24 Feb 2022 14:14:49 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 231768400E;
        Thu, 24 Feb 2022 14:14:49 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 02/21] NFS: Trace lookup revalidation failure
Date:   Thu, 24 Feb 2022 09:14:46 -0500
Message-ID: <43364F7C-BEED-4C35-8745-9181AD2D9F57@redhat.com>
In-Reply-To: <20220223211305.296816-3-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 23 Feb 2022, at 16:12, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Enable tracing of lookup revalidation failures.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index ebddc736eac2..1aa55cac9d9a 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1474,9 +1474,7 @@ nfs_lookup_revalidate_done(struct inode *dir, 
> struct dentry *dentry,
>  {
>  	switch (error) {
>  	case 1:
> -		dfprintk(LOOKUPCACHE, "NFS: %s(%pd2) is valid\n",
> -			__func__, dentry);
> -		return 1;
> +		break;
>  	case 0:
>  		/*
>  		 * We can't d_drop the root of a disconnected tree:
> @@ -1485,13 +1483,10 @@ nfs_lookup_revalidate_done(struct inode *dir, 
> struct dentry *dentry,
>  		 * inodes on unmount and further oopses.
>  		 */
>  		if (inode && IS_ROOT(dentry))
> -			return 1;
> -		dfprintk(LOOKUPCACHE, "NFS: %s(%pd2) is invalid\n",
> -				__func__, dentry);
> -		return 0;
> +			error = 1;
> +		break;
>  	}
> -	dfprintk(LOOKUPCACHE, "NFS: %s(%pd2) lookup returned error %d\n",
> -				__func__, dentry, error);
> +	trace_nfs_lookup_revalidate_exit(dir, dentry, 0, error);


There's a path through nfs4_lookup_revalidate that will now only produce
this exit tracepoint.  Does it need the _enter tracepoint added?

Ben

