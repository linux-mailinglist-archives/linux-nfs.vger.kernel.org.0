Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3734A731606
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 13:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbjFOLDb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 07:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbjFOLDY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 07:03:24 -0400
Received: from out-10.mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8772949
        for <linux-nfs@vger.kernel.org>; Thu, 15 Jun 2023 04:03:21 -0700 (PDT)
Message-ID: <de03d60e-0720-33be-e0fa-fcde587489a5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686826999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31dJgRFCsqu//EY9h78jvruPaMDSErokC9iXi+ASWUw=;
        b=SZ4wMuTBIUu5D2Uu+rBnCQy0OOD7DdSnRy6AEXBiO5JgDhnUOg4XrKl8If4miXjlDy6x7J
        MzgA7Q0+0ZokiqjuTX4qM6Rf4lawzfyhkZcQgYn/uSbSS5B7layFM3KGBzzw9egKU2yUAn
        EQFYzWrQDBmIwamHP8fw6n1db+1UiUw=
Date:   Thu, 15 Jun 2023 19:03:13 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] NFSv4.2: fix wrong shrinker_id
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, trond.myklebust@hammerspace.com,
        anna@kernel.org, fllinden@amazon.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <20230614072443.3264264-1-qi.zheng@linux.dev>
 <202306150121.cN9iKnvx-lkp@intel.com>
 <0d70dc6c-3f7e-b899-adcb-5b71c1aa298e@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <0d70dc6c-3f7e-b899-adcb-5b71c1aa298e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2023/6/15 10:46, Qi Zheng wrote:
> 
> 
> On 2023/6/15 02:06, kernel test robot wrote:
>> Hi Qi,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on trondmy-nfs/linux-next v6.4-rc6 next-20230614]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    
>> https://github.com/intel-lab-lkp/linux/commits/Qi-Zheng/NFSv4-2-fix-wrong-shrinker_id/20230614-152853
>> base:   linus/master
>> patch link:    
>> https://lore.kernel.org/r/20230614072443.3264264-1-qi.zheng%40linux.dev
>> patch subject: [PATCH] NFSv4.2: fix wrong shrinker_id
>> config: i386-debian-10.3 
>> (https://download.01.org/0day-ci/archive/20230615/202306150121.cN9iKnvx-lkp@intel.com/config)
>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>> reproduce (this is a W=1 build):
>>          git checkout linus/master
>>          b4 shazam 
>> https://lore.kernel.org/r/20230614072443.3264264-1-qi.zheng@linux.dev
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          make W=1 O=build_dir ARCH=i386 olddefconfig
>>          make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new 
>> version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: 
>> https://lore.kernel.org/oe-kbuild-all/202306150121.cN9iKnvx-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>
>>>> ERROR: modpost: "free_prealloced_shrinker" [fs/nfs/nfsv4.ko] undefined!
>>>> ERROR: modpost: "register_shrinker_prepared" [fs/nfs/nfsv4.ko] 
>>>> undefined!
>>>> ERROR: modpost: "prealloc_shrinker" [fs/nfs/nfsv4.ko] undefined!
> 
> Ah, these three functions need to be exported. Will fix it in the v2.

Or we can just swap the order of register_shrinker() and 
list_lru_init_memcg().

> 
>>
