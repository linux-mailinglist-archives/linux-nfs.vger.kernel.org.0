Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DB0763AB4
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jul 2023 17:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjGZPRi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jul 2023 11:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjGZPRU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jul 2023 11:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E375E2D4B
        for <linux-nfs@vger.kernel.org>; Wed, 26 Jul 2023 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690384574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A+RJ9bjdJOKdVlmB8tH5nWBvWZOXyXeNxJfoIL0LKjo=;
        b=hJA7PLzV8wOBEgxnjqjTkkCMESLVOTPqtqnzVTfrN2Ip608+gHI9x0dIxNNYnplaURbyQ/
        egMQX1kZ/xZREC8ipP01MlpgSgLy0OTmWbt+1DqjsTuHV4zcoDAlA4lSHUamsbL4RP1qVV
        5aovIWI5HFI/mclyDk6jUyleVoFIHCo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-vkyNeiwRM4eA3JvU8t_DXw-1; Wed, 26 Jul 2023 11:09:42 -0400
X-MC-Unique: vkyNeiwRM4eA3JvU8t_DXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D80261C05AA7;
        Wed, 26 Jul 2023 15:09:28 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F408145414B;
        Wed, 26 Jul 2023 15:09:27 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] NFSv4: fix out path in __nfs4_get_acl_uncached
Date:   Wed, 26 Jul 2023 11:09:26 -0400
Message-ID: <BC2D2754-5E16-408E-AC74-E1DD34821620@redhat.com>
In-Reply-To: <20230725115933.23784-1-pchelkin@ispras.ru>
References: <20230725115933.23784-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 25 Jul 2023, at 7:59, Fedor Pchelkin wrote:

> Another highly rare error case when a page allocating loop (inside
> __nfs4_get_acl_uncached, this time) is not properly unwound on error.
> Since pages array is allocated being uninitialized, need to free only
> lower array indices. NULL checks were useful before commit 62a1573fcf84
> ("NFSv4 fix acl retrieval over krb5i/krb5p mounts") when the array had
> been initialized to zero on stack.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 62a1573fcf84 ("NFSv4 fix acl retrieval over krb5i/krb5p mounts")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Nice one.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

