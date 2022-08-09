Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8D58D23F
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Aug 2022 05:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiHIDLE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Aug 2022 23:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIDLD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Aug 2022 23:11:03 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D3010B8;
        Mon,  8 Aug 2022 20:10:59 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.8.64])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4M1ykn71Ryz1DwT;
        Tue,  9 Aug 2022 11:10:57 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4M1ykW2zBgzCFQtR;
        Tue,  9 Aug 2022 11:10:43 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4M1ykR4p84z9tyDD;
        Tue,  9 Aug 2022 11:10:39 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4M1ykM4ps2z4xVnQ;
        Tue,  9 Aug 2022 11:10:35 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 2793AGKQ021717;
        Tue, 9 Aug 2022 11:10:16 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 9 Aug 2022 11:10:16 +0800 (CST)
Date:   Tue, 9 Aug 2022 11:10:16 +0800 (CST)
X-Zmail-TransId: 2b0462f1d01874bde6e5
X-Mailer: Zmail v1.0
Message-ID: <202208091110164796108@zte.com.cn>
In-Reply-To: <20220727100107.3062-1-wang.yi59@zte.com.cn>
References: 20220727100107.3062-1-wang.yi59@zte.com.cn
Mime-Version: 1.0
From:   <wang.yi59@zte.com.cn>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <linux-nfs@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <xue.zhihong@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <zhang.xianwei8@zte.com.cn>,
        <wang.yi59@zte.com.cn>
Subject: =?UTF-8?B?UmU6W1BBVENIXSBORlN2NC4xOiBSRUNMQUlNX0NPTVBMRVRFIG11c3QgaGFuZGxlIEVBQ0NFUw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2793AGKQ021717
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 62F1D040.000 by FangMail milter!
X-FangMail-Envelope: 1660014658/4M1ykn71Ryz1DwT/62F1D040.000/10.35.8.64/[10.35.8.64]/mxde.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 62F1D040.000/4M1ykn71Ryz1DwT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Gentle ping :)

> From: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
>
> A client should be able to handle getting an EACCES error while doing
> a mount operation to reclaim state due to NFS4CLNT_RECLAIM_REBOOT
> being set. If the server returns RPC_AUTH_BADCRED because authentication
> failed when we execute "exportfs -au", then RECLAIM_COMPLETE will go a
> wrong way. After mount succeeds, all OPEN call will fail due to an
> NFS4ERR_GRACE error being returned. This patch is to fix it by resending
> a RPC request.
>
> Signed-off-by: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
> fs/nfs/nfs4proc.c | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index bb0e84a46d61..b51b83506011 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -9477,6 +9477,9 @@ static int nfs41_reclaim_complete_handle_errors(struct rpc_task *task, struct nf
> rpc_delay(task, NFS4_POLL_RETRY_MAX);
> fallthrough;
> case -NFS4ERR_RETRY_UNCACHED_REP:
> + case -EACCES:
> + dprintk("%s: failed to reclaim complete error %d for server %s, retrying\n",
> + __func__, task->tk_status, clp->cl_hostname);
> return -EAGAIN;
> case -NFS4ERR_BADSESSION:
> case -NFS4ERR_DEADSESSION:
