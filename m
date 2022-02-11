Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63A24B2498
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Feb 2022 12:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiBKLkO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Feb 2022 06:40:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiBKLkN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Feb 2022 06:40:13 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72728E9B
        for <linux-nfs@vger.kernel.org>; Fri, 11 Feb 2022 03:40:10 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nIUHY-0000YI-63; Fri, 11 Feb 2022 12:40:08 +0100
Message-ID: <f7a7d0e1-41ab-f648-97a3-9fd92e0e2eb2@leemhuis.info>
Date:   Fri, 11 Feb 2022 12:40:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-BS
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, it+linux-nfs@molgen.mpg.de,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        regressions@lists.linux.dev
References: <20220208183823.1391397-1-trondmy@kernel.org>
 <d16aac1e-a3aa-309a-0130-c60147c980d1@molgen.mpg.de>
 <82dffa3e-1b14-e590-aaf6-f9f8570e616c@molgen.mpg.de>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] NFS: LOOKUP_DIRECTORY is also ok with symlinks
In-Reply-To: <82dffa3e-1b14-e590-aaf6-f9f8570e616c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1644579610;a36ff182;
X-HE-SMSGID: 1nIUHY-0000YI-63
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11.02.22 11:55, Paul Menzel wrote:
> #regzbot monitor:
> https://lore.kernel.org/linux-nfs/20220208183823.1391397-1-trondmy@kernel.org/

Thx for trying, but that failed (as is unneeded, see below): regzbot
can't determine which of the tracked regression might be meant here, so
it can't associate it with your report.

> Am 09.02.22 um 23:02 schrieb Paul Menzel:
> 
>> Am 08.02.22 um 19:38 schrieb trondmy@kernel.org:
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> Commit ac795161c936 (NFSv4: Handle case where the lookup of a directory
>>> fails) [1], part of Linux since 5.17-rc2, introduced a regression, where
>>> a symbolic link on an NFS mount to a directory on another NFS does not
>>> resolve(?) the first time it is accessed:
>>>
>>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> Fixes: ac795161c936 ("NFSv4: Handle case where the lookup of a
>>> directory fails")
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> Thank you for fixing it so quickly. My colleague verified, that it
>> fixes our issue.
>>
>> Tested-by: Donald Buczek <buczek@molgen.mpg.de>
> 
> Also for regzbot:
> 
> Link:
> https://lore.kernel.org/linux-nfs/0235e04a-18aa-ccbf-f520-38a2d55e8b54@molgen.mpg.de/

Hmmm, regzbot from this could in theory be modified to determine which
regression was meant, but right now regzbot processes commands
sequentially, so in this order it wouldn't work anyway.

But there is a bigger problem: that link points to a reply to your
report, not the report. I guess I can modify regzbot to handle such
cases, but I have more pressing issue right now, sorry. But I'll keep it
in mind.

The right link tag one would have been:

Link:
https://lore.kernel.org/r/bd2075f0-2343-5bfa-83bf-0e916303727d@molgen.mpg.de/

(s!/r/!/linux-nfs/! would have worked for regzbot as well)

Trond, can you please add this tag to your patch in case you respin it,
as explained, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.

BTW, paul: Regzbot will monitor every subthread with a proper link tag
(like I gave above), so there is no need for a "#regzbot monitor" in
anyway if developers would just place the tags as the documentation states.

Ciao, Thorsten


>>> ---
>>>   fs/nfs/dir.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>> index e128503728f2..6dee4e12d381 100644
>>> --- a/fs/nfs/dir.c
>>> +++ b/fs/nfs/dir.c
>>> @@ -2051,14 +2051,14 @@ int nfs_atomic_open(struct inode *dir, struct
>>> dentry *dentry,
>>>       if (!res) {
>>>           inode = d_inode(dentry);
>>>           if ((lookup_flags & LOOKUP_DIRECTORY) && inode &&
>>> -            !S_ISDIR(inode->i_mode))
>>> +            !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
>>>               res = ERR_PTR(-ENOTDIR);
>>>           else if (inode && S_ISREG(inode->i_mode))
>>>               res = ERR_PTR(-EOPENSTALE);
>>>       } else if (!IS_ERR(res)) {
>>>           inode = d_inode(res);
>>>           if ((lookup_flags & LOOKUP_DIRECTORY) && inode &&
>>> -            !S_ISDIR(inode->i_mode)) {
>>> +            !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))) {
>>>               dput(res);
>>>               res = ERR_PTR(-ENOTDIR);
>>>           } else if (inode && S_ISREG(inode->i_mode)) {
> 
> 
