Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8335575B507
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGTQyR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 12:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjGTQyQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 12:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B735D1715
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689872014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rf54fJtTcxCN7XycZmLlr/YyYttA5IpYXVAqXzPUilU=;
        b=B7xrIBIH9e9YECON1+fT39dIdZEsioyEygridpJzkq1QLJu8lxqhgBDzN5QZ7aqHdhjS9Z
        ioywrmppvGtX2SJsYEoro3QiBB57aOaAp7JUuGyNSQeEjRlgoJTYZMQQNDd1GPLuqyoQ4K
        tiGeBzRPW5D9SEPVACps7PkTApKTsiw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-9i4lpJrQOY-wfVKCgktb4A-1; Thu, 20 Jul 2023 12:53:30 -0400
X-MC-Unique: 9i4lpJrQOY-wfVKCgktb4A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31ADE800159;
        Thu, 20 Jul 2023 16:53:30 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52B5D4A9004;
        Thu, 20 Jul 2023 16:53:27 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] NFSv4/pnfs: minor fix for cleanup path in
 nfs4_get_device_info
Date:   Thu, 20 Jul 2023 12:53:26 -0400
Message-ID: <BAB89FB2-C67B-417C-9C53-D3F06D781586@redhat.com>
In-Reply-To: <20230720153753.20497-1-pchelkin@ispras.ru>
References: <20230720153753.20497-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On 20 Jul 2023, at 11:37, Fedor Pchelkin wrote:

> It is an almost improbable error case but when page allocating loop in
> nfs4_get_device_info() fails then we should only free the already
> allocated pages, as __free_page() can't deal with NULL arguments.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

This looks correct to me.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

