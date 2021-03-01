Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4485132760F
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 03:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhCACSW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Feb 2021 21:18:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:58424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhCACSV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 28 Feb 2021 21:18:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92D3EAC6F;
        Mon,  1 Mar 2021 02:17:39 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Mon, 01 Mar 2021 13:17:15 +1100
Subject: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <161456493684.22801.323431390819102360.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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

NeilBrown (5):
      mountd: reject unknown client IP when !use_ipaddr.
      mountd: Don't proactively add export info when fh info is requested.
      mountd: add logging for authentication results for accesses.
      mountd: add --cache-use-ipaddr option to force use_ipaddr
      mountd: make default ttl settable by option


 support/export/auth.c      |  4 +++
 support/export/cache.c     | 32 +++++++++++------
 support/export/v4root.c    |  3 +-
 support/include/exportfs.h |  3 +-
 support/nfs/exports.c      |  4 ++-
 utils/mountd/mountd.c      | 30 +++++++++++++++-
 utils/mountd/mountd.man    | 70 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 131 insertions(+), 15 deletions(-)

--
Signature

