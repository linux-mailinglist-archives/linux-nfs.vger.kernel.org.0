Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2528768364A
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 20:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjAaTUJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 14:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjAaTUH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 14:20:07 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C925B15C87
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 11:20:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w20so2020414pfn.4
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 11:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2sLS0K+ZhIkqbMsTGQaISH1ooey58GccURrwarDdyE=;
        b=G6STF4sC1IpYH+no6DBmCAcH7Dl9pIblHzbIvAB2w5vJ94fHRUn6x38dBcHVyNU/wC
         0AFLl2R04cIjjYq2wylvT71L2CKS8QjR0Q1qDuW8bSU82PNNly8kyVSQWJpgBMxb8dMB
         VL4X75iZiKpz/14U2Z8VDjvd1NOMbDvrGy3/EYnSVQL4rmyDjIT6PWL6rj63EEyw6KY6
         aZtODo26wNngBm5CNzUsBlMyvczZp+tCRasts0Uj8yqS4ixbvEMbAH39UvKwQG+Gfiog
         qypDYb+bWf0idYVxupi6T9AuxMGBEdPzmg5/W8kASuLXasdoAYAIC2UsQKhnOkfA8G3n
         y3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2sLS0K+ZhIkqbMsTGQaISH1ooey58GccURrwarDdyE=;
        b=jN/IfvmQgIWH5B15Tdifzk5sADc4E1I3LbmFmMaNpXfcr7vcJTuXyJWfmlkjK7q3jJ
         yCaHJD4PnxqvnJmEOIf48sk6LvNSXS36Z5JqkSOD0RKLXy6cOvok6ofXL4jCAw1SPy8w
         oQrUIIOd40x346YdAAK08wvoN5fVR2N4jLPTMoI1/+j1qPCdxhSFTH5lcRC4w1Hlfbxj
         +lUonw27KJPIfxG6hnPTbBj88Pc9oBdz6P6xMJVSTV6k5cYkHnhWmYJU9HWRVaF9azu6
         YnD45/zRTJ+EfWBv8zg3g6/aUWx1ZScsLEZL9XATcMEN9UOkDmRNpP+eOVVS2YHmt8bu
         Gbqw==
X-Gm-Message-State: AO0yUKUoFPCP8vfxLSfapfbpt3Vwv45ExBAGpPDYxl+oOKlvplMFEWbB
        fbvm9YEZvSgMU3ZY44bn8pq0m28E3HjL8EChYlWotF6q
X-Google-Smtp-Source: AK7set920vXvpidHAVHmr9Qpsf4vmpEbKsj23IyrDmBvifq27nHDYxuUxPed4dYVyLnv+51QdmaJziz/aU9R7E+ppEE=
X-Received: by 2002:a05:6a00:3498:b0:592:5885:862f with SMTP id
 cp24-20020a056a00349800b005925885862fmr3266989pfb.18.1675192805194; Tue, 31
 Jan 2023 11:20:05 -0800 (PST)
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
 <CAN-5tyFro=naMgub9uAZ0wa20WhZwV2Rh6xv_meNice1EG+Dug@mail.gmail.com> <046e01d935a0$7b3a2d30$71ae8790$@mindspring.com>
In-Reply-To: <046e01d935a0$7b3a2d30$71ae8790$@mindspring.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 31 Jan 2023 14:19:54 -0500
Message-ID: <CAN-5tyE+wKVtHWr+DF67DLN0pvO332dDajvBbeGyCFu1fyqdRQ@mail.gmail.com>
Subject: Re: Zombie / Orphan open files
To:     Frank Filz <ffilzlnx@mindspring.com>
Cc:     "Andrew J. Romero" <romero@fnal.gov>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 31, 2023 at 1:19 PM Frank Filz <ffilzlnx@mindspring.com> wrote:
>
> > On Mon, Jan 30, 2023 at 5:44 PM Andrew J. Romero <romero@fnal.gov> wrot=
e:
> > >
> > > Hi
> > >
> > > This is a quick general NFS server question.
> > >
> > > Does the NFSv4x  specification require or recommend that:   the NFS s=
erver,
> > after some reasonable time,
> > > should / must close orphan / zombie open files ?
> >
> > Why should the server be responsible for a badly behaving client? It se=
ems like
> > you are advocating for the world where a problem is hidden rather than =
solved.
> > But because bugs do occur and some customers want a quick solution, som=
e
> > storage providers do have ways of dealing with releasing resources (lik=
e open
> > state) that the client will never ask for again.
> >
> > Why should we excuse bad user behaviour? For things like long running j=
obs
> > users have to be educated that their credentials must stay valid for th=
e duration
> > of their usage.
> >
> > Why should we excuse poor application behaviour that doesn't close file=
s? But in
> > a way we do, the OS will make sure that the file is closed when the app=
lication
> > exists without explicitly closing the file. So I'm curious how do you g=
et in a state
> > with zombie?
>
> Don't automatically assume this is bad application behavior, though it ma=
y be behavior we don't all like, sometimes it may be for a reason. Applicat=
ions may be keeping a file open to protect the file (works best when share =
deny modes are available, i.e. most likely a Windows client). Also, won't a=
n executable be kept open for the lifetime of the process, especially if th=
e executable is large enough that it will be paged in/out from the file? Th=
is assures the same executable is available for the lifetime of the process=
 even if deleted and replaced with a new version.

Aren't you describing is a long running job (a file that needs to be
kept opened -- and not closed -- for a long period of time)? And it's
a user's responsibility to have creds that are long enough (or a
system of renewal) that covers the duration of the job. To be clear
you are talking about a long running process that keeps a file opened.
You are not talking about a process that starts, opens a file and the
process exits without closing a file.  That's poor application
behaviour I was referring too. Regardless in that situation OS cleans
up. So I'm very curious how these zombie/orphan files are being
created, how does it happens that the OS doesn't clean up.

> Now whether this kind of activity is desirable via NFS may be another que=
stion...
>
> Frank
>
