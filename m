Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF37D6BF2
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjJYMfc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 08:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjJYMfb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 08:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B68F
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 05:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698237281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9rhzqr3NOHtVKCBuqfpDxgciMBYDCCCmcwS5w2Kpjs=;
        b=Y9ED11ktO8qFItO65EDXCdrEcGK7mILGUyt+s57fVnc3wgXu5Of3z71E2VsIpiiHtFsnK1
        m8VB9CJKwlLhDtQfmm/UOv65BX1DNg1T1U8w06wc89ev06tVen+SdtnfdUWQlLN0QUI95J
        vRNYznbzuSAVaG2g9oa2X+oR8ulSQi4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-FJPbped1NaSK3-7XS-bRXg-1; Wed,
 25 Oct 2023 08:34:38 -0400
X-MC-Unique: FJPbped1NaSK3-7XS-bRXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A91512812940;
        Wed, 25 Oct 2023 12:34:37 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6593725C0;
        Wed, 25 Oct 2023 12:34:36 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] NFS: Fix an off by one in root_nfs_cat()
Date:   Wed, 25 Oct 2023 08:34:35 -0400
Message-ID: <11A69D01-44A5-4261-BF9B-EC3A1209E3F1@redhat.com>
In-Reply-To: <7f97bb62c4e8137c5d7f7a7a30789440a5102b3f.1698183837.git.christophe.jaillet@wanadoo.fr>
References: <7f97bb62c4e8137c5d7f7a7a30789440a5102b3f.1698183837.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 Oct 2023, at 17:47, Christophe JAILLET wrote:

> The intent is to check if the 'dest' is truncated or not. So, >+ should be
> used instead of >, because strlcat() returns the length of 'dest' and 'src'
> excluding the trailing NULL.
>
> Fixes: 56463e50d1fc ("NFS: Use super.c for NFSROOT mount option parsing")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Minor typo in the body: >+ should be >=, otherwise looks right.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

