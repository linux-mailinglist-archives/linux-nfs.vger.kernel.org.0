Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D0F1C8B53
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2020 14:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgEGMuc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 May 2020 08:50:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60840 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbgEGMub (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 May 2020 08:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588855830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ZXnx6vVyAc5C4VZ392S5XX7o2FOLPGrxxNVMZm9cWWM=;
        b=jVuJxDuEvKmmbasqfZ7PrCNRArRnHSKpt4jntIc8rExTNsYj1gd2lvt3hARgZOx1B45GeD
        /jbjRZNR6aSZqXi1dCU1Ggwq0wcxdoPZ8qo1W0BaHBOSbn+mpgaMAl+K9UtT7FKR35pQ8Z
        dY0zB7nfolYh4yH2ZrsxL0jQa8fN2uQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-08brWEpeOx6iMAj0PPaydA-1; Thu, 07 May 2020 08:50:27 -0400
X-MC-Unique: 08brWEpeOx6iMAj0PPaydA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741BAEC1A0;
        Thu,  7 May 2020 12:50:26 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-13.rdu2.redhat.com [10.10.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE09E6295A;
        Thu,  7 May 2020 12:50:25 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     dhowells@redhat.com, kiran.modukuri@gmail.com,
        carmark.dlut@gmail.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/1] cachefiles: Fix race between read_waiter and read_copier
Date:   Thu,  7 May 2020 08:50:21 -0400
Message-Id: <1588855822-5532-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch was originally posted by Lei Xue in 2018:
https://lore.kernel.org/patchwork/patch/889373/

The responses on the above thread ended up fixing a separate, but related 
problem in this code path, but the last portion of the commit message
indicated the original problem was thought to have been fixed as well.
    commit 934140ab028713a61de8bca58c05332416d037d1
    Author: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
    Date: 2018-07-25 15:04:25 +0100
    
        cachefiles: Fix refcounting bug in backing-file read monitoring

However, the original problem reported by Lei still remains and is fairly
easy to reproduce.  My reproducer details are below and I could reproduce
within a few minutes.  I ended up at the same patch after tracing of the
problem and proving this race still exists, then testing with this patch
applied.  The work is detailed in the following bug:
https://bugzilla.redhat.com/show_bug.cgi?id=1829662

I am re-submitting this with Lei as author as I've only rebased the patch
on dhowells fscache-fixes branch, changed the subject line, and cleaned
up the patch header.

Reproducer
==========

# NFS server setup / config
# uname -r
3.10.0-1127.el7.x86_64
# cat /etc/exports
/data *(rw,sec=sys:krb5)
# df -h /data
Filesystem      Size  Used Avail Use% Mounted on
/dev/vdb         16G   16G  340M  98% /data
# time for i in $(seq 1 4000); do dd if=/dev/zero of=/data/file$i.bin bs=1M count=4; done &

# NFS client config and test
# uname -r
3.10.0-1062.23.1.el7.x86_64
# _or_
# From https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=fscache-fixes&id=1836833f67ab49363d221aeb120956448ca5be4f
# uname -r
5.7.0-rc3-1836833f67ab
# df /var/cache/fscache
Filesystem      Size  Used Avail Use% Mounted on
/dev/md0        7.8G   36M  7.3G   1% /var/cache/fscache
# make sure cachefilesd is running
systemctl status cachefilesd
# To run the test on the client:
# mount -overs=3,fsc nfs-server:/data /mnt/nfs
# cat dd-ioload.sh 
NFS_MNT=/mnt/nfs
echo 3 > /proc/sys/vm/drop_caches
for i in $(seq 1 2000); do
        dd if=$NFS_MNT/file$i.bin of=/dev/null bs=28k >/dev/null 2>&1 &
done
wait
# while true; do date; time ./dd-ioload.sh; done &

