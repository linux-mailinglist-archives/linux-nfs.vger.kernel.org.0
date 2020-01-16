Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD6413DC66
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 14:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgAPNv1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 08:51:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40006 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgAPNv1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 08:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579182686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Nbn+N57X58RnCPsb6V2BiTOHlhwM/BvJjY/VcPB+W8E=;
        b=MQBeyIMFG55/nVSbOlCM+N4KBNDgu4EyWAtf6Ao7oVBRL6IhCi+TBHJvYsneKtoBIEmsOi
        3VaaGVn/Y8OOGjdBlBQkNB9IQxzuaZl/vWQLNL1Vb9hUUJx0TZ6nanDm8q2dbQ0HD1a1dq
        2apjvWwet5fAPerNDpsC+0owTHr8D1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-m0ghOif6MuqdSMZ-KLQjDA-1; Thu, 16 Jan 2020 08:51:24 -0500
X-MC-Unique: m0ghOif6MuqdSMZ-KLQjDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4891107ACC5;
        Thu, 16 Jan 2020 13:51:23 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B0FE80A5C;
        Thu, 16 Jan 2020 13:51:23 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Lookup revalidation for OPEN_CLAIM_FH
Date:   Thu, 16 Jan 2020 08:51:22 -0500
Message-ID: <31B20BC3-A089-47F9-9821-7A3543FF7413@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I'd like to fix up lookup revalidation for v4.1+ when the client is using
OPEN_CLAIM_FH.  The fixes a while back for Stan Hu's case do not seem to
improve things for v4.1, and actually make the behavior a bit worse since we
no longer pass through nfs_lookup_verify_inode(), which would catch the
cases where nlink == 0.

Would you accept work to _always_ revalidate the dentry's parent for
CLAIM_FH?  Alternatively, it seems that CLAIM_NULL would be preferable for
this case, though I don't know how the client would know when to decide
between them.

Here's a simple reproducer for convenience, I think we've already all agreed
that the behavior we want is for the second open by `cat` to reflect the
results of the move on the server, or at least eventually later opens would
revalidate the dentry:

#!/bin/bash

set -o xtrace
vers=4.1

exportfs -ua
exportfs -o rw,sec=sys,no_root_squash *:/exports

mkdir /mnt/localhost || true

rm -f /exports/file{1,2}

echo this is file 1 > /exports/file1
echo this is file 2 > /exports/file2

mount -t nfs -ov$vers,sec=sys localhost:/exports /mnt/localhost

tail -f /mnt/localhost/file1 &
sleep 1

# this is file 1
cat /mnt/localhost/file1

# overwrite the file on the server:
mv -f /exports/file2 /exports/file1

# this is file 2
cat /mnt/localhost/file1

killall tail
# this is file 2
cat /mnt/localhost/file1
umount /mnt/localhost


Switching the $vers variable between v4.0 and v4.1 in this script shows the
difference in behavior.

Thanks for any advice,
Ben

