Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAAA3A68DB
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jun 2021 16:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhFNOWE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 10:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233383AbhFNOWE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Jun 2021 10:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623680401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F4r6zXU9JovBkh6SsFD5G5K6EvAJNO/7FLVKe9QAg28=;
        b=JbI4rXkEAIkTvnlDL9qSK13XolnQRuqnWOGjLzQT/S1KYaHcoLeiqypGoEYm9K9f6FhTDU
        Wq1lVstRJuIXpkorcnypwvoLBig2rvLrUc/hWecGzSXYbbAzCbuVBoHqLr7gpEM5SyR/gs
        5s4efNEn7S2HmMlDKp8GtnsAqcGQG20=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-EYiwhqU0NUaCmsDa25CccQ-1; Mon, 14 Jun 2021 10:19:59 -0400
X-MC-Unique: EYiwhqU0NUaCmsDa25CccQ-1
Received: by mail-qt1-f199.google.com with SMTP id d7-20020ac811870000b02901e65f85117bso7509881qtj.18
        for <linux-nfs@vger.kernel.org>; Mon, 14 Jun 2021 07:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=F4r6zXU9JovBkh6SsFD5G5K6EvAJNO/7FLVKe9QAg28=;
        b=XaCh4kATErLc30SrA/w+3ms74daFwpbFr2dTGzm9Gurq9M70Z6A6EczsBAnHOOeGG1
         AOsa0lJ7ibKK3l5Xu78dvYtt9o9CLZvB0K8sbOHQK+GZt3KIycUY/ztlWx9sqck6aued
         pdtiQSFeykIOGhiA3lRMBH9k12gxb2lVxChJKb7HdUo6gjgE/DQjqsLcKC8+FHAfa08V
         OOMtUxDrSaUXqJ/xIwUltNsOUnc3lOg/BT0m4IkxTriGb3eWb3iGc+FBXOmKNVzxu3H3
         8itMvnLfEy8ypxAryh4hdOWzjOVKvHLLLOUJCaf0PCQau2JSoshfwWawm1kUUiiTVGiS
         cu2A==
X-Gm-Message-State: AOAM533/+HwCTO12rcltlyxN4FjAIyuPeflZg1q6jJaBoFfzyBWbPXJK
        x6GHgoginpVCsEi1Elg1Q15rhkNzpfzD9S9t71nb9ce1rPXm/c9DSLX2ma2VgE5r2HCG1RklYbw
        LW5WiPUuIFIgKqniaTnKG
X-Received: by 2002:a37:9f51:: with SMTP id i78mr16654513qke.345.1623680399566;
        Mon, 14 Jun 2021 07:19:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/6IEZ+QfVUK02KN9O4bl5mcthGlZiOTp4RNVssZ1tim/l1UA5wkakFDU2Ls8uv4MXDweuxg==
X-Received: by 2002:a37:9f51:: with SMTP id i78mr16654492qke.345.1623680399310;
        Mon, 14 Jun 2021 07:19:59 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([71.161.93.112])
        by smtp.gmail.com with ESMTPSA id w4sm9781676qtv.79.2021.06.14.07.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 07:19:59 -0700 (PDT)
From:   Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.5.4 released.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Message-ID: <c8795653-7728-18a4-93dc-58943ad0fe09@redhat.com>
Date:   Mon, 14 Jun 2021 10:23:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

This release contains a number of bug fixes, man page
updates as well as updates to rpc.gssd that allows
the deamon to recover from thread creation failures
and threads hung in the Kerberos library.

Finally, a couple new flags were added to mountd
that allows the setting of the TTL and tweaks how
messages are logged.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.4/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.5.4

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.5.4/2.5.4-Changelog
or
    http://sourceforge.net/projects/nfs/files/nfs-utils/2.5.4/

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.

