Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642BE58BCDB
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Aug 2022 22:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiHGUSK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Aug 2022 16:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiHGUSJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 7 Aug 2022 16:18:09 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC2E6166
        for <linux-nfs@vger.kernel.org>; Sun,  7 Aug 2022 13:18:08 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 61BDF6214; Sun,  7 Aug 2022 16:18:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 61BDF6214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1659903487;
        bh=nwZgiXLqDFkR5cqGJIzWWLECp9b5M2KSrf3dGPEeJo8=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=pSoWM+fF9fxtnuQUD+hsejzB7GN51inrNuwDZnLYMvG+4SkTh4A1UeFxunhPI1vRY
         4aHkd2et9PZ0u0Bli4f7ZBeg0zxWNSBI9a0YuNleOqqU6+THxfkzFFTLEs6KdNuRaF
         o8beNToVsJBLpBbxvdg6sdJJqvNlNahh1siC80sQ=
Date:   Sun, 7 Aug 2022 16:18:07 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] DELEG21: Return delegations so clean_diff() works
Message-ID: <20220807201807.GC14260@fieldses.org>
References: <165971593943.1762917.4388644054248311900.stgit@morisot.1015granger.net>
 <165971594611.1762917.16737275128372470606.stgit@morisot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165971594611.1762917.16737275128372470606.stgit@morisot.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 05, 2022 at 12:12:26PM -0400, Chuck Lever wrote:
> WARNING: could not clean testdir due to:
> Making sure b'DELEG21-1' is writable: operation OP_SETATTR should return NFS4_OK, instead got NFS4ERR_DELAY

Thanks, both applied.--b.

> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  nfs4.0/servertests/st_delegation.py |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/nfs4.0/servertests/st_delegation.py b/nfs4.0/servertests/st_delegation.py
> index ff042cdb69a8..9c98ec0e0fb3 100644
> --- a/nfs4.0/servertests/st_delegation.py
> +++ b/nfs4.0/servertests/st_delegation.py
> @@ -731,7 +731,7 @@ def testServerSelfConflict(t, env):
>      c = env.c1
>      count = c.cb_server.opcounts[OP_CB_RECALL]
>      c.init_connection(b'pynfs%i_%s' % (os.getpid(), t.word()), cb_ident=0)
> -    _get_deleg(t, c, c.homedir + [t.word()], None, NFS4_OK)
> +    deleg_info, fh, stateid = _get_deleg(t, c, c.homedir + [t.word()], None, NFS4_OK)
>  
>      sleeptime = 1
>      while 1:
> @@ -746,6 +746,10 @@ def testServerSelfConflict(t, env):
>          check(res, [NFS4_OK, NFS4ERR_DELAY], "Open which causes recall")
>          env.sleep(sleeptime, 'Got NFS4ERR_DELAY on open')
>      c.confirm(b'newowner', res)
> +    res = c.compound([op.putfh(fh), op.delegreturn(deleg_info.read.stateid)])
> +    check(res)
> +    res = c.close_file(t.word(), fh, stateid)
> +    check(res)
>      newcount = c.cb_server.opcounts[OP_CB_RECALL]
>      if newcount > count:
>          t.fail("Unnecessary delegation recall")
> 
