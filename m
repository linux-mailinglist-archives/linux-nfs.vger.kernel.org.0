Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7284493041
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 23:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349415AbiARWAw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 17:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiARWAw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 17:00:52 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E18C061574
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jan 2022 14:00:52 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id AD1D47932; Tue, 18 Jan 2022 17:00:51 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org AD1D47932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1642543251;
        bh=WGOvI8IIj24h1+BSgxcdMP9CEenlhAccdKKTGcwDqEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPDCdIaXVEb4GjpFncvEpF46XlIHZZ2RU2K5Fvlk9WCGeC8YiSC5LTlXCg23KzNjd
         x8f3gOEOI4yjkAWzp5i0veruOj3hppZ5lAOcRWxiKi2ClJm3fFdS0rlg3YD54CZ5aP
         7ankNBOEMy+bsQ/jhG4fhySnVuswdZ9KmBbpuJGY=
Date:   Tue, 18 Jan 2022 17:00:51 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Jonathan Woithe <jwoithe@just42.net>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [PATCH 2/2] lockd: fix failure to cleanup client locks
Message-ID: <20220118220051.GC16108@fieldses.org>
References: <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
 <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220115212336.GB30050@marvin.atrad.com.au>
 <20220116220627.GA19813@marvin.atrad.com.au>
 <1E71316C-9EE8-4C71-ADA1-71E2910CA070@oracle.com>
 <20220117074430.GA22026@marvin.atrad.com.au>
 <20220117220851.GA8494@marvin.atrad.com.au>
 <20220117221156.GB3090@fieldses.org>
 <20220118220016.GB16108@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118220016.GB16108@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

In my testing, we're sometimes hitting the request->fl_flags & FL_EXISTS
case in posix_lock_inode, presumably just by random luck since we're not
actually initializing fl_flags here.

This probably didn't matter before 7f024fcd5c97 "Keep read and write fds
with each nlm_file" since we wouldn't previously unlock unless we knew
there were locks.

But now it causes lockd to give up on removing more locks.

We could just initialize fl_flags, but really it seems dubious to be
calling vfs_lock_file with random values in some of the fields.

Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/lockd/svcsubs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 54c2e42130ca..0a22a2faf552 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -180,6 +180,7 @@ static int nlm_unlock_files(struct nlm_file *file)
 {
 	struct file_lock lock;
 
+	locks_init_lock(&lock);
 	lock.fl_type  = F_UNLCK;
 	lock.fl_start = 0;
 	lock.fl_end   = OFFSET_MAX;
-- 
2.34.1

