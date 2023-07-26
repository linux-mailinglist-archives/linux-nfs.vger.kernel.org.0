Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD1763A4E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jul 2023 17:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjGZPHi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jul 2023 11:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjGZPHZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jul 2023 11:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05133A8F
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jul 2023 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690383874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EI959SVEy3Ab4UW5TDivuJY6YgnVvwsZSZueFfPsWoU=;
        b=RYr5Z41D0zIHNCmVRvnSlhD0RIwUC65QHIR1QdcbRcq1QrnEnBXHsI8PBceipVbz+jaL+D
        a+Nxsh1RDoK5Beh2OZeNMW9squniWC7sCYwgfTRaBKO2xyCUWZVbSTbzepwo3r2UwsKqSQ
        eVMAmd9irOS2FSxP453rZa/PPtfLY0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-JCcOZCaWPc-ty5pYiB2liQ-1; Wed, 26 Jul 2023 11:04:28 -0400
X-MC-Unique: JCcOZCaWPc-ty5pYiB2liQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBA3A800B35;
        Wed, 26 Jul 2023 15:04:27 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A7CDF782E;
        Wed, 26 Jul 2023 15:04:25 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Frank van der Linden <fllinden@amazon.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] NFSv4.2: fix error handling in nfs42_proc_getxattr
Date:   Wed, 26 Jul 2023 11:04:24 -0400
Message-ID: <4CA714BC-E458-4F90-B6D4-C61B5A8D61CF@redhat.com>
In-Reply-To: <20230725115900.23690-1-pchelkin@ispras.ru>
References: <20230725115900.23690-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 25 Jul 2023, at 7:58, Fedor Pchelkin wrote:

> There is a slight issue with error handling code inside
> nfs42_proc_getxattr(). If page allocating loop fails then we free the
> failing page array element which is NULL but __free_page() can't deal with
> NULL args.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: a1f26739ccdc ("NFSv4.2: improve page handling for GETXATTR")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Looks right to me,

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

