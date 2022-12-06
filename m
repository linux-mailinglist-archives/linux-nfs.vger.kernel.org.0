Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F766445E3
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Dec 2022 15:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiLFOkw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Dec 2022 09:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiLFOkv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Dec 2022 09:40:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE4E22536
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 06:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670337596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9JF4yqNCbXX6iNnSpaRGjomagKxeWxYh5/t3ptRBsU=;
        b=OBzJFwOA6uOaS0Siq54RTCEpBrb16/cIwPd+8ti1UZvyC06YO8IylG4jcKRxdosvbb5S9d
        sCQPRe9+Vsb6pBRZx4YTwlMuEUovIg1jqP7V/sNLcdcC55Hs8yG4y5mG53H3bju4D66zHE
        /Ey+gsfNqMSCvy9zpZY9uEFGezbFtnI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-5RfOgxQHMAqIY4IS9ppTCg-1; Tue, 06 Dec 2022 09:39:49 -0500
X-MC-Unique: 5RfOgxQHMAqIY4IS9ppTCg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF3AF80252C;
        Tue,  6 Dec 2022 14:39:50 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE140492B04;
        Tue,  6 Dec 2022 14:39:48 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Theodor Mittermair <tmittermair@cvl.tuwien.ac.at>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS performance problem (readdir, getattr, actimeo, lookupcache)
Date:   Tue, 06 Dec 2022 09:39:45 -0500
Message-ID: <AC525DA8-35E8-4D13-9A9F-59DFFA225D6D@redhat.com>
In-Reply-To: <22200778-0055-454B-84F2-E633E321C834@oracle.com>
References: <dc3b95d2-93d0-992f-8f02-75c5bbb3bdff@cvl.tuwien.ac.at>
 <0193C32D-D74A-423C-AF08-58EB436FABDD@redhat.com>
 <22200778-0055-454B-84F2-E633E321C834@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6 Dec 2022, at 9:32, Chuck Lever III wrote:

>> On Dec 6, 2022, at 8:21 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 5 Dec 2022, at 21:18, Theodor Mittermair wrote:
>>
>>> Hello,
>>
>> Hi Theodor,
>>
>> .. snip ..
>>
>>> From what i gathered around the internet and understood, there seem to be
>>> heuristics involved when the client decides what operations to transmit to
>>> the server.  Also, the timed-out cache seems to be creating what some
>>> called a "getattr storm", which i understand in theory.
>>
>> When `du` gathers information, it does so by switching between two syscalls:
>> getdents() and stat() (or some equivalents).  The getdents() syscall causes
>> the NFS client to perform either READDIR or READDIRPLUS - the choice of
>> which is governed by a heuristic.  The heuristic can only intelligently
>> determine which readdir operation to use based on whether the program is
>> performing this pattern of getdents(), stat(), stat(), stat(), getdents(),
>> stat(), stat(), stat().  The way it can tell is by checking if each inode's
>> attributes have been cached, so the cache timeouts end up coming into play.
>>
>>> But why does the first request manage to be smarter about it, since it
>>> gathers the same information about the exact same files?
>>
>> It's not smarter, it just optimistically uses READDIRPLUS on the very first
>> call of getdents() for a directory, but can only do so if the directory's
>> dentries have not yet been cached.  If they /are/ cached, but each dentry's
>> individual attributes have timed out, then the client must send an
>> individual GETATTR for each entry.
>>
>> What is happening for you is that your attribute caches for each inode are
>> timing out, but the overall directory's dentry list is not changing.
>> There's no need to send /any/ readdir operations - so the heuristic doesn't
>> send READDIRPLUS and you end up with one full pile of getdents() results of
>> individual GETATTRs for every entry.
>
> Are those GETATTRs emitted one at a time sequentially, or concurrently?

Sequentially, as `du` loops for each getdents() entry calling stat().

Ben

