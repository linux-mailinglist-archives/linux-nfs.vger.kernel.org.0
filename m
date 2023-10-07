Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313EA7BC6FB
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Oct 2023 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbjJGLDC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Oct 2023 07:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbjJGLDB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Oct 2023 07:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66B983
        for <linux-nfs@vger.kernel.org>; Sat,  7 Oct 2023 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696676535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2jCIAVh0LUnn+BmfQudSRXJ9BYeUQifLuOZ51br33WE=;
        b=HKMzweO0MXzbGrH4ovgYtU7BtxQpvXR/nXsbTsStBRQSksuyuFviMNCMFKQAQi0MECei+b
        K4pl/8xxS+EH8wu6pxmhoTxWityqBrnl5+L9S7c7stQ5IB36u2YYt7283fjsZnl/XE79dI
        lU8/WmqusP0bE97fl806qPWKfxA1Ah4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-1eUd5RGHOzyzE57ha3XNFg-1; Sat, 07 Oct 2023 07:02:05 -0400
X-MC-Unique: 1eUd5RGHOzyzE57ha3XNFg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-59f530248a6so6979447b3.0
        for <linux-nfs@vger.kernel.org>; Sat, 07 Oct 2023 04:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696676524; x=1697281324;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2jCIAVh0LUnn+BmfQudSRXJ9BYeUQifLuOZ51br33WE=;
        b=BH7kOf137d35W8Fw1dvhE5Ja1/4kMk0mrpMov/rdkGD6319WAKNUiHv4JrOpYaDAzw
         eymAZaYuoUQTnYmwwvRbasIHdYcOcV9VsIaO0QBQfUUgjatnSj9Ksia1mRJaYx95T5IL
         VSWvX4Ig/H71isbz2r+lGfe3HkafXm3kOx+0oHXLDepdn4l+joMMA88ycwrCsTp2vMMM
         +amPBYiaXgr1xkwrhv1d+qH7DgRa32fv+IGtj072GskjmK4j8WldVOgML2RhW8hVUMeq
         mtAObU4YOnKME++0SHP4VTh/N9YSaG5cdVPoY4gdplPVDdtzzSm6LVWjH7VDejIGFnba
         ykgQ==
X-Gm-Message-State: AOJu0Yy+6TQjeId/Cjjez9875wZiypdiiqrkkpokOhNfV6wiRZ1baJF6
        9R2dsJdd44BkXGbypoZvvScVhuynnezggB9cmEH4DooCcC0YxWzkfPSg3yELSpmPmE6PwYI2eC+
        rx2uvCUkA11fjYgqvuHQA
X-Received: by 2002:a0d:d8c6:0:b0:583:cf8d:bc0e with SMTP id a189-20020a0dd8c6000000b00583cf8dbc0emr9450445ywe.5.1696676524754;
        Sat, 07 Oct 2023 04:02:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4yVVakPuI1rvkPqjPjA4V9xUcF+teGSVhNmh5I74zxty0ofF5DxAwn7fYvwPEUH85qXhK+g==
X-Received: by 2002:a0d:d8c6:0:b0:583:cf8d:bc0e with SMTP id a189-20020a0dd8c6000000b00583cf8dbc0emr9450431ywe.5.1696676524465;
        Sat, 07 Oct 2023 04:02:04 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.164.53])
        by smtp.gmail.com with ESMTPSA id d1-20020ac851c1000000b004197d6d97c4sm1976472qtn.24.2023.10.07.04.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 04:02:04 -0700 (PDT)
Message-ID: <18277b6d-f38b-4201-a92e-de843401ce2a@redhat.com>
Date:   Sat, 7 Oct 2023 07:02:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: libtirpc-1.3.4 released.
To:     libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

In this release some memory management issues were fix
as well as better error detecting. Finally code was
added to honor reserve ports in ip_local_reserved_ports.

The tarball:

http://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.4/libtirpc-1.3.4.tar.bz2

Release notes:

http://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.4/Release-1.3.4.txt

The git tree is at:
    git://linux-nfs.org/~steved/libtirpc

steved.

