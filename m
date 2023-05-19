Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0A709EFB
	for <lists+linux-nfs@lfdr.de>; Fri, 19 May 2023 20:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjESST2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 May 2023 14:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjESST1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 May 2023 14:19:27 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC3F139
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 11:19:25 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f3faefc92cso31456661cf.3
        for <linux-nfs@vger.kernel.org>; Fri, 19 May 2023 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684520364; x=1687112364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h95iPV5Io6qABbL20jw5Zt3qcHcaUmhFJh6Nlwi1LrQ=;
        b=dsPEuRhWBTMw2r25IsYK7SQX3N9kWAKyoeKR7XHigTyVxtxORdN76qLPEtlKfAkOqW
         bjDGyzCK68kSiskRFFPwr4oypROai/t9S+klBu8Is1+OO6Upton8Wf50R2/3ScMUysjS
         vt14EOspjheI09nBr0jsXO3dhIU/EGgR3knhGYLoVTmSd8BaNGgCdrHzQFrAbNhzJ6oS
         DO+rXXVujyoXEMyCst0rJps0+HDq3elc0PgowUfI+RwFGPAxC076TFJ0Phf32SFFOKM0
         +6+YLb92z9pQMe5g22hVa2Vy+YMmMi3m9iqIIGZW3WvewbXZCVfiGNNCy4nMEwL7LZqK
         sCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684520364; x=1687112364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h95iPV5Io6qABbL20jw5Zt3qcHcaUmhFJh6Nlwi1LrQ=;
        b=j8MRwdDzhBt7foX2gUuBOEhm2vp4D99P0b/8AU3+p0GG1ikhD1wGq2ZwjoHlPiRvBt
         DVn23lktSVm0OLOWFoGlGionDYFmllKmayxzhe7omr/6GeYV94ZUv2Xu/364Fwl1Huz2
         QuWNpjMadb1JsutdH6pV48oTeKoKFsuwt1rn6ByLhc401z0zB2F9uIBY07D4aNnk4UWs
         C+vKCB6vZyk9q2LyZHSjlV/cZX7B46G2ziqubsDe35xR4VL//xcEQNVyrsxmNPEoin7H
         XNPbNHTDBkMNw0B9vWobI84KgZVXIkrG9PH/4upS2sz6ZNRlVWhrwVbVyH+RT4BdIiiE
         WY6w==
X-Gm-Message-State: AC+VfDylKvldmYE2FV2+1arQvvhBfbXzdPszBMosCuditbCNdPp5vaeF
        HSr/PtSe6dqbhDMROQyYLRicKUq/MlIx7OY8AMW9k2/u+Qc=
X-Google-Smtp-Source: ACHHUZ6EHfsnXzpMRjeOb7H1WobI8K5z5orqsdNMikHX4SSuIwb6Efn9IXwwaxHfx62DrIwY3DHfj8cqCEoUX+YHeK4=
X-Received: by 2002:ac8:4e41:0:b0:3f6:9678:9d2a with SMTP id
 e1-20020ac84e41000000b003f696789d2amr3535274qtw.47.1684520364136; Fri, 19 May
 2023 11:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
 <168426612899.74246.12074514989473589840.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168426612899.74246.12074514989473589840.stgit@oracle-102.nfsv4bat.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Fri, 19 May 2023 14:19:05 -0400
Message-ID: <CAFX2Jfn2epNz+OpMTD0yeTCjNNxTRR0rANp8+GHk7sLeVpUBhw@mail.gmail.com>
Subject: Re: [PATCH RFC 09/12] SUNRPC: Add RPC-with-TLS support to xprtsock.c
To:     Chuck Lever <cel@kernel.org>
Cc:     anna.schumaker@netapp.com, trondmy@hammerspace.com,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

On Tue, May 16, 2023 at 3:52=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Use the new TLS handshake API to enable the SunRPC client code
> to request a TLS handshake. This implements support for RFC 9289.
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/xprtsock.h |    1
>  net/sunrpc/xprtsock.c           |  289 +++++++++++++++++++++++++++++++++=
+-----
>  2 files changed, 253 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprts=
ock.h
> index 574a6a5391ba..700a1e6c047c 100644
> --- a/include/linux/sunrpc/xprtsock.h
> +++ b/include/linux/sunrpc/xprtsock.h
> @@ -57,6 +57,7 @@ struct sock_xprt {
>         struct work_struct      error_worker;
>         struct work_struct      recv_worker;
>         struct mutex            recv_mutex;
> +       struct completion       handshake_done;
>         struct sockaddr_storage srcaddr;
>         unsigned short          srcport;
>         int                     xprt_err;
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 7ea5984a52a3..686dd313f89f 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -48,6 +48,7 @@
>  #include <net/udp.h>
>  #include <net/tcp.h>
>  #include <net/tls.h>
> +#include <net/handshake.h>
>
>  #include <linux/bvec.h>
>  #include <linux/highmem.h>
> @@ -189,6 +190,11 @@ static struct ctl_table xs_tunables_table[] =3D {
>   */
>  #define XS_IDLE_DISC_TO                (5U * 60 * HZ)
>
> +/*
> + * TLS handshake timeout.
> + */
> +#define XS_TLS_HANDSHAKE_TO    (10U * HZ)
> +
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  # undef  RPC_DEBUG_DATA
>  # define RPCDBG_FACILITY       RPCDBG_TRANS
> @@ -1238,6 +1244,10 @@ static void xs_reset_transport(struct sock_xprt *t=
ransport)
>         if (atomic_read(&transport->xprt.swapper))
>                 sk_clear_memalloc(sk);
>
> +       /* XXX: Maybe also send a TLS Closure alert? */
> +
> +       tls_handshake_cancel(sk);
> +
>         kernel_sock_shutdown(sock, SHUT_RDWR);
>
>         mutex_lock(&transport->recv_mutex);
> @@ -2411,60 +2421,266 @@ static void xs_tcp_setup_socket(struct work_stru=
ct *work)
>         current_restore_flags(pflags, PF_MEMALLOC);
>  }
>
> +/*
> + * Transfer the connected socket to @upper_transport, then mark that
> + * xprt CONNECTED.
> + */
> +static int xs_tls_finish_connecting(struct rpc_xprt *lower_xprt,
> +                                   struct sock_xprt *upper_transport)
> +{
> +       struct sock_xprt *lower_transport =3D
> +                       container_of(lower_xprt, struct sock_xprt, xprt);
> +       struct rpc_xprt *upper_xprt =3D &upper_transport->xprt;
> +
> +       if (!upper_transport->inet) {
> +               struct socket *sock =3D lower_transport->sock;
> +               struct sock *sk =3D sock->sk;
> +
> +               /* Avoid temporary address, they are bad for long-lived
> +                * connections such as NFS mounts.
> +                * RFC4941, section 3.6 suggests that:
> +                *    Individual applications, which have specific
> +                *    knowledge about the normal duration of connections,
> +                *    MAY override this as appropriate.
> +                */
> +               if (xs_addr(upper_xprt)->sa_family =3D=3D PF_INET6) {
> +                       ip6_sock_set_addr_preferences(sk,
> +                               IPV6_PREFER_SRC_PUBLIC);
> +               }
> +
> +               xs_tcp_set_socket_timeouts(upper_xprt, sock);
> +               tcp_sock_set_nodelay(sk);
> +
> +               lock_sock(sk);
> +
> +               /*
> +                * @sk is already connected, so it now has the RPC callba=
cks.
> +                * Reach into @lower_transport to save the original ones.
> +                */
> +               upper_transport->old_data_ready =3D lower_transport->old_=
data_ready;
> +               upper_transport->old_state_change =3D lower_transport->ol=
d_state_change;
> +               upper_transport->old_write_space =3D lower_transport->old=
_write_space;
> +               upper_transport->old_error_report =3D lower_transport->ol=
d_error_report;
> +               sk->sk_user_data =3D upper_xprt;
> +
> +               /* socket options */
> +               sock_reset_flag(sk, SOCK_LINGER);
> +
> +               xprt_clear_connected(upper_xprt);
> +
> +               upper_transport->sock =3D sock;
> +               upper_transport->inet =3D sk;
> +               upper_transport->file =3D lower_transport->file;
> +
> +               release_sock(sk);
> +
> +               /* Reset lower_transport before shutting down its clnt */
> +               mutex_lock(&lower_transport->recv_mutex);
> +               lower_transport->inet =3D NULL;
> +               lower_transport->sock =3D NULL;
> +               lower_transport->file =3D NULL;
> +
> +               xprt_clear_connected(lower_xprt);
> +               xs_sock_reset_connection_flags(lower_xprt);
> +               xs_stream_reset_connect(lower_transport);
> +               mutex_unlock(&lower_transport->recv_mutex);
> +       }
> +
> +       if (!xprt_bound(upper_xprt))
> +               return -ENOTCONN;
> +
> +       xs_set_memalloc(upper_xprt);
> +
> +       if (!xprt_test_and_set_connected(upper_xprt)) {
> +               upper_xprt->connect_cookie++;
> +               clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_st=
ate);
> +               xprt_clear_connecting(upper_xprt);
> +
> +               upper_xprt->stat.connect_count++;
> +               upper_xprt->stat.connect_time +=3D (long)jiffies -
> +                                          upper_xprt->stat.connect_start=
;
> +               xs_run_error_worker(upper_transport, XPRT_SOCK_WAKE_PENDI=
NG);
> +       }
> +       return 0;
> +}
> +
>  /**
> - * xs_tls_connect - establish a TLS session on a socket
> - * @work: queued work item
> + * xs_tls_handshake_done - TLS handshake completion handler
> + * @data: address of xprt to wake
> + * @status: status of handshake
> + * @peerid: serial number of key containing the remote's identity
>   *
>   */
> -static void xs_tls_connect(struct work_struct *work)
> +static void xs_tls_handshake_done(void *data, int status, key_serial_t p=
eerid)
>  {
> -       struct sock_xprt *transport =3D
> -               container_of(work, struct sock_xprt, connect_worker.work)=
;
> -       struct rpc_clnt *clnt;
> +       struct rpc_xprt *lower_xprt =3D data;
> +       struct sock_xprt *lower_transport =3D
> +                               container_of(lower_xprt, struct sock_xprt=
, xprt);
>
> -       clnt =3D transport->clnt;
> -       transport->clnt =3D NULL;
> -       if (IS_ERR(clnt))
> -               goto out_unlock;
> +       lower_transport->xprt_err =3D status ? -EACCES : 0;
> +       complete(&lower_transport->handshake_done);
> +       xprt_put(lower_xprt);
> +}
>
> -       xs_tcp_setup_socket(work);
> +static int xs_tls_handshake_sync(struct rpc_xprt *lower_xprt, struct xpr=
tsec_parms *xprtsec)
> +{
> +       struct sock_xprt *lower_transport =3D
> +                               container_of(lower_xprt, struct sock_xprt=
, xprt);
> +       struct tls_handshake_args args =3D {
> +               .ta_sock        =3D lower_transport->sock,
> +               .ta_done        =3D xs_tls_handshake_done,
> +               .ta_data        =3D xprt_get(lower_xprt),
> +               .ta_peername    =3D lower_xprt->servername,

This part isn't compiling for me on v6.4-rc2:

net/sunrpc/xprtsock.c:2538:4: error: field designator 'ta_peername'
does not refer to any field in type 'struct tls_handshake_args'
                .ta_peername    =3D lower_xprt->servername,
                 ^
1 error generated.

Am I missing a patch, or did this struct get changed somewhere along the li=
ne?

Anna

> +       };
> +       struct sock *sk =3D lower_transport->inet;
> +       int rc;
>
> -       rpc_shutdown_client(clnt);
> +       init_completion(&lower_transport->handshake_done);
> +       set_bit(XPRT_SOCK_IGNORE_RECV, &lower_transport->sock_state);
>
> -out_unlock:
> -       return;
> +       lower_transport->xprt_err =3D -ETIMEDOUT;
> +       switch (xprtsec->policy) {
> +       case RPC_XPRTSEC_TLS_ANON:
> +               rc =3D tls_client_hello_anon(&args, GFP_KERNEL);
> +               if (rc)
> +                       goto out_put_xprt;
> +               break;
> +       case RPC_XPRTSEC_TLS_X509:
> +               args.ta_my_cert =3D xprtsec->cert_serial;
> +               args.ta_my_privkey =3D xprtsec->privkey_serial;
> +               rc =3D tls_client_hello_x509(&args, GFP_KERNEL);
> +               if (rc)
> +                       goto out_put_xprt;
> +               break;
> +       default:
> +               rc =3D -EACCES;
> +               goto out_put_xprt;
> +       }
> +
> +       rc =3D wait_for_completion_interruptible_timeout(&lower_transport=
->handshake_done,
> +                                                      XS_TLS_HANDSHAKE_T=
O);
> +       if (rc <=3D 0) {
> +               if (!tls_handshake_cancel(sk)) {
> +                       if (rc =3D=3D 0)
> +                               rc =3D -ETIMEDOUT;
> +                       goto out_put_xprt;
> +               }
> +       }
> +
> +       rc =3D lower_transport->xprt_err;
> +
> +out:
> +       xs_stream_reset_connect(lower_transport);
> +       clear_bit(XPRT_SOCK_IGNORE_RECV, &lower_transport->sock_state);
> +       return rc;
> +
> +out_put_xprt:
> +       xprt_put(lower_xprt);
> +       goto out;
>  }
>
> -static void xs_set_transport_clnt(struct rpc_clnt *clnt, struct rpc_xprt=
 *xprt)
> +/**
> + * xs_tls_connect - establish a TLS session on a socket
> + * @work: queued work item
> + *
> + * For RPC-with-TLS, there is a two-stage connection process.
> + *
> + * The "upper-layer xprt" is visible to the RPC consumer. Once it has
> + * been marked connected, the consumer knows that a TCP connection and
> + * a TLS session have been established.
> + *
> + * A "lower-layer xprt", created in this function, handles the mechanics
> + * of connecting the TCP socket, performing the RPC_AUTH_TLS probe, and
> + * then driving the TLS handshake. Once all that is complete, the upper
> + * layer xprt is marked connected.
> + */
> +static void xs_tls_connect(struct work_struct *work)
>  {
> -       struct sock_xprt *transport =3D container_of(xprt, struct sock_xp=
rt, xprt);
> +       struct sock_xprt *upper_transport =3D
> +               container_of(work, struct sock_xprt, connect_worker.work)=
;
> +       struct rpc_clnt *upper_clnt =3D upper_transport->clnt;
> +       struct rpc_xprt *upper_xprt =3D &upper_transport->xprt;
>         struct rpc_create_args args =3D {
> -               .net            =3D xprt->xprt_net,
> -               .protocol       =3D xprt->prot,
> -               .address        =3D (struct sockaddr *)&xprt->addr,
> -               .addrsize       =3D xprt->addrlen,
> -               .timeout        =3D clnt->cl_timeout,
> -               .servername     =3D xprt->servername,
> -               .nodename       =3D clnt->cl_nodename,
> -               .program        =3D clnt->cl_program,
> -               .prognumber     =3D clnt->cl_prog,
> -               .version        =3D clnt->cl_vers,
> +               .net            =3D upper_xprt->xprt_net,
> +               .protocol       =3D upper_xprt->prot,
> +               .address        =3D (struct sockaddr *)&upper_xprt->addr,
> +               .addrsize       =3D upper_xprt->addrlen,
> +               .timeout        =3D upper_clnt->cl_timeout,
> +               .servername     =3D upper_xprt->servername,
> +               .nodename       =3D upper_clnt->cl_nodename,
> +               .program        =3D upper_clnt->cl_program,
> +               .prognumber     =3D upper_clnt->cl_prog,
> +               .version        =3D upper_clnt->cl_vers,
>                 .authflavor     =3D RPC_AUTH_TLS,
> -               .cred           =3D clnt->cl_cred,
> +               .cred           =3D upper_clnt->cl_cred,
>                 .xprtsec        =3D {
>                         .policy         =3D RPC_XPRTSEC_NONE,
>                 },
> -               .flags          =3D RPC_CLNT_CREATE_NOPING,
>         };
> +       unsigned int pflags =3D current->flags;
> +       struct rpc_clnt *lower_clnt;
> +       struct rpc_xprt *lower_xprt;
> +       int status;
>
> -       switch (xprt->xprtsec.policy) {
> -       case RPC_XPRTSEC_TLS_ANON:
> -       case RPC_XPRTSEC_TLS_X509:
> -               transport->clnt =3D rpc_create(&args);
> -               break;
> -       default:
> -               transport->clnt =3D ERR_PTR(-ENOTCONN);
> +       if (atomic_read(&upper_xprt->swapper))
> +               current->flags |=3D PF_MEMALLOC;
> +
> +       xs_stream_start_connect(upper_transport);
> +
> +       /* This implicitly sends an RPC_AUTH_TLS probe */
> +       lower_clnt =3D rpc_create(&args);
> +       if (IS_ERR(lower_clnt)) {
> +               clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_st=
ate);
> +               xprt_clear_connecting(upper_xprt);
> +               xprt_wake_pending_tasks(upper_xprt, PTR_ERR(lower_clnt));
> +               smp_mb__before_atomic();
> +               xs_run_error_worker(upper_transport, XPRT_SOCK_WAKE_PENDI=
NG);
> +               goto out_unlock;
>         }
> +
> +       /* RPC_AUTH_TLS probe was successful. Try a TLS handshake on
> +        * the lower xprt.
> +        */
> +       rcu_read_lock();
> +       lower_xprt =3D rcu_dereference(lower_clnt->cl_xprt);
> +       rcu_read_unlock();
> +       status =3D xs_tls_handshake_sync(lower_xprt, &upper_xprt->xprtsec=
);
> +       if (status)
> +               goto out_close;
> +
> +       status =3D xs_tls_finish_connecting(lower_xprt, upper_transport);
> +       if (status)
> +               goto out_close;
> +
> +       trace_rpc_socket_connect(upper_xprt, upper_transport->sock, 0);
> +       if (!xprt_test_and_set_connected(upper_xprt)) {
> +               upper_xprt->connect_cookie++;
> +               clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_st=
ate);
> +               xprt_clear_connecting(upper_xprt);
> +
> +               upper_xprt->stat.connect_count++;
> +               upper_xprt->stat.connect_time +=3D (long)jiffies -
> +                                          upper_xprt->stat.connect_start=
;
> +               xs_run_error_worker(upper_transport, XPRT_SOCK_WAKE_PENDI=
NG);
> +       }
> +       rpc_shutdown_client(lower_clnt);
> +
> +out_unlock:
> +       current_restore_flags(pflags, PF_MEMALLOC);
> +       upper_transport->clnt =3D NULL;
> +       xprt_unlock_connect(upper_xprt, upper_transport);
> +       return;
> +
> +out_close:
> +       rpc_shutdown_client(lower_clnt);
> +
> +       /* xprt_force_disconnect() wakes tasks with a fixed tk_status cod=
e.
> +        * Wake them first here to ensure they get our tk_status code.
> +        */
> +       xprt_wake_pending_tasks(upper_xprt, status);
> +       xs_tcp_force_close(upper_xprt);
> +       xprt_clear_connecting(upper_xprt);
> +       goto out_unlock;
>  }
>
>  /**
> @@ -2498,8 +2714,7 @@ static void xs_connect(struct rpc_xprt *xprt, struc=
t rpc_task *task)
>         } else
>                 dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt=
);
>
> -       xs_set_transport_clnt(task->tk_client, xprt);
> -
> +       transport->clnt =3D task->tk_client;
>         queue_delayed_work(xprtiod_workqueue,
>                         &transport->connect_worker,
>                         delay);
>
>
