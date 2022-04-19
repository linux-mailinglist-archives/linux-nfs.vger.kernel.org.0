Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C39C507A8A
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Apr 2022 21:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbiDSUAb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Apr 2022 16:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbiDSUAa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Apr 2022 16:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1797E26562
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650398262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mY76h2ebeEbaMrVhFseUjO+nXeDJ6eyP8Az/7canwDY=;
        b=bJRPiPAtNDZQVHJAWxIVk2jBK+XGTh1m0OM9NmNDLJfJoFNi4R54cY4EIe5j4/Wi5lCK09
        OGqCJbP3+1AMUkbOPzYJOLNbeOkU17yXEw93bTJs45airA1Uks1di6S8wjEhT5fylvvmTX
        mDH45nr88BdtNO5xVcxytwRkRcPDE8g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-8YM8DJJOMQiSKrfSkXnCow-1; Tue, 19 Apr 2022 15:57:40 -0400
X-MC-Unique: 8YM8DJJOMQiSKrfSkXnCow-1
Received: by mail-qv1-f70.google.com with SMTP id m16-20020ad45050000000b00446393a7a9fso9485635qvq.6
        for <linux-nfs@vger.kernel.org>; Tue, 19 Apr 2022 12:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mY76h2ebeEbaMrVhFseUjO+nXeDJ6eyP8Az/7canwDY=;
        b=DYqt0fxgL26UlzdNf1jTglnRHHe1TJm1bbBmSO2P8D3zETAQaK3IRBvEFfCVC/Bvgj
         vOVvj4Itf1M5blWiobL1Fgd+TfHdBXux7WlSZs4MpkssrRegRyrdm5ef7c79d1glHf5y
         PZM2tG+yEArflc36N5G/tJpSL/nHQ6MTifaRPWa/ic1z0e/L3yac+TBRImD+PswOz8g6
         uLZxrhPK7MWggBlR/UzNDUKQYJ/55US/Tikav0NB3O4PMALZL0jGe+EGaIPnD9LbhhC5
         eGoRaZ7Q5XnsdhAYag2qdtyxgliTdn3EYGljorxaPskWuOGwn94BO22+8yq1NIx70pOV
         GlKQ==
X-Gm-Message-State: AOAM532bZCOoSOelvBypeNvlPa3jl4Pm7jbssOzddo7ZbHYIDtAPi3wl
        eWoc9KcYSz55zChKSoCtcVfPAWrNv5pB6m7vS9GOJ1NjgSF3kwSF8MO4S8E+XJnlJ4c+Ua4Z/gL
        Uczoo56/vYXfvWnAcW94N
X-Received: by 2002:ac8:5e4e:0:b0:2e2:2bad:47b1 with SMTP id i14-20020ac85e4e000000b002e22bad47b1mr11504475qtx.493.1650398259535;
        Tue, 19 Apr 2022 12:57:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyutQ1A0CKF+iVt9V+fuK2Q0U7lu0HKg1wmNdAyiCX6sl/m1tUtQxSpVrtTItPSsPLjWfe+Hw==
X-Received: by 2002:ac8:5e4e:0:b0:2e2:2bad:47b1 with SMTP id i14-20020ac85e4e000000b002e22bad47b1mr11504456qtx.493.1650398259145;
        Tue, 19 Apr 2022 12:57:39 -0700 (PDT)
Received: from [172.31.1.6] ([71.168.80.171])
        by smtp.gmail.com with ESMTPSA id i123-20020a378681000000b0069c73915781sm455238qkd.120.2022.04.19.12.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 12:57:38 -0700 (PDT)
Message-ID: <a363ba71-9778-51f4-9c7e-88cb29020331@redhat.com>
Date:   Tue, 19 Apr 2022 15:57:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/7] Intruduce nfsrahead
Content-Language: en-US
To:     Thiago Becker <tbecker@redhat.com>, linux-nfs@vger.kernel.org
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        kolga@netapp.com
References: <20220401153208.3120851-1-tbecker@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220401153208.3120851-1-tbecker@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/1/22 11:32 AM, Thiago Becker wrote:
> Recent changes in the linux kernel caused NFS readahead to default to
> 128 from the previous default of 15 * rsize. This causes performance
> penalties to some read-heavy workloads, which can be fixed by
> tuning the readahead for that given mount.
> 
> Specifically, the read troughput on a sec=krb5p mount drops by 50-75%
> when comparing the default readahead with a readahead of 15360.
> 
> Previous discussions:
> https://lore.kernel.org/linux-nfs/20210803130717.2890565-1-trbecker@gmail.com/
> I attempted to add a non-kernel option to mount.nfs, and it was
> rejected.
> 
> https://lore.kernel.org/linux-nfs/20210811171402.947156-1-trbecker@gmail.com/
> Attempted to add a mount option to the kernel, rejected as well.
> 
> I had started a separate tool to set the readahead of BDIs, but the
> scope is specifically for NFS, so I would like to get the community
> feeling for having this in nfs-utils.
> 
> This patch series introduces nfs-readahead-udev, a utility to
> automatically set NFS readahead when NFS is mounted. The utility is
> triggered by udev when a new BDI is added, returns to udev the value of
> the readahead that should be used.
> 
> The tool currently supports setting read ahead per mountpoint, nfs major
> version, or by a global default value.
> 
> v2:
>      - explain the motivation
> 
> v3:
>      - adopt already available facilities
>      - nfsrahead is now configured in nfs.conf
> 
> v4:
>      - retry getting the device if it fails
>      - assorted fixes and improvements
> 
> Thiago Becker (7):
>    Create nfsrahead
>    nfsrahead: configure udev
>    nfsrahead: only set readahead for nfs devices.
>    nfsrahead: add logging
>    nfsrahead: get the information from the config file.
>    nfsrahead: User documentation
>    nfsrahead: retry getting the device if it fails.
> 
>   .gitignore                      |   2 +
>   configure.ac                    |   1 +
>   systemd/nfs.conf.man            |  11 ++
>   tools/Makefile.am               |   2 +-
>   tools/nfsrahead/99-nfs.rules.in |   1 +
>   tools/nfsrahead/Makefile.am     |  16 +++
>   tools/nfsrahead/main.c          | 183 ++++++++++++++++++++++++++++++++
>   tools/nfsrahead/nfsrahead.man   |  72 +++++++++++++
>   8 files changed, 287 insertions(+), 1 deletion(-)
>   create mode 100644 tools/nfsrahead/99-nfs.rules.in
>   create mode 100644 tools/nfsrahead/Makefile.am
>   create mode 100644 tools/nfsrahead/main.c
>   create mode 100644 tools/nfsrahead/nfsrahead.man
> 
Committed... (tag nfs-utils-2-6-2-rc4)

steved.

