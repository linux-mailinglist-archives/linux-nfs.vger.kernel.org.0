Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745B37E7021
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Nov 2023 18:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbjKIR0B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Nov 2023 12:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344547AbjKIR0A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Nov 2023 12:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F9535BB
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 09:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699550714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZSFCqalm3fCkkTNJ3JfrJEcT/KnwSWzYlkFvHnxFoo=;
        b=Oyy4Xa891H8toCKWIVSdU/gazTTBfUMGDLBadcvWX0VPmtbLUFREV1CvIg16oOn0QMRkdq
        bSsjxHPojdqs37mq40aGqezIp6CVXyX7sGoQpNWntHLq90zgRKvqNKgnoV5UzxX1kw5Xfm
        6LoMVQ1FruRBka91/SHEb3umjPkTIlc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-KHlAVaRkPP6YTAwHXaTVcQ-1; Thu, 09 Nov 2023 12:25:12 -0500
X-MC-Unique: KHlAVaRkPP6YTAwHXaTVcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43749811E92;
        Thu,  9 Nov 2023 17:25:12 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A75C640C6EB9;
        Thu,  9 Nov 2023 17:25:11 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com
Subject: Re: [PATCH v2 1/5] NFS: Fix error handling for O_DIRECT write
 scheduling
Date:   Thu, 09 Nov 2023 12:25:10 -0500
Message-ID: <4EBFA030-C144-4017-842F-B8D6B2ADC19A@redhat.com>
In-Reply-To: <44d134dd65a4c7194f5200a390e5229003ba4016.camel@hammerspace.com>
References: <20230904163441.11950-1-trondmy@kernel.org>
 <20230904163441.11950-2-trondmy@kernel.org>
 <02FDFFF6-8512-4BBA-845D-72C21864E621@redhat.com>
 <44d134dd65a4c7194f5200a390e5229003ba4016.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9 Nov 2023, at 11:53, Trond Myklebust wrote:
>
> Hi Ben,
>
> Relying on the value of dreq->bytes_left is just not a good idea, given
> that the layoutget request could end up returning NFS4ERR_DELAY.
>
> How about something like the following patch?

That looks promising!  I think ->bytes_left could get dropped after this.

I'll send it through some testing and report back, thanks!

Ben

