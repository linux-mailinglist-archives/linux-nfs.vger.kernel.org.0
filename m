Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF334595ED8
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Aug 2022 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiHPPPg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Aug 2022 11:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiHPPPT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Aug 2022 11:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4288174363
        for <linux-nfs@vger.kernel.org>; Tue, 16 Aug 2022 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660662915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2BJPLzBCkQ7/C8SjM6cs7Dqcq6n9EfCcJ5ipAL7bprk=;
        b=XDUH8kEuOMQMjJ9Nk4VW8U1AyTAOOFyZen/PrPECPcqgrdi2IIdNwFP4SkatIlLajAR6oI
        B7h6LBSYYXZ/oZRL1X8kb0SvyIARGrm4stIVDXi4Mnw4BMKw71Yl2L6HdYN92k9PZlVCqe
        N55TGqQBYCy1lAUNsIiYMI4z0BP/1Es=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-RdpwO5JfPpywgyNrBQY1QQ-1; Tue, 16 Aug 2022 11:15:12 -0400
X-MC-Unique: RdpwO5JfPpywgyNrBQY1QQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD2A78339C3;
        Tue, 16 Aug 2022 15:15:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDD5F2166B29;
        Tue, 16 Aug 2022 15:15:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ef692314ada01fd2117b730ef0afae50102974f5.camel@kernel.org>
References: <ef692314ada01fd2117b730ef0afae50102974f5.camel@kernel.org> <20220816134419.xra4krb3jwlm4npk@wittgenstein> <20220816132759.43248-1-jlayton@kernel.org> <20220816132759.43248-2-jlayton@kernel.org> <4066396.1660658141@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
        viro@zeniv.linux.org.uk, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org
Subject: Re: [PATCH 1/4] vfs: report change attribute in statx for IS_I_VERSION inodes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12636.1660662903.1@warthog.procyon.org.uk>
Date:   Tue, 16 Aug 2022 16:15:03 +0100
Message-ID: <12637.1660662903@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> I think we'll just have to ensure that before we expose this for any
> filesystem that it conforms to some minimum standards. i.e.: it must
> change if there are data or metadata changes to the inode, modulo atime
> changes due to reads on regular files or readdir on dirs.
> 
> The local filesystems, ceph and NFS should all be fine. I guess that
> just leaves AFS. If it can't guarantee that, then we might want to avoid
> exposing the counter for it.

AFS monotonically increments the counter on data changes; doesn't make any
change for metadata changes (other than the file size).

But you can't assume NFS works as per your suggestion as you don't know what's
backing it (it could be AFS, for example - there's a converter for that).

Further, for ordinary disk filesystems, two data changes may get elided and
only increment the counter once.  And then there's mmap...

It might be better to reduce the scope of your definition and just say that it
must change if there's a data change and may also be changed if there's a
metadata change.

David

