Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEB4496D1C
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jan 2022 18:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiAVRgZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jan 2022 12:36:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230289AbiAVRgY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jan 2022 12:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642872984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xwHew9SxboNbzCrM/hfmKIAu85E2d0G6pYm1kGBbLRs=;
        b=LiVuMxCDcdv+HkNl4l4z+Wh3Q44uxUt2wa0RQmfTZ52PtCHo8zLF8unZ461A5AAszOXFhf
        UliXk3cxUzXeLqVD7B6gfAP8MjiiZCA77/8vuS3NKrwvFYjkY4Yeg4SIKDG3cvdShfznyw
        t3EuWxmzJXkpvf9NBDxCkXTSKTz5hlI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-xmKjz1wCPCGoInWdKIBk6w-1; Sat, 22 Jan 2022 12:36:22 -0500
X-MC-Unique: xmKjz1wCPCGoInWdKIBk6w-1
Received: by mail-qv1-f72.google.com with SMTP id r12-20020a0562140c8c00b004226c4fc035so1176345qvr.4
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 09:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=xwHew9SxboNbzCrM/hfmKIAu85E2d0G6pYm1kGBbLRs=;
        b=Jx55BLwfhTkZwJjAUdWo3sz0ompTTLeqmVOaAbIxlR3remjJrWUo0JP0wriIaFmhAw
         oI0e2beSyGKjilBm5Aj0i37cPrDOJTbhVHgpGCJphb/kWBWVMI9uVAflBHemYyO3142S
         sjmpMKzTmo/d0U/ZogfmEVfZanLlJlCvIggpHTiIDo6Q2ZN5LsbZWoZXcAO/6bPxHxTk
         ZhwyJz8I5wRwRNpUOjlMMNeiNaD74QQZicW8oyq0C0CvJfIfjp7hvnr7C1JCpRpTicAw
         VHoAAFhLqmlCIY9sSnUBWYFcdAkSyFZH8VysiJm95k1FXH5qJPZ7aYXlBOuZXqOm/g0N
         yI9w==
X-Gm-Message-State: AOAM531PWQQr2f+ueimIL1HFOxtXStLDfrvyTNISgIxDICbZ+JUpTiRq
        byrhEfgMzvpzHiT2zqGO4xnwX0cDPtS+p4RwclRTR/2HFjv9+xCUSIV2qU7iFAeoDUZk7FVNt3D
        6/3P3vyP+1ECY8byvAN0W9fW13m0b0ccspS2Xc1w4sqH291tEa20zDs4pxuu6PcXbKvMBrg==
X-Received: by 2002:a05:6214:20ab:: with SMTP id 11mr2794969qvd.127.1642872981716;
        Sat, 22 Jan 2022 09:36:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnBja4x/zAUQMlFih5+XIchQa7hzS51WFIRsBS+a26+zgl17+WMzXJvBwaqPJv6o1ZIBI6sw==
X-Received: by 2002:a05:6214:20ab:: with SMTP id 11mr2794956qvd.127.1642872981473;
        Sat, 22 Jan 2022 09:36:21 -0800 (PST)
Received: from [172.31.1.6] ([70.109.152.127])
        by smtp.gmail.com with ESMTPSA id c11sm4810308qte.28.2022.01.22.09.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jan 2022 09:36:21 -0800 (PST)
Message-ID: <e5eaa806-af35-a54a-e4ed-f1edf53f03f8@redhat.com>
Date:   Sat, 22 Jan 2022 12:36:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.6.1 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

My apologies for the confusion of the tagging
of the git tree... I moved from 2.5 to a 2.6
release because in this release NFSv2 is no longer
tolerated. Meaning it can not be enabled and will
error out if used on either the client or server.

I'm hoping this will not be a significant change
but I thought the versioning should reflect the
change.

A number of memory leaks were plugged up, changes
to make the tools a bit more arm64 friendly,
as well as a number of bug fixes...

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.1/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.1

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.6.1/2.6.1-Changelog
or
    http://sourceforge.net/projects/nfs/files/nfs-utils/2.6.1/

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

