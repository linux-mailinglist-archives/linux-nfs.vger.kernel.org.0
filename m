Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4237C85DD
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Oct 2023 14:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjJMMen (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Oct 2023 08:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjJMMem (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Oct 2023 08:34:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75E4BD;
        Fri, 13 Oct 2023 05:34:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92344C433C8;
        Fri, 13 Oct 2023 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697200481;
        bh=TvaszAa1RVva07RsdzVcq3JaOcKMz7c1edgzZZ1dueA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2QrR7x8DjDdi3eZfOOEmzZCHQfw/uXf4rmdALLzwAXUAHlYGdTzrrlZg9AZlgtvz
         U7/z/4n8J9hxcySByWivnR0BZYOzct8yzGmWbRUIwFy0XXqAPNj6xYzpdzsiO2DGQ2
         BqX7XBlldwH0h76xXG67B4+9RoYLsSZmDAg7vy9EbBnbJUjBbfwmD9MdtuczV3cvad
         7bOMKH6+/a27wTRrSoOPtm+LkupyGkRFh8Yy1Wgf1BgAU8+gyF/3T9zg68fh1Vis6H
         kJ+XbJl6N+gHSdp7XnwlBSTnyTwZhXFHU6VzWIoK7/g4GUpQXOC2x2bDeMaDhVpUuw
         0W+8yoXKALA4A==
Date:   Fri, 13 Oct 2023 14:34:35 +0200
From:   Simon Horman <horms@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Xin Tan <tanxin.ctf@gmail.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-XXX] SUNRPC: Add an IS_ERR() check back to where it
 was
Message-ID: <20231013123435.GK29570@kernel.org>
References: <356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 11, 2023 at 11:00:22AM +0300, Dan Carpenter wrote:
> This IS_ERR() check was deleted during in a cleanup because, at the time,
> the rpcb_call_async() function could not return an error pointer.  That
> changed in commit 25cf32ad5dba ("SUNRPC: Handle allocation failure in
> rpc_new_task()") and now it can return an error pointer.  Put the check
> back.
> 
> A related revert was done in commit 13bd90141804 ("Revert "SUNRPC:
> Remove unreachable error condition"").
> 
> Fixes: 037e910b52b0 ("SUNRPC: Remove unreachable error condition in rpcb_getport_async()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks,

I've reviewed the logic of this commit along with the description
and it matches up in my mind.

Reviewed-by: Simon Horman <horms@kernel.org>
