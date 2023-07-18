Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54366757E2A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 15:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjGRNvf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 18 Jul 2023 09:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGRNve (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 09:51:34 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D99398
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 06:51:33 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-403b36a4226so30215251cf.0
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 06:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689688292; x=1692280292;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soZjzBFx9rRvxI8NaKcPcdFgo86l+KYfnuxZdlrt0Z0=;
        b=FQaGHBg6jbARuGJK+maEiK1D385F6G/0o3NankAk1Y9O/T9ys5UCMn8sdXiBd6pdK5
         LEMognkwxsAIpgKwndkG7UlkY4t2mNM8Amojwgf12TW64IFI773USoi5LjlRFclFLI5D
         Y80h0iHtUx8CEODlcJIOWP9eq5zaix9gXYl1X8G5byKEyu1KCscx+jt+zY9SdBtUd+83
         Q0QSNMe2PTq0vHdyLlRpnfJqI9racHSaSRXjlkbrBGY0jA9sgVJdcBKaSGqcdnwCbxxO
         Nd1xAZQBpdb11lldjIdd0pO/g7EVsSL/UvGbYdiDsxlCtKbqpXYbe2fVL0IS1g9UZRbr
         35Hw==
X-Gm-Message-State: ABy/qLagcv8vLtVI2iTgkpSP5iA0dQlLU2wknjyno7jRPuID8/8wLIQk
        WPr03ujWpXItjRV3ekbHOKgWrsRVvg==
X-Google-Smtp-Source: APBJJlHn7TdfCkY0o3nHQQ+G2SNt9DFn+qxJKfvPZwhnMG2y/si1FpAJls7JiLbRkjMNQla+tCmI0Q==
X-Received: by 2002:a05:622a:215:b0:403:fd78:ff46 with SMTP id b21-20020a05622a021500b00403fd78ff46mr1094471qtx.52.1689688292427;
        Tue, 18 Jul 2023 06:51:32 -0700 (PDT)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id d23-20020ac84e37000000b0040338d69f51sm639785qtw.80.2023.07.18.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:51:31 -0700 (PDT)
Message-ID: <106daf5e0242b67bdb04e2e8e4ae7e114a4b47ab.camel@kernel.org>
Subject: Re: [PATCH] nfsd: Remove incorrect check in nfsd4_validate_stateid
From:   Trond Myklebust <trondmy@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 09:51:31 -0400
In-Reply-To: <6dc89e4859a6851773bc2931d919e1cb204ae690.camel@kernel.org>
References: <20230718123837.124780-1-trondmy@kernel.org>
         <6dc89e4859a6851773bc2931d919e1cb204ae690.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-18 at 09:35 -0400, Jeff Layton wrote:
> On Tue, 2023-07-18 at 08:38 -0400, trondmy@kernel.org wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > 
> > If the client is calling TEST_STATEID, then it is because some
> > event
> > occurred that requires it to check all the stateids for validity
> > and
> > call FREE_STATEID on the ones that have been revoked. In this case,
> > either the stateid exists in the list of stateids associated with
> > that
> > nfs4_client, in which case it should be tested, or it does not.
> > There
> > are no additional conditions to be considered.
> > 
> > Reported-by: Frank Ch. Eigler <fche@redhat.com>
> > Fixes: 663e36f07666 ("nfsd4: kill warnings on testing stateids with
> > mismatched clientids")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> >  fs/nfsd/nfs4state.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 6e61fa3acaf1..3aefbad4cc09 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6341,8 +6341,6 @@ static __be32 nfsd4_validate_stateid(struct
> > nfs4_client *cl, stateid_t *stateid)
> >         if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> >                 CLOSE_STATEID(stateid))
> >                 return status;
> > -       if (!same_clid(&stateid->si_opaque.so_clid, &cl-
> > >cl_clientid))
> > -               return status;
> >         spin_lock(&cl->cl_lock);
> >         s = find_stateid_locked(cl, stateid);
> >         if (!s)
> 
> IDGI. Is this fixing an actual bug? Granted this code does seem
> unnecessary, but removing it doesn't seem like it will cause any
> user-visible change in behavior. Am I missing something?

It was clearly triggering in
https://bugzilla.redhat.com/show_bug.cgi?id=2176575

Furthermore, if you look at commit 663e36f07666, you'll see that all it
does is remove the log message because "it is expected". For some
unknown reason, it did not register that "then the check is incorrect".

So yes, this is fixing a real bug.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


