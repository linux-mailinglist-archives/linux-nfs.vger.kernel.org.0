Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA14C70B6
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiB1Pe2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 10:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbiB1Pe1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 10:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB88D3BBFC
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 07:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646062427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ozv258jxbTEl9R1jaOd101OO92B/s4cqsl1sObYtu+c=;
        b=QMt7PDGCg+EparTHHdfB/27ufB0W/Pa8z0BdMvqpu5SS4dF8awojAFBwus8jANHtwuR9Q+
        86HA4kWjXo8pOo5RE9BAaCDikpRkN6/mOFjNZxyRvF615PL7eRL16iKN/XUUbAa5yLhrcw
        J3k00M/Wx2q6W8JPjL9lOaFPR+71jOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-dKWGPRITOS6NMX1vB9mQ2g-1; Mon, 28 Feb 2022 10:33:44 -0500
X-MC-Unique: dKWGPRITOS6NMX1vB9mQ2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26D441854E27;
        Mon, 28 Feb 2022 15:33:43 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 909EB7D3E4;
        Mon, 28 Feb 2022 15:33:42 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org, anna.schumaker@netapp.com
Subject: Re: [PATCH] NFSv4: use unique client identifiers in network
 namespaces
Date:   Mon, 28 Feb 2022 10:33:41 -0500
Message-ID: <786D4105-B1D4-47B9-9B0B-166F6C0E6ABD@redhat.com>
In-Reply-To: <88a6445c7d7cde971479cae70ca0eb62f68ff96e.camel@hammerspace.com>
References: <6e05bf321ff50785360e6c339d111db368e7dfda.1644349990.git.bcodding@redhat.com>
 <189aba691b341f64f653817c9cdf018ef34ac257.camel@hammerspace.com>
 <7CDAEA98-3A8D-459A-80FE-82AA58A4EDA2@redhat.com>
 <164600585213.15631.6635814364853064416@noble.neil.brown.name>
 <BA04DD0D-4B05-48AD-9E22-AB7524E737C3@redhat.com>
 <88a6445c7d7cde971479cae70ca0eb62f68ff96e.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 28 Feb 2022, at 10:16, Trond Myklebust wrote:
> On Mon, 2022-02-28 at 09:43 -0500, Benjamin Coddington wrote:
>> On 27 Feb 2022, at 18:50, NeilBrown wrote:
>>> I liked this patch at first, but I no longer think it is a good
>>> idea.
>>>
>>> It is quite possible today for containers to provide sufficient
>>> uniqueness simply by setting a unique hostname before the first NFS
>>> mount.
>>> Quite possibly some containers already do this, and are working
>>> perfectly.
>>>
>>> If we add new randomness, the they will get a different identifier
>>> on
>>> each boot.  This is bad for exactly the same reason that it is bad
>>> for
>>> "net == &init_net".
>>>
>>> i.e.  I believe this patch could cause a regression for working
>>> sites.
>>> The regression may not be immediately obvious, but it may still be
>>> there.
>>> For this reason, I think this patch should be dropped.
>>
>> I agree, Trond please drop this patch.
>>
>>
> Since it was already pushed to linux-next, it will have to be reverted.
>

I'm not seeing it on any branch on linux-next.  I presume no one's pulled
your linux-next branch.  Are you not able to drop it from your linux-next
branch?

Ben

