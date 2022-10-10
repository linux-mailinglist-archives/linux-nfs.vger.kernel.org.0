Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7F5F9DC3
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Oct 2022 13:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiJJLmU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Oct 2022 07:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiJJLmK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Oct 2022 07:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79366F571
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665402126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=nhBZvWoCwGa0Xkxum8eK1xr6OvtknNP9jC6XCUj52m8=;
        b=JzonRnIWzENMkzAkl7xlQZ/xhbUc4pIIL8fP1k9awuctJRwimYwhBNemX8VKIURjtJa5p+
        +o1egDd+9lVDHwaSf4qLvUw1DDDo9P0ga7bQH5wB7+WBq6zp1mYFbcIuqZEBCO57gT24tu
        DcZSbAgAJfJnqk2iJ78Y21E6dgbekRo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-nFz84k8ANj6em-mQwUdh1g-1; Mon, 10 Oct 2022 07:42:05 -0400
X-MC-Unique: nFz84k8ANj6em-mQwUdh1g-1
Received: by mail-wm1-f70.google.com with SMTP id d5-20020a05600c34c500b003b4fb42ccdeso8853045wmq.8
        for <linux-nfs@vger.kernel.org>; Mon, 10 Oct 2022 04:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhBZvWoCwGa0Xkxum8eK1xr6OvtknNP9jC6XCUj52m8=;
        b=zKURO2muS8/a6KRJD7lEzhCRSrVHDod/e9D4evOZyGDPR8q0wMMYmfhSZQJV19jqBr
         gqzfpD90c81SkW/78po/wbitwZzRkUguUdZstXngVDY23R6Kok12wy6hCclOFwYgOv7i
         W9TjEmv8m775YNDg47mFX2S/A7XvRakYyQvQmrm1yg5A9e3SLxfodJuknzu3Tjx86zL6
         hm2+MB+NIbDWEavuQt7m5LPoXY+nQtywd2JYr5jY9XHveVJwOFBzVgXCaRVuu5PyWBIF
         Y1scC7wHK8se2o3J+fsW14LATzXj3Mwr4opoe8uK4Pvgc9D1m1n/LwPtbeM4f1le7lD9
         gVKw==
X-Gm-Message-State: ACrzQf0yQJ8ZgHlS4rro84Gkhq5xDH8/S2hkV2Jr7yhN6r2cOgsoc6bp
        mUE7V6X5jzDVHPDqByXhSwHaWLKsNmSw5pjIEDO/6z+KAK5Hwf+K6e2dtW0Y7CNREpCHeFzIiS/
        XPJt4ufVNXekEZhEQx6Jd
X-Received: by 2002:adf:f410:0:b0:22e:3e12:237d with SMTP id g16-20020adff410000000b0022e3e12237dmr11300060wro.398.1665402124263;
        Mon, 10 Oct 2022 04:42:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM707PlzaIIiwshZOQRdgB+itVOVpETHW7KECcWvylgh5g2+ZkWWev2k71rqw5l5fvf2vOoDJw==
X-Received: by 2002:adf:f410:0:b0:22e:3e12:237d with SMTP id g16-20020adff410000000b0022e3e12237dmr11300037wro.398.1665402124018;
        Mon, 10 Oct 2022 04:42:04 -0700 (PDT)
Received: from localhost.localdomain ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c1d2400b003a62052053csm20562268wms.18.2022.10.10.04.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 04:42:03 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:41:57 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v2] sunrpc: Use GFP_NOFS to prevent use of current->task_frag.
Message-ID: <de6d99321d1dcaa2ad456b92b3680aa77c07a747.1665401788.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit a1231fda7e94 ("SUNRPC: Set memalloc_nofs_save() on all
rpciod/xprtiod jobs") stopped setting sk->sk_allocation explicitly in
favor of using memalloc_nofs_save()/memalloc_nofs_restore() critical
sections.

However, ->sk_allocation isn't used just by the memory allocator.
In particular, sk_page_frag() uses it to figure out if it can return
the page_frag from current or if it has to use the socket one.
With ->sk_allocation set to the default GFP_KERNEL, sk_page_frag() now
returns current->page_frag, which might already be in use in the
current context if the call happens during memory reclaim.

Fix this by setting ->sk_allocation to GFP_NOFS.
Note that we can't just instruct sk_page_frag() to look at
current->flags, because it could generate a cache miss, thus slowing
down the TCP fast path.

This is similar to the problems fixed by the following two commits:
  * cifs: commit dacb5d8875cc ("tcp: fix page frag corruption on page
    fault").
  * nbd: commit 20eb4f29b602 ("net: fix sk_page_frag() recursion from
    memory reclaim").

Fixes: a1231fda7e94 ("SUNRPC: Set memalloc_nofs_save() on all rpciod/xprtiod jobs")
Link: https://lore.kernel.org/netdev/b4d8cb09c913d3e34f853736f3f5628abfd7f4b6.1656699567.git.gnault@redhat.com/
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v2: - Post only to linux-nfs to make it clearer which is the target tree.
    - Incorporate already collected acked-by and reviewed-by tags.

 net/sunrpc/xprtsock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index e976007f4fd0..1bd3048d43ae 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1882,6 +1882,7 @@ static int xs_local_finish_connecting(struct rpc_xprt *xprt,
 		sk->sk_write_space = xs_udp_write_space;
 		sk->sk_state_change = xs_local_state_change;
 		sk->sk_error_report = xs_error_report;
+		sk->sk_allocation = GFP_NOFS;
 
 		xprt_clear_connected(xprt);
 
@@ -2083,6 +2084,7 @@ static void xs_udp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 		sk->sk_user_data = xprt;
 		sk->sk_data_ready = xs_data_ready;
 		sk->sk_write_space = xs_udp_write_space;
+		sk->sk_allocation = GFP_NOFS;
 
 		xprt_set_connected(xprt);
 
@@ -2250,6 +2252,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 		sk->sk_state_change = xs_tcp_state_change;
 		sk->sk_write_space = xs_tcp_write_space;
 		sk->sk_error_report = xs_error_report;
+		sk->sk_allocation = GFP_NOFS;
 
 		/* socket options */
 		sock_reset_flag(sk, SOCK_LINGER);
-- 
2.21.3

