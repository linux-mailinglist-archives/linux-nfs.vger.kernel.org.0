Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9A470DC51
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 14:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjEWMRb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 08:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbjEWMRa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 08:17:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC791A1
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 05:17:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A59BE22A27;
        Tue, 23 May 2023 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684844241;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHyDx/YVDVlyI5mELhOX9sbEBf2QEz6wTh/McSpCJ4c=;
        b=avxfzBP+UqCVErDEwfH47BoQvmlM9FoZ9GNVmNqd4W2K6gTw0TswKURn2oxrpzutTTZOCg
        76kdQgLj9Kp/OCE/IzIOcBuWoPLXL28WlXJANN2EP9lMQYQMtPiqDHjvGYzHYsWGwWPUyH
        gPTiH8c9qm2TjMlHw8mNgfG7l7QX8b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684844241;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHyDx/YVDVlyI5mELhOX9sbEBf2QEz6wTh/McSpCJ4c=;
        b=2wYNcXsPct1+Ts/27T+yVdpZeC36JB8XQHUE9LYAv6dl57dAGcx3f2Pg96IYROqd0G9GPC
        d9LdHrAx7tBWXnAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 409C113588;
        Tue, 23 May 2023 12:17:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2CnUDNGubGRAJQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 23 May 2023 12:17:21 +0000
Date:   Tue, 23 May 2023 14:17:19 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: [PATCH 0/2] Support abstract address for rpcbind in kernel
Message-ID: <20230523121719.GA616123@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <168375610447.26246.3237443941479930060.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168375610447.26246.3237443941479930060.stgit@noble.brown>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil,

> These two patches cause the SUNRPC layer in Linux to attempt to contact
> rpcbind using an AF_UNIX socket with an abstract address before
> the existing attempts of AF_UNIX to a socket in the filesystem, and IP
> to a well known port.

> This allows the benefits of an AF_UNIX connection combined with the
> benefits of honouring the network namespace when connection rpcbind.

> For this to be useful, rpcbind must listed on that name, and user-space
> tools must also connect to the same address.  This requires changes to
> rpcbind and too libtirpc.  libtirpc currently has a bug which causes
> sockets bountd to abstract addresses to appear to be unbound, so asking
> systemd to pass rpcbind an abstract socket doesn't work - rpcbind
> rejects it.

> Patches for rpcbind and libtirpc will follow.

Thanks a lot for taking care. I finally find a time to test it.
I tested all your patchsets on openSUSE with kernel 6.3.1 (built locally),
rpcbind [2] and libtirpc [3], but although all patches LGTM, there is some
failure:

PATH="/opt/ltp/testcases/bin:$PATH" nfslock01.sh -v 3 -t tcp
nfslock01 1 TINFO: IPv6 disabled on lhost via kernel command line or not compiled in
nfslock01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
nfslock01 1 TINFO: add local addr 10.0.0.2/24
nfslock01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
nfslock01 1 TINFO: add remote addr 10.0.0.1/24
nfslock01 1 TINFO: Network config (local -- remote):
nfslock01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
nfslock01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
nfslock01 1 TINFO: fd00:1:1:1::2/64/ -- fd00:1:1:1::1/64/
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:157: TINFO: Skipping ext2 as requested by the test
tst_supported_fs_types.c:157: TINFO: Skipping ext3 as requested by the test
tst_supported_fs_types.c:90: TINFO: Kernel supports ext4
tst_supported_fs_types.c:55: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports xfs
tst_supported_fs_types.c:55: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:55: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:157: TINFO: Skipping vfat as requested by the test
tst_supported_fs_types.c:157: TINFO: Skipping exfat as requested by the test
tst_supported_fs_types.c:157: TINFO: Skipping ntfs as requested by the test
tst_supported_fs_types.c:157: TINFO: Skipping tmpfs as requested by the test
nfslock01 1 TINFO: === Testing on ext4 ===
nfslock01 1 TINFO: Formatting ext4 with opts='/dev/loop0'
nfslock01 1 TINFO: YES TST_FS_TYPE: 'ext4'
nfslock01 1 TINFO: Mounting device: mount -t ext4 /dev/loop0 /tmp/LTP_nfslock01.pLrRsUDH2Y/mntpoint -o i_version
nfslock01 1 TINFO: timeout per run is 0h 5m 0s
nfslock01 1 TINFO: mount.nfs: (linux nfs-utils 2.6.3)
nfslock01 1 TINFO: setup NFSv3, socket type tcp
nfslock01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfslock01.pLrRsUDH2Y/mntpoint/3/tcp /tmp/LTP_nfslock01.pLrRsUDH2Y/3/0
mount.nfs: trying 10.0.0.2 prog 100003 vers 3 prot TCP port 2049
mount.nfs: portmap query failed: RPC: Program not registered
mount.nfs: trying 10.0.0.2 prog 100003 vers 3 prot TCP port 2049
mount.nfs: portmap query failed: RPC: Program not registered
mount.nfs: trying 10.0.0.2 prog 100003 vers 3 prot TCP port 2049
mount.nfs: portmap query failed: RPC: Program not registered
mount.nfs: requested NFS version or transport protocol is not supported for /tmp/LTP_nfslock01.pLrRsUDH2Y/3/0
=> pvorel: ERROR above
mount.nfs: timeout set for Tue May 23 07:49:10 2023
mount.nfs: trying text-based options 'proto=tcp,vers=3,addr=10.0.0.2'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: prog 100005, trying vers=3, prot=6
mount.nfs: trying text-based options 'proto=tcp,vers=3,addr=10.0.0.2'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: prog 100005, trying vers=3, prot=6
mount.nfs: trying text-based options 'proto=tcp,vers=3,addr=10.0.0.2'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: prog 100005, trying vers=3, prot=6
nfslock01 1 TBROK: mount command failed
nfslock01 1 TINFO: Cleaning up testcase
nfslock01 1 TINFO: AppArmor enabled, this may affect test results
nfslock01 1 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
nfslock01 1 TINFO: loaded AppArmor profiles: none

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0

I retest it also on single filesystem other than ext4:
PATH="/opt/ltp/testcases/bin:$PATH" LTP_SINGLE_FS_TYPE=btrfs nfslock01.sh -v 3 -t tcp
PATH="/opt/ltp/testcases/bin:$PATH" LTP_SINGLE_FS_TYPE=xfs nfslock01.sh -v 3 -t tcp
But the result is the same: "mount command failed".

BTW even other tests fail:
PATH="/opt/ltp/testcases/bin:$PATH" LTP_SINGLE_FS_TYPE=btrfs nfs01.sh -t tcp

I also downloaded LTP to slightly older code, when only single filesystem was used
(before 9e61bb028), but obviously mount still fails.

Therefore I tested just mount on loop device with the default NFSv4, which works:
dd if=/dev/zero of=/tmp/dev bs=1M count=500
losetup /dev/loop0 /tmp/dev
mkfs.ext2 /dev/loop0
mkdir -p /export
mount /dev/loop0 /export
exportfs -o no_root_squash,async,no_subtree_check,rw localhost:/export
mkdir -p /import
mount localhost:/export /import

df | grep /import
localhost:/export nfs4      467M     0  442M   0% /import

mount | grep /import
localhost:/export on /import type nfs4 (rw,relatime,vers=4.2,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp6,timeo=600,retrans=2,sec=sys,clientaddr=::1,local_lock=none,addr=::1)

But testing NFSv3 does not work (nothing interesting in dmesg):
umount /import
mount -o proto=tcp,vers=3 localhost:/export /import

Obviously, kernel 6.2.12 with the same NFS config with unmodified libtirpc and rpcbind works:

localhost:/export on /import type nfs (rw,relatime,vers=3,rsize=262144,wsize=262144,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=127.0.0.1,mountvers=3,mountport=20048,mountproto=tcp,local_lock=none,addr=127.0.0.1)

I double checked if I backported everything correctly, thus I expect there is
some problem with the code.

Kind regards,
Petr

[1] https://build.opensuse.org/package/binaries/home:pevik:branches:network/rpcbind/openSUSE_Tumbleweed
[2] https://build.opensuse.org/package/show/home:pevik:branches:Base:System/libtirpc

> NeilBrown


> ---

> NeilBrown (2):
>       SUNRPC: support abstract unix socket addresses
>       SUNRPC: attempt to reach rpcbind with an abstract socket name


>  net/sunrpc/clnt.c      |  8 ++++++--
>  net/sunrpc/rpcb_clnt.c | 39 +++++++++++++++++++++++++++++++--------
>  net/sunrpc/xprtsock.c  |  9 +++++++--
>  3 files changed, 44 insertions(+), 12 deletions(-)
