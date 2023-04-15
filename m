Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251796E32C3
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 19:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjDORLv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Apr 2023 13:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDORLv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Apr 2023 13:11:51 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1FB107
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 10:11:49 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33FHBbMD059069;
        Sun, 16 Apr 2023 02:11:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sun, 16 Apr 2023 02:11:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33FHBalh059066
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 16 Apr 2023 02:11:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
Date:   Sun, 16 Apr 2023 02:11:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
 <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2023/04/16 1:13, Chuck Lever III wrote:
>> On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>
>> Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | GFP_NOFS
>> does not make sense. Drop __GFP_FS flag in order to avoid deadlock.
> 
> The server side threads run in process context. GFP_KERNEL
> is safe to use here -- as Jeff said, this code is not in
> the server's reclaim path. Plenty of other call sites in
> the NFS server code use GFP_KERNEL.

GFP_KERNEL memory allocation calls filesystem's shrinker functions
because of __GFP_FS flag. My understanding is

  Whether this code is in memory reclaim path or not is irrelevant.
  Whether memory reclaim path might hold lock or not is relevant.

. Therefore, question is, does nfsd hold i_rwsem during memory reclaim path?

> 
> But I agree that the flag combination doesn't make sense.
> Maybe drop GFP_NOFS instead and call it only a clean-up?

