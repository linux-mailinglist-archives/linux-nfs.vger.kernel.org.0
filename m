Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E0C7466F3
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 03:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGDBrL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 21:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGDBrK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 21:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E3FE4E
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 18:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D58C86108E
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 01:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42AFC433C8;
        Tue,  4 Jul 2023 01:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688435228;
        bh=dfMoSgYM5RJbBVtDZ4AdijqJoLEJkTdS1ggmGstPRi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2sQtbg5DyXKSA75yI1JqRp/ek9ucPwULdZPI0EydB7q56o6u4Ok6kNO8ecPLY69J
         MmWW8kO9Q4L0aPHtKBDu1JIbuFC+Xb535rOBo75og023jwuUQPVm/ySFsMBfzLfJiL
         BhlPe+MDyp6WURItli1CZeOmS48OvvlDF3x/yoOkyiio8DkWnIDFHqiAvqiGpLEV6a
         ILE0rhN2V35xAchHNiSR2AwHWvS4cYaNWAoxM4PC+iXPxe+jaHRiq0NekN6/FaRqVM
         FpBmgwdcdFQYHxWeB0SZ0047iVjO0pzt/470wAGPdsM+AI5udML8l246JMMR/Zf9QE
         XkQ+t7jiKW3tg==
Date:   Mon, 3 Jul 2023 21:47:05 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v2 4/9] SUNRPC: Count ingress RPC messages per svc_pool
Message-ID: <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>
 <168843152047.8939.5788535164524204707@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168843152047.8939.5788535164524204707@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 04, 2023 at 10:45:20AM +1000, NeilBrown wrote:
> On Tue, 04 Jul 2023, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > To get a sense of the average number of transport enqueue operations
> > needed to process an incoming RPC message, re-use the "packets" pool
> > stat. Track the number of complete RPC messages processed by each
> > thread pool.
> 
> If I understand this correctly, then I would say it differently.
> 
> I think there are either zero or one transport enqueue operations for
> each incoming RPC message.  Is that correct?  So the average would be in
> (0,1].
> Wouldn't it be more natural to talk about the average number of incoming
> RPC messages processed per enqueue operation?  This would be typically
> be around 1 on a lightly loaded server and would climb up as things get
> busy. 
> 
> Was there a reason you wrote it the way around that you did?

Yes: more than one enqueue is done per incoming RPC. For example,
svc_data_ready() enqueues, and so does svc_xprt_receive().

If the RPC requires more than one call to ->recvfrom() to complete
the receive operation, each one of those calls does an enqueue.
