Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE37797DE3
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Sep 2023 23:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjIGVV5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Sep 2023 17:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbjIGVV5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Sep 2023 17:21:57 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895511BD2
        for <linux-nfs@vger.kernel.org>; Thu,  7 Sep 2023 14:21:37 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5712b68dbc0so837602eaf.1
        for <linux-nfs@vger.kernel.org>; Thu, 07 Sep 2023 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694121697; x=1694726497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kxl+dc9kriypXYdDZczrE5Qbpc1853AivNur5ZjZXs=;
        b=OAX+A0pz81FlJcOlIVJFtubhw2icNy/D8Zdcx1IGojpEvcysOW2iwvIsLaDd/I+54O
         tNjqWywpZTu8xqG/A57W7AXHRp0qeHX+cFiWmMbpZqYz5HM4o2LGHKW+Q+K8dujR7Oux
         ZHJ1QH+J13LPJDc7uM0E7Ag52PwPc295U84ElJwoOTENqPa5m7NIQ8JVUvwIcz817n4u
         3q9zct5Vhc4tBi2LlTdeAQbFHkU+tzkosiwsXXyqY0yxwX4ZTMPWBzaDp4R/t7iT2ygE
         c0bNfq+lEirIa5U4H9qc4nDc84f0pe4ZWjzfsSzg6nP+fxHQ00YlZMQVNU97TKxznwoa
         SO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694121697; x=1694726497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kxl+dc9kriypXYdDZczrE5Qbpc1853AivNur5ZjZXs=;
        b=UkaZvGQ/UycnOb9Z75P0jvsJgHewRUT0+AhHUPLn5B8lv4aj3Bc7O+OUP3CzEYFtDa
         X3L8zvztt2EzV4AxX7sUTHw7Kv8ijzljh1ZHF9M7rLtFjfoTr7bteO/oqdKznKUL1Snv
         kuNQUjkGU21vdOl4RBe2eCzTRLpzopI9CikTFe8moBj2v1w7R8iBlLZCDG3wBD2wmYfl
         ckcH7FjLPLoYoFaJiKg3GMwIr5QfrZmUYMLfmhxakE68J03mtkqQhZN5gx3jBxEyjAqg
         pvsFf8H1R2DPFV6GE0+3G3HCmNl1DaOcOQUJ5ReKiR0ny8eQj1Wat0A2gZg6HbA/oBCR
         5c4Q==
X-Gm-Message-State: AOJu0YzXzUtJsOoWYJir4CYYtMkvxCrohJBlP2TFNRpys5clD1jt/g7I
        mGsqdUmKSn8LoJ/2XPBUcwyolsW9kAB50z8R0Ds=
X-Google-Smtp-Source: AGHT+IEzJZDqe+RkAtxSfa7fVggTV48AK9jnTLGOw0u7+5WopMAFqHDhg1wkdvclF6gkY0KGl1plFAPWraTHYspW2UI=
X-Received: by 2002:a4a:3056:0:b0:571:260e:ab69 with SMTP id
 z22-20020a4a3056000000b00571260eab69mr780827ooz.2.1694121696821; Thu, 07 Sep
 2023 14:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <CALXu0Ucch734JB9piCUaTbCXwuuYSTmayvSin8RFYfcYcD+FmA@mail.gmail.com>
In-Reply-To: <CALXu0Ucch734JB9piCUaTbCXwuuYSTmayvSin8RFYfcYcD+FmA@mail.gmail.com>
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Thu, 7 Sep 2023 23:21:25 +0200
Message-ID: <CANH4o6M7+6CNjdjG+dNWpDYYqwUboZrUMjNBJ5Nq3J9hZ_5Snw@mail.gmail.com>
Subject: Re: [Ms-nfs41-client-devel] CITI ms-nfsv41 client: IOCTL_NFS41_WRITE
 failed with 31 xid=5481722 opcode=NFS41_FILE_QUERY?
To:     Cedric Blancher <cedric.blancher@gmail.com>
Cc:     Ms-nfs41-client-devel@lists.sourceforge.net,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 1, 2023 at 5:54=E2=80=AFAM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> Good morning!
>
> The CITI ms-nfsv41 client for Windows sometimes prints the following warn=
ings:
>
> 1eac: IOCTL_NFS41_WRITE failed with 31 xid=3D5481722 opcode=3DNFS41_FILE_=
QUERY
>
> Does anyone know what this means? Data loss?

I think it means the process got killed while doing the write

Thanks,
Martin
