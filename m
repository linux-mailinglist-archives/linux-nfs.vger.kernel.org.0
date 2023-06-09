Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE72729C1D
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jun 2023 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjFIOBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Jun 2023 10:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjFIOBj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Jun 2023 10:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C1D35BB
        for <linux-nfs@vger.kernel.org>; Fri,  9 Jun 2023 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686319242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OucUd27DsolH1DodPgH8qA0WeWQeDcM9JHesA6i32JM=;
        b=BOPK9EYhJ1UOv06pmDNMimtmZ32MDkdd0arz7/uEsf+//yI+1GxIAiM4CLOflWu+25qzBz
        anUw9Jtn/7Qci0HYXFXWcz8dyvj/S9rc0+mS1k/XApMpGp3DvCLoREiwmccJ0GAdFX6N7x
        GPPr1V+6xKvqgrADAPuOYH6Ug0W6vj4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-0Qk7w8cUNResrkHE4hrkIw-1; Fri, 09 Jun 2023 10:00:39 -0400
X-MC-Unique: 0Qk7w8cUNResrkHE4hrkIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 961E685A5BF;
        Fri,  9 Jun 2023 14:00:36 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC1DF20268C6;
        Fri,  9 Jun 2023 14:00:35 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>, anna@kernel.org,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs4: don't map EACCESS and EPERM to EIO
Date:   Fri, 09 Jun 2023 10:00:34 -0400
Message-ID: <83016291-825A-4A16-B7A8-8B492A47CD5A@redhat.com>
In-Reply-To: <1144390245.427543.1686317435856.JavaMail.zimbra@desy.de>
References: <20230608144933.412664-1-tigran.mkrtchyan@desy.de>
 <cfde2b7b2a7f24f2652ce0bb82727cb0b810c758.camel@hammerspace.com>
 <AD6C85BF-50F9-42BB-83E8-16BCE03D3CF1@desy.de>
 <437767d036ee95a7ce92d7fa2add82a441eedf78.camel@hammerspace.com>
 <1144390245.427543.1686317435856.JavaMail.zimbra@desy.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9 Jun 2023, at 9:30, Mkrtchyan, Tigran wrote:

> Hi Trond,
>
> Obviously, the patch is incorrect. The behavior of the upstream kernel and
> RHEL kernels are different.

RHEL-9 should be ok here.

There's a few things we need to be fixing for RHEL-8.9.  This is one of them.
https://bugzilla.redhat.com/show_bug.cgi?id=2213828

Ben

