Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FFA5AF392
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 20:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIFS2y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiIFS2x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 14:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77588A74DA
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662488931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=abDxxZc+2Z6OGfNmDuQFxd8/lJdZS+V6VLtFRmdKmOU=;
        b=Ja2nj0IyQ1YbWJrzJ+mEBVmRvjQUlGt4Cv8Smavb77eM0huYNyva8fXHHZO8bNjNI4tE5N
        kYjAWNuq2WFOY2SH2ufaHx483jDo+nRFbuU5/guh7tUjPzgHWy1U/PTlNsLee+fYiFjhVD
        8j6o08dEDozcnUDUUvHdNGeXO0AswfI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-Cz-FedpqPS2p5aoa-CetmQ-1; Tue, 06 Sep 2022 14:28:47 -0400
X-MC-Unique: Cz-FedpqPS2p5aoa-CetmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 528248037AF;
        Tue,  6 Sep 2022 18:28:46 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFEC44C816;
        Tue,  6 Sep 2022 18:28:45 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Olga Kornievskaia" <aglo@umich.edu>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Date:   Tue, 06 Sep 2022 14:28:43 -0400
Message-ID: <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
In-Reply-To: <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1 Sep 2022, at 21:27, Olga Kornievskaia wrote:

> Thanks Chuck. I first, based on a hunch, narrowed down that it's
> coming from Al Viro's merge commit. Then I git bisected his 32patches
> to the following commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979

No crash for me after reverting f0f6b614f83dbae99d283b7b12ab5dd2e04df979.

Ben

