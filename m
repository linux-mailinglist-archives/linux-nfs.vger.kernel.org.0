Return-Path: <linux-nfs+bounces-13805-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDB5B2E193
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FB41BC4A8A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC310322A01;
	Wed, 20 Aug 2025 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="hbL4cBoX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9121E0AD
	for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705248; cv=none; b=fO6mY2AkruaFRX1m3lEq86sS+95lWPmgPKQCTdqGCdvgC0SkuCTs/7V6jnNiqoFZbOsqRpJo6Ujm9QyLtqcVA2UYZpYZ5WJ85EoBn5zyUOyPPGUqXiY7YH7OXQO2JiZd0PPqCo1g75nt6q0PpPOzneZHswOIbU/unl4cMwAQKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705248; c=relaxed/simple;
	bh=Ldpo+GbWxSWl9cCQ7KExOcHZ0OS7NPT+X37BW5G6u/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aq6f7LjuE7+r119mo2LpmysH9VKNHRwgO2J1NX0f7Wyevt2sc4aGwI3ugWpcByknXmA7ykmJyg8xcadJ4BzCpKsnarm3b1RUSvEpWOCeRNbIYZCa+quc0W/EEbLXXEmBvmgCFpgXkuuwzPVpfhrZVsCFHtUQZSxtOwq+Wfbk00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=hbL4cBoX; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333f8f02afaso207431fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1755705244; x=1756310044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTIQB9R0WJfcCXGO7guHaugrb2pCrGX/8QDDMIioBdY=;
        b=hbL4cBoXuShH9Fi/vvUZuXArgCa9bTLhX+FxpDCbIt0GXm4Ywbq133Ooujlk7D+oHJ
         6OLEWQ9CovLcDH9WHptYfdzs8bBf3fekfh4KazYl7OPxvoQ70eB0WZLyQ+cYGE+KSw9v
         vhbJwbABX/i6whZzt/sdn6Dd8Baxl8L1QZahejiOFnxSLR7xh2Wn84LTz8bEUeuRV3jB
         lq25fnhawBPR0lpAjsYICdNBZPmpHlglVCwn3Z68H0CqZCREbcdt3gBPe6G5nC0jUSsk
         r7tPriDC3NSSm10UDthnVGULElaJsxyZRH6hgjwARw7+AqdFV9bx4/nKRut5aP32e4yu
         tcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755705244; x=1756310044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTIQB9R0WJfcCXGO7guHaugrb2pCrGX/8QDDMIioBdY=;
        b=qRMqLRpuuAwNrLZP6QhUU6ECS+3acH1/AD5d/RFt5hskzyq2JrXcApyBmKxWDdoWBw
         hxYh0QNeWfWkKsXFPJZ8iqlCpo7OO8Qr6KNSmMppb75aBRFdKC4s8ZEq2zxF9z9dPqJm
         VApBnNRPs/x7Z00UMpm1mwUtbjQYksAEVtgIAsKgRPTEWcccHlXt3RWX9IiVNXGod1mA
         sWdY0hc8381c6ZGzGuBHleVsjz1ukkkZBD9eqD4Zkm9g8D0L0bq4B8rt75NI1eizHWc0
         sPl1VaPWC4oaqEVFuTrWdkczOhyKHtMTIT73R0RYSYGK/AHgPPTo/JysIQh1WStmzSGh
         QEtg==
X-Gm-Message-State: AOJu0YxyGV3KSY7JeUTO0T07NTBELienPFoAO3KYWC9MqtBlHMZbpc0p
	Tj5XQrCRJq3SBo4HUrOCAnRw29Huf3QxDkE7VghI7OpIYY7v43nSd0xWBZiCmShd9Sn9cQ4abwD
	sOIMBPPfMxaTLYuqP0xFpVxvFDVFE88Sg4JeN
X-Gm-Gg: ASbGncsKrqZ2F7fTer3PyYjYf9R861RkEIlLOJZ2QwZ49rc04FnU9j60rhcx7/Ge/UI
	BDMd08hBVNA7NqQOyiqnFXOh297QAD1AkGG+s9PZlXoqcvvpkehziFQBLxbqrRPxOazczuv26Hx
	mcHV0rqU5qMdxURIb26L+UqPxRF6MHlsodHcWpFqTXEMpTLDAPLPHN0p9TXgQMKtsR/fXW4G1pC
	fYAon7cgksdgnYGmbYz2/X9OInwadG+CJXPT8tE3/4s2Qji1vZ7
X-Google-Smtp-Source: AGHT+IHc0InOIwtSd4dCVLwltU4NQl9EUjZqD+DORpmipZ0wIUMdhMUHpqOyLpnOfe8qiJ38IqFKI3EoimGBdI+lZZk=
X-Received: by 2002:a05:651c:41c1:b0:332:6304:3076 with SMTP id
 38308e7fff4ca-3353bc5c548mr11104361fa.1.1755705243633; Wed, 20 Aug 2025
 08:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820142729.89704-1-cel@kernel.org> <20250820142729.89704-3-cel@kernel.org>
In-Reply-To: <20250820142729.89704-3-cel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 20 Aug 2025 11:53:52 -0400
X-Gm-Features: Ac12FXwI1B90u_O_Im1NIRbQPZemL0dv16jItEEoCEtPLkwkfq37cXm6kTTHN_0
Message-ID: <CAN-5tyEX5QcLCTG5R-0Gf9bMUuN-YoPid6hOFoftN4U_kAMUpQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] SUNRPC: Move the svc_rpcb_cleanup() call sites
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 10:32=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote=
:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Clean up: because svc_rpcb_cleanup() and svc_xprt_destroy_all()
> are always invoked in pairs, we can deduplicate code by moving
> the svc_rpcb_cleanup() call sites into svc_xprt_destroy_all().

Tested-by: Olga Kornievskaia <okorniev@redhat.com>

> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/lockd/svc.c                  | 6 ++----
>  fs/nfs/callback.c               | 2 +-
>  fs/nfsd/nfsctl.c                | 2 +-
>  fs/nfsd/nfssvc.c                | 7 ++-----
>  include/linux/sunrpc/svc_xprt.h | 3 ++-
>  net/sunrpc/svc.c                | 1 -
>  net/sunrpc/svc_xprt.c           | 7 ++++++-
>  7 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index e80262a51884..d68afa196535 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -216,8 +216,7 @@ static int make_socks(struct svc_serv *serv, struct n=
et *net,
>         if (warned++ =3D=3D 0)
>                 printk(KERN_WARNING
>                         "lockd_up: makesock failed, error=3D%d\n", err);
> -       svc_xprt_destroy_all(serv, net);
> -       svc_rpcb_cleanup(serv, net);
> +       svc_xprt_destroy_all(serv, net, true);
>         return err;
>  }
>
> @@ -255,8 +254,7 @@ static void lockd_down_net(struct svc_serv *serv, str=
uct net *net)
>                         nlm_shutdown_hosts_net(net);
>                         cancel_delayed_work_sync(&ln->grace_period_end);
>                         locks_end_grace(&ln->lockd_manager);
> -                       svc_xprt_destroy_all(serv, net);
> -                       svc_rpcb_cleanup(serv, net);
> +                       svc_xprt_destroy_all(serv, net, true);
>                 }
>         } else {
>                 pr_err("%s: no users! net=3D%x\n",
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 511f80878809..c8b837006bb2 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -136,7 +136,7 @@ static void nfs_callback_down_net(u32 minorversion, s=
truct svc_serv *serv, struc
>                 return;
>
>         dprintk("NFS: destroy per-net callback data; net=3D%x\n", net->ns=
.inum);
> -       svc_xprt_destroy_all(serv, net);
> +       svc_xprt_destroy_all(serv, net, false);
>  }
>
>  static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index bc6b776fc657..63d52edcad72 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1993,7 +1993,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, =
struct genl_info *info)
>          * remaining listeners and recreate the list.
>          */
>         if (delete)
> -               svc_xprt_destroy_all(serv, net);
> +               svc_xprt_destroy_all(serv, net, false);
>
>         /* walk list of addrs again, open any that still don't exist */
>         nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_SOCK_ADDR, info->nlh=
dr,
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 82b0111ac469..7057ddd7a0a8 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -535,16 +535,13 @@ void nfsd_destroy_serv(struct net *net)
>  #endif
>         }
>
> -       svc_xprt_destroy_all(serv, net);
> -
>         /*
>          * write_ports can create the server without actually starting
> -        * any threads--if we get shut down before any threads are
> +        * any threads.  If we get shut down before any threads are
>          * started, then nfsd_destroy_serv will be run before any of this
>          * other initialization has been done except the rpcb information=
.
>          */
> -       svc_rpcb_cleanup(serv, net);
> -
> +       svc_xprt_destroy_all(serv, net, true);
>         nfsd_shutdown_net(net);
>         svc_destroy(&serv);
>  }
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_x=
prt.h
> index 369a89aea186..fde60d4e2cd5 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -165,7 +165,8 @@ int svc_xprt_create(struct svc_serv *serv, const char=
 *xprt_name,
>                         struct net *net, const int family,
>                         const unsigned short port, int flags,
>                         const struct cred *cred);
> -void   svc_xprt_destroy_all(struct svc_serv *serv, struct net *net);
> +void   svc_xprt_destroy_all(struct svc_serv *serv, struct net *net,
> +                            bool unregister);
>  void   svc_xprt_received(struct svc_xprt *xprt);
>  void   svc_xprt_enqueue(struct svc_xprt *xprt);
>  void   svc_xprt_put(struct svc_xprt *xprt);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index b1fab3a69544..9c7245d811eb 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -436,7 +436,6 @@ void svc_rpcb_cleanup(struct svc_serv *serv, struct n=
et *net)
>         svc_unregister(serv, net);
>         rpcb_put_local(net);
>  }
> -EXPORT_SYMBOL_GPL(svc_rpcb_cleanup);
>
>  static int svc_uses_rpcbind(struct svc_serv *serv)
>  {
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 8b1837228799..049ab53088e9 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -1102,6 +1102,7 @@ static void svc_clean_up_xprts(struct svc_serv *ser=
v, struct net *net)
>   * svc_xprt_destroy_all - Destroy transports associated with @serv
>   * @serv: RPC service to be shut down
>   * @net: target network namespace
> + * @unregister: true if it is OK to unregister the destroyed xprts
>   *
>   * Server threads may still be running (especially in the case where the
>   * service is still running in other network namespaces).
> @@ -1114,7 +1115,8 @@ static void svc_clean_up_xprts(struct svc_serv *ser=
v, struct net *net)
>   * threads, we may need to wait a little while and then check again to
>   * see if they're done.
>   */
> -void svc_xprt_destroy_all(struct svc_serv *serv, struct net *net)
> +void svc_xprt_destroy_all(struct svc_serv *serv, struct net *net,
> +                         bool unregister)
>  {
>         int delay =3D 0;
>
> @@ -1124,6 +1126,9 @@ void svc_xprt_destroy_all(struct svc_serv *serv, st=
ruct net *net)
>                 svc_clean_up_xprts(serv, net);
>                 msleep(delay++);
>         }
> +
> +       if (unregister)
> +               svc_rpcb_cleanup(serv, net);
>  }
>  EXPORT_SYMBOL_GPL(svc_xprt_destroy_all);
>
> --
> 2.50.0
>
>

