Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B0176CB58
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjHBK5u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 06:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHBK5r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 06:57:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874412706;
        Wed,  2 Aug 2023 03:57:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686ea67195dso4821958b3a.2;
        Wed, 02 Aug 2023 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690973848; x=1691578648;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZMbvHqHfNju3vz5dg2yx+1aokirDZw7B5GcpGdB8+4=;
        b=bd6YmXkBoEMzBM8+b7AIrxNQ0TetARKDJ+mA99+77YGMpSNcRy8AyInyGriaohxat3
         aj1U8L9kiac/PnG4s0+9WTQMcHgq6oVRPOORvpCj2XO7VFX/MiLSLzhBB0bHloPcPwVR
         TLjS6ADA8sxko980wxsUkUM8+4y8tn5HQ4hEvIP91aCsUUP0YBE/sffAVB+cZbJfupgK
         YBAKr8F6VkgBydCbzdR/lStk9q09Z1mlVSyn9vBC3VsR5ZGBEtskwBCcBmaeU+hx6dAJ
         QYsJA48grPtJdgrWBz9LB2cqnbQVqE1hO3h+14dM+l8JhYxoYDJMJYRp6o2eIa6dmayL
         VQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690973848; x=1691578648;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TZMbvHqHfNju3vz5dg2yx+1aokirDZw7B5GcpGdB8+4=;
        b=PxpNMeoZ2m/uU/BTyzRY4WlewHwVajY8SJg3qXysDaNSW3248acGKCg10TDzsBOomM
         6lHFyhD6lxQR47A0FVteXB1qg0M2iwsnt+V/HRpE1ZHOfMSdlMSJ/y7VGCeykrzpqBrK
         s40uK8ICJMyOIKl/83S2j1iEkOcbqePoB8R1K4Qdect2Bjd7NN6p/u4IK1xzUZCZUPSN
         cJK+KUT1P00K6+Jlq1Ppn4VL9SofTWLau4PkdDWBadrv+61IfnpVskqtQ6UgnB9Nqvaq
         aacY0KgtlZ8y1bcNeWTutWHB5Jjwtf0L8KNEFJz3OrlCKhCWDHzBznpylD60/gDMZEYo
         keGg==
X-Gm-Message-State: ABy/qLY9Dcz1Z4WzoAkzHnf2e9Z3r16XB6zCs0wmb2HZGAJNH/zxVv8R
        Qfgp8MmrD3xK0JVvCZLQOoQ=
X-Google-Smtp-Source: APBJJlGdLTLxqfVF5Jm9nh4XWR+VXSOSkdieEymVf76G12NalJbzBy8VvdlnosHF+QrX2+iNCcWJrg==
X-Received: by 2002:a05:6a00:21c3:b0:686:baf2:35f4 with SMTP id t3-20020a056a0021c300b00686baf235f4mr16934383pfj.29.1690973847696;
        Wed, 02 Aug 2023 03:57:27 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id v24-20020aa78518000000b00679b7d2bd57sm10822897pfn.192.2023.08.02.03.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 03:57:27 -0700 (PDT)
Message-ID: <43860d25-aa68-ce46-18e8-05960a95e9a6@gmail.com>
Date:   Wed, 2 Aug 2023 17:57:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Mohadeb Mondal <mohadeb.mondal@dell.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS <linux-nfs@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Linux client uses server side copy of NFS 4.2 when small files
 are copied between two intra server file system mount points
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Justification: The server-side copy of small files takes more time than the R/W copy in NFS 4.2.
> When I have two NFS 4.2 files systems from the same NFS server mounted in my linux client & I issue a copy operation between one file system to the other file system, the linux client issues server side copy of NFS 4.2 with COPY_NOTIFY packet.
> If these two file systems are part of two different server, the same linux client issues server side copy of NFS 4.2 with COPY_NOTIFY packet only if the file size is more than 128 KB.
> For less <= 128 KB files the client uses READ and WRITE operations in case of inter server copy.
> 
> As the protocol does not specify any way for the server to drive the client for switching to the legacy file copy method, the same mechanism for the inter-server server-side copy could be applied to the intra-server copy as well.
> 
> The request has two parts.
> 1. Introduce one config parameter in "/etc/nfs.conf" where a user can provide the minimum file size required for COPY_NOTIFY operation. Default it to 128 KB. If the file size is less, the client should use READ and WRITE operations instead of COPY_NOTIFY for both inter & intra server copy in NFS 4.2 mount.
> 
> 2. Modify how intra server copy is handled now. It should follow similar approach as followed by inter server copy. It should utilize the config variable from point  1 to decide between "READ and WRITE operation" and "COPY_NOTIFY".
> 
> Reproducible: Always
> 
> Steps to Reproduce:
> 1.Configure two Linux NFS 4.2 server & take one Fedora 38 client.
> 2.Configure 2 file system in one server and one file system in another server.
> 3.Initiate file copy between file systems in the same server.
> 4.Also initiate file copy between file systems in the two different server.
> 5.Try step 3-4 with file size of 1 byte, 128 KB & 129 KB files.
> 6.Take packet capture and see the content.
> 
> Actual Results:  
> For inter server copy, 
> It uses COPY_NOTIFY operation for file size more than 128 KB. for <= 128 KB it use READ and WRITE operations.
> For intra server copy,
> It uses COPY_NOTIFY operation for all file sizes
> 
> Expected Results:  
> 1. One new parameter is introduced in nfs.conf to configure minimum file size for COPY_NOTIFY operation with a default value 128 KB.
> 2. For file sizes more than the configured value or more than 128KB if not configured, the client should issue COPY_NOTIFY operation for intra & inter server copy.
> 3. For other case, it should use READ and WRITE operations instead of COPY_NOTIFY for both inter & intra server copy in NFS 4.2 mount
> 
> The test was done with
> Fedora Linux 38 (Workstation Edition) with
> Kernel 6.4.4-200.fc38.x86_64
> 
> I have also attached packet capture of 1 byte, 128 KB & > 128 KB file copy operation for your reference.

See Bugzilla for the full thread and attached tcpdump output.

Note that I have to forward the Bugzilla report by this email because
the reporter chose generic `Kernel` component when filing it, thus
missing linux-nfs list. The reporter's address is also in To: field
so that you can reach him without having to go to Bugzilla.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217749

-- 
An old man doll... just what I always wanted! - Clara
