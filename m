Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9367365BE3D
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jan 2023 11:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbjACKfs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 05:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbjACKfj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 05:35:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FC2FAE8
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 02:35:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84C1461227
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 10:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB17DC433D2;
        Tue,  3 Jan 2023 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672742114;
        bh=pKGkVyuUN9vH68w0zKGe1yKcS0Pl8Xq8FzgezhAuf98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufnH+fDZ6EvzO6bL1gT93T3F96cNfNNqmVMwBnr5sKlbDLAuqTKFVIHmxZpNsWhLj
         S3B2zmdZOUo/UYDNTWSXX3qefEpTUw57a5qTrQcblGu1qeXwez+Wh0KR0WG0X0C8p5
         CtuDFc0PnOeVzEeKc1gqItWgpkWY0Me1fxFxb00LuF3np/p6Bie5dmGtfrhR3Aa41P
         WTuWKoM+ea1GFKtrjFjduG2wgRYDbc3vMgj6E0WCNOLkT/63Cr5gQ4yS1PpJeRCZni
         ELRzU6R7g2VuYL8GB9edA4MO51Dvedxn16CG8ug3+oOWjBxiS3FFuaMrWmOk9gmJ4u
         m4QZtWcTu1qoA==
Date:   Tue, 3 Jan 2023 11:35:09 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "cuiyue-fnst@fujitsu.com" <cuiyue-fnst@fujitsu.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: nfs setgid inheritance test
Message-ID: <20230103103509.2go7k6b767wst6xg@wittgenstein>
References: <OS0PR01MB64337F9E0954384995085EFDE3F09@OS0PR01MB6433.jpnprd01.prod.outlook.com>
 <20221230154800.pt3hkfzmkmmmtuq7@wittgenstein>
 <OS0PR01MB64334F6BB7530E4334CDD2F4E3F19@OS0PR01MB6433.jpnprd01.prod.outlook.com>
 <20221231121005.e7tuny36oqury5vy@wittgenstein>
 <OS0PR01MB6433F3BE4AE069C163DC93EFE3F49@OS0PR01MB6433.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OS0PR01MB6433F3BE4AE069C163DC93EFE3F49@OS0PR01MB6433.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 03, 2023 at 02:58:29AM +0000, cuiyue-fnst@fujitsu.com wrote:
> Hello Christian, 
> 
> > > Thank you for your response.
> > >
> > > > Afaict, nothing has changed and the test should still be skipped.
> > > > I'm not sure I ever send a patch to skip this test specifically for
> > > > nfs though. I might just not have gotten around to that.
> > > >
> > > > Can you please also send the exact steps for reproducing this issue?
> > >
> > > The reproducing steps is as follows:
> > >
> > > Client & Server:
> > > 1. Install xfstests
> > > 2. # yum install libcap-devel
> > >
> > > Server:
> > > 1. Set exports file.
> > > # echo "/nfstest
> > *(rw,insecure,no_subtree_check,no_root_squash,fsid=1)
> > > /nfsscratch
> > *(rw,insecure,no_subtree_check,no_root_squash,fsid=2)" >/etc/exports
> > > 2. Restart services.
> > > # systemctl restart rpcbind.service
> > > # systemctl restart nfs-server.service # systemctl restart
> > > rpc-statd.service
> > >
> > > Client:
> > > 1. Create mount point
> > > # mkdir -p /mnt/test
> > > # mkdir -p /mnt/scratch
> > > 2. Cofigure NFS parameters.
> > > # echo "FSTYP=nfs
> > > TEST_DEV=server_IP:/nfstest
> > > TEST_DIR=/mnt/test
> > > SCRATCH_DEV=server_IP:/nfsscratch
> > > SCRATCH_MNT=/mnt/scratch
> > > export KEEP_DMESG=yes
> > > NFS_MOUNT_OPTIONS=\"-o vers=3\"">/var/lib/xfstests/local.config
> > > 3. Test
> > > # ./check -d generic/633
> > 
> > The tests should pass with "no_root_squash" set. The root cause of the original
> > issue was that files created by root are squashed to 65534 which breaks setgid
> > inheritance rules for S_ISGID directories.
> > 
> > But without root squashing the tests should succeed. If I reproduce this exactly
> > with your instructions on a v6.2-rc1 kernel I get a success as expected.
> > 
> > I don't think you've told me What kernel you are testing this on?
> 
> Sorry, I didn't make it clearly before.

No worries.

> I tested on kernel 5.14.0-162.6.1.el9_1.x86_64, and it failed with "no_root_squash" set.
> But after I apply commit 1639a49ccdce58ea248841ed9b23babcce6dbb0b onto kernel 5.14.0-162.6.1.el9_1.x86_64, 
> the case will pass.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=1639a49ccdce58ea248841ed9b23babcce6dbb0b

Ah, good. That's crucial information as no_root_squash did work before
and it would've been a regression if it suddenly would leave the setgid
bit set.

> This patch moves S_ISGID stripping into the vfs, so NFS can solve the setgid inheritance problem.
> 
> But although the test can succeed, when the root is squashed to nobody, is it still suitable to use generic/633 to test?

No, when root squashing is enabled the test shouldn't run. I've
mentioned this in my earlier mail.

Just one example, when you create a new file in a setgid directory then
the new file will inherit the gid of the directory it has been created
in. But with root squashing that's no longer the case for the root user
since root squashing changes the {g,u}id that a file is created as. It
essentially idmaps {g,u}id 0 to 655345. That means reasoning about
setgid inheritance rules as the root user doesn't work in the tests
anymore. If that is a desirable thing then xfstests should gain a new
nfs specific test for this case.
