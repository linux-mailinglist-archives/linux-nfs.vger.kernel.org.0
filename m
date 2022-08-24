Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB7B59F61A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Aug 2022 11:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiHXJVC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Aug 2022 05:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiHXJVC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Aug 2022 05:21:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53969832F7;
        Wed, 24 Aug 2022 02:21:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E27E4617E4;
        Wed, 24 Aug 2022 09:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5138C433D6;
        Wed, 24 Aug 2022 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661332860;
        bh=aHssPV+PvZjgi8MDT5duCiMiIpJ6jhBj9xyXxHLUzok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oViOs84xwCgHkMMjWBwXuyhM2PHi3AGoN+ld6xN6xhO9mFWy3Bc2Uig4xY8aGv7Lm
         j7vWnzOGmtaUYPT2p1zOzYWdT4QaMh4LlTP03Toqzftt7QykauJcCWSwGh4ev3qY5B
         D5gOQT3Li72E6iabkt9ppsTchjdJEnDJqZo1MM6c5pxxIv8LyT4algU2eQ1HnPi6/K
         3lHkGpMrDV0fwjzdkJhdykuJ3/wJzn9eXAt+jtn+00n1t3a8W6RI4ribg7pqtku4FM
         fH4u44rFJlrz4rD7a/RD/dhLoMQ6PmouGfZzcpfsiXSnVsfTTxgXolmir4eF41TsJZ
         +drxOH8HV+chg==
Date:   Wed, 24 Aug 2022 12:20:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v1] RDMA/core: Fix check_flush_dependency splat on addr_wq
Message-ID: <YwXtePKW+sn/89M6@unreal>
References: <166118222093.3250511.11454048195824271658.stgit@morisot.1015granger.net>
 <YwSLOxyEtV4l2Frc@unreal>
 <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <584E7212-BC09-48E1-A27E-725E54FA075E@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 23, 2022 at 01:58:44PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 23, 2022, at 4:09 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Mon, Aug 22, 2022 at 11:30:20AM -0400, Chuck Lever wrote:

<...>

> >> The xprtiod work queue is WQ_MEM_RECLAIM, so any work queue that
> >> one of its work items tries to cancel has to be WQ_MEM_RECLAIM to
> >> prevent a priority inversion.
> > 
> > But why do you have WQ_MEM_RECLAIM in xprtiod?
> 
> Because RPC is under a filesystem (NFS). Therefore it has to handle
> writeback demanded by direct reclaim. All of the storage ULPs have
> this constraint, in fact.

I don't know, this ib_addr workqueue is used when connection is created.
Jason, what do you think?

Thanks
