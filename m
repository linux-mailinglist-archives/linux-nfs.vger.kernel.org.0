Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E234B7D8F
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390929AbfISPI7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 11:08:59 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:37923 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388808AbfISPI7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 11:08:59 -0400
Received: by mail-io1-f44.google.com with SMTP id k5so8531648iol.5
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2019 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Q/kkfVVsj6sw5lYCmq8HgqPXsWbozaGSHVGGTc0OmU=;
        b=XE4NhdvNXktFcq5mkhIJ0rF0NRT063Bm7lueTbqe7EYRhaO2r3QN0A8LuFqVTXJaGK
         BWnsu5Mi4b0u2SPtoE0kdwAjVzu29u/KAY0+K7JpiiPm1EZFvR4t1JDgM2cZdPofiy8X
         9PBPYJasSQAnVPnTyKw13bQg3AbZDTKxN+t4UjgQMbB1AbQUFsGfzL6nEuRAEXcF4Gn3
         5J63zJUFX3zkDUzLcJmSOIyLgm1mfjomuon/Z2+nJ26nqWDSMTHGevkD8zonxlhpKZF8
         SmQ5I2QTJ+puWnVvft4se0g/5GTcIXWDPmn6pcHsc94XHAZM0yNS7OPS4T51HjKjOkYi
         Wz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Q/kkfVVsj6sw5lYCmq8HgqPXsWbozaGSHVGGTc0OmU=;
        b=JOfeYkXpCIbqljbH6WcTPe3teLn9NnzbFYNE6fAhsDcDsLzqsNgenB8XXGwnK6ilCc
         3f7Q2V3M2tN/ERoTOTfvh4FxhFsunXWERQ/b462ySmqd3KTH/MMDSuQt7O4G3diQeV8U
         KmAHTMW5VCeOeDITpNv/2IVl8i9+mz5BbBF73RjbPMPPTscqs+kuevShIyJIrjc+2Bn/
         SB2yKtuypqG68UbSBVLGr1Jqk0RUQ8X83uMR5AJGNueP3JLUtCnIvUDJdRrm+UxmQgas
         POvRakzwanVj4gK3T2UD7yok93IIi/RETj+ZUHkTiq9VQRRTvQyGiUOPopHxk/KkU12u
         43iA==
X-Gm-Message-State: APjAAAVUWGjhTHf2ZPxqylNKhsoBm/eUkmmODPlg1p6JkSIcUbtViXUp
        1c0EB440ebn8sHS2M2SllVfCc6kXo1hPwOV6DQ==
X-Google-Smtp-Source: APXvYqynUI3Ptd0+1QbGQUPpYWTm9S1JCBenBSfULiyIWOI45JdkiTv6O7kp5LZWAQxikbHuwZRyfpKwQ4fDy0QlgC8=
X-Received: by 2002:a02:2302:: with SMTP id u2mr12837744jau.70.1568905737764;
 Thu, 19 Sep 2019 08:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
In-Reply-To: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
From:   Trond Myklebust <trondmy@gmail.com>
Date:   Thu, 19 Sep 2019 11:08:46 -0400
Message-ID: <CAABAsM7XHjTC4311-XY04RSy_XJs+E+j+-3prYAarX_=k0259g@mail.gmail.com>
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps, what sets those defaults?
To:     Alkis Georgopoulos <alkisg@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 19 Sep 2019 at 03:44, Alkis Georgopoulos <alkisg@gmail.com> wrote:
>
> Hi, in any recent distribution that I tried, the default NFS wsize/rsize
> was 1 MB.
>
> On 10/100 Mbps networks, this causes severe lags, timeouts, and dmesg
> fills with messages like:
>
>  > [  316.404250] nfs: server 192.168.1.112 not responding, still trying
>  > [  316.759512] nfs: server 192.168.1.112 OK
>
> Forcing wsize/rsize to 32K makes all the problems disappear and NFS
> access more snappy, without sacrificing any speed at least up to gigabit
> networks that I tested with.
>
> I would like to request that the defaults be changed to 32K.
> But I didn't find out where these defaults come from, where to file the
> issue and my test case / benchmarks to support it.
>
> I've initially reported it at the klibc nfsmount program that I was
> using, but this is just using the NFS defaults, which are the ones that
> should be amended. So initial test case / benchmarks there:
> https://lists.zytor.com/archives/klibc/2019-September/004234.html
>
> Please Cc me as I'm not in the list.
>

The default client behaviour is just to go with whatever recommended
value the server specifies. You can change that value yourself on the
knfsd server by editing the pseudo-file in
/proc/fs/nfsd/max_block_size.

Cheers
   Trond
