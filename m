Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4240E41E58
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 09:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436646AbfFLHzL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 03:55:11 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:33522 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407657AbfFLHzK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jun 2019 03:55:10 -0400
Received: by mail-pl1-f178.google.com with SMTP id c14so14982plo.0
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2019 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=4pkbh9VHHra7RLHot+OJBI/nZ7dvpr9A9udrrVHGQNA=;
        b=TvulknlB6D7LpUYU1L4+vjs7GoVtltEXKx0VK6DDUu8H0g4HwLFxr18kaxj3Gn2mrn
         1gU93ghvGvtrVlCZOVskTRYjOtgKSnXqRbNcfohRT/TxeTdHmX17UisW+otUaYgZrAtw
         CVqJT+5se2zmsiOsfN3cdoI7ElT5FUXht4YGxaaLrkGIrQPSKzqT1lVgiQ3zHDRuZ9v3
         OI1tSscolhzLIYbWI2GamMUjOv8gGKUO+q161B8NG8plQ/oLcc40JKYLqDbGsWDvHgGA
         KCkZ0TMMMNZgKS01AkPr3KmQFPXM8KaafCt1Q7F+k1ZtGbvk2DzhXhhEns2J9m25ZSmK
         pZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=4pkbh9VHHra7RLHot+OJBI/nZ7dvpr9A9udrrVHGQNA=;
        b=f13oNCGnr4qZpIgP2cB+YAeIIoVK3ukXBcBEbc81WdXF7vJ0a4rfXzAlqYYpFDvMyr
         bBHYPLu12yZafFaoHrqUM0xGZY1BUl+f0ZoO9QIzWEd+xgQ8G2dSVrI3tt+5TfcXbfuc
         Y+nW/AoSzFvlthiBKdEHPhmEfQRMFj3rki/qRNu/kfx0umxNqxNva0dERVfOVI8hxkfC
         KXFiAre2VHveB05X8C66WCNrnTwOhdnEbLHL0RCyLh7uBso82jxH5RgU3R1cSXiKTjjX
         kl9iG8kLxZkQKjRhmMNmJ2TtmcfBBZUUqbnZH64UPvWWcR0sN9Ouj6kQvL7FKJv6Rz3e
         hVAw==
X-Gm-Message-State: APjAAAWWaxUAxF+NHu4jLLhFBrMLL+4O+cTMGAdIWFqrFXY8FgEnF3+h
        yBEn8jTRg7yb/5Z1p56OL5CWQiWU
X-Google-Smtp-Source: APXvYqzvX/MWJeq+AM+ciU8BGwy5I3jia7qyT26zCVEW6Y7hOvUjIsc5m2yeg5R1iU/ZHSLHZe7Ypw==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr18474112pla.5.1560326109585;
        Wed, 12 Jun 2019 00:55:09 -0700 (PDT)
Received: from [0.0.0.0] ([47.244.216.228])
        by smtp.gmail.com with ESMTPSA id b26sm14014367pfo.129.2019.06.12.00.55.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 00:55:09 -0700 (PDT)
To:     linux-nfs@vger.kernel.org
From:   Jianchao Wang <jianchao.wan9@gmail.com>
Subject: Can we setup pNFS with multiple DSs ?
Message-ID: <71d00ed4-78b8-cefb-4245-99f3e53e5d2a@gmail.com>
Date:   Wed, 12 Jun 2019 15:55:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi

I'm trying to setup a pNFS experiment environment.
And this is what I have got, 
VM-0 (DS)      running a iscsi target
VM-1 (MS)      initiator, mount a XFS on the device, and export it by NFS with pnfs option
VM-2 (Client)  initiator, but not mount, running a blkmapd
               mount the shared directory of VM-1 by NFS

And it semes to work well as the mountstatus
            LAYOUTGET: 14 14 0 3472 2744 1 1381 1384
	GETDEVICEINFO: 1 1 0 196 148 0 5 5
	 LAYOUTCOMMIT: 8 8 0 2352 1368 0 1256 1257

The kernel version I use is 4.18.19.

And would anyone please help to clarify following questions ?
1. Can I involve multiple DSs here ?
2. Is this stable enough to use in production ? How about earlier version, for example 4.14 ?

Many thanks in advance
Jianchao







