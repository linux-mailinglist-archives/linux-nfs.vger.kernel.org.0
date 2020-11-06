Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971DA2A90F5
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKFIFm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 03:05:42 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57230 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgKFIFm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Nov 2020 03:05:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UEPEc7J_1604649938;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEPEc7J_1604649938)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 16:05:39 +0800
Subject: Re: [PATCH] fs/nfsd: remove unused NFSDDBG_FACILITY to tame gcc
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1604634457-3954-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604634457-3954-2-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <8145bb50-8606-809d-01b2-221a6c259103@linux.alibaba.com>
Date:   Fri, 6 Nov 2020 16:05:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1604634457-3954-2-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Sorry, gcc is error on this case, it cann't find out much of
NFSDDBG_##flag

Forget this patch.

Alex

ÔÚ 2020/11/6 ÉÏÎç11:47, Alex Shi Ð´µÀ:
> There are lots of NFSDDBG_FACILITY defined in many files
> but it isn't used anywhere. so remove it to tame the gcc warning:
> 
> fs/nfsd/nfsxdr.c:12:0: warning: macro "NFSDDBG_FACILITY" is not used
> [-Wunused-macros]
> fs/nfsd/filecache.c:23:0: warning: macro "NFSDDBG_FACILITY" is not used
> [-Wunused-macros]
> fs/nfsd/nfs3xdr.c:17:0: warning: macro "NFSDDBG_FACILITY" is not used
> [-Wunused-macros]
> fs/nfsd/flexfilelayoutxdr.c:11:0: warning: macro "NFSDDBG_FACILITY" is
> not used [-Wunused-macros]
> fs/nfsd/nfsxdr.c:12:0: warning: macro "NFSDDBG_FACILITY" is not used
> [-Wunused-macros]
> fs/nfsd/filecache.c:23:0: warning: macro "NFSDDBG_FACILITY" is not used
> [-Wunused-macros]
> fs/nfsd/nfs3xdr.c:17:0: warning: macro "NFSDDBG_FACILITY" is not used
> [-Wunused-macros]
> fs/nfsd/flexfilelayoutxdr.c:11:0: warning: macro "NFSDDBG_FACILITY" is
> not used [-Wunused-macros]
> 
