Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B28010D07D
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Nov 2019 03:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK2CFi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Nov 2019 21:05:38 -0500
Received: from fieldses.org ([173.255.197.46]:43646 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfK2CFi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 28 Nov 2019 21:05:38 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 5FE5F1C89; Thu, 28 Nov 2019 21:05:38 -0500 (EST)
Date:   Thu, 28 Nov 2019 21:05:38 -0500
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: generic/446 failure
Message-ID: <20191129020538.GA18060@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm seeing a failure like:

generic/446 32s ... - output mismatch (see /root/xfstests-dev/results//generic/446.out.bad)
    --- tests/generic/446.out	2019-09-18 17:28:00.826721481 -0400
    +++ /root/xfstests-dev/results//generic/446.out.bad	2019-11-28 18:56:36.583719464 -0500
    @@ -1,2 +1,7 @@
     QA output created by 446
    +fallocate: Resource temporarily unavailable
    +fallocate: Resource temporarily unavailable
    +fallocate: Resource temporarily unavailable
    +fallocate: Resource temporarily unavailable
    +fallocate: Resource temporarily unavailable
     Silence is golden
    ...

A bisect pins it on:

	0e0cb35b417f NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE

Have you seen this before?

I took a quick look at a network trace to see if there were
ALLOCATE or DEALLOCATE failures, but there weren't.  The problem doesn't
reproduce when the test is run under strace.  That's all I've tried.

--b.
