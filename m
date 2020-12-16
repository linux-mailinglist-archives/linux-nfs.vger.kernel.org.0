Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A552DBA2C
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 05:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgLPEoM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Dec 2020 23:44:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:58324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgLPEoM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Dec 2020 23:44:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ABA54ACC4;
        Wed, 16 Dec 2020 04:43:30 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Date:   Wed, 16 Dec 2020 15:43:02 +1100
Subject: [PATCH 0/7 nfs-utils] Assorted improvements to handling nfsmount.conf
Cc:     Justin Mitchell <jumitche@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Message-ID: <160809318571.7232.10427700322834760606.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The handling of version specifiers in mount.nfs, and even in the kernel,
is somewhat ideosyncratic when multiple versions are listed.

For example,  "-o vers=4.1,nfsvers=3" will result in both versions being
passed to the kernel, and the kernel complaining because version 3
doesn't support minor version numbers.
Conversly, "-o nfsvers=4.1,vers=3" will result in the "nfsvers=4.1"
being stripped off and vers=3 being used.

Further, version settings found in /etc/nfsmount.conf are sometimes
ignored if a version is given on the command line, and sometimes not.
If "nfsvers=3" is in the config file, then the presense of "-o vers=4.1"
will cause it to be ignored, the presense of "-o nfsvers=4.1" will too, but
mainly because of sloppy code.  However "-o v4.1" won't cause the config
file setting to be ignored.

This series cleans up all of this and some related issues, and updates
the man page.

With other options, the last option listed on the command line wins.
I have not tried to provide that for version options.  Instead, if there
are multiple version options listed, and error is reported.

Thanks,
NeilBrown

---

NeilBrown (7):
      mount: configfile: remove whitesspace from end of lines
      mount: report error if multiple version specifiers are given.
      Revert "mount.nfs: merge in vers= and nfsvers= options"
      mount: convert configfile.c to use parse_opt.c
      mount: options in config file shouldn't over-ride command-line options.
      mount: don't add config-file protcol version options when already present.
      mount: update nfsmount.conf man page


 utils/mount/configfile.c      | 230 +++++++++++-----------------------
 utils/mount/network.c         |  36 +++---
 utils/mount/nfsmount.conf.man | 110 ++++++++++------
 utils/mount/parse_opt.c       |  12 +-
 utils/mount/parse_opt.h       |   3 +-
 5 files changed, 174 insertions(+), 217 deletions(-)

--
Signature

