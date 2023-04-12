Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8007B6DFCF6
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Apr 2023 19:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjDLRuz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Apr 2023 13:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDLRuy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Apr 2023 13:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317CDFC
        for <linux-nfs@vger.kernel.org>; Wed, 12 Apr 2023 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681321807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hnZ5k4BHyhwu/T9VXcpDYH9Iz7d7quDe+qt6+xIJOiU=;
        b=UFZlVTqC1krN061sVe6AyiZzMJOegxf+KaZ18wraLOsDixoA7DvjucnyadX4AyHjMdZxxv
        pfBhj+MjhBcLteDXDkcUU1F1NQF7CtRQR3kVtf/pmklSfdkniCl/Bb/H/4T5oXCMcRC3G2
        jC5MG/w8NBcDk1XpCNbtG7pv8t3lvJo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-eVTk2QV6PrOoRmuWS89lzg-1; Wed, 12 Apr 2023 13:50:05 -0400
X-MC-Unique: eVTk2QV6PrOoRmuWS89lzg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C648E1C08967;
        Wed, 12 Apr 2023 17:50:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA6B6492C14;
        Wed, 12 Apr 2023 17:50:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZDbuFO+f8FCvrawH@aion.usersys.redhat.com>
References: <ZDbuFO+f8FCvrawH@aion.usersys.redhat.com> <380323.1681314997@warthog.procyon.org.uk> <48886D84-1A04-4B07-A666-BB56684E759F@oracle.com>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     dhowells@redhat.com, Chuck Lever III <chuck.lever@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: Did the in-kernel Camellia or CMAC crypto implementation break?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <385662.1681321803.1@warthog.procyon.org.uk>
Date:   Wed, 12 Apr 2023 18:50:03 +0100
Message-ID: <385663.1681321803@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Scott Mayhew <smayhew@redhat.com> wrote:

> Yes, I found that if I run the test via kunit.py it works fine.  If I
> try to run it via loading the gss_krb5_test module, the checksum tests
> fail.  But if I build the tests directly into the kernel, then they also
> run fine.

I have them built into the kernel, both in sunrpc and my krb5 lib.  Both are
failing.

David

