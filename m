Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC744FE3C7
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Apr 2022 16:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbiDLObV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Apr 2022 10:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiDLObT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Apr 2022 10:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6751CE3A
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649773741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6j9X5eOKKHOM92VLXohw/w5Wikg6iweTiDYPsh1lys=;
        b=C496DiaC5nOVSAWN0qBsxtV0yyBY7pv2IQssIcVAMs8mCoW/+dvFY0UmlkhU/RrnIlzhGA
        v26yHSkzGIHAbeJERGT6HXE6Pp6/qyg1h9rA27dPzqn9F1n4rooboyfabx44vSH7ibYBlG
        u65y34JlbPm5lffVGafkO9Fvujrsrqg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-WgLIuuKnNlqmkKFUJisDpA-1; Tue, 12 Apr 2022 10:28:59 -0400
X-MC-Unique: WgLIuuKnNlqmkKFUJisDpA-1
Received: by mail-pl1-f198.google.com with SMTP id p8-20020a170902e74800b001564f2593a5so7959650plf.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 Apr 2022 07:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q6j9X5eOKKHOM92VLXohw/w5Wikg6iweTiDYPsh1lys=;
        b=BfnQIwYVtgPKHMJDh7WDe3mNNlxuK2kTeGREAkbtfVIsj8MSy8iMSOwjsTwFUV1zCO
         Hfv2eHwv4ti27Jtw+cAQxGtgnIj0OQ/KTtE/omWkDqdB9wZAHg+r8MhRpknJ2ZuDIM4r
         nWdoKpTsVHfUTJhmPukd5DqrCuvOQxPjLxCRs55ByThVj8bVcAFbaIyv83a63Vmll0IX
         38WbH/HpTZ2PqZ0tX13Zuq+TxqUu0cxZ855/6l/k3YWA38uwbyQL6UJ4niPOKEFtq6CO
         +7TIM0FptqxPEEa6nndZ0z3n+CMNG2FSOGE7rBVT/f8iB6E2H/OnV/Z87Fv5q9SvaoUB
         ZXow==
X-Gm-Message-State: AOAM530tespbnsGL/d10d2VhJPAlBVFJdnFt3ZERTxJOCliKApnTCd27
        1qmMRGEH+2n5H6O5SnJMClB6Z4Lgry9v8ZkgqQjhabIVIgWwMIl0wbgXz2yPqwu0l7ZPDrM5UUk
        Nxmxg/HDJWOZEnph8cW5M
X-Received: by 2002:a17:90b:1e08:b0:1c7:585c:9034 with SMTP id pg8-20020a17090b1e0800b001c7585c9034mr5252509pjb.184.1649773738511;
        Tue, 12 Apr 2022 07:28:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ52qtVn6mptIb1T0vuAcaCO8oVN6LpeuwOV72jn7slbBfVaxb4IoxWNmPlMX8lZ0z8P/R9w==
X-Received: by 2002:a17:90b:1e08:b0:1c7:585c:9034 with SMTP id pg8-20020a17090b1e0800b001c7585c9034mr5252486pjb.184.1649773738236;
        Tue, 12 Apr 2022 07:28:58 -0700 (PDT)
Received: from [10.19.60.33] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h18-20020a63c012000000b0039cc3c323f7sm3002015pgg.33.2022.04.12.07.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 07:28:57 -0700 (PDT)
Message-ID: <f9ec727f-e616-4af8-ac09-2d0fd1f2ae0a@redhat.com>
Date:   Tue, 12 Apr 2022 10:28:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] nfs-utils: nfsidmap.man: Fix section number
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Bryan Schumaker <bjschuma@netapp.com>,
        Ben Hutchings <benh@debian.org>
References: <20220412070016.720489-1-carnil@debian.org>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220412070016.720489-1-carnil@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 4/12/22 3:00 AM, Salvatore Bonaccorso wrote:

My mailer was unable to process the attachment
Please in-line the patch and resend it.

steved.

