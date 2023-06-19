Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24C735FEF
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jun 2023 00:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjFSWt4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jun 2023 18:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFSWt4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jun 2023 18:49:56 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5F5E54
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jun 2023 15:49:54 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b072753301so11578921fa.1
        for <linux-nfs@vger.kernel.org>; Mon, 19 Jun 2023 15:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1687214992; x=1689806992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuevwNfqJdBC4EHOgC0lRBwg5Gz4Btd5JsBTI52JGhk=;
        b=o0ZQvJUuOKjWaGJ1pCArT1HiLdrSjx0+BKRw+h6cdequjTVT0yMGh2oqCErGI8PUic
         AWXYsrgzb5NrEd/ynR3E1xOqcQUyBN5g2SY53aiMgxb7z8WVHAllrtpEC+V1WiLdoIZv
         XDMYW4tXuwNI7HM5/6b8fDN8eN1i5dqpiBRRlpZ9s9Xo5ASnXJkZry9ggfITY4qswMCN
         U/1qy0R+3xD1C5OFlKqxQlXycduWlk1cWt7UU9g1h79y08zXwWp8MDWdtDaPTHIu+NMR
         tuDOEJJq9mPyoZ/4weuz8jU2Y1TvVsjQ6YxaTuvJjp/bzn7YA22HpH07OCnZAmWiqF3Y
         X8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687214992; x=1689806992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuevwNfqJdBC4EHOgC0lRBwg5Gz4Btd5JsBTI52JGhk=;
        b=Nlw89OEl5poCuxEEWEVCvHCR5Fdh3Y4DuFUmCXQfoWmEpvt3vMa9nCDwdJ2IJAn/3J
         WhkfDo6n0cMBTcdWgm3meiBPsvoZDJXatgZCJkNlOG8fXoQFSr/xpTqxyaX++I7jaltK
         5ch2WNSDkRLyjY6k011VN0I0vld1AlJRIIG7W8Glrl9yHkhAWB2hcAbBF0ikQ+62sXpb
         tMHUciSc034qfmO9MImJGMHBGWR0kG3AcZ+Z/47cZkUOFluv1RYCUcTRDzfK2D1J5/OP
         z7/1+Qp9vogXqnmaTD8F+Ftcpz1d8LyPGNWAZQwxZdsHaR0FnPeowAUYqsrUCfDA6A9P
         FXYw==
X-Gm-Message-State: AC+VfDwecdp3O32UW4a8pwvFmkR6wejONcy7SyHLbmBwAWsNa5T1lKbh
        7RdUDUHkCOE/8IVmVerc8sDrKhY+TPtSkejIlBThOs/+Sow=
X-Google-Smtp-Source: ACHHUZ6cinvb/unGZbDWUTZP7KquPED9JuRsAw+71cXa6gMSHsHT3pgFuO6DB+HgpXT6z/RFuKa68d2LPixOAiDYHvs=
X-Received: by 2002:a2e:8e2f:0:b0:2b4:60c0:1ac9 with SMTP id
 r15-20020a2e8e2f000000b002b460c01ac9mr3825793ljk.2.1687214992016; Mon, 19 Jun
 2023 15:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <f9651599-846e-3331-9353-8a8264de1a27@oracle.com>
 <d5efe21b5f6a4bc7edd0f8ed441f63aa76b7e41a.camel@hammerspace.com> <D1821C7B-7A7E-4B99-BAB2-89AF03223605@oracle.com>
In-Reply-To: <D1821C7B-7A7E-4B99-BAB2-89AF03223605@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 19 Jun 2023 18:49:38 -0400
Message-ID: <CAN-5tyHR-Pev9Askv=CTVP7WtJ2L=r0Kzc7uaFer_5C6-OzMkA@mail.gmail.com>
Subject: Re: NFSv4.0 Linux client fails to return delegation
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Dai Ngo <dai.ngo@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 19, 2023 at 4:02=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Jun 19, 2023, at 3:19 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
> >
> > Hi Dai,
> >
> > On Mon, 2023-06-19 at 10:02 -0700, dai.ngo@oracle.com wrote:
> >> Hi Trond,
> >>
> >> I'm testing the NFS server with write delegation support and the
> >> Linux client
> >> using NFSv4.0 and run into a situation that needs your advise.
> >>
> >> In this scenario, the NFS server grants the write delegation to the
> >> client.
> >> Later when the client returns delegation it sends the compound PUTFH,
> >> GETATTR
> >> and DELERETURN.
> >>
> >> When the NFS server services the GETATTR, it detects that there is a
> >> write
> >> delegation on this file but it can not detect that this GETATTR
> >> request was
> >> sent from the same client that owns the write delegation (due to the
> >> nature
> >> of NFSv4.0 compound). As the result, the server sends CB_RECALL to
> >> recall
> >> the delegation and replies NFS4ERR_DELAY to the GETATTR request.
> >>
> >> When the client receives the NFS4ERR_DELAY it retries with the same
> >> compound
> >> PUTFH, GETATTR, DELERETURN and server again replies the
> >> NFS4ERR_DELAY. This
> >> process repeats until the recall times out and the delegation is
> >> revoked by
> >> the server.
> >>
> >> I noticed that the current order of GETATTR and DELEGRETURN was done
> >> by
> >> commit e144cbcc251f. Then later on, commit 8ac2b42238f5 was added to
> >> drop
> >> the GETATTR if the request was rejected with EACCES.
> >>
> >> Do you have any advise on where, on server or client, this issue
> >> should
> >> be addressed?
> >
> > This wants to be addressed in the server. The client has a very good
> > reason for wanting to retrieve the attributes before returning the
> > delegation here: it needs to update the change attribute while it is
> > still holding the delegation in order to ensure close-to-open cache
> > consistency.
> >
> > Since you do have a stateid in the DELEGRETURN, it should be possible
> > to determine that this is indeed the client that holds the delegation.
>
> I think it needs to be made clear in a specification that this is
> the intended and conventional server implementation needed for such
> a COMPOUND.
>
> RFC 7530 Section 14.2 says:
>
> > The server will process the COMPOUND procedure by evaluating each of
> > the operations within the COMPOUND procedure in order.
>
> 2nd paragraph of RFC 7530 Section 15.2.4 says:
>
> >    The COMPOUND procedure is used to combine individual operations into
> > a single RPC request. The server interprets each of the operations
> > in turn. If an operation is executed by the server and the status of
> > that operation is NFS4_OK, then the next operation in the COMPOUND
> > procedure is executed. The server continues this process until there
> > are no more operations to be executed or one of the operations has a
> > status value other than NFS4_OK.
>
> Obviously in this case the client has sent a well-formed COMPOUND,
> but it's not one the server can execute given the ordering
> constraint spelled out above.
>
> Can you refer us to a part of any RFC that says it's appropriate
> to look ahead at subsequent operations in an NFSv4.0 COMPOUND to
> obtain a state or client ID? Otherwise the Linux client will have
> the same problem with any server implementation that handles
> GETATTR conflicts as described in RFC 7530 Section 16.7.5.

I'm not sure if this is totally irrelevant here but for the NFSv4.2
COPY nfsd does look ahead into the following operations in order to
determine if it should allow one of the filehandle that it can't
resolve (ie because it's a source server filehandle) which it would
normally return ERR_STALE if it were any other compound. But of course
one can argue that the spec specifically says that server needs to
look ahead.

> Based on this language I don't believe NFSv4.0 clients can rely on
> server implementations to look ahead for client ID information. In
> my view the client ought to provide a client ID by placing a RENEW
> before the GETATTR. Even in that case, the server implementation
> might not be aware that it needs to save the client ID from the
> RENEW operation.
>
>
> --
> Chuck Lever
>
>
