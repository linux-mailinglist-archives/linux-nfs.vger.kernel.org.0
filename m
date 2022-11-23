Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0126367DD
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Nov 2022 18:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbiKWR6l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Nov 2022 12:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239325AbiKWR6R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Nov 2022 12:58:17 -0500
Received: from wedge010.net.lu.se (wedge010.net.lu.se [130.235.56.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A9F64570;
        Wed, 23 Nov 2022 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1669226272; h=from:subject:to:date:message-id;
        bh=KQhk2ap/hZCSu63a5uf1OoR3V/bnmsDEXpetctJWHwM=;
        b=FGisCrKKTYZY8/+bw/C9GhcYkpyc7tkgtgEzgyq6pDfJLK4S0oW9eA0hLagX/CYu/KOwXvhGphq
        O69CMxKAR5PfXtiaMKf2sZ0nspBu3I4IzJHKm3kcB9zzTTZo0Vp9M33Q6B6n7pNBznEQWtQeTd9sX
        qT1+roCKnuqo4qvOMfcep0Na6HEMSZtpd6er/qP07xcxELU3FEkbSfGwWBDf7WgfW2TkkSY8StmoN
        WDyYZdw01LgNJOMK1Jl/ocvJKDymMhi9vsE5lLr6+QWO9oDeKDmhyYGrMBSI+zkm9jslCfZf8kQwi
        zMcHkclCYZcUDMuZHbZEtSh/40j3nlx8Up8w==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.13; Wed, 23
 Nov 2022 18:57:52 +0100
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.13; Wed, 23
 Nov 2022 18:57:46 +0100
Message-ID: <d2d80dc2-2ac9-809f-635d-a8c2f2bfdb69@control.lth.se>
Date:   Wed, 23 Nov 2022 18:57:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Kernel 6.0.5 breaks virtual machines that boot from nfs mounted
 qcow2 images
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
References: <65115206-ec17-443e-8495-91661a2fd9be@control.lth.se>
 <0abaa41e-79e1-3c0c-6d1b-47d4e21f2296@control.lth.se>
 <A0F05ED3-14B0-4AE7-B4F7-82398033CA34@redhat.com>
 <90DACFB9-2854-4688-8822-936C6EEB1FD3@oracle.com>
From:   Anders Blomdell <anders.blomdell@control.lth.se>
In-Reply-To: <90DACFB9-2854-4688-8822-936C6EEB1FD3@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc011.uw.lu.se (130.235.59.233) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
Received-SPF: Pass (wedge010.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge010.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge010.net.lu.se
X-OrganizationHeadersPreserved: wedge010.net.lu.se
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2022-11-23 18:51, Chuck Lever III wrote:
> 
>> On Nov 23, 2022, at 12:49 PM, Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 23 Nov 2022, at 5:08, Anders Blomdell wrote:
>>
>>> Our problems turned out to be a fallout of Al Viros's splice rework, where nfsd reads with non-zero offsets and not ending
>>> on a page boundary failed to remap the last page. I belive that this is a decent fix for that problem (tested on v6.1-rc6,
>>> 6.0.7 and 6.0.9)
>>>
>>> ---- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -873,7 +873,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
>>>         unsigned offset = buf->offset;
>>>          page += offset / PAGE_SIZE;
>>> -       for (int i = sd->len; i > 0; i -= PAGE_SIZE)
>>> +       for (int i = sd->len + offset % PAGE_SIZE; i > 0; i -= PAGE_SIZE)
>>>                 svc_rqst_replace_page(rqstp, page++);
>>>         if (rqstp->rq_res.page_len == 0)        // first call
>>>                 rqstp->rq_res.page_base = offset % PAGE_SIZE;
>>
>>
>> Does anyone have insight into how we could possibly have caught this in testing?
> 
> Was also wondering this. I had though fstests (via fsx) would have exercised
> this usage scenario.
My guess is that one has to look very hard at qcow2 handling in qemu...

/Anders


-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
