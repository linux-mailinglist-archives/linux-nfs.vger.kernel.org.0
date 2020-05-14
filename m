Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45181D2C99
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2020 12:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgENK0o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 May 2020 06:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgENK0n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 May 2020 06:26:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BDFC061A0C
        for <linux-nfs@vger.kernel.org>; Thu, 14 May 2020 03:26:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f6so1087938pgm.1
        for <linux-nfs@vger.kernel.org>; Thu, 14 May 2020 03:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=F/AuceWv1rF5Dq0GrZElQ2Gk8jkt6NdP+z8rO7F9owk=;
        b=h6Gnw9S4dFldcQwrsdThMnZN3p9N4VPz713kgCFGrlxgCNcRNlQ+ziYH/1+RbochFv
         PfhX2oPWZ1p2OpHxqwRsNnHzmD7YXBaYDE4vkzN5Cn8KvsMIiNZwzNJwKvyvLL+xYb0u
         2PZzSRxP1DVnWB9pndMJgg3LGmiMvm+qAjRY9Q0mM9P49EQmyn5hlGH/Cl8VhdFN4CZ+
         v/LL0OIrP3XzjuiNDTykRRWX3rHimWUBr9AQb4GIvT0bxrhrnMXSddzz1iGP3p2rXCVU
         zk0+2aC9kPWjd+OMBoxaah9PbtbROUJw/svHOL4wjyyPM+GlsWNfZlTIxewlxOPFnYYo
         1yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=F/AuceWv1rF5Dq0GrZElQ2Gk8jkt6NdP+z8rO7F9owk=;
        b=hevDuJKCw+PHQPen2sdSNNMaCISChvlQqViN/gAJcDOhDXBvHeriRsrrz2PnxWBrPq
         T8JmaqDXPGekKA7wU6S2FXFZb+oR7BrRuHC2zqkeilxB28/orGVwd4mQOH3BSAAPu6fL
         deqmLVBPUD/eNXGbnXflBBX6RMpgRFoeM8v536W/OC1Lw/xynbq697Wd+Q3yNP7nTLrF
         TPnaQNe0abOhrWEnY0s8cLEUD3Z/xrA9xOpbh9tbYdfJMsJVa2h91p6ul7UVN7CuB6Mn
         986HV6207Xou+Y8LS/vV8vGZ+zc11IcTH/yTDgYU6oxsE2uou24zL4/zoF69In8RhtyT
         uBuQ==
X-Gm-Message-State: AOAM5307OTcW7dt2sw+6jy4p8mhei9AgPHiPQLg2It+d7RgDrcld04xV
        5Eg9cF3OS0E3W8G7V2k9pUHGUs/rclI8pb2eDoln6f54d9bMeA==
X-Google-Smtp-Source: ABdhPJz0nN9BbpX5JiBI30dyJRwp90NUsSRKmFdScymSZlRhXNd9GDRk8jN5Kvjm3wNcfnZFt7Kq3z3fNBITWxTcrXo=
X-Received: by 2002:a62:3442:: with SMTP id b63mr2291000pfa.137.1589452001410;
 Thu, 14 May 2020 03:26:41 -0700 (PDT)
MIME-Version: 1.0
From:   sea you <seayou@gmail.com>
Date:   Thu, 14 May 2020 12:26:30 +0200
Message-ID: <CAL9i7GFmOOCWoOnGuDORCCHonFE7siUxSvAvP4TpWX5+CR601g@mail.gmail.com>
Subject: Kernel panic in laundromat_main on 5.3.0-46-generic (Ubuntu HWE)
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

Today we've seen a kernel panic that looks like related to delegations
and laundromat

...
[1388051.959652] Call Trace:
[1388051.959984]  unhash_delegation_locked+0x39/0xa0 [nfsd]
[1388051.960631]  laundromat_main+0x235/0x5a0 [nfsd]
[1388051.961234]  process_one_work+0x1fd/0x3f0
[1388051.961803]  worker_thread+0x34/0x410
[1388051.962281]  kthread+0x121/0x140
[1388051.962698]  ? process_one_work+0x3f0/0x3f0
[1388051.963210]  ? kthread_park+0xb0/0xb0
[1388051.963690]  ret_from_fork+0x22/0x40
....

In the link below you'll find what has been captured from the console.

https://pastebin.com/raw/CdpMfUAK

I couldn't really find any reference to this in the mailing list
history so I assume we might have hit a bug that is unknown so far.

Best regards,
Doma
