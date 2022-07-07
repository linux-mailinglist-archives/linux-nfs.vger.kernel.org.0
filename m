Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074BF56A159
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 13:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiGGLxD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jul 2022 07:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbiGGLwU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jul 2022 07:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38542564DC
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jul 2022 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657194730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j2uZ8O43ST+HjPuuK2AK+tdS64i0KGf3LGLQhCUhzoo=;
        b=DzspXfF9ucdPE/seHpW+RwkIU2XzfOswAuzi90+aCI9jeU0yT7pZ9DkifIExlb/w/nKQiI
        0aml6HNjLpbZPg2Ot9EjiTalP44ZP+GN3zRKxmmh+LeriC8FTZPn5bN7+imDg2YRM0tz8p
        hkhHVzKR11lCuoSbZKfsmHir/Q6q7Dw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-zF7QgPbxMvys86l4MZDuLA-1; Thu, 07 Jul 2022 07:51:55 -0400
X-MC-Unique: zF7QgPbxMvys86l4MZDuLA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD47D101A58D;
        Thu,  7 Jul 2022 11:51:54 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60C50492C3B;
        Thu,  7 Jul 2022 11:51:54 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "jie wang" <yjxxtd12@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Question abount sm-notify when use NFSv3 lock
Date:   Thu, 07 Jul 2022 07:51:53 -0400
Message-ID: <68BD4FDC-A409-422A-BE3F-318AEC8F3134@redhat.com>
In-Reply-To: <CACt_J9NtB5+1MiL8JrNbyLf6uhgHWDYmyAtKgmKdhzMkgL9E5g@mail.gmail.com>
References: <CACt_J9PHSjkz_-x0K=7+AYjiX1Ur5cV+brC9Tv4i7dkG=NSBuQ@mail.gmail.com>
 <3D87B9ED-3A00-478B-AC17-435B71D0A349@redhat.com>
 <CACt_J9NXmz4WCBT8iAT1MRNnhE1k5DpQct+00t-hTsbZrru06g@mail.gmail.com>
 <CACt_J9NtB5+1MiL8JrNbyLf6uhgHWDYmyAtKgmKdhzMkgL9E5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6 Jul 2022, at 19:57, jie wang wrote:

> If execute "sm-notify -f -v ip2", sm-notify did not send the notify 
> request.

Hmm, maybe its a bug?  You can turn up debugging with the "-d" opt, 
adding
more increases vebosity.  Try using three of them:

sm-notify -ddd -f -v ip2

Have you tried looking at an strace?  Are there different values set for
sm-notify in your nfs.conf file?

Check out the source, perhaps sm-notify isn't going to be able to send a
notification for an address that doesn't exist on a local network 
adapter
(this is a common pattern), and you need to configure that ip address as 
an
additional address on your system?

These are guesses.

Ben

