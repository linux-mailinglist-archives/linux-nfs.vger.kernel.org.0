Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE86EB06C
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Apr 2023 19:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjDURR2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Apr 2023 13:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjDURR2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Apr 2023 13:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E760010D1
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682097402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3oVkXNMaz59VAAwJ9/yqYsr8BtlGKB1vFjdFjCtyAvw=;
        b=ZfPjWi1tjhVD70JOR6Kwgk9xgoox0VIrgBqFgrqeFLIEgKVg3gTFjpBSHt1QJ9Vo6wLzO/
        pNRICIzbj6bS3HuEwB0lni5049aarHXSia6J8GzWKlwsLT1wSRtYMNmvHXTvEe6XRY9CE3
        AnxU1kjUWL7TVfj1P84tUXJEnpCmp7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-uxhs3AmSOdqqeRW_zU_VBA-1; Fri, 21 Apr 2023 13:16:40 -0400
X-MC-Unique: uxhs3AmSOdqqeRW_zU_VBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78A93101A54F
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:16:40 +0000 (UTC)
Received: from [172.16.193.1] (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3317F1410F20
        for <linux-nfs@vger.kernel.org>; Fri, 21 Apr 2023 17:16:40 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/9 RFC v2] NFS sysfs scaffolding
Date:   Fri, 21 Apr 2023 13:16:39 -0400
Message-ID: <C5665DA5-A20D-4317-A43C-69DA0272E2B9@redhat.com>
In-Reply-To: <cover.1682096307.git.bcodding@redhat.com>
References: <cover.1682096307.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Apr 2023, at 13:08, Benjamin Coddington wrote:

> Here's another round of sysfs entries for each nfs_server, this time with a
> single use-case: a "shutdown" toggle that causes the basic rpc_clnt(s) to
> immediately fail tasks with -EIO.  It works well for the non pNFS cases to
> allow an unmount of a filesystem when the NFS server has gone away.
>
> I'm posting to gain potential NACKing, or to be redirected, or to serve as
> fodder for discussion at LSF.
>
> I'm thinking I'd like to toggle v4.2 things like READ_PLUS in here next, or
> other module-level options that maybe would be useful per-mount.
>
> Benjamin Coddington (9):
>   NFS: rename nfs_client_kset to nfs_kset
>   NFS: rename nfs_client_kobj to nfs_net_kobj
>   NFS: add superblock sysfs entries
>   NFS: Add sysfs links to sunrpc clients for nfs_clients
>   NFS: add a sysfs link to the lockd rpc_client
>   NFS: add a sysfs link to the acl rpc_client
>   NFS: add sysfs shutdown knob
>   NFS: Cleanup unused rpc_clnt variable

^^ whoops.. had the wrong patch in here.  I'll send a v3.

Ben

