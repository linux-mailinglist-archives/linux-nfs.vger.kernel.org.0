Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC246F5B3
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Dec 2021 22:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhLIVPk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Dec 2021 16:15:40 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:35416 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhLIVPk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Dec 2021 16:15:40 -0500
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 16:15:40 EST
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B845562EB58A;
        Thu,  9 Dec 2021 22:05:49 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MFhJh1SoPAm1; Thu,  9 Dec 2021 22:05:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2876262EB595;
        Thu,  9 Dec 2021 22:05:49 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mve3MJ0sVjve; Thu,  9 Dec 2021 22:05:49 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E8A7162EB58A;
        Thu,  9 Dec 2021 22:05:48 +0100 (CET)
Date:   Thu, 9 Dec 2021 22:05:48 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     luis.turcitu@appsbroker.com, chris.chilvers@appsbroker.com,
        david.young@appsbroker.com, david <david@sigma-star.at>,
        bfields@fieldses.org,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>
Message-ID: <1576494286.153679.1639083948872.JavaMail.zimbra@nod.at>
Subject: Improving NFS re-export
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF94 (Linux)/8.8.12_GA_3809)
Thread-Index: DIlIQMBpkOIKFedlU9SceqK8F8UnKA==
Thread-Topic: Improving NFS re-export
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello NFS list,

I'd like to improve the NFS re-export feature, especially wrt. crossmounts.
Currently a NFS client will face EIO when crossing a mount point on the re-exporting server.
This was discussed here[0]. While in that discussion the assumption was that check_export()
in fs/nfsd/export.c emits EIO I did further experiments and realized that EIO actually
comes from the NFS client side of the re-exporting server.

nfs_encode_fh() in fs/nfs/export.c checks for IS_AUTOMOUNT(inode), if this is the case
it refuses to create a new file handle.
So while accessing /files/disk2 directly on the re-exporting server triggers an automount,
accessing via nfsd the export function of the client side gives up.

AFAIU the suggested proxy-only-mode[1] will not address this problem, right?

One workaround is manually adding an export for each volume on the re-exporting server.
This kinda works but is tedious and error prone.

I have a crazy idea how to automate this:
Since nfs_encode_fh() in the NFS client side of the re-exporting server can detect
crossing mounts, we could install a new export on the sever side as soon the
IS_AUTOMOUNT(inode) case arises. We could even use the same fsid.
What do you think?

Another obstacle is file handle wrapping.
When re-exporting, the NFS client side adds inode and file information to each file handle,
the server side also adds information. In my test setup this enlarges a 16 bytes file handle
to 40 bytes.
The proxy-only-mode won't help us either here.

Did you consider using the opaque file handle from the server as lookup key in a
(persisted) data structure?
That way at least the client side of the re-exporting server no longer has to enlarge
the file handle with inode and file type information.
If the re-exporting server re-exports just one server (proxy-only-mode) we could also
skip adding the fsid to the handle.
What do you think?

I'm looking forward to hear your comments.

Thanks,
//richard

[0] https://marc.info/?l=linux-nfs&m=161670807413876&w=2
[1] https://linux-nfs.org/wiki/index.php/NFS_proxy-only_mode
