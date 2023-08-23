Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91897862C2
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Aug 2023 23:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbjHWVxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Aug 2023 17:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbjHWVxT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Aug 2023 17:53:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651C2E52;
        Wed, 23 Aug 2023 14:53:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EFD92225F0;
        Wed, 23 Aug 2023 21:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692827591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwgnjQes1bT02qBPMda+5vRYMMXvlcEEomPLV8hJEgA=;
        b=IQQ6adUT4c91A6IV9Gyx3Vtek61l//YkanVph7HKrzXnwmQ37/aaY+rEVJSycEfDAJE7Bm
        NfxV/r15QxH4hF/4k13En/2Lmvg3qZv0xUXPAhCedz72sxSaf2WievbeKiQ7bnKX2vl2E0
        RtCYBiyiZItFSYDNQgInbSUBgNuKciY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692827591;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwgnjQes1bT02qBPMda+5vRYMMXvlcEEomPLV8hJEgA=;
        b=8LiIHCtsccAJwTb8GIHRnuaOZ5ux5vlUBcWTCarQQf9nuk3w/JGosYGB1ciK3xOz7Temwd
        kARtsgiLFXvmDkAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D5041351F;
        Wed, 23 Aug 2023 21:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F35NOMN/5mSsRwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 23 Aug 2023 21:53:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Yue Haibing" <yuehaibing@huawei.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        jlayton@kernel.org, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, kuba@kernel.org, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH -next] SUNRPC: Remove unused declaration rpc_modcount()
In-reply-to: <ZOZyJsV0Qkz8/NhP@tissot.1015granger.net>
References: <20230809141426.41192-1-yuehaibing@huawei.com>,
 <169161700457.32308.8657894998370155540@noble.neil.brown.name>,
 <ZOZyJsV0Qkz8/NhP@tissot.1015granger.net>
Date:   Thu, 24 Aug 2023 07:53:04 +1000
Message-id: <169282758439.11865.1546671583988704052@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 24 Aug 2023, Chuck Lever wrote:
> On Thu, Aug 10, 2023 at 07:36:44AM +1000, NeilBrown wrote:
> > On Thu, 10 Aug 2023, Yue Haibing wrote:
> > > These declarations are never implemented since the beginning of git his=
tory.
> > > Remove these, then merge the two #ifdef block for simplification.
> >=20
> > For the historically minded, this was added in 2.1.79
> > https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/=
net/sunrpc/stats.c?id=3Dae04feb38f319f0d389ea9e41d10986dba22b46d
> >=20
> > and removed in 2.3.27.
> > https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/=
net/sunrpc/stats.c?id=3D53022f15f8c0381a9b55bbe2893a5f9f6abda6f3
> >=20
> > Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> Thanks, Neil. It isn't yet clear to me which tree this should go
> through: nfsd or NFS client. I can take it just to get things
> moving...

It hardly matters.  Once there was a "trivial" tree, and it would be an
equally good fit there.  I think that if you include it in your next
submission, no one will complain.

Thanks,
NeilBrown


>=20
>=20
> > Thanks,
> > NeilBrown
> >=20
> > >=20
> > > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> > > ---
> > >  include/linux/sunrpc/stats.h | 23 +++++++----------------
> > >  1 file changed, 7 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/include/linux/sunrpc/stats.h b/include/linux/sunrpc/stats.h
> > > index d94d4f410507..3ce1550d1beb 100644
> > > --- a/include/linux/sunrpc/stats.h
> > > +++ b/include/linux/sunrpc/stats.h
> > > @@ -43,22 +43,6 @@ struct net;
> > >  #ifdef CONFIG_PROC_FS
> > >  int			rpc_proc_init(struct net *);
> > >  void			rpc_proc_exit(struct net *);
> > > -#else
> > > -static inline int rpc_proc_init(struct net *net)
> > > -{
> > > -	return 0;
> > > -}
> > > -
> > > -static inline void rpc_proc_exit(struct net *net)
> > > -{
> > > -}
> > > -#endif
> > > -
> > > -#ifdef MODULE
> > > -void			rpc_modcount(struct inode *, int);
> > > -#endif
> > > -
> > > -#ifdef CONFIG_PROC_FS
> > >  struct proc_dir_entry *	rpc_proc_register(struct net *,struct rpc_stat=
 *);
> > >  void			rpc_proc_unregister(struct net *,const char *);
> > >  void			rpc_proc_zero(const struct rpc_program *);
> > > @@ -69,7 +53,14 @@ void			svc_proc_unregister(struct net *, const char =
*);
> > >  void			svc_seq_show(struct seq_file *,
> > >  				     const struct svc_stat *);
> > >  #else
> > > +static inline int rpc_proc_init(struct net *net)
> > > +{
> > > +	return 0;
> > > +}
> > > =20
> > > +static inline void rpc_proc_exit(struct net *net)
> > > +{
> > > +}
> > >  static inline struct proc_dir_entry *rpc_proc_register(struct net *net=
, struct rpc_stat *s) { return NULL; }
> > >  static inline void rpc_proc_unregister(struct net *net, const char *p)=
 {}
> > >  static inline void rpc_proc_zero(const struct rpc_program *p) {}
> > > --=20
> > > 2.34.1
> > >=20
> > >=20
> >=20
>=20
> --=20
> Chuck Lever
>=20

