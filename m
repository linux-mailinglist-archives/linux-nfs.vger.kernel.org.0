Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB27DB5FD
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 10:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjJ3JTI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 05:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjJ3JTI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 05:19:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B10CC1;
        Mon, 30 Oct 2023 02:19:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A00CC433C8;
        Mon, 30 Oct 2023 09:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698657545;
        bh=tCbSk7k6HoCG0YBYhnscoQAFkrgJgHVIso7mfMwQI/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLncPk0Vsw9NxmRYetbkJRnukmJB0tdR/DHkRESi8vLMafJCDm/18Ey0fsLr6SNzI
         Rphhc7peudNr+vnqlX1IzT69rv/tMthqyAigCKG98YPSlvrzfLaXyrniynDrcKGc0G
         7Y+99sFziteDRdfPpdbb1JskLRsEegoumlJKK3c0=
Date:   Mon, 30 Oct 2023 10:19:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ChenXiaoSong <chenxiaosongemail@foxmail.com>
Cc:     trond.myklebust@hammerspace.com, chenxiaosong@kylinos.cn,
        Anna.Schumaker@netapp.com, sashal@kernel.org,
        liuzhengyuan@kylinos.cn, huangjinhui@kylinos.cn,
        liuyun01@kylinos.cn, huhai@kylinos.cn, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Question about LTS 4.19 patch "89047634f5ce NFS: Don't interrupt
 file writeout due to fatal errors"
Message-ID: <2023103023-playmaker-jingle-9d15@gregkh>
References: <tencent_BEDA418B8BD86995FBF3E92D4F9F5D342C0A@qq.com>
 <2023103055-anaerobic-childhood-c1f1@gregkh>
 <tencent_4CA081DD6E435CDA2EAB9C826F7899F78C05@qq.com>
 <2023103055-saddled-payer-bd26@gregkh>
 <tencent_21E20176E2E5AB7C33CB5E67F10D02763508@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_21E20176E2E5AB7C33CB5E67F10D02763508@qq.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 30, 2023 at 05:04:35PM +0800, ChenXiaoSong wrote:
> 
> On 2023/10/30 16:58, Greg KH wrote:
> > If you just revert that one patch, is the issue resolved?  And what
> > about other stable releases that have that change in it?
> > 
> > If this does need to be reverted, please submit a patch that does so and
> > we can review it that way.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> In my opinion, this patch is not for fixing a bug, but is part of a
> refactoring patchset. The 'Fixes:' tag should not be added.

Nothing we can do about that now, right?  And to try to ask developers
about a change they made in 2019 is a bit rough, don't you think?  If
you think the change is incorrect, please submit a patch to resolve it
after you have tested that it works properly.

thanks,

greg k-h
