Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29786B8206
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 21:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390535AbfIST5N (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 15:57:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35390 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfIST5N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Sep 2019 15:57:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so5415559wmi.0
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2019 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=X9urOrHZGeErvOkysXeQPTttflTL/sXZymWH5wMQwjU=;
        b=rGjkPq9gTXNG5H5IDrNT1t4pzGw3nZQ6ImJWvRyuBEA9E9wFfTCeVSFrzeBtrnkLL0
         uMgvjD4/ve63doBYsK+ZSwQp1PbAAugCWZZ9Hb9dsBeUmoN5vS9Etq62RzEsuLXqCg1Q
         lcLbhDQPQ1TDd12wt+rOGuCV8Jtal3Lf6GUQDS3Qk7k5wRO2rrT6Bxv6OjbuhPBNuQct
         OFS7Q6aoibUrOoiG4ht+p4k9YDhRlVOwPn/lxUiO3IHFoRJUP1IBhcO1vzos7ZM0IdY+
         W9fUqT0RX/lHhD3EBtJu7oSmJR1G2zd3+L4mgL0F+0QWmhAXJl2Vx/e9vwy71sTq2F70
         4Elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X9urOrHZGeErvOkysXeQPTttflTL/sXZymWH5wMQwjU=;
        b=Ckkdiqu2dcDs32CIzAZW+z3EdbzamubN6JpNZZBn1ojcJ8cKnRTG2k8Op8mY14+7Uj
         Mv2wPeFLxOzThW9dDLusc3DAAXfr5AjW2Y734d6J+BU560FqlCh4cfZ31YNyJcOQuP58
         psAXPUOzAq3Ae2Lucr/bcIW2so42iG8FfsraCew2Bra7aLqDcRqGQ8VCwgsQF0F0CEeu
         aYGaxMc2QPASymPWalb7QsCYZSgkYNHuvbFyw1RvGuVrOE7tG0eLButwKjG+HenY4bA3
         SXfXH1m/uEBWC3cmSnMBIHeiOgjnvecaZkbGmxxpv1ssA3ZaHUPHuGftfy3kxs6Gce3P
         /ADA==
X-Gm-Message-State: APjAAAVMK/EfO+cVyIASMr02KQRiw5uKk/6oAbkLX2tIQ657MNmpYXmJ
        gTiF3kTp3HRdzqsRdTAfFRNj9gAj
X-Google-Smtp-Source: APXvYqxnWVty+W5xz50H5b6tBR58sQyP26YtD4TOtXfi+mRt4Rwx9R032pXH4wLRIwNjuOmrl39RMg==
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr4255549wmj.57.1568923030837;
        Thu, 19 Sep 2019 12:57:10 -0700 (PDT)
Received: from [10.161.254.11] (srv1-dide.ioa.sch.gr. [81.186.20.0])
        by smtp.googlemail.com with ESMTPSA id t6sm10933145wmf.8.2019.09.19.12.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 12:57:10 -0700 (PDT)
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
 <CAABAsM7XHjTC4311-XY04RSy_XJs+E+j+-3prYAarX_=k0259g@mail.gmail.com>
 <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
 <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
 <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
 <e51876b8c2540521c8141ba11b11556d22bde20b.camel@hammerspace.com>
From:   Alkis Georgopoulos <alkisg@gmail.com>
Message-ID: <915fa536-c992-3b77-505e-829c4d049b02@gmail.com>
Date:   Thu, 19 Sep 2019 22:57:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e51876b8c2540521c8141ba11b11556d22bde20b.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/19/19 10:51 PM, Trond Myklebust wrote:
> I don't understand why klibc would default to supplying a timeo=7
> argument at all. It would be MUCH better if it just let the kernel set
> the default, which in the case of TCP is timeo=600.
> 
> I agree with your argument that replaying requests every 0.7 seconds is
> just going to cause congestion. TCP provides for reliable delivery of
> RPC messages to the server, which is why the kernel default is a full
> minute.
> 
> So please ask the klibc developers to change libmount to let the kernel
> decide the default mount options. Their current setting is just plain
> wrong.


This was what I asked in my first message to their mailing list,
https://lists.zytor.com/archives/klibc/2019-September/004234.html

Then I realized that timeo=600 just hides the real problem,
which is rsize=1M.

NFS defaults: timeo=600,rsize=1M => lag
nfsmount defaults: timeo=7,rsize=1MK => lag AND dmesg errors

My proposal: timeo=whatever,rsize=32K => all fine

If more benchmarks are needed from me to document the
"NFS defaults: timeo=600,rsize=1M => lag"
I can surely provide them.

Thanks,
Alkis
