Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905181A8F13
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2020 01:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbgDNXZa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Apr 2020 19:25:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:29317 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731159AbgDNXZZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 14 Apr 2020 19:25:25 -0400
IronPort-SDR: BtUYH5WuwYUCpHDOFrBFMVYPsmWNPhaejlFrVw4gWF9ygjjbwkjfZFVNl7GoyQ0CIrm+YCm3o5
 qA7ZUsuG/jew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 16:25:21 -0700
IronPort-SDR: yV6LB+QoJSoyaIoFV6Ec46IGksX5kBfLNE9sF3D54IMsSDUa4sQJ6Jrr/b9/tJ7rqW8KJiEDF0
 1W5nnjpQGI6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="453721931"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Apr 2020 16:25:19 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jOUve-000BgH-NZ; Wed, 15 Apr 2020 07:25:18 +0800
Date:   Wed, 15 Apr 2020 07:24:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        linux-nfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH 3/8] fs: wrap simple_pin_fs/simple_release_fs arguments
 in a struct
Message-ID: <202004150726.FqMGnFlz%lkp@intel.com>
References: <20200414124304.4470-4-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414124304.4470-4-eesposit@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Emanuele,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on driver-core/driver-core-testing linus/master v5.7-rc1 next-20200414]
[cannot apply to security/next-testing]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Emanuele-Giuseppe-Esposito/Simplefs-group-and-simplify-linux-fs-code/20200415-030834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 885a64715fd81e6af6d94a038556e0b2e6deb19c

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

smatch warnings:
fs/debugfs/inode.c:689 remove_one() warn: inconsistent indenting

vim +689 fs/debugfs/inode.c

   684	
   685	static void remove_one(struct dentry *victim)
   686	{
   687	    if (d_is_reg(victim))
   688			__debugfs_file_removed(victim);
 > 689		simple_release_fs(&debugfs);
   690	}
   691	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
