Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B854BDBCC
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 18:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354941AbiBUQpe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 11:45:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381038AbiBUQpd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 11:45:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 024FA22BD5
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 08:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645461909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RQO74vB3UwLMGxug9BwsiCUbRYSD1LKvRiVzNi16h8=;
        b=WE45UUROjvJ7DRWa2BzgDiU05C5lbqSk2WS+0FyyKu9rJ1nLcJsBsSOuxSQ3OHxhjprQox
        /oGNjGNG55gP0Kw3FJ1BmytaHtKc6Qu5bd85mUyyWTroQWzAOwHDNenNQk8QQvakgn+xfE
        uCfG2a8LMyDh1wJ/9IBwqwTPn+V9eN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-tECtSaesM1uq4lR2kvCdSg-1; Mon, 21 Feb 2022 11:45:07 -0500
X-MC-Unique: tECtSaesM1uq4lR2kvCdSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B00671006AA6;
        Mon, 21 Feb 2022 16:45:06 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D7D8838F4;
        Mon, 21 Feb 2022 16:45:06 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Date:   Mon, 21 Feb 2022 11:45:05 -0500
Message-ID: <BCE9A6AB-EAA5-477E-BFE7-529AEC443E6A@redhat.com>
In-Reply-To: <20220221160851.15508-6-trondmy@kernel.org>
References: <20220221160851.15508-1-trondmy@kernel.org>
 <20220221160851.15508-2-trondmy@kernel.org>
 <20220221160851.15508-3-trondmy@kernel.org>
 <20220221160851.15508-4-trondmy@kernel.org>
 <20220221160851.15508-5-trondmy@kernel.org>
 <20220221160851.15508-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Feb 2022, at 11:08, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> When reading a very large directory, we want to try to keep the page
> cache up to date if doing so is inexpensive. Right now, we will try to
> refill the page cache if it is non-empty, irrespective of whether or not
> doing so is going to take a long time.
>
> Replace that algorithm with something that looks at how many times we've
> refilled the page cache without seeing a cache hit.

Hi Trond, I've been following your work here - thanks for it.

I'm wondering if there might be a regression on this patch for the case
where two or more directory readers are part way through a large directory
when the pagecache is truncated.  If I'm reading this correctly, those
readers will stop caching after 5 fills and finish the remainder of their
directory reads in the uncached mode.

Isn't there an OP amplification per reader in this case?

Ben

