Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9910C7E93F1
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 02:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjKMBMw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Nov 2023 20:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjKMBMv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Nov 2023 20:12:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900441BDD
        for <linux-nfs@vger.kernel.org>; Sun, 12 Nov 2023 17:12:48 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso5944062a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 12 Nov 2023 17:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699837967; x=1700442767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TM54X+tTm+Z4yA9xFtpRl+D2KeJtfWmxqunjRiloueA=;
        b=gVTxdXMDNWC57sKuJYxq5zqZaDF27FsTjU0zu0RUsbRhWSYuepfy0lLJo390Sev6b1
         z8OPIDjBuePZKDHOpGEucvKXQ6cmhLt/mQuUtEbqgzJy5wTa9XnlmmLQsuEylhM2e0Ti
         s0WkSHYYHso/eTxTVORP/0A7h8qiw7lh3/yLpG26x9zo2ZaHCpVLqZCdbF0ld45ulXzA
         t0KbF6CMR24Vfsawj0JpI2qQpMGow6kczCxddtDNIfrMgLDFD6m63I0tFK3PKts5rguL
         9/fhNJ2rDS77TjfJBaA7cSNFT/Fve5HP05by7qlQOQR9P6IYF8BfptORfYWL/S4Ae3Pn
         q1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699837967; x=1700442767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TM54X+tTm+Z4yA9xFtpRl+D2KeJtfWmxqunjRiloueA=;
        b=YL+6jkPqAPGf8ptNrg8bLDxZrEeyVnPvt+be7SBFcenVgxBSRp3fFIOoA/UZ6HQeXc
         dT/FhJLv77IJBh1SIakXywuMLUeV7s/u6dMTz28LQclWaHWYMsSkX63c1rwGJYP/Jw71
         J88Jk5lWxf6BRgT4wv9RH05UXCRTffEqk0sqKRczPGYhIvGp0ZQMk9ZyaHHyw7p3W3vT
         RRzene/FBGI3msnhQjAji09CUA3SdSLJBiyioKORB3jYeeCKvzPy3+zpY0gEWhckHbF5
         eZScBjbFErX6943FOFQIIurH/pGoJpWJ/gGsbZuRjkWaP8CnN8BL0T5Pt5bXASPKhBGe
         C0UA==
X-Gm-Message-State: AOJu0Yynebw1j5NNjDe82X/hNdWdmyQomP4EXmsCYGGcQPeQfbVUJueh
        atQqGIptiw4w+X/n3DQQrlhSTU4E4+iH7xdCs/U=
X-Google-Smtp-Source: AGHT+IG0nwqZnRH4RmlCJnznjAVntURLdtuShZt3gwoU7KFezmRIBTn7stbR+teXQDJc9V9dAfdQcmtg7YIiLoH7so8=
X-Received: by 2002:aa7:c78f:0:b0:540:2c48:7913 with SMTP id
 n15-20020aa7c78f000000b005402c487913mr3369055eds.38.1699837966765; Sun, 12
 Nov 2023 17:12:46 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
 <CALXu0UcT4gG8xEVOvK1mshMDa_hKYu7rJK2biq8==ySOXdA3+w@mail.gmail.com> <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
In-Reply-To: <4F5C3573-2962-4072-ACB1-1CB8236866D5@oracle.com>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Mon, 13 Nov 2023 02:12:10 +0100
Message-ID: <CALXu0Ue=GNSb7_7H7mLG21fq_n9H7TQdFcmjZbdT3AiC0S7ZMw@mail.gmail.com>
Subject: No bugzilla account confirmation email from bugzilla.linux-nfs.org
 Re: BUG in exports(5), no example for refer= Re: Examples for refer= in /etc/exports?
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 10 Nov 2023 at 01:37, Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Nov 9, 2023, at 7:05 PM, Cedric Blancher <cedric.blancher@gmail.com> wrote:
> >
> > On Thu, 2 Nov 2023 at 10:51, Cedric Blancher <cedric.blancher@gmail.com> wrote:
> >>
> >> Good morning!
> >>
> >> Does anyone have examples of how to use the refer= option in /etc/exports?
> >
> > Short answer:
> > To redirect an NFS mount from local machine /ref/baguette to
> > /export/home/baguette on host 134.49.22.111 add this to Linux
> > /etc/exports:
> >
> > /ref *(no_root_squash,refer=/export/home@134.49.22.111)
> >
> > This is basically an exports(5) manpage bug, which does not provide
> > ANY examples.
>
> That's because setting up a referral this way is deprecated. The
> preferred way to do it is to use nfsref(8).
>
>
> > Plus, /ref must not be a dir controlled by the automounter, or a Linux
> > 6.6 kernel will panic
>
> Can you open a bug report at bugzilla.linux-nfs.org <http://bugzilla.linux-nfs.org/> (product "kernel"
> component "server") and provide the details of the panic?

I tried, but I never got the bugzilla account confirmation email from
bugzilla.linux-nfs.org

Also, the https certificate of bugzilla.linux-nfs.org is somehow
wrong, Chrome does not like it

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
