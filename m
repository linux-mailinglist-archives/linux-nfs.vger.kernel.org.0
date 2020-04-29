Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06651BDB4D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 14:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgD2MDQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Apr 2020 08:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgD2MDP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Apr 2020 08:03:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3169CC03C1AD
        for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2020 05:03:15 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w20so2352337ljj.0
        for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2020 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qahp3iAZwIJGWwgqOB8C8znd2GCfzFnf0HdXDuS25Yc=;
        b=A18CgSuzl1wYXhJPwC5bbEtxiqcbC0xUsN1MbHIKKsqLIlvHEHLYMVI6E1n5YUXLDX
         jObspzUZq3QWfSBFAXMHSY+cqDZwG3iKMHTCQgwV8qGECPra5K0tlsyNFrK9E3qc+Wbk
         d/juPEEQDFxqlwjkI0r2nrcHFIpxTWqWoo65RUg4JY4A9FuJ4uS0g1c2rntc3TnATGfM
         9yUUxgFVy386hksWSy5HA3xBLl3Et1vumYG0zwhT7sIKljBmYSNAICc0LNYMQVKxGSbO
         ch7Njr2XfRF8gpMn/kvNZKvT1b55/gbEckyUW+aY++mxtOLEGF0ABOSb0ZiGdzof5LIJ
         UDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qahp3iAZwIJGWwgqOB8C8znd2GCfzFnf0HdXDuS25Yc=;
        b=S/gX9ruzsfl4c71R5dpXYcY0UKlip5nj0jwizlMT7R2gzFPqh40ex36jnRohMUDskH
         dMaqAjH5AH0/0iXHDJv/rrhAddEBKcBagRvbjzV2719S1los5POdY6ix92G3aDZJk05R
         UFjZKg2muB5dviKZDRdbcKa1jP1jU3QjOLEAU9SzBzetjOisPv0t4fbWemEA1OV4a45R
         /J17FgLL7jz79M5XNUpj+fR9GkK7xDol/6+WCOq39IjIaAljZKJxLbKc0i72ZZNMZJU/
         qJzmETBdPUe267Pu5m6g/BmcqMvwV2J7/B+Br5JUtN1jpPZaBFdDKC8CYxV9DxPeZ8Sh
         1TBg==
X-Gm-Message-State: AGi0PuY273Q8lIYC0nRqGtqe/UkYZJuh6U1Y490Bx28D/pJBlVyCjISF
        Cbsbt/w2p/sdIz7vn4iyKfr5rizS912BC7HcTQhefXof
X-Google-Smtp-Source: APiQypIzXXwAiQGqx73un+JDbvgsFiSGhMTvrvyt/eGuNmIKXb6GDoJ8zs4/xNAUli9wny17iFMI+wcYRXFiLflXvB4=
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr21354433ljk.134.1588161788619;
 Wed, 29 Apr 2020 05:03:08 -0700 (PDT)
MIME-Version: 1.0
From:   gaurav gangalwar <gaurav.gangalwar@gmail.com>
Date:   Wed, 29 Apr 2020 17:32:57 +0530
Message-ID: <CAJiE4OnMQE7b7bzj=rnMBZ5xRrzTfHqqgyNOSGguuDFk3G=z1Q@mail.gmail.com>
Subject: [Problem] Client discarding data, mount hung.
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I am getting these logs in rpcdebug, client is discarding replies for
FSINFO and FSSTAT.
Mount point is not accessible, but I am able to mount and access from other=
 ips.

C02W91BDHV2R:jita-hang-discard gaurav.gangalwar$ grep "discarded" syslog.1

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.783761] RPC:
 discarded 172 bytes

Apr 28 16:13:09 jita_tester_host_12 kernel: [2345499.393657] RPC:
 discarded 168 bytes

Apr 28 16:13:16 jita_tester_host_12 kernel: [2345507.216440] RPC:
 discarded 172 bytes

Apr 28 16:13:44 jita_tester_host_12 kernel: [2345534.412376] RPC:
 discarded 168 bytes


I am not sure what could be the reason for discarding, I am using tcp
as mount option, as per code looks like tcp_flags on transport may not
be set.
I am clueless, how to debug, as I couldn=E2=80=99t find any failure in serv=
er
logs and tcpdump.
Please let me know how to debug this issue further?

Pasting more log snippet and kernel version

nutanix@jita_tester_host_12:~$ uname -a

Linux jita_tester_host_12 4.15.0-38-generic #41-Ubuntu SMP Wed Oct 10
10:59:38 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux


Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782554] RPC:
61642 xprt_transmit(72)

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782606] RPC:
 xs_tcp_send_request(72) =3D 0

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782607] RPC:
61642 xmit complete

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782609] RPC:
61642 sleep_on(queue "xprt_pending" time 4881255675)

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782610] RPC:
61642 added to queue 00000000d869a80a "xprt_pending"

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782611] RPC:
61642 setting alarm for 60000 ms

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782612] RPC:
 wake_up_first(00000000ae52133b "xprt_sending")

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782613] RPC:
61642 sync task going to sleep

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.783719] RPC:
 xs_data_ready...

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.783759] RPC:
 xs_tcp_data_recv started

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.783761] RPC:
 discarded 172 bytes

Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.783761] RPC:
 xs_tcp_data_recv done



Regards,
Gaurav
