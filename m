Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF7B65E723
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 09:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjAEI4L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 03:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjAEI4C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 03:56:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974784FD6B
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 00:56:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B54561912
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 08:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0061C433D2;
        Thu,  5 Jan 2023 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672908960;
        bh=/WJ4TzwLNTQmsExtQI1HV6Y6AhzYnBFre+KtFdwcou0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8vyWuweqHNWpGbjrSeSiEeorKkXeivcXWjxcgEBQq4B27ruswlk3gn1/OFZFN8bB
         aMl5aZYVHgv1rX9fRRvx9WhKdUicp0g7908foaLGBQgQsrv5RUxQ+ksW0GXpMIhm6M
         taQGLYXr1+ngHlkQgsIjdS9w7rfUOr3zZ6VlDkiInEflIH909TzXKJxI50xaM9DmEN
         Uuh55jx2VfmHatAEwV3a60wd0kHNvKbkYkO8UjlFlcrPf7EN+o4hD5f702AVqo74fG
         Ug78J+fSGclrSa0mHQEQ5ug6g2zlE3W2vo8iKLlc3ELcZlPas6GPZkdmoj3aZudVrR
         J4Q5jhdFnEUrQ==
Date:   Thu, 5 Jan 2023 09:55:56 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "cuiyue-fnst@fujitsu.com" <cuiyue-fnst@fujitsu.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: nfs setgid inheritance test
Message-ID: <20230105085556.6iwv7qhm3xowt2cq@wittgenstein>
References: <OS0PR01MB64337F9E0954384995085EFDE3F09@OS0PR01MB6433.jpnprd01.prod.outlook.com>
 <20221230154800.pt3hkfzmkmmmtuq7@wittgenstein>
 <OS0PR01MB64334F6BB7530E4334CDD2F4E3F19@OS0PR01MB6433.jpnprd01.prod.outlook.com>
 <20221231121005.e7tuny36oqury5vy@wittgenstein>
 <OS0PR01MB6433F3BE4AE069C163DC93EFE3F49@OS0PR01MB6433.jpnprd01.prod.outlook.com>
 <20230103103509.2go7k6b767wst6xg@wittgenstein>
 <OS0PR01MB64337F65D0531CB013CC2A2EE3FA9@OS0PR01MB6433.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS0PR01MB64337F65D0531CB013CC2A2EE3FA9@OS0PR01MB6433.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_05,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 05, 2023 at 08:16:02AM +0000, cuiyue-fnst@fujitsu.com wrote:
> Hi, Christian,
> 
> Thank you so much for your explanation.
> 
> > > I tested on kernel 5.14.0-162.6.1.el9_1.x86_64, and it failed with
> > "no_root_squash" set.
> > > But after I apply commit 1639a49ccdce58ea248841ed9b23babcce6dbb0b
> > onto
> > > kernel 5.14.0-162.6.1.el9_1.x86_64, the case will pass.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com/?h=1639a49ccdce58ea248841ed9b23babcce6dbb0b
> > 
> > Ah, good. That's crucial information as no_root_squash did work before and it
> > would've been a regression if it suddenly would leave the setgid bit set.
> 
> If I don't apply this patch, the setgid bit will not be stripped.
> So is this behavior an NFS bug? 
> Does NFS need to strip SGID bit when the "no_root_squash" set or "root_squash" set?

But I explained that already in the paragraph in previous mails?

* root_squash:    skip the test
* no_root_squash: test works

Of course, it requires kernels where setgid inheritance has been fixed.
IOW, NFS itself doesn't need to do anything.

> 
> Thanks,
> 
> ★☆★☆★☆★☆FNSTオンラインへようこそ★☆★☆★☆★☆
>    FNST最新情報盛りたくさん！
>    http://online.fnst.cn.fujitsu.com/fnst-news
> ★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆
> 
> > -----Original Message-----
> > From: Christian Brauner <brauner@kernel.org>
> > Sent: Tuesday, January 3, 2023 6:35 PM
> > To: Cui, Yue/崔 悦 <cuiyue-fnst@fujitsu.com>
> > Cc: Christian Brauner <christian@brauner.io>; linux-nfs@vger.kernel.org
> > Subject: Re: nfs setgid inheritance test
> > 
> > On Tue, Jan 03, 2023 at 02:58:29AM +0000, cuiyue-fnst@fujitsu.com wrote:
> > > Hello Christian,
> > >
> > > > > Thank you for your response.
> > > > >
> > > > > > Afaict, nothing has changed and the test should still be skipped.
> > > > > > I'm not sure I ever send a patch to skip this test specifically
> > > > > > for nfs though. I might just not have gotten around to that.
> > > > > >
> > > > > > Can you please also send the exact steps for reproducing this issue?
> > > > >
> > > > > The reproducing steps is as follows:
> > > > >
> > > > > Client & Server:
> > > > > 1. Install xfstests
> > > > > 2. # yum install libcap-devel
> > > > >
> > > > > Server:
> > > > > 1. Set exports file.
> > > > > # echo "/nfstest
> > > > *(rw,insecure,no_subtree_check,no_root_squash,fsid=1)
> > > > > /nfsscratch
> > > > *(rw,insecure,no_subtree_check,no_root_squash,fsid=2)" >/etc/exports
> > > > > 2. Restart services.
> > > > > # systemctl restart rpcbind.service # systemctl restart
> > > > > nfs-server.service # systemctl restart rpc-statd.service
> > > > >
> > > > > Client:
> > > > > 1. Create mount point
> > > > > # mkdir -p /mnt/test
> > > > > # mkdir -p /mnt/scratch
> > > > > 2. Cofigure NFS parameters.
> > > > > # echo "FSTYP=nfs
> > > > > TEST_DEV=server_IP:/nfstest
> > > > > TEST_DIR=/mnt/test
> > > > > SCRATCH_DEV=server_IP:/nfsscratch
> > > > > SCRATCH_MNT=/mnt/scratch
> > > > > export KEEP_DMESG=yes
> > > > > NFS_MOUNT_OPTIONS=\"-o vers=3\"">/var/lib/xfstests/local.config
> > > > > 3. Test
> > > > > # ./check -d generic/633
> > > >
> > > > The tests should pass with "no_root_squash" set. The root cause of
> > > > the original issue was that files created by root are squashed to
> > > > 65534 which breaks setgid inheritance rules for S_ISGID directories.
> > > >
> > > > But without root squashing the tests should succeed. If I reproduce
> > > > this exactly with your instructions on a v6.2-rc1 kernel I get a success as
> > expected.
> > > >
> > > > I don't think you've told me What kernel you are testing this on?
> > >
> > > Sorry, I didn't make it clearly before.
> > 
> > No worries.
> > 
> > > I tested on kernel 5.14.0-162.6.1.el9_1.x86_64, and it failed with
> > "no_root_squash" set.
> > > But after I apply commit 1639a49ccdce58ea248841ed9b23babcce6dbb0b
> > onto
> > > kernel 5.14.0-162.6.1.el9_1.x86_64, the case will pass.
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com
> > > mit/?h=1639a49ccdce58ea248841ed9b23babcce6dbb0b
> > 
> > Ah, good. That's crucial information as no_root_squash did work before and it
> > would've been a regression if it suddenly would leave the setgid bit set.
> > 
> > > This patch moves S_ISGID stripping into the vfs, so NFS can solve the setgid
> > inheritance problem.
> > >
> > > But although the test can succeed, when the root is squashed to nobody, is it
> > still suitable to use generic/633 to test?
> > 
> > No, when root squashing is enabled the test shouldn't run. I've mentioned this in
> > my earlier mail.
> > 
> > Just one example, when you create a new file in a setgid directory then the new
> > file will inherit the gid of the directory it has been created in. But with root
> > squashing that's no longer the case for the root user since root squashing
> > changes the {g,u}id that a file is created as. It essentially idmaps {g,u}id 0 to
> > 655345. That means reasoning about setgid inheritance rules as the root user
> > doesn't work in the tests anymore. If that is a desirable thing then xfstests
> > should gain a new nfs specific test for this case.
