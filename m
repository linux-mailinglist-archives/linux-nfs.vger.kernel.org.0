Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B5B622B83
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Nov 2022 13:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiKIM21 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Nov 2022 07:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKIM20 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Nov 2022 07:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C92C11C
        for <linux-nfs@vger.kernel.org>; Wed,  9 Nov 2022 04:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667996850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7WXiclAYoJ7uWURPKEcMedmxWv7P5d2eqAf3c29ZlSg=;
        b=Pib/9KjEdLNgaMNNu0mfosLBB6VRLqYiJLdDEID5SyFn9FiuLlRadf7ypWPArf7fyEGYfG
        p1QGq5EQfrLmGlLLxBoXMqXaBF7uTufiV6goTQtxLDDC6sImPxcGh0VKYFjkv9swMd/wwW
        6YeVDy11GbOxnVXUtJK+y6rOQEeMuyM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-3YK-aZx0MIuqaIDjnQcn9A-1; Wed, 09 Nov 2022 07:27:26 -0500
X-MC-Unique: 3YK-aZx0MIuqaIDjnQcn9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10742101A528;
        Wed,  9 Nov 2022 12:27:26 +0000 (UTC)
Received: from [10.22.32.142] (unknown [10.22.32.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BAC440C2086;
        Wed,  9 Nov 2022 12:27:25 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        trond.myklebust@primarydata.com
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Add an explanation of NFSv4 client
 identifiers
Date:   Wed, 09 Nov 2022 07:27:24 -0500
Message-ID: <BC4D4B10-93F7-4B91-B998-87B0E2D3D551@redhat.com>
In-Reply-To: <165029751204.8305.958477650360928356.stgit@bazille.1015granger.net>
References: <165029751204.8305.958477650360928356.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 18 Apr 2022, at 11:58, Chuck Lever wrote:

> To enable NFSv4 to work correctly, NFSv4 client identifiers have
> to be globally unique and persistent over client reboots. We
> believe that in many cases, a good default identifier can be
> chosen and set when a client system is imaged.
>
> Because there are many different ways a system can be imaged,
> provide an explanation of how NFSv4 client identifiers and
> principals can be set by install scripts and imaging tools.
>
> Additional cases, such as NFSv4 clients running in containers, also
> need unique and persistent identifiers. The Linux NFS community
> sets forth this explanation to aid those who create and manage
> container environments.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  .../filesystems/nfs/client-identifier.rst          |  216 ++++++++++++++++++++
>  Documentation/filesystems/nfs/index.rst            |    2
>  2 files changed, 218 insertions(+)
>  create mode 100644 Documentation/filesystems/nfs/client-identifier.rst
>

8< ---

> +Linux provides two mechanisms to add uniqueness to its "co_ownerid"
> +string:
> +
> +    nfs.nfs4_unique_id
> +      This module parameter can set an arbitrary uniquifier string
> +      via the kernel command line, or when the "nfs" module is
> +      loaded.
> +
> +    /sys/fs/nfs/client/net/identifier
> +      This virtual file, available since Linux 5.3, is local to the
> +      network namespace in which it is accessed and so can provide
> +      distinction between network namespaces (containers) when the
> +      hostname remains uniform.

Docs are currently wrong because the path is actually:

/sys/fs/nfs/net/nfs_client/identifier

as originally created on bf11fbdb20b38.

It would be trivial to change the docs, but I have to say I think the
"nfs_client" path component is redundant.  The docs version with "client"
also seems redundant, since /sys/fs/nfs should only every contain client
things.

Is it too late to move things a bit?

Ben

