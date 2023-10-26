Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9007D8559
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Oct 2023 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjJZO5c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 10:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjJZO5b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 10:57:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A876693;
        Thu, 26 Oct 2023 07:57:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA795C433C7;
        Thu, 26 Oct 2023 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698332249;
        bh=xFnrK/hYymR3dfz8jx8fav5cyj+9R1dn8SkXsqL4fWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggiYUmgKY6ENHDjAVtmLaip5NluFzVyIwYaHAMfn8f9qujFJ9uMk02EcWnmmCdumC
         0H7U3gAk6FFMrHw4WOmERYzAJFLOsFEvXr6h4cgP7Wauq1QdXKReshzxxJ5+9op3ZU
         OoON7cV0ZvvGdDHM1O7cG4P9g3XQa23A/jJchbL1XdYXysz4liFuAyeLZe32RUMyFx
         TTtFeseZCeHTvWtlJzc2Jfl4v1u8l4A6HBBPBlFTGPG5+ReRUtW35W9Juz6OqHQnnx
         JHWwKBZcTT6oqjE6BBh+S2GuRQtp3QfxcxRWdDEuMaTvS9tUhr9BDuFTYbYF6W/KhT
         QVPoht0R37Wyw==
Date:   Thu, 26 Oct 2023 15:57:20 +0100
From:   Simon Horman <horms@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: sunrpc: Fix an off by one in root_nfs_cat()
Message-ID: <20231026145720.GB225043@kernel.org>
References: <856a652a7e28dde246b00025da7d4115978ae75f.1698184400.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <856a652a7e28dde246b00025da7d4115978ae75f.1698184400.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 24, 2023 at 11:55:30PM +0200, Christophe JAILLET wrote:
> The intent is to check if the strings' are truncated or not. So, >= should
> be used instead of >, because strlcat() and snprintf() return the length of
> the output, excluding the trailing NULL.
> 
> Fixes: a02d69261134 ("SUNRPC: Provide functions for managing universal addresses")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>

