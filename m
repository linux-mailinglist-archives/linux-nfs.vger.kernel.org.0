Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B151C4D9AB2
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 12:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbiCOL4J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 07:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbiCOL4J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 07:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9CA738BCE
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647345290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0f8NwBpotV6slXJKkWwnIcZFPvb2ucjf4SHEGfM1l4o=;
        b=AykXeQxlmOFG95UIdx2WYy5IYeio+10c4cKXMCr2KxZkvutebQboR3NGNZBXuzZMh+4QZc
        gW5MyMIy44lE7lxiL3GDPUAv5yIQeamHPOz15d7YTWE6L+9z9Ff/6V/CE4whHGOP0XaSFY
        LwNR+tsVQKU+u+jbfczpDhDIQEeuRWc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-wKlEHXXHM0aoFaZmxp71ww-1; Tue, 15 Mar 2022 07:54:49 -0400
X-MC-Unique: wKlEHXXHM0aoFaZmxp71ww-1
Received: by mail-qk1-f197.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so14063133qkb.23
        for <linux-nfs@vger.kernel.org>; Tue, 15 Mar 2022 04:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0f8NwBpotV6slXJKkWwnIcZFPvb2ucjf4SHEGfM1l4o=;
        b=rPyPhgHgvUz2esEP59V23jxSRjjyKDXhwWigEhvgoUXppHYFeYRAQOR4Gdkd2ig8Rm
         KfhuZBJ1Lk1U4GBAB6ioEPtEaQ0h9qzQjJWOR/hHt24P4lTrxu8zNOXt+uUyH8vsCQxi
         GCpTrTpAizrZLopcQ1vLcUD+aSw7hShWTMlfSWfpkhwx0m8j7x2b0Zo9CyqCxsQIqvre
         NkXHJkOQgHligl69Ceseez307M7Xx2CfLuTFCn7V73lAK2VbJJwY2/8EHUbukc4x179i
         MMXJaLXd4rcU6xd6CCkKcrjQACdmJ6WiAZzjbHNphUYGK6zcwMY/r+L5txRh5jMKSXGe
         ZUbw==
X-Gm-Message-State: AOAM530g3fIsClR05GTtbazB6hngQ6SbZ2IhtKu6BTITtD/Whm2qmSjf
        p3BwvHKxrJSXAOKTh+ORLBiwIwZisKcd4z3AxNiT/lffPXbeK2fclYjm+kdrdTz8iNJ4EjLTOnv
        LFU2N/F3wzi98hRPRzLyq
X-Received: by 2002:a05:622a:1112:b0:2e1:d807:698e with SMTP id e18-20020a05622a111200b002e1d807698emr5025957qty.425.1647345288949;
        Tue, 15 Mar 2022 04:54:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzifDPucfLJS3vFlBa+XOTRsslj7bav7ue4Mr0nbNtBE1sZZ6mENgUcNv/I3yu5Qe2tA5b8Fw==
X-Received: by 2002:a05:622a:1112:b0:2e1:d807:698e with SMTP id e18-20020a05622a111200b002e1d807698emr5025938qty.425.1647345288627;
        Tue, 15 Mar 2022 04:54:48 -0700 (PDT)
Received: from [172.31.1.6] ([71.168.97.48])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a188300b002e1cbca8ea4sm6252807qtc.59.2022.03.15.04.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 04:54:48 -0700 (PDT)
Message-ID: <f6a1e306-211a-25d0-50c5-63c631ca1e47@redhat.com>
Date:   Tue, 15 Mar 2022 07:54:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC v2 PATCH 0/7] Introduce nfs-readahead-udev
Content-Language: en-US
To:     Thiago Becker <tbecker@redhat.com>, linux-nfs@vger.kernel.org
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        kolga@netapp.com
References: <20220311190617.3294919-1-tbecker@redhat.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <20220311190617.3294919-1-tbecker@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/11/22 2:06 PM, Thiago Becker wrote:
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
> Thiago Becker (7):
>    Create nfs-readahead-udev
>    readahead: configure udev
>    readahead: create logging facility
>    readahead: only set readahead for nfs devices.
>    readahead: create the configuration file
>    readahead: add mountpoint and fstype options
>    readahead: documentation
> 
>   .gitignore                                    |   6 +
>   configure.ac                                  |   4 +
>   tools/Makefile.am                             |   2 +-
>   tools/nfs-readahead-udev/99-nfs_bdi.rules.in  |   1 +
>   tools/nfs-readahead-udev/Makefile.am          |  26 +++
>   tools/nfs-readahead-udev/config_parser.c      |  25 +++
>   tools/nfs-readahead-udev/config_parser.h      |  14 ++
>   tools/nfs-readahead-udev/list.h               |  48 ++++
>   tools/nfs-readahead-udev/log.h                |  16 ++
>   tools/nfs-readahead-udev/main.c               | 211 ++++++++++++++++++
>   .../nfs-readahead-udev/nfs-readahead-udev.man |  47 ++++
>   tools/nfs-readahead-udev/parser.y             |  85 +++++++
>   tools/nfs-readahead-udev/readahead.conf       |  15 ++
>   tools/nfs-readahead-udev/scanner.l            |  19 ++
>   tools/nfs-readahead-udev/syslog.c             |  47 ++++
>   15 files changed, 565 insertions(+), 1 deletion(-)
>   create mode 100644 tools/nfs-readahead-udev/99-nfs_bdi.rules.in
>   create mode 100644 tools/nfs-readahead-udev/Makefile.am
>   create mode 100644 tools/nfs-readahead-udev/config_parser.c
>   create mode 100644 tools/nfs-readahead-udev/config_parser.h
>   create mode 100644 tools/nfs-readahead-udev/list.h
>   create mode 100644 tools/nfs-readahead-udev/log.h
>   create mode 100644 tools/nfs-readahead-udev/main.c
>   create mode 100644 tools/nfs-readahead-udev/nfs-readahead-udev.man
>   create mode 100644 tools/nfs-readahead-udev/parser.y
>   create mode 100644 tools/nfs-readahead-udev/readahead.conf
>   create mode 100644 tools/nfs-readahead-udev/scanner.l
>   create mode 100644 tools/nfs-readahead-udev/syslog.c
> 
My apologies for waiting late on this... I was on PTO.

I really don't like the name of the is command. It
does not follow any of the naming conventions we used in the
past... Can you please rename the command to nfsrahead.

tia,

steved.

