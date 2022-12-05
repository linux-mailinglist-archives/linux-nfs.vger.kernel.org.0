Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A8642EFB
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Dec 2022 18:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiLERjQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Dec 2022 12:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLERjP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Dec 2022 12:39:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C31C42
        for <linux-nfs@vger.kernel.org>; Mon,  5 Dec 2022 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670261899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=474Veck1VYB4rPLuZHOcu9oupe9hsVxc3fxdcRWFKn0=;
        b=SEOmf7JqiRYpNi4G/bgt87MtZaMhj6WLDj0uGBPC0e1ZmtdVyD8x1MTxbZJf4UXRTHAFwF
        qsLTGnFgImUPpDRH7SD3rS9vLsODTRM8EF0VTY8HlgtXWwkZjkt4ceI3uEpRvrkgSziJDd
        iD264cqg+etx5TuMjOaaJTLvnHEITNs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-T3r9giCIPkC2n9rlrDiGmw-1; Mon, 05 Dec 2022 12:38:08 -0500
X-MC-Unique: T3r9giCIPkC2n9rlrDiGmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE59C2823805;
        Mon,  5 Dec 2022 17:38:07 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 573C240C206B;
        Mon,  5 Dec 2022 17:38:07 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Jidong Xiao <jidong.xiao@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Is Linux NFS block size 512 bytes or is this a bug?
Date:   Mon, 05 Dec 2022 12:38:01 -0500
Message-ID: <60C55655-4A83-4B93-AEEB-89C69EBEE472@redhat.com>
In-Reply-To: <CAG4AFWYGYtYOoi8BuFos__GSNrLVXBwcaDpVR0D6fRv3ibPkmA@mail.gmail.com>
References: <CAG4AFWYGYtYOoi8BuFos__GSNrLVXBwcaDpVR0D6fRv3ibPkmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5 Dec 2022, at 0:44, Jidong Xiao wrote:

> Hi,
>
> I saw this line in fs/nfsd/nfs3xdr.c:
>
> /* used */
> p = xdr_encode_hyper(p, ((u64)stat->blocks) << 9);
>
> It seems we are left-shifting the blocks 9 bits, to get the number of
> bytes used. Is this a bug or we know the block size is always 512
> bytes?

By calling vfs_getattr(), which needs to behave for stat(2) syscall as
returning the number of 512 byte blocks.  I think we're stuck with the
traditional idea that blocks are always 512 bytes in linux, at least from
the perspective of stat().

The history of such is beyond my time, but I don't think this is a bug.

Ben

