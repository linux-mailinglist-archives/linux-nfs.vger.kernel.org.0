Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36A6B0BD0
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 15:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjCHOsX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 09:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjCHOrs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 09:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6199273E
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 06:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678286745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XZvYNzaxOA1OpFqzgjQReDW70l14ij3I5KokteR4is=;
        b=M7Npkq61GF2Gu99tlbk11DCFwr3qLPViKauXGVRvyq2dZzJZlzX5Gac+5Z6s48T6iyr3+3
        LwfXXjOnt4Iz13HxxOO193qoM3OAkeBJERiDOBOzNSz32CmSMfk3d9UTfXfVBEt8BEHccC
        VBLdhmQJHW43RFzXd/isjf42g1NH8gM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-t3WYAKcYM9GIHjzwAF-H7Q-1; Wed, 08 Mar 2023 09:45:41 -0500
X-MC-Unique: t3WYAKcYM9GIHjzwAF-H7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 896841C2CAA0;
        Wed,  8 Mar 2023 14:45:40 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A143C440D9;
        Wed,  8 Mar 2023 14:45:39 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chengen Du <chengen.du@canonical.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFS: Correct timing for assigning access cache timestamp
Date:   Wed, 08 Mar 2023 09:45:37 -0500
Message-ID: <1B808CC0-49C6-4AF6-B7E2-0772A71DB490@redhat.com>
In-Reply-To: <20230308080327.33906-1-chengen.du@canonical.com>
References: <20230308080327.33906-1-chengen.du@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Mar 2023, at 3:03, Chengen Du wrote:

> When the user's login time is newer than the cache's timestamp,
> the original entry in the RB-tree will be replaced by a new entry.
> Currently, the timestamp is only set if the entry is not found in
> the RB-tree, which can cause the timestamp to be undefined when
> the entry exists. This may result in a significant increase in
> ACCESS operations if the timestamp is set to zero.
>
> Signed-off-by: Chengen Du <chengen.du@canonical.com>
> ---
>  fs/nfs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index a41c3ee4549c..6fbcbb8d6587 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -3089,7 +3089,6 @@ static void nfs_access_add_rbtree(struct inode *i=
node,
>  		else
>  			goto found;
>  	}
> -	set->timestamp =3D ktime_get_ns();
>  	rb_link_node(&set->rb_node, parent, p);
>  	rb_insert_color(&set->rb_node, root_node);
>  	list_add_tail(&set->lru, &nfsi->access_cache_entry_lru);
> @@ -3114,6 +3113,7 @@ void nfs_access_add_cache(struct inode *inode, st=
ruct nfs_access_entry *set,
>  	cache->fsgid =3D cred->fsgid;
>  	cache->group_info =3D get_group_info(cred->group_info);
>  	cache->mask =3D set->mask;
> +	cache->timestamp =3D ktime_get_ns();
>
>  	/* The above field assignments must be visible
>  	 * before this item appears on the lru.  We cannot easily
> -- =

> 2.37.2

Looks good to me.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

