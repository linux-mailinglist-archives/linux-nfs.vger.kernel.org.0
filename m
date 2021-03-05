Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED832DE6A
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 01:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhCEAob (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 19:44:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:39092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhCEAob (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 4 Mar 2021 19:44:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7154AD72;
        Fri,  5 Mar 2021 00:44:29 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Fri, 05 Mar 2021 11:43:23 +1100
Subject: [PATCH 0/7 v2] nfs-utils: provide audit-logging of NFSv4 access
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <161490464823.15291.13358214486203434566.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This version improves the man-pages, usage messages, etc and
adds a new feature: logging client attach/detach based on
/proc/fs/nfsd/clients/
That feature is in patch 7 and should be considered RFC at this point.
i.e. patches 1-6 are ready to apply, patch 7 isn't.

A problem with patch7 is double-reporting due to the extra transient
entries in the clients directory.  I'm wondering if we could add a
"Confirmed: Y" line for confirmed clients, so that the code could
ignore any clients which are not confirmed.
Maybe those clients should just not appear, but I'd like something
that will not produce noise on old kernels, and I'm happy if it
doesn't produce any log messages without a backport of a small
kernel patch.

Comments?

V2 series comment:

V1 of this series didn't update the usage() message for mountd,
and omited the required ':' after the 'T' sort-option.  This
series fixes those two omissions.

Original series comment:

When NFSv3 is used mountd provides logs of successful and failed mount
attempts which can be used for auditing.
When NFSv4 is used there are no such logs as NFSv4 does not have a
distinct "mount" request.

However mountd still knows about which filesysytems are being accessed
from which clients, and can actually provide more reliable logs than it
currently does, though they must be more verbose - with periodic "is
being accessed" message replacing a single "was mounted" message.

This series adds support for that logging, and adds some related
improvements to make the logs as useful as possible.

NeilBrown

---

NeilBrown (7):
      mountd: reject unknown client IP when !use_ipaddr.
      mountd: Don't proactively add export info when fh info is requested.
      mountd/exports: update man page
      mountd: add logging for authentication results for accesses.
      mountd: add --cache-use-ipaddr option to force use_ipaddr
      mountd: make default ttl settable by option
      mountd: add logging of NFSv4 clients attaching and detaching.


 nfs.conf                   |   4 +
 support/export/Makefile.am |   3 +-
 support/export/auth.c      |   4 +
 support/export/cache.c     |  41 +++++----
 support/export/export.h    |   9 +-
 support/export/v4clients.c | 177 +++++++++++++++++++++++++++++++++++++
 support/export/v4root.c    |   3 +-
 support/include/exportfs.h |   3 +-
 support/nfs/exports.c      |   4 +-
 systemd/nfs.conf.man       |  20 +++++
 utils/exportd/exportd.c    |  42 +++++++--
 utils/exportd/exportd.man  |  94 ++++++++++++++------
 utils/mountd/mountd.c      |  32 ++++++-
 utils/mountd/mountd.h      |   5 --
 utils/mountd/mountd.man    |  98 ++++++++++++++++----
 utils/mountd/svc_run.c     |   5 +-
 16 files changed, 464 insertions(+), 80 deletions(-)
 create mode 100644 support/export/v4clients.c

--
Signature

