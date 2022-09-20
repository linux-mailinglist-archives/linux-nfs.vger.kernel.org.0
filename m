Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E507C5BED44
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 21:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiITTA5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Sep 2022 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiITTAy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Sep 2022 15:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C65872EE2
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663700446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=T6uXpz/pby0XMvJRchTM/1Jee6RsQY/19FHiPx60F/A=;
        b=g5+pn3VCZXQbfa46Qq0tdTh9Sr2VjsgTj3mbY8zV2d1ubMGkUaHi3WS2SQAfR1I8KduCZd
        jJanlQKUDW6CIOQI+fZiSUSmKWXMOlTfvygIVX1qQU0k+MKX9D+5sqtCGdhZLkD9FfAvI9
        aTKUmSRixxHUaHGGNqAanUmhJm+hzCY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-AtsAXs35Mr2gRzp7LRbSIg-1; Tue, 20 Sep 2022 15:00:44 -0400
X-MC-Unique: AtsAXs35Mr2gRzp7LRbSIg-1
Received: by mail-qv1-f71.google.com with SMTP id dw19-20020a0562140a1300b004a8eee124b4so2680130qvb.21
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 12:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=T6uXpz/pby0XMvJRchTM/1Jee6RsQY/19FHiPx60F/A=;
        b=ucNJsuiEQ2dNVOhtumQ9jrYHydi1fojRP+QFh5u8fhl2SH/GM10OcCxFJEn+21q+v7
         5KxpgWAj3NOc+xRmwu6B6Rkj6vGEmbgZYoCSsHmptlbeXFIYjkBPdw1fK3biyg648uz9
         VD+aToh2P1Y5Ok753ubSks/dd2VRbSk6lY7+9Paiv0BN0cxys5udCB99LQ+OGj+6XEdS
         CEzSQJ8otRS/Lo2Tsxn01nNtvUcXvv5LvFDwK/eYq0J+DNUhTl7pdCuH2kCaWpB2GihC
         pBPY3GSOHm0xIVMQcmnSq1hheKkWNrPX4vdiMvebHuJ77+Cux/G2HxpjafsSHLb9rQvX
         vqBw==
X-Gm-Message-State: ACrzQf1oIunD7NRpM0OVM/Gnjhz6+MSklqqtts4O71gvoLJ7Xj0ipriU
        yYvDZxh9/C0fWQGc1lu7ydh1dLPrAzR+DVgzCDWenC23EQNe4JmMAPV7mNp4z7z0UArKhJAfF6m
        fckDB6R/6QN4tgP9apDBiu+efZ4xZ83CJja93Gn4F3tl2kLZwpfE6NkURLxlHAzr1MC64oQ==
X-Received: by 2002:a05:622a:15c5:b0:35c:d407:cbfd with SMTP id d5-20020a05622a15c500b0035cd407cbfdmr17558178qty.540.1663700444009;
        Tue, 20 Sep 2022 12:00:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7xlDxOa60X3bvYZzofU1zYaVavd/yCFuqlYwyejLP6iGzT79WQYKACqcXI9aA7V2G7UPKz6g==
X-Received: by 2002:a05:622a:15c5:b0:35c:d407:cbfd with SMTP id d5-20020a05622a15c500b0035cd407cbfdmr17558153qty.540.1663700443747;
        Tue, 20 Sep 2022 12:00:43 -0700 (PDT)
Received: from [172.31.1.6] ([71.161.93.20])
        by smtp.gmail.com with ESMTPSA id k7-20020a05620a138700b006b9c6d590fasm344783qki.61.2022.09.20.12.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 12:00:43 -0700 (PDT)
Message-ID: <d2a0d253-2b49-ae14-b6ac-6a363326fb1d@redhat.com>
Date:   Tue, 20 Sep 2022 15:00:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
From:   Steve Dickson <steved@redhat.com>
Subject: nfs4-acl-tools-0.4.2
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

In this release the syntax has been changed to used
the "-i" flag set the index for where the
insertion or deletions should start.

The git tree: git://linux-nfs.org/~steved/nfs4-acl-tools.git
The tarball: 
http://linux-nfs.org/~steved/nfs4-acl-tools/nfs4-acl-tools-0.4.2.tar.gz

steved.

