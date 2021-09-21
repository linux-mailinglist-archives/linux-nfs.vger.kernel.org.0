Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A5B413565
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Sep 2021 16:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhIUOea (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Sep 2021 10:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhIUOea (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Sep 2021 10:34:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C0C061574
        for <linux-nfs@vger.kernel.org>; Tue, 21 Sep 2021 07:33:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 728211512; Tue, 21 Sep 2021 10:32:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 728211512
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632234779;
        bh=GWGVSENLrMQ4sSL6QoXqiZ9vygYwt/3pMPujuZsJLX4=;
        h=Date:To:Subject:From:From;
        b=gSjegIXnzrbMWKQxcOyI0JEOPtZ2kcnCPlqOP9P3Qbis7Dcw/LJ9XLAOVqoJBuH3Z
         483zY4P+0Xcn1qeygGG/+ivPgxdQhFPOk7tBysY8dM8FvmG1ePzQmI9xK/l+r0fV/T
         7qFSDroBfZ0pbXbQ9rer7Qe7VHaKd+eSRys01HtY=
Date:   Tue, 21 Sep 2021 10:32:59 -0400
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: reexport documentation
Message-ID: <20210921143259.GB21704@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

We've supported reexport for a while but documentation is limited.  This
is mainly a simplified version of the text I wrote for the linux-nfs
wiki at https://wiki.linux-nfs.org/wiki/index.php/NFS_re-export.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 Documentation/filesystems/nfs/index.rst    |   1 +
 Documentation/filesystems/nfs/reexport.rst | 110 +++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/filesystems/nfs/reexport.rst

diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/filesystems/nfs/index.rst
index 65805624e39b..288d8ddb2bc6 100644
--- a/Documentation/filesystems/nfs/index.rst
+++ b/Documentation/filesystems/nfs/index.rst
@@ -11,3 +11,4 @@ NFS
    rpc-server-gss
    nfs41-server
    knfsd-stats
+   reexport
diff --git a/Documentation/filesystems/nfs/reexport.rst b/Documentation/filesystems/nfs/reexport.rst
new file mode 100644
index 000000000000..892cb1e9c45c
--- /dev/null
+++ b/Documentation/filesystems/nfs/reexport.rst
@@ -0,0 +1,110 @@
+Reexporting NFS filesystems
+===========================
+
+Overview
+--------
+
+It is possible to reexport an NFS filesystem over NFS.  However, this
+feature comes with a number of limitations.  Before trying it, we
+recommend some careful research to determine wether it will work for
+your purposes.
+
+A discussion of current known limitations follows.
+
+"fsid=" required, crossmnt broken
+---------------------------------
+
+We require the "fsid=" export option on any reexport of an NFS
+filesystem.
+
+The "crossmnt" export option does not work in the reexport case.
+
+Reboot recovery
+---------------
+
+The NFS protocol's normal reboot recovery mechanisms don't work for the
+case when the reexport server reboots.  Clients will lose any locks
+they held before the reboot, and further IO will result in errors.
+Closing and reopening files should clear the errors.
+
+Filehandle limits
+-----------------
+
+If the original server uses an X byte filehandle for a given object, the
+reexport server's filehandle for the reexported object will be X+22
+bytes, rounded up to the nearest multiple of four bytes.
+
+The result must fit into the RFC-mandated filehandle size limits:
+
++-------+-----------+
+| NFSv2 |  32 bytes |
++-------+-----------+
+| NFSv3 |  64 bytes |
++-------+-----------+
+| NFSv4 | 128 bytes |
++-------+-----------+
+
+So, for example, you will only be able to reexport a filesystem over
+NFSv2 if the original server gives you filehandles that fit in 10
+bytes--which is unlikely.
+
+In general there's no way to know the maximum filehandle size given out
+by an NFS server without asking the server vendor.
+
+But the following table gives a few examples.  The first column is the
+typical length of the filehandle from a Linux server exporting the given
+filesystem, the second is the length after that nfs export is reexported
+by another Linux host:
+
++--------+-------------------+----------------+
+|        | filehandle length | after reexport |
++========+===================+================+
+| ext4:  | 28 bytes          | 52 bytes       |
++--------+-------------------+----------------+
+| xfs:   | 32 bytes          | 56 bytes       |
++--------+-------------------+----------------+
+| btrfs: | 40 bytes          | 64 bytes       |
++--------+-------------------+----------------+
+
+All will therefore fit in an NFSv3 or NFSv4 filehandle after reexport,
+but none are reexportable over NFSv2.
+
+Linux server filehandles are a bit more complicated than this, though;
+for example:
+
+        - The (non-default) "subtreecheck" export option generally
+          requires another 4 to 8 bytes in the filehandle.
+        - If you export a subdirectory of a filesystem (instead of
+          exporting the filesystem root), that also usually adds 4 to 8
+          bytes.
+        - If you export over NFSv2, knfsd usually uses a shorter
+          filesystem identifier that saves 8 bytes.
+        - The root directory of an export uses a filehandle that is
+          shorter.
+
+As you can see, the 128-byte NFSv4 filehandle is large enough that
+you're unlikely to have trouble using NFSv4 to reexport any filesystem
+exported from a Linux server.  In general, if the original server is
+something that also supports NFSv3, you're *probably* OK.  Re-exporting
+over NFSv3 may be dicier, and reexporting over NFSv2 will probably
+never work.
+
+For more details of Linux filehandle structure, the best reference is
+the source code and comments; see in particular:
+
+        - include/linux/exportfs.h:enum fid_type
+        - include/uapi/linux/nfsd/nfsfh.h:struct nfs_fhbase_new
+        - fs/nfsd/nfsfh.c:set_version_and_fsid_type
+        - fs/nfs/export.c:nfs_encode_fh
+
+Open DENY bits ignored
+----------------------
+
+NFS since NFSv4 supports ALLOW and DENY bits taken from Windows, which
+allow you, for example, to open a file in a mode which forbids other
+read opens or write opens. The Linux client doesn't use them, and the
+server's support has always been incomplete: they are enforced only
+against other NFS users, not against processes accessing the exported
+filesystem locally. A reexport server will also not pass them along to
+the original server, so they will not be enforced between clients of
+different reexport servers.
-- 
2.31.1

