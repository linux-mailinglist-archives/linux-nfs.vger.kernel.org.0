Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5A5B0464
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Sep 2022 14:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiIGMxf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Sep 2022 08:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiIGMxO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Sep 2022 08:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD77C773
        for <linux-nfs@vger.kernel.org>; Wed,  7 Sep 2022 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662555175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pzGF4JCDbCnyO8i6LXRCYYwL9qvEU4Y8265aQCUKwA=;
        b=Gtobz2tFrpuiALiFmHVsSbx28lanvPAhB5F0lfA7SEbotZQJEmC7ySyRof4IjF3CAQEGdc
        L+R/fdR1hY0dk1CF9jJC08Uq/cUnFzdqqC42oKldssi+qd4vJdVJxoBSQFwzSp7va4y8SM
        ECFsjdsRjpjfqXowZxkLTdExFFRsYSw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-AxT0L-jtMOG67TbjdZpFMA-1; Wed, 07 Sep 2022 08:52:49 -0400
X-MC-Unique: AxT0L-jtMOG67TbjdZpFMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4DD880029D;
        Wed,  7 Sep 2022 12:52:48 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EBC31415102;
        Wed,  7 Sep 2022 12:52:47 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Olga Kornievskaia" <aglo@umich.edu>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Chuck Lever III" <chuck.lever@oracle.com>
Subject: Re: Is this nfsd kernel oops known?
Date:   Wed, 07 Sep 2022 08:52:46 -0400
Message-ID: <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com>
In-Reply-To: <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7 Sep 2022, at 0:58, Chuck Lever III wrote:

>> On Sep 6, 2022, at 3:12 PM, Olga Kornievskaia <aglo@umich.edu> wrote:
>>
>> On Tue, Sep 6, 2022 at 2:28 PM Benjamin Coddington 
>> <bcodding@redhat.com> wrote:
>>>
>>> On 1 Sep 2022, at 21:27, Olga Kornievskaia wrote:
>>>
>>>> Thanks Chuck. I first, based on a hunch, narrowed down that it's
>>>> coming from Al Viro's merge commit. Then I git bisected his 
>>>> 32patches
>>>> to the following commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979
>>>
>>> No crash for me after reverting 
>>> f0f6b614f83dbae99d283b7b12ab5dd2e04df979.
>>
>> I second that. No crash after a revert here.
>
> I bisected the new xfstests failures to the same commit:
>
> f0f6b614f83dbae99d283b7b12ab5dd2e04df979 is the first bad commit
> commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Thu Jun 23 17:21:37 2022 -0400
>
>     copy_page_to_iter(): don't split high-order page in case of 
> ITER_PIPE
>
>     ... just shove it into one pipe_buffer.
>
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
>  lib/iov_iter.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>

I've been reliably reproducing this on generic/551 on xfs.  In the case
where it crashes, rqstp->rq_res.page_base is positive multiple of 
PAGE_SIZE
after getting set in nfsd_splice_actor(), and that with page_len 
overruns
the 256 pages we have.

With f0f6b614f83d reverted, rqstp->rq_res.page_base is always zero.

After 47b7fcae419dc and f0f6b614f83d, buf->offset in nfsd_splice_actor 
can
be a positive multiple of PAGE_SIZE, whereas before it was always just 
the
offset into the page.

Something like this might fix it up:

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9f486b788ed0..d62963f36f03 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -849,7 +849,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, 
struct pipe_buffer *buf,

         svc_rqst_replace_page(rqstp, buf->page);
         if (rqstp->rq_res.page_len == 0)
-               rqstp->rq_res.page_base = buf->offset;
+               rqstp->rq_res.page_base = buf->offset % PAGE_SIZE;
         rqstp->rq_res.page_len += sd->len;
         return sd->len;
  }


.. but we should check with Al about whether this needs to be fixed over 
in
copy_page_to_iter_pipe(),  since I don't think pipe_buffer offset should 
be
greater than PAGE_SIZE.

Al, any thoughts?

Ben

