Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E314C0E6F
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 09:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbiBWIpA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 03:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiBWIo6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 03:44:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4B4657BB
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 00:44:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0856160D
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 08:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D8AC340E7;
        Wed, 23 Feb 2022 08:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645605870;
        bh=YySbdJMxXTPFAzyxczeOXMlnDonHBYfTq78zdLO1OtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7oU/vJGueQKqyvIuabG7VBLHvcO+uNwpS4sAnuU9oCx/4BhKDZFqQweV4pM4pddX
         s8l8etwfFteb7yIQ15pk17fZINvsfwjQda63GHpbQok9D+XcLPsVz1trojtYLIfkC0
         8lnOfHDNzZqnWsd7rAuz6RSoK31lobyT6faZuq2PYw06j1kAH4eQhae4VbQbmpipPX
         Sl+iFz0dcVa4EHGhByuV9st2EZ3aLrD469YEBb/w1czwAL842xj1Q5RJ1J/zF3h88Z
         JCk2rBR1LsoweZ4nnxAssJ8ISGbmqa5R6uHPGtMlaStBhl7beDEHL/TW4hlZFLLDmp
         m1aIma15c+cbQ==
Date:   Wed, 23 Feb 2022 09:44:25 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "suy.fnst@fujitsu.com" <suy.fnst@fujitsu.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "l@damenly.su" <l@damenly.su>
Subject: Re: [bug?] nfs setgid inheritance
Message-ID: <20220223084425.uq75dqfwymgfayus@wittgenstein>
References: <OS3PR01MB770539462BE3E7959DAF8B5789389@OS3PR01MB7705.jpnprd01.prod.outlook.com>
 <20220219113412.7ov4tbkisv4vnmo3@wittgenstein>
 <55aef6aa0e1825c1709051091c7bf849fccbda32.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55aef6aa0e1825c1709051091c7bf849fccbda32.camel@hammerspace.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Feb 19, 2022 at 05:00:18PM +0000, Trond Myklebust wrote:
> On Sat, 2022-02-19 at 12:34 +0100, Christian Brauner wrote:
> > On Sat, Feb 19, 2022 at 08:34:30AM +0000, suy.fnst@fujitsu.com wrote:
> > > Hi NFS folks,
> > >   During our xfstests, we found generic/633 fails like:
> > > ============================================
> > > FSTYP         -- nfs
> > > PLATFORM      -- Linux/x86_64 btrfs 5.17.0-rc4-custom #236 SMP
> > > PREEMPT Sat Feb 19 15:09:03 CST 2022
> > > MKFS_OPTIONS  -- 127.0.0.1:/nfsscratch
> > > MOUNT_OPTIONS -- -o vers=4 127.0.0.1:/nfsscratch /mnt/scratch
> > > 
> > > generic/633 0s ... [failed, exit status 1]- output mismatch (see
> > > /root/xfstests-dev/results//generic/633.out.bad)
> > >     --- tests/generic/633.out   2021-05-23 14:03:08.879999997 +0800
> > >     +++ /root/xfstests-dev/results//generic/633.out.bad 2022-02-19
> > > 16:31:28.660000013 +0800
> > >     @@ -1,2 +1,4 @@
> > >      QA output created by 633
> > >      Silence is golden
> > >     +idmapped-mounts.c: 7906: setgid_create - Success - failure:
> > > is_setgid
> > >     +idmapped-mounts.c: 13907: run_test - Success - failure: create
> > > operations in directories with setgid bit set
> > >     ...
> > >     (Run 'diff -u /root/xfstests-dev/tests/generic/633.out
> > > /root/xfstests-dev/results//generic/633.out.bad'  to see the entire
> > > diff)
> > > Ran: generic/633
> > > Failures: generic/633
> > > Failed 1 of 1 tests
> > > ============================================
> > > 
> > > The failed test is about setgid inheritance. 
> > > When  a file is created with S_ISGID in the directory with S_ISGID,
> > > NFS  doesn't strip the  setgid bit of the new created file but
> > > others
> > > (ext4/xfs/btrfs) do.  They call inode_init_owner() which does
> > > the strip after new_inode().
> > > However, NFS has its own logical to handle inode capacities. 
> > > As the test says the behavior can be filesystem type specific,
> > > I'd report to you NFS guys and ask whether it's a bug or not?
> > 
> > Thanks for the report. I'm not sure why NFS would have different
> > rules
> > for setgid inheritance. So I'm inclined to think that this is simply
> > a
> > bug similar to what we saw in xfs and ceph. But I'll let the NFS
> > folks
> > determine that.
> > 
> > XFS is only special in so far as it has a sysctl that lets it alter
> > sgid
> > inheritance behavior. And it only has that to allow for legacy irix
> > semantics iiuc.
> 
> OK, so how do you expect this 'idmapped-mounts' functionality to work
> on NFS? I'm not asking about this bug in particular. I'm asking about
> what this is supposed to do in general.

Just to clarify, the bug has nothing to do with idmapped mounts. The
idmapped mount testsuite always had a vfs generic part. That vfs generic
part has been made available to all filesystems supporting xfstests a
few weeks ago. (So far this setgid inheritance bug here has been present
in 3 filesystems.)

> 
> At a quick glance, it looks to me as if these idmapped mount helpers
> are just hacking different values into the inode cache representation
> of files, and then somehow expecting that to result in different

(Just to clarify, the inode cache is never changed by an idmapped mount
unless a new filesystem object is created/permantently changed. The
inode cache is left alone otherwise and ownership is only transiently
mapped when checking permissions.)

> behaviour.
> That's not going to work with NFS, for two reasons:
>    1. Security is enforced by the server and not the client. If you
>       want these values you're poking into the inode cache to change
>       the behaviour of the server, then they have to be propagated by
>       the client to that server. 
>    2. The NFS security model is authentication based. In particular,
>       when strong authentication is being used, then my identity is
>       established by user+password that I've logged in as to the
>       kerberos server (or whatever). So while the idmapped mount stuff
>       may be poking values into my credential or the inode cache, the
>       server is going to ignore all that and tell me that any file I
>       create is owned by user trond@domain. It will not allow me to
>       change file ownership or to override access permissions unless
>       trond@domain happens to be a privileged user such as root.
> 
> I'm pretty sure the cifs/smb client will have the same problem.

I did a POC for ceph a while back and I did also have POC patches for
cifs/smb. For ceph e.g. the {g,u}id with which a file is to be created
with or will have its ownership changed to is sent from the client to
the server with server being responsible for deciding whether that
creation is allowed or not.
NFS already has a notion of idmapping via upcalls afair. Whether or not
support for idmapped mounts make sense for NFS depends on how the
current idmapping feature is implemented and what use-cases aren't
supported by it that idmapped mounts can.
