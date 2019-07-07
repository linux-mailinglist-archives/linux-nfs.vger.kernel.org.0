Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142FD61598
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2019 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGGQq5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Jul 2019 12:46:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:46213 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfGGQq4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Jul 2019 12:46:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2019 09:46:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,463,1557212400"; 
   d="scan'208";a="192081614"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2019 09:46:55 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hkAJT-000Bm1-0d; Mon, 08 Jul 2019 00:46:55 +0800
Date:   Mon, 8 Jul 2019 00:46:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kbuild-all@01.org, linux-nfs@vger.kernel.org
Subject: [nfs:testing 18/19] fs/nfs/dir.c:196:51-52: Unneeded semicolon
Message-ID: <201907080032.BxKfahLm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

tree:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git testing
head:   c433a7975cfc839906aaa891f68d86ca228f7e43
commit: 36cdd6c6a8416b6a455ddc0b104eaf94eb37d39e [18/19] NFS: Ensure cached readdir info is NUL terminated

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> fs/nfs/dir.c:196:51-52: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
