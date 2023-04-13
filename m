Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB49F6E10B7
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Apr 2023 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjDMPNA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Apr 2023 11:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjDMPM7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Apr 2023 11:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5543B47F
        for <linux-nfs@vger.kernel.org>; Thu, 13 Apr 2023 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681398712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZEvAbrWHZmI+R0aeT5QQCncd8FNt8T5KkXSjokG1Df0=;
        b=RNZF1yS83ucU3RRe20HBYlAAshuwB94tS8gcJ/mhwnD1vof48dsA2JZ7ftzMw8sGNFxt2o
        +5sKw8fI6rU+AkrZL1LhTrR7jAdbxCewb+Rg4gXb9BukNcCh8fTxtcJW1s5ONb9TnC40MR
        oD2f9Zx3YIW6hwL47Nqui7iXcIr+kmg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-EGd4aHdjPxKCHh3DijJDVw-1; Thu, 13 Apr 2023 11:11:44 -0400
X-MC-Unique: EGd4aHdjPxKCHh3DijJDVw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 300861C087A1;
        Thu, 13 Apr 2023 15:11:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DD922027045;
        Thu, 13 Apr 2023 15:11:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZDgTrsTIsYvF78nP@aion.usersys.redhat.com>
References: <ZDgTrsTIsYvF78nP@aion.usersys.redhat.com> <1078410.1681393916@warthog.procyon.org.uk>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     dhowells@redhat.com, Chuck Lever <chuck.lever@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: Fix RFC6803 encryption test
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1113059.1681398702.1@warthog.procyon.org.uk>
Date:   Thu, 13 Apr 2023 16:11:42 +0100
Message-ID: <1113060.1681398702@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Scott Mayhew <smayhew@redhat.com> wrote:

> I still see the failures with this patch applied.  The rfc6803 checksum
> tests run before the rfc6803 encryption tests, so I'm not sure how this
> would help.

It fixes the failure I was getting; it doesn't mean there aren't other bugs.

David

