Return-Path: <linux-nfs+bounces-8396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81779E79CE
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 21:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55F716B639
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 20:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459E51FD7B6;
	Fri,  6 Dec 2024 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="CWCIrYfm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA411C5490;
	Fri,  6 Dec 2024 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515559; cv=none; b=fezHinubyyXaRNDAO8BbAGnuIcP4VWje2ZigeQamOX61v5L/NiYSdePPycJ/7YeTa5Hgn0ftBJ0RZDsLbYLj6h3Sec5QNwUE4Khrbg1g2kKkQtri2ENFgigjJEGWNVupJvcbKzZVztqLZnCFrZvT7jmInNvs/HBlaO0/ffGw+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515559; c=relaxed/simple;
	bh=ZkAyDHoiZXuUqwRzLPJuGNgHzpQ9dkeWgabZ4ONtDhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f10ReLtH48PgmacPgTKDQGeXJZYaShg4XHOcZzGziyc3GhK7+373SQFDaZU0Z00Uf1bGmZKwRZyn0+b99Ipelnu78g6vBE3HKCTDa1Lz6VwxFfVgTGzadKUN+1dtON29oEecPyX6Gzz4womWSr8l6FlKmOa7heE3AS0Ca646WoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=CWCIrYfm; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1733515553; bh=ZkAyDHoiZXuUqwRzLPJuGNgHzpQ9dkeWgabZ4ONtDhs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CWCIrYfmr4jBC7IfciYLfthTNr3fRCZQuFiQb/5JiI+9MeVtS+CxqdqSpOoyuGKE7
	 DlVJxMOPjRYLPv6YnBABHRCG2SEWR4hfWWnbVvfMkb2QV+dyOYvdRSVmIhpZGU/qpR
	 hO+qaD1n98xGGxo1CsojlHhKYNPpddoQmTGX+ldloYg3gd00An3fytXUh1HHQ1MbXy
	 wcRcCIm+tChRGZwXXEEg8evuUvKGbteKTiAqabQoWmDeRp/s/IrJRJAh75v8pK31PQ
	 AxoQpd1VvXOyCi9EcJLTqZtQRLw1Hy3un+MZou8Duo6bMnWEVrkur1uiNdN7CDlWtT
	 7Cx4FjMUpUict119Nk61mgxeFjcuw8uMKJn6U6PQUh6hP4K/+nvWHm1tRrEWeyklfx
	 0KpOqK0iBXBoaxpc3rEWECr4RZMz0+pgUbVXWdtLEwz1m1BLyFAodQpQ5ZzqX5wFFH
	 UE8fOEKdTb34c0hXAZJJXX1ymS7XFGNqEdFiu5btb8APtZ9rRJyqWZRTdEhQ6dasgI
	 LVu2QwED1oxbrXaxP+u3MrpxV671szViq8vPCZUX1GUKDEJ6UC1x9eLsXK1QkawAiP
	 YRAR9VlJKbNNeKeQtzZY09mX838PgPspseu1w2kv92vvdm0YheiixZP/8Jol2fqaM4
	 FYPPHN8uRmabUmCVZGhZ91EI=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id B604218E22A;
	Fri,  6 Dec 2024 21:05:52 +0100 (CET)
Message-ID: <78666cf5-2214-413f-9450-19377a06049e@ijzerbout.nl>
Date: Fri, 6 Dec 2024 21:05:50 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] LSM: Ensure the correct LSM context releaser
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net, linux-integrity@vger.kernel.org,
 netdev@vger.kernel.org, audit@vger.kernel.org,
 netfilter-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Todd Kjos <tkjos@google.com>
References: <20241023212158.18718-1-casey@schaufler-ca.com>
 <20241023212158.18718-2-casey@schaufler-ca.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241023212158.18718-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 23-10-2024 om 23:21 schreef Casey Schaufler:
> Add a new lsm_context data structure to hold all the information about a
> "security context", including the string, its size and which LSM allocated
> the string. The allocation information is necessary because LSMs have
> different policies regarding the lifecycle of these strings. SELinux
> allocates and destroys them on each use, whereas Smack provides a pointer
> to an entry in a list that never goes away.
>
> Update security_release_secctx() to use the lsm_context instead of a
> (char *, len) pair. Change its callers to do likewise.  The LSMs
> supporting this hook have had comments added to remind the developer
> that there is more work to be done.
>
> The BPF security module provides all LSM hooks. While there has yet to
> be a known instance of a BPF configuration that uses security contexts,
> the possibility is real. In the existing implementation there is
> potential for multiple frees in that case.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: audit@vger.kernel.org
> Cc: netfilter-devel@vger.kernel.org
> To: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: linux-nfs@vger.kernel.org
> Cc: Todd Kjos <tkjos@google.com>
> ---
>   drivers/android/binder.c                | 24 +++++++--------
>   fs/ceph/xattr.c                         |  6 +++-
>   fs/nfs/nfs4proc.c                       |  8 +++--
>   fs/nfsd/nfs4xdr.c                       |  8 +++--
>   include/linux/lsm_hook_defs.h           |  2 +-
>   include/linux/security.h                | 35 ++++++++++++++++++++--
>   include/net/scm.h                       | 11 +++----
>   kernel/audit.c                          | 30 +++++++++----------
>   kernel/auditsc.c                        | 23 +++++++-------
>   net/ipv4/ip_sockglue.c                  | 10 +++----
>   net/netfilter/nf_conntrack_netlink.c    | 10 +++----
>   net/netfilter/nf_conntrack_standalone.c |  9 +++---
>   net/netfilter/nfnetlink_queue.c         | 13 +++++---
>   net/netlabel/netlabel_unlabeled.c       | 40 +++++++++++--------------
>   net/netlabel/netlabel_user.c            | 11 ++++---
>   security/apparmor/include/secid.h       |  2 +-
>   security/apparmor/secid.c               | 11 +++++--
>   security/security.c                     |  8 ++---
>   security/selinux/hooks.c                | 11 +++++--
>   19 files changed, 165 insertions(+), 107 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 978740537a1a..d4229bf6f789 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3011,8 +3011,7 @@ static void binder_transaction(struct binder_proc *proc,
>   	struct binder_context *context = proc->context;
>   	int t_debug_id = atomic_inc_return(&binder_last_id);
>   	ktime_t t_start_time = ktime_get();
> -	char *secctx = NULL;
> -	u32 secctx_sz = 0;
> +	struct lsm_context lsmctx;
Not initialized ?
>   	struct list_head sgc_head;
>   	struct list_head pf_head;
>   	const void __user *user_buffer = (const void __user *)
> @@ -3291,7 +3290,8 @@ static void binder_transaction(struct binder_proc *proc,
>   		size_t added_size;
>   
>   		security_cred_getsecid(proc->cred, &secid);
> -		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> +		ret = security_secid_to_secctx(secid, &lsmctx.context,
> +					       &lsmctx.len);
>   		if (ret) {
>   			binder_txn_error("%d:%d failed to get security context\n",
>   				thread->pid, proc->pid);
> @@ -3300,7 +3300,7 @@ static void binder_transaction(struct binder_proc *proc,
>   			return_error_line = __LINE__;
>   			goto err_get_secctx_failed;
>   		}
> -		added_size = ALIGN(secctx_sz, sizeof(u64));
> +		added_size = ALIGN(lsmctx.len, sizeof(u64));
>   		extra_buffers_size += added_size;
>   		if (extra_buffers_size < added_size) {
>   			binder_txn_error("%d:%d integer overflow of extra_buffers_size\n",
> @@ -3334,23 +3334,23 @@ static void binder_transaction(struct binder_proc *proc,
>   		t->buffer = NULL;
>   		goto err_binder_alloc_buf_failed;
>   	}
> -	if (secctx) {
> +	if (lsmctx.context) {
 From code inspection it is not immediately obvious. Can you
guarantee that lsmctx is always initialized when the code
gets to this point? Perhaps it is safer to just initialize when
it is defined above (line 3014).


