Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F77465A3E3
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Dec 2022 13:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLaMKN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 31 Dec 2022 07:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLaMKL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 31 Dec 2022 07:10:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1428FB4B6
        for <linux-nfs@vger.kernel.org>; Sat, 31 Dec 2022 04:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FE5E60AE5
        for <linux-nfs@vger.kernel.org>; Sat, 31 Dec 2022 12:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069F7C433D2;
        Sat, 31 Dec 2022 12:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672488610;
        bh=64IKh9w9YspLRF8YNT7MErwqRoQt5/RoI5l3Z/CVKjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXuoKP015w4PDh+v5KSxYgXaW1VXLz36E9Hi3ueCXYCKWyKA6++R4nTkkPAl398LU
         9BaGFTLaY/3nwDPnFln1HmcBA3JU3dGzTt6RX8bzvs5IwoZys5GopNX+3P7xrpQT7M
         pA+6aFpA0QrQeHaeGK76BDvb1RH6X24eKZYyscVE+uacekdFWHKZi5uNezme2neP1U
         pU5l8pwTm4b7AWUw2liMJNLOAaGmAcPnsv26BT0nsRonTXblYZIw4e7ty7fx+r3VoJ
         TBGlA8+80XqsIqm0LUkEESNoEO2gdYMod13sRrnngpDGO9RjsCn6Dp8+znhwiwYO/L
         cJZ77I2yqH1Fg==
Date:   Sat, 31 Dec 2022 13:10:05 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "cuiyue-fnst@fujitsu.com" <cuiyue-fnst@fujitsu.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: nfs setgid inheritance test
Message-ID: <20221231121005.e7tuny36oqury5vy@wittgenstein>
References: <OS0PR01MB64337F9E0954384995085EFDE3F09@OS0PR01MB6433.jpnprd01.prod.outlook.com>
 <20221230154800.pt3hkfzmkmmmtuq7@wittgenstein>
 <OS0PR01MB64334F6BB7530E4334CDD2F4E3F19@OS0PR01MB6433.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS0PR01MB64334F6BB7530E4334CDD2F4E3F19@OS0PR01MB6433.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_40,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Dec 31, 2022 at 02:25:52AM +0000, cuiyue-fnst@fujitsu.com wrote:
> Hi, Christian
> 
> Thank you for your response.
> 
> > Afaict, nothing has changed and the test should still be skipped.
> > I'm not sure I ever send a patch to skip this test specifically for nfs though. I
> > might just not have gotten around to that.
> > 
> > Can you please also send the exact steps for reproducing this issue?
> 
> The reproducing steps is as follows:
> 
> Client & Server:
> 1. Install xfstests
> 2. # yum install libcap-devel
> 
> Server:
> 1. Set exports file.
> # echo "/nfstest      *(rw,insecure,no_subtree_check,no_root_squash,fsid=1)
> /nfsscratch      *(rw,insecure,no_subtree_check,no_root_squash,fsid=2)" >/etc/exports
> 2. Restart services.
> # systemctl restart rpcbind.service 
> # systemctl restart nfs-server.service
> # systemctl restart rpc-statd.service 
> 
> Client:
> 1. Create mount point 
> # mkdir -p /mnt/test
> # mkdir -p /mnt/scratch
> 2. Cofigure NFS parameters.
> # echo "FSTYP=nfs
> TEST_DEV=server_IP:/nfstest
> TEST_DIR=/mnt/test
> SCRATCH_DEV=server_IP:/nfsscratch
> SCRATCH_MNT=/mnt/scratch
> export KEEP_DMESG=yes
> NFS_MOUNT_OPTIONS=\"-o vers=3\"">/var/lib/xfstests/local.config
> 3. Test
> # ./check -d generic/633

The tests should pass with "no_root_squash" set. The root cause of the
original issue was that files created by root are squashed to 65534
which breaks setgid inheritance rules for S_ISGID directories.

But without root squashing the tests should succeed. If I reproduce this
exactly with your instructions on a v6.2-rc1 kernel I get a success as
expected.

I don't think you've told me What kernel you are testing this on?

> 
> Thanks,
> cuiyue
> 
> ★☆★☆★☆★☆FNSTオンラインへようこそ★☆★☆★☆★☆
>    FNST最新情報盛りたくさん！
>    http://online.fnst.cn.fujitsu.com/fnst-news
> ★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆
> 
> > -----Original Message-----
> > From: Christian Brauner <brauner@kernel.org>
> > Sent: Friday, December 30, 2022 11:48 PM
> > To: Cui, Yue <cuiyue-fnst@fujitsu.com>
> > Cc: Christian Brauner <christian@brauner.io>; linux-nfs@vger.kernel.org
> > Subject: Re: nfs setgid inheritance test
> > 
> > On Fri, Dec 30, 2022 at 11:11:56AM +0000, cuiyue-fnst@fujitsu.com wrote:
> > > Hi, Christian
> > >
> > > When I test xfstests on NFS(with no_root_squash), generic/633 fails like this:
> > >
> > > generic/633       [failed, exit status 1]- output mismatch (see
> > /var/lib/xfstests/results//generic/633.out.bad)
> > >     --- tests/generic/633.out     2022-11-23 09:13:48.919484895 -0500
> > >     +++ /var/lib/xfstests/results//generic/633.out.bad   2022-11-24
> > 05:53:40.836484895 -0500
> > >     @@ -1,2 +1,4 @@
> > >      QA output created by 633
> > >      Silence is golden
> > >     +vfstest.c: 1642: setgid_create - Success - failure: is_setgid
> > >     +vfstest.c: 1882: run_test - Operation not supported - failure: create
> > operations in directories with setgid bit set
> > >     ...
> > >     (Run 'diff -u /var/lib/xfstests/tests/generic/633.out
> > > /var/lib/xfstests/results//generic/633.out.bad'  to see the entire
> > > diff)
> > >
> > > We have reported this problem on Feburary.
> > >
> > https://lore.kernel.org/linux-nfs/OS3PR01MB770539462BE3E7959DAF8B57893
> > > 89@OS3PR01MB7705.jpnprd01.prod.outlook.com/T/#u
> > >
> > > At that time, the conclusion is NFS should skip this test.
> > > But I cannot find this patch in the latest xfstests.
> > > Does NFS still need to skip this test now?
> > 
> > Afaict, nothing has changed and the test should still be skipped.
> > I'm not sure I ever send a patch to skip this test specifically for nfs though. I
> > might just not have gotten around to that.
> > 
> > Can you please also send the exact steps for reproducing this issue?
