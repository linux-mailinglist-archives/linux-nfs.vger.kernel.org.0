Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D60778142E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 22:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354823AbjHRUMq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 16:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379964AbjHRUMc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 16:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958873C0A;
        Fri, 18 Aug 2023 13:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C7E26111E;
        Fri, 18 Aug 2023 20:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72932C433C7;
        Fri, 18 Aug 2023 20:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692389545;
        bh=2J9mZCtn5b7jC6cUUud8wEYdOLbQaF+FTWWcksyybP0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q7nyzk6y/dp4w5fAHbKd7dOd8LkjaNdz0lvBb7SSja6hSN1JrgzEwWfZNW2MQzkzX
         ej2/aLt+npkuzlbv3WSpKUIL6L3qg0oCDSNNVGIyJbSNQgxiJoHLtCsQeT5NsGxzdw
         rtxO5t1PBnNs7B1m5aVLXbrWFwggmAT+LtwsyqMJXkt+RIGJCCAVSv1ngFuzP1MVmP
         RuhKKmA0qzwqYS7YnFeq7ZYCiOswp1dvvURpIZBWnFoLElvKou1qgJtiBRxv6v7JFN
         7/z+2nFy8IEKmwvq+5nMIETlS4GE/uCMtDWxykymlZG/NjW6vxbO+KkoUE4cVC+yPF
         7o84cpxiTUb6A==
Message-ID: <a32e7ee72f47f5e25abd95d4db2fc6d50e32d5a2.camel@kernel.org>
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
From:   Jeff Layton <jlayton@kernel.org>
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Date:   Fri, 18 Aug 2023 16:12:22 -0400
In-Reply-To: <20230818041740.gonna.513-kees@kernel.org>
References: <20230818041740.gonna.513-kees@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-08-17 at 21:17 -0700, Kees Cook wrote:
> From: Elena Reshetova <elena.reshetova@intel.com>
>=20
> atomic_t variables are currently used to implement reference counters
> with the following properties:
>  - counter is initialized to 1 using atomic_set()
>  - a resource is freed upon counter reaching zero
>  - once counter reaches zero, its further
>    increments aren't allowed
>  - counter schema uses basic atomic operations
>    (set, inc, inc_not_zero, dec_and_test, etc.)
>=20
> Such atomic variables should be converted to a newly provided
> refcount_t type and API that prevents accidental counter overflows and
> underflows. This is important since overflows and underflows can lead
> to use-after-free situation and be exploitable.
>=20
> The variable cred.usage is used as pure reference counter. Convert it
> to refcount_t and fix up the operations.
>=20
> **Important note for maintainers:
>=20
> Some functions from refcount_t API defined in refcount.h have different
> memory ordering guarantees than their atomic counterparts. Please check
> Documentation/core-api/refcount-vs-atomic.rst for more information.
>=20
> Normally the differences should not matter since refcount_t provides
> enough guarantees to satisfy the refcounting use cases, but in some
> rare cases it might matter.  Please double check that you don't have
> some undocumented memory guarantees for this variable usage.
>=20
> For the cred.usage it might make a difference in following places:
>  - get_task_cred(): increment in refcount_inc_not_zero() only
>    guarantees control dependency on success vs. fully ordered atomic
>    counterpart
>  - put_cred(): decrement in refcount_dec_and_test() only
>    provides RELEASE ordering and ACQUIRE ordering on success vs. fully
>    ordered atomic counterpart
>=20
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Reviewed-by: David Windsor <dwindsor@gmail.com>
> Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: rebase
> v1: https://lore.kernel.org/lkml/20200612183450.4189588-4-keescook@chromi=
um.org/
> ---
>  include/linux/cred.h |  8 ++++----
>  kernel/cred.c        | 42 +++++++++++++++++++++---------------------
>  net/sunrpc/auth.c    |  2 +-
>  3 files changed, 26 insertions(+), 26 deletions(-)
>=20
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 8661f6294ad4..bf1c142afcec 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -109,7 +109,7 @@ static inline int groups_search(const struct group_in=
fo *group_info, kgid_t grp)
>   * same context as task->real_cred.
>   */
>  struct cred {
> -	atomic_t	usage;
> +	refcount_t	usage;
>  #ifdef CONFIG_DEBUG_CREDENTIALS
>  	atomic_t	subscribers;	/* number of processes subscribed */
>  	void		*put_addr;
> @@ -229,7 +229,7 @@ static inline bool cap_ambient_invariant_ok(const str=
uct cred *cred)
>   */
>  static inline struct cred *get_new_cred(struct cred *cred)
>  {
> -	atomic_inc(&cred->usage);
> +	refcount_inc(&cred->usage);
>  	return cred;
>  }
> =20
> @@ -261,7 +261,7 @@ static inline const struct cred *get_cred_rcu(const s=
truct cred *cred)
>  	struct cred *nonconst_cred =3D (struct cred *) cred;
>  	if (!cred)
>  		return NULL;
> -	if (!atomic_inc_not_zero(&nonconst_cred->usage))
> +	if (!refcount_inc_not_zero(&nonconst_cred->usage))
>  		return NULL;
>  	validate_creds(cred);
>  	nonconst_cred->non_rcu =3D 0;
> @@ -285,7 +285,7 @@ static inline void put_cred(const struct cred *_cred)
> =20
>  	if (cred) {
>  		validate_creds(cred);
> -		if (atomic_dec_and_test(&(cred)->usage))
> +		if (refcount_dec_and_test(&(cred)->usage))
>  			__put_cred(cred);
>  	}
>  }
> diff --git a/kernel/cred.c b/kernel/cred.c
> index bed458cfb812..33090c43bcac 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -39,7 +39,7 @@ static struct group_info init_groups =3D { .usage =3D R=
EFCOUNT_INIT(2) };
>   * The initial credentials for the initial task
>   */
>  struct cred init_cred =3D {
> -	.usage			=3D ATOMIC_INIT(4),
> +	.usage			=3D REFCOUNT_INIT(4),
>  #ifdef CONFIG_DEBUG_CREDENTIALS
>  	.subscribers		=3D ATOMIC_INIT(2),
>  	.magic			=3D CRED_MAGIC,
> @@ -99,17 +99,17 @@ static void put_cred_rcu(struct rcu_head *rcu)
> =20
>  #ifdef CONFIG_DEBUG_CREDENTIALS
>  	if (cred->magic !=3D CRED_MAGIC_DEAD ||
> -	    atomic_read(&cred->usage) !=3D 0 ||
> +	    refcount_read(&cred->usage) !=3D 0 ||
>  	    read_cred_subscribers(cred) !=3D 0)
>  		panic("CRED: put_cred_rcu() sees %p with"
>  		      " mag %x, put %p, usage %d, subscr %d\n",
>  		      cred, cred->magic, cred->put_addr,
> -		      atomic_read(&cred->usage),
> +		      refcount_read(&cred->usage),
>  		      read_cred_subscribers(cred));
>  #else
> -	if (atomic_read(&cred->usage) !=3D 0)
> +	if (refcount_read(&cred->usage) !=3D 0)
>  		panic("CRED: put_cred_rcu() sees %p with usage %d\n",
> -		      cred, atomic_read(&cred->usage));
> +		      cred, refcount_read(&cred->usage));
>  #endif
> =20
>  	security_cred_free(cred);
> @@ -135,10 +135,10 @@ static void put_cred_rcu(struct rcu_head *rcu)
>  void __put_cred(struct cred *cred)
>  {
>  	kdebug("__put_cred(%p{%d,%d})", cred,
> -	       atomic_read(&cred->usage),
> +	       refcount_read(&cred->usage),
>  	       read_cred_subscribers(cred));
> =20
> -	BUG_ON(atomic_read(&cred->usage) !=3D 0);
> +	BUG_ON(refcount_read(&cred->usage) !=3D 0);
>  #ifdef CONFIG_DEBUG_CREDENTIALS
>  	BUG_ON(read_cred_subscribers(cred) !=3D 0);
>  	cred->magic =3D CRED_MAGIC_DEAD;
> @@ -162,7 +162,7 @@ void exit_creds(struct task_struct *tsk)
>  	struct cred *cred;
> =20
>  	kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid, tsk->real_cred, tsk->c=
red,
> -	       atomic_read(&tsk->cred->usage),
> +	       refcount_read(&tsk->cred->usage),
>  	       read_cred_subscribers(tsk->cred));
> =20
>  	cred =3D (struct cred *) tsk->real_cred;
> @@ -221,7 +221,7 @@ struct cred *cred_alloc_blank(void)
>  	if (!new)
>  		return NULL;
> =20
> -	atomic_set(&new->usage, 1);
> +	refcount_set(&new->usage, 1);
>  #ifdef CONFIG_DEBUG_CREDENTIALS
>  	new->magic =3D CRED_MAGIC;
>  #endif
> @@ -267,7 +267,7 @@ struct cred *prepare_creds(void)
>  	memcpy(new, old, sizeof(struct cred));
> =20
>  	new->non_rcu =3D 0;
> -	atomic_set(&new->usage, 1);
> +	refcount_set(&new->usage, 1);
>  	set_cred_subscribers(new, 0);
>  	get_group_info(new->group_info);
>  	get_uid(new->user);
> @@ -356,7 +356,7 @@ int copy_creds(struct task_struct *p, unsigned long c=
lone_flags)
>  		get_cred(p->cred);
>  		alter_cred_subscribers(p->cred, 2);
>  		kdebug("share_creds(%p{%d,%d})",
> -		       p->cred, atomic_read(&p->cred->usage),
> +		       p->cred, refcount_read(&p->cred->usage),
>  		       read_cred_subscribers(p->cred));
>  		inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>  		return 0;
> @@ -450,7 +450,7 @@ int commit_creds(struct cred *new)
>  	const struct cred *old =3D task->real_cred;
> =20
>  	kdebug("commit_creds(%p{%d,%d})", new,
> -	       atomic_read(&new->usage),
> +	       refcount_read(&new->usage),
>  	       read_cred_subscribers(new));
> =20
>  	BUG_ON(task->cred !=3D old);
> @@ -459,7 +459,7 @@ int commit_creds(struct cred *new)
>  	validate_creds(old);
>  	validate_creds(new);
>  #endif
> -	BUG_ON(atomic_read(&new->usage) < 1);
> +	BUG_ON(refcount_read(&new->usage) < 1);
> =20
>  	get_cred(new); /* we will require a ref for the subj creds too */
> =20
> @@ -533,13 +533,13 @@ EXPORT_SYMBOL(commit_creds);
>  void abort_creds(struct cred *new)
>  {
>  	kdebug("abort_creds(%p{%d,%d})", new,
> -	       atomic_read(&new->usage),
> +	       refcount_read(&new->usage),
>  	       read_cred_subscribers(new));
> =20
>  #ifdef CONFIG_DEBUG_CREDENTIALS
>  	BUG_ON(read_cred_subscribers(new) !=3D 0);
>  #endif
> -	BUG_ON(atomic_read(&new->usage) < 1);
> +	BUG_ON(refcount_read(&new->usage) < 1);
>  	put_cred(new);
>  }
>  EXPORT_SYMBOL(abort_creds);
> @@ -556,7 +556,7 @@ const struct cred *override_creds(const struct cred *=
new)
>  	const struct cred *old =3D current->cred;
> =20
>  	kdebug("override_creds(%p{%d,%d})", new,
> -	       atomic_read(&new->usage),
> +	       refcount_read(&new->usage),
>  	       read_cred_subscribers(new));
> =20
>  	validate_creds(old);
> @@ -579,7 +579,7 @@ const struct cred *override_creds(const struct cred *=
new)
>  	alter_cred_subscribers(old, -1);
> =20
>  	kdebug("override_creds() =3D %p{%d,%d}", old,
> -	       atomic_read(&old->usage),
> +	       refcount_read(&old->usage),
>  	       read_cred_subscribers(old));
>  	return old;
>  }
> @@ -597,7 +597,7 @@ void revert_creds(const struct cred *old)
>  	const struct cred *override =3D current->cred;
> =20
>  	kdebug("revert_creds(%p{%d,%d})", old,
> -	       atomic_read(&old->usage),
> +	       refcount_read(&old->usage),
>  	       read_cred_subscribers(old));
> =20
>  	validate_creds(old);
> @@ -728,7 +728,7 @@ struct cred *prepare_kernel_cred(struct task_struct *=
daemon)
> =20
>  	*new =3D *old;
>  	new->non_rcu =3D 0;
> -	atomic_set(&new->usage, 1);
> +	refcount_set(&new->usage, 1);
>  	set_cred_subscribers(new, 0);
>  	get_uid(new->user);
>  	get_user_ns(new->user_ns);
> @@ -843,7 +843,7 @@ static void dump_invalid_creds(const struct cred *cre=
d, const char *label,
>  	printk(KERN_ERR "CRED: ->magic=3D%x, put_addr=3D%p\n",
>  	       cred->magic, cred->put_addr);
>  	printk(KERN_ERR "CRED: ->usage=3D%d, subscr=3D%d\n",
> -	       atomic_read(&cred->usage),
> +	       refcount_read(&cred->usage),
>  	       read_cred_subscribers(cred));
>  	printk(KERN_ERR "CRED: ->*uid =3D { %d,%d,%d,%d }\n",
>  		from_kuid_munged(&init_user_ns, cred->uid),
> @@ -917,7 +917,7 @@ void validate_creds_for_do_exit(struct task_struct *t=
sk)
>  {
>  	kdebug("validate_creds_for_do_exit(%p,%p{%d,%d})",
>  	       tsk->real_cred, tsk->cred,
> -	       atomic_read(&tsk->cred->usage),
> +	       refcount_read(&tsk->cred->usage),
>  	       read_cred_subscribers(tsk->cred));
> =20
>  	__validate_process_creds(tsk, __FILE__, __LINE__);
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 2f16f9d17966..f9f406249e7d 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -39,7 +39,7 @@ static LIST_HEAD(cred_unused);
>  static unsigned long number_cred_unused;
> =20
>  static struct cred machine_cred =3D {
> -	.usage =3D ATOMIC_INIT(1),
> +	.usage =3D REFCOUNT_INIT(1),
>  #ifdef CONFIG_DEBUG_CREDENTIALS
>  	.magic =3D CRED_MAGIC,
>  #endif

I wonder what sort of bugs this will uncover.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
