Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDDF7D6BF4
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbjJYMgC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 08:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbjJYMgA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 08:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71A6AC
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698237313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIfXyZoxzqzNs1x6NcY6WinvIChe9VAS0A6uJtrJM9Q=;
        b=Get87GoJRo3xZLFj9lY0z6doim7gBzG8/0leBohCwDdURcsPV2hKfRWDlXgHY32R6S9cjt
        6YDtShmBZdo/3d+ueoqxlfpR/BCgT7FJ1ofSFtJzNZD1qRrY83/01W7svzBoa66XH3zopf
        oCQlugMVttduHqg68848sr0T54vSyrc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-Q8Qxy8Y6ONSwH4z1ALu1_w-1; Wed, 25 Oct 2023 08:34:56 -0400
X-MC-Unique: Q8Qxy8Y6ONSwH4z1ALu1_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14F66811E8E;
        Wed, 25 Oct 2023 12:34:56 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CAF125C2;
        Wed, 25 Oct 2023 12:34:53 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: sunrpc: Fix an off by one in root_nfs_cat()
Date:   Wed, 25 Oct 2023 08:34:52 -0400
Message-ID: <F7210412-252A-43F1-AF00-E5287C6C8DE5@redhat.com>
In-Reply-To: <856a652a7e28dde246b00025da7d4115978ae75f.1698184400.git.christophe.jaillet@wanadoo.fr>
References: <856a652a7e28dde246b00025da7d4115978ae75f.1698184400.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 Oct 2023, at 17:55, Christophe JAILLET wrote:

> The intent is to check if the strings' are truncated or not. So, >= should
> be used instead of >, because strlcat() and snprintf() return the length of
> the output, excluding the trailing NULL.
>
> Fixes: a02d69261134 ("SUNRPC: Provide functions for managing universal addresses")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

