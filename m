Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F013E5AC6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbhHJNO3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 09:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhHJNO3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 09:14:29 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB08C0613D3
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 06:14:07 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 139so698715vkx.0
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=CMTN8P6wL7WpShINueCeSnr8mIS2IIoNzVTxcXCoz/4=;
        b=mF4fPpHby/NhYbbyaiRw0ofuUwlwEqPY4aDxSEpYVgZAP3rNJPZL/7qVzg13hS8Ogl
         uAhK693AhmtONWN8Idwqx7NXUMXj+chUSM13FUgVD7KRHQeTN6q1r0x2eQ8N5nc6cpdA
         6NNQvkW2IwKM5NAE7tvbSr+RJCT0A4ME31eKfRa03j1ISmWw4vgqtAV3Zj6B8Axykl/K
         rpNOMOS5ohOqrgz+tCvCKxkdE3DhbiSVurJzWrmG6YWDyRX1yX2ee/ex4wP9g5tUugus
         Hcvvbx3Eqc8sDOCBVy78AXfAPksQDR5SUa96gqMVYgg84IDcXmAiDOdB6TAkzVJdmEVz
         eCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CMTN8P6wL7WpShINueCeSnr8mIS2IIoNzVTxcXCoz/4=;
        b=ZnqN61kO2wofYu2mwsJmSJ1kQ71itwqRDNRVDhbLKx7K5/UX604Ib7GCfdrNf6D1CP
         NRDbhzqBf2tiuWMT2fTuOw9ZHKJMoF2Mash79LmZcV/pafghCN8ikz0NeJXkmbgzDSMG
         YtpTvKPqBjQI/1VDl8T7W0bdTpeJfW7amVAGcRlnjQmRpMhmZptNsyHneDCrpoOJOuih
         YgqNyhe6nSXYTDkTuV30C6oUrF6xeA8zrXGaC0RrFqBaOaEEIfUjGnabjGQXTboittvo
         YWYEqwt0aweXckysEL7VbMV/TNT4Dk5G7MmW3OO0BQJstqTpXUCihWG0xcsKqGTgSqnK
         kLEQ==
X-Gm-Message-State: AOAM531cXW03t05o12UuQqc/ZD0FHmeUnYOIatqv8XyejcTw3tn8VjEu
        ghyhLoJkyCYIrTvIYNr8cWGgBz2ddeEmcYwGrbdhpbHK4Hg=
X-Google-Smtp-Source: ABdhPJzHWMnVM1b1VqWniZH9g5T5domHZcArNTWevy9lPeNI4zZft5R4YjtLX1hVNfBDI4ReVzKdPazhzETVLHwW7Co=
X-Received: by 2002:a1f:d943:: with SMTP id q64mr18140809vkg.23.1628601246618;
 Tue, 10 Aug 2021 06:14:06 -0700 (PDT)
MIME-Version: 1.0
From:   mhnx <morphinwithyou@gmail.com>
Date:   Tue, 10 Aug 2021 16:13:55 +0300
Message-ID: <CAE-AtHqLDWaggTrPb-3BsobfEgOXtGCQrs9Uw4Ywai_K1bhpcw@mail.gmail.com>
Subject: NFS shares suddenly becomes unresponsive
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello

I have a weird problem. I'm using libnfs 3.0.0-2 and nfs-utils 2.3.3-1
on arch-linux.

Sometimes nfs exports are becomes unresponsive and can not mount any
export and mounted clients can not read and write to mounted shares.
Also showmount -e $nfsserver gives an empty list. When I restart the
nfs-server everything goes back to normal.

I only see one error in logs and I'm not sure this is related to this
problem because problem not occurs after this log everytime but mostly
when it happens I see only this log.

nfsd: peername failed (err 107)!

I have 30++ exports and high client usage. Clients are very differ;
linux, windows and datastore. BTW: I have a strong server. 20core, x2
socket and a bunch of free rams, 2x 40G lacp network.

My nfs.conf only has an open line which is "threads=128"

What should I do?
