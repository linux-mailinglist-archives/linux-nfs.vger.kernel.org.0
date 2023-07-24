Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1354175F220
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 12:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjGXKIh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 06:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjGXKIP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 06:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD1049E2
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690192737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hElr3oAo1P+U1Ohn5FyKlRi/J/m2MdRTbO0VL1LnEoA=;
        b=FiEl3TzZSAkyi2Obo7CG2AthKaW+vMd2gCQY/Pe8pZX/d8bM6BTrA0KaNkoQgkerT/lgS8
        OJWAdYauF1AquQek9ijUkIK+9FdTF2adagHryjPzcnA5ptFIsE1vgdEkaZyQqDoT3wiaj+
        7QVNMmBkFxbjs1ONpH1qLw7npkw1fvM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-6pDLNKHwOtGUQU_A7RZXCg-1; Mon, 24 Jul 2023 05:58:52 -0400
X-MC-Unique: 6pDLNKHwOtGUQU_A7RZXCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE188185A78B;
        Mon, 24 Jul 2023 09:58:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 266AB2166B25;
        Mon, 24 Jul 2023 09:58:51 +0000 (UTC)
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
Content-ID: <64139.1690192730.1@warthog.procyon.org.uk>
Date:   Mon, 24 Jul 2023 10:58:50 +0100
Message-ID: <64140.1690192730@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

> +	buf = page_frag_alloc(&svsk->sk_frag_cache, sizeof(marker),
> +			      GFP_KERNEL);

Is this SMP-safe?  page_frag_alloc() does no locking.

David

