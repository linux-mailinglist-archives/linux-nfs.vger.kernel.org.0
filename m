Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F3456906C
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 19:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiGFROm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 13:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiGFROl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 13:14:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849E928720
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 10:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2F0E61E9E
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 17:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F86C3411C;
        Wed,  6 Jul 2022 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657127679;
        bh=mOVEHDLo3l6jekHoGdleMdjnVImCL2OjQWpPedzQlj8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PFa9kqtzsKIeh+M2tIt2zj1Dib3EfOcYKf7dvPY6oGLaNPlLGN45joS83X18yxeCQ
         RM3csr0nux3QdqT6XovLSfunjUxCo4/n6eohwXWojn28y5vH/4CdwgaUsPOhkrAW68
         etx7hK06LSFDGMtGwTwfPfY6cHk+ceTqgLcbKkmp27ZMiazPN2ERxabo0tsxL7T2eV
         7kwDagl6Tm5EYnM7p9f3rtKCm69ocfxDPUBb6mb4q0IMmbFYiur7HMMvMCdl2HqmL/
         8b647aigI2qOPA0wc0KMNQSNTCL0N+aexNl162Ubqd6yeHtLHCplTipW3B5OqIjRx7
         FFYkpwNAkffvQ==
Message-ID: <b586b5afbec012175e6014c9ba51af8963bfd4a3.camel@kernel.org>
Subject: Re: [PATCH v2 02/15] SUNRPC: Widen rpc_task::tk_flags
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Wed, 06 Jul 2022 13:14:37 -0400
In-Reply-To: <165452704158.1496.8199298253321400554.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
         <165452704158.1496.8199298253321400554.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-06-06 at 10:50 -0400, Chuck Lever wrote:
> There is just one unused bit left in rpc_task::tk_flags, and I will
> need two in subsequent patches. Double the width of the field to
> accommodate more flag bits.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/clnt.h  |    6 ++++--
>  include/linux/sunrpc/sched.h |   32 ++++++++++++++++----------------
>  net/sunrpc/clnt.c            |   11 ++++++-----
>  net/sunrpc/debugfs.c         |    2 +-
>  4 files changed, 27 insertions(+), 24 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
> index 90501404fa49..cbdd20dc84b7 100644
> --- a/include/linux/sunrpc/clnt.h
> +++ b/include/linux/sunrpc/clnt.h
> @@ -193,11 +193,13 @@ void rpc_prepare_reply_pages(struct rpc_rqst *req, =
struct page **pages,
>  			     unsigned int hdrsize);
>  void		rpc_call_start(struct rpc_task *);
>  int		rpc_call_async(struct rpc_clnt *clnt,
> -			       const struct rpc_message *msg, int flags,
> +			       const struct rpc_message *msg,
> +			       unsigned int flags,
>  			       const struct rpc_call_ops *tk_ops,
>  			       void *calldata);
>  int		rpc_call_sync(struct rpc_clnt *clnt,
> -			      const struct rpc_message *msg, int flags);
> +			      const struct rpc_message *msg,
> +			      unsigned int flags);
>  struct rpc_task *rpc_call_null(struct rpc_clnt *clnt, struct rpc_cred *c=
red,
>  			       int flags);
>  int		rpc_restart_call_prepare(struct rpc_task *);
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index 1d7a3e51b795..d4b7ebd0a99c 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -82,7 +82,7 @@ struct rpc_task {
>  	ktime_t			tk_start;	/* RPC task init timestamp */
> =20
>  	pid_t			tk_owner;	/* Process id for batching tasks */
> -	unsigned short		tk_flags;	/* misc flags */
> +	unsigned int		tk_flags;	/* misc flags */
>  	unsigned short		tk_timeouts;	/* maj timeouts */
> =20
>  #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
> @@ -112,27 +112,27 @@ struct rpc_task_setup {
>  	const struct rpc_call_ops *callback_ops;
>  	void *callback_data;
>  	struct workqueue_struct *workqueue;
> -	unsigned short flags;
> +	unsigned int flags;
>  	signed char priority;
>  };
> =20
>  /*
>   * RPC task flags
>   */
> -#define RPC_TASK_ASYNC		0x0001		/* is an async task */
> -#define RPC_TASK_SWAPPER	0x0002		/* is swapping in/out */
> -#define RPC_TASK_MOVEABLE	0x0004		/* nfs4.1+ rpc tasks */
> -#define RPC_TASK_NULLCREDS	0x0010		/* Use AUTH_NULL credential */
> -#define RPC_CALL_MAJORSEEN	0x0020		/* major timeout seen */
> -#define RPC_TASK_DYNAMIC	0x0080		/* task was kmalloc'ed */
> -#define	RPC_TASK_NO_ROUND_ROBIN	0x0100		/* send requests on "main" xprt =
*/
> -#define RPC_TASK_SOFT		0x0200		/* Use soft timeouts */
> -#define RPC_TASK_SOFTCONN	0x0400		/* Fail if can't connect */
> -#define RPC_TASK_SENT		0x0800		/* message was sent */
> -#define RPC_TASK_TIMEOUT	0x1000		/* fail with ETIMEDOUT on timeout */
> -#define RPC_TASK_NOCONNECT	0x2000		/* return ENOTCONN if not connected *=
/
> -#define RPC_TASK_NO_RETRANS_TIMEOUT	0x4000		/* wait forever for a reply =
*/
> -#define RPC_TASK_CRED_NOREF	0x8000		/* No refcount on the credential */
> +#define RPC_TASK_ASYNC			0x00000001	/* is an async task */
> +#define RPC_TASK_SWAPPER		0x00000002	/* is swapping in/out */
> +#define RPC_TASK_MOVEABLE		0x00000004	/* nfs4.1+ rpc tasks */
> +#define RPC_TASK_NULLCREDS		0x00000010	/* Use AUTH_NULL credential */
> +#define RPC_CALL_MAJORSEEN		0x00000020	/* major timeout seen */
> +#define RPC_TASK_DYNAMIC		0x00000080	/* task was kmalloc'ed */
> +#define	RPC_TASK_NO_ROUND_ROBIN		0x00000100	/* send requests on "main" x=
prt */
> +#define RPC_TASK_SOFT			0x00000200	/* Use soft timeouts */
> +#define RPC_TASK_SOFTCONN		0x00000400	/* Fail if can't connect */
> +#define RPC_TASK_SENT			0x00000800	/* message was sent */
> +#define RPC_TASK_TIMEOUT		0x00001000	/* fail with ETIMEDOUT on timeout *=
/
> +#define RPC_TASK_NOCONNECT		0x00002000	/* return ENOTCONN if not connect=
ed */
> +#define RPC_TASK_NO_RETRANS_TIMEOUT	0x00004000	/* wait forever for a rep=
ly */
> +#define RPC_TASK_CRED_NOREF		0x00008000	/* No refcount on the credential=
 */
> =20
>  #define RPC_IS_ASYNC(t)		((t)->tk_flags & RPC_TASK_ASYNC)
>  #define RPC_IS_SWAPPER(t)	((t)->tk_flags & RPC_TASK_SWAPPER)
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index ed13d55df720..8fd45de66882 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1161,7 +1161,8 @@ EXPORT_SYMBOL_GPL(rpc_run_task);
>   * @msg: RPC call parameters
>   * @flags: RPC call flags
>   */
> -int rpc_call_sync(struct rpc_clnt *clnt, const struct rpc_message *msg, =
int flags)
> +int rpc_call_sync(struct rpc_clnt *clnt, const struct rpc_message *msg,
> +		  unsigned int flags)
>  {
>  	struct rpc_task	*task;
>  	struct rpc_task_setup task_setup_data =3D {
> @@ -1196,9 +1197,9 @@ EXPORT_SYMBOL_GPL(rpc_call_sync);
>   * @tk_ops: RPC call ops
>   * @data: user call data
>   */
> -int
> -rpc_call_async(struct rpc_clnt *clnt, const struct rpc_message *msg, int=
 flags,
> -	       const struct rpc_call_ops *tk_ops, void *data)
> +int rpc_call_async(struct rpc_clnt *clnt, const struct rpc_message *msg,
> +		   unsigned int flags, const struct rpc_call_ops *tk_ops,
> +		   void *data)
>  {
>  	struct rpc_task	*task;
>  	struct rpc_task_setup task_setup_data =3D {
> @@ -3079,7 +3080,7 @@ static void rpc_show_task(const struct rpc_clnt *cl=
nt,
>  	if (RPC_IS_QUEUED(task))
>  		rpc_waitq =3D rpc_qname(task->tk_waitqueue);
> =20
> -	printk(KERN_INFO "%5u %04x %6d %8p %8p %8ld %8p %sv%u %s a:%ps q:%s\n",
> +	printk(KERN_INFO "%5u %08x %6d %8p %8p %8ld %8p %sv%u %s a:%ps q:%s\n",
>  		task->tk_pid, task->tk_flags, task->tk_status,
>  		clnt, task->tk_rqstp, rpc_task_timeout(task), task->tk_ops,
>  		clnt->cl_program->name, clnt->cl_vers, rpc_proc_name(task),
> diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
> index 7dc9cc929bfd..8b66235a3a49 100644
> --- a/net/sunrpc/debugfs.c
> +++ b/net/sunrpc/debugfs.c
> @@ -30,7 +30,7 @@ tasks_show(struct seq_file *f, void *v)
>  	if (task->tk_rqstp)
>  		xid =3D be32_to_cpu(task->tk_rqstp->rq_xid);
> =20
> -	seq_printf(f, "%5u %04x %6d 0x%x 0x%x %8ld %ps %sv%u %s a:%ps q:%s\n",
> +	seq_printf(f, "%5u %08x %6d 0x%x 0x%x %8ld %ps %sv%u %s a:%ps q:%s\n",
>  		task->tk_pid, task->tk_flags, task->tk_status,
>  		clnt->cl_clid, xid, rpc_task_timeout(task), task->tk_ops,
>  		clnt->cl_program->name, clnt->cl_vers, rpc_proc_name(task),
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
