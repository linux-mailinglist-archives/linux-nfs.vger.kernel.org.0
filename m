Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD245A2C94
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Aug 2022 18:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbiHZQpD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Aug 2022 12:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344539AbiHZQom (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Aug 2022 12:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9342EE1174
        for <linux-nfs@vger.kernel.org>; Fri, 26 Aug 2022 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661532237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4VJliubx2X/3z67orDyh6cKnfRD7eylOqSO8VdeD+mw=;
        b=aFFIV0ClHc9bpkcPoFkgVn4btibY1TBDMjwP9Uav5XnAjJdWVyv7OEA4qxnOIBGERpZnfl
        QBCvq0+bGLr6oB76Di+VNw7g5MAyQ3VVVWFDM/sIoDSSzZ6ABEgXFd2J0kqeJPzuWKQIzu
        AGxBacMicU09n8HZfOEjePDNK7w2ggs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-ARj6oV4BOJypxwrZuUSAQQ-1; Fri, 26 Aug 2022 12:43:52 -0400
X-MC-Unique: ARj6oV4BOJypxwrZuUSAQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5A861C006B9;
        Fri, 26 Aug 2022 16:43:51 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27BFD40CF916;
        Fri, 26 Aug 2022 16:43:50 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de
Subject: Re: [PATCH 0/2] NFS: limit use of ACCESS cache for negative responses
Date:   Fri, 26 Aug 2022 12:43:49 -0400
Message-ID: <54685EB8-7E6D-4EC4-8A9E-2BF55F41DABA@redhat.com>
In-Reply-To: <a56ca216aef75f419d8a13dd6c7719ef15bbcaab.camel@hammerspace.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 26 Aug 2022, at 11:44, Trond Myklebust wrote:

> On Fri, 2022-08-26 at 10:59 -0400, Benjamin Coddington wrote:
>> On 16 May 2022, at 21:36, Trond Myklebust wrote:
>>> So until you have a different solution that doesn't impact the
>>> client's
>>> ability to cache permissions, then the answer is going to be "no"
>>> to
>>> these patches.
>>
>> Hi Trond,
>>
>> We have some folks negatively impacted by this issue as well.  Are
>> you
>> willing to consider this via a mount option?
>>
>> Ben
>>
>
> I don't see how that answers my concern.

A mount option would need to be set to enable the behavior, so the cases
you're concerned about would be unaffected.

> I'd rather see us set up an explicit trigger mechanism. It doesn't have
> to be particularly sophisticated. I can imagine just having a global,
> or more likely a per-container, cookie that has a control mechanism in
> /sys/fs/nfs, and that can be used to order all the inodes to invalidate
> their permissions caches when you believe there is a need to do so.
>
> i.e. you cache the value of the global cookie in the inode, and if you
> notice a change, then that's the signal that you need to invalidate the
> permissions cache before updating the cached value of the cookie.
>
> That way, you have a mechanism that serves all purposes: it can do an
> immediate one-time only flush, or you can set up a userspace job that
> issues a global flush once every so often, e.g. using a cron job.

We had the every-so-often flush per-inode before 57b691819ee2.

Here's the setup in play: there's a large number of v3 clients and users,
and many times each day group membership changes occur which either restrict
or grant access to parts of the namespace.

The feedback I'm getting is that it will be a lot of extra orchestration to
have to trigger something on each client when the group memberships change.
The desired behavior was as before 57b691819ee2: the access cache expired
with the attribute timeout.  It would be nice to have a mount option that
could restore the access cache behavior as it was before 57b691819ee2.

Ben

