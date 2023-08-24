Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3926578770E
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjHXRYW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Aug 2023 13:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbjHXRYS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Aug 2023 13:24:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578861995
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 10:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA58967619
        for <linux-nfs@vger.kernel.org>; Thu, 24 Aug 2023 17:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527E3C433CA;
        Thu, 24 Aug 2023 17:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692897855;
        bh=5Ggj/Kg5wfAhxVt9QW/cX0PRx5Pv392KhR5COtHdRGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R3cNTEA9Hwk8+Q966g57u+7zIpYW9jtSuMoen0B7LincT76GZ4AshJcze/L1kYHuU
         EWUBmHo1lQiwf4ZVPdi9hIFKW+sk6aGR+LkepojSAzaYCyVtDBNRr9CXH+sNnfSLzG
         hk5rbAdTGaXurCritfcgiO8xLI9e8UAFvLOu1uwMiBzSsHMiPzTNhuGNovqP/LCQp1
         WAl7oAT0KCiJ2W5seyr5rLiUbaHzzKViVBFGudgKSCSo+mK9AI4IwBsCjtxrnXxO33
         YBUTO/VCkVtO0s53Siex69KoRL9I83mOfRyUNaFJjzKeO1/g8G/KObCOwZ/wOfouzc
         7TMOt/hZpX7CQ==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-76ce59842c1so3192985a.3;
        Thu, 24 Aug 2023 10:24:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YxRl22MShVxcwGcXw3qVODmZ5jmkk9UiQJatXykpQZEwtfyfMLJ
        vYAsIqYkY1x6zmveu1c1eH2JBJP433WStfYAZgQ=
X-Google-Smtp-Source: AGHT+IF7AtnCrfFgx5N2SJ1aGlUri1yn8SyO3sjdNzo//0hW68COP4DlHG1oAN39/oD8AAa5Rv3qQwYBP+7jOuCzaKA=
X-Received: by 2002:a05:620a:2989:b0:767:d0c:9ec1 with SMTP id
 r9-20020a05620a298900b007670d0c9ec1mr19658778qkp.59.1692897854417; Thu, 24
 Aug 2023 10:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230809141426.41192-1-yuehaibing@huawei.com> <169161700457.32308.8657894998370155540@noble.neil.brown.name>
 <ZOZyJsV0Qkz8/NhP@tissot.1015granger.net>
In-Reply-To: <ZOZyJsV0Qkz8/NhP@tissot.1015granger.net>
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 24 Aug 2023 13:23:58 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfm4y49BKDLCjU86e5hSGhRKyAcgK=BypSB5ESTswPFJWw@mail.gmail.com>
Message-ID: <CAFX2Jfm4y49BKDLCjU86e5hSGhRKyAcgK=BypSB5ESTswPFJWw@mail.gmail.com>
Subject: Re: [PATCH -next] SUNRPC: Remove unused declaration rpc_modcount()
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     NeilBrown <neilb@suse.de>, Yue Haibing <yuehaibing@huawei.com>,
        trond.myklebust@hammerspace.com, jlayton@kernel.org,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        kuba@kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 23, 2023 at 4:55=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On Thu, Aug 10, 2023 at 07:36:44AM +1000, NeilBrown wrote:
> > On Thu, 10 Aug 2023, Yue Haibing wrote:
> > > These declarations are never implemented since the beginning of git h=
istory.
> > > Remove these, then merge the two #ifdef block for simplification.
> >
> > For the historically minded, this was added in 2.1.79
> > https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/dif=
f/net/sunrpc/stats.c?id=3Dae04feb38f319f0d389ea9e41d10986dba22b46d
> >
> > and removed in 2.3.27.
> > https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/dif=
f/net/sunrpc/stats.c?id=3D53022f15f8c0381a9b55bbe2893a5f9f6abda6f3
> >
> > Reviewed-by: NeilBrown <neilb@suse.de>
>
> Thanks, Neil. It isn't yet clear to me which tree this should go
> through: nfsd or NFS client. I can take it just to get things
> moving...
>

I'm fine with you taking this patch!

Anna
>
> > Thanks,
> > NeilBrown
> >
> > >
> > > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> > > ---
> > >  include/linux/sunrpc/stats.h | 23 +++++++----------------
> > >  1 file changed, 7 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/include/linux/sunrpc/stats.h b/include/linux/sunrpc/stat=
s.h
> > > index d94d4f410507..3ce1550d1beb 100644
> > > --- a/include/linux/sunrpc/stats.h
> > > +++ b/include/linux/sunrpc/stats.h
> > > @@ -43,22 +43,6 @@ struct net;
> > >  #ifdef CONFIG_PROC_FS
> > >  int                        rpc_proc_init(struct net *);
> > >  void                       rpc_proc_exit(struct net *);
> > > -#else
> > > -static inline int rpc_proc_init(struct net *net)
> > > -{
> > > -   return 0;
> > > -}
> > > -
> > > -static inline void rpc_proc_exit(struct net *net)
> > > -{
> > > -}
> > > -#endif
> > > -
> > > -#ifdef MODULE
> > > -void                       rpc_modcount(struct inode *, int);
> > > -#endif
> > > -
> > > -#ifdef CONFIG_PROC_FS
> > >  struct proc_dir_entry *    rpc_proc_register(struct net *,struct rpc=
_stat *);
> > >  void                       rpc_proc_unregister(struct net *,const ch=
ar *);
> > >  void                       rpc_proc_zero(const struct rpc_program *)=
;
> > > @@ -69,7 +53,14 @@ void                     svc_proc_unregister(struc=
t net *, const char *);
> > >  void                       svc_seq_show(struct seq_file *,
> > >                                  const struct svc_stat *);
> > >  #else
> > > +static inline int rpc_proc_init(struct net *net)
> > > +{
> > > +   return 0;
> > > +}
> > >
> > > +static inline void rpc_proc_exit(struct net *net)
> > > +{
> > > +}
> > >  static inline struct proc_dir_entry *rpc_proc_register(struct net *n=
et, struct rpc_stat *s) { return NULL; }
> > >  static inline void rpc_proc_unregister(struct net *net, const char *=
p) {}
> > >  static inline void rpc_proc_zero(const struct rpc_program *p) {}
> > > --
> > > 2.34.1
> > >
> > >
> >
>
> --
> Chuck Lever
