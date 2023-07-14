Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A687A753EA8
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 17:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjGNPUO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjGNPUO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 11:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875371BD4
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689347967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9IvDhb5ELJqXrzg3Tr0Ch4TKzHEZqp43o44UDZzYcdE=;
        b=BUZE28FRznpYQHYhrfIsgCBCS5pffRWlN3lJM1bbfeoLg+402CCxG4CpmJAtE0pMntCA/p
        J26F2q+JUYDk4Ppr8IDi53YwJBCOom0cJEjTDeXKH3im8gfTo+MyITvxzG70qembY/bvF3
        sXIDek7jg/aoTDDg5Z9ArSAcGgzR+DA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-CRZYOMIIOWu9c2hisvyrQw-1; Fri, 14 Jul 2023 11:19:22 -0400
X-MC-Unique: CRZYOMIIOWu9c2hisvyrQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D351980006E;
        Fri, 14 Jul 2023 15:19:21 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2426240C2063;
        Fri, 14 Jul 2023 15:19:20 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Kinglong Mee <kinglongmee@gmail.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH] nfs: fix redundant readdir request after get eof
Date:   Fri, 14 Jul 2023 11:19:19 -0400
Message-ID: <70B9A332-FDA0-418E-81CF-962229E93AC5@redhat.com>
In-Reply-To: <CAB6yy359Gvdu=v1ZvTLXPoY2EMtER3_cBVDKc4MQYhaMOjcUSw@mail.gmail.com>
References: <8d6d9329-f5f1-2f15-f578-e4f8010b9b02@gmail.com>
 <5E28252D-6EA1-4DD9-A5B3-957E13589982@redhat.com>
 <CAB6yy359Gvdu=v1ZvTLXPoY2EMtER3_cBVDKc4MQYhaMOjcUSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Jul 2023, at 23:07, Kinglong Mee wrote:

> Hi Ben,
>
...
> Comparing with the above one, this seems work.

This fixes it for me and keeps the optimization.  Its quite a subtle bit of
logic - maybe a comment is appropriate?  One non-intuitive thing here is
that array->size == 19 for a directory with 18 entries, since we count the
"eof" entry as a blank entry instead of the last real entry.

Ben

