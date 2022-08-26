Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BCA5A2E66
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 20:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiHZS1h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 14:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiHZS1g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 14:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD98D3447
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661538454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FaKEYNB6y5v/Ekh4SL1N4iTiFI1VS/8XS6d+uMaleJQ=;
        b=bDEC9xSvNwd2CuwBe2CD+MjCGRsxd12e+cX6Nkg2W9SwSDk5klWc+696nT0/NgBfT3dRvZ
        vBTmwBHWpyNxvuTz97RyTSRPBGTa7ipCrHN8pfahgo2xTWUZjx1uilBwyn8P9xz9kVF3Wu
        dLlZ5DirDfnjedXfXzQmcDHLKeuCko4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-FI-e518FO9a94-PlaB0GiQ-1; Fri, 26 Aug 2022 14:27:32 -0400
X-MC-Unique: FI-e518FO9a94-PlaB0GiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BD5E3C11991;
        Fri, 26 Aug 2022 18:27:32 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F17394010D45;
        Fri, 26 Aug 2022 18:27:31 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Date:   Fri, 26 Aug 2022 14:27:30 -0400
Message-ID: <FA952BF7-1638-4BD1-8DA9-683078CFDE8F@redhat.com>
In-Reply-To: <f5a2163d11f73e24c2106d43e72d0400d5a282b6.camel@hammerspace.com>
References: <165110909570.7595.8578730126480600782.stgit@noble.brown>
 <165274590805.17247.12823419181284113076@noble.neil.brown.name>
 <72f091ceaaf15069834eb200c04f0630eca7eaef.camel@hammerspace.com>
 <165274805538.17247.18045261877097040122@noble.neil.brown.name>
 <acdd578d2bb4551e45570c506d0948647d964f66.camel@hammerspace.com>
 <165274950799.17247.7605561502483278140@noble.neil.brown.name>
 <3ec50603479c7ee60cfa269aa06ae151e3ebc447.camel@hammerspace.com>
 <165275056203.17247.1826100963816464474@noble.neil.brown.name>
 <d6c351439c71d95f761c89533919850c91975639.camel@hammerspace.com>
 <D788BD7B-029F-4A4C-A377-81B117BD4CD2@redhat.com>
 <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>
 <54685EB8-7E6D-4EC4-8A9E-2BF55F41DABA@redhat.com>
 <f5a2163d11f73e24c2106d43e72d0400d5a282b6.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 26 Aug 2022, at 12:56, Trond Myklebust wrote:
> User group membership is not a per-mount thing. It's a global thing.

The cached access entry is a per-inode thing.

> As I said, what I'm proposing does allow you to set up a cron job that
> flushes your cache on a regular basis. There is absolutely no extra
> value whatsoever provided by moving that into the kernel on a per-mount
> basis.

Sure there is - that's where we configure major NFS client behaviors.

I understand where you're coming from, but it seems so bizarre that a previous
behavior that multiple organizations built and depend upon has been removed
to optimize performance, and now we will need to tell them that to restore
it we must write cron jobs on all the clients.  I don't think there's been a
dependency on cron to get NFS to work a certain way yet.

A mount option is much easier to deploy in these organizations that have
autofs deployed, and documenting it in NFS(5) seems the right place.

If that's just not acceptable, at least let's just make a tuneable that
expires entries rather than a trigger to flush everything.  Please consider
the configuration sprawl on the NFS client, and let me know how to proceed.

Ben

