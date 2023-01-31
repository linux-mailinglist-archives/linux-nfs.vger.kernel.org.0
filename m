Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A19A68398D
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 23:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjAaWrr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 17:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjAaWrq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 17:47:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3054210
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 14:47:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l4-20020a17090a850400b0023013402671so128537pjn.5
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 14:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu+UveQQ7/6hjal8Wp4useyLiFQ+PWTQ0D0Hw2Wr6Q0=;
        b=kd83u5/62K15p6FEvIFb03qG4AyZtkCRpl1vlmFbQOzqGQJx4j+Xk20/M4L9NV8tIo
         wfpJl3a19+w5jXxJVNAYiA5lU0hN7aeSevF3+GCf0GFi00iEMc+P9WVPElmr/rq8xw41
         H/f/UFBefS+IS5MEHp0TnnGo8CjTkQkvGCQ0Efx6IrbVxm9bVpn5KT1zp3aBW85RbkYT
         pB4fWByGzBmo+WBmUj0NDRtAYyvrBIUU/8tZgnPLnt0brgEfG2nzd2LyR9lmwyw9EMfo
         60QM6xYC1UNbWF7qIlm8vQY3qYfmh7LFJGZu7hp0nj2vrvldriRVubIj11M1e9jOf+QZ
         LByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zu+UveQQ7/6hjal8Wp4useyLiFQ+PWTQ0D0Hw2Wr6Q0=;
        b=RldwJ+n5vEK7CsQW45Q6cOrU0Okd8ygzAQrNramU7u4N1364UttWazgNbYqbWumJWp
         22jQPpmb1U15kYGuLl8Qi3/TPr9D0L4MteTekurvVqpn+NJGMJ4uzkB5AYpVpzsWXmV3
         Lw/wCEFqFVl1GlmTKQ1c8Zs3RrXaCe9cSmdEbvQDokwwQqtgT5r1tfUQJ1Lqt9tngV/2
         z9lnT3eK0ehKy3wZbHv5Sn0g4+GoMsJhBtW/WLdZNYBZxuUPViyZ6lZzcKoXu44tp9Sg
         jFwLpjCmelfR/sQx3vm7crYgGv/RLovkFhFvRcTGqBKMtluRz1yE6/m2TStIjY4v/UKq
         /7ew==
X-Gm-Message-State: AO0yUKVPViRkJDSe0IlzXjV5KNIaITgqxBkLS9daLWLpk9kSdFU7utWE
        txF2lnT8TmgfduR0GmNP3TAFcIpxLvXrriKS5zQ=
X-Google-Smtp-Source: AK7set+Eq9g3Z8g8MH21q9wyecgusDEu/44L8FtOEAa4Jv3GtUQKzqttnV64xKlyNBgw5hTospDgO7tmL+7VBDf/J/Y=
X-Received: by 2002:a17:902:e74f:b0:196:1c5a:55cf with SMTP id
 p15-20020a170902e74f00b001961c5a55cfmr124033plf.15.1675205256031; Tue, 31 Jan
 2023 14:47:36 -0800 (PST)
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
 <CAN-5tyGdaL_pYgqgS0TDwqCzVu=0rgLau8TDZMTe+hmC395UtQ@mail.gmail.com> <SA1PR09MB7552674B97042D59646F6EF1A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
In-Reply-To: <SA1PR09MB7552674B97042D59646F6EF1A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 31 Jan 2023 17:47:24 -0500
Message-ID: <CAN-5tyGQrW-DDa8E+jzwdJuJa1swtq31kd6u_0nPoZXwpJPu=g@mail.gmail.com>
Subject: Re: Zombie / Orphan open files
To:     "Andrew J. Romero" <romero@fnal.gov>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

On Tue, Jan 31, 2023 at 5:26 PM Andrew J. Romero <romero@fnal.gov> wrote:
>
> Hi Olga
>
> This is great info !
>
> Can you make sure that the host principal is not granted any
> read or write access ( via  ACL entry, owner, group or Everyone access)
> to the actual directory and file being opened.
>
> If, by spec or well established convention,  the client host principal just needs to submit the "close request"
> to the NFS server ; but, needs no access to the actual directory tree or files, then
> my NAS vendor will need to take action.
>
> If I need to grant directory / file access to all host principals on-site
> I will probably get serious computer-security opposition.

Closing a file has nothing to do with having access to the file. As
per spec, doing state operations should be allowed by the machine
principal.

Here's the paragraph of the spec stating that things like CLOSE must be allowed:

In cases where the server's security policies on a portion of its
namespace require RPCSEC_GSS authentication, a client may have to use
an RPCSEC_GSS credential to remove per-file state (e.g., LOCKU, CLOSE,
etc.). The server may require that the principal that removes the
state match certain criteria (e.g., the principal might have to be the
same as the one that acquired the state). However, the client might
not have an RPCSEC_GSS context for such a principal, and might not be
able to create such a context (perhaps because the user has logged
off). When the client establishes SP4_MACH_CRED or SP4_SSV protection,
it can specify a list of operations that the server MUST allow using
the machine credential (if SP4_MACH_CRED is used) or the SSV
credential (if SP4_SSV is used).

If the NAS vendor is disallowing it then they are in the wrong.

>
> Thanks !
>
> Andy
>
> >
> > What you describe  --- having different views of state on the client
> > and server -- is not a known common behaviour.
> >
> > I have tried it on my Kerberos setup.
> > Gotten a 5min ticket.
> > As a user opened a file in a process that went to sleep.
> > My user credentials have expired (after 5mins). I verified that by
> > doing an "ls" on a mounted filesystem which resulted in permission
> > denied error.
> > Then I killed the application that had an opened file. This resulted
> > in a NFS CLOSE being sent to the server using the machine's gss
> > context (which is a default behaviour of the linux client regardless
> > of whether or not user's credentials are valid).
> >
> > Basically as far as I can tell, a linux client can handle cleaning up
> > state when user's credentials have expired.
> > >
> > >
> > >
> > > Andy
> > >
> > >
> > >
> > >
> > >
