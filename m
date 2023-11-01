Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5CE7DE191
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 14:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbjKANaY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 09:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344200AbjKANaY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 09:30:24 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA86F7
        for <linux-nfs@vger.kernel.org>; Wed,  1 Nov 2023 06:30:19 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41b7fd8f458so41762211cf.0
        for <linux-nfs@vger.kernel.org>; Wed, 01 Nov 2023 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698845419; x=1699450219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MltogKM6IUsqM04IbU0F9CuqeIvuc4jUoShaBCvvcY=;
        b=IZcl6PQQ+gJCVDit0Tp9gRk1Vv+duqcyQFlNr5Jg57W2oBm/SlQrJTfsrsSCXC+UMO
         S0UID7X6jxUMDcpcJn5rvSh+FFv3g32chEHlyUmoDP3zP0FOR+X8GvmVB5FzSk5H5WvO
         SmBo/rvc6Ji0+5rN9LfI58ezf0JwTxlBIRV4H4SYZen3lho27ywvyCppbpEXv0T84DWX
         KThlFebmhRldWa0vlw2NKZDHL/4QhSnuUb4+EsM4xczF9wstFwbv/qxcV2OpouhB2Txe
         mPS83A8R4JQtwrRAsq0V0AF6woJHSulHRWg+u1SbEyShFL4dnE4Puea1OsUMi6+oEfT4
         28Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698845419; x=1699450219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MltogKM6IUsqM04IbU0F9CuqeIvuc4jUoShaBCvvcY=;
        b=jMlK88vSukn489S6ZfKu4v4ES65Pb7wMt91m6NmcDdY4DWQ58E0D4pJ211ZH0BQ3v3
         I/fPfBA1eQ8ZJa4br/FmMVxhndvGF0dqKbzbTPKlhno6/obweiu75roORREnnPtpWX7b
         4CvYVoFNWZ2atG7PT4a8dBdIeYqrdpUTyLfV+EiYbDpRYjUBfO6wuL2iSt7JYKflUdIy
         Tvrtn5yKFYXxYZpWrbyhN1ioJOF4nX9qlS1AYRX2xji5940fbMfGy8A+S2cOPXxYqQE4
         qEkxuRiMqMuyaxoejHDrmjKKU3ptCL57WYYa/c6+CeiwZ4XavR9MoxWLaiktYomlg9et
         mOLg==
X-Gm-Message-State: AOJu0Ywe+P1bS1WUdYqiRnVZUSvxHUqD5k07aJs9BQkWBJT0dQ0thCqM
        gHsrvcPRtHqPtukAVFJm4UYDZU0yYBJ1o+zRYgsGEJ29gyY=
X-Google-Smtp-Source: AGHT+IGiF5T101Tr1R1tGMY41jjBn/+6uKcycS62ECxhICdQbVRKxjVixmW7rsSjA0kiEsGXiN7hZxjtYnKPCDUaGA0=
X-Received: by 2002:a05:622a:34b:b0:41e:2523:da45 with SMTP id
 r11-20020a05622a034b00b0041e2523da45mr20171387qtw.31.1698845418716; Wed, 01
 Nov 2023 06:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <CANH4o6POxEyCYW0dY1FAEk518b3aGwVp5qogMMHqHR1Ukfg8yw@mail.gmail.com>
In-Reply-To: <CANH4o6POxEyCYW0dY1FAEk518b3aGwVp5qogMMHqHR1Ukfg8yw@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 1 Nov 2023 09:30:02 -0400
Message-ID: <CAFX2Jfm7LApk2nu3==0BbLdUwN_Z13vfxxJC_Tk=5eYgiij-ww@mail.gmail.com>
Subject: Re: Status of READPLUS support in Linux 6.5 kernel?
To:     Martin Wege <martin.l.wege@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Martin,

On Wed, Nov 1, 2023 at 5:09=E2=80=AFAM Martin Wege <martin.l.wege@gmail.com=
> wrote:
>
> Good morning!
>
> Is NFSv4 READPLUS usable in a Linux 6.5 kernel, for a NFSv4 client and
> NFSv4 sever?

Linux 6.5 has a useable READ_PLUS server implementation, but the
client only uses it if you enable a Kconfig option. I'd recommend
using Linux 6.6 on the client, since it contains some important
READ_PLUS bugfixes. Linux 6.6 also defaults to compiling in the
READ_PLUS operation, so you only need to change kconfig options if you
want it turned off.

I hope this helps!
Anna

>
> Thanks,
> Martin
