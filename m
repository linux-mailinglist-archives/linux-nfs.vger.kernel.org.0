Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAC68728B
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Feb 2023 01:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBBAxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Feb 2023 19:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBBAxU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Feb 2023 19:53:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D8410A83
        for <linux-nfs@vger.kernel.org>; Wed,  1 Feb 2023 16:53:18 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 88so421888pjo.3
        for <linux-nfs@vger.kernel.org>; Wed, 01 Feb 2023 16:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wKwPA1tP95IXuwze3pus7M1XUKHovvCv+MW3PRQKbTs=;
        b=fhDF9gSjNYOrwU3Pxt/6Bhca282A6nRmiQl/wDWkw4oVFtzMQ0yNWZqJA5jA+tRn8o
         KNAQM8wtPTA1tZ0nd/VTA3gyfQWHaC76RHQNKjxcUPuxrqWxs04pVbSpYRoL/kNQncqZ
         WIbvkDBM1y+AQpj3LBmRfrAKo8VvifwiBmdWtkqNebgMLPp/eKbBjDE0u7J1c83lFtM5
         +n0KsLnV+OEXrSyCHRHI3IT1TQi0jUQtqzeRCy45xWFQL68NfFZng1Abt35eBxkUe6cj
         vB9knAcA+tTohLYxIJ2p9072/P7U0CQEF/0H/lRjgDCmNNdIXakRShisYKWRDn+CbMV2
         277A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKwPA1tP95IXuwze3pus7M1XUKHovvCv+MW3PRQKbTs=;
        b=416kFbw99YeBiK4kRm9wjqvaAoSEGl7TGI6q0fvlM/7R5v2rN3hJoTK67oaN4ws11E
         5TIL6v1vLgjKYXqMroXeXZxRWpGWJzaR8eS7ADPcpGMBNs8N5xW2QXofz9v9R6UEkJhf
         Fm0ZGBIGAMgOxX71/1S2UEEoZqRU8jokOqphdZGoJKp2MKi0V3uONdd4gWCBJXdQRsxq
         eGmzZEGo29u7RQuEhI+ITFsaNOsPnaRkQYyJXYG7Fd/cV6GVXYQeMxM3AlSsYV66eL8s
         cXwg2oZMyYWdqmJhVUCQ+XrHRkCe9iB8GbaPyIpeCTlLhsUeicqyoSABFjgSDnJNVasP
         pGQw==
X-Gm-Message-State: AO0yUKWdLarTibf9//qpzB53rRUwBvnc0/il8Zf1B5pVPkb0Fi6aUIP8
        EQ8OMuQVPM7nDUh8+F4HwH8e3pktUDfms88y7Bi+Rfpj
X-Google-Smtp-Source: AK7set+kfQevrToQvR9LUA9ZQtPyd+OXJQo2mWMn0RCvavRSUc8FBRscPh5kzsrpuHfoE9LK5mlS2xiUC/8VQj+ukcQ=
X-Received: by 2002:a17:902:be17:b0:198:b624:f4c2 with SMTP id
 r23-20020a170902be1700b00198b624f4c2mr699295pls.6.1675299198113; Wed, 01 Feb
 2023 16:53:18 -0800 (PST)
MIME-Version: 1.0
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
 <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
 <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <0BBE155A-CE56-40F7-A729-85D67A9C0CC3@oracle.com> <SA1PR09MB755212AB7E5C5481C45028A8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyHOJ=qXUU73VsZC9Ezs7_-eZ46VDtiE_DWB3bdyr768gA@mail.gmail.com>
 <SA1PR09MB7552C7543CE6E9D263C070D4A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyGdaL_pYgqgS0TDwqCzVu=0rgLau8TDZMTe+hmC395UtQ@mail.gmail.com>
 <SA1PR09MB7552674B97042D59646F6EF1A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyGQrW-DDa8E+jzwdJuJa1swtq31kd6u_0nPoZXwpJPu=g@mail.gmail.com>
 <SA1PR09MB7552AB9D248410D0DE9866B2A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyHnrFe5sZvd7MZ3NgdLhv8AyGUxu7ioJ3zb4ouj0Lq5Mw@mail.gmail.com>
 <SA1PR09MB755217D2B3E29E9486D4796FA7D19@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyGaX=Go+kwrM33K2EaY41sXmf4v1+2JO8MhbDuGTGG7zA@mail.gmail.com> <SA1PR09MB755277F59EB463643BEBDD77A7D69@SA1PR09MB7552.namprd09.prod.outlook.com>
In-Reply-To: <SA1PR09MB755277F59EB463643BEBDD77A7D69@SA1PR09MB7552.namprd09.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 1 Feb 2023 19:53:06 -0500
Message-ID: <CAN-5tyHS=Ru_5fojUuHhxumsXHv+z6evfGsowb7J1PMENKNTTA@mail.gmail.com>
Subject: Re: Zombie / Orphan open files
To:     "Andrew J. Romero" <romero@fnal.gov>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
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

adding back the mailing list.

On Wed, Feb 1, 2023 at 7:22 PM Andrew J. Romero <romero@fnal.gov> wrote:
>
>
>
> > > Is the default behavior, of using MACHINE CREDENTIALS
> > > for certain state control operations,  in place when NFS v4.0 is being used ?
> > > or only if 4.1 or greater are being used ?
> >
> > This is only for 4.1+.
> >
>
> Our NAS is v4.0 .... they will release their 4.1 soon
>

Ah see not sure why I didn't ask on the thread what nfs version it was
and right away jumped to talking about 4.1+. With 4.0, operations such
as open/close would be done with the user's credentials. If they
expire, that's a problem. 4.1 protocol is preferred over 4.0 for
variety of reason and thing could be one of them.

I can confirm that the same experiment I've done with 4.1, with 4.0
leads to the client not sending an open to the server (since it has no
creds to use).

I don't believe there are any provisions in the 4.0 spec for allowing
something like a CLOSE to be sent with something other than the
principal's creds that created that state.
