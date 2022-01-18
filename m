Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422D94929A1
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 16:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344512AbiARP0v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 10:26:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47904 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiARP0t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 10:26:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B83A1F3BB;
        Tue, 18 Jan 2022 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642519607;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pISiuQNXvK9RwVRhtGimkQU0Qq0IlFXZAYS9c6WH+lo=;
        b=ItRpTvT6cl/39P2xG0WErztkWwVfTpmCyJcH8HCL1HOEyv/50eACyhwXRbUWaEx/AavWyv
        i/GEy1azJQJMjwt4ow+Gcj3A5fz80NdHVxz6miV2X6qnP9huzKmZVIas9iBBuif9MjcE/n
        dx52PdW+Hzx5Be05QZxi8ghrDV1idnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642519607;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pISiuQNXvK9RwVRhtGimkQU0Qq0IlFXZAYS9c6WH+lo=;
        b=FMrd7SwJzJ2RgV5jLa4I8KuP1T+FDVAH2X8D6YWlM5T+UouOT4ScmXKyVnMffdlCCxxfwL
        9C8MJnaJYiTnKfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CFCC13B41;
        Tue, 18 Jan 2022 15:26:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id swZsCDfc5mGVYAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 18 Jan 2022 15:26:47 +0000
Date:   Tue, 18 Jan 2022 16:26:45 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Neil Brown <neilb@suse.de>, Steve Dickson <SteveD@redhat.com>,
        Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>,
        ltp@lists.linux.it
Subject: LTP nfslock01 test failing on NFS v3 (lockd: cannot monitor 10.0.0.2)
Message-ID: <YebcNQg0u5cU1QyQ@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

this is a test failure posted by Nikita Yushchenko [1]. LTP NFS test nfslock01
looks to be failing on NFS v3:

"not unsharing /var makes AF_UNIX socket for host's rpcbind to become available
inside ltpns. Then, at nfs3 mount time, kernel creates an instance of lockd for
ltpns, and ports for that instance leak to host's rpcbind and overwrite ports
for lockd already active for root namespace. This breaks nfs3 file locking."

This error has been hidden, showing only with extra patch from Nikita [2].
Because the patch has not been merged, in case you want to verify yourself,
feel free to use my LTP fork branch nfs_flock/fail-on-error to get this patch +
strace debugging [3]:

# PATH="/opt/ltp/testcases/bin:$PATH" /opt/ltp/testcases/bin/nfslock01 -t tcp -v 3
...
nfslock01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
nfslock01 1 TINFO: add local addr 10.0.0.2/24
nfslock01 1 TINFO: add local addr fd00:1:1:1::2/64
nfslock01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
nfslock01 1 TINFO: add remote addr 10.0.0.1/24
nfslock01 1 TINFO: add remote addr fd00:1:1:1::1/64
nfslock01 1 TINFO: Network config (local -- remote):
nfslock01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
nfslock01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
nfslock01 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
nfslock01 1 TINFO: timeout per run is 0h 5m 0s
nfslock01 1 TINFO: setup NFSv3, socket type tcp
nfslock01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfslock01.PAYCDFih75/3/tcp /tmp/LTP_nfslock01.PAYCDFih75/3/0
nfslock01 1 TINFO: creating test files
nfslock01 1 TINFO: Testing locking
nfslock01 1 TINFO: locking 'flock_idata' file and writing data
nfslock01 1 TINFO: waiting for pids: 2022 2023
execve("/opt/ltp/testcases/bin/nfs_flock", ["nfs_flock", "0", "flock_idata"], 0x7ffd4dae5880 /* 206 vars */execve("/opt/ltp/testcases/bin/nfs_flock", ["nfs_flock", "1", "flock_idata"], 0x7ffee8d52690 /* 206 vars */) = 0
brk(NULL)                               = 0x555ad67cc000
...
openat(AT_FDCWD, "flock_idata", O_RDWR) = 3
) = 3
fcntl(3, F_SETLKW, {l_type=F_WRLCK, l_whence=SEEK_SET, l_start=64, l_len=64}fcntl(3, F_SETLKW, {l_type=F_WRLCK, l_whence=SEEK_SET, l_start=0, l_len=64}) = -1 ENOLCK (No locks available)
newfstatat(1, "", {st_mode=S_IFCHR|0600, st_rdev=makedev(0x88, 0x1), ...}, AT_EMPTY_PATH) = 0
brk(NULL)                               = 0x55aefc2d5000
brk(0x55aefc2f6000)                     = 0x55aefc2f6000
write(1, "failed in writeb_lock, Errno = 3"..., 34failed in writeb_lock, Errno = 37
) = 34
exit_group(1)                           = ?
+++ exited with 1 +++
) = -1 ENOLCK (No locks available)
newfstatat(1, "", {st_mode=S_IFCHR|0600, st_rdev=makedev(0x88, 0x1), ...}, AT_EMPTY_PATH) = 0
brk(NULL)                               = 0x555ad67cc000
brk(0x555ad67ed000)                     = 0x555ad67ed000
write(1, "failed in writeb_lock, Errno = 3"..., 34failed in writeb_lock, Errno = 37
) = 34
exit_group(1)                           = ?
+++ exited with 1 +++
nfslock01 1 TFAIL: nfs_lock process failed
...

Dmesg shows: "lockd: cannot monitor 10.0.0.2", test fails on
fcntl(fd, F_SETLKW, &lock), lock.l_whence is SEEK_SET.

Running other NFS versions (-v 4 or -v 4.1 or -v 4.2) works ok.
Also tested only on TCP due UDP being recently disabled by default.

I found this behaviour on various kernels (openSUSE 5.16, Debian: 5.16, 5.10,
SLES 5.14 and 5.3 - both heavily patched).

Is it a bug in lockd or in a test? Is there some limitation on v3?

Kind regards,
Petr
