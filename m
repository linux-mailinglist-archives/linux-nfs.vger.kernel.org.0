Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DA5686AE7
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Feb 2023 16:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjBAPzj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Feb 2023 10:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjBAPzU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Feb 2023 10:55:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AD07D83
        for <linux-nfs@vger.kernel.org>; Wed,  1 Feb 2023 07:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675266824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b14fQ9b3Becxzzq+aOfqyIBQo9ZQERqU1JrZ0A37IQU=;
        b=OuB6uoS7Z1lysy95K79g9D/9XdDU2fPMndnthb1b6xFFYLeSEesIO+/EeJBp0N4MS2dvMT
        vIQ8VRUdwJfWVUl5SqrQHxkUWR+aSVBcBKUhICieJ4GGI/43xMIarzwIV9G7u8w+WyzreV
        piDFaOs5WtZ4ueIjOT3Kw43z6xlh/zY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-E1rcM5wIOP6SGqV-V1s3zA-1; Wed, 01 Feb 2023 10:53:41 -0500
X-MC-Unique: E1rcM5wIOP6SGqV-V1s3zA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0C9B882822;
        Wed,  1 Feb 2023 15:53:40 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E330422FE;
        Wed,  1 Feb 2023 15:53:40 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: git regression failures with v6.2-rc NFS client
Date:   Wed, 01 Feb 2023 10:53:37 -0500
Message-ID: <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
In-Reply-To: <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1 Feb 2023, at 9:10, Benjamin Coddington wrote:
>
> Working on a fix..

=2E. actually, I have no idea how to fix this - if tmpfs is going to modi=
fy
the position of its dentries, I can't think of a way for the client to lo=
op
through getdents() and remove every file reliably.

The patch you bisected into just makes this happen on directories with 18=

entries instead of 127 which can be verified by changing COUNT in the
reproducer.

As Trond pointed out in:
https://lore.kernel.org/all/eb2a551096bb3537a9de7091d203e0cbff8dc6be.came=
l@hammerspace.com/

    POSIX states very explicitly that if you're making changes to the
    directory after the call to opendir() or rewinddir(), then the
    behaviour w.r.t. whether that file appears in the readdir() call is
    unspecified. See
    https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir.ht=
ml

The issue here is not quite the same though, we unlink the first batch of=

entries, then do a second getdents(), which returns zero entries even tho=
ugh
some still exist.  I don't think POSIX talks about this case directly.

I guess the question now is if we need to drop the "ls -l" improvement
because after it we are going to see this behavior on directories with >1=
7
entiries instead of >127 entries.

It should be possible to make tmpfs (and friends) generate reliable cooki=
es
by doing something like hashing out the cursor->d_child into the cookie
space.. (waving hands)

Ben

