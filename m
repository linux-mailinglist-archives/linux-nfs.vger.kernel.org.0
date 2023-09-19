Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5610A7A6AB4
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Sep 2023 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjISS2E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Sep 2023 14:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISS2D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Sep 2023 14:28:03 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B597
        for <linux-nfs@vger.kernel.org>; Tue, 19 Sep 2023 11:27:57 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4179632293bso32098981cf.3
        for <linux-nfs@vger.kernel.org>; Tue, 19 Sep 2023 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695148076; x=1695752876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k806ESdawvOUVMAtZ/hRUSMxdVPE7RooEnOr4H5EYfY=;
        b=Do0VnkblGHn37TCjh5EYl5BKqCpKErbrj8bQjWDOIRQGqOypMWb4PbrHKf25bVqrYq
         4NhsDlp7HeNa//H+3AOud5FRI9aYwegFyMJWo5BtfwoXMych8hT8D0gi8KZ/PXa+fEc0
         fRZLN4R905LXmu7GcpX6Rz3pCnIpMXGtIVbljVD/38Ydx6Asx1ujb2PHqLoGj1lWG3Zj
         3GEjj90vL+3IE+crhC8mbo6mwDGsx3FKQO8Yw92QoafmSfCUCF7/G97xYzdw/90PFqVi
         pqdZb3+yvvlJQs4lsuZN6ODZaP+DDggnSdgQbljHFY67jGB1u2acvR1R2a6Sk4ajDMme
         aOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695148076; x=1695752876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k806ESdawvOUVMAtZ/hRUSMxdVPE7RooEnOr4H5EYfY=;
        b=NY+UWDnVt6+bYOeHuggMzukftocr0KsvAogt8Spuui4FKZ0eCsIPLAYBXt6SFJzQsr
         xvqIxzbcYHDGwGjld3YCLf5UDTh/+Rlj98ewBOyjL1DvTGZvOWGdUEsRKL23kzpX/6nZ
         LG7AI9aTochLUXQrAKA2TmAn1e9cfyHIodx7hP1D+whcZAIGc2nD90YMlGJOwqWsrjV/
         MeBIvy2wJFxxEmM6L4I6faV3+zCOzyl25vX7xjDn8h73bVnoUV/637j/bg5IFrpE4V8O
         CHZgjw5HbLrOM76dP5dc15NQN6vcz7oH8gTfgLQX+Bw0+8Pj/k42y2IO3PTYl8dyG8ia
         LT+g==
X-Gm-Message-State: AOJu0YzF98LrELeTJwmCOmTe2N/S+VHNsOiQS9O8Fn5Ih2EUC/I21yWk
        EcvVB8WN/WWyRn+GEFPN3u39jYH3RqrrL8IthZo=
X-Google-Smtp-Source: AGHT+IHW8xAvRD0lZuLi66gsIuZzQ1mvJsZcTFQZnYnA2FCIEUMmH1QKg40vAoVY4NXxFSh32ijLbsYpMgspvAr52+4=
X-Received: by 2002:ac8:5a05:0:b0:417:9e55:617f with SMTP id
 n5-20020ac85a05000000b004179e55617fmr361626qta.62.1695148076555; Tue, 19 Sep
 2023 11:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <169403069468.5590.10798268439536368989.stgit@oracle-102.nfsv4bat.org>
 <AA691FE9-5183-4912-BB0A-32E86629D7B1@oracle.com>
In-Reply-To: <AA691FE9-5183-4912-BB0A-32E86629D7B1@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 19 Sep 2023 14:27:40 -0400
Message-ID: <CAFX2Jf=hVi1sGARPvfW8BLJ189obH=Ha+qovDWD6_ptWvSpUqA@mail.gmail.com>
Subject: Re: [PATCH v2] SUNRPC: Fail quickly when server does not recognize TLS
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 18, 2023 at 2:37=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Sep 6, 2023, at 4:05 PM, Chuck Lever <cel@kernel.org> wrote:
> >
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > rpcauth_checkverf() should return a distinct error code when a
> > server recognizes the AUTH_TLS probe but does not support TLS so
> > that the client's header decoder can respond appropriately and
> > quickly. No retries are necessary is in this case, since the server
> > has already affirmatively answered "TLS is unsupported".
> >
> > Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> > net/sunrpc/auth.c     |   11 ++++++++---
> > net/sunrpc/auth_tls.c |    4 ++--
> > net/sunrpc/clnt.c     |   10 +++++++++-
> > 3 files changed, 19 insertions(+), 6 deletions(-)
> >
> > This must be applied after 'Revert "SUNRPC: Fail faster on bad verifier=
"'
> >
> > Changes since RFC:
> > - Basic testing has been done
> > - Added an explicit check for a zero-length verifier string
>
> Hi Anna, was this patch rejected?

Nope! I was under the impression Trond would be taking it for 6.7, but
if you think it's needed earlier I can include it in the next bugfixes
pull request.

Thanks,
Anna

>
>
> > diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> > index 2f16f9d17966..814b0169f972 100644
> > --- a/net/sunrpc/auth.c
> > +++ b/net/sunrpc/auth.c
> > @@ -769,9 +769,14 @@ int rpcauth_wrap_req(struct rpc_task *task, struct=
 xdr_stream *xdr)
> >  * @task: controlling RPC task
> >  * @xdr: xdr_stream containing RPC Reply header
> >  *
> > - * On success, @xdr is updated to point past the verifier and
> > - * zero is returned. Otherwise, @xdr is in an undefined state
> > - * and a negative errno is returned.
> > + * Return values:
> > + *   %0: Verifier is valid. @xdr now points past the verifier.
> > + *   %-EIO: Verifier is corrupted or message ended early.
> > + *   %-EACCES: Verifier is intact but not valid.
> > + *   %-EPROTONOSUPPORT: Server does not support the requested auth typ=
e.
> > + *
> > + * When a negative errno is returned, @xdr is left in an undefined
> > + * state.
> >  */
> > int
> > rpcauth_checkverf(struct rpc_task *task, struct xdr_stream *xdr)
> > diff --git a/net/sunrpc/auth_tls.c b/net/sunrpc/auth_tls.c
> > index de7678f8a23d..87f570fd3b00 100644
> > --- a/net/sunrpc/auth_tls.c
> > +++ b/net/sunrpc/auth_tls.c
> > @@ -129,9 +129,9 @@ static int tls_validate(struct rpc_task *task, stru=
ct xdr_stream *xdr)
> > if (*p !=3D rpc_auth_null)
> > return -EIO;
> > if (xdr_stream_decode_opaque_inline(xdr, &str, starttls_len) !=3D start=
tls_len)
> > - return -EIO;
> > + return -EPROTONOSUPPORT;
> > if (memcmp(str, starttls_token, starttls_len))
> > - return -EIO;
> > + return -EPROTONOSUPPORT;
> > return 0;
> > }
> >
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index 315bd59dea05..80ee97fb0bf2 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -2722,7 +2722,15 @@ rpc_decode_header(struct rpc_task *task, struct =
xdr_stream *xdr)
> >
> > out_verifier:
> > trace_rpc_bad_verifier(task);
> > - goto out_garbage;
> > + switch (error) {
> > + case -EPROTONOSUPPORT:
> > + goto out_err;
> > + case -EACCES:
> > + /* Re-encode with a fresh cred */
> > + fallthrough;
> > + default:
> > + goto out_garbage;
> > + }
> >
> > out_msg_denied:
> > error =3D -EACCES;
> >
> >
>
> --
> Chuck Lever
>
>
