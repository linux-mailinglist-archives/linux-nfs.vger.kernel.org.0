Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28B77EFFCD
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Nov 2023 14:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjKRNVL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Nov 2023 08:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRNVL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Nov 2023 08:21:11 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9821127
        for <linux-nfs@vger.kernel.org>; Sat, 18 Nov 2023 05:21:07 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41cc75c55f0so34928781cf.1
        for <linux-nfs@vger.kernel.org>; Sat, 18 Nov 2023 05:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700313667; x=1700918467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTgFA30ZtCH9mz5GQBwXPY3tXPlQlQLGOqqnbir0BP4=;
        b=UTiD50lZzOoemQ8gTfBxnKz8IvSAk2LB7ZChFsfRymK8PW4Tf+Omsuj2Gru/x2RdnZ
         lk/sZWyzybOmfyBBrsWNuK3YmCHsUHHmq77A+tQ8sTd6EpsLJMdrtc/UwPVw0wWwSI3t
         vT87C8doI83G6nAVj3WbjX4XBWc0i8SgbHHtPmn08RpoVsq1mmP+co9yXnWnngbV0xvd
         VTuMCiG4LMifbd8j/QgG0qlY1ubraQyhI3PQQSbuA0t/3zq4rRm7KO8mvJGPwhJ3ZOff
         QEHsaDlp+G3IH09wX121yf0bNXGlTSNgklmMwXc/+xUiVgmBlbBNdrgRtZshgzPFbx4P
         045w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700313667; x=1700918467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTgFA30ZtCH9mz5GQBwXPY3tXPlQlQLGOqqnbir0BP4=;
        b=muWQq/CggSoSS+KPbiQ28stkaIyLtEqj219KDctH/SPxTiSnyWr11jHoIe0av/9Us4
         dws2J2MDNSxI4f1PbriMFvYGPa3rI7OmGZnUr1ulTFJYYC74Az11OgB1Etnp5vmZ0cue
         FCSxIHc/jdnaVr5S/Kzn/mzSgzjkGswIYBsMKEpYbt/QjVBEtidP1NxcSWaffdSbGnDS
         pZ9mEXK/hmfFMkTAue0Y6ev9Wk0rPe2GS6qTosEGLLlzAfwHAahne8YKRSzGIfvdmn3B
         uXNDC7zsKXavdlN14l5pmrQEYSQYYSJH/t2KTfpeRNVsvQ6xCxPzROaiN08sD7H8PLNy
         O+xA==
X-Gm-Message-State: AOJu0YyfKJbz0VRuMFkM/cBKiOqiiKp4hvTVjv2RMlfNaEYT/wAAMbkw
        AN0gzE3OXSkz+18715QPJ92hQDnpkZm6sR65zggTRbu/GKkVDw==
X-Google-Smtp-Source: AGHT+IGxRHfaFaaRdPJJ8d+126VAFJrbn4ynfnF5lQEhT0Im8Ho4m7fZDfEtAVo7+nGLBuzAQUIFi9Lyc45bUz8PCy8=
X-Received: by 2002:ac8:7d43:0:b0:421:bb1e:cfeb with SMTP id
 h3-20020ac87d43000000b00421bb1ecfebmr3009620qtb.11.1700313666975; Sat, 18 Nov
 2023 05:21:06 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UfhH7AQ=sqDkGAukYPDN-HYGkwfsLuswkmYeDRgcgJ1XA@mail.gmail.com>
 <4fd6a706b7dbc626ebb5b8b0779e9f8bd4319518.camel@kernel.org>
In-Reply-To: <4fd6a706b7dbc626ebb5b8b0779e9f8bd4319518.camel@kernel.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Sat, 18 Nov 2023 08:20:51 -0500
Message-ID: <CAFX2JfmnM456zUiu+UusPE7e9AtP=zm-anZ3NJhVja24UzSguA@mail.gmail.com>
Subject: Re: NFSv4-over-TLS, info?
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

[Resend because Gmail converted to an HTML message]

Hi Cedric,

On Sat, Nov 18, 2023 at 7:11=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Sat, 2023-11-18 at 09:02 +0100, Cedric Blancher wrote:
> > Good morning!
> >
> > Where can we get more information about NFSv4-over-TLS? How will it be
> > implemented? In libtirpc?
> >
>
> It's available today in several distros (Fedora, Debian, etc.). You'll
> need the ktls-utils package. The only docs are currently the manpages,
> AFAIK. I don't think anyone has written a HOWTO or anything yet, if
> you're interested in writing one after setting it up.

I wrote up a HOWTO for ArchLinux a couple of months ago. I'm sure you
can use that as a starting point and adapt it to your environment:
https://wiki.archlinux.org/title/NFS#TLS_encryption

Thanks,
Anna

>
> Cheers,
> --
> Jeff Layton <jlayton@kernel.org>
