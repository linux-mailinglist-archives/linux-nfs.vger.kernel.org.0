Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EDA57106E
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 04:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiGLCon (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 22:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiGLCol (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 22:44:41 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738E32AC66
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 19:44:40 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C489661D1; Mon, 11 Jul 2022 22:44:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C489661D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1657593879;
        bh=WHOZ45h/X2eyJFtiF5ItPZDJpL8pd2wyUEZKUfBUxnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wp/ssd0IUuUndmb9tdXy1Ih8VPcaYUjqOpRC2JNZvOw48ke4qWClsO7F7MVBhQlcv
         Bujf/WeKKfMQ5IRDLU96JrMX//DWJ++MnkZ5DGAqweJurGKXMKw1Sat9V8/aqtVzbr
         mXmPckAvc/ZDHKeIMVHMV4wIiuqgiN5BF6RHWlQA=
Date:   Mon, 11 Jul 2022 22:44:39 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1] Add basic tests for DESTROY_SESSION
Message-ID: <20220712024439.GE14184@fieldses.org>
References: <165756921593.2281287.10609723157095539123.stgit@morisot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165756921593.2281287.10609723157095539123.stgit@morisot.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applying, thanks.--b.

On Mon, Jul 11, 2022 at 03:55:32PM -0400, Chuck Lever wrote:
> The existing DSESS tests seem specific to Ganesha; they fail when
> run against Linux NFSD. Here's a basic one that all server
> implementations should PASS.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  nfs4.1/server41tests/st_destroy_session.py |   23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/nfs4.1/server41tests/st_destroy_session.py b/nfs4.1/server41tests/st_destroy_session.py
> index b8be62582366..bd5e12d7ebf1 100644
> --- a/nfs4.1/server41tests/st_destroy_session.py
> +++ b/nfs4.1/server41tests/st_destroy_session.py
> @@ -1,12 +1,33 @@
>  from .st_create_session import create_session
>  from xdrdef.nfs4_const import *
> -from .environment import check, fail, create_file, open_file
> +from .environment import check, fail, create_file, open_file, close_file
>  from xdrdef.nfs4_type import open_owner4, openflag4, createhow4, open_claim4
>  import nfs_ops
>  op = nfs_ops.NFS4ops()
>  import threading
>  import rpc.rpc as rpc
>  
> +def testDestroyBasic(t, env):
> +    """Operations after DESTROY_SESSION should fail with BADSESSION
> +
> +    FLAGS: destroy_session all
> +    CODE: DSESS1
> +    """
> +    c = env.c1.new_client(env.testname(t))
> +    sess1 = c.create_session()
> +    sess1.compound([op.reclaim_complete(FALSE)])
> +    res = c.c.compound([op.destroy_session(sess1.sessionid)])
> +    res = create_file(sess1, env.testname(t),
> +                      access=OPEN4_SHARE_ACCESS_READ)
> +    check(res, NFS4ERR_BADSESSION)
> +    sess2 = c.create_session()
> +    res = create_file(sess2, env.testname(t),
> +                      access=OPEN4_SHARE_ACCESS_READ)
> +    check(res)
> +    fh = res.resarray[-1].object
> +    open_stateid = res.resarray[-2].stateid
> +    close_file(sess2, fh, stateid=open_stateid)
> +
>  def testDestroy(t, env):
>      """
>     - create a session
> 
