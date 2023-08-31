Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA17B78F1A2
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 19:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346845AbjHaRER (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 13:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244161AbjHaREQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 13:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958D910C4
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693501398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EQ3BP0Ufh22Wq28SGsvfllyGNpBdtwtxFdPikniPPyU=;
        b=QfMqwOEkmAMJxhS2ptiUJDU24PYGZPAP2jRzamTp2dG9mIvd0vNfIoWqF1zA7I/Kl7LYPY
        ik6UoKkuJ72HJFSTsrAt6fNlBf6UlLbsjMR+A0SZtdDMvqYlD5Q3Nwtkynp49N+e8Wuj1n
        AOrbhGMCCevRFb2F2P3Puz0Wl4A2gg8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-S3H3V2KaMSGGuUrOwQhQpw-1; Thu, 31 Aug 2023 13:03:16 -0400
X-MC-Unique: S3H3V2KaMSGGuUrOwQhQpw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70815101A52E;
        Thu, 31 Aug 2023 17:03:16 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03DBE4021C8;
        Thu, 31 Aug 2023 17:03:15 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFSv4: add sysctl for setting READDIR attrs
Date:   Thu, 31 Aug 2023 13:03:14 -0400
Message-ID: <4C7FEC52-164E-408C-A26E-611F6D7C314B@redhat.com>
In-Reply-To: <021d9cf4ba3ee8a776d8c227858866caf6c7308d.camel@kernel.org>
References: <8f752f70daf73016e20c49508f825e8c2c94f5e7.1693494824.git.bcodding@redhat.com>
 <021d9cf4ba3ee8a776d8c227858866caf6c7308d.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 31 Aug 2023, at 12:28, Jeff Layton wrote:
> This doesn't seem worthwhile to me. We have a clear reason to add
> WORD0_TYPE to "basic" READDIR, which is that we want to be able to fill
> out the d_type for getdents.

Yeah, and exposing all the bits might create some interesting effects.

> I don't see the same sort of rationale for fetching other attributes. It
> would just be priming the inode cache with certain info. That could
> useful for some workloads, but that seems like sort of a niche thing.

The issues I frequently see around READDIR are that we keep micro-optimizing
and regressing in another place.  If we set WORD0_TYPE, there's a non-zero
chance someone might start yelling about it in awhile because their server
takes longer to query the inode.  Its nice we have the option to give the
power back the user sometimes without needing to grow a mount option, or use
a module param (which would appply to the whole system) - so this was a fun
example.

> Adding more info also reduces the number of entries you can pack into a
> READDIR reply, which is makes it easier to trigger cookie problems with
> creates and deletes in large directories.

I don't think those two things are related for filesystems with stable
cookies, or I'm not understanding you.

I'm in favor of the default READDIR asking for type.

Ben

