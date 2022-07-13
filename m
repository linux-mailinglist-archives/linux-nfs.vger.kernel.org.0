Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A8F573749
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 15:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiGMNWs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 09:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGMNWs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 09:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EFB8B4AE
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657718566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F/+E1ECi0puEBFInlLKBbyX4jpamV3J0oFs83DRhKdQ=;
        b=G9H69o8aas1M9Psf3yfmHRqvWGgbeoM76IxN/Zv55yHQp6tMvHx3TUAWkl7C9CRkRNsd2w
        pvikxyz3lkkda/lob/sxBa5rbSKg3MrVl8+Bf6hpzkwSloGCM5SPl9tLizJ45fzr7yWV54
        yP1FFTudpZNM7BK6VzDs5a7gE1mzW/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-HqEJF0RjNO-p8TOFhIgt1A-1; Wed, 13 Jul 2022 09:22:41 -0400
X-MC-Unique: HqEJF0RjNO-p8TOFhIgt1A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E70D101A586;
        Wed, 13 Jul 2022 13:22:41 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57FB0492C3B;
        Wed, 13 Jul 2022 13:22:40 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Rick Macklem" <rmacklem@uoguelph.ca>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        trondmy@hammerspace.com
Subject: Re: [PATCH v2 00/15] RPC-with-TLS client side
Date:   Wed, 13 Jul 2022 09:22:39 -0400
Message-ID: <1FDB511A-646F-4E37-B95F-F83E1ED26796@redhat.com>
In-Reply-To: <YQBPR0101MB9742D7F0D54EB37CE9B476C4DD899@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
 <c9b6787ba9154d1f4c2bf25387a35453ad20badb.camel@kernel.org>
 <F713FAF6-8910-4BA2-86C6-C5B09223AC0F@oracle.com>
 <YQBPR0101MB9742D7F0D54EB37CE9B476C4DD899@YQBPR0101MB9742.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12 Jul 2022, at 20:51, Rick Macklem wrote:

> As I already posted to Jeff, I can put the server up for
> a day or two at any time anyone would like to test
> against it.
>
> It now does TLS1.3 and I'll note the one thing the
> server did that caught the FreeBSD client "off guard"
> was it sends a couple of post handshake handshake
> records. (The FreeBSD client now just tosses these away.)
>
> Just email if/when you'd like to test, rick

Hey Chuck, is the bakeathon root or intermediate certificate published
somewhere so we can add them to our trust stores?

Ben

