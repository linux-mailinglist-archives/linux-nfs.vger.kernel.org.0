Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7188F4EBEBC
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Mar 2022 12:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245353AbiC3K2H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Mar 2022 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbiC3K2H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Mar 2022 06:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EFC925FD6D
        for <linux-nfs@vger.kernel.org>; Wed, 30 Mar 2022 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648635981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c4bIFt9jVSIGZ2yyObkamPZtqAyQFwbbDREVYsapdgo=;
        b=En9f74pyyfrhUFB6HDpmBm69cA0l68e44NM8Jbvzw3wUbCgzwL4FTbGey5wCmCq9WjyYDc
        A2A+wjtyq3j8LlJWxBIEuhTqpoyIwvz16Kt+ZHUe8s/PXsQMNII8jrAKJlLdS1DpTcK8l6
        zb5Jp5DN/pdzmNmp1OBdUUUSJOc5Wmg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-WOcvhNmsOFG4j7yI-KFN_A-1; Wed, 30 Mar 2022 06:26:19 -0400
X-MC-Unique: WOcvhNmsOFG4j7yI-KFN_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DACA1801387;
        Wed, 30 Mar 2022 10:26:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B99540CF8F8;
        Wed, 30 Mar 2022 10:26:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <164859751830.29473.5309689752169286816.stgit@noble.brown>
References: <164859751830.29473.5309689752169286816.stgit@noble.brown>
To:     NeilBrown <neilb@suse.de>
Cc:     dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] MM changes to improve swap-over-NFS support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2923576.1648635976.1@warthog.procyon.org.uk>
Date:   Wed, 30 Mar 2022 11:26:16 +0100
Message-ID: <2923577.1648635976@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Do you have a branch with your patches on?

David

