Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C204B536E56
	for <lists+linux-nfs@lfdr.de>; Sat, 28 May 2022 22:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiE1US5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 May 2022 16:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiE1US4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 28 May 2022 16:18:56 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611FD4B865
        for <linux-nfs@vger.kernel.org>; Sat, 28 May 2022 13:18:53 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B2FA81506; Sat, 28 May 2022 16:18:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B2FA81506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1653769132;
        bh=fBJruRo+ZwstRVSyLUK8JtL3lvw/sER98oJ4abJw/Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YEYgVETbnwV6iwgzMCjG72nvGPPJpySQs5QHcqEy6hr+Q1lZkLmO3ayPg4FAYIPYv
         u4eADLG8wu8zYQhE1PZurxY7tgAuPbvKGQzoN0Anp48aIl1++zII5othqg0VPKQ+du
         8Y/BoVDX0YajktrBvZjdgSqftSDYIu4SkQMMzlUM=
Date:   Sat, 28 May 2022 16:18:52 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Add pynfs4.0 release lockowner test RLOWN2
Message-ID: <20220528201852.GD9929@fieldses.org>
References: <1653341570-22461-1-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653341570-22461-1-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applied, thanks.--b.

On Mon, May 23, 2022 at 02:32:50PM -0700, Dai Ngo wrote:
> Add RLOWN2, similar to RLOWN1 but remove the file before release
> lockowner. This test is to exercise to code path causing problem
> of being blocked in nfsd_file_put while holding the cl_client lock.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  nfs4.0/servertests/st_releaselockowner.py | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/nfs4.0/servertests/st_releaselockowner.py b/nfs4.0/servertests/st_releaselockowner.py
> index ccd10ff..2c83f99 100644
> --- a/nfs4.0/servertests/st_releaselockowner.py
> +++ b/nfs4.0/servertests/st_releaselockowner.py
> @@ -24,3 +24,28 @@ def testFile(t, env):
>      owner = lock_owner4(c.clientid, b"lockowner_RLOWN1")
>      res = c.compound([op.release_lockowner(owner)])
>      check(res)
> +
> +def testFile2(t, env):
> +    """RELEASE_LOCKOWNER 2 - same as basic test but remove
> +    file before release lockowner.
> +
> +    FLAGS: releaselockowner all
> +    DEPEND:
> +    CODE: RLOWN2
> +    """
> +    c = env.c1
> +    c.init_connection()
> +    fh, stateid = c.create_confirm(t.word())
> +    res = c.lock_file(t.word(), fh, stateid, lockowner=b"lockowner_RLOWN2")
> +    check(res)
> +    res = c.unlock_file(1, fh, res.lockid)
> +    check(res)
> +
> +    ops = c.use_obj(c.homedir) + [op.remove(t.word())]
> +    res = c.compound(ops)
> +    check(res)
> +
> +    # Release lockowner
> +    owner = lock_owner4(c.clientid, b"lockowner_RLOWN2")
> +    res = c.compound([op.release_lockowner(owner)])
> +    check(res)
> -- 
> 1.8.3.1
