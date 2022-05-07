Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5B51E9DC
	for <lists+linux-nfs@lfdr.de>; Sat,  7 May 2022 22:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446987AbiEGUTG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 May 2022 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446976AbiEGUTE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 May 2022 16:19:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45874255BC
        for <linux-nfs@vger.kernel.org>; Sat,  7 May 2022 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651954516; x=1683490516;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b/b20ZzIqk0/fSbXoB2Waa51shvrKSfdabXE/1j/I4o=;
  b=FhS77NFL9ptE00RdoD15+4GySQORKpGvXg8notUkYaYEYsC0EJJ+bZUX
   L8oPgrvdQpPzRlVDYksPH6q+97izUoRcVStJ9P3A+bRM0Cjw+ghLUXg8q
   hHf61HbGmJbdcnzxAmo4lgFYSCPol02molY+G3FJZ635yylNOW+r5l2c/
   1QeP9BsCU+HS4P5jSwnB3KNR2I+gZuZMppYEeV2mJCX5jth9Pi1/A/n0O
   2hufC0HvQSrfbcWUW6MjkomhnrKj05Ajru7Reqnj59IVy663kzu+/+Oqb
   Bc2Ei9wfp7UHixaZAvucAX/TIoAzF32+mL45KH/7zV/6+88zWBESlIIaB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="293968479"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="293968479"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 13:15:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="666008500"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 May 2022 13:15:08 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnQpX-000Ewh-D8;
        Sat, 07 May 2022 20:15:07 +0000
Date:   Sun, 8 May 2022 04:14:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kbuild-all@lists.01.org, linux-nfs@vger.kernel.org
Subject: [trondmy-nfs:testing 10/11] fs/nfs/nfs4xdr.c:5441:2-3: Unneeded
 semicolon
Message-ID: <202205080451.lMiCyJ4b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

tree:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git testing
head:   3ae6128f05af0939ada8b2b0f9a0e334f24e7835
commit: 215995a763543dd4e029173f2268785cce39ce86 [10/11] NFSv4: Add encoders/decoders for the NFSv4.1 dacl and sacl attributes
config: x86_64-randconfig-c002 (https://download.01.org/0day-ci/archive/20220508/202205080451.lMiCyJ4b-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> fs/nfs/nfs4xdr.c:5441:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
