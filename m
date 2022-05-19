Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D86E52E0D3
	for <lists+linux-nfs@lfdr.de>; Fri, 20 May 2022 01:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343790AbiESXtZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 May 2022 19:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343752AbiESXtP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 May 2022 19:49:15 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561ED122B6D;
        Thu, 19 May 2022 16:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1653004154; x=1684540154;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=n2sodAkHQl9j+LmXATpuFnXNE/BjAXWpNSeFFdVqsJU=;
  b=PAqj4h4eYRfY2G1dy8ZfecDnpl0VKcgq2U+BeVERkucBYD+Tk8mIGt1M
   UDZP6ylmWuOgZQLMFPYdI1EV5v9aTOQc12Pmd6oqUakRquDQTKLtahG3c
   vgJ885Nio5CKTVeIql3ZvYqMTs0Bc9WcTo4FLueja1s4ckwsmyUr9zmUF
   8=;
X-IronPort-AV: E=Sophos;i="5.91,238,1647302400"; 
   d="scan'208";a="203340388"
Subject: Re: [PATCH] FS: nfs: removed goto statement
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-41c1ef8b.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 19 May 2022 23:49:13 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-41c1ef8b.us-east-1.amazon.com (Postfix) with ESMTPS id 8221B16239A;
        Thu, 19 May 2022 23:49:12 +0000 (UTC)
Received: from EX13P01UWA004.ant.amazon.com (10.43.160.127) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 19 May 2022 23:49:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13P01UWA004.ant.amazon.com (10.43.160.127) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 19 May 2022 23:49:08 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.36 via Frontend Transport; Thu, 19 May 2022 23:49:08
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 613E7F9F; Thu, 19 May 2022 23:49:08 +0000 (UTC)
Date:   Thu, 19 May 2022 23:49:08 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Javier Abrego <javier.abrego.lorente@gmail.com>
CC:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <20220519234907.GA12990@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <20220519225115.35431-1-javier.abrego.lorente@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220519225115.35431-1-javier.abrego.lorente@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 20, 2022 at 12:51:15AM +0200, Javier Abrego wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> In this function goto can be replaced. Avoiding goto will improve the
> readability
> 
> Signed-off-by: Javier Abrego<javier.abrego.lorente@gmail.com>
> ---
>  fs/nfs/nfs42xattr.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
> index e7b34f7e0..2fc806454 100644
> --- a/fs/nfs/nfs42xattr.c
> +++ b/fs/nfs/nfs42xattr.c
> @@ -743,25 +743,19 @@ void nfs4_xattr_cache_set_list(struct inode *inode, const char *buf,
>         struct nfs4_xattr_entry *entry;
> 
>         cache = nfs4_xattr_get_cache(inode, 1);
> -       if (cache == NULL)
> -               return;
> -
> -       entry = nfs4_xattr_alloc_entry(NULL, buf, NULL, buflen);
> -       if (entry == NULL)
> -               goto out;
> -
> -       /*
> -        * This is just there to be able to get to bucket->cache,
> -        * which is obviously the same for all buckets, so just
> -        * use bucket 0.
> -        */
> -       entry->bucket = &cache->buckets[0];
> -
> -       if (!nfs4_xattr_set_listcache(cache, entry))
> -               kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
> -
> -out:
> -       kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
> +       if (cache == NULL) {
> +               kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
> +       } else {
> +              /*
> +               * This is just there to be able to get to bucket->cache,
> +               * which is obviously the same for all buckets, so just
> +               * use bucket 0.
> +               */
> +               entry->bucket = &cache->buckets[0];
> +
> +               if (!nfs4_xattr_set_listcache(cache, entry))
> +                       kref_put(&entry->ref, nfs4_xattr_free_entry_cb);
> +       }
>  }
> 
>  /*

Hm, I'm not sure what your intention was here, but this patch is wrong
in several ways. It references 'cache' when it's NULL. It removes the
allocation of 'entry' altogether, and then references an uninitialized
variable. Which, surely, gcc would have warned about.

I mean, in the original code, you could replace

if (entry == NULL)
	goto out;

with

if (entry != NULL) {
	...
}

..and remove the out label. Not sure if that would make things massively
more readable.

- Frank
