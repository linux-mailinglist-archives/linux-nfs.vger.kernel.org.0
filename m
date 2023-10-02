Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A987B5BE4
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Oct 2023 22:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjJBUR6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Oct 2023 16:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJBUR5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Oct 2023 16:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACDBB7
        for <linux-nfs@vger.kernel.org>; Mon,  2 Oct 2023 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696277827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LOIeyzyBBTzDeBQ3c0LeWGcGBvFSKm0ymMOwVybD/5E=;
        b=ZyMA3gaiPV8ORFMRILBteAHba2zSkM15hbB/JAs1bO4JAFrkwUN+SNq7kWnGlXspTqG8x3
        hwhPgvIeOU7+o/DzjQ/BWufhrKZdU3k+J+5uRQbVYIlW8opIlnyUT5QXS1emz4ZQgj3Q6o
        S2nguWDqq/7DsxlZfdL2y47HC5Ggut8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-WXmXWeiROTaovMdZXPD4yg-1; Mon, 02 Oct 2023 16:17:01 -0400
X-MC-Unique: WXmXWeiROTaovMdZXPD4yg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0623185A79B;
        Mon,  2 Oct 2023 20:17:00 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16F862156701;
        Mon,  2 Oct 2023 20:16:59 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFS: Fix potential oops in nfs_inode_remove_request()
Date:   Mon, 02 Oct 2023 16:16:58 -0400
Message-ID: <E72F7FD9-6613-461D-A64D-BD23132F8F75@redhat.com>
In-Reply-To: <20230725150807.8770-2-smayhew@redhat.com>
References: <20230725150807.8770-1-smayhew@redhat.com>
 <20230725150807.8770-2-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 25 Jul 2023, at 11:08, Scott Mayhew wrote:

> Once a folio's private data has been cleared, it's possible for another
> process to clear the folio->mapping (e.g. via invalidate_complete_folio2
> or evict_mapping_folio), so it wouldn't be safe to call
> nfs_page_to_inode() after that.
>
> Fixes: 0c493b5cf16e ("NFS: Convert buffered writes to use folios")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>

Ben

