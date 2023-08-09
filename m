Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C877776B07
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Aug 2023 23:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjHIVhC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Aug 2023 17:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHIVhB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Aug 2023 17:37:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C997A1718;
        Wed,  9 Aug 2023 14:36:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F80821857;
        Wed,  9 Aug 2023 21:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691617014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBfO+cmTIVu68kmGmMkFCRYZIK4fBK6RzvP4dlFXVnA=;
        b=1e3FnObzcmp2zYQGStCyHwb24hME1PrLq+75elZo5iQinGHhzdLPVocHPadgMHtWx0UFsM
        E3lwKNHEWD3cxzX713U1/mW8fii3W9YlpPhFEkxg8fZZlmcHfYS2evj1/uZLYZybQGTnBS
        +1pd420T0Zd1mWAoAgUFbxvRqyjZOCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691617014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBfO+cmTIVu68kmGmMkFCRYZIK4fBK6RzvP4dlFXVnA=;
        b=al572XNxQRQGZPvywmTeGOmdKGFNSm9s0zV1KSY2p52G+OuhXQ0vFHv4ifEu2p4MMTMfoe
        cLJ8TbQsks0dYlCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A40EF133B5;
        Wed,  9 Aug 2023 21:36:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qq8oFfIG1GSFYgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 09 Aug 2023 21:36:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Yue Haibing" <yuehaibing@huawei.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, yuehaibing@huawei.com,
        kuba@kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -next] SUNRPC: Remove unused declaration rpc_modcount()
In-reply-to: <20230809141426.41192-1-yuehaibing@huawei.com>
References: <20230809141426.41192-1-yuehaibing@huawei.com>
Date:   Thu, 10 Aug 2023 07:36:44 +1000
Message-id: <169161700457.32308.8657894998370155540@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 10 Aug 2023, Yue Haibing wrote:
> These declarations are never implemented since the beginning of git history.
> Remove these, then merge the two #ifdef block for simplification.

For the historically minded, this was added in 2.1.79
https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/net/=
sunrpc/stats.c?id=3Dae04feb38f319f0d389ea9e41d10986dba22b46d

and removed in 2.3.27.
https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/net/=
sunrpc/stats.c?id=3D53022f15f8c0381a9b55bbe2893a5f9f6abda6f3

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBRown

>=20
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/sunrpc/stats.h | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/stats.h b/include/linux/sunrpc/stats.h
> index d94d4f410507..3ce1550d1beb 100644
> --- a/include/linux/sunrpc/stats.h
> +++ b/include/linux/sunrpc/stats.h
> @@ -43,22 +43,6 @@ struct net;
>  #ifdef CONFIG_PROC_FS
>  int			rpc_proc_init(struct net *);
>  void			rpc_proc_exit(struct net *);
> -#else
> -static inline int rpc_proc_init(struct net *net)
> -{
> -	return 0;
> -}
> -
> -static inline void rpc_proc_exit(struct net *net)
> -{
> -}
> -#endif
> -
> -#ifdef MODULE
> -void			rpc_modcount(struct inode *, int);
> -#endif
> -
> -#ifdef CONFIG_PROC_FS
>  struct proc_dir_entry *	rpc_proc_register(struct net *,struct rpc_stat *);
>  void			rpc_proc_unregister(struct net *,const char *);
>  void			rpc_proc_zero(const struct rpc_program *);
> @@ -69,7 +53,14 @@ void			svc_proc_unregister(struct net *, const char *);
>  void			svc_seq_show(struct seq_file *,
>  				     const struct svc_stat *);
>  #else
> +static inline int rpc_proc_init(struct net *net)
> +{
> +	return 0;
> +}
> =20
> +static inline void rpc_proc_exit(struct net *net)
> +{
> +}
>  static inline struct proc_dir_entry *rpc_proc_register(struct net *net, st=
ruct rpc_stat *s) { return NULL; }
>  static inline void rpc_proc_unregister(struct net *net, const char *p) {}
>  static inline void rpc_proc_zero(const struct rpc_program *p) {}
> --=20
> 2.34.1
>=20
>=20

