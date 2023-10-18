Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5C77CE138
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjJRPcO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjJRPcN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 11:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE45118
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697643085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJjSKfUQTcoC80LPn9xGSAff+OFEbL1iKvizfskLo0U=;
        b=DyR694x4NM8w/v308o1+BNMMs9XKUoNMyIsG6vf8x7Z/ebTQoyYNAlxotGCakzsYcw+0Gh
        8bQyzg+ADrOokxlua750cIeZ91tBLWS5HXioN/c3PMHdu5/n7Lveyi2Xc50HL0XeQB7qtt
        lNjpUdH7Z8HvzG4j+p9p1DInbpXVqZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-atLNvQ3-N-eeuDftBtJlhQ-1; Wed, 18 Oct 2023 11:31:09 -0400
X-MC-Unique: atLNvQ3-N-eeuDftBtJlhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E71688D012;
        Wed, 18 Oct 2023 15:31:04 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4809908;
        Wed, 18 Oct 2023 15:31:03 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Charles Hedrick <hedrick@rutgers.edu>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: bad info in NFS context
Date:   Wed, 18 Oct 2023 11:31:02 -0400
Message-ID: <0BE81C71-CA47-4BE2-ABE7-FEEF2206EFD6@redhat.com>
In-Reply-To: <MW5PR14MB549922FC884959461AE4D8BDAAD5A@MW5PR14MB5499.namprd14.prod.outlook.com>
References: <PH0PR14MB5493ED33985C95FEBE4DA808AAF9A@PH0PR14MB5493.namprd14.prod.outlook.com>
 <B7D023CD-2810-4BD6-8570-AB0C0EE95287@redhat.com>
 <PH0PR14MB5493AB9814249EC5D66E635DAAF8A@PH0PR14MB5493.namprd14.prod.outlook.com>
 <650954F9-F67D-4F62-AD7B-4D16DF45E168@redhat.com>
 <PH0PR14MB5493A8657F42289DBC301CC2AAF8A@PH0PR14MB5493.namprd14.prod.outlook.com>
 <7B541D75-296B-4264-92BC-6154B84F2557@redhat.com>
 <MW5PR14MB549922FC884959461AE4D8BDAAD5A@MW5PR14MB5499.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 18 Oct 2023, at 11:18, Charles Hedrick wrote:

> Ubuntu added fasc, but it's a kernel parameter. It can be changed without
> a reboot, so we were able to fix the problem. It appears that this has
> become the default upstream. I looked at Ubuntu's kernel code for their
> next LTS, and it looks like they've accepted the upstream code, so the
> problem shouldn't occur in the next LTS. Meanwhile we've taken precautions
> to set the option on all our systems.

I'm surprised - I haven't seen any "fasc" mount option go upstream.  Where
did you see the upstream work?

I'll probably hack up a patch to dump the access cache via sysfs file and
send that sometime this week, I can copy you if you have interest.  I'm
thinking usage would look something like:

echo <uid> > /sys/fs/nfs/0\:57/drop_access_cache

Ben

