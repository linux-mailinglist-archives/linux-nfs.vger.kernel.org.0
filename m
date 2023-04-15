Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E466E347F
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Apr 2023 01:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDOXVe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Apr 2023 19:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDOXVe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Apr 2023 19:21:34 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467252117
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 16:21:32 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33FNLH3b022776;
        Sun, 16 Apr 2023 08:21:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sun, 16 Apr 2023 08:21:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33FNLH8S022773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 16 Apr 2023 08:21:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
Date:   Sun, 16 Apr 2023 08:21:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
 <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
 <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
 <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2023/04/16 3:40, Jeff Layton wrote:
> On Sun, 2023-04-16 at 02:11 +0900, Tetsuo Handa wrote:
>> On 2023/04/16 1:13, Chuck Lever III wrote:
>>>> On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>>>
>>>> Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | GFP_NOFS
>>>> does not make sense. Drop __GFP_FS flag in order to avoid deadlock.
>>>
>>> The server side threads run in process context. GFP_KERNEL
>>> is safe to use here -- as Jeff said, this code is not in
>>> the server's reclaim path. Plenty of other call sites in
>>> the NFS server code use GFP_KERNEL.
>>
>> GFP_KERNEL memory allocation calls filesystem's shrinker functions
>> because of __GFP_FS flag. My understanding is
>>
>>   Whether this code is in memory reclaim path or not is irrelevant.
>>   Whether memory reclaim path might hold lock or not is relevant.
>>
>> . Therefore, question is, does nfsd hold i_rwsem during memory reclaim path?
>>
> 
> No. At the time of these allocations, the i_rwsem is not held.

Excuse me? nfsd_getxattr()/nfsd_listxattr() _are_ holding i_rwsem
via inode_lock_shared(inode) before kvmalloc(GFP_KERNEL | GFP_NOFS) allocation.
That's why

	/*
	 * We're holding i_rwsem - use GFP_NOFS.
	 */

is explicitly there in nfsd_listxattr() side.

If memory reclaim path (directly or indirectly via locking dependency) involves
inode_lock_shared(inode)/inode_lock(inode), it is not safe to use __GFP_FS flag.

