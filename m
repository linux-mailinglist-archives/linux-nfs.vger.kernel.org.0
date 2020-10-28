Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBC229E0D4
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 02:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgJ1WDB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Oct 2020 18:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728160AbgJ1WBX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Oct 2020 18:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603922482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=g7FLQO3CrpnwcCqIvFHtJHSQlfglx6THwuxYGSZJU7w=;
        b=CroS7KNhlUzXqFE10HFqLcjjodqE+bgTO6lWsB75AGiZziUdA5tD84cg2C0vV8/3FXKBPg
        91LgRp3jJ7dEOwDrFGN1y3O8O1DkYWrQ8jAjol2p43PR87HetraK0YNXN+Mu18QKeoDOS7
        YENLx4m1n2ipFQhU8tT6+0alwTMkRSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-wBvUO6TbPdqkcVs2kwXzKg-1; Wed, 28 Oct 2020 08:59:19 -0400
X-MC-Unique: wBvUO6TbPdqkcVs2kwXzKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F013835BA7
        for <linux-nfs@vger.kernel.org>; Wed, 28 Oct 2020 12:59:18 +0000 (UTC)
Received: from fedora.rsable.com (unknown [10.74.9.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8138F19C4F;
        Wed, 28 Oct 2020 12:59:16 +0000 (UTC)
Date:   Wed, 28 Oct 2020 18:29:11 +0530
From:   Rohan Sable <rsable@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, rsable@redhat.com
Subject: [PATCH v1] mountstats: handle KeyError in display_raw_stats
Message-ID: <20201028125911.GA140323@fedora.rsable.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

While printing Nfsv4ops from older /proc/self/mountstats
e.g. in 2.6.32-754.el6.x86_64 from RHEL 6.10,
it will not have all the Keys present leading to a KeyError
like below :

Traceback (most recent call last):
  File "nfs-utils/tools/mountstats/mountstats.py", line 1131, in <module>
    res = main()
  File "nfs-utils/tools/mountstats/mountstats.py", line 1120, in main
    return args.func(args)
  File "nfs-utils/tools/mountstats/mountstats.py", line 860, in mountstats_command
    print_mountstats(stats, args.nfs_only, args.rpc_only, args.raw, args.xprt_only)
  File "nfs-utils/tools/mountstats/mountstats.py", line 813, in print_mountstats
    stats.display_raw_stats()
  File "nfs-utils/tools/mountstats/mountstats.py", line 381, in display_raw_stats
    print('\t%12s: %s' % (op, " ".join(str(x) for x in self.__rpc_data[op])))
KeyError: 'FSID_PRESENT'

Signed-off-by: Rohan Sable <rsable@redhat.com>
---
 tools/mountstats/mountstats.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 25e92a19..23876fc4 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -378,7 +378,10 @@ class DeviceData:
                 print('\t%12s: %s' % (op, " ".join(str(x) for x in self.__rpc_data[op])))
         elif vers == '4':
             for op in Nfsv4ops:
-                print('\t%12s: %s' % (op, " ".join(str(x) for x in self.__rpc_data[op])))
+                try:
+                    print('\t%12s: %s' % (op, " ".join(str(x) for x in self.__rpc_data[op])))
+                except KeyError:
+                    continue
         else:
             print('\tnot implemented for version %d' % vers)
         print()
-- 
2.26.2

