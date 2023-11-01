Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A085C7DE19D
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 14:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343846AbjKANVj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 09:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343851AbjKANVi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 09:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF1DFC
        for <linux-nfs@vger.kernel.org>; Wed,  1 Nov 2023 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698844850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xThp48OO5GzIlur7YkP4GgzDT8B7pPmZBQECo2sOWgY=;
        b=Rf4cA1cs/rg8BJyy7ha7d9zsM9oDf3ozZmcqBVpC/RSKkzHee00rXHAFHKBOOpYs8ytuXG
        fs9K3I3PtrRSEHPtdZoKa5G5HQ60qzly395hVSNr170KmDXucDpXQprEHeOX0QR54cLJR7
        +1YNQxBu/ykCMI/tpBIM4h1CUy5w1Yc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-zNXRGIp_P0Oe5Uw6LTZQ7Q-1; Wed, 01 Nov 2023 09:20:47 -0400
X-MC-Unique: zNXRGIp_P0Oe5Uw6LTZQ7Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A88F185A780;
        Wed,  1 Nov 2023 13:20:47 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 563781121308;
        Wed,  1 Nov 2023 13:20:46 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>
Subject: Re: [PATCH] pNFS: Fix a hang in nfs4_evict_inode()
Date:   Wed, 01 Nov 2023 09:20:45 -0400
Message-ID: <92B7CF2E-26C4-412A-AAED-B06F6B9B4383@redhat.com>
In-Reply-To: <20231008182019.12842-1-trondmy@kernel.org>
References: <20231008182019.12842-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On 8 Oct 2023, at 14:20, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> We are not allowed to call pnfs_mark_matching_lsegs_return() without
> also holding a reference to the layout header, since doing so could lea=
d
> to the reference count going to zero when we call
> pnfs_layout_remove_lseg(). This again can lead to a hang when we get to=

> nfs4_evict_inode() and are unable to clear the layout pointer.
>
> pnfs_layout_return_unused_byserver() is guilty of this behaviour, and
> has been seen to trigger the refcount warning prior to a hang.
>
> Fixes: b6d49ecd1081 ("NFSv4: Fix a pNFS layout related use-after-free r=
ace when freeing the inode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/pnfs.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index 63904a372b2f..21a365357629 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -2638,31 +2638,44 @@ pnfs_should_return_unused_layout(struct pnfs_la=
yout_hdr *lo,
>  	return mode =3D=3D 0;
>  }
>
> -static int
> -pnfs_layout_return_unused_byserver(struct nfs_server *server, void *da=
ta)
> +static int pnfs_layout_return_unused_byserver(struct nfs_server *serve=
r,
> +					      void *data)
>  {
>  	const struct pnfs_layout_range *range =3D data;
> +	const struct cred *cred;
>  	struct pnfs_layout_hdr *lo;
>  	struct inode *inode;
> +	nfs4_stateid stateid;
> +	enum pnfs_iomode iomode;
> +
>  restart:
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(lo, &server->layouts, plh_layouts) {
> -		if (!pnfs_layout_can_be_returned(lo) ||
> +		inode =3D lo->plh_inode;
> +		if (!inode || !pnfs_layout_can_be_returned(lo) ||
>  		    test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags))
>  			continue;
> -		inode =3D lo->plh_inode;
>  		spin_lock(&inode->i_lock);
> -		if (!pnfs_should_return_unused_layout(lo, range)) {
> +		if (!lo->plh_inode ||
> +		    !pnfs_should_return_unused_layout(lo, range)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
> +		pnfs_get_layout_hdr(lo);

We're getting a crash with the nfs_inode.layout =3D=3D NULL in writeback.=


We haven't bisected to this yet, but I think this change is exposing the
case where the pnfs_layout_hdr refcount goes to zero, but we can still fi=
nd
it here on server->layouts, and bump the refcount incorrectly.

Plausible?  We can send a fix or test one..

Ben

