Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0607D6C0F
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbjJYMgg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 08:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjJYMge (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 08:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7718E13D
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698237342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZpHifrU2s5Zl3Ak7+hsd8JgtA2mkf3sTAvVq9SRCPk=;
        b=g3kqYUL6KFUDBSAq5/4H9wCx+GYKyssyAey3k6VF8Q0EdczVm/biISICpVPNH977MLmQnE
        eQPJEGW7PD6M8HpMySClUT3mmJ8oQQvruhBm7AMLzrcGvVy/pHiePf4SJE52HvdegeU7Lh
        2ghijiWNaS+G38qex9HxC7so08J+MxM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-margzujmNWm9iKyqDIlRyQ-1; Wed, 25 Oct 2023 08:35:38 -0400
X-MC-Unique: margzujmNWm9iKyqDIlRyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86848857CF6;
        Wed, 25 Oct 2023 12:35:37 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 992CF1C060AE;
        Wed, 25 Oct 2023 12:35:34 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net v2] net: sunrpc: Fix an off by one in
 rpc_sockaddr2uaddr()
Date:   Wed, 25 Oct 2023 08:35:33 -0400
Message-ID: <3860625A-B435-45A7-BC53-883A50539510@redhat.com>
In-Reply-To: <31b27c8e54f131b7eabcbd78573f0b5bfe380d8c.1698184674.git.christophe.jaillet@wanadoo.fr>
References: <31b27c8e54f131b7eabcbd78573f0b5bfe380d8c.1698184674.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 Oct 2023, at 17:58, Christophe JAILLET wrote:

> The intent is to check if the strings' are truncated or not. So, >= should
> be used instead of >, because strlcat() and snprintf() return the length of
> the output, excluding the trailing NULL.
>
> Fixes: a02d69261134 ("SUNRPC: Provide functions for managing universal addresses")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Fix cut'n'paste typo in subject
>     Add net in [PATCH...]
> ---

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

