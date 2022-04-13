Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A5C4FFB19
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Apr 2022 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiDMQY3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Apr 2022 12:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiDMQY3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Apr 2022 12:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 338EE2E083
        for <linux-nfs@vger.kernel.org>; Wed, 13 Apr 2022 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649866927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D+1JpeO8JhQH4iNA0xitKOUU7IsW27o5XnyNdUHi9y0=;
        b=GoYBUo/kdmQZAdcgnFlvGx1F47Gip5SqdM7O7F+d+HkgqxdP1VlvgUmSSW9OEgm8gHNy6T
        v/JFunAPVb/m/9N/7BEeE1uETvFLMxTC0lovQZAWtUNwgJWA5IXu5HRZLmxjiCCxDwCdJi
        VMMUkByAwRJgqRbShtNP4POa8ISSn+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-4JLYiJ2YNqeWDuEW4eNSNw-1; Wed, 13 Apr 2022 12:22:06 -0400
X-MC-Unique: 4JLYiJ2YNqeWDuEW4eNSNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC75A1014A61
        for <linux-nfs@vger.kernel.org>; Wed, 13 Apr 2022 16:22:05 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA4B840CF8EA
        for <linux-nfs@vger.kernel.org>; Wed, 13 Apr 2022 16:22:05 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Patches from the list with Content-Type: application/octet-stream
Date:   Wed, 13 Apr 2022 12:22:05 -0400
Message-ID: <AA7D017B-F143-4493-B542-F8BCBEC86306@redhat.com>
In-Reply-To: <1EBC0B18-2233-4467-89E7-4351B4047E95@redhat.com>
References: <1EBC0B18-2233-4467-89E7-4351B4047E95@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Apr 2022, at 9:32, Benjamin Coddington wrote:

> Anyone know why the linux-nfs list is setting
>
> Content-Type: application/octet-stream
>
> mail header for patches?  It seems to have started sometime last week, and
> makes it difficult for me to quickly read patches.

Alice has pointed out that this isn't a vger.kernel.org issue, but seems
instead to be added by our local MTAs if the mailer hasn't set it yet.

I'll follow up on this problem with our local MTA service.
Ben

