Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8943B5404BE
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345697AbiFGRTF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 13:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345659AbiFGRS6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 13:18:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C7F104CBD
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 10:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6CD5B822B4
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 17:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6659EC36B0E
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 17:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654622332;
        bh=F07bJEoT+m1KhPzKCPn4NYUlUGs7DKn+SxtiFkxAgN0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uKj9padEnWphqjrlo13wBH3DlJVSqlUvSfBBseq537+z2r4/t2AudIfRTPX09BL2x
         7405UaHrZwzaVTPqLxVoPfNvoUNBELAOMAT0gF1qH7S33nJ3tPEID0YpoN44ldPT5F
         JVpPxQjSwrdWZosCpPY5qkPs4bdCMR5bXHvoqohCk8YtqrmSFZTRsMI0v6Knd4HFYh
         6gB4Xr/8UoWU67Vl9lAKZR2rt+vaJ4ege3RIdUEkvWq9bbIGb5wAsOV4J947Zjaewx
         PWlJR/INDaYgbN/m63D+p3HCUo0WKq76AKvmcPhu+jyeMfKAF2MW946MUb5X3Ga/iG
         QVmzMFpamum4A==
Received: by mail-wm1-f47.google.com with SMTP id z17so4834740wmi.1
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jun 2022 10:18:52 -0700 (PDT)
X-Gm-Message-State: AOAM532Z1UT41nLlE8+h2t7ZJxqU5LLOCuQB6WEXc33ViNK01lnWdgmb
        3DPCMm7qvDCtkrWcT4T3w/v4lalogTFNobiy9F8=
X-Google-Smtp-Source: ABdhPJyMK6LTfrH4CWlhTiYiNIU1NFXj26hKk/gdyHgE6EA3JpCu0RuijxBz0aK5H5BB3aVEaot/Usex6X8JFhs2q5I=
X-Received: by 2002:a05:600c:4f51:b0:397:86a9:b827 with SMTP id
 m17-20020a05600c4f5100b0039786a9b827mr56525329wmq.114.1654622330875; Tue, 07
 Jun 2022 10:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220601173449.155273-1-smayhew@redhat.com> <CAFX2JfkQFoQd2UDGqtMc=FPPrtpb0Qyjj-iO-FXZUfauVcXv2w@mail.gmail.com>
 <Yp9KMY8/bOQfbd57@aion.usersys.redhat.com>
In-Reply-To: <Yp9KMY8/bOQfbd57@aion.usersys.redhat.com>
From:   Anna Schumaker <anna@kernel.org>
Date:   Tue, 7 Jun 2022 13:18:34 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfm8Dk83owBu7eQ72==394u1HaStSydXx6T=B3fC8FXt4g@mail.gmail.com>
Message-ID: <CAFX2Jfm8Dk83owBu7eQ72==394u1HaStSydXx6T=B3fC8FXt4g@mail.gmail.com>
Subject: Re: [PATCH] sunrpc: set cl_max_connect when cloning an rpc_clnt
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 7, 2022 at 8:53 AM Scott Mayhew <smayhew@redhat.com> wrote:
>
> On Mon, 06 Jun 2022, Anna Schumaker wrote:
>
> > Hi Scott,
> >
> > On Wed, Jun 1, 2022 at 1:34 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > >
> > > If the initial attempt at trunking detection using the krb5i auth flavor
> > > fails with -EACCES, -NFS4ERR_CLID_INUSE, or -NFS4ERR_WRONGSEC, then the
> > > NFS client tries again using auth_sys, cloning the rpc_clnt in the
> > > process.  If this second attempt at trunking detection succeeds, then
> > > the resulting nfs_client->cl_rpcclient winds up having cl_max_connect=0
> > > and subsequent attempts to add additional transport connections to the
> > > rpc_clnt will fail with a message similar to the following being logged:
> > >
> > > [502044.312640] SUNRPC: reached max allowed number (0) did not add
> > > transport to server: 192.168.122.3
> >
> > Good catch! I was wondering if you could give me a "Fixes:" tag so it
> > can be backported to stable?
>
> Fixes: dc48e0abee24 ("SUNRPC enforce creation of no more than max_connect xprts")

Thanks! Applied for a -rc pull request

>
> >
> > Thanks,
> > Anna
> >
> > >
> > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > ---
> > >  net/sunrpc/clnt.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > > index e2c6eca0271b..b6781ada3aa8 100644
> > > --- a/net/sunrpc/clnt.c
> > > +++ b/net/sunrpc/clnt.c
> > > @@ -651,6 +651,7 @@ static struct rpc_clnt *__rpc_clone_client(struct rpc_create_args *args,
> > >         new->cl_discrtry = clnt->cl_discrtry;
> > >         new->cl_chatty = clnt->cl_chatty;
> > >         new->cl_principal = clnt->cl_principal;
> > > +       new->cl_max_connect = clnt->cl_max_connect;
> > >         return new;
> > >
> > >  out_err:
> > > --
> > > 2.35.3
> > >
> >
>
