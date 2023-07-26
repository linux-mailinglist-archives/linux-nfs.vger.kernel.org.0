Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE6763601
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jul 2023 14:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjGZMOq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jul 2023 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjGZMOf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jul 2023 08:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9705B2698
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jul 2023 05:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690373618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LnW9xkF8qrzBpOp/lykCe+AD7AowiLx25o2vuyMj38Y=;
        b=PDZqX1ForN82WIUVp2NIsGLTpUGZ8zFycYdzHbRtVzt2qYol6dvbowxpaGqNzXl21XOb8E
        d3GLGMegCFDXg4uMIQIr8JTyuZ5rMdWfkTtDBP96LSRPCeXQEF7kfaDI2/dh/t8HtW0wXb
        5BVu4Vw4P89iDHcIYukK7kp4aF58WWE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-odnFqjtHNDuQw6wgKoCQAw-1; Wed, 26 Jul 2023 08:13:37 -0400
X-MC-Unique: odnFqjtHNDuQw6wgKoCQAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3054185A793;
        Wed, 26 Jul 2023 12:13:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34EB6200BA7C;
        Wed, 26 Jul 2023 12:13:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <168979146324.1905271.11000616800905663660.stgit@morisot.1015granger.net>
References: <168979146324.1905271.11000616800905663660.stgit@morisot.1015granger.net> <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
To:     Chuck Lever <cel@kernel.org>
Cc:     dhowells@redhat.com, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 1/5] SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6579.1690373615.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jul 2023 13:13:35 +0100
Message-ID: <6580.1690373615@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck Lever <cel@kernel.org> wrote:

> Add a helper to convert a whole xdr_buf directly into an array of
> bio_vecs, then send this array instead of iterating piecemeal over
> the xdr_buf containing the outbound RPC message.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

