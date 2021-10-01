Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E541E781
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 08:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbhJAG34 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 02:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352187AbhJAG3u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Oct 2021 02:29:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A97BC06176A
        for <linux-nfs@vger.kernel.org>; Thu, 30 Sep 2021 23:28:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i25so34711454lfg.6
        for <linux-nfs@vger.kernel.org>; Thu, 30 Sep 2021 23:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOTJYER/idURZQmQAjcttF4r8c5HWgifH8AMSqldgMw=;
        b=jBvT/Mc3ByuR53D0xtBKBP5QbpC/Dfxuqi7ue6kVQx84tmB9+M1XExrYmoZ4gh2bl5
         ZvrswtghuCIA1cdtq7PKCdhrUYZwgHOXpZG69/mQYftfpoz8P1WwbHRxldChzpXHOezT
         DNNvTRgNgonS8Oyz+3v4SfiJy8woZIfGmQWuCO5cO6P53xvUAkOh87OLzotqpL663bsR
         rPYZUdMZTcpEPIwAZ1oEG/K/Vi5reENEMdDlZGewowVvrcfIk0wniOjfEkbwZuKe2eKe
         uJt9CM2ocwCv5gLKpkdUPxwCMTyRXXTYxNP3pB5QzIngla2buJrnHBcFZvnj8YsEkkK+
         qjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOTJYER/idURZQmQAjcttF4r8c5HWgifH8AMSqldgMw=;
        b=A2jsvNFdsJvI2WaAFhoKeDocP55xflC07yPzpAs1A/il104pUrVPx+unup5Y2abG49
         +SGPVgItHCykJCt+9bEhoPE4aDbnagZWI6tac7K6IR+8omeJ0xcgVl3oN3ShWVaZE/Jc
         VJU6Cb+BhKgJcHEGG9342Ea8Zy8+NbO0vqvWFlfiUuGpmM5m/QpMC2J6e2lePbh8Bj2Q
         0hVVKvgx0lbHUqq1mv24MHfo8WINA/jU4OFlGCFv7bH5B4S+XMIHmjs37V7ro74bjkIP
         gKU3sfwYy0glQSSY+VKGLVoeqaq1dhBAso8ynFBiPQBQZQ2aYbLkbopv3ow47Wrah4+X
         5XKA==
X-Gm-Message-State: AOAM530vwd50eFImziZRRTGmmh0QjpIfTr5x+mqBGQd6AAY3NviInAAc
        DDwoVrUwdEgSA2BxzocZehMp94zGKGj6hBOeBetBkP7UqSl3tw==
X-Google-Smtp-Source: ABdhPJxHaGv791lnvanpJDkD4mrpMfYPVyVJ/ZjkAX05695YGKG4yVynT0GxbPgJ6wLwpJI1B+eQm7ScbKsxwoqsAeg=
X-Received: by 2002:a2e:8746:: with SMTP id q6mr10165014ljj.286.1633069684934;
 Thu, 30 Sep 2021 23:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANkgwetkTUjj-bMrM4XTvk0vhGiJt3wNKPpRvzgTk-u7ZfrdXg@mail.gmail.com>
 <20210930211123.GA16927@fieldses.org> <20210930212506.GB16927@fieldses.org>
In-Reply-To: <20210930212506.GB16927@fieldses.org>
From:   Volodymyr Khomenko <volodymyr@vastdata.com>
Date:   Fri, 1 Oct 2021 09:27:54 +0300
Message-ID: <CANkgwesSz+9j8Y=c1PHLjF0BwOBkbHhN99nZ7YPS83ByK2680Q@mail.gmail.com>
Subject: Re: GSSAPI fix for pynfs nfs4.1 client code
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> Looking at the network--my server's not responding to the first data
> message.

I see that linux client (when doing mount -t nfs -o
"vers=4.1,sec=krb") always does the same
(i.e. the very 1st packet with EXCHANGE_ID operation comes with GSS
sequence number=1,
then CREATE_SESSION uses seq_num=2, and so on). If your server works
normally with a regular mount,
I don't think that my fix is not related at all to this problem

volodymyr.

On Fri, Oct 1, 2021 at 12:25 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, Sep 30, 2021 at 05:11:23PM -0400, J. Bruce Fields wrote:
> > On Thu, Sep 30, 2021 at 06:22:09PM +0300, Volodymyr Khomenko wrote:
> > > commit b77dc49c775756f08bdd0c6ebbe67a96f0ffe41f
> > > Author: Volodymyr Khomenko <volodymyr@vastdata.com>
> > > Date:   Thu Sep 30 17:53:04 2021 +0300
> > >
> > >     Fixed GSSContext to start sequence numbering from 1
> > >
> > >     GSS sequence number 0 is usually used by NFS4 NULL request
> > >     during GSS context establishment (but ignored by server).
> > >     Client should never reuse GSS sequence number, so using
> > >     0 for the next real operation (EXCHANGE_ID) is possible but
> > >     looks suspicious. Fixed the code so numbering for operations
> > >     is done from 1 to avoid confusion.
> >
> > So, I can verify that --security=krb5 works after this patch but not
> > before, good.  But why is that?  As you say, the server is supposed to
> > ignore the sequence number on context creation requests.  And 0 is valid
> > sequence number as far as I know.
>
> Looking at the network--my server's not responding to the first data
> message.
>
> I think the Linux server just has a bug.  I'll make a patch....
>
> --b.
