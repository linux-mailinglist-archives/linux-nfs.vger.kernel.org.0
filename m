Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387A3763602
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jul 2023 14:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjGZMOr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jul 2023 08:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjGZMOp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jul 2023 08:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93181739
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jul 2023 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690373636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7folU+o6IdMcxxre54Tgnhp0bUYj76Sj/pvmsSdnh4=;
        b=JqvEYWj/+Mg+tkC87Z8ClEQC/L3CLFdB802T2KIGkkysyt0roaKgUQb0EnIZ9mhnqVHLOc
        2dDOHu+3WWGbV44gwO54fXk52qakDb14QAFhTcXeSrWKCnGRecB9bFXGy7/KWXzoqSCuOb
        mc36EdkGrcDpQ5Rn4B5SjZbU8kPlrs0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-R2r3OplUP3qpsN733A26xQ-1; Wed, 26 Jul 2023 08:13:52 -0400
X-MC-Unique: R2r3OplUP3qpsN733A26xQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 501162A5955D;
        Wed, 26 Jul 2023 12:13:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE298492C13;
        Wed, 26 Jul 2023 12:13:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <168979146971.1905271.4709699930756258041.stgit@morisot.1015granger.net>
References: <168979146971.1905271.4709699930756258041.stgit@morisot.1015granger.net> <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
To:     Chuck Lever <cel@kernel.org>
Cc:     dhowells@redhat.com, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 2/5] SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6598.1690373630.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jul 2023 13:13:50 +0100
Message-ID: <6599.1690373630@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck Lever <cel@kernel.org> wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
> 
> There is now enough infrastructure in place to combine the stream
> record marker into the biovec array used to send each outgoing RPC
> message on TCP. The whole message can be more efficiently sent with
> a single call to sock_sendmsg() using a bio_vec iterator.
> 
> Note that this also helps with RPC-with-TLS: the TLS implementation
> can now clearly see where the upper layer message boundaries are.
> Before, it would send each component of the xdr_buf (record marker,
> head, page payload, tail) in separate TLS records.
> 
> Suggested-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>

