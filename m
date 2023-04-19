Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD17B6E805E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 19:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjDSR3k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjDSR3j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 13:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C9F72B4
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681925331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ihiwXpDL+XFx0tVOaUHxeVnDzkDFebGV372mGDT2o5E=;
        b=UMd6nm5Q8DAkkQyotpW4yD0/AiMPly1pFAJGy9Z2gYMPpF/jegFoGApgTjYR6dI6iqbC0d
        8s+4ntXXHnAPbat9mvq+u1xmQA6frO7k58qh0Ri32izs2JT58rU9lX9Z04R6IBg4KjyMFH
        f3Y4eONhuLRPhis8yL0CFm4XOMkcL84=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-6pMe69shMEqyBv2aj3V7_Q-1; Wed, 19 Apr 2023 13:28:50 -0400
X-MC-Unique: 6pMe69shMEqyBv2aj3V7_Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ef67855124so185876d6.1
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 10:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681925328; x=1684517328;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ihiwXpDL+XFx0tVOaUHxeVnDzkDFebGV372mGDT2o5E=;
        b=f5DxWyPPh62w67YeRoYiO3Nf7s2za9QRxfyLljmJPy6eSor0lehCZ8cSw8waE/cPu/
         gS+NWAv+pe+hYNz4DPR8sH63vA9N8evH+xC8LmSBoz2AYCxwF3w2RKJa9raOb5Tj6IQa
         NVWyMYnyCvjZIQTLW66CjYTzVgETGKsSnvvfrkq6pq4HR8ySFucjWPfgA8leqIA62jjb
         YfhH7kXZhyf3SO6bcSfui3qDcdUND6+VMq8JQNt7kJFRVzPklN99KBU89rwlnqyY5Fvn
         FICWZB9wTGARsDj0HZ3VLZ1zNcewnT2tjvEjkg3KrPIzLxRhN058LR9dWVK/m2kWmQPA
         vHRA==
X-Gm-Message-State: AAQBX9evlX+NZpoaFTC6mTEdOKv1GnSoYmeQT3H4otgj/MdOKkU6xf7K
        3nEJWDqM5Uh82nwH80IcqjQj1mG0s0MYiDsG6vvNfkilSX3HqpnoW6Up1XTkLhUSvaSa2VVtjoz
        9JaFMJsvgEhU2ciSBp9ih0JSwRNUn2oVATAv5pipzYZSW7uX4PgIU/IjZZ5JQqllJiplbQFxRcD
        ceUA==
X-Received: by 2002:a05:6214:500e:b0:5ef:5af7:a274 with SMTP id jo14-20020a056214500e00b005ef5af7a274mr26690620qvb.3.1681925328675;
        Wed, 19 Apr 2023 10:28:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350asM+h7G5MMjSimWsVD+DFjH2XI8vVHaT4OnvURDMrVmhHolJvNacKwBHK5J6ePzWcfhhJ1yw==
X-Received: by 2002:a05:6214:500e:b0:5ef:5af7:a274 with SMTP id jo14-20020a056214500e00b005ef5af7a274mr26690589qvb.3.1681925328379;
        Wed, 19 Apr 2023 10:28:48 -0700 (PDT)
Received: from [172.31.1.6] ([70.105.248.80])
        by smtp.gmail.com with ESMTPSA id b10-20020a056214002a00b005f160622f3esm1016217qvr.85.2023.04.19.10.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 10:28:47 -0700 (PDT)
Message-ID: <34b5dcb5-b559-8f18-d69b-0dcc8cacfbed@redhat.com>
Date:   Wed, 19 Apr 2023 13:28:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.6.3 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

In this release there is TLS-with-RPC support and re-export
improvements, including a new daemon fsidd.

A number of typos fixed in man pages and nfs.conf and
the usual bug fixes.

Thank you for everyone who has contributed!

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.3/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.3

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.3/2.6.3-Changelog
or
    http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.3/

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

