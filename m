Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F56568B7A
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiGFOjr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 10:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiGFOjq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 10:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81D821F63E
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657118384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALAacfGjAogsHguKlnqwWd55bFhtnvPi/ULHhY2G5aQ=;
        b=auElw+X1FN9oRH8sgJU0/AktAjDsI3gAiZXtlmVzrqP5Ev38Jq5MOjYKd0nsyW9GeT8bfF
        F/6lmHgy61NvAttbNBekMSJyiIH3sEK/vG2MgfkvCMF4a9yfyZI92Cq5+vBSGeZtd+wpsn
        7tQ51hOpIcfn5eAfx/7qma9SuOJadc8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-ffFlZ0QAMcOp1AjwiOYKPQ-1; Wed, 06 Jul 2022 10:39:43 -0400
X-MC-Unique: ffFlZ0QAMcOp1AjwiOYKPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBA4D3C0F37C;
        Wed,  6 Jul 2022 14:39:42 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87D402026D64;
        Wed,  6 Jul 2022 14:39:42 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "jie wang" <yjxxtd12@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Question abount sm-notify when use NFSv3 lock
Date:   Wed, 06 Jul 2022 10:39:41 -0400
Message-ID: <3D87B9ED-3A00-478B-AC17-435B71D0A349@redhat.com>
In-Reply-To: <CACt_J9PHSjkz_-x0K=7+AYjiX1Ur5cV+brC9Tv4i7dkG=NSBuQ@mail.gmail.com>
References: <CACt_J9PHSjkz_-x0K=7+AYjiX1Ur5cV+brC9Tv4i7dkG=NSBuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6 Jul 2022, at 8:28, jie wang wrote:

> Hi, all
>   When we use NFSv3, we have a LoadBalance in front of NFS server. For
> example, LoadBalance's ip is ip2 and NFS server's ip is ip1, and
> client use ip2 to mount.
>
>   Now client use flock to lock file, then I restart NFS server and
> execute sm-notify -f. Then the problem occurs, the sm-notify request's
> src ip is ip1, not ip2, so rpc.statd will ignore this notify, because
> it does not match ip2 when mount, so client will not reclaim lock, and
> lock lost when restart NFS server.
>
>   Do you know how to address this ? Thanks a lot.

The sm-notify(8) man page shows you can use '-v' to specify an ipaddr or
hostname.

Ben

