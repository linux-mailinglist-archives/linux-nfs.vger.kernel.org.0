Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2512C52EA76
	for <lists+linux-nfs@lfdr.de>; Fri, 20 May 2022 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348340AbiETLEJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348312AbiETLEH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 07:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8190C149AA1
        for <linux-nfs@vger.kernel.org>; Fri, 20 May 2022 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653044645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yE2PbTqRpDymDYivezQVeunCA9NMPzja3YRE39MaMNc=;
        b=LA+PxGDEAxYRGAghvMq6YN6OJjuJnkti1RkR1C0vN7bKtbz3tUcgyEfBmFu/b0u9WNgjom
        RlEu26xmBXIqkNEhlgjVQf0TvIc6jt0qWT3UTAqTGjxv4j/c89jQr81W5h99aOHcvc3QgN
        0C57rVjPUCLoBHG/OcP3gguti8TV0ik=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-XpSnvcZjN-6UF4mTo4PINw-1; Fri, 20 May 2022 07:04:02 -0400
X-MC-Unique: XpSnvcZjN-6UF4mTo4PINw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D16829AB3F5;
        Fri, 20 May 2022 11:04:01 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51DD4492C3B;
        Fri, 20 May 2022 11:04:01 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Javier Abrego" <javier.abrego.lorente@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: removed goto statement
Date:   Fri, 20 May 2022 07:04:00 -0400
Message-ID: <B6970757-8D00-422E-A8B9-658A4CBAB41D@redhat.com>
In-Reply-To: <20220520085019.44138-1-javier.abrego.lorente@gmail.com>
References: <20220520085019.44138-1-javier.abrego.lorente@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 20 May 2022, at 4:50, Javier Abrego wrote:

> In this function goto can be replaced. Avoiding goto will improve the
> readability
>
> Signed-off-by: Javier Abrego<javier.abrego.lorente@gmail.com>
> ---
>  fs/nfs/nfs42xattr.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
> index e7b34f7e0..9bf3a88fd 100644
> --- a/fs/nfs/nfs42xattr.c
> +++ b/fs/nfs/nfs42xattr.c
> @@ -747,21 +747,19 @@ void nfs4_xattr_cache_set_list(struct inode 
> *inode, const char *buf,
>  		return;
>
>  	entry = nfs4_xattr_alloc_entry(NULL, buf, NULL, buflen);
> -	if (entry == NULL)
> -		goto out;
> -
> -	/*
> -	 * This is just there to be able to get to bucket->cache,
> -	 * which is obviously the same for all buckets, so just
> -	 * use bucket 0.
> -	 */
> -	entry->bucket = &cache->buckets[0];
> -
> -	if (!nfs4_xattr_set_listcache(cache, entry))
> -		kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
> -
> -out:
> -	kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
> +	if (entry == NULL) {
> +		kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
> +	} else {
> +	       /*
> +		* This is just there to be able to get to bucket->cache,
> +		* which is obviously the same for all buckets, so just
> +		* use bucket 0.
> +		*/
> +		entry->bucket = &cache->buckets[0];
> +
> +		if (!nfs4_xattr_set_listcache(cache, entry))
> +			kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
> +	}
>  }
>
>  /*
> -- 
> 2.25.1

No, NACK because you removed the kref_put of cache->ref.  I find this
function quite readable as it is.

Ben

