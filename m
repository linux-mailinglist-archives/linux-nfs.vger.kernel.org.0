Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A504BC832
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Feb 2022 12:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiBSLei (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Feb 2022 06:34:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbiBSLeh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Feb 2022 06:34:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70E050454
        for <linux-nfs@vger.kernel.org>; Sat, 19 Feb 2022 03:34:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B462B80758
        for <linux-nfs@vger.kernel.org>; Sat, 19 Feb 2022 11:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6631C004E1;
        Sat, 19 Feb 2022 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645270457;
        bh=QHo5BZzDWJoq9QDW49R+XLww9yjbYUAE/e5wemGHijA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1BjTKNGwNLJSwYKjvcGL3A4wFpaiN1WY2H4XJZrhb65LvjNufDlnpePg9auWVNZd
         ztTJyxh+HRM+QN5H3QvUiw86MUQLixU8f3q4fSnSLUHpbZjDCl8DO0gQOhJ3fd/7st
         CsqVy9fzZJPQseqIp0ytoH13MB1zbKFXRSUrPQhVAHNYyYcwhWQU0hEJ8HbhyCx2E7
         I91UQU0S6PoTPie9S28osdL+rUBjvz2DsJHy3+wghiBMHo+k5C4a5cwGT3ZqjYlhXT
         EZz720BSn6LwgtsLOGnOiwW4vKuhvQiFUO3FrqCsNPpmTHSVt+x9EPLnmosBZgXyK8
         qeeDHalNc68vw==
Date:   Sat, 19 Feb 2022 12:34:12 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "l@damenly.su" <l@damenly.su>,
        "brauner@kernel.org" <brauner@kernel.org>
Subject: Re: [bug?] nfs setgid inheritance
Message-ID: <20220219113412.7ov4tbkisv4vnmo3@wittgenstein>
References: <OS3PR01MB770539462BE3E7959DAF8B5789389@OS3PR01MB7705.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OS3PR01MB770539462BE3E7959DAF8B5789389@OS3PR01MB7705.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Feb 19, 2022 at 08:34:30AM +0000, suy.fnst@fujitsu.com wrote:
> Hi NFS folks,
>   During our xfstests, we found generic/633 fails like:
> ============================================
> FSTYP         -- nfs
> PLATFORM      -- Linux/x86_64 btrfs 5.17.0-rc4-custom #236 SMP PREEMPT Sat Feb 19 15:09:03 CST 2022
> MKFS_OPTIONS  -- 127.0.0.1:/nfsscratch
> MOUNT_OPTIONS -- -o vers=4 127.0.0.1:/nfsscratch /mnt/scratch
> 
> generic/633 0s ... [failed, exit status 1]- output mismatch (see /root/xfstests-dev/results//generic/633.out.bad)
>     --- tests/generic/633.out   2021-05-23 14:03:08.879999997 +0800
>     +++ /root/xfstests-dev/results//generic/633.out.bad 2022-02-19 16:31:28.660000013 +0800
>     @@ -1,2 +1,4 @@
>      QA output created by 633
>      Silence is golden
>     +idmapped-mounts.c: 7906: setgid_create - Success - failure: is_setgid
>     +idmapped-mounts.c: 13907: run_test - Success - failure: create operations in directories with setgid bit set
>     ...
>     (Run 'diff -u /root/xfstests-dev/tests/generic/633.out /root/xfstests-dev/results//generic/633.out.bad'  to see the entire diff)
> Ran: generic/633
> Failures: generic/633
> Failed 1 of 1 tests
> ============================================
> 
> The failed test is about setgid inheritance. 
> When  a file is created with S_ISGID in the directory with S_ISGID, 
> NFS  doesn't strip the  setgid bit of the new created file but others
> (ext4/xfs/btrfs) do.  They call inode_init_owner() which does
> the strip after new_inode().
> However, NFS has its own logical to handle inode capacities. 
> As the test says the behavior can be filesystem type specific,
> I'd report to you NFS guys and ask whether it's a bug or not?

Thanks for the report. I'm not sure why NFS would have different rules
for setgid inheritance. So I'm inclined to think that this is simply a
bug similar to what we saw in xfs and ceph. But I'll let the NFS folks
determine that.

XFS is only special in so far as it has a sysctl that lets it alter sgid
inheritance behavior. And it only has that to allow for legacy irix
semantics iiuc.

Christian
