Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7372AEDB2
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2019 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbfIJOuF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Sep 2019 10:50:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbfIJOuF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Sep 2019 10:50:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76F9618CCF02
        for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2019 14:50:04 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5668F5D9DC;
        Tue, 10 Sep 2019 14:50:04 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 004D720B53; Tue, 10 Sep 2019 10:50:03 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [nfs-utils PATCH v3 4/4] nfsdcld: update nfsdcld.man
Date:   Tue, 10 Sep 2019 10:50:03 -0400
Message-Id: <20190910145003.4165-5-smayhew@redhat.com>
In-Reply-To: <20190910145003.4165-1-smayhew@redhat.com>
References: <20190910145003.4165-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Tue, 10 Sep 2019 14:50:04 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Added some historical information to the notes section, along with
some information regarding upgrading and downgrading nfsdcld.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 utils/nfsdcld/nfsdcld.man | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/utils/nfsdcld/nfsdcld.man b/utils/nfsdcld/nfsdcld.man
index c271d14..4c2b1e8 100644
--- a/utils/nfsdcld/nfsdcld.man
+++ b/utils/nfsdcld/nfsdcld.man
@@ -185,15 +185,37 @@ on stable storage by manipulating information on the filesystem
 directly, in the directory to which \fI/proc/fs/nfsd/nfsv4recoverydir\fR
 points.
 .PP
-This daemon requires a kernel that supports the nfsdcld upcall. If the
-kernel does not support the new upcall, or is using the legacy client
-name tracking code then it will not create the pipe that nfsdcld uses to
-talk to the kernel.
+This changed with the original introduction of \fBnfsdcld\fR upcall in kernel version 3.4,
+which was later deprecated in favor of the \fBnfsdcltrack\fR(8) usermodehelper
+program, support for which was added in kernel version 3.8.  However, since the
+usermodehelper upcall does not work in containers, support for a new version of
+the \fBnfsdcld\fR upcall was added in kernel version 5.2.
+.PP
+This daemon requires a kernel that supports the \fBnfsdcld\fR upcall. On older kernels, if
+the legacy client name tracking code was in use, then the kernel would not create the
+pipe that \fBnfsdcld\fR uses to talk to the kernel.  On newer kernels, nfsd attempts to
+initialize client tracking in the following order:  First, the \fBnfsdcld\fR upcall.  Second,
+the \fBnfsdcltrack\fR usermodehelper upcall.  Finally, the legacy client tracking.
 .PP
 This daemon should be run as root, as the pipe that it uses to communicate
 with the kernel is only accessable by root. The daemon however does drop all
 superuser capabilities after starting. Because of this, the \fIstoragedir\fR
 should be owned by root, and be readable and writable by owner.
+.PP
+The daemon now supports different upcall versions to allow the kernel to pass additional
+data to be stored in the on-disk database.  The kernel will query the supported upcall
+version from \fBnfsdcld\fR during client tracking initialization.  A restart of \fBnfsd\fR is
+not necessary after upgrading \fBnfsdcld\fR, however \fBnfsd\fR will not use a later upcall
+version until restart.  A restart of \fBnfsd is necessary\fR after downgrading \fBnfsdcld\fR,
+to ensure that \fBnfsd\fR does not use an upcall version that \fBnfsdcld\fR does not support.
+Additionally, a downgrade of \fBnfsdcld\fR requires the schema of the on-disk database to
+be downgraded as well.  That can be accomplished using the \fBclddb-tool\fR(8) utility.
+.SH FILES
+.TP
+.B /var/lib/nfs/nfsdcld/main.sqlite
+.SH SEE ALSO
+.BR nfsdcltrack "(8), " clddb-tool (8)
 .SH "AUTHORS"
 .IX Header "AUTHORS"
-The nfsdcld daemon was developed by Jeff Layton <jlayton@redhat.com>.
+The nfsdcld daemon was developed by Jeff Layton <jlayton@redhat.com>
+with modifications from Scott Mayhew <smayhew@redhat.com>.
-- 
2.17.2

