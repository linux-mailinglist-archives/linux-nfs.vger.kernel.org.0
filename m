Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465CCBAD47
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2019 06:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406612AbfIWE12 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Sep 2019 00:27:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:47300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405826AbfIWE12 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Sep 2019 00:27:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A0BDAFA4;
        Mon, 23 Sep 2019 04:27:27 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Mon, 23 Sep 2019 14:26:57 +1000
Subject: [PATCH 0/3] some nfs-utils patches.
Cc:     linux-nfs@vger.kernel.org
Message-ID: <156921267783.27519.2402857390317412450.stgit@noble.brown>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These free are largely unrelated.
The only connection is that without the second, I get
warnings because my /etc/nfs.conf includes /etc/nfs.conf.local - just
in case.
Then, without the first patch, the open fds get confused and
rpc.mountd doesn't listen on all /proc/net/rpc/*/channel
properly and nfs doesn't work.

Thanks,
NeilBrown

---

NeilBrown (3):
      mountd: Initialize logging early.
      conffile: allow optional include files.
      statd: take user-id from /var/lib/nfs/sm


 support/nfs/conffile.c    |   13 ++++++++++---
 support/nsm/file.c        |   16 +++++-----------
 systemd/nfs.conf.man      |    3 +++
 utils/mountd/mountd.c     |    9 +++------
 utils/statd/sm-notify.man |   10 +++++++++-
 utils/statd/statd.man     |   10 +++++++++-
 6 files changed, 39 insertions(+), 22 deletions(-)

--
Signature

