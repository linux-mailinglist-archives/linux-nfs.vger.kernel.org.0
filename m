Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E32C6F6528
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 08:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjEDGil (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 02:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEDGik (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 02:38:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF0D2713
        for <linux-nfs@vger.kernel.org>; Wed,  3 May 2023 23:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CA0F63026
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 06:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDEBC433EF;
        Thu,  4 May 2023 06:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683182318;
        bh=6qx6l3zW0LV7J9K1OMuDGwXITRI4dS+m35AAlxBZAgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fiz8BHr4WhrzMQ9TSGzuA2aS6GL3ck0f3v8bPftxdzK+xyUBSIs5LYNqUz39LaM8S
         0yiGKi6diqdXaTNd16DYdNNJYHXWCwNn7K5NqgMBJEKsFjYs2JmhVle516HCUFROdz
         ewgk+MwDnmkNPydl1d5/MbPpWcAcemOjDfm7IicypfEDb/Cn3FeQOztwguoVG+PmGa
         3Rvxj/3yCA4X1ItzRs4BJAgXDm7hFw6+bfQD4I9cui44pslo9BlJ1RCZCkGr7YlprZ
         gRNlpad+6OvDgT1nJK2Mx1KTGhmuSbb54vrh5DFlSzSFe5eMo3KKZUp9c/xXJqE7nb
         nJ0Z1ByAj+bpQ==
Date:   Thu, 4 May 2023 08:38:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Sherry Yang <sherry.yang@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH] nfsd: use vfs setgid helper
Message-ID: <20230504-rasten-vibrieren-ee7f0e7a39ef@brauner>
References: <20230502-agenda-regeln-04d2573bd0fd@brauner>
 <77C7061E-2316-4C73-89E5-7C8CA0AEB6FD@oracle.com>
 <51805A56-F815-405F-8CDF-4CD04A17436C@oracle.com>
 <741D94D5-4058-452E-830B-49D3BEBD5D8E@oracle.com>
 <20230503-mehrverbrauch-spargel-258668d27f53@brauner>
 <ac5c9882-8cc7-8d64-5784-fd71b04dde3a@oracle.com>
 <A5A8DAD5-7FFD-4CE6-ADC9-FF9F5E509869@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A5A8DAD5-7FFD-4CE6-ADC9-FF9F5E509869@oracle.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 03, 2023 at 02:05:48PM +0000, Chuck Lever III wrote:
> 
> 
> > On May 3, 2023, at 6:53 AM, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:
> > 
> > Hi Christian,
> > 
> > On 03/05/23 12:30 pm, Christian Brauner wrote:
> >> On Tue, May 02, 2023 at 06:23:51PM +0000, Chuck Lever III wrote:
> >>> 
> >>> 
> >>>> On May 2, 2023, at 12:50 PM, Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>>> 
> >>>> 
> >>>> 
> >>>>> On May 2, 2023, at 9:49 AM, Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>>>> 
> >>>>>> 
> >>>>>> On May 2, 2023, at 9:36 AM, Christian Brauner <brauner@kernel.org> wrote:
> >>>>>> 
> >>>>>> We've aligned setgid behavior over multiple kernel releases. The details
> >>>>>> can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2' of
> >>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
> >>>>>> commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
> >>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
> >>>>>> Consistent setgid stripping behavior is now encapsulated in the
> >>>>>> setattr_should_drop_sgid() helper which is used by all filesystems that
> >>>>>> strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
> >>>>>> raised in e.g., chown_common() and is subject to the
> >>>>>> setattr_should_drop_sgid() check to determine whether the setgid bit can
> >>>>>> be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
> >>>>>> will cause notify_change() to strip it even if the caller had the
> >>>>>> necessary privileges to retain it. Ensure that nfsd only raises
> >>>>>> ATR_KILL_SGID if the caller lacks the necessary privileges to retain the
> >>>>>> setgid bit.
> >>>>>> 
> >>>>>> Without this patch the setgid stripping tests in LTP will fail:
> >>>>>> 
> >>>>>>> As you can see, the problem is S_ISGID (0002000) was dropped on a
> >>>>>>> non-group-executable file while chown was invoked by super-user, while
> >>>>>> 
> >>>>>> [...]
> >>>>>> 
> >>>>>>> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
> >>>>>> 
> >>>>>> [...]
> >>>>>> 
> >>>>>>> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
> >>>>>> 
> >>>>>> With this patch all tests pass.
> >>>>>> 
> >>>>>> Reported-by: Sherry Yang <sherry.yang@oracle.com>
> >>>>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
> >>>>> 
> > 
> > We had a very similar report from kernel-test-robot.
> > 
> > https://lore.kernel.org/all/202210091600.dbe52cbf-yujie.liu@intel.com/
> > 
> > Which points to commit: ed5a7047d201 ("attr: use consistent sgid stripping checks")
> > 
> > And the above commit is backported to LTS kernels -- 5.10.y,5.15.y and 6.1.y
> > 
> > So would it be better to tag it to stable by adding "Cc: <stable@vger.kernel.org>" ?
> > 
> > Thanks,
> > Harshit
> > 
> >>>>> There are some similar fstests failures this fix might address.
> >>>>> 
> >>>>> I've applied this patch to the nfsd-fixes tree for broader
> >>>>> testing.
> >>>> 
> >>>> ERROR: modpost: "setattr_should_drop_sgid" [fs/nfsd/nfsd.ko] undefined!
> >>>> 
> >>>> Did I apply this patch to the wrong kernel?
> >>> 
> >>> setattr_should_drop_sgid() is not available to callers built as
> >>> modules. It needs an EXPORT_SYMBOL or _GPL.
> >> Hey Chuck,
> >> Thanks for taking a look!
> >> The required export is part of
> >> commit 4f704d9a835 ("nfs: use vfs setgid helper")
> >> which is in current mainline as of Monday this week which was part of my
> >> v6.4/vfs.misc PR that was merged.
> >> So this should all work fine on mainline. Seems I didn't use --base
> >> which is why that info was missing.
> >> Thanks!
> >> Christian
> 
> I'll apply this to nfsd-next (6.5) and add Jeff's Reviewed-by
> and a Cc: stable.

Thanks all! Appreciate the Cc: stable fixup.
