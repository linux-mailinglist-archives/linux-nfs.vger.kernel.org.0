Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4817CE7F4
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 21:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjJRTmo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 15:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjJRTmn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 15:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3579F114
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 12:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697658114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkXC7VDaoQK3RUozAAkGDOpsoWCmtz0VTHzkQBX3IBg=;
        b=glDlVjy2E+xv4AP/axZmCILMD60OjknO6Hmn5yE1Q9f1BeqJ2cfbDszYf1Y6xb3paXBHEp
        ib9Y/OxFbJqyOg3zv0Ah9Bxglcejf8lQiadZXmBxqJR5n8+DDwKaqErQ1iHblo60ihh2pZ
        3GswMw/lexk1SbP/mwMKcKRGDk/JeV0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-_2QbrvH6N5uQX1yWoB85nA-1; Wed, 18 Oct 2023 15:41:50 -0400
X-MC-Unique: _2QbrvH6N5uQX1yWoB85nA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B54ED10201FE;
        Wed, 18 Oct 2023 19:41:49 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18E05492BFA;
        Wed, 18 Oct 2023 19:41:48 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.2: READ_PLUS - when safe to use?
Date:   Wed, 18 Oct 2023 15:41:47 -0400
Message-ID: <CCC3D7FC-BC0E-414D-A9CA-545EFC9AFC10@redhat.com>
In-Reply-To: <CAFX2JfkRpfRe6-T3MELWsAX_V5xyZoiv0Prq_1qq4-5Pi4PCag@mail.gmail.com>
References: <CALXu0Ufzu8FMdH=-_35tHNqu3c6ewf4d6a379=fUMwNvGq_rgQ@mail.gmail.com>
 <CAFX2JfkRpfRe6-T3MELWsAX_V5xyZoiv0Prq_1qq4-5Pi4PCag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 18 Oct 2023, at 15:32, Anna Schumaker wrote:

> Hi Ced,
>
> On Sat, Oct 14, 2023 at 9:08 AM Cedric Blancher
> <cedric.blancher@gmail.com> wrote:
>>
>> Good afternoon!
>>
>> Since which kernel versions (NFS server, NFS client) is NFSv4.2
>> READ_PLUS safely usable?
>
> Linux 6.2 for the server side and 6.6 for the client.
>
>>
>> Also, could you make this a mount option, so people can turn this
>> on/off per mount, instead of using a kernel build option for this?
>
> The eventual plan is to remove the kernel build option entirely. We
> probably won't do a mount option, and just have it enabled by default
> when using NFS v4.2.

Anna, I'm still planning on either re-sending the patch you wrote to
enable/disable optional features per-mount, or re-work it to make it
file-per-feature as the sysfs creators intended.

We need the option to toggle client's default per-server or per-mount.

Ben

