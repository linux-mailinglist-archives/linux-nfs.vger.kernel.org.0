Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6480E6374E7
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Nov 2022 10:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKXJOH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Nov 2022 04:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKXJOF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Nov 2022 04:14:05 -0500
Received: from wedge009.net.lu.se (wedge009.net.lu.se [130.235.56.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA89A113FD4;
        Thu, 24 Nov 2022 01:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1669281233; h=from:subject:to:date:message-id;
        bh=rdM9hfr5frWjVSYLhSHzBcEzoQqV/1jhiWP1nUfsnkM=;
        b=JnX2V072VXgpgO4U9rQNCjmGPZn/2bg0wGKL5xhCd0EAFCUgPTtHA9AmTCh9FfVNMEKbbzhyBJS
        QZ/Tau1aTUrk9JyYcZ/2Qz6ILs7xqxaBPZDU9S9S3qZQWIqVhLEMleR6/ID1ZIjerodthnxqwOFqa
        xOdWtta7+GHbP3M7+soQGRSHOVH2rc2MT66ZMGv28z1t7nOTySJG1OdRLa2M39iHLd2D4xQrcJLPi
        VLLIx5KZX2busxShxTidPkOG30GXQ8scZemv52TQF6/lBfux2fUd2CN4r1Uus5HBxEBTWT3b9bKGb
        pPw0wA2IX4Ef1/Dgpq0wq8EOwBcfBEaOaEKw==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.13; Thu, 24
 Nov 2022 10:13:47 +0100
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.13; Thu, 24
 Nov 2022 10:12:10 +0100
Message-ID: <065b8a56-9546-b2d2-695c-7d56df0eab6d@control.lth.se>
Date:   Thu, 24 Nov 2022 10:12:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Kernel 6.0.5 breaks virtual machines that boot from nfs mounted
 qcow2 images
Content-Language: en-US
From:   Anders Blomdell <anders.blomdell@control.lth.se>
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
 <d2d80dc2-2ac9-809f-635d-a8c2f2bfdb69@control.lth.se>
In-Reply-To: <d2d80dc2-2ac9-809f-635d-a8c2f2bfdb69@control.lth.se>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc011.uw.lu.se (130.235.59.233) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
Received-SPF: Pass (wedge009.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge009.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge009.net.lu.se
X-OrganizationHeadersPreserved: wedge009.net.lu.se
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2022-11-23 18:57, Anders Blomdell wrote:
> 
> 
> On 2022-11-23 18:51, Chuck Lever III wrote:
>>
>>> On Nov 23, 2022, at 12:49 PM, Benjamin Coddington <bcodding@redhat.com> wrote:
>>>
>>> On 23 Nov 2022, at 5:08, Anders Blomdell wrote:
>>>
>>>> Our problems turned out to be a fallout of Al Viros's splice rework, where nfsd reads with non-zero offsets and not ending
>>>> on a page boundary failed to remap the last page. I belive that this is a decent fix for that problem (tested on v6.1-rc6,
>>>> 6.0.7 and 6.0.9)
>>>>
>>>> ---- a/fs/nfsd/vfs.c
>>>> +++ b/fs/nfsd/vfs.c
>>>> @@ -873,7 +873,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
>>>>         unsigned offset = buf->offset;
>>>>          page += offset / PAGE_SIZE;
>>>> -       for (int i = sd->len; i > 0; i -= PAGE_SIZE)
>>>> +       for (int i = sd->len + offset % PAGE_SIZE; i > 0; i -= PAGE_SIZE)
>>>>                 svc_rqst_replace_page(rqstp, page++);
>>>>         if (rqstp->rq_res.page_len == 0)        // first call
>>>>                 rqstp->rq_res.page_base = offset % PAGE_SIZE;
>>>
>>>
>>> Does anyone have insight into how we could possibly have caught this in testing?
>>
>> Was also wondering this. I had though fstests (via fsx) would have exercised
>> this usage scenario.
> My guess is that one has to look very hard at qcow2 handling in qemu...
aio_read seems to trigger the problem, but there is a lot of buffering going on that I don't understand
(e.g even short aio_reads leads to 16384 bytes read)

/Anders
-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
