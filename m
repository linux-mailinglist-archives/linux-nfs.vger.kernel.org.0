Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F5458DA8F
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Aug 2022 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbiHIOwC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Aug 2022 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244499AbiHIOwB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Aug 2022 10:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C879D1CFFA
        for <linux-nfs@vger.kernel.org>; Tue,  9 Aug 2022 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660056719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vgi0fTJ0b7FwJs6rQF7KjB7lyfCm+3RLPeRFrj9jfRo=;
        b=a72a8q+AyBMqeLWzUTWkRQV1sbcoC4fnquzkuJUdpa3UbAdT9/14zA+ptwfb95NCSJljwr
        lP9JrV2AbfzmdpSKQSHqdFsBBb+UeoStPoGSXcbOPK9gJQ5+LlIMvI3ZHlOECHYkn7FdR1
        /3bQYY/OxGIMLXBjpPOSGALBuqbd99g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-aWfBlS_7OSWLok5esgD1QQ-1; Tue, 09 Aug 2022 10:51:58 -0400
X-MC-Unique: aWfBlS_7OSWLok5esgD1QQ-1
Received: by mail-qk1-f197.google.com with SMTP id x22-20020a05620a259600b006b552a69231so10346015qko.18
        for <linux-nfs@vger.kernel.org>; Tue, 09 Aug 2022 07:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=Vgi0fTJ0b7FwJs6rQF7KjB7lyfCm+3RLPeRFrj9jfRo=;
        b=YKMIjRNPLcu3d0xv7ffQmfTMXObBoD9s4UK/XGbtcymyPXJ0EjRR+6D2dss9HOiuyh
         jY/bENjjcpA281/V4MHosl6nEr2JOL5q1NcZkqnvNX28r4xYtuOVdk1ZHvV1z9d74+Hd
         1Vbv8h0EYa8Ao8SfuTKVvja34CL3z+5/8E64Q8Kd/Y9NWkfB/AcVE+5lcB6HTVDO56r7
         iRWngYokuuIEg/jn2O6dXiQ3LfPSYGRLbibQpQ6nrCle+51ocPc3jZFGdsBLPKmHqq6V
         ouyja0zkkAxYzUxlb5ots7YXCMbe+LM9zh9Qp4efGYCZ92F6FNqgTg5F7LVJhCv8lsK3
         kb5w==
X-Gm-Message-State: ACgBeo3cyk1B9TAgyGpwh4ZTcsuUmOTc893IlHexKamw3R2uYdntat2x
        G7xN4AIIteGUsP/Y/fiALMnJhBeY7zPg9AcRjd+tERCc2jv1oGegsdiBdAv5Nw5Ml8QqpdakLWL
        Et8BWC/Td2SBrcuS5qG0D8VCFdNmJTXfhy3Mbrsw/LfGQ/vmEFOb5C9UswXAIlQOOdnnCcQ==
X-Received: by 2002:ae9:e88d:0:b0:6b9:4a0b:cea5 with SMTP id a135-20020ae9e88d000000b006b94a0bcea5mr7552272qkg.748.1660056718012;
        Tue, 09 Aug 2022 07:51:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Ht1d2UtrHEHqkYrVKiHdtZHjC/M6JbCKxTOnvN8bV9CbFLEewpo0UWYYtDBqkdpBXv00s7g==
X-Received: by 2002:ae9:e88d:0:b0:6b9:4a0b:cea5 with SMTP id a135-20020ae9e88d000000b006b94a0bcea5mr7552258qkg.748.1660056717731;
        Tue, 09 Aug 2022 07:51:57 -0700 (PDT)
Received: from [172.31.1.6] ([70.109.152.92])
        by smtp.gmail.com with ESMTPSA id t1-20020a05620a450100b006b59f02224asm12397244qkp.60.2022.08.09.07.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 07:51:57 -0700 (PDT)
Message-ID: <469a34bb-e566-fc9c-3367-2c4e4fe1f776@redhat.com>
Date:   Tue, 9 Aug 2022 10:51:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.6.2 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

In this release there is a two new commands (rpcctl, nfsrahead)
but mostly it is bug fixes and updates to config files
and man pages.

Thank you for everyone who has contributed!

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.2/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.2

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.2/2.6.2-Changelog
or
    http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.2/

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

