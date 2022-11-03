Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA96184FE
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Nov 2022 17:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKCQme (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Nov 2022 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiKCQlq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 12:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED61C43B
        for <linux-nfs@vger.kernel.org>; Thu,  3 Nov 2022 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667493515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yg8hSmUtp8lzNDLyKE/qDpSLiTbyZAup75oCBqKmHiQ=;
        b=L16qhdlwGSTss0KCkL3Hn5sn34pY2kdgGxg7PB2XXO/+RJhlI+XwN9VqW4i1xJ5dTNVhws
        JWwma6oncOPCqnqHUu7wCjvm8Za7ntwQ6lCcv0eF5DafF/iBX9SfBHs1TUP4fWRfzOQezg
        upmb85cU+BxEIqrUkXIU9wHpQSE5zz0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-9cTbRan8NTWwF0z6B3jGZA-1; Thu, 03 Nov 2022 12:38:34 -0400
X-MC-Unique: 9cTbRan8NTWwF0z6B3jGZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2558F85A59D;
        Thu,  3 Nov 2022 16:38:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16280492B06;
        Thu,  3 Nov 2022 16:38:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221103161637.1725471-7-dwysocha@redhat.com>
References: <20221103161637.1725471-7-dwysocha@redhat.com> <20221103161637.1725471-1-dwysocha@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: Re: [RFC PATCH v10 6/6] netfs: Change netfs_inode_init to allocate memory to allow opt-in
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <108532.1667493511.1@warthog.procyon.org.uk>
Date:   Thu, 03 Nov 2022 16:38:31 +0000
Message-ID: <108533.1667493511@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dave Wysochanski <dwysocha@redhat.com> wrote:

> This saves memory for network filesystems inode that would build
> in netfs support, but like to opt-in to netfs on some mounts while
> opting-out of netfs on other mounts.
> ...
>  static struct inode *afs_alloc_inode(struct super_block *sb)
>  {
>  	struct afs_vnode *vnode;
> +	int	ret;
>  
>  	vnode = alloc_inode_sb(sb, afs_inode_cachep, GFP_KERNEL);
>  	if (!vnode)
>  		return NULL;
>  
> +	ret = netfs_inode_init(&vnode->netfs, &afs_req_ops);
> +	if (ret) {
> +		afs_free_inode(AFS_VNODE_TO_I(vnode));
> +		return NULL;
> +	}
>  	atomic_inc(&afs_count_active_inodes);
>  
>  	/* Reset anything that shouldn't leak from one inode to the next. */

This makes the memory footprint worse for 9p, afs, ceph and cifs - and adds a
time penalty to inode creation and destruction as well (though probably not a
huge amount).

David

