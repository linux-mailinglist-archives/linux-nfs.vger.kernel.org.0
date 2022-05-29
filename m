Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E52537297
	for <lists+linux-nfs@lfdr.de>; Sun, 29 May 2022 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiE2UpA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 May 2022 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiE2Uoy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 May 2022 16:44:54 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EA27B9F9
        for <linux-nfs@vger.kernel.org>; Sun, 29 May 2022 13:44:52 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CFB3A685B; Sun, 29 May 2022 16:44:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CFB3A685B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1653857091;
        bh=OXQjX6AaY2KpcbqEollv9lkm0axeWuNAiHWFlN83m6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VP0SpN7d1k5dB4qUgt4SHwQT5R+uO5K/9QcWrYR1Egc8G8V23iyFSh85PXukNBKCy
         UCudCo7SCjHG0ShVLhF7g5ICnizYjMeJLLNY0UHrSDdIeSRmTaUqHci1g3C0CbnJRO
         v8xNAeg0EwGvy9/D7m+81uB9bmUZMnlPZk5MshaM=
Date:   Sun, 29 May 2022 16:44:51 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsv4.0/release-lockowner: Check for proper LOCKS_HELD
 response
Message-ID: <20220529204451.GB32262@fieldses.org>
References: <165384405174.3290283.7508180988614656582.stgit@morisot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165384405174.3290283.7508180988614656582.stgit@morisot.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applied.

(Though I'd prefer new tests go under nfs4.1/server41tests/ where
possible.)

--b.

On Sun, May 29, 2022 at 01:07:31PM -0400, Chuck Lever wrote:
> Ensure that RELEASE_LOCKOWNER returns LOCKS_HELD if the lockowner
> is still in use.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  nfs4.0/servertests/st_releaselockowner.py |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/nfs4.0/servertests/st_releaselockowner.py b/nfs4.0/servertests/st_releaselockowner.py
> index 2c83f99b207f..b296e6c2752a 100644
> --- a/nfs4.0/servertests/st_releaselockowner.py
> +++ b/nfs4.0/servertests/st_releaselockowner.py
> @@ -49,3 +49,24 @@ def testFile2(t, env):
>      owner = lock_owner4(c.clientid, b"lockowner_RLOWN2")
>      res = c.compound([op.release_lockowner(owner)])
>      check(res)
> +
> +def testLocksHeld(t, env):
> +    """RELEASE_LOCKOWNER - Locks held test
> +
> +    FLAGS: releaselockowner all
> +    DEPEND:
> +    CODE: RLOWN3
> +    """
> +    c = env.c1
> +    c.init_connection()
> +    fh, stateid = c.create_confirm(t.word())
> +    res = c.lock_file(t.word(), fh, stateid, lockowner=b"lockowner_RLOWN3")
> +    check(res)
> +    owner = lock_owner4(c.clientid, b"lockowner_RLOWN3")
> +    res2 = c.compound([op.release_lockowner(owner)])
> +    check(res2, NFS4ERR_LOCKS_HELD)
> +    res = c.unlock_file(1, fh, res.lockid)
> +    check(res)
> +    owner = lock_owner4(c.clientid, b"lockowner_RLOWN3")
> +    res = c.compound([op.release_lockowner(owner)])
> +    check(res)
> 
