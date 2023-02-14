Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90560696765
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 15:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjBNOxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 09:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjBNOxT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 09:53:19 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0B20069
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 06:53:15 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n2so10319011pfo.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 06:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XWt9bhqTDg16yw+MoUTF+CW9ejH48/mlI191j8Zk8Q=;
        b=Snl7Mrfo3y+MF2pvKfsWGXtCOmqmTBck5KsvPONcg+zwsj3ohMF12Pyp5QE/pXcPcy
         PpH6B6speEK+cszeRprDEoSz8KUyodU5NwpW3sOdqLqLBVg9EOIeCIQNF3RWItNFUqKV
         37ccHnt73WuD+lb3AudecI2jI2nCw+vrga069Vb2gjInusd5xDf8PBFxnE5x38wKhg3x
         +/BiQrKNCaGVMJ0O8P+1arV9cRJOhgYq5M5kXHoEfkvHyS+uEkRQz5AkwV2pJ4CDOTLh
         LlF/+yvi4e+3lqjuiTtj0/qmyBwUQ/0aSW4a++eYMCrvjK7N77+7/0RsHtbY2zslqKGI
         lybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XWt9bhqTDg16yw+MoUTF+CW9ejH48/mlI191j8Zk8Q=;
        b=Dlc/AIHj/3qAy2BG10/XiIWGvRJQN0ldhyfSqdy7Z16BbB2h9wj4AR6k1yetnfnrLQ
         LFvJKwPQ2FH4orDpQqMalQRSZI5Fda9/g4Q++WIcSYGhhVGbAAKQWEGug1BFpXvOa5Pg
         tTcp58vYCFs9n/xjCOzSKDuljtlEDT/WzFaziwJ9tb32SGqMN62DHee0jZ906L7mqSsE
         t0JuMekzpddE24BacZmQsdiOpuuoz/CDx6xf0AEly5CHyIbyW0MyDhHfhmtWcGCijPD4
         Kjw3NlBHj961xVpGNk4BVuEuubiYibv5beF4iRHHalS0Q1K1Juj3HxpjXYZPm2FljkaB
         lr/A==
X-Gm-Message-State: AO0yUKUTYpKx01xWTISR3LLgB9PDVmD7AGU42x680ESovoAYqVVy7rY2
        N/AKAtF5Nj/YuerOcqlpsL8PBeGdHG0A+lYHQs2+noDR
X-Google-Smtp-Source: AK7set+cXOIpsGaLNKx8sKGSLxKDgQdZIFK+zpn4A72IMMLs9AeixPBAQ1goPapRMnnyEGz+e9pBNADciOaPPNDqDTg=
X-Received: by 2002:a62:180f:0:b0:5a8:d500:85a6 with SMTP id
 15-20020a62180f000000b005a8d50085a6mr513603pfy.54.1676386395143; Tue, 14 Feb
 2023 06:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20230212140148.4F0D.409509F4@e16-tech.com> <PH0PR14MB5493A75DC8E617230D426F09AADD9@PH0PR14MB5493.namprd14.prod.outlook.com>
 <CAN-5tyH45zKa+xcvwMoUzWPewUkwNZpJycNN+ZdHeea8Uj6tFQ@mail.gmail.com>
In-Reply-To: <CAN-5tyH45zKa+xcvwMoUzWPewUkwNZpJycNN+ZdHeea8Uj6tFQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 14 Feb 2023 09:53:04 -0500
Message-ID: <CAN-5tyGa6hpJcBkPDocuVPbPEP32Jg5AgR=Z6DbMc7kg_oKsLg@mail.gmail.com>
Subject: Re: question about the performance impact of sec=krb5
To:     Charles Hedrick <hedrick@rutgers.edu>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 13, 2023 at 1:53 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Mon, Feb 13, 2023 at 1:02 PM Charles Hedrick <hedrick@rutgers.edu> wro=
te:
> >
> > those numbers seem implausible.
> >
> > I just tried my standard quick NFS test on the same file system with se=
c=3Dsys and sec=3Dkrb5. It untar's a file with 80,000 files in it, of a siz=
e typical for our users.
> >
> > krb5: 1:38
> > sys: 1:29
> >
> > I did the test only once. Since the server is in use, it should really =
be tried multiple times.
> >
> > krb5i and krb5p have to work on all the contents. I haven't looked at t=
he protocol details, but krb5 with no suffix should only have to work on he=
aders. 3.2 msec increase in latency would be a disaster, which we would cer=
tainly have noticed. (Almost all of our NFS activity uses krb5.)
> >
> > It is particularly implausible that latency would increase by 3.2 msec =
for krb5, 0.6 msec for krb5i and 1.6 for krb5p. krb5 encrypts only security=
 info. krb5p encrypts everything.  Perhaps they mean 0.32 msec? We'd even n=
otice that, but at least it would be consistent with krb5i and krb5p.
>
> Actually they really did mean 3.2. Here's another reference that
> produces similar numbers :
> https://www.netapp.com/media/19384-tr-4616.pdf . Why krb5 perf gets
> higher latency then the rest is bizarre and should have been looked at
> before publication.

Nevermind. After some investigation, it turns out the public report
has a typo, it should have been 0.2ms. Hopefully they'll fix it.

> > From: Wang Yugui <wangyugui@e16-tech.com>
> > Sent: Sunday, February 12, 2023 1:01 AM
> > To: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>
> > Subject: question about the performance impact of sec=3Dkrb5
> >
> > Hi,
> >
> > question about the performance of sec=3Dkrb5.
> >
> > https://learn.microsoft.com/en-us/azure/azure-netapp-files/performance-=
impact-kerberos
> > Performance impact of krb5:
> >         Average IOPS decreased by 53%
> >         Average throughput decreased by 53%
> >         Average latency increased by 3.2 ms
> >
> > and then in 'man 5 nfs'
> > sec=3Dkrb5  provides cryptographic proof of a user's identity in each R=
PC request.
> >
> > Is there a option of better performance to check krb5 only when mount.n=
fs4,
> > not when file acess?
> >
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2023/02/12
> >
