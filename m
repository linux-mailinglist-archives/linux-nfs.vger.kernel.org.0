Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC8683282
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 17:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAaQ1K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 11:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaQ1J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 11:27:09 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E25354232
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 08:27:07 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v23so15623868plo.1
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C4vB+u0yQ8TuW40gEIkW4Yd2mhTQ/apbWouxbq9s9dU=;
        b=jFIQM8KwYn2t7gE7nZUneaZ2/yKQPs5yEPwb7bgbf3dalLDhrbKu429xUrqRXSPjjR
         9Ea1FVj4kloyDB1V8s/03TCVhKP9umf7iMbCoCvddRtfBngfSSmyGxuxZBKvmu/ab8QZ
         8m3rJ1fZwaGstqVQBgO7IzBqaOlBCi5QRqRFI7kSxlWmIg94T7IJpkCfk7GdIhOpiMDn
         w9V6U3qFHz+TzdNnPWeq2FgCZgJ4Hr779eNQTzKpgrZ0ZQ6U1OimSnWIHDa+VQsHAJcx
         XVHQQz4pz55hNpmXnWd9Q1256u153UipRkg0GLG1vVMLG3sQZjaFDUV6ih1FD5bpuwsP
         sEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4vB+u0yQ8TuW40gEIkW4Yd2mhTQ/apbWouxbq9s9dU=;
        b=39occcZ7b9IiDMiA2B0QBew0VH1gpKCEhodwsYuETuz9wuvhpjmgspN8Fl6c8o67zV
         0fxHJ3KHdf4JHF/umcN/4VUvMkVWvZLv6gffC3S2GP5m7bzmivt5XGO2yFS3ufpeFQ0b
         AdB3aOtRaOisDtZ9Rvy3wg30e7lqVe7wj4+gU6HeYkpgKCVgkNv6lM3F5xrUxjfPXMkU
         cSfA08qiyae6UO8ej2chL/UifD+VSjjoNhz04sx7pQJG9BIMoTB48oecn0v6QpeEN6SC
         sZkK5+g3yHY/bGJiR6Cj7pOj3gzjH6wlNa+d7IOGpkSkKicJP4fKT6zeqAP8Tgly/CY8
         uwJg==
X-Gm-Message-State: AO0yUKVgnPNmqAfvl+rQzYumni+miONtsGAod+ieyWpwPXC/lYRqVciz
        +DnZeDbJDI1C6cNYSmr1aHH4kLMpLWHm9i5cmj4=
X-Google-Smtp-Source: AK7set81SYmTA87C5Oe0V2fpXeuEJKHgluMWO5v0HQBhfRGf0NyNwgRdnOyEjuu22bw9SEOCcChaYS8EUvHCR1Jrymw=
X-Received: by 2002:a17:902:d4c7:b0:189:5859:adfd with SMTP id
 o7-20020a170902d4c700b001895859adfdmr80766plg.6.1675182426688; Tue, 31 Jan
 2023 08:27:06 -0800 (PST)
MIME-Version: 1.0
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org> <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
In-Reply-To: <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 31 Jan 2023 11:26:55 -0500
Message-ID: <CAN-5tyFro=naMgub9uAZ0wa20WhZwV2Rh6xv_meNice1EG+Dug@mail.gmail.com>
Subject: Re: Zombie / Orphan open files
To:     "Andrew J. Romero" <romero@fnal.gov>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 30, 2023 at 5:44 PM Andrew J. Romero <romero@fnal.gov> wrote:
>
> Hi
>
> This is a quick general NFS server question.
>
> Does the NFSv4x  specification require or recommend that:   the NFS server, after some reasonable time,
> should / must close orphan / zombie open files ?

Why should the server be responsible for a badly behaving client? It
seems like you are advocating for the world where a problem is hidden
rather than solved. But because bugs do occur and some customers want
a quick solution, some storage providers do have ways of dealing with
releasing resources (like open state) that the client will never ask
for again.

Why should we excuse bad user behaviour? For things like long running
jobs users have to be educated that their credentials must stay valid
for the duration of their usage.

Why should we excuse poor application behaviour that doesn't close
files? But in a way we do, the OS will make sure that the file is
closed when the application exists without explicitly closing the
file. So I'm curious how do you get in a state with zombie?

> On several NAS platforms I have seen large numbers of orphan / zombie open files "pile up"
> as a result of Kerberos credential expiration.
>
> Does the Red Hat NFS server "deal with" orphan / zombie open files ?
>
> Thanks
>
> Andy Romero
> Fermilab
>
>
