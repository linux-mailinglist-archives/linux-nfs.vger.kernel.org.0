Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8DB54DAFD
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jun 2022 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbiFPGva (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jun 2022 02:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbiFPGv3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jun 2022 02:51:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA45E5BD06
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 23:51:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7BBE621C85;
        Thu, 16 Jun 2022 06:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655362286;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaB8uap2BzLYqn7FttBfPkR0KtlLual8TfZL74kVsxY=;
        b=mbfIGiZmBjOaRji5drqCIm4yz5q1B+CezUozxXnsxLXAhNh/8BaBkWVZ62im+pi7L5miLM
        DGa/NkS3i9c49uOTF1+vgE8gpeiaM10dJ0/E/0IGo0fvuE6zqCcV4YRRlLApdHciOuvEMB
        hRDeE0JM0TUHMKDM8Ry+ekFHqrZ3ec8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655362286;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaB8uap2BzLYqn7FttBfPkR0KtlLual8TfZL74kVsxY=;
        b=63zfYp3BbP+dRp/W+pOJk/rZ70RwsYe6y4YgNtQL5XCuJ4G/g0hNxGdYFJQDf2mPhCJQdn
        Wgk/UuWGxEJs+0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5505A1344E;
        Thu, 16 Jun 2022 06:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7QX7Eu7SqmJAXQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 16 Jun 2022 06:51:26 +0000
Date:   Thu, 16 Jun 2022 08:51:24 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Li Wang <liwang@redhat.com>
Cc:     LTP List <ltp@lists.linux.it>, linux-nfs@vger.kernel.org
Subject: Re: [LTP] [RFC][PATCH v2 9/9] nfs: Use TST_ALL_FILESYSTEMS=1
Message-ID: <YqrS7K3l3b3Vp+ys@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-10-pvorel@suse.cz>
 <CAEemH2dViRNFsreFRyyTtPECdVEyaAEE0CuYBmZrwor=rgi=mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEemH2dViRNFsreFRyyTtPECdVEyaAEE0CuYBmZrwor=rgi=mQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On Fri, Jun 10, 2022 at 5:44 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi NFS developers,

> > your comments are welcome. This is an effort how to support NFS tests on
> > all filesystems available on SUT. Using $TST_MNTPOINT means test run in
> > loop, each time different filesystem is used. It's implemented via
> > formatted loop device (the same way as in LTP C API).

> > Code is also at:
> > https://github.com/pevik/ltp/tree/shell/all_filesystems.v2

> > But this requires restarting NFS server (otherwise legacy
> > testcases/lib/daemonlib.sh
> > would have to be used), which is IMHO not optimal.

> > Without that (or only run 'systemctl reload nfs-server' or exportfs -r
> > on remote side) it cannot be umounted after testing - debugging with
> > fuser, code at:

> > https://github.com/pevik/ltp/commit/3656d035d43445a107154ef397ef1db2fad2c4f0

> > The problem is that loop device is still referenced by nfs server and
> > thus cannot be unmounted. Can this be somehow fixed? Is it even wanted
> > to have tests on loop device (the only reasonable way to support more
> > filesystems)? Also tests will run much longer (we could filter out some
> > filesystems not supported, if there are any).

> > # LTP_SINGLE_FS_TYPE=ext2 PATH="/opt/ltp/testcases/bin:$PATH" nfs07.sh -v
> > 3 -t tcp -i3
> > ## NOTE: testing itself is OK
> > nfs07 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> > nfs07 1 TINFO: add local addr 10.0.0.2/24
> > nfs07 1 TINFO: add local addr fd00:1:1:1::2/64
> > nfs07 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> > nfs07 1 TINFO: add remote addr 10.0.0.1/24
> > nfs07 1 TINFO: add remote addr fd00:1:1:1::1/64
> > nfs07 1 TINFO: Network config (local -- remote):
> > nfs07 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> > nfs07 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> > nfs07 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> > tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
> > tst_supported_fs_types.c:148: TINFO: WARNING: testing only ext2
> > tst_supported_fs_types.c:89: TINFO: Kernel supports ext2
> > tst_supported_fs_types.c:51: TINFO: mkfs.ext2 does exist
> > nfs07 1 TINFO: Testing on ext2
> > nfs07 1 TINFO: Formatting ext2 with opts='/dev/loop0'
> > nfs07 1 TINFO: timeout per run is 0h 5m 0s
> > nfs07 1 TINFO: mount.nfs: (linux nfs-utils 2.6.1)
> > nfs07 1 TINFO: setup NFSv3, socket type tcp
> > nfs07 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfs07.A3PIB82iUv/mntpoint/3/tcp
> > /tmp/LTP_nfs07.A3PIB82iUv/mntpoint/3/0
> > nfs07 1 TPASS: All files and directories were correctly listed
> > nfs07 2 TPASS: All files and directories were correctly listed
> > nfs07 3 TPASS: All files and directories were correctly listed
> > nfs07 4 TINFO: Cleaning up testcase

> > ## DEBUGGING CODE in nfs_cleanup()
> > nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w ($TST_TMPDIR)
> >                      USER        PID ACCESS COMMAND
> > /tmp/LTP_nfs07.P1XS9smc5w:
> >                      root     kernel mount /tmp
> >                      root       2125 ..c.. tst_timeout_kil
> > nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w/mntpoint ($TST_MNTPOINT)
> >                      USER        PID ACCESS COMMAND
> > /tmp/LTP_nfs07.P1XS9smc5w/mntpoint:
> >                      root     kernel mount
> > /tmp/LTP_nfs07.P1XS9smc5w/mntpoint
> > nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0
> >                      USER        PID ACCESS COMMAND
> > /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0:
> >                      root     kernel mount
> > /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0

> > ## from nfs_cleanup()
> > ## grep -q "$local_dir" /proc/mounts && umount $local_dir
> > nfs07 4 TINFO: umount /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0
> > umount: /tmp/LTP_nfs07.P1XS9smc5w/mntpoint: target is busy.


> Maybe try with `umount -fl`?

Thank you! Unfortunately it does not work (I tried this before ending up with
restarting server because even -fl did not help).

I also consider the need of 'umount -fl' as kind of error just less aggressive
then restarting server. But if this is considered ok, why not.

Kind regards,
Petr

> unmount manual says:
>    -f, --force    force unmount (in case of an unreachable NFS system)
>    -l, --lazy      detach the filesystem now, clean up things later
