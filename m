Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926FD683697
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Jan 2023 20:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjAaTbl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Jan 2023 14:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAaTbk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Jan 2023 14:31:40 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D99E5246
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 11:31:39 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso15458679pjb.4
        for <linux-nfs@vger.kernel.org>; Tue, 31 Jan 2023 11:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LhkeQ038JEhzEGjCdk18TZmevfaflM8a7jzCoC6THBk=;
        b=NJj6jokcwLvJwuRNwgTjQpeix7UWJ9i+E4qLeLiG2yqgWOo7ROG4YH/tYu7/b6mT8p
         4N/NNMHJuN/Q0wNoF2GkQPmhSF+bQ/OqDuPk323Ij8EB4kawhjTzkZG0VkeipbxqLdPL
         r3qoNNaQSmnGiPAWR6aXNKLa7IT9z5P0HtomnxuMTx9WfGr9YU0fJfefOCsTGpLEb8tA
         1Xq1f37MQtkmrJdR7stSsLkUVtdEv/qL3apvOtiL5Na/o/2P4ndLngz//yiCPAM38Yn4
         LaDzdfuF7XrtLBxxgl4GGSo0Lg4hmzINJQigkEonvxGUKSvlYve8W0H8HiUj+it/iXqI
         x4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhkeQ038JEhzEGjCdk18TZmevfaflM8a7jzCoC6THBk=;
        b=lkJoOn79mwTWa+5CghGRzvyWNYAn7mkEqg2JqdjevyFGEoUlMLINHfrC8YUWFKhRrp
         PrOLAnqmyYr+JsYVbBZqA9tEHTBIitdyhTfhf6ep4PjRu2tMMZldiiDOR3Rcv+wVNNWG
         CXWRDiyyoLLVF6bxe2s5+eMVlFCqVjhSTZ6DzDw0fkutULfs1TBnVlj3LeGqU5o5BroU
         MB1mimnfmVparotORLkA0JxXccdARMHQLMA/Wnhrn1TjKzgnKGvDlrtY+7+KHmtg6iu9
         1Ruzk3yzHckI1N0TVrrqDGucgapfICFUIXlvNx84F/iABNMBHTX8RXhTlIBSoZ/SWiz7
         N9Vw==
X-Gm-Message-State: AO0yUKVNBOQ21ip1KXn0Y3aAGsHmpwiokTkaAaiLwEbOCUaIipIgY44B
        gQW1jMCpWk+Gb9pMxCUEaLC2vuIqzMTT/OUGAto=
X-Google-Smtp-Source: AK7set8tYkOZu8QV7N4A8YDiZ+Kp4FmEB1hC6BI+/ip7FMrG/hV1CS9lubUbDvgN2aQj1lNlwj/jKpL2eNwUn8K0fCc=
X-Received: by 2002:a17:90a:ebd1:b0:22c:445b:d81 with SMTP id
 cf17-20020a17090aebd100b0022c445b0d81mr2825016pjb.104.1675193498815; Tue, 31
 Jan 2023 11:31:38 -0800 (PST)
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
In-Reply-To: <SA1PR09MB755212AB7E5C5481C45028A8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 31 Jan 2023 14:31:27 -0500
Message-ID: <CAN-5tyHOJ=qXUU73VsZC9Ezs7_-eZ46VDtiE_DWB3bdyr768gA@mail.gmail.com>
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

On Tue, Jan 31, 2023 at 12:12 PM Andrew J. Romero <romero@fnal.gov> wrote:
>
>
>
> > -----Original Message-----
> > From: Chuck Lever III <chuck.lever@oracle.com>
> >
> > > On Jan 31, 2023, at 9:42 AM, Andrew J. Romero <romero@fnal.gov> wrote:
> > >
> > > In a large campus environment, usage of the relevant memory pool will eventually get so
> > > high that a server-side reboot will be needed.
> >
> > The above is sticking with me a bit.
> >
> > Rebooting the server should force clients to re-establish state.
> >
> > Are they not re-establishing open file state for users whose
> > ticket has expired?
>
>
> > I would think each client would re-establish
> > state for those open files anyway, and the server would be in the
> > same overcommitted state it was in before it rebooted.
>
>
> When the number of opens gets close to the limit which would result in
> a disruptive  NFSv4 service interruption ( currently 128K open files is the limit),
> I do the reboot ( actually I transfer the affected NFS serving resource
> from one NAS cluster-node to the other NAS cluster node ... this based on experience
> is like a 99.9% "non-disruptive reboot" of the affected NFS serving resource )
>
> Before the resource transfer there will be ~126K open files
> ( from the NAS perspective )
> 0.1 seconds after the resource transfer there will be
> close to zero files open. Within a few seconds there will
> be ~2000 and within a few minutes there will be ~2100.
> During the rest of the day I only see a slow rise in the average number
> of opens to maybe 2200. ( my take is ~2100 files were "active opens" before and after
>   the resource transfer ,  the rest of the 126K opens were zombies
> that the clients were no longer using ).  In 4-6 months
> the number of opens from the NAS perspective will slowly
> creep back up to the limit.

What you are describing sounds like a bug in a system (be it client or
server). There is state that the client thought it closed but the
server still keeping that state.

>
>
>
> >
> > We might not have an accurate root cause analysis yet, or I could
> > be missing something.
> >
> > --
> > Chuck Lever
> >
> >
>
