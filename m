Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D87F487798
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 13:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiAGM0q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jan 2022 07:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiAGM0q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 07:26:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA1C061212
        for <linux-nfs@vger.kernel.org>; Fri,  7 Jan 2022 04:26:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z9so21433250edm.10
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jan 2022 04:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=jsU3SSUo8r6yYxjmEqMQ9dwixM8I3+71bek2ZCdoTT0=;
        b=dtiNIYWpPJDH9HhhAXH8XwVI7D3XKfJohUMwuPkKejNhDK3CtuJZF2O6lSZW7qOTXT
         ZG7FhZL1JTHyFrYXEDd+P4yFwPpkOILruIs8qiA3c+GPaPJJ8dblLs0YK4hsCQ1ER7qx
         eethBdnOdX+OBOsOS9KBYxQ61KK3NWkROLLKosePh0mfUOSf96pd3GDjhWnbKHl07MeT
         jC6PXu6oojYZ9SSI6hB8Zj0HCuD3e8nCFRmBmrMu7oe1gUCw1x90zU2xOpV7uYvw1QSP
         IZaSJD+eMR4Ed514AFWXHWa7kdBpoKTd1Q/dHKjr8fO+y08OT8CidY8ZsVIHqbLcO9eb
         wsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jsU3SSUo8r6yYxjmEqMQ9dwixM8I3+71bek2ZCdoTT0=;
        b=1BKZBNzW5HWZ7eYadr36uDbIyLLH3+YahTUTcIQKpajll7fNAgzpuOycKRo0t3F81i
         QWLgSatT75axJwqXNtwanw4NBtpAbvxdWd7B2mQLMSW4GHk7ih5OzwI8DoOv2yrvCIwJ
         mowJzisaDQgdsTEBnSALiAruL6Id72wcGdviDNiwAZAexxt5qUJq6sCehRzweJdrV1nh
         sryEDUk+Ud2Yp/KnaIkCcdp/a5sK1kCn06dnjuWhMdYVdoHKTM8KP6CMFeLFib9KweLX
         iHicrV98zXWPQA6kukpIpnNXnC7JD7eYsj5rLU7lgERbxeSsGc1Sd18epWx/4hkY0esa
         cHjw==
X-Gm-Message-State: AOAM5301dudxSbNSsSnIfIN2QCty71iyGDz1fKjor+bYorVCW1ifJnyz
        ciUcz7qCicOTBsq3intdp4MpH189Ed8kq3NqJuZD2iP+1bzp7TDU
X-Google-Smtp-Source: ABdhPJxl+MxtQXRXOKLItEDuvVr8uLPocDE52yQM/6SlEfFiHmV9Hfh+3BpYWEbq+Z6X/X4ME7JuECpvejVnxoU8+Og=
X-Received: by 2002:a17:907:9809:: with SMTP id ji9mr41700314ejc.539.1641558403728;
 Fri, 07 Jan 2022 04:26:43 -0800 (PST)
MIME-Version: 1.0
From:   Daire Byrne <daire@dneg.com>
Date:   Fri, 7 Jan 2022 12:26:07 +0000
Message-ID: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
Subject: nconnect & repeating BIND_CONN_TO_SESSION?
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I have been playing around with NFSv4.2 over very high latency
networks (200ms - nocto,actimeo=3600,nconnect) and I noticed that
lookups were much slower than expected.

Looking at a normal stat, at first with simple workloads, I see the
expected LOOKUP/ACCESS pairs for each directory and file in a path.
But after some period of time and with extra load on the client host
(I am also re-exporting these mounts but I don't think that's
relevant), I start to see a BIND_CONN_TO_SESSION call for every
nconnect connection before every LOOKUP & ACCESS. In the case of a
high latency network, these extra roundtrips kill performance.

I am using nconnect because it has some clear performance benefits
when doing sequential reads and writes over high latency connections.
If I use nconnect=16 then I end up with an extra 16
BIND_CONN_TO_SESSION roundtrips before every operation. And once it
gets into this state, there seems to be no way to stop it.

Now this client is actually mounting ~22 servers all with nconnect and
if I reduce the nconnect for all of them to "8" then I am less likely
to see these repeating BIND_CONN_TO_SESSION calls (although I still
see some). If I reduce the nconnect for each mount to 4, then I don't
see the BIND_CONN_TO_SESSION appear (yet) with our workloads. So I'm
wondering if there is some limit like the number of client mounts of
unique server (22) times the total number of TCP connections to each?
So in this case 22 servers x nconnect=8 = 176 client connections.

Or are there some sequence errors that trigger a BIND_CONN_TO_SESSION
and increasing the number of nconnect threads increases the chances of
triggering it? The remote servers are a mix of RHEL7 and RHEL8 and
seem to show the same behaviour.

I tried watching the rpcdebug stream but I'll admit I wasn't really
sure what to look for. I see the same thing on a bunch of recent
kernels (I've only tested from 5.12 upwards). This has probably been
happening for our workloads for quite some time but it's only when the
latency became so large that I noticed all these extra round trips.

Any pointers as to why this might be happening?

Cheers,

Daire
