Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4456767EB4D
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jan 2023 17:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjA0Qn5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Jan 2023 11:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjA0Qn4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Jan 2023 11:43:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1967D86627
        for <linux-nfs@vger.kernel.org>; Fri, 27 Jan 2023 08:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674837745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T3WdbdwIuWIW0ATUUETVXlWiWT0w0MulD32ZVf4uzQc=;
        b=b36bONmkWsFmGpYJBxQ+zEvYU7d8SWp+UsW0XDbZ2eJ5jkAxNUcuPUDkiCCUhhvHvht5IJ
        wbZva6BP5ZVj1+S8WXvCTgIvQ+I7F/6GHUUB7ZT9UKTvWhMgIjQsSJRqv5VZF41tMKyPHa
        KrouiVft9bXfpQjfqpVfb1FB1C6888Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-grW1VFAIPyyWBgJseMO-wg-1; Fri, 27 Jan 2023 11:42:21 -0500
X-MC-Unique: grW1VFAIPyyWBgJseMO-wg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4110B1816EC0;
        Fri, 27 Jan 2023 16:42:21 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEE892026D4B;
        Fri, 27 Jan 2023 16:42:20 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix race to check ls_layouts
Date:   Fri, 27 Jan 2023 11:42:18 -0500
Message-ID: <49815925-FB60-456F-8633-79B4C203B782@redhat.com>
In-Reply-To: <C9FA580A-52A6-4208-AFA2-91E8BCB36B9F@oracle.com>
References: <979eebe94ef380af6a5fdb831e78fd4c0946a59e.1674836262.git.bcodding@redhat.com>
 <C9FA580A-52A6-4208-AFA2-91E8BCB36B9F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 27 Jan 2023, at 11:34, Chuck Lever III wrote:

>> On Jan 27, 2023, at 11:18 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> Its possible for __break_lease to find the layout's lease before we've
>> added the layout to the owner's ls_layouts list.  In that case, setting
>> ls_recalled = true without actually recalling the layout will cause the
>> server to never send a recall callback.
>>
>> Move the check for ls_layouts before setting ls_recalled.
>>
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>
> Did this start misbehaving recently, or has it always been broken?
> That is, does it need:
>
> Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls") ?

I'm doing some new testing of racing LAYOUTGET and CB_LAYOUTRETURN after
running into a livelock, so I think it has always been broken and the Fixes
tag is probably appropriate.

However, now I'm wondering if we'd run into trouble if ls_layouts could be
empty but the lease still exist..  but that seems like it would be a
different bug.

Ben

