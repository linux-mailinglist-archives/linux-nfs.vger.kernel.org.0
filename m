Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD753FF6F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 14:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiFGMxS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbiFGMxO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 08:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8651824F25
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654606390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CteZ4Os1WnEJvKlp+beKkYEGZpnaQCnHeL2Txt/VsLY=;
        b=Ns0S4OZ/5OAJ94MYwNWMkfidUmNDfyUTDgaqMTp4Z46lJwZl5qiC+Nc1RcVb6IHWigeU4X
        6h1bBuI5On5emqzY4YzNt2Or821/TdI6j1yP6YoIapedcrEM696mQM23VJnTJ7cifpOgT/
        Agvl17l277leJuU3lxkq+PXum5w4t5k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-FmIY3mtKNaOxaF9odRZOLQ-1; Tue, 07 Jun 2022 08:53:06 -0400
X-MC-Unique: FmIY3mtKNaOxaF9odRZOLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EECF8AD570;
        Tue,  7 Jun 2022 12:53:06 +0000 (UTC)
Received: from aion.usersys.redhat.com (unknown [10.22.9.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30F96C23DBF;
        Tue,  7 Jun 2022 12:53:06 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 788E21A27C3; Tue,  7 Jun 2022 08:53:05 -0400 (EDT)
Date:   Tue, 7 Jun 2022 08:53:05 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: set cl_max_connect when cloning an rpc_clnt
Message-ID: <Yp9KMY8/bOQfbd57@aion.usersys.redhat.com>
References: <20220601173449.155273-1-smayhew@redhat.com>
 <CAFX2JfkQFoQd2UDGqtMc=FPPrtpb0Qyjj-iO-FXZUfauVcXv2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFX2JfkQFoQd2UDGqtMc=FPPrtpb0Qyjj-iO-FXZUfauVcXv2w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 06 Jun 2022, Anna Schumaker wrote:

> Hi Scott,
> 
> On Wed, Jun 1, 2022 at 1:34 PM Scott Mayhew <smayhew@redhat.com> wrote:
> >
> > If the initial attempt at trunking detection using the krb5i auth flavor
> > fails with -EACCES, -NFS4ERR_CLID_INUSE, or -NFS4ERR_WRONGSEC, then the
> > NFS client tries again using auth_sys, cloning the rpc_clnt in the
> > process.  If this second attempt at trunking detection succeeds, then
> > the resulting nfs_client->cl_rpcclient winds up having cl_max_connect=0
> > and subsequent attempts to add additional transport connections to the
> > rpc_clnt will fail with a message similar to the following being logged:
> >
> > [502044.312640] SUNRPC: reached max allowed number (0) did not add
> > transport to server: 192.168.122.3
> 
> Good catch! I was wondering if you could give me a "Fixes:" tag so it
> can be backported to stable?

Fixes: dc48e0abee24 ("SUNRPC enforce creation of no more than max_connect xprts")

> 
> Thanks,
> Anna
> 
> >
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  net/sunrpc/clnt.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index e2c6eca0271b..b6781ada3aa8 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -651,6 +651,7 @@ static struct rpc_clnt *__rpc_clone_client(struct rpc_create_args *args,
> >         new->cl_discrtry = clnt->cl_discrtry;
> >         new->cl_chatty = clnt->cl_chatty;
> >         new->cl_principal = clnt->cl_principal;
> > +       new->cl_max_connect = clnt->cl_max_connect;
> >         return new;
> >
> >  out_err:
> > --
> > 2.35.3
> >
> 

