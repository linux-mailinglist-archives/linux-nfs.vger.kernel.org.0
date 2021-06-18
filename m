Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD413AC01F
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jun 2021 02:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhFRAfK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Jun 2021 20:35:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50192 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhFRAfK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Jun 2021 20:35:10 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 160521FD8A;
        Fri, 18 Jun 2021 00:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623976381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRCQl2S+jt9CEBtKavfWh/wYRhBdJqIg1NrFwobQu2g=;
        b=osln04UAtncq+LZWY/FhB2mcD9TXGnCFdVN47QwWoMcHfDsi4T5VYuX8EWLdTEE9kNXnKH
        OkqYpuGotwzIpi3MuoLVVJL6aJEPzlT2aEdljwMkw5ZqAg0ZST0n9rLsDDGUduz2dcZ7+N
        efgX/8yXiCWq/JLMWKfWZcdutG91MOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623976381;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRCQl2S+jt9CEBtKavfWh/wYRhBdJqIg1NrFwobQu2g=;
        b=BH8g7DvADM3cmYAUMNwsp5f1Af2MhMaRyP/CSa1WaCADx1dQVmOMHaiyj5N1929XQJ0FFl
        qxugFGI8HpKX/0BQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 092CE118DD;
        Fri, 18 Jun 2021 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623976380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRCQl2S+jt9CEBtKavfWh/wYRhBdJqIg1NrFwobQu2g=;
        b=GpLrqZIifZhUY3VbKz92avhn8emgI8Vh7VmVBVGQyb9uSWr1fzbgLHXxm1QNJfyk52HrkE
        Erzg/K2wtZncwygzIKEum8bU4qIPI+zI9CTJ8259+iAk2v4L9NZbfnWvZ7/7RGdo1KpUzo
        4hOrhSW1fQUAxMnZGmpaOUIu29mX3DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623976380;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRCQl2S+jt9CEBtKavfWh/wYRhBdJqIg1NrFwobQu2g=;
        b=tZ0ISTA78650y0lUbcoo569h07spjwXPs6gL7cYNmsA2tSFuoP+Pa3H2PyZ5CtWYGTF/p9
        AJV9ABmXXAYSLqAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id vx4zK7vpy2BmZQAALh3uQQ
        (envelope-from <neilb@suse.de>); Fri, 18 Jun 2021 00:32:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <20210617122852.BE6A.409509F4@e16-tech.com>
References: <20210615231318.F40F.409509F4@e16-tech.com>,
 <162389895501.29912.12470238090250719500@noble.neil.brown.name>
Date:   Fri, 18 Jun 2021 10:32:56 +1000
Message-id: <162397637680.29912.2268876490205517592@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 17 Jun 2021, Wang Yugui wrote:
> > Can we go back to the beginning.  What, exactly, is the problem you are
> > trying to solve?  How can you demonstrate the problem?
> >=20
> > NeilBrown
>=20
> I nfs/exported a btrfs with 2 subvols and 2 snapshot(subvol).
>=20
> # btrfs subvolume list /mnt/test
> ID 256 gen 53 top level 5 path sub1
> ID 260 gen 56 top level 5 path sub2
> ID 261 gen 57 top level 5 path .snapshot/sub1-s1
> ID 262 gen 57 top level 5 path .snapshot/sub2-s1
>=20
> and then mount.nfs4 it to /nfs/test.
>=20
> # /bin/find /nfs/test/
> /nfs/test/
> find: File system loop detected; '/nfs/test/sub1' is part of the same file =
system loop as '/nfs/test/'.
> /nfs/test/.snapshot
> find: File system loop detected; '/nfs/test/.snapshot/sub1-s1' is part of t=
he same file system loop as '/nfs/test/'.
> find: File system loop detected; '/nfs/test/.snapshot/sub2-s1' is part of t=
he same file system loop as '/nfs/test/'.
> /nfs/test/dir1
> /nfs/test/dir1/a.txt
> find: File system loop detected; '/nfs/test/sub2' is part of the same file =
system loop as '/nfs/test/'
>=20
> /bin/find report 'File system loop detected'. so I though there is
> something wrong.

Certainly something is wrong.  The error message implies that some
directory is reporting the same dev an ino as an ancestor directory.
Presumably /nfs/test and /nfs/test/sub1.
Can you confirm that please. e.g. run the command

   stat /nfs/test /nfs/test/sub1

and examine the output.

As sub1 is considered a different file system, it should have a
different dev number.  NFS will assign a different device number only
when the server reports a different fsid.  The Linux NFS server will
report a different fsid if d_mountpoint() is 'true' for the dentry, and
follow_down() results in no change the the vfsmnt,dentry in a 'struct
path'.

You have already said that d_mountpoint doesn't work for btrfs, so that
is part of the problem.  NFSD doesn't trust d_mountpoint completely as
it only reports that the dentry is a mountpoint in some namespace, not
necessarily in this namespace.  So you really need to fix
nfsd_mountpoint.

I suggest you try adding your "dirty fix" to nfsd_mountpoint() so that
it reports the root of a btrfs subvol as a mountpoint, and see if that
fixes the problem.  It should change the problem at least.  You would
need to get nfsd_mountpoint() to return '1' in this case, not '2'.

NeilBrown

