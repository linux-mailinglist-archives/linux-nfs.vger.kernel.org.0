Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A225A2A30
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 16:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiHZO7U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242617AbiHZO7S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 10:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7570D99CE
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661525957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4sT6cPObYVYFGAbshMuSoJcQWCc0YuGMsMFW5ouDLCM=;
        b=H3HdVnHMUKVZPS9q9SVWe6D4ITne47ncdeyHKIxTGxbVtF/Fw2NnGRAAy3iZQV0XT1QDyN
        Md5mCYR6/19HO0x7HNngBJSfRANAWiHpTTuU2E+6jUfhsKqr2epJA50tjshKVsITqIVYrk
        zkKcekuQHuUpXmnV0cd1TGtPyDHFgwM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-XY6yH73iNfGfB8IMedfifA-1; Fri, 26 Aug 2022 10:59:13 -0400
X-MC-Unique: XY6yH73iNfGfB8IMedfifA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 869EB3C11720;
        Fri, 26 Aug 2022 14:59:12 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA23BC15BB3;
        Fri, 26 Aug 2022 14:59:11 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     neilb@suse.de, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Date:   Fri, 26 Aug 2022 10:59:09 -0400
Message-ID: <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>
In-Reply-To: <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>
 <165274805538.17247.18045261877097040122@noble.neil.brown.name>
 <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>
 <165274950799.17247.7605561502483278140@noble.neil.brown.name>
 <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>
 <165275056203.17247.1826100963816464474@noble.neil.brown.name>
 <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 May 2022, at 21:36, Trond Myklebust wrote:
> So until you have a different solution that doesn't impact the client's
> ability to cache permissions, then the answer is going to be "no" to
> these patches.

Hi Trond,

We have some folks negatively impacted by this issue as well.  Are you
willing to consider this via a mount option?

Ben

