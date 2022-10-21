Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC6560772C
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Oct 2022 14:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJUMoH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Oct 2022 08:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJUMny (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Oct 2022 08:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1442625FD18
        for <linux-nfs@vger.kernel.org>; Fri, 21 Oct 2022 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666356231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjUdl7eLqQYzlkm0EfvfVZQpUsrnAX3nZytknp2wvNA=;
        b=ezVCSzDc4kG9u2KNcoepOlAMZgNKlRVG1QFgjm2dJRZtGrQZ3bn3Y71t4clsJFHLpwj+yl
        VxyVdDf71MkIwFOWAMONEMC7S4iamgCzX7APgCs3OR6v96S9gSMz0k1wJfGuBtbkEhV2kF
        aiyrcEqg/Mk5FPrMJ+EeY7yEbmRVs3o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-0lPuMdE6Pm-qcf2LyoTx1w-1; Fri, 21 Oct 2022 08:43:50 -0400
X-MC-Unique: 0lPuMdE6Pm-qcf2LyoTx1w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E96C8185A7B0;
        Fri, 21 Oct 2022 12:43:49 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C9D42166B33;
        Fri, 21 Oct 2022 12:43:48 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Trigger the "ls -l" readdir heuristic sooner
Date:   Fri, 21 Oct 2022 08:43:45 -0400
Message-ID: <2B40F919-4E12-4891-B732-59650B507AA9@redhat.com>
In-Reply-To: <20220920170021.1391560-1-bcodding@redhat.com>
References: <20220920170021.1391560-1-bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 20 Sep 2022, at 13:00, Benjamin Coddington wrote:

> Since commit 1a34c8c9a49e ("NFS: Support larger readdir buffers") has
> updated dtsize, and with recent improvements to the READDIRPLUS helper
> heuristic, the heuristic may not trigger until many dentries are emitte=
d
> to userspace.   This will cause many thousands of GETATTR calls for "ls=

> -l" when the directory's pagecache has already been populated.  This
> manifests as poor performance for long directory listings after an
> initially fast "ls -l".
>
> Fix this by emitting only 17 entries for any first pass through the NFS=

> directory's ->iterate_shared(), which allows userpace to prime the
> counters for the heuristic.
>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---

Hello Trond and Anna, please consider this patch.  We have folks that are=

sad and confused that "ls -l" becomes much slower after running it once.

Olga also tested this fix and reported performance gains here:
https://lore.kernel.org/linux-nfs/CAN-5tyFsJy-D9cEfk8zCH8-0KErWteVW8Zb7BM=
qjL7=3D=3D2qtT_A@mail.gmail.com/

Olga, would you be willing to contribute your "Tested-by" for this patch?=


Any comments from anyone would also be welcome.

Ben

