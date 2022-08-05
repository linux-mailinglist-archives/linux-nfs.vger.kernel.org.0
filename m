Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3384F58ABC4
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Aug 2022 15:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiHENnZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Aug 2022 09:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbiHENnX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Aug 2022 09:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0DCD248F8
        for <linux-nfs@vger.kernel.org>; Fri,  5 Aug 2022 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659707001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igi80iPjpA0KzxzMwA83MX2LOBEAPPVwmOqawso8N0w=;
        b=b6rNF4gCsIR6cBLmFqt9Io7pZe9Ti+7FwXXRiBLR5zKpO3wAVX1zJ6UJ+8NcEXW1/bbQEx
        uk2W9bUuNPGRQDD3VsCCAeYNapvGWRfoytqZo6MNMvua9xKGQHuSTP168JOYW7gDqhLEJ8
        KVgpqybS/xNJoJudQa74qDPEY8AW/CQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-FLYBmdePNGW6Y_1HaqsnKA-1; Fri, 05 Aug 2022 09:43:17 -0400
X-MC-Unique: FLYBmdePNGW6Y_1HaqsnKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3018C100AF91;
        Fri,  5 Aug 2022 13:43:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 934234010D27;
        Fri,  5 Aug 2022 13:43:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <b767fd4f14469005035eca04cc74ea5222601566.camel@kernel.org>
References: <b767fd4f14469005035eca04cc74ea5222601566.camel@kernel.org> <165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfs: Fix automount superblock LSM init problem, preventing sb sharing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2835065.1659706995.1@warthog.procyon.org.uk>
Date:   Fri, 05 Aug 2022 14:43:15 +0100
Message-ID: <2835066.1659706995@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> I hit a problem when testing this:

	if (reference) {

should be:

	if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {

in both selinux and smack.

David

