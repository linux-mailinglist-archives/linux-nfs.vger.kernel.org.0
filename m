Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC083A2D07
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhFJNbp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 09:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231172AbhFJNbp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 09:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623331788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzDn90gw9PlkWZNz1Sv48VLjtp7b0XFBTo9e4s6xahU=;
        b=MCu9AqigEDUL/PI6wyx2G2dpnHv0ZzOcFbBkunMGfDwTcfTes5t43oPm3wBYguYRX3nWcL
        EPLdnKs0KVumlTFgO/60TvX47anbgBNhU0n/NArFaJKJMHI/LTqt6ah+yxnC36UAnk9QV4
        DPS+6AKQCejGfakpjopA+vW7KBWYSOo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-OixG_9vEOneaHV8ebT_0bQ-1; Thu, 10 Jun 2021 09:29:47 -0400
X-MC-Unique: OixG_9vEOneaHV8ebT_0bQ-1
Received: by mail-qv1-f70.google.com with SMTP id br4-20020ad446a40000b029021addf7b587so20284192qvb.10
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 06:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vzDn90gw9PlkWZNz1Sv48VLjtp7b0XFBTo9e4s6xahU=;
        b=IVan26/EnV11lRKwXi2eGtzd2j/KC5WAyaGDgeb2gqC7rWMHFhnMvTV5sTrW1lovhI
         DHMlhagJ1OQhuylazVW1aMI5HQ+Uw5WRDyvkWCcIwpt5u1d3/gjKbVGFM40j9X3xHRdN
         eYrN+5a77J6PaPmocfJt46K5B07Duetn6c54JEUyv2sgDo9yICfDPctjUVNJsQA9TN4A
         Bf0MdKK44oS5KIpXbYSZH6Imj8qJeqMFaLb/W5JN4ikmaRn+8n9aBZzstlsv0P1G6R7K
         Y5qzBwsGMEWP1gbmsBXkZuiEu2mWBDRxSUNYseGo7wjmFqUXmYt3JoenHFXfBjDl/Har
         KDZQ==
X-Gm-Message-State: AOAM530JK+M/nnZiP+RN98AMeJX/ifJHcOS1MJyY+U8/mEHYrXW8sLLE
        J0ry8q4HygkZ1kZcAia0IBc0gN5kMuWMSRjci9eQJxopzfmVNhzwprSc97IhMKjBUTu6zRgswWJ
        iZogA8ZXCIGFVEP3xldE0yFr+zs0R+TylFsE9GWIiwoHHuUVIuP6ujwGwCGAlyeArbWJJYw==
X-Received: by 2002:ac8:5813:: with SMTP id g19mr5226888qtg.383.1623331786867;
        Thu, 10 Jun 2021 06:29:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzscIROZ3brvcKGSn59nM5wNNP4TbDDEfauP4Ckao4j4KpuuPZtOZErDGoQvPZVXi0Z2SgoOQ==
X-Received: by 2002:ac8:5813:: with SMTP id g19mr5226868qtg.383.1623331786577;
        Thu, 10 Jun 2021 06:29:46 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.93.112])
        by smtp.gmail.com with ESMTPSA id e127sm2284720qkf.62.2021.06.10.06.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 06:29:46 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] don't collapse transports for the trunkable
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <9657859a-7e65-0b38-a4c5-3f74d0bdc5e8@redhat.com>
Date:   Thu, 10 Jun 2021 09:32:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 6/9/21 5:53 PM, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> This patch series attempts to allow for new mounts that are to the
> same server (ie nfsv4.1+ session trunkable servers) but different
> network addresses to use connections associated with those mounts
> but still use the same client structure.
> 
> A new mount options, "max_connect", controls how many extra transports
> can be added to an existing client, with maximum of 128 transports in
> total for either nconnect transports (which are multiple connections
> but to the same IP) or transports that are going to different network
> addresses.
I'm trying to figure out why this new mount option is needed...
What is it protecting? What am I missing?

Plus it needs to be documented....

steved.
> 
> Olga Kornievskaia (3):
>    SUNRPC query xprt switch for number of active transports
>    NFSv4 introduce max_connect mount options
>    NFSv4.1+ add trunking when server trunking detected
> 
>   fs/nfs/client.c             |  1 +
>   fs/nfs/fs_context.c         |  8 +++++++
>   fs/nfs/internal.h           |  2 ++
>   fs/nfs/nfs4client.c         | 43 +++++++++++++++++++++++++++++++++++--
>   fs/nfs/super.c              |  2 ++
>   include/linux/nfs_fs_sb.h   |  1 +
>   include/linux/sunrpc/clnt.h |  2 ++
>   net/sunrpc/clnt.c           | 13 +++++++++++
>   8 files changed, 70 insertions(+), 2 deletions(-)
> 

