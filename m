Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B15F7303B7
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jun 2023 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343744AbjFNPYO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jun 2023 11:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbjFNPYN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Jun 2023 11:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA5199
        for <linux-nfs@vger.kernel.org>; Wed, 14 Jun 2023 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686756205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=diKKv+BaeU++Kkxbt3j674MAf9bH7QKC98izjBTVV10=;
        b=AAMQLVr3m1PhoCtp559cbosUq1+OMDwHBGKArt6XZH3bPysuTeJ8GbOooKpXLCYZp7/5QS
        n0Ccax94VqbIdH8vI4nxli9L1huYmnuPt1+73uBZcu/NihZ9uVSXpFLILaAUeNCQ4QJtqt
        pe4+aQySrdexpHC87yvQQtzkhpqXOOY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-fsSyVJ6TP-uEEan9Z80sLg-1; Wed, 14 Jun 2023 11:23:22 -0400
X-MC-Unique: fsSyVJ6TP-uEEan9Z80sLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D35513806738;
        Wed, 14 Jun 2023 15:23:21 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBAFE2166B25;
        Wed, 14 Jun 2023 15:23:20 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsroot: Fix missing check for return value of strsep()
Date:   Wed, 14 Jun 2023 11:23:19 -0400
Message-ID: <43531410-F066-4DE9-9FA7-990D2E5D878B@redhat.com>
In-Reply-To: <20230614143058.112300-1-cymi20@fudan.edu.cn>
References: <20230614143058.112300-1-cymi20@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 14 Jun 2023, at 10:30, Chenyuan Mi wrote:

> The strsep() function in root_nfs_parse_options() may return NULL
> if argument 'incoming' is NULL. Since 'incoming' has Null check in
> this function, it is also need to add Null check for return value
>  of strsep().

Incoming is checked to be non-NULL *before* sending it to strsep() here.

> Found by our static analysis tool.

The tool must be noticing that it is checked for NULL *after* strsep(),
which wouldn't matter to strsep() at all.

Ben

