Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9A17CE7C2
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Oct 2023 21:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjJRTcd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Oct 2023 15:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRTcc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Oct 2023 15:32:32 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1125B114
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 12:32:29 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41cbd1d7e04so6595001cf.1
        for <linux-nfs@vger.kernel.org>; Wed, 18 Oct 2023 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697657548; x=1698262348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJu4Fija8K7B7YNWcfUIBiqrUNB0t/6s1XSV3btWQyg=;
        b=E/JOrWvuosLbq18sPY9+2s8dsZ2jsh+H9bP/tenPmZtmzJ4SXgK4I2WN+PBmLX/Heu
         vKHpVAywgrok0hjnF6+NfbsCTSiH9jTUIXSi6VMtTuUq8BAv9ctSOUAEW0LigU8gUP7f
         6/L9qxCEtWdw1BwRfv/4yrvlaedCBxJAve+ovvAllCFHG+iJ2YHpBERSKwVCzeWdL/v1
         ldCmVbW8P0449l37/vCxccdFtUvmhr+cLofpcpBdbOWrsNvrZeGvs8miBwK1k1Hoh5tX
         E5sFGx3Zf1ySfPEwxJ0s3nnKgTNhzr7d87a/gdm7XGRYwyV6dBgrdTZEfdaw0C+SroNz
         s8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697657548; x=1698262348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJu4Fija8K7B7YNWcfUIBiqrUNB0t/6s1XSV3btWQyg=;
        b=LbikJEhRuvetwaWCTrd1thQ86Wa+kez+SvEsd4XgpqRvTA5pJNgWpzqPvwXbF3L8Rp
         q81R+Zx4Y2jdwxeXjdM2sOWsHBOH/Ck0hP8Wh1OL+aza+hnnL0X/bSZ60N3cj7bZizl3
         GADS9u2i1U0Gy8s5NngN7/kN55WjcbRY2JynqK8VhM/J8v5Aps/Iin8iaoibxHvqj7m5
         Jhy4A1BwiBu6Lr+6rPzD76RBZzYm1++MIHe0tBkNq4WAcDfHSjySXjb3S3b8cEWJGNwp
         7pVU4Rl3lHNAYpPQxUq79Ym5A+1QDuPspdiLisrUtTr8JK2TYYNJiyI4HnBV0nIekcn1
         UX4Q==
X-Gm-Message-State: AOJu0YyggD2oJFGPtdHxPfvmRCbh50vgHzXyIc2L79dR4YrhpziOpYiw
        Oy8PTBlzqPRNiDIsLcRDXxXwxXDECopchNP/0ac=
X-Google-Smtp-Source: AGHT+IFngGZVUZCoK2RDKnCXPMHtr6TwT3Ww4vczKN8BxYksw2f8vnXmkd8CiGBnSZNEl/3Y1I4jpd90/lxbyVRoGZ0=
X-Received: by 2002:ac8:5cce:0:b0:412:c2a:eaef with SMTP id
 s14-20020ac85cce000000b004120c2aeaefmr252516qta.11.1697657547990; Wed, 18 Oct
 2023 12:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <CALXu0Ufzu8FMdH=-_35tHNqu3c6ewf4d6a379=fUMwNvGq_rgQ@mail.gmail.com>
In-Reply-To: <CALXu0Ufzu8FMdH=-_35tHNqu3c6ewf4d6a379=fUMwNvGq_rgQ@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 18 Oct 2023 15:32:11 -0400
Message-ID: <CAFX2JfkRpfRe6-T3MELWsAX_V5xyZoiv0Prq_1qq4-5Pi4PCag@mail.gmail.com>
Subject: Re: NFSv4.2: READ_PLUS - when safe to use?
To:     Cedric Blancher <cedric.blancher@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

Hi Ced,

On Sat, Oct 14, 2023 at 9:08=E2=80=AFAM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> Good afternoon!
>
> Since which kernel versions (NFS server, NFS client) is NFSv4.2
> READ_PLUS safely usable?

Linux 6.2 for the server side and 6.6 for the client.

>
> Also, could you make this a mount option, so people can turn this
> on/off per mount, instead of using a kernel build option for this?

The eventual plan is to remove the kernel build option entirely. We
probably won't do a mount option, and just have it enabled by default
when using NFS v4.2.

I hope this helps,
Anna

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
