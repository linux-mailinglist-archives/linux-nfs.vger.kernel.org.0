Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE927EE0AE
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 13:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjKPMaO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 07:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPMaO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 07:30:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A22DD
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 04:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700137810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vHqjvMiU4Zn1b5ADn/ffz6ZK8IxbKrqjpsxEnn6yJCE=;
        b=Cb2x1Nz56CvQEa5ukmEBxFMyqw/e0pRJbTUKM+7zXdfG7jV8stFU2//dFGgPgcxOpnqZHA
        sTOypiV/RGdqbRwjQDlOEFHj1pbXUR2C7lq8vFXNo11V/6N7RvZh+Uhn3V6SoFYdghvNzY
        XYDB9a1v5ZUTTgekD0ZgFlDS8Y4xOZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-_IVBHS8VN0yqq-lphjJHNQ-1; Thu, 16 Nov 2023 07:30:07 -0500
X-MC-Unique: _IVBHS8VN0yqq-lphjJHNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0418101A54C;
        Thu, 16 Nov 2023 12:30:06 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4128F492BFD;
        Thu, 16 Nov 2023 12:30:06 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Martin Wege <martin.l.wege@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Does NFSv4 close-to-open consistency work with server "async"
 mount open?
Date:   Thu, 16 Nov 2023 07:30:04 -0500
Message-ID: <08A8C65F-5755-41DC-B29A-DE168B23C968@redhat.com>
In-Reply-To: <CANH4o6PU1p6NzS3X6ohGFPjzxKXr3gXn70s-VV+HSzAAPbWyvQ@mail.gmail.com>
References: <CANH4o6PU1p6NzS3X6ohGFPjzxKXr3gXn70s-VV+HSzAAPbWyvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Nov 2023, at 2:11, Martin Wege wrote:

> Hello,
>
> Does NFSv4 close-to-open consistency on the client work with server
> "async" mount open?

Yes, I believe it should, but I am looking at knfsd code and I think it
won't.

> We see several build errors here with parallel GNU Makefile update,
> where one process writes a file, exists, and the next process doesn't
> see all data (linker ar: file too short).
> But if you manually look at it the files are OK, and completely written.
>
> What is this? NFSv4 client bug, NFSv4 server bug, admin error (async
> breaking close-to-open consistency?

Hard to say, a wire capture would show.  My guess is that the server's
"async" disables the write gather in nfsd_vfs_write().

> Also, is close-to-open consistency guaranteed between different NFSv4 clients?

Yes.

Ben

