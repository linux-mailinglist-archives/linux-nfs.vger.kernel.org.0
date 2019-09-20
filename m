Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C417CB8E3A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 12:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbfITKEs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Sep 2019 06:04:48 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37294 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393385AbfITKEs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Sep 2019 06:04:48 -0400
Received: by mail-wr1-f41.google.com with SMTP id i1so6125399wro.4
        for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2019 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uTZxGQ78P7KhZVbZZi6L74Ld9LI/dh/LCCq39qoJxh0=;
        b=hJiXwCjx9WaO5eaSmUgVfe/UxEaWQR6/quY5o3xlQTKxGaCkOD+97Ts6OybgScXsL+
         KB2e0v3EIxiEMmSHlw5f85mcP4yyyiIAnjsQhP9KqF92bu5bn+Xcmo2wp3Bwf0dmfv1o
         vOHnm2bb5r9/uLXhF1fKylBEVER5y5UxwukWBTbGG2qcyiySa3rDi86hT4dtwu4wwJ7B
         koh1BJSJTfgNi1fbyAWZa2K1B90RPfieRg9U3dcMuwxm9evnRC7mGp817VgTKDQfkTwK
         kHqVBZEzsHHxxdsgdg/JAQNb8F0iZI53sQEny+zxgTIoAuv+5MLbSZSdtB+C3iR8W8iI
         3VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uTZxGQ78P7KhZVbZZi6L74Ld9LI/dh/LCCq39qoJxh0=;
        b=Ka9jz3cbFcRQDw/Vq0N/COWH4TbdOHMVwiHuUojXhJXTFGCRgp6aUH9GbHz93Dr5rT
         hh6s6Kemij3EA4qB/wregZKNyVKgBRY5sxiBKMGNA9FFW+OMuZBM4zSKs6ZJHKUOnXup
         lb6qEdnnXXWDHuFPU8JTxtfJQ3YXSbF9FbcQXcte5eM0UR/sSVN7KvnfiSD7zvxotyQ4
         ezYdGVc69cIK2PcISCx9xOGWS3ki3i7mMTV4a2p5YUqMwjvdW7ZtPZNFQ8kSKxVU5/S0
         CnzPBHEJ3BMfZEul8NrHzVTLWmRS7WGhSO1Qi0G6tNKzMBy+Hf8OBXkzVf24LvSdnqn5
         sYNQ==
X-Gm-Message-State: APjAAAXqR+ikfvf/GJJEH+SKr78yHSxygHlxyhkmXLIItPT94RStBCvD
        8qhS3o+Z+0zI7EQCzjjsEubJME5d
X-Google-Smtp-Source: APXvYqztCRaBXnwo9Qky8VeZdyseh8w+f47j684QoZ5KczaVGfg6MMVgQ6M1INYyIwMKvi3OHI1B7Q==
X-Received: by 2002:adf:ce86:: with SMTP id r6mr10907267wrn.57.1568973884807;
        Fri, 20 Sep 2019 03:04:44 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id 189sm2263748wma.6.2019.09.20.03.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 03:04:44 -0700 (PDT)
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
From:   Alkis Georgopoulos <alkisg@gmail.com>
To:     Trond Myklebust <trondmy@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
 <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
 <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
 <e51876b8c2540521c8141ba11b11556d22bde20b.camel@hammerspace.com>
 <915fa536-c992-3b77-505e-829c4d049b02@gmail.com>
 <1d5f6643330afd2c04350006ad2a60e83aebb59d.camel@hammerspace.com>
 <5601db40-ee2f-262d-7d01-5c589c9a07eb@gmail.com>
 <d7ea48b4cd665eced45783bf94d6b1ff1f211960.camel@hammerspace.com>
 <20190919211912.GA21865@cosmos.ssec.wisc.edu>
 <503c22ad34b3f3a15015b7384bcad469b2899cb4.camel@hammerspace.com>
 <20190919221601.GA30751@cosmos.ssec.wisc.edu>
 <0213704b-3930-5be6-bd3d-dbaabc24a270@gmail.com>
 <1e7c9896-eb1b-9d7c-fff0-6df2b3d96392@gmail.com>
Message-ID: <6fa596e9-b154-310e-9685-7663731618ba@gmail.com>
Date:   Fri, 20 Sep 2019 13:04:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1e7c9896-eb1b-9d7c-fff0-6df2b3d96392@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/20/19 12:48 PM, Alkis Georgopoulos wrote:
> I did test the boot bandwidth (I mean how many MB were transferred).
> On ext4-over-NFS, with tmpfs-and-overlayfs to make root writable:


I also tested with the kernel netbooting default of rsize=4K to compare.
All on 100 Mbps, tcp,timeo=600:

| rsize | MB to boot | sec to boot |
|-------|------------|-------------|
|   1M  |    1250    |     84      |
|  32K  |     471    |     40      |
|   4K  |     320    |     31      |
|   2K  |     355    |     34      |

It appears matching rsize=cluster size=4K gives the best results.

Thank you,
Alkis Georgopoulos
