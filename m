Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0918A5BFD9C
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Sep 2022 14:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIUMRG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Sep 2022 08:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiIUMRD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Sep 2022 08:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2150497512
        for <linux-nfs@vger.kernel.org>; Wed, 21 Sep 2022 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663762618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=88AABOCvYqwyFu3wcntAdM7TMw+5PcSkgLEzIU9Xpiw=;
        b=IiFCCN0YbPcs3MSw9gYIB7htgJB/Mlii7ueV3TVPhBcChHmQ34KczCQMWxlTDCc9TawJFC
        UzZe4gg63zdy0leLd9J+npWlAc1+MgtGXO8AszxRWIMqnGRgVDDYsX60FxjcedYUF7bMbx
        BFvBtWLyIEWmOl4hK+nzMhPnl7kFP/Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-308-PIq6XYBQPGKAZlppDbPB6Q-1; Wed, 21 Sep 2022 08:16:57 -0400
X-MC-Unique: PIq6XYBQPGKAZlppDbPB6Q-1
Received: by mail-wm1-f71.google.com with SMTP id h133-20020a1c218b000000b003b3263d477eso2503866wmh.8
        for <linux-nfs@vger.kernel.org>; Wed, 21 Sep 2022 05:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=88AABOCvYqwyFu3wcntAdM7TMw+5PcSkgLEzIU9Xpiw=;
        b=ySBP2soi5xIUfkf+vhSIvvAdeXR09vUSYqyk6fWXApOwB1sNu7fE10dUvs1V1S3xTR
         AiN8x295UH4tFY+mZTJiX6gfobs/XuwdyP+J0ND7RdxOqAAVZJFe4afaZM1+HMu6AVRc
         0yrhx536zv79RRcKmD0RAiHGtHlkfKAYKzBjqBoEoCxtc/Ins7vl9Bkri4XZ8VeXtS5s
         zww4UoI+TdYmwYuoOEaVPv/7+xNoD51etbaoPjsgNc7DnqbWQnMbgMN5e/FSNazM96VT
         kIwBKBRT/K8GD4hQNDOsDjaibCWZhfgKADPuahg23MRV2744jBXCkiUfXy13/sI4dik9
         CzLA==
X-Gm-Message-State: ACrzQf2N40QV81xsThf8a5wPEN09A5ipHE2Mc/jAaIitzsWS7opXiZoS
        sGYEAeJLyQ9Aa3Usrhs5QPbwRjUrMEItLhWiUq/tG+T0H3yHaWu6z8xW8mR12O09FAc21bu9jM3
        Bq0I84rP3dTb7ATpncCth
X-Received: by 2002:a05:6000:188c:b0:22b:5c7:a21c with SMTP id a12-20020a056000188c00b0022b05c7a21cmr8189263wri.59.1663762616637;
        Wed, 21 Sep 2022 05:16:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5QMv2SR8/v15L+K54GwLlYkpBGb+MzKdXCh57jOCmT5M1gYNOIYzkke5zUXMUK+9i3KetJIQ==
X-Received: by 2002:a05:6000:188c:b0:22b:5c7:a21c with SMTP id a12-20020a056000188c00b0022b05c7a21cmr8189250wri.59.1663762616450;
        Wed, 21 Sep 2022 05:16:56 -0700 (PDT)
Received: from debian.home (2a01cb058d2cf4004ad3915553d340e2.ipv6.abo.wanadoo.fr. [2a01:cb05:8d2c:f400:4ad3:9155:53d3:40e2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c290400b003a83fda1dc5sm2567593wmd.44.2022.09.21.05.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 05:16:55 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:16:53 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH net] sunrpc: Use GFP_NOFS to prevent use of
 current->task_frag.
Message-ID: <96a18bd00cbc6cb554603cc0d6ef1c551965b078.1663762494.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Link: https://lore.kernel.org/netdev/b4d8cb09c913d3e34f853736f3f5628abfd7f4b6.1656699567.git.gnault@redhat.com/
Fixes: a1231fda7e94 ("SUNRPC: Set memalloc_nofs_save() on all rpciod/xprtiod jobs")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
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

