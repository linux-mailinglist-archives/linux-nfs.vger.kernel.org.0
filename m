Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0236E7EE5CB
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Nov 2023 18:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjKPRSG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 12:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjKPRSD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 12:18:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0223B101
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 09:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700155080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6eaUN7akebxjqP47KvyhLwS4CX2CVpk5q8H7GHDgTpE=;
        b=Ch99/xPaLDaqPvATR9vt/CBGAbaVezeocr7Ic8HIX8/2AAxY4HZL9bsTxcA12YN35ue7ru
        xAp7y/+zr4epzvrOKSlTuV0KURw8jFCYOkgTa4N9sf8ZLnsA9u4hI7bGBcBBPjjzBvZCL8
        t6+W1joQoFyYqRQni9hGG+viJqhRORY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-dlmzS6DCPHaUqcuOFfPxeA-1; Thu, 16 Nov 2023 12:17:57 -0500
X-MC-Unique: dlmzS6DCPHaUqcuOFfPxeA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9927C185A785
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 17:17:57 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 526B5492BFE
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 17:17:57 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Blocklayoutdriver deadlock with knfsd
Date:   Thu, 16 Nov 2023 12:17:55 -0500
Message-ID: <3A3EABED-888C-40B1-9929-B4CCDB646BA0@redhat.com>
In-Reply-To: <1CC82EC5-6120-4EE4-A7F0-019CF7BC762C@redhat.com>
References: <1CC82EC5-6120-4EE4-A7F0-019CF7BC762C@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Nov 2023, at 12:11, Benjamin Coddington wrote:

> I ran into this old problem again recently, last discussed here:
> https://lore.kernel.org/linux-nfs/F738DB31-B527-4048-94A7-DBF00533F8C1@=
redhat.com/#t
>
> Problem is that clients can easily issue enough WRITEs that end up in
>
> __break_lease
> xfs_break_leased_layouts
> ...
> nfsd_vfs_write
> ...
> svc_process
> svc_recv
> nfsd
>
> .. so that all the knfsds are there, and nothing can process the
> LAYOUTRETURN.
>
> I'm pretty sure we can make the linux client a bit smarter about it (I =
saw
> one LAYOUTGET and one conflicting WRITE in the same TCP segment, in tha=
t
> order).

Actually, I can't imagine any block/SCSI/NVMe server implementation that
would be fine with a client writing to the device at the same time the se=
rver
does, and so why shouldn't the client preemptively return the layout?

Ben

