Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5673191335
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2020 15:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCXO3D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 10:29:03 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60030 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbgCXO3D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Mar 2020 10:29:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TtX8sph_1585060130;
Received: from Macintosh.local(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0TtX8sph_1585060130)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Mar 2020 22:28:50 +0800
Subject: Re: [PATCH] nfsd: fix race between cache_clean and cache_purge
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <5eed50660eb13326b0fbf537fb58481ea53c1acb.1585043174.git.wuyihao@linux.alibaba.com>
 <91F74983-D681-4CD3-92FF-8CDB8DB7CD8D@oracle.com>
From:   Yihao Wu <wuyihao@linux.alibaba.com>
Message-ID: <709608a5-24e6-d279-ef3a-ff9ab7538f88@linux.alibaba.com>
Date:   Tue, 24 Mar 2020 22:28:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <91F74983-D681-4CD3-92FF-8CDB8DB7CD8D@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020/3/24 10:18 PM, Chuck Lever wrote:
>> Fixes: 471a930ad7d1(SUNRPC: Drop all entries from cache_detail when cache_purge())
>> Cc: stable@vger.kernel.org #v4.11+
> Yihao, I couldn't get this patch to apply to kernels before v5.0.
> 
> I don't think we need both a Fixes tag and a Cc: stable, because
> stable maintainers will try to apply this patch to any kernel that
> has 471a930, and ignore the failures.
> 
> So if I apply your fix, I'm going to drop the Cc: stable tag.
> 
> 

OK. And thanks for reviewing and reminding me this, Chuck.

Yihao Wu
