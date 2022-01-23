Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2FD497660
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 00:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiAWXxq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 18:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbiAWXxp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 18:53:45 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C198C06173B
        for <linux-nfs@vger.kernel.org>; Sun, 23 Jan 2022 15:53:45 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id j2so16548893ejk.6
        for <linux-nfs@vger.kernel.org>; Sun, 23 Jan 2022 15:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=CqdUdHVN6E6ZceBwT8KM9D1xekkTzH22IAWcjML3lo4=;
        b=MfxAoSSEppfflqtF6mj50qRNFD1QGIxEmYe6m9OeJ7WcU6uwZcttw9piDy5cvjY+1H
         kNB04gn9Hwh53wDVYHjroJX8zXncsIQTz0bQqlMh5jIEQM9PUdEPiYw6pTF6Rn1Q0IMf
         fvIkZcGX+KTZQyTab0h9ZoXSdRVP9dgaUFtUx98Qw2OYT+ynGJ6xA+q3crUfnhJeOM7Q
         DKsV4SLNWfoHVF3NAx7ilV76TDpSjgh3hFBaHyBTNILqENDnDZRCj3fIm89dLMJyyMFd
         H2BH64okZ37oKzJEVA5RADzDh3Z9THGOdIIFgHQ10frq8piy3yij4bxv9x1v9T1tzrDY
         Y0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CqdUdHVN6E6ZceBwT8KM9D1xekkTzH22IAWcjML3lo4=;
        b=OCN5PojQwNmUXMS/BtPMgnQrSn4hGrEsONvhRIQG8pgzPFa+EqEHePji3dqXzd+S46
         KX5BbFVG4yq1K8kWnWSGNq9A3lU2tqyw8A14kJFNCUoiFFur2qKzbk30NZ8A4wRZzQhB
         wzT3FM3wYMCNwa8RZUHlpJiUrgaCn/CnJnC4/N04B8lit2OECYFUGxkDLXTHi4xokoZH
         PnJT/IB3IRJRAleRsR2RGi1LeHl478N2hcwzFdfPL1NU8G6Goi98pG43zry7CF6mUgWb
         Q7wmtvs1OVSgYr2Mnw70IiHZZ9RDCfspT/mrQZH9HH2TxBtbSg7Fgxgyz8nElaSLcZe9
         mHAg==
X-Gm-Message-State: AOAM532n+RbxsmUBF0/ns2co0jLISxuWE/GznlEv0Sj2GrOo4VrQ77ZN
        PyJEIPyY9BR+vcgEcoGvPPgZ2bpPg9QiKfWEdWisegiXFVAR2/CG
X-Google-Smtp-Source: ABdhPJwzmjl54FzRukV8otwJ09bfepYLL7C4zvNTPPzMNi2A9g+YfMKmcPX2IISTpAci3Oto9hOqdRFoxtRrMgCUjZY=
X-Received: by 2002:a17:906:3819:: with SMTP id v25mr10434795ejc.539.1642982023951;
 Sun, 23 Jan 2022 15:53:43 -0800 (PST)
MIME-Version: 1.0
From:   Daire Byrne <daire@dneg.com>
Date:   Sun, 23 Jan 2022 23:53:08 +0000
Message-ID: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>
Subject: parallel file create rates (+high latency)
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I've been experimenting a bit more with high latency NFSv4.2 (200ms).
I've noticed a difference between the file creation rates when you
have parallel processes running against a single client mount creating
files in multiple directories compared to in one shared directory.

If I start 100 processes on the same client creating unique files in a
single shared directory (with 200ms latency), the rate of new file
creates is limited to around 3 files per second. Something like this:

# add latency to the client
sudo tc qdisc replace dev eth0 root netem delay 200ms

sudo mount -o vers=4.2,nocto,actimeo=3600 server:/data /tmp/data
for x in {1..10000}; do
    echo /tmp/data/dir1/touch.$x
done | xargs -n1 -P 100 -iX -t touch X 2>&1 | pv -l -a > /dev/null

It's a similar (slow) result for NFSv3. If we run it again just to
update the existing files, it's a lot faster because of the
nocto,actimeo and open file caching (32 files/s).

Then if I switch it so that each process on the client creates
hundreds of files in a unique directory per process, the aggregate
file create rate increases to 32 per second. For NFSv3 it's 162
aggregate new files per second. So much better parallelism is possible
when the creates are spread across multiple remote directories on the
same client.

If I then take the slow 3 creates per second example again and instead
use 10 client hosts (all with 200ms latency) and set them all creating
in the same remote server directory, then we get 3 x 10 = 30 creates
per second.

So we can achieve some parallel file create performance in the same
remote directory but just not from a single client running multiple
processes. Which makes me think it's more of a client limitation
rather than a server locking issue?

My interest in this (as always) is because while having hundreds of
processes creating files in the same directory might not be a common
workload, it is if you are re-exporting a filesystem and multiple
clients are creating new files for writing. For example a batch job
creating files in a common output directory.

Re-exporting is a useful way of caching mostly read heavy workloads
but then performance suffers for these metadata heavy or writing
workloads. The parallel performance (nfsd threads) with a single
client mountpoint just can't compete with directly connected clients
to the originating server.

Does anyone have any idea what the specific bottlenecks are here for
parallel file creates from a single client to a single directory?

Cheers,

Daire
