Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38CA1C06AC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2020 21:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgD3ToP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Apr 2020 15:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgD3ToO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Apr 2020 15:44:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C70DC035494
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2020 12:44:13 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b12so2766423ion.8
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2020 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mBq8tSWjKQgsRenscJ+i7RimvOiJyY3Qg7RoQBJa8hs=;
        b=bpj1uK0XyAPTZxumWr9hEJrfBNMRJbtUBCyFEoFVlon3boVPU/KqM2lhPfONo/WCiS
         sU6+xqsP20+qzX1jkRvk48FymtM9jdL5Uajr+Y2Bq+5ry/pVeaFFD25VxichdYFJvjlI
         EC893IQen2N7v0QS9xEIVNfpm15jn2SxlbL8X0r9yEvhSorIapQIwh1qMQT70dvptaVo
         Rvj8QbRMyri9CIDO2q+yLJi+TMXfzjx7l3tGeMP2S2qK2dtvPXZB3fiDLZmt2W3ct+dU
         9K6uFYKxLUAJvs6a1SoghXTRn/H0OtDFbi6ztQRduOEIlDoGJYtrKVKsHWVyctxyeEAJ
         eUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mBq8tSWjKQgsRenscJ+i7RimvOiJyY3Qg7RoQBJa8hs=;
        b=BDpVpee2L0REEQstFb6dSGe9cl6H1z9CHgWQGRwdhnhogegRPmHoZr+O30MsgbCY0S
         0JxkrQRM9JjdaOhD+l1YDjr4GTwkzL1O7ULj6lYL9Zxe5E59DzBnW1ofwjDy06dit2tK
         FsQ1NeL1TpbM0eI+sxDEfLBBuFrr4PDapP8+zfG4mjDJodPDloIi0Ybp7GR6SAI9Glt9
         Kmj81sK+x3hkzVOrjAyeHUXJrA1qC2Z/ZjV5HyLm/LpH6IR5i2LFyFSp3uHQG3xX0aDH
         q78u0Oso4/aAg/38jt1UkSM+5pyCy/vsEt769E++yLLD/LHX9GU47EBW04CQElGxHEO3
         jcRg==
X-Gm-Message-State: AGi0Pua4LOBG1T/QTLPrfJlA5CZTyLuiJizZL6F0azKG+8Y3yDhk9hIW
        S9/9W8c2A6wqATmhPnZFyx0YH1PPIfYl/btllJg=
X-Google-Smtp-Source: APiQypIrwqdzquKEnHyvFWEVS3WL865+rx1DFOQo0AHdvBMeep+GE44S9HDJ/LkdG26zXtKJmcCK87mFgr12cv5B2mM=
X-Received: by 2002:a02:a787:: with SMTP id e7mr3341145jaj.92.1588275852620;
 Thu, 30 Apr 2020 12:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJiE4OnMQE7b7bzj=rnMBZ5xRrzTfHqqgyNOSGguuDFk3G=z1Q@mail.gmail.com>
In-Reply-To: <CAJiE4OnMQE7b7bzj=rnMBZ5xRrzTfHqqgyNOSGguuDFk3G=z1Q@mail.gmail.com>
From:   Ashish Sangwan <ashishsangwan2@gmail.com>
Date:   Fri, 1 May 2020 01:14:01 +0530
Message-ID: <CAOiN93nuAVE+xyC_NYpXX50LRq---tn0mVFVFJP5syEKHhSxzA@mail.gmail.com>
Subject: Re: [Problem] Client discarding data, mount hung.
To:     gaurav gangalwar <gaurav.gangalwar@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 29, 2020 at 5:35 PM gaurav gangalwar
<gaurav.gangalwar@gmail.com> wrote:
>
> I am getting these logs in rpcdebug, client is discarding replies for
> FSINFO and FSSTAT.
> Mount point is not accessible, but I am able to mount and access from oth=
er ips.
>
> C02W91BDHV2R:jita-hang-discard gaurav.gangalwar$ grep "discarded" syslog.=
1
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.783761] RPC:
>  discarded 172 bytes
>
> Apr 28 16:13:09 jita_tester_host_12 kernel: [2345499.393657] RPC:
>  discarded 168 bytes
>
> Apr 28 16:13:16 jita_tester_host_12 kernel: [2345507.216440] RPC:
>  discarded 172 bytes
>
> Apr 28 16:13:44 jita_tester_host_12 kernel: [2345534.412376] RPC:
>  discarded 168 bytes
>
Adding some more information to what Gaurav mentioned:
A quick glance at the code, looks like in xs_tcp_data_recv(),
xs_tcp_read_discard() is called for the entire packet.
That would mean transport->tcp_flags are 0?

But we have seen that the connection is still in ESTABLISHED state:
tcp    0   0 10.41.24.83:973     10.41.24.14:2049    ESTABLISHED -

Not sure how can tcp_flags become 0 for established connection?


>
> I am not sure what could be the reason for discarding, I am using tcp
> as mount option, as per code looks like tcp_flags on transport may not
> be set.
> I am clueless, how to debug, as I couldn=E2=80=99t find any failure in se=
rver
> logs and tcpdump.
> Please let me know how to debug this issue further?
>
> Pasting more log snippet and kernel version
>
> nutanix@jita_tester_host_12:~$ uname -a
>
> Linux jita_tester_host_12 4.15.0-38-generic #41-Ubuntu SMP Wed Oct 10
> 10:59:38 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
>
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782554] RPC:
> 61642 xprt_transmit(72)
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782606] RPC:
>  xs_tcp_send_request(72) =3D 0
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782607] RPC:
> 61642 xmit complete
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782609] RPC:
> 61642 sleep_on(queue "xprt_pending" time 4881255675)
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782610] RPC:
> 61642 added to queue 00000000d869a80a "xprt_pending"
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782611] RPC:
> 61642 setting alarm for 60000 ms
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782612] RPC:
>  wake_up_first(00000000ae52133b "xprt_sending")
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.782613] RPC:
> 61642 sync task going to sleep
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.783719] RPC:
>  xs_data_ready...
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.783759] RPC:
>  xs_tcp_data_recv started
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.783761] RPC:
>  discarded 172 bytes
>
> Apr 28 16:12:16 jita_tester_host_12 kernel: [2345446.783761] RPC:
>  xs_tcp_data_recv done
>
>
>
> Regards,
> Gaurav
