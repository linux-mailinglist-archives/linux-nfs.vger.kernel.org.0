Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164284B23C5
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Feb 2022 11:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbiBKKzr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Feb 2022 05:55:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbiBKKzp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Feb 2022 05:55:45 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E7AD8D
        for <linux-nfs@vger.kernel.org>; Fri, 11 Feb 2022 02:55:43 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebe1.dynamic.kabel-deutschland.de [95.90.235.225])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EB81161EA1926;
        Fri, 11 Feb 2022 11:55:40 +0100 (CET)
Message-ID: <82dffa3e-1b14-e590-aaf6-f9f8570e616c@molgen.mpg.de>
Date:   Fri, 11 Feb 2022 11:55:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] NFS: LOOKUP_DIRECTORY is also ok with symlinks
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, it+linux-nfs@molgen.mpg.de,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        regressions@lists.linux.dev
References: <20220208183823.1391397-1-trondmy@kernel.org>
 <d16aac1e-a3aa-309a-0130-c60147c980d1@molgen.mpg.de>
In-Reply-To: <d16aac1e-a3aa-309a-0130-c60147c980d1@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

#regzbot monitor: 
https://lore.kernel.org/linux-nfs/20220208183823.1391397-1-trondmy@kernel.org/

Dear Trond,


Am 09.02.22 um 23:02 schrieb Paul Menzel:

> Am 08.02.22 um 19:38 schrieb trondmy@kernel.org:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> Commit ac795161c936 (NFSv4: Handle case where the lookup of a directory
>> fails) [1], part of Linux since 5.17-rc2, introduced a regression, where
>> a symbolic link on an NFS mount to a directory on another NFS does not
>> resolve(?) the first time it is accessed:
>>
>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Fixes: ac795161c936 ("NFSv4: Handle case where the lookup of a 
>> directory fails")
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Thank you for fixing it so quickly. My colleague verified, that it fixes 
> our issue.
> 
> Tested-by: Donald Buczek <buczek@molgen.mpg.de>

Also for regzbot:

Link: 
https://lore.kernel.org/linux-nfs/0235e04a-18aa-ccbf-f520-38a2d55e8b54@molgen.mpg.de/


Kind regards,

Paul


>> ---
>>   fs/nfs/dir.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>> index e128503728f2..6dee4e12d381 100644
>> --- a/fs/nfs/dir.c
>> +++ b/fs/nfs/dir.c
>> @@ -2051,14 +2051,14 @@ int nfs_atomic_open(struct inode *dir, struct 
>> dentry *dentry,
>>       if (!res) {
>>           inode = d_inode(dentry);
>>           if ((lookup_flags & LOOKUP_DIRECTORY) && inode &&
>> -            !S_ISDIR(inode->i_mode))
>> +            !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
>>               res = ERR_PTR(-ENOTDIR);
>>           else if (inode && S_ISREG(inode->i_mode))
>>               res = ERR_PTR(-EOPENSTALE);
>>       } else if (!IS_ERR(res)) {
>>           inode = d_inode(res);
>>           if ((lookup_flags & LOOKUP_DIRECTORY) && inode &&
>> -            !S_ISDIR(inode->i_mode)) {
>> +            !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))) {
>>               dput(res);
>>               res = ERR_PTR(-ENOTDIR);
>>           } else if (inode && S_ISREG(inode->i_mode)) {
