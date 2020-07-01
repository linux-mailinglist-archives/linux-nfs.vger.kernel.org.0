Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCBD210129
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 02:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgGAAz3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jun 2020 20:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGAAz2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Jun 2020 20:55:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385BEC061755
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2020 17:55:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f7so19026026wrw.1
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2020 17:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=w5fiJW6n3sAfYyHmixvuwkB+kRXMBP2micRtspTnPKM=;
        b=sJPyZ4EtLJLajdteuRpipuX/VbUcHLIe55XzDT4YielPuQGcxZkXZ7sTuwXIijWR+E
         njXXmgnUnk1dOnZFtDmavEniH9d83fobGBwn+VCeLnEYetsTGa/USvs6TnVMcFoBlptM
         LccEch4gcsdqO/tD7gF/annqoPXvjmsLQqYQlcjAB2ctvfBxi2BlzLIfctr9mfLShTQw
         nOW+GpRTeUakIh6hBEYGmL8x8hGrbVC5GNwI6LWs+RzP7mTX4dp3sM+JMw33Fh1gAVDP
         qY2zDZ4AFdbhvNBlZb7nHPXU61XVQLoWSTvN1Bknj102anCWfMSWLgWl0/9yvFm1fN7N
         VWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w5fiJW6n3sAfYyHmixvuwkB+kRXMBP2micRtspTnPKM=;
        b=X/gAJGZd7TQhSrH+K9lP1FtN6r1fOguK0rMXJuRjYuITgRb14tKTIH7/EyQKd0N5sn
         dzlPvEeDvc4kJXcqoydIybfuTV/8kBAi6yJaDE+n+Lw4nBLg36LPtjxgJYtNDj6XHM1A
         kEhlcn+uiPRBgax4Q7UQMsCeonIfQswomYot9DqKeKQPPl0yi2MGFk1FRdPlsDg/OPEs
         5UOS4Kr/B3kNM8nTm6FXx+LHuVNBJuYJ5CCsUnwkp/0Q0kRajPq+vH61WAo5Z8tC/KB/
         aI1nEYIlS3iGSX3STktmRPiH9Ky+V5CYy0B1RDIhVnstev7Fgz2yJUGs5UTIWF7DbIXe
         T/Ow==
X-Gm-Message-State: AOAM531olOeFbx/98d87hLSwCHrDNvXNSsaAu0WiPC2zgsLCOhVK2Lxj
        r4cHcQykWkbNL2eymfDkF3f9mn3yNUsDvV4UQaOUeAWT
X-Google-Smtp-Source: ABdhPJwGDF8I3LedpBhcMVk1OsGzEH91iRmABTVr+zVDCZPS4VmLw/6zHMHcUQsuDYXE3ejbRTfyGh3WUXNrDMarI2Q=
X-Received: by 2002:a5d:6088:: with SMTP id w8mr23567575wrt.49.1593564926547;
 Tue, 30 Jun 2020 17:55:26 -0700 (PDT)
MIME-Version: 1.0
From:   Pradeep <pradeep.thomas@gmail.com>
Date:   Tue, 30 Jun 2020 17:55:15 -0700
Message-ID: <CAD8zhTBCEbOkA_jFzzDXcd0jiH9ZgUh1KUJAJzhnWFMC+JGjNA@mail.gmail.com>
Subject: File create performance between NFSv3 and NFSv4.
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

While testing a performance issue, I noticed that the number of
creates that an NFS client can do over NFSv4 is significantly lower
compared to NFSv3. I'm using the test below:

https://github.com/distributed-system-analysis/smallfile

Command run:
smallfile_cli.py  --operation create --threads 128 --file-size 1
--files 1024 --top <nfs-dir>
[ 128 threads, each doing 1024 file creates of 1K size]

This gives around 1169 creates/sec with NFSv4.1 and 8073 creates/sec
with NFSv3. This is with the exact same client and server. NFS server
is tuned to use 200 threads.

When I looked at tcpdump, I noticed that over NFSv3 multiple parallel
requests are being sent and NFSv4 is pretty much serial. Is there
anything that I can tune to improve NFSv4 performance w.r.t to file
creations?

This also shows up in benchmarks like SpecFS SWBUILD's INIT phase
where millions of files are getting created.

Thanks,
Pradeep
