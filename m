Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899427A1FDE
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 15:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjIONch (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 09:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjIONch (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 09:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD79610D
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694784705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S0TIYmiW6p58jTwEZIsa+5WBhcBcc6l39GUojlBKEL8=;
        b=NZjtZa/mVtvxjz5DrnV8+AxbMx7A1j1uKLfNCntcClBteIQlEN7BS7MJDjfTnrpNF+Bhm4
        xlci5LesLiaHwgHgF/brWErKKPESnQx2NObdVxn8WeLPguc1aagPFuxfMFSbyul5OOBShd
        52Zm6Sv7Wr7Go/UwPwHJSEee8qGDCJA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-Pj6mq7h1NA-oZ2da2V8D1g-1; Fri, 15 Sep 2023 09:31:44 -0400
X-MC-Unique: Pj6mq7h1NA-oZ2da2V8D1g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBAF318162CD
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 13:31:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62A7910F1BE7;
        Fri, 15 Sep 2023 13:31:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230608214137.856006-1-dwysocha@redhat.com>
References: <20230608214137.856006-1-dwysocha@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] netfs: Only call folio_start_fscache() one time for each folio
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3629818.1694784702.1@warthog.procyon.org.uk>
Date:   Fri, 15 Sep 2023 14:31:42 +0100
Message-ID: <3629819.1694784702@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Okay, this looks reasonable.  Should I apply Jeff's suggestion before I send
it to Linus?

David

