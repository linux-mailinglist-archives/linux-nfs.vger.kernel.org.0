Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF152F69B6
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 19:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbhANSia (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jan 2021 13:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbhANSi3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jan 2021 13:38:29 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76641C061757
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jan 2021 10:37:49 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x23so7587736lji.7
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jan 2021 10:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkNtbEGTwZJ6sJ64X8rspVr19ENTJTSpvUAXlKtllQI=;
        b=Q7ohKsRMNh4Rc3WRHs3bzJHXz4sCpiCGuFg0wgPXdd6abZ4BN5HODklWo4nCfsJzoV
         cDJqXdWG8+LIUi6wd+pO/FYsehPdglS77UP80eb8++xCD8QXOVzPu41ikIIR3j0ds/GO
         tX7LXIjW5ol/pOSSYdU1B19U3II2TTTmSUjMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkNtbEGTwZJ6sJ64X8rspVr19ENTJTSpvUAXlKtllQI=;
        b=eFC07Q5aVuPEkReoibcD26CPHAun1n1bCSIXUkOfQiflNAOmOLmDba70bceUeSCmXM
         04DRtduFIODRKMuEPqS3rwcyiSJlvVLxkj1RE5kcGFd+8lTKLfIA6RYyuyc7Rnn2EcOZ
         V197LLBYl3Y7dn/U2en2EgF/k5GD4xnS3//ES3BUpruYHK9/7MAq08r/jUxkrrU2QH4Y
         SaidKcmMPksK6nElDQQS96138EfhVVQWkcRix2pd8s8varAa3N7Wc4XxQTwaXSfRBHnO
         0P3a96L5IiQzARXyh2F6MlTcRaYRNxcj2oxPqv6t0AJ+5jwREgVpzAxkTlYxHvmTqudM
         DoxQ==
X-Gm-Message-State: AOAM530Se1grnC1LRsxQwSds/70NtIXs8fbTrGxqgtkf9D5MMw/cSMJ9
        dIl/xqN3VROuvo2isOEb4DqCMAi6mmu0cw==
X-Google-Smtp-Source: ABdhPJyRf0VKw44K0jm49b4J9Paldq+tRRRET8/nHb4nzhqIMaaZQAUQoPQM7dZqKHScDFNrLsa4Vg==
X-Received: by 2002:a2e:9d8e:: with SMTP id c14mr3695650ljj.7.1610649467362;
        Thu, 14 Jan 2021 10:37:47 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id i29sm622137lfc.193.2021.01.14.10.37.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 10:37:46 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id o17so9477754lfg.4
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jan 2021 10:37:46 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr3646053lfu.40.1610649465741;
 Thu, 14 Jan 2021 10:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20210108154230.GB950@1wt.eu> <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org> <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <CAHxDmpTEBJ1jd_fr3GJ4k7KgzaBpe1LwKgyZn0AJ0D1ESK12fQ@mail.gmail.com>
 <96aea58bde3fe4c09cccd9ead2a1c85eb887d276.camel@hammerspace.com>
 <CAHxDmpTyrG74hOkzmDK834t+JiQduWHVWxCf_7nrDVa++EK2mA@mail.gmail.com>
 <74269493859fa65a7f594dadd5d86c74bd910e66.camel@hammerspace.com>
 <20210114180758.GB3914@fieldses.org> <CAHk-=wic1CEkj_vjf3dUWv41=aKeazSW5ugGOfYsKQZnihQhMw@mail.gmail.com>
 <7E14D32D-1B39-4DB1-AE39-B8B34655DC7D@oracle.com>
In-Reply-To: <7E14D32D-1B39-4DB1-AE39-B8B34655DC7D@oracle.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 14 Jan 2021 10:37:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgXAdv07SOB01X+1c=3NP6qP+AgLdn33QOt073i4088DA@mail.gmail.com>
Message-ID: <CAHk-=wgXAdv07SOB01X+1c=3NP6qP+AgLdn33QOt073i4088DA@mail.gmail.com>
Subject: Re: nfsd vurlerability submit
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 14, 2021 at 10:35 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> If I understand your question correctly... there is a commit in
> linux-next that simply doesn't return any filehandle for ".."
> in the root directory.

Great.

> I intend to send you a PR after a few more days of soak time,
> unless you'd like me to send it now.

No, no hurry. I was more just checking that Trond's suggestion didn't
get lost in the discussion about guessing file handles.

              Linus
