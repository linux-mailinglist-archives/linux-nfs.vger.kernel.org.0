Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E04BEC40
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 22:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiBUVLB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 16:11:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiBUVLA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 16:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06BEE23BE7
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 13:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645477834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nGzqYYBlk//bNiwQrnETQ40/WikSnOjlBbpEgspiwsQ=;
        b=KbR+kd+7N6XFpQVLz1KMKHhWImiQVdqhh2Be7BCMJ+3HQY5IYljPgyXr9Ec8arsEKT1Cmy
        cBIkvA1D7yfwCurIFMavjCVytF70atXMSirC+pHYikb/6nEn4CI14/ZjL5HAJHJw5/xGd1
        Hs15r03kCeGAeYWmQcWTwvDHXwYtSOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-3c5vovcGNLGTDRcaCJparw-1; Mon, 21 Feb 2022 16:10:32 -0500
X-MC-Unique: 3c5vovcGNLGTDRcaCJparw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7BA31091DA2;
        Mon, 21 Feb 2022 21:10:30 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E200E709;
        Mon, 21 Feb 2022 21:10:30 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Date:   Mon, 21 Feb 2022 16:10:29 -0500
Message-ID: <9DBD587E-C4CA-4674-B47D-92396EEEA082@redhat.com>
In-Reply-To: <b097f18981260e9a2d75f654a5c4f229391bb8bb.camel@hammerspace.com>
References: <20220221160851.15508-1-trondmy@kernel.org>
 <20220221160851.15508-2-trondmy@kernel.org>
 <20220221160851.15508-3-trondmy@kernel.org>
 <20220221160851.15508-4-trondmy@kernel.org>
 <20220221160851.15508-5-trondmy@kernel.org>
 <20220221160851.15508-6-trondmy@kernel.org>
 <BCE9A6AB-EAA5-477E-BFE7-529AEC443E6A@redhat.com>
 <e01f0373409aaf09dbaf59f3aa7deb421af68980.camel@hammerspace.com>
 <5B222AF7-98A7-428B-81B2-1A1D3FFAD944@redhat.com>
 <b097f18981260e9a2d75f654a5c4f229391bb8bb.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Feb 2022, at 15:55, Trond Myklebust wrote:
>
> We will always need the ability to cut over to uncached readdir.

Yes.

> If the cookie is no longer returned by the server because one or more
> files were deleted then we need to resolve the situation somehow (IOW:
> the 'rm *' case). The new algorithm _does_ improve performance on those
> situations, because it no longer requires us to read the entire
> directory before switching over: we try 5 times, then fail over.

Yes, using per-page validation doesn't remove the need for uncached readdir.
It does allow a reader to simply resume filling the cache where it left
off.  There's no need to try 5 times and fail over.  And there's no need to
make a trade-off and make the situation worse in certain scenarios.

I thought I'd point that out and make an offer to re-submit it.  Any
interest?

Ben

