Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E347F964D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 17:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKLQz2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 11:55:28 -0500
Received: from fieldses.org ([173.255.197.46]:41100 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfKLQxb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 12 Nov 2019 11:53:31 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 29AC41C23; Tue, 12 Nov 2019 11:53:30 -0500 (EST)
Date:   Tue, 12 Nov 2019 11:53:30 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Subject: Re: [PATCH 1/2] sunrpc: remove __KERNEL__ ifdefs
Message-ID: <20191112165330.GD8905@fieldses.org>
References: <20191112153423.27337-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112153423.27337-1-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applied both, but if there turn out to be any conflicts I'm also
OK with it going through the client side or splitting it up somehow.

--b.

On Tue, Nov 12, 2019 at 04:34:22PM +0100, Christoph Hellwig wrote:
> Remove the __KERNEL__ ifdefs from the non-UAPI sunrpc headers,
> as those can't be included from user space programs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/sunrpc/auth.h        | 3 ---
>  include/linux/sunrpc/auth_gss.h    | 2 --
>  include/linux/sunrpc/clnt.h        | 3 ---
>  include/linux/sunrpc/gss_api.h     | 2 --
>  include/linux/sunrpc/gss_err.h     | 3 ---
>  include/linux/sunrpc/msg_prot.h    | 3 ---
>  include/linux/sunrpc/rpc_pipe_fs.h | 3 ---
>  include/linux/sunrpc/svcauth.h     | 4 ----
>  include/linux/sunrpc/svcauth_gss.h | 2 --
>  include/linux/sunrpc/xdr.h         | 3 ---
>  include/linux/sunrpc/xprt.h        | 4 ----
>  include/linux/sunrpc/xprtsock.h    | 4 ----
>  12 files changed, 36 deletions(-)
> 
> diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
> index 5f9076fdb090..e9ec742796e7 100644
> --- a/include/linux/sunrpc/auth.h
> +++ b/include/linux/sunrpc/auth.h
> @@ -10,8 +10,6 @@
>  #ifndef _LINUX_SUNRPC_AUTH_H
>  #define _LINUX_SUNRPC_AUTH_H
>  
> -#ifdef __KERNEL__
> -
>  #include <linux/sunrpc/sched.h>
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/sunrpc/xdr.h>
> @@ -194,5 +192,4 @@ struct rpc_cred *get_rpccred(struct rpc_cred *cred)
>  	return NULL;
>  }
>  
> -#endif /* __KERNEL__ */
>  #endif /* _LINUX_SUNRPC_AUTH_H */
> diff --git a/include/linux/sunrpc/auth_gss.h b/include/linux/sunrpc/auth_gss.h
> index 30427b729070..43e481aa347a 100644
> --- a/include/linux/sunrpc/auth_gss.h
> +++ b/include/linux/sunrpc/auth_gss.h
> @@ -13,7 +13,6 @@
>  #ifndef _LINUX_SUNRPC_AUTH_GSS_H
>  #define _LINUX_SUNRPC_AUTH_GSS_H
>  
> -#ifdef __KERNEL__
>  #include <linux/refcount.h>
>  #include <linux/sunrpc/auth.h>
>  #include <linux/sunrpc/svc.h>
> @@ -90,6 +89,5 @@ struct gss_cred {
>  	unsigned long		gc_upcall_timestamp;
>  };
>  
> -#endif /* __KERNEL__ */
>  #endif /* _LINUX_SUNRPC_AUTH_GSS_H */
>  
> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
> index abc63bd1be2b..64bffcb7142b 100644
> --- a/include/linux/sunrpc/clnt.h
> +++ b/include/linux/sunrpc/clnt.h
> @@ -109,8 +109,6 @@ struct rpc_procinfo {
>  	const char *		p_name;		/* name of procedure */
>  };
>  
> -#ifdef __KERNEL__
> -
>  struct rpc_create_args {
>  	struct net		*net;
>  	int			protocol;
> @@ -237,5 +235,4 @@ static inline int rpc_reply_expected(struct rpc_task *task)
>  		(task->tk_msg.rpc_proc->p_decode != NULL);
>  }
>  
> -#endif /* __KERNEL__ */
>  #endif /* _LINUX_SUNRPC_CLNT_H */
> diff --git a/include/linux/sunrpc/gss_api.h b/include/linux/sunrpc/gss_api.h
> index 5ac5db4d295f..bd691e08be3b 100644
> --- a/include/linux/sunrpc/gss_api.h
> +++ b/include/linux/sunrpc/gss_api.h
> @@ -13,7 +13,6 @@
>  #ifndef _LINUX_SUNRPC_GSS_API_H
>  #define _LINUX_SUNRPC_GSS_API_H
>  
> -#ifdef __KERNEL__
>  #include <linux/sunrpc/xdr.h>
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/uio.h>
> @@ -160,6 +159,5 @@ struct gss_api_mech * gss_mech_get(struct gss_api_mech *);
>   * corresponding call to gss_mech_put. */
>  void gss_mech_put(struct gss_api_mech *);
>  
> -#endif /* __KERNEL__ */
>  #endif /* _LINUX_SUNRPC_GSS_API_H */
>  
> diff --git a/include/linux/sunrpc/gss_err.h b/include/linux/sunrpc/gss_err.h
> index a6807867bd21..b73c329c83f2 100644
> --- a/include/linux/sunrpc/gss_err.h
> +++ b/include/linux/sunrpc/gss_err.h
> @@ -34,8 +34,6 @@
>  #ifndef _LINUX_SUNRPC_GSS_ERR_H
>  #define _LINUX_SUNRPC_GSS_ERR_H
>  
> -#ifdef __KERNEL__
> -
>  typedef unsigned int OM_uint32;
>  
>  /*
> @@ -163,5 +161,4 @@ typedef unsigned int OM_uint32;
>  /* XXXX This is a necessary evil until the spec is fixed */
>  #define GSS_S_CRED_UNAVAIL GSS_S_FAILURE
>  
> -#endif /* __KERNEL__ */
>  #endif /* __LINUX_SUNRPC_GSS_ERR_H */
> diff --git a/include/linux/sunrpc/msg_prot.h b/include/linux/sunrpc/msg_prot.h
> index 4722b28ec36a..bea40d9f03a1 100644
> --- a/include/linux/sunrpc/msg_prot.h
> +++ b/include/linux/sunrpc/msg_prot.h
> @@ -8,8 +8,6 @@
>  #ifndef _LINUX_SUNRPC_MSGPROT_H_
>  #define _LINUX_SUNRPC_MSGPROT_H_
>  
> -#ifdef __KERNEL__ /* user programs should get these from the rpc header files */
> -
>  #define RPC_VERSION 2
>  
>  /* size of an XDR encoding unit in bytes, i.e. 32bit */
> @@ -217,5 +215,4 @@ typedef __be32	rpc_fraghdr;
>  /* Assume INET6_ADDRSTRLEN will always be larger than INET_ADDRSTRLEN... */
>  #define RPCBIND_MAXUADDRLEN	RPCBIND_MAXUADDR6LEN
>  
> -#endif /* __KERNEL__ */
>  #endif /* _LINUX_SUNRPC_MSGPROT_H_ */
> diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
> index e90b9bd99ded..cd188a527d16 100644
> --- a/include/linux/sunrpc/rpc_pipe_fs.h
> +++ b/include/linux/sunrpc/rpc_pipe_fs.h
> @@ -2,8 +2,6 @@
>  #ifndef _LINUX_SUNRPC_RPC_PIPE_FS_H
>  #define _LINUX_SUNRPC_RPC_PIPE_FS_H
>  
> -#ifdef __KERNEL__
> -
>  #include <linux/workqueue.h>
>  
>  struct rpc_pipe_dir_head {
> @@ -133,4 +131,3 @@ extern void unregister_rpc_pipefs(void);
>  extern bool gssd_running(struct net *net);
>  
>  #endif
> -#endif
> diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
> index 3e53a6e2ada7..b0003866a249 100644
> --- a/include/linux/sunrpc/svcauth.h
> +++ b/include/linux/sunrpc/svcauth.h
> @@ -10,8 +10,6 @@
>  #ifndef _LINUX_SUNRPC_SVCAUTH_H_
>  #define _LINUX_SUNRPC_SVCAUTH_H_
>  
> -#ifdef __KERNEL__
> -
>  #include <linux/string.h>
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/sunrpc/cache.h>
> @@ -185,6 +183,4 @@ static inline unsigned long hash_mem(char const *buf, int length, int bits)
>  	return full_name_hash(NULL, buf, length) >> (32 - bits);
>  }
>  
> -#endif /* __KERNEL__ */
> -
>  #endif /* _LINUX_SUNRPC_SVCAUTH_H_ */
> diff --git a/include/linux/sunrpc/svcauth_gss.h b/include/linux/sunrpc/svcauth_gss.h
> index a4528b26c8aa..ca39a388dc22 100644
> --- a/include/linux/sunrpc/svcauth_gss.h
> +++ b/include/linux/sunrpc/svcauth_gss.h
> @@ -9,7 +9,6 @@
>  #ifndef _LINUX_SUNRPC_SVCAUTH_GSS_H
>  #define _LINUX_SUNRPC_SVCAUTH_GSS_H
>  
> -#ifdef __KERNEL__
>  #include <linux/sched.h>
>  #include <linux/sunrpc/types.h>
>  #include <linux/sunrpc/xdr.h>
> @@ -24,5 +23,4 @@ void gss_svc_shutdown_net(struct net *net);
>  int svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name);
>  u32 svcauth_gss_flavor(struct auth_domain *dom);
>  
> -#endif /* __KERNEL__ */
>  #endif /* _LINUX_SUNRPC_SVCAUTH_GSS_H */
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index f33e5013bdfb..b41f34977995 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -11,8 +11,6 @@
>  #ifndef _SUNRPC_XDR_H_
>  #define _SUNRPC_XDR_H_
>  
> -#ifdef __KERNEL__
> -
>  #include <linux/uio.h>
>  #include <asm/byteorder.h>
>  #include <asm/unaligned.h>
> @@ -552,6 +550,5 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
>  		*array = be32_to_cpup(p);
>  	return retval;
>  }
> -#endif /* __KERNEL__ */
>  
>  #endif /* _SUNRPC_XDR_H_ */
> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index d783e15ba898..874205227778 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -19,8 +19,6 @@
>  #include <linux/sunrpc/xdr.h>
>  #include <linux/sunrpc/msg_prot.h>
>  
> -#ifdef __KERNEL__
> -
>  #define RPC_MIN_SLOT_TABLE	(2U)
>  #define RPC_DEF_SLOT_TABLE	(16U)
>  #define RPC_MAX_SLOT_TABLE_LIMIT	(65536U)
> @@ -505,6 +503,4 @@ static inline void xprt_inject_disconnect(struct rpc_xprt *xprt)
>  }
>  #endif
>  
> -#endif /* __KERNEL__*/
> -
>  #endif /* _LINUX_SUNRPC_XPRT_H */
> diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
> index a940de03808d..3c1423ee74b4 100644
> --- a/include/linux/sunrpc/xprtsock.h
> +++ b/include/linux/sunrpc/xprtsock.h
> @@ -8,8 +8,6 @@
>  #ifndef _LINUX_SUNRPC_XPRTSOCK_H
>  #define _LINUX_SUNRPC_XPRTSOCK_H
>  
> -#ifdef __KERNEL__
> -
>  int		init_socket_xprt(void);
>  void		cleanup_socket_xprt(void);
>  
> @@ -91,6 +89,4 @@ struct sock_xprt {
>  #define XPRT_SOCK_WAKE_PENDING	(6)
>  #define XPRT_SOCK_WAKE_DISCONNECT	(7)
>  
> -#endif /* __KERNEL__ */
> -
>  #endif /* _LINUX_SUNRPC_XPRTSOCK_H */
> -- 
> 2.20.1
