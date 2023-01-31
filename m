Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E44683616
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 20:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjAaTIr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 14:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjAaTIr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 14:08:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5D343478
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 11:08:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 88so15112108pjo.3
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 11:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LqDw/6pV9YZJMNmIbj6MqKDZFxJS8nVgQ+GtTY8OyzE=;
        b=QCcLcsIcHQWz+iq+zqHaL1g+VAPUubOj2aZnp5BHboB979oKg+aw03klMH2Y/tdqUy
         GiUCRdt29zQ/o53hDxfNdm8P5ncKAQvjkqSjVRcPohl0aJ1I9yc7R6/bo3ckDId1t5Iq
         V9k2frHtozPK09oD29JWoCwLBoMIcwAhQejDdoLR2fNtrbgkZ/hgx0AB97083CPBcuPC
         YCp1UhOzD5EYqOnrH3SyDkbqpaIn9/xKvtRAqv8pIOIPUo6tCm/40h9uNhr3yzuWcIDT
         onfVG+Kx9gWbfqGv8PPAulUhgMiBwoLXLD0NPfbu9V4qJTfGj22D4goVjtcWGoz6U+dw
         ufVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LqDw/6pV9YZJMNmIbj6MqKDZFxJS8nVgQ+GtTY8OyzE=;
        b=kkydD4n5xnhJfjteCyXAber0EdF8bWRbcqdlVd6MsFDr6mnDCgsXZeLr3E2vo5TmnL
         IZQBQNLnDQmT1OW6bZYKGCzpTD2+Fyl5fLOCa2B5S9LHZeXmO0PQkpWWXqWd0jKnKQwv
         g2twuEII7kynFvQe2RlalIvCS5GvWM6TKdglzOxEEWN1O9hlm2ZNtywAV/rn4kGkMopz
         B/tXtEgE0MwzwCJIygIOza/5iC1FVrlD4YRZihytuhLlBwNmQysNLgDwQlQQ6n5TioKU
         oKz7kL3pEOXIDv3x2AN2sipPV6CFL6lfBZlluc3voCOXItAXws9iMW+G76q9HC2y5fLP
         CWkQ==
X-Gm-Message-State: AO0yUKVjuv8EdUcot0nZDTyBf0zEVXXou3dWR0K29a94AHglbffEt759
        h7oVqdK1Tqld+HC4Fs5DvXdF67sbKV7024k6UKc=
X-Google-Smtp-Source: AK7set9ws8A+KNTaMUpCte0iFDFtypQWJQGJX3XRzo4FjlAovPu8x9+BzEP5I+B1VFDg8zKGjxHdXOlVZIZ/nuNIfEA=
X-Received: by 2002:a17:90a:8909:b0:22c:b87b:80d6 with SMTP id
 u9-20020a17090a890900b0022cb87b80d6mr1148830pjn.156.1675192124971; Tue, 31
 Jan 2023 11:08:44 -0800 (PST)
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
 <25395E08-073E-4572-A46D-A2228DB0212E@oracle.com> <SA1PR09MB7552B00147DBC9200BB8CDBAA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
In-Reply-To: <SA1PR09MB7552B00147DBC9200BB8CDBAA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 31 Jan 2023 14:08:33 -0500
Message-ID: <CAN-5tyGyCNW1Za1gLR7RD=iLgvyDZaWt+=axiLCp7mc6j0bVbQ@mail.gmail.com>
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

On Tue, Jan 31, 2023 at 1:35 PM Andrew J. Romero <romero@fnal.gov> wrote:
>
>
>
> >
> > That's not the way state recovery works. Clients will reopen only
> > the files that are still in use. If the clients don't open the
> > "zombie" files again, then I'm fairly certain the applications
> > have already closed those files.
>
> Hi
>
> In the case of my test script , I know that the files were not
> closed explicitly or on script termination.

How do you know that the files were not closed on the script
termination? One way to see what the OS might be doing for you is to
grab either a set of tracepoints or a network trace. A client would
have sent the close but it was for some reason rejected by the server?

> ( script terminated
> without credentials ) .   By the time my session re-acquired credentials
> ( intentionally after process termination) , the process was already terminated
> and nothing, on the client, would ever attempt to clean-up the
> server-side "zombie open files"
>
> The server-side pool usage caused by my intentionally
> bad test script was not freed up until I did the cluster resource migration.

Once you did a migration event (which is how storage can recover from
having unrecoverable state btw), if the client (ie., the kernel, not
the script) "truly" didn't close files, then the kernel would have
recovered the open state again. However, I suspect that a resource
migration event helps to get out of a bad state. Which means, the
client (ie, kernel) did try to close the file but failed to do so
(lack of creds as you say) and since the kernel won't try to recover
from the lack of creds forever, it might give up on doing the close.
Yet, on the server side that state would remain. And something like a
migration event (which is non-disruptive to the client) is a way to
get out of such situations.

> Question:
> When a simple app (for example a python script ) on the NFS client
> simply opens a text file,  is a lease automatically, behind the scenes,
> created on the server. If so, is the server responsible for doing this:
> If the lease isn't renewed every N minutes, close the file.
>
> By "simply opens" a text file, I mean that:   the script contains no
> code to request or in any way explicitly use locks
>
>
>
> Thanks
>
>
