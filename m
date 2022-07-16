Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21C4576C30
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Jul 2022 08:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiGPGaG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Jul 2022 02:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGPGaC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 16 Jul 2022 02:30:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF1012769
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 23:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657952941; x=1689488941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o1ICIGxVxwPE6ZjMQbjcSfhxh7SOuTRnuQL6m3p6uqQ=;
  b=PdnTbAe7hn7OXz6/5an44gZR6LQQUF50kHhq8vEjOEIHAhMoep9MqopW
   08g2pMRNyg4dyNyTI7uwjR+mslZAb7aFxoTCKZ0Km49vMnae1UsTQaMik
   XteEgvQEuKAukdCdffaDr5Ap8Y8tes9Wgnvn1sCAUYPRRJqGC7clDIOyE
   wUmUl+6ho9auZ454y//HEsBR6EFRXYDkw75KBZ3AoK+6B5yF3pGjJF98b
   PSBH2TZhZ9ra6RhcSvAvCmN7PWrLb69soaYEh9awfX3w/0Onls2LJ68Z8
   F0G/e5uky7ET51t6XvEOWbcHmni+aCaX710+RcrJ6dHr9ynV8tuiRnpa9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="311624435"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="311624435"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 23:29:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="842763309"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2022 23:29:00 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCbIS-0001DY-20;
        Sat, 16 Jul 2022 06:29:00 +0000
Date:   Sat, 16 Jul 2022 14:28:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com
Cc:     kbuild-all@lists.01.org, anna@kernel.org
Subject: Re: [PATCH v2 3/6] SUNRPC: Introduce xdr_buf_trim_head()
Message-ID: <202207161409.4ykWVM8o-lkp@intel.com>
References: <20220713190825.615678-4-anna@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713190825.615678-4-anna@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna,

I love your patch! Perhaps something to improve:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v5.19-rc6 next-20220715]
[cannot apply to cel-2.6/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anna-Schumaker/NFSD-Improvements-for-the-NFSv4-2-READ_PLUS-operation/20220714-030910
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/networking/kapi:59: net/sunrpc/xdr.c:1749: WARNING: Unexpected indentation.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
