Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83132A7837
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2019 03:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfIDBu6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Sep 2019 21:50:58 -0400
Received: from mx1.math.uh.edu ([129.7.128.32]:56502 "EHLO mx1.math.uh.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfIDBu6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Sep 2019 21:50:58 -0400
Received: from epithumia.math.uh.edu ([129.7.128.2])
        by mx1.math.uh.edu with esmtp (Exim 4.92)
        (envelope-from <tibbs@math.uh.edu>)
        id 1i5KRT-0006fx-6c; Tue, 03 Sep 2019 20:50:54 -0500
Received: by epithumia.math.uh.edu (Postfix, from userid 7225)
        id 21319801554; Tue,  3 Sep 2019 20:50:39 -0500 (CDT)
From:   Jason L Tibbitts III <tibbs@math.uh.edu>
To:     Wolfgang Walter <linux@stwm.de>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org, km@cm4all.com,
        linux-kernel@vger.kernel.org
Subject: Re: Regression in 5.1.20: Reading long directory fails
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
        <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
        <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
Date:   Tue, 03 Sep 2019 20:50:39 -0500
In-Reply-To: <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de> (Wolfgang
        Walter's message of "Tue, 03 Sep 2019 23:37:30 +0200")
Message-ID: <ufad0ggrfrk.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -2.9 (--)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I asked the XFS folks who mentioned that the issues with 64 bit inodes
are old, constrained to larger filesystems than what I'm using, not an
issue with nfsv4, and not present on anything but 32bit clients with old
userspace.

In any case, I have been experimenting a bit and somehow the issue seems
to be related to exporting with sec=krb5i:krb5p or sec=krb5i.  If I
export with just sec=krb5p, things magically begin to work.

So basically:

[root@ld00 ~]# ls -l ~tester|wc -l; grep tester /proc/mounts
7685
nas00:/export/misc-00/tester /home/tester nfs4 rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=krb5p,clientaddr=172.21.84.191,local_lock=none,addr=172.21.86.77 0 0

(unmount, then re-export with krb5i on the server)

[root@ld00 ~]# ls -l ~tester|wc -l; grep tester /proc/mounts
ls: reading directory '/home/tester': Input/output error
5623
nas00:/export/misc-00/tester /home/tester nfs4 rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=krb5i,clientaddr=172.21.84.191,local_lock=none,addr=172.21.86.77 0 0

(umount, then re-export with krb5i:krb5p on the server)

[root@ld00 ~]# ls -l ~tester|wc -l; grep tester /proc/mounts
ls: reading directory '/home/tester': Input/output error
5623
nas00:/export/misc-00/tester /home/tester nfs4 rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=krb5i,clientaddr=172.21.84.191,local_lock=none,addr=172.21.86.77 0 0

(umount, switch back to plain krb5p)

[root@ld00 ~]# ls -l ~tester|wc -l; grep tester /proc/mounts
7685
nas00:/export/misc-00/tester /home/tester nfs4 rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=krb5p,clientaddr=172.21.84.191,local_lock=none,addr=172.21.86.77 0 0

Sometimes the number of files it lists before it fails changes (and in
this case has been as small as a few hundred) but I don't know what
causes it to change.

Anyway, I hope this helps to pinpoint the problem.  I now have a really
easy way to reproduce this without having to kick people off of the
server, and if the successes aren't just some kind of false positives
then I guess I also have a workaround.  I'm still at a loss as to why a
revert of the readdir changes makes any difference at all here.

 - J<
