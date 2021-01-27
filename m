Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0998D3055D7
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jan 2021 09:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhA0Id3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jan 2021 03:33:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231355AbhA0IbX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jan 2021 03:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611736193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Q+z8mBpoHy5JY7dVhOZYlfR55UlJfA0F6H+83P0fpbQ=;
        b=WkRTupsxo21+SSVz+0GR1IAuTo9cqTpI9p3vfKrZb4h+nR7+wTqn4IwKYAPd0r7h2qc/6o
        h520vn7rD993FQr763cvjrPhiU2JU+xutGqjhY2YlDsLAdHgFAIsKlWbPrU8qEWfMWdMBX
        qZNx59nwA88yxTSpV6sLU5ksbyObw+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-jkZDoBVTMJyxYQvl0BO9PQ-1; Wed, 27 Jan 2021 03:29:51 -0500
X-MC-Unique: jkZDoBVTMJyxYQvl0BO9PQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BE2B1005513;
        Wed, 27 Jan 2021 08:29:50 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD0055C1A3;
        Wed, 27 Jan 2021 08:29:49 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/8] Convert NFS fscache read paths to netfs API
Date:   Wed, 27 Jan 2021 03:29:47 -0500
Message-Id: <1611736187-15472-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This minimal set of patches update the NFS client to use the new
readahead method and convert the fscache read paths to use the new
netfs API, and are at:
https://github.com/DaveWysochanskiRH/kernel/releases/tag/fscache-iter-lib-nfs-20210127
https://github.com/DaveWysochanskiRH/kernel/commit/8693c3602ce02e4038fa732bef02b2641f739e02

The patches are based on David Howells fscache-netfs-lib tree at
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-netfs-lib

The first 6 patches refactor some of the NFS read code to facilitate
re-use, the next 2 patches do the conversion to the new API.  Note
that the last patch converts nfs_readpages to nfs_readahead.

Changes since dhowells posting on Jan 25, 2021
- address feedback from Willy (Chuck's feedback in TODO list)
- ensure kernel builds cleanly with each patch 
- readahead patch: cleanup handling of 'ret'

Still TODO
1. Fix known bugs (some may disappear with uncondional netfs API)
  a) One oops with fscache enabled on parallel read unit test
  b) nfs_issue_op: takes rcu_read_lock but may calls nfs_page_alloc()
  with GFP_KERNEL which may sleep (dhowells noted this in a review)
  c) nfs_refresh_inode() takes inode->i_lock but may call
  __fscache_invalidate() which may sleep (found with lockdep)
2. Fixup NFS fscache stats (NFSIOS_FSCACHE_*)
* Compare with netfs stats and determine if still needed
3. Cleanup dfprintks and/or convert to tracepoints
4. Further tests (see "Not tested yet")

Tests run
1. Custom NFS+fscache unit tests for basic operation: PASS*
* vers=3,4.0,4.1,4.2,sec=sys,server=localhost (same kernel)
* one fscache enabled parallel read test that oopses due to page lock state
  * probably goes away if we unconditionally call netfs API
2. cthon04: PASS
* test options "-b -g -s -l", fsc,vers=3,4.0,4.1,4.2,sec=sys
* No failures, oopses or hangs
3. iozone tests: PASS
* nofsc,fsc,vers=3,4.0,4.1,4.2,sec=sys,server=rhel7,rhel8
* No failures, oopses, or hangs
4. xfstests/generic: PASS*
* no hangs or oopses; a few failures unrelated to these patches
* Ran following configurations
  * vers=4.2,fsc,sec=sys,rhel7-server
  * vers=4.2,nofsc,sec=sys,rhel8-server (test still running, ok so far)
  * vers=4.1,nofsc,sec=sys,netapp-server(pnfs/files)
  * vers=4.0,fsc (test still running, ok so far)

Not tested yet:
* error injections (for example, connection disruptions, server errors during IO, etc)
* many process mixed read/write on same file
* performance

