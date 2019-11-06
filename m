Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F150AF1EB8
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2019 20:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfKFT0l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Nov 2019 14:26:41 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33553 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfKFT0l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Nov 2019 14:26:41 -0500
Received: by mail-il1-f196.google.com with SMTP id m5so13693121ilq.0
        for <linux-nfs@vger.kernel.org>; Wed, 06 Nov 2019 11:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spd1-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=pEbuiGRB8DNm/nzmNHz6NLvDxuWJWaVBPWJ6s6P5rzc=;
        b=Kcev8rJ/feMlvNdLM9D9jJyl9ETHN20ReNaiD0OzybO09KK+njcdd2YR71mTHErmdc
         l1cxVKqTnrIkQPHcOP/6MjD4S4C6V2Wy1j2couEY3MdtaGLNSdbyv5kgY++HpL9TYgnc
         +qdofONVD67hFRtnN0ogTNlKCgSQ6sRlDQHbx54bXGNTdogy0ZzxLNttaeq0u16GtawI
         dfwpOTcMeOFeiSQTEqUkhIpb5k0dV4jSRLCS72TWlegunv51NdKzbVWzwxH6vk1J7Wb+
         9eBvXFVTS1AEKLJDpaYH6WSwOoUkYg8yqgRaKsLyPDrW91Qiwdak20qHBgNEFQGhROcZ
         r5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pEbuiGRB8DNm/nzmNHz6NLvDxuWJWaVBPWJ6s6P5rzc=;
        b=bjCvuNq9T3fSrxkJaf45ZDKrlUdSlot2nT77/sduoJZLbMCpJQDir0cUzvMMLuOz/a
         lJ3sQmgzyoGa3qqZVRAiLn5pz7bgsxJfnOt6dXwagEFNgZRHFr9vw+s05xvNHBoMmwgW
         tft6eBglfaPVR9ftlEicXA0L43w8HvgJA6pZC5OmdIIc4FSjUInok8Khub1NJXRLxZJj
         1ebnEtGYp8LbnZL9xJn7yFiqgpjky3e0hIF+faQ5gjsbJy/TdEjv8BP5vfgQ1GfTchTz
         bANqif0PbFo1ykDCXK9yizzHLIbD9Tgq9Nspw5EwYni+JbxFGIzg6l17D9L+lCaMBG7d
         FHXw==
X-Gm-Message-State: APjAAAWdNe9IMRNyR3XSXux9oBWYg1L9jhjnKpsSGh20rnz26s9QVIv4
        grxZTxD3Qgh2nam5btuHD8R+xeG44OiM9DmLnnYHEk2sEBY=
X-Google-Smtp-Source: APXvYqwfj6ZKLn1p3H5Mp8tCSuxDIaTivbQDUeHpDH3u61D7uO4jO+EsUPsyQ5MV3v5aLDTszFA2JIHxqGWwGGYmc9E=
X-Received: by 2002:a92:7e0d:: with SMTP id z13mr4909248ilc.168.1573068399681;
 Wed, 06 Nov 2019 11:26:39 -0800 (PST)
MIME-Version: 1.0
From:   Steve Dainard <sdainard@spd1.com>
Date:   Wed, 6 Nov 2019 11:26:29 -0800
Message-ID: <CAEMJtDsCm8rcjaL60_Ak4AbuhvzL=AXsnWC4mPNi2OH_cVMEFg@mail.gmail.com>
Subject: el7 /proc/fs/nfsd/pool_stats sockets-enqueued = packets-arrived
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

We monitor sockets-enqueued on our NFS el6 servers which gives us an
idea if our servers are being overloaded.

On el7 3.10.0-1062.4.1.el7.x86_64 sockets-enqueued is always =
packets-arrived making it appear that nfs threads are never
immediately available to service requests.

Example output EL7:
/proc/fs/nfsd/pool_stats:
# pool packets-arrived sockets-enqueued threads-woken threads-timedout
0 9919427 9919427 9867288 40774

Thread usage does not move while sockets-enqueued are incrementing:
/proc/net/rpc/nfsd:
...
th 32 0 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000
...

Is this a bug?
