Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75427F0834
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 18:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjKSR7V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 12:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSR7V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 12:59:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB43EF9
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:59:14 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso5175555a12.3
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700416753; x=1701021553; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrUW5dPkmft2iIWzBiHH0QUZLTVFqhvCbn1ZjHXeIQs=;
        b=Ok+4V6NwRssX5px7ooiAPLSHOtTJaAxAx1PqiQbUxS5NOCLmUNzcSoz1baqWh3TEwt
         KfJXCYPQ24+jYPdfr1NMYoR7YuXUizkZ8HiBjIitHSm6/29VAo0vBaPddZTbfDHvHzYn
         Q5JKoJAI7owYhe5dhZKCGh/Ho2oLupMaFKpk3NcWFvFownJ5u+BBohKz0DXIjKhWRlbD
         Wd/FtMv/Ms6SplGegHW87haj+meIwRq+zs9VmvaNI87PlMgYvqD+xcNRs0iXFJkGhic+
         APghd0h9TFXVAfk6FNXvYJbDlUyuLSbXJ8knmub1c1bc8feelrADIfKsQcDD+Nrz0tEE
         ASzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700416753; x=1701021553;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrUW5dPkmft2iIWzBiHH0QUZLTVFqhvCbn1ZjHXeIQs=;
        b=RcvAo+Mh9ruhQHfHRxCHSCcJ3t2F1rYNcoS6/CvcEcaQ7ZBtthfWiD5mQkGxziswmG
         KrFKBZzHzgrf5KawCkhdSx88tR7mSWNT/fMSV3pKgbKj7IFzOOGvgqdJPFKJKY9gM6dD
         fttR1qL1f3jv3WRS/C9yUPRK/KlcBGZEBDKffC8mocQSyxJyhSzcaVmShAlVDuNWpcr6
         epWnXW/qjN0yx2f7ClURh+lLQf19m6lkyYrK9F26T3rv8eeC1PAebHED6X+LygoZdERN
         +IHvsb1naDU0tQaZ2GCxGzco586mYod0BysiBBgYabHGDTwT6vaS4Zwji0BvS+MhS4kg
         R+PQ==
X-Gm-Message-State: AOJu0YzjyEY6zAqm4d4PNWXFYd5fGe1P5jDartrhvU9ExLrK20m2GmL7
        qMGqpJ39gRr/D/8ZW5JqWO4QW4NgmBw4wX2hc6PSTrJc
X-Google-Smtp-Source: AGHT+IHxTNXoX3C8gtFjeNrfp00U5XR4haQYtUwQ232p6jWpBK2ED3cCc2M4liEgtZkUW/8aw8lvO6qzE1XlGQORo5A=
X-Received: by 2002:a05:6402:14d6:b0:540:9b47:4f70 with SMTP id
 f22-20020a05640214d600b005409b474f70mr4415954edx.26.1700416752958; Sun, 19
 Nov 2023 09:59:12 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeGnSvBbrfgnRNqdNGjDTag5Lz8uWOvuy_n57RHO3CRqw@mail.gmail.com>
 <CAFX2JfnzDczbegELv3GMCYb3CEKZ+5WfgVotdoA3CyjUprGpTQ@mail.gmail.com>
In-Reply-To: <CAFX2JfnzDczbegELv3GMCYb3CEKZ+5WfgVotdoA3CyjUprGpTQ@mail.gmail.com>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sun, 19 Nov 2023 18:58:35 +0100
Message-ID: <CALXu0UebE2oGgWLMn-NkfGq5n+2dEFnqrOy617SRMmKF-dGOXg@mail.gmail.com>
Subject: Re: How does READ_PLUS differ from READ?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

On Sun, 19 Nov 2023 at 18:48, Anna Schumaker <schumaker.anna@gmail.com> wro=
te:
>
> Hi,
>
> On Sun, Nov 19, 2023 at 12:38=E2=80=AFPM Cedric Blancher
> <cedric.blancher@gmail.com> wrote:
> >
> > Good evening!
> >
> > How does READ_PLUS differ from READ? Has anyone made a simpler
> > presentation (PowerPoint slides) than the RFCs?
>
> No slides, but at a high level READ_PLUS can compress out long ranges
> of zeroes in a read reply by returning a HOLE segment instead of the
> actual zeroes. It's perfectly valid for the server to skip the zero
> detection and return everything as a data segment, however.

So how do you differ between
1. a hole, aka no filesystem blocks allocated
2. a long sequence of valid data with all zero bytes in them

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
