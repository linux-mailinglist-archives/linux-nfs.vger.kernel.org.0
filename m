Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE6072D00B
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjFLUCB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 16:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjFLUB7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 16:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9111734
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686600004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CNgGuR06BZ5D8e7Hlmso6kySTcqrBo2A1PCoyFRlJRs=;
        b=h3cqG2QPPxv9M2bwQ4/ucnYH80xH2938XEPqqeW3bJlgxAuFEk6TxrKSVw/alDLNSduI5v
        aft8sl0/9fVyXqdpt6BOOC13DfSbsZ/ZrS4gAkN1OUeGp3tJfJdF4NLWYM9I1PDWjTF0Qw
        7j/PGJl4X9heC1mL4myd/k8Xa2nHc3A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-l9a6rvYeP-mr1TsoT5ztdg-1; Mon, 12 Jun 2023 16:00:02 -0400
X-MC-Unique: l9a6rvYeP-mr1TsoT5ztdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D02E9811E8D;
        Mon, 12 Jun 2023 20:00:01 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC89940D1B60;
        Mon, 12 Jun 2023 20:00:00 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>, cperl@janestreet.com,
        linux-nfs@vger.kernel.org, willy@infradead.org
Subject: Re: Too many ENOSPC errors
Date:   Mon, 12 Jun 2023 15:59:59 -0400
Message-ID: <F1367691-87B4-405A-A013-45D0124B4011@redhat.com>
In-Reply-To: <efed50ed4c1487703436139cd26b37ca536031ef.camel@kernel.org>
References: <CAAih9mhU-UKGvSKBsCqRmkN6zvsD_ThofU94tCOECVJ2G9iW=w@mail.gmail.com>
 <9b3e6161f290246eb8003767b2b34596a10f5d71.camel@kernel.org>
 <CAAih9miBhTWZVt2N_39tzzOfJfjyUKeq30tD2OOQZdQhRSFhSw@mail.gmail.com>
 <cd4e8b16a8c154e6bda38021eef2c0d56badb43c.camel@kernel.org>
 <71b3ff942fdf6f070f6cd59f29e04081d3f94c38.camel@kernel.org>
 <5f3f2565aa31da52cd7b4359cba078e1990d44e7.camel@hammerspace.com>
 <efed50ed4c1487703436139cd26b37ca536031ef.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12 Jun 2023, at 15:21, Jeff Layton wrote:

> On Mon, 2023-06-12 at 19:04 +0000, Trond Myklebust wrote:
>>
>> Does RHEL-8 have commit 6c984083ec24, 064109db53ec, d95b26650e86,
>> e6005436f6cc, 9641d9bc9b75, and cea9ba7239dc applied?
>>
>
> Ben is working on backporting those as we speak. Hopefully we can get
> RHEL8's state closer to where upstream is.

 https://bugzilla.redhat.com/show_bug.cgi?id=2213644

We don't have eager write support in RHEL-8, so 064109db53ec is unneeded.

Ben

