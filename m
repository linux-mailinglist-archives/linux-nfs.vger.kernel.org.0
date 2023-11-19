Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97377F082E
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 18:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjKSRsk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 12:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSRsj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 12:48:39 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466CF2
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:48:36 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-586ba7cdb6bso2119655eaf.2
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700416114; x=1701020914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DpF7NLOX47ToqHt5TY5kjCdhCamBjh1nYa7p1Btwxk=;
        b=INGPL7mZEvDC4CF/LaFxZDPjdpf3/ZwoaP+O/BwOPxUNZUJyGbYGeG+PauUKDAmbrr
         lvR/D92sKZcGJKn5krEGQ28C0Dh6DqAu08bgoczy78s8IErwD/JquMT8SRZyOXn/ETgL
         /cH6Lq45AbLO/7yO7pedRT12DhWntzGD+O9Pj+wwrYzIDkzMtYRmBpTjQYcMoI9Cm/1i
         kNI+AhXQuJvvOxAOZpWe41fQ6E4owShHN4LggpwVr7oJ5pj+59AdnA62127ZVvfDp2Hd
         FNFqQuAdIQ2ONdZ0r7zwj6J1znwDeQTCHKfxxXW+Su/DcHG4rcXN6KQHdQPrJDFDpyAW
         1Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700416114; x=1701020914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DpF7NLOX47ToqHt5TY5kjCdhCamBjh1nYa7p1Btwxk=;
        b=Sl7oz0V/xU4FHEl/KF0UKx9/Sb9sQNCGQDFhxQxiNSOJL0arLhDWr4d+RFAqv++YXV
         gxR5dVRcLgZtDIGHhAcCkFCXpCofkDAX2sZH9aLvc0AkbzDOl2ErrghVS5jHJDT9uwco
         I/5JchNVNOqvJtZ/ZDiIvpNvBrafb4/0r2r+qH5/ytGjSY5oB9pc/HeS6gxcpxAcloC1
         nKoOg+uq0kXucfU2Y4QLFhIozoZuzLmYeLoOb5gHPj5kO80BoMBQABZ2cj0D8J8/gP38
         DlvoHxz5CPHbQVJ7lMIjCarYgAffs3/EAkpXoFDPPLSZXdlnbE38N4gOQRtQ8/v2n25c
         vTOg==
X-Gm-Message-State: AOJu0Ywc0ziTYqWOd4/lgg5OKfNFJG63yMy/FLRxd6/aqBCdZteUDccv
        S0oXAXxHQWoXouPPPQcP71V6YhbrT07l4QacSm6WWZN0reA=
X-Google-Smtp-Source: AGHT+IEaaB20/4tndPgKP/z5+6id2dqEdKdJaeUeckd3f7GnspYXS0NtEd3Zfmrw18mKRR3uI3Hk1u4X40o9+C4U1eY=
X-Received: by 2002:a05:6358:52c8:b0:16b:c486:c315 with SMTP id
 z8-20020a05635852c800b0016bc486c315mr6225164rwz.3.1700416113874; Sun, 19 Nov
 2023 09:48:33 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeGnSvBbrfgnRNqdNGjDTag5Lz8uWOvuy_n57RHO3CRqw@mail.gmail.com>
In-Reply-To: <CALXu0UeGnSvBbrfgnRNqdNGjDTag5Lz8uWOvuy_n57RHO3CRqw@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Sun, 19 Nov 2023 12:48:17 -0500
Message-ID: <CAFX2JfnzDczbegELv3GMCYb3CEKZ+5WfgVotdoA3CyjUprGpTQ@mail.gmail.com>
Subject: Re: How does READ_PLUS differ from READ?
To:     Cedric Blancher <cedric.blancher@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Sun, Nov 19, 2023 at 12:38=E2=80=AFPM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> Good evening!
>
> How does READ_PLUS differ from READ? Has anyone made a simpler
> presentation (PowerPoint slides) than the RFCs?

No slides, but at a high level READ_PLUS can compress out long ranges
of zeroes in a read reply by returning a HOLE segment instead of the
actual zeroes. It's perfectly valid for the server to skip the zero
detection and return everything as a data segment, however.

Anna

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
