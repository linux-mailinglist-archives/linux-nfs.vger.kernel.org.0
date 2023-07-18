Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3056E757F89
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 16:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjGRObI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 18 Jul 2023 10:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjGRObE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 10:31:04 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5C1990
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 07:30:59 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-63c70dc7ed2so32485586d6.0
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 07:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689690658; x=1692282658;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCdDPOmRzvgADoIxSzmEupKrEuLOXBz11IFidsTkDOU=;
        b=Ho9yogjq6pXWIc4EP1fe13IjzP4WOhLPiQ3OXcz7ZmpDZlfnVDmTlXwOhzs+Dk6V6Z
         dEnXMcgcj39vtAcNOMBqz3QYXlpsyHXzlTVpUjPuquDf+kKlSWlE0POPVgKaZWwDtQKE
         aionKKMw6q0V2F+64At+NlBrPPLCA8ewhaPGtsuXzhX39jx4gcJ6zk8V2+Bo7+byzYpP
         jByTT0ZTT7lfBWhO/u+3ZyJnkiunSkaRawWTKRpjaOGsWY+aALGhVq7mBYFr39r+tcM/
         Qi2r3Sp95fCz8Yu4Q0bYcbLPthspY4c0SW6JZy0ES5oBa3P4Dew7q+q1f3/6FT9hp8Sc
         SxUw==
X-Gm-Message-State: ABy/qLY9DADlUlM+flZ7ky4GYeNoZz1nALeyYdnnrltLw9wCHwhmqW5P
        cqWivvVl6nNX5pCBkReQuiMM3m0zXw==
X-Google-Smtp-Source: APBJJlFBnnq4qaYBsnkfI07LVNi5U+LX12ZFA/lltgtfK54xZ6yNcExkBsMSvrfWQ0Bz74apU2YxzA==
X-Received: by 2002:a0c:b453:0:b0:636:1aae:1bc1 with SMTP id e19-20020a0cb453000000b006361aae1bc1mr15775167qvf.47.1689690658034;
        Tue, 18 Jul 2023 07:30:58 -0700 (PDT)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id y11-20020a0ce04b000000b00636141d46c7sm753055qvk.94.2023.07.18.07.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 07:30:57 -0700 (PDT)
Message-ID: <cd4cdc83d81eb23faf919136b8ddfe5e52cfc052.camel@kernel.org>
Subject: Re: [PATCH] nfsd: Remove incorrect check in nfsd4_validate_stateid
From:   Trond Myklebust <trondmy@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 18 Jul 2023 10:30:56 -0400
In-Reply-To: <0F52C77C-C1AA-48E1-B30A-CD15342EEAFF@oracle.com>
References: <20230718123837.124780-1-trondmy@kernel.org>
         <6dc89e4859a6851773bc2931d919e1cb204ae690.camel@kernel.org>
         <106daf5e0242b67bdb04e2e8e4ae7e114a4b47ab.camel@kernel.org>
         <0F52C77C-C1AA-48E1-B30A-CD15342EEAFF@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-18 at 14:12 +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 18, 2023, at 9:51 AM, Trond Myklebust <trondmy@kernel.org>
> > wrote:
> > 
> > On Tue, 2023-07-18 at 09:35 -0400, Jeff Layton wrote:
> > > On Tue, 2023-07-18 at 08:38 -0400, trondmy@kernel.org wrote:
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > 
> > > > If the client is calling TEST_STATEID, then it is because some
> > > > event
> > > > occurred that requires it to check all the stateids for
> > > > validity
> > > > and
> > > > call FREE_STATEID on the ones that have been revoked. In this
> > > > case,
> > > > either the stateid exists in the list of stateids associated
> > > > with
> > > > that
> > > > nfs4_client, in which case it should be tested, or it does not.
> > > > There
> > > > are no additional conditions to be considered.
> > > > 
> > > > Reported-by: Frank Ch. Eigler <fche@redhat.com>
> > > > Fixes: 663e36f07666 ("nfsd4: kill warnings on testing stateids
> > > > with
> > > > mismatched clientids")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Trond Myklebust
> > > > <trond.myklebust@hammerspace.com>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > > 
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 6e61fa3acaf1..3aefbad4cc09 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -6341,8 +6341,6 @@ static __be32
> > > > nfsd4_validate_stateid(struct
> > > > nfs4_client *cl, stateid_t *stateid)
> > > >         if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> > > >                 CLOSE_STATEID(stateid))
> > > >                 return status;
> > > > -       if (!same_clid(&stateid->si_opaque.so_clid, &cl-
> > > > > cl_clientid))
> > > > -               return status;
> > > >         spin_lock(&cl->cl_lock);
> > > >         s = find_stateid_locked(cl, stateid);
> > > >         if (!s)
> > > 
> > > IDGI. Is this fixing an actual bug? Granted this code does seem
> > > unnecessary, but removing it doesn't seem like it will cause any
> > > user-visible change in behavior. Am I missing something?
> > 
> > It was clearly triggering in
> > https://bugzilla.redhat.com/show_bug.cgi?id=2176575
> > 
> > Furthermore, if you look at commit 663e36f07666, you'll see that
> > all it
> > does is remove the log message because "it is expected". For some
> > unknown reason, it did not register that "then the check is
> > incorrect".
> 
> I don't think 663e36f altered this logic: it "returned status"
> when it emitted the warning, and it "returned status" after
> the warning was removed.
> 
> 
> > So yes, this is fixing a real bug.
> 
> If there is a bug, wouldn't it have been introduced when the
> "!same_clid()" check was added?
> 

Correct.

> Fixes: 7df302f75ee2 ("NFSD: TEST_STATEID should not return
> NFS4ERR_STALE_STATEID")
> 

It can't fix anything older than that patch, because it won't apply.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


