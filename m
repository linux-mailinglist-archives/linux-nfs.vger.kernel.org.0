Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9BF5703EF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGKNN1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 09:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGKNN1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 09:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB52D3343C
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 06:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657545202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBLnAz0+1kfQ8gTtMHKAnuK/Tg33tti6uwdgUojHvDI=;
        b=AOa4/RzrgaMMNHLSrmxtrhKSWqJqZX1XTdkhSv3rG2qpqCh/n0v0XVu8REkHU5LoQ00qOs
        n+Pz+5QDNGkLlh16stNsX9/yyzPxXLQcRobxPiuM1kXlhDWlZxupcRXLvU7tW80CoVCt8K
        Ay1G5j6BH5radlCmTQeXCGD/3hpdu2k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-C33svtrmP1utMAFEAMBg1A-1; Mon, 11 Jul 2022 09:13:19 -0400
X-MC-Unique: C33svtrmP1utMAFEAMBg1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6192A2803043;
        Mon, 11 Jul 2022 13:13:19 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D64A91121315;
        Mon, 11 Jul 2022 13:13:18 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Andreas Hasenack" <andreas@canonical.com>,
        "Steve Dickson" <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Why keep var-lib-nfs-rpc_pipefs.mount around?
Date:   Mon, 11 Jul 2022 09:13:17 -0400
Message-ID: <EE39279C-4E40-48C8-ABC9-707EB1AD6D79@redhat.com>
In-Reply-To: <CANYNYEFSdBua3Ay6jGk2cacossVJ8_CzDgDBnFCjXfk5XSoGEQ@mail.gmail.com>
References: <CANYNYEFSdBua3Ay6jGk2cacossVJ8_CzDgDBnFCjXfk5XSoGEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 8 Jul 2022, at 12:50, Andreas Hasenack wrote:

> Hi,
>
> I was tracking down a Debian/Ubuntu bug with nfs-utils 2.6.1 where in
> one case, after installing the packages, you would end up with
> rpc_pipefs mounted at the same time in two locations: /run/rpc_pipefs
> and /var/lib/nfs/rpc_pipefs. The /run location is what debian/ubuntu
> default to.
>
> After poking around a bit, I think I found out why that is
> happening[1], but it led me to ask this question: why is
> var-lib-nfs-rpc_pipefs.mount (and its corresponding rpc_pipefs.target
> unit) still shipped, given that nfs-utils now has a generator?

Could just be an oversight, or perhaps a better reason exists.  The
nfs-utils userspace has to handle a lot of different cases and legacy
setups.

Steve D, do you know?

Ben

> Shouldn't the generator be enough for all cases, where rpc_pipefs is
> mounted in the default compile-time location, or changed via a config
> change to nfs.conf? I know currently it checks[2] whether the config
> points at the default location, but that check could just be skipped
> and then the generator would always produce the correct mount and
> target units.
>
>
> 1. =

> https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/1971935/commen=
ts/22
> 2. =

> https://salsa.debian.org/kernel-team/nfs-utils/-/blob/master/systemd/rp=
c-pipefs-generator.c#L138

