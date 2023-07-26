Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EC27635F7
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jul 2023 14:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjGZMOQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jul 2023 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjGZMOP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jul 2023 08:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC9526A1
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jul 2023 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690373597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lsERt6CnZNRE+dhh1BGptB8b+vQ21piRrkA+84QPZcM=;
        b=UYxdC+5seiekNY+hCM6PJO1QwgVdSmYDK6oji3CjQF2KOmvtzP7RmrT1rYp9EJMaoYvl9V
        NeBHSqfDPd/0m6okh4hV1BpdwagsgR5QdSnaYnQClSILDjblpakjfalFKuzbwzxYyWUx6M
        LtXuKgkvZ+gZWfu6IP3hm+GoNxFDDTg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-DAfwQkvvPdicDDG69ac9QA-1; Wed, 26 Jul 2023 08:13:16 -0400
X-MC-Unique: DAfwQkvvPdicDDG69ac9QA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 133AF185A792;
        Wed, 26 Jul 2023 12:13:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E858492C13;
        Wed, 26 Jul 2023 12:13:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
References: <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
To:     Chuck Lever <cel@kernel.org>
Cc:     dhowells@redhat.com, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 0/5] Send RPC-on-TCP with one sock_sendmsg() call
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6564.1690373594.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jul 2023 13:13:14 +0100
Message-ID: <6565.1690373594@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

> After some discussion with David Howells at LSF/MM 2023, we arrived
> at a plan to use a single sock_sendmsg() call for transmitting an
> RPC message on socket-based transports. This is an initial part of
> the transition to support handling folios with file content, but it
> has scalability benefits as well.
> 
> Initial performance benchmark results show 5-10% throughput gains
> with a fast link layer and a tmpfs export. I've added some other
> ideas to this series for further discussion -- these have also shown
> performance benefits in my testing.

I like it :-)

David

