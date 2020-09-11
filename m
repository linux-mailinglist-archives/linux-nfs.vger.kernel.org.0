Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0A266A7E
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Sep 2020 23:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgIKV70 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Sep 2020 17:59:26 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:47565 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgIKV7V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Sep 2020 17:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599861561; x=1631397561;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=QeDXwHX3wf345BKy5Edc9IRMU9ZYUNAu9K1tJtAaZsM=;
  b=MczZ1ZWmHEpBmGuerSplSxj8Sv0QAhaL6C+gnzO2bqjVZA8FbxktTSQw
   QGWnvtyVUkpeI7zBgrWyxh49lxkrjrwx2K4wWtL/qlXD8xVsT8sxmj7Nz
   eXcEe3wkWz2f9b2BJyS/MmDqX9vDssyIjYoBkaq31QDcTdx/EQye6/bp/
   4=;
X-IronPort-AV: E=Sophos;i="5.76,417,1592870400"; 
   d="scan'208";a="74312092"
Subject: Re: [PATCH] nfs: round down reported block numbers in statfs
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 11 Sep 2020 21:59:19 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 9D3D3A1EC3;
        Fri, 11 Sep 2020 21:59:18 +0000 (UTC)
Received: from EX13D19UEA004.ant.amazon.com (10.43.61.134) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 11 Sep 2020 21:59:17 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19UEA004.ant.amazon.com (10.43.61.134) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 11 Sep 2020 21:59:17 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Fri, 11 Sep 2020 21:59:17 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 1C21CC13F5; Fri, 11 Sep 2020 21:59:17 +0000 (UTC)
Date:   Fri, 11 Sep 2020 21:59:17 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>
CC:     <anna.schumaker@netapp.com>, <trond.myklebust@hammerspace.com>,
        <dhowells@redhat.com>
Message-ID: <20200911215916.GA2437@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200910200644.8165-1-fllinden@amazon.com>
 <202009111258.q1Pb2upn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202009111258.q1Pb2upn%lkp@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 11, 2020 at 12:36:31PM +0800, kernel test robot wrote:
> 
> 
> Hi Frank,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on nfs/linux-next]
> [also build test ERROR on v5.9-rc4 next-20200910]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Frank-van-der-Linden/nfs-round-down-reported-block-numbers-in-statfs/20200911-040903
> base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
> config: riscv-rv32_defconfig (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    riscv32-linux-ld: fs/nfs/super.o: in function `nfs_statfs':
>    super.c:(.text+0x204): undefined reference to `__udivdi3'
> >> riscv32-linux-ld: super.c:(.text+0x220): undefined reference to `__udivdi3'
>    riscv32-linux-ld: super.c:(.text+0x23c): undefined reference to `__udivdi3'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Ah yeah, forgot about 64bit divides and 32bit archs..

Will send v2 with div64_u64.

- Frank
