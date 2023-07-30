Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8D76863D
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jul 2023 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjG3Pih (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jul 2023 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjG3Pig (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jul 2023 11:38:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069981A6;
        Sun, 30 Jul 2023 08:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7285260C90;
        Sun, 30 Jul 2023 15:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6BDC433C7;
        Sun, 30 Jul 2023 15:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690731514;
        bh=6Tg+YnOjTOzZ36qidVpHdrfFL8OCIoJOBbOccF6fXOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G6XNmH6q8NDph4s4tKRMg1HzXO7d35v8KhJ1rYKyCvQihaXbPSrstWu3yHWFtGkN/
         /AzMPjt5EMO9fj3uXNksTc7eE3aKQq7U9tVt4qCrEADu3lZUWFH7+mpPvb9Elz3q/J
         //AedUHZd032n0qia2V8EB13C0zLZD8+dsF2gzM8KGR7s329KwTqo+IZSpemxP0cJo
         YeJ1fY+iykWTSdll3IK3NjWqidVEt8YcBbC/UkyGB/DBNr9gkdnLo5t/R0UQElPJvG
         wqGBnpzrG1w4mQ1CFy9nDxt0QdKk1NJD5NRZZdxKkxKkZ2D0ThOQY5P2jOjMlgJHpj
         lu5d/lS0oRZFA==
Date:   Sun, 30 Jul 2023 17:38:29 +0200
From:   Simon Horman <horms@kernel.org>
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sunrpc: wrap debug symobls with CONFIG_SUNRPC_DEBUG
Message-ID: <ZMaD9ZIxQ3kRuCgB@kernel.org>
References: <20230728145751.138057-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728145751.138057-1-minhuadotchen@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 28, 2023 at 10:57:50PM +0800, Min-Hua Chen wrote:
> rpc_debug, nfs_debug, nfsd_debug, and nlm_debug are used
> if CONFIG_SUNRPC_DEBUG is set. Wrap them with CONFIG_SUNRPC_DEBUG
> and fix the following sparse warnings:
> 
> net/sunrpc/sysctl.c:29:17: sparse: warning: symbol 'rpc_debug' was not declared. Should it be static?
> net/sunrpc/sysctl.c:32:17: sparse: warning: symbol 'nfs_debug' was not declared. Should it be static?
> net/sunrpc/sysctl.c:35:17: sparse: warning: symbol 'nfsd_debug' was not declared. Should it be static?
> net/sunrpc/sysctl.c:38:17: sparse: warning: symbol 'nlm_debug' was not declared. Should it be static?
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

