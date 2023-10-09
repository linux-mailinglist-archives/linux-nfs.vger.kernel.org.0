Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036DF7BE3A0
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Oct 2023 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjJIOyd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Oct 2023 10:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjJIOyd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Oct 2023 10:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED658F
        for <linux-nfs@vger.kernel.org>; Mon,  9 Oct 2023 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696863228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HcMtELOwQu7P1JVKA67WmvkCkrFqYfOfIFRa6Qduun8=;
        b=PxT7GCnI0EuG1LqD0l9ojSnJIjIxP8mDGDfak5Ipdz6kYE23KBnj+nUHAuMujJKsOj8IYX
        otFQHtaDqoFUFIqGd8GkVs2OmRlKCiRl20nDHlu1Jt3WrbvRTulQHlIRz0aPLt8fkPq4F4
        LE/m223zdj/4aYGhhSfiXTkNCRVHbCg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-HmGY1s-UNJOHQ09U_WGlQg-1; Mon, 09 Oct 2023 10:53:42 -0400
X-MC-Unique: HmGY1s-UNJOHQ09U_WGlQg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77422b20b13so94992585a.1
        for <linux-nfs@vger.kernel.org>; Mon, 09 Oct 2023 07:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696863221; x=1697468021;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HcMtELOwQu7P1JVKA67WmvkCkrFqYfOfIFRa6Qduun8=;
        b=CpKBPNHyM/N2NwzGmX89h8P0i4D9FKRT23rl/AzaVIqXHOscYgTH3J4ytDTkv7Pr/Y
         gwoIvST24HQX1Q1rES25o3cezOcKGZpZBnOnGBH1s3ErWMkni+hBzcXxgc17rtleo0+e
         5+A6TdOCX6eYtuaWtHM5x9tHTBM27ydI5uKG8jOBIcrtPCyP8L+RQUUy/7qcmwI0KE6N
         jm9JYHNVOgI5j9V6OzgIc/0lbrU6r+28ctGsIPSADkFh8NLtSd+5xtGhodtQqTEaTjjh
         f4hwZ234iYF0UyNUv+Hg9NClpwg83MYz8/IT+CWa1ri75qzDCvGvoKU1l59pDZ1eAFcf
         mSpw==
X-Gm-Message-State: AOJu0Yz24Oczlqi9BhJFGWutKi6ylnzRr94Hc/2+4uKjfJhMyV1N6rCG
        GRjAwG+zzEPqJGyuREU6wp0nwq2IgH5ANnqJuzzHPDuL0KrP5HHslXJ0IRmjR1bGljgqlFD8yq5
        BbelUlXpzq/IFcu+2fWMozXfiaiMGD7tV7IK7YMuovAsCrRC/qfBj/8D1YnHvCf+IxFYkrtwuKQ
        rrqnwN
X-Received: by 2002:a05:6214:2303:b0:658:30c4:206 with SMTP id gc3-20020a056214230300b0065830c40206mr17523105qvb.0.1696863221428;
        Mon, 09 Oct 2023 07:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQvzjTX/vw1Rp3UNNEQA8SfItFfOeDZvpHvwTNYEWdU9z5Zwj7AQ1P/t44VdLMPVtSR+3Yng==
X-Received: by 2002:a05:6214:2303:b0:658:30c4:206 with SMTP id gc3-20020a056214230300b0065830c40206mr17523086qvb.0.1696863221134;
        Mon, 09 Oct 2023 07:53:41 -0700 (PDT)
Received: from [10.193.20.130] ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id c11-20020a0cf2cb000000b0065b2167fd63sm3836888qvm.65.2023.10.09.07.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 07:53:40 -0700 (PDT)
Message-ID: <3bd325f2-3723-4cf2-bf10-2d3378ffd05e@redhat.com>
Date:   Mon, 9 Oct 2023 10:53:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
Subject: Bakeathon is live!
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The Bakeathon has started... Info to do
remote testing and registering are at

http://www.nfsv4bat.org/Events/2023/Oct/BAT/index.html

Feel free to join us via google meet at

https://meet.google.com/yxw-iwyc-vzc

steved.

