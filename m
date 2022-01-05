Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89A485B3E
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 23:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244707AbiAEWEA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 17:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244642AbiAEWDz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Jan 2022 17:03:55 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C677CC061201
        for <linux-nfs@vger.kernel.org>; Wed,  5 Jan 2022 14:03:54 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9923A248F; Wed,  5 Jan 2022 17:03:53 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9923A248F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641420233;
        bh=6nRQ+4uX/PxDm53SfF7T/N7/KYvDAe7rZv+ylBAp6bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wrG0OEY8Vc99jkiZ6+3bzZ5DcZAwXv4KFpgsLybyN0WnNUnPicz8jehyTAoBmvyHZ
         G6jc0wy/Abhygx5HWzw67BOTZVYliQIs1KX8htCoNXniPpcGstIE3r8CRnM5tr8cn2
         1J4MxHOcSxsBndWVVLGgbIjypyo+8ndGUod6Er/I=
Date:   Wed, 5 Jan 2022 17:03:53 -0500
From:   "'bfields@fieldses.org'" <bfields@fieldses.org>
To:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
Cc:     'Trond Myklebust' <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'neilb@suse.de'" <neilb@suse.de>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: Re: client caching and locks
Message-ID: <20220105220353.GF25384@fieldses.org>
References: <20201001214749.GK1496@fieldses.org>
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>
 <20201006172607.GA32640@fieldses.org>
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>
 <20220103162041.GC21514@fieldses.org>
 <OSZPR01MB7050F9737016E8E3F0FD5255EF4A9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>
 <20220104153205.GA7815@fieldses.org>
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>
 <OSZPR01MB7050C5098D47514FFEC2DA82EF4B9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSZPR01MB7050C5098D47514FFEC2DA82EF4B9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 05, 2022 at 09:31:59AM +0000, inoguchi.yuki@fujitsu.com wrote:
> I have understood. So for cache consistency, full file locking is needed if 
> multiple clients can write the different parts of the same file concurrently. 
> 
> I think this kind of information should be documented in somewhere. 
> If it is enough to focus on the file locking, I'm assuming it to be under "DATA AND METADATA COHERENCE" 
> section in the nfs man page.

That subsection is kind of outdated.  It leads with a discussion of the
(increasingly less relevant) NLM and NSM protocols, and despite being a
subsection of the "DATA AND METADTA COHERENCE" section, never gets
around to talking about that.

It also makes it sound like "nolock" only affects NLM, which I don't
think is right.

How about this?  I also updated the lock/nolock description and deleted
the end of this subsection since it's redundant with that.  And removed
the bit about using nolock to mount /var with v2/v3 as that seems like a
bit of a niche case at this point.  If we still want to document that, I
think it belongs elsewhere.

--b.

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index 3bc18e1b30a9..7db043202fcf 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -722,10 +722,10 @@ reports the proper maximum component length to applications
 in such cases.
 .TP 1.5i
 .BR lock " / " nolock
-Selects whether to use the NLM sideband protocol to lock files on the server.
+Selects whether to lock files on the server.
 If neither option is specified (or if
 .B lock
-is specified), NLM locking is used for this mount point.
+is specified), locks are taken on the server.
 When using the
 .B nolock
 option, applications can lock files,
@@ -733,16 +733,9 @@ but such locks provide exclusion only against other applications
 running on the same client.
 Remote applications are not affected by these locks.
 .IP
-NLM locking must be disabled with the
-.B nolock
-option when using NFS to mount
-.I /var
-because
-.I /var
-contains files used by the NLM implementation on Linux.
-Using the
+The
 .B nolock
-option is also required when mounting exports on NFS servers
+option is required when using NFSv2 or NFSv3 to mount servers
 that do not support the NLM protocol.
 .TP 1.5i
 .BR cto " / " nocto
@@ -1486,47 +1479,40 @@ the use of the
 .B sync
 mount option.
 .SS "Using file locks with NFS"
-The Network Lock Manager protocol is a separate sideband protocol
-used to manage file locks in NFS version 2 and version 3.
-To support lock recovery after a client or server reboot,
-a second sideband protocol --
-known as the Network Status Manager protocol --
-is also required.
-In NFS version 4,
-file locking is supported directly in the main NFS protocol,
-and the NLM and NSM sideband protocols are not used.
+The nfs filesystem supports advisory byte-range locks acquired with
+.BR fcntl (2) .
+Locks obtained by
+.BR flock (2)
+are implemented as
+.BR fcntl (2)
+locks.
 .P
-In most cases, NLM and NSM services are started automatically,
-and no extra configuration is required.
-Configure all NFS clients with fully-qualified domain names
-to ensure that NFS servers can find clients to notify them of server reboots.
+Locking can also provide cache consistency:
 .P
-NLM supports advisory file locks only.
-To lock NFS files, use
-.BR fcntl (2)
-with the F_GETLK and F_SETLK commands.
-The NFS client converts file locks obtained via
-.BR flock (2)
-to advisory locks.
+Before acquiring a file lock, the client revalidates its cached data for
+the file.  Before releasing a write lock, the client flushes to the
+server's stable storage any data in the locked range.
 .P
-When mounting servers that do not support the NLM protocol,
-or when mounting an NFS server through a firewall
-that blocks the NLM service port,
-specify the
-.B nolock
-mount option. NLM locking must be disabled with the
-.B nolock
-option when using NFS to mount
-.I /var
-because
-.I /var
-contains files used by the NLM implementation on Linux.
+A distributed application running on multiple NFS clients can take a
+read lock for each range that it reads and a write lock for each range that
+it writes.  On its own, however, that is insufficient to ensure that
+reads get up-to-date data.
 .P
-Specifying the
-.B nolock
-option may also be advised to improve the performance
-of a proprietary application which runs on a single client
-and uses file locks extensively.
+When revalidating caches, the client is unable to reliably determine the
+difference between changes made by other clients and changes it made
+itself.  Therefore, such an application would also need to prevent
+concurrent writes from multiple clients, either by taking whole-file
+locks on every write or by some other method.
+.P
+The protocol used for file locking differs between version.  In versions
+before NFSv4, locks are implemented using the Network Lock Manager and
+Network Status Manager protocols.  In versions since NFSv4, file locking
+is supported directly in the main NFS protocol.
+.P
+In most cases, NLM and NSM services are started automatically,
+and no extra configuration is required.  NFSv2 and NFSv3 clients should
+be configured with fully-qualified domain names
+to ensure that NFS servers can find clients to notify them of server reboots.
 .SS "NFS version 4 caching features"
 The data and metadata caching behavior of NFS version 4
 clients is similar to that of earlier versions.
