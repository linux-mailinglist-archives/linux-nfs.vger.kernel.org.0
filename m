Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E9762DCD6
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 14:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiKQNbr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 08:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiKQNbq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 08:31:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853A871F00
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 05:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668691844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3RAbJCl/fhcop9wct6HLY/Xc5cASW2kdLAtpYvmNUTU=;
        b=Ek66jzDZlkQ45RKgXYAbuvypwqv48eae7/ocNxTAv8/EZRnA/5Rr4QdlZEuvxqzQx4pgMp
        040CsyeCf92A1vBqIJXa1hLipYQzUtdctlXHMw5DluDtyalFkV/0n41IPP/q3TPRwdd3vg
        k7dhL/dlc267IVu64tkoQQsXaGp3jaY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-N1_wWIDOMqem0Z8OZM_0yA-1; Thu, 17 Nov 2022 08:30:41 -0500
X-MC-Unique: N1_wWIDOMqem0Z8OZM_0yA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BD063C0D180;
        Thu, 17 Nov 2022 13:30:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E55F40C6EC3;
        Thu, 17 Nov 2022 13:30:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221117115023.1350181-2-dwysocha@redhat.com>
References: <20221117115023.1350181-2-dwysocha@redhat.com> <20221117115023.1350181-1-dwysocha@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, Daire Byrne <daire.byrne@gmail.com>,
        Benjamin Maynard <benmaynard@google.com>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] fscache: Fix oops due to race with cookie_lru and use_cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3715747.1668691837.1@warthog.procyon.org.uk>
Date:   Thu, 17 Nov 2022 13:30:37 +0000
Message-ID: <3715748.1668691837@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dave Wysochanski <dwysocha@redhat.com> wrote:

> If a cookie expires from the LRU and the LRU_DISCARD flag is set,
> but the state machine has not run yet, it's possible another thread
> can call fscache_use_cookie and begin to use it.  When the
> cookie_worker finally runs, it will see the LRU_DISCARD flag set,
> transition the cookie->state to LRU_DISCARDING, which will then
> withdraw the cookie.  Once the cookie is withdrawn the object is
> removed the below oops will occur because the object associated
> with the cookie is now NULL.
> 
> Fix the oops by clearing the LRU_DISCARD bit if another thread
> uses the cookie before the cookie_worker runs.

I think this is the right approach.  The state machine should just fall
through without doing anything, despite having been woken.

David

