Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB375AB9B8
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 22:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiIBU6R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 16:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiIBU6P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 16:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079EB105B71
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662152292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwueiN3OiC5RnSZBpSr/jvMLD9mpzcprtCAsEgYF/9g=;
        b=RCMqD2pG3UZKti44Kj8znHcGxKrRhzCrO15woZfZYAu/415+TCYgl5kNbskp1VNAFEPbR4
        e/YIZqMj7yffxcQwP4f0wFOs0C6+lNAWQmX80rW7FQ6Q7LvV6F6xOSeoCxO41x9uNCYP5x
        Qwe82G1wmG2qkKJgpNA9SwlqvHhlqrg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-CXI_5czrP52XBiy_YaqDrA-1; Fri, 02 Sep 2022 16:58:06 -0400
X-MC-Unique: CXI_5czrP52XBiy_YaqDrA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C4F6185A794;
        Fri,  2 Sep 2022 20:58:06 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF329492C3B;
        Fri,  2 Sep 2022 20:58:05 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Olga Kornievskaia" <aglo@umich.edu>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Date:   Fri, 02 Sep 2022 16:58:04 -0400
Message-ID: <6DC1F4DF-8242-480B-813A-5F87D64593A6@redhat.com>
In-Reply-To: <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Olga, does this fix it up for you?  I'm testing now, but I think it 
might be
a little harder for me to hit.

Ben

8<------------------------------------------------
 From 6bea39a887495b1748ff3b179d6e2f3d7e552b61 Mon Sep 17 00:00:00 2001
 From: Benjamin Coddington <bcodding@redhat.com>
Date: Fri, 2 Sep 2022 16:49:17 -0400
Subject: [PATCH] SUNRPC: Fix svc_tcp_sendmsg bvec offset calculation

The xdr_buf's bvec member points to an array of struct bio_vec, let's
fixup the calculation to the start of the bio_vec for non-zero
page_base.

Fixes: bad4c6eb5eaa ("SUNRPC: Fix NFS READs that start at 
non-page-aligned offsets")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
  net/sunrpc/svcsock.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2fc98fea59b4..ecafc9c4bc5c 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1110,7 +1110,7 @@ static int svc_tcp_sendmsg(struct socket *sock, 
struct xdr_buf *xdr,
                 unsigned int offset, len, remaining;
                 struct bio_vec *bvec;

-               bvec = xdr->bvec + (xdr->page_base >> PAGE_SHIFT);
+               bvec = &xdr->bvec[xdr->page_base >> PAGE_SHIFT];
                 offset = offset_in_page(xdr->page_base);
                 remaining = xdr->page_len;
                 while (remaining > 0) {
--
2.37.2

