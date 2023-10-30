Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCCF7DB58A
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjJ3I6q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 04:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3I6q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 04:58:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D8A7;
        Mon, 30 Oct 2023 01:58:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E42C433C8;
        Mon, 30 Oct 2023 08:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698656324;
        bh=erM2EyKMcmAPiQ3Ee/fFfOGmnuj/HoTNrYWY9/L8w/A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orpMJTPOKZ9Y7pqYCShS3dCwyhQMartTyOrQ3f3P5/kXRLBaEF3ArbCulkLvQRyPU
         8BnsfLViT73X2JIxkgIwcTRnrfrFs0SFa848NF9pnEuQnjDtFex8MWuWztD6WJKqC9
         K1oPi4+jFJQAgSDx4jjbBFSHWDb6UkBIw1wPhEvU=
Date:   Mon, 30 Oct 2023 09:58:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ChenXiaoSong <chenxiaosongemail@foxmail.com>
Cc:     trond.myklebust@hammerspace.com, chenxiaosong@kylinos.cn,
        Anna.Schumaker@netapp.com, sashal@kernel.org,
        liuzhengyuan@kylinos.cn, huangjinhui@kylinos.cn,
        liuyun01@kylinos.cn, huhai@kylinos.cn, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Question about LTS 4.19 patch "89047634f5ce NFS: Don't interrupt
 file writeout due to fatal errors"
Message-ID: <2023103055-saddled-payer-bd26@gregkh>
References: <tencent_BEDA418B8BD86995FBF3E92D4F9F5D342C0A@qq.com>
 <2023103055-anaerobic-childhood-c1f1@gregkh>
 <tencent_4CA081DD6E435CDA2EAB9C826F7899F78C05@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4CA081DD6E435CDA2EAB9C826F7899F78C05@qq.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 30, 2023 at 04:54:02PM +0800, ChenXiaoSong wrote:
> On 2023/10/30 16:43, Greg KH wrote:
> > Try it and see, but note, that came from the 4.19.99 release which was
> > released years ago, are you sure you are using the most recent 4.19.y
> > release?
> 
> I use the most recent release 1b540579cf66 Linux 4.19.296.
> 
> > If we missed some patches, that should be added on top of the current
> > tree, please let us know the git commit ids of them after you have
> > tested them that they work properly, and we will gladly apply them.
> Merging the entire patchset may not be the best option. Perhaps a better
> choice is to revert this patch. And I would like to see Trond's suggestion.
> 

If you just revert that one patch, is the issue resolved?  And what
about other stable releases that have that change in it?

If this does need to be reverted, please submit a patch that does so and
we can review it that way.

thanks,

greg k-h
