Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D66A24FF52
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Aug 2020 15:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHXNxn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Aug 2020 09:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHXNxl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Aug 2020 09:53:41 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3918C061573
        for <linux-nfs@vger.kernel.org>; Mon, 24 Aug 2020 06:53:41 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e11so7272310ils.10
        for <linux-nfs@vger.kernel.org>; Mon, 24 Aug 2020 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AAmMHH05bjsNsljU7cO0eHbLpA0Gp4jkp3UV8bvZbts=;
        b=RHB2oDisOGED/c1WMeoIGQEFmgi6CHStA3q2u5Ykwo9B6m4prOF64x5EQZY2pGnpr3
         KYHmd97tZZ8wQcPGc/KYxRvJlSA0lnfO2cbcYYnxIv/o6xAsX5TemsbbILaWvb6Ok5+V
         U0W0+oYL4bX2S1Q6PQgQyKXIquS1wrgSQVJD3ZFFXIGYjoEE1Viw9e3l6YsSL1W2NK5y
         GtcWDqNKFradFRA3nDciUuQwqLGk9OxJ5Ryej4FHhscBPey9/hkGp8MVSUDSH7JBnnSG
         eC1waS5TFxcgL69eOwr9wc0EkuCx5f16XUlgAPG/BA4KGt5VL09/FOQ5iFO7fSM0x3P5
         jyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AAmMHH05bjsNsljU7cO0eHbLpA0Gp4jkp3UV8bvZbts=;
        b=TW4P7ruYgN7Uxd8gAN8RTtGxrQYQNZhL7AXnYlcAZq97Ri5lzExnXx/FpvMpUmVqnt
         XUB/GHh7E5PbGNVRul/LXGluAseFm3INkiNETQ+barPeuWTQ1bAL7NOJsfznLe7m5Knj
         b+bNMxhDWr3VVC62SqddO8Q/hUIRQmqOtHa9c/RWwxlt9OHhRb6PZYQTBRw6eXv3t3hM
         2tKYKdmSQkYgd644V4thk1XthdIJ2yKswa4+giKbHBNbJA7cFNQar7LENvy/ZVyLCw5e
         xblh4z3UdWRWc13aGowCa1kwVzAhJgUnTO35UwqWPZ7XfpgKK/SrISkMtyPPzoHljc66
         MH+g==
X-Gm-Message-State: AOAM533APQCS3KKRtrPkwsQewHGk95aLwcACwhoYoCVWgY91lDtJRayB
        jvaoRIJlw5t/taHIUkdeFErppsDzoPw=
X-Google-Smtp-Source: ABdhPJxMrOcl9KRflu9NF0AmfJyXqRbBmVCsreg8ROC0UjQNysjddjhkoSbKA9kcU9EU2+fi7s83Ww==
X-Received: by 2002:a92:9117:: with SMTP id t23mr5328703ild.177.1598277220725;
        Mon, 24 Aug 2020 06:53:40 -0700 (PDT)
Received: from anon-dhcp-152.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t16sm7390273ili.75.2020.08.24.06.53.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 06:53:39 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] nfsd: remove fault injection code
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20200820194944.GC28555@fieldses.org>
Date:   Mon, 24 Aug 2020 09:53:37 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6895C9AD-3622-4925-A268-23E6404C42D1@gmail.com>
References: <20200820194944.GC28555@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

> On Aug 20, 2020, at 3:49 PM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> It was an interesting idea but nobody seems to be using it, it's buggy
> at this point, and nfs4state.c is already complicated enough without =
it.
> The new nfsd/clients/ code provides some of the same functionality, =
and
> could probably do more if desired.

Maybe this should mention that the feature has been deprecated since
9d60d93198c6 ("Deprecate nfsd fault injection").


> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> .../admin-guide/nfs/fault_injection.rst       |  70 ---
> Documentation/admin-guide/nfs/index.rst       |   1 -
> fs/nfsd/Kconfig                               |  10 -
> fs/nfsd/Makefile                              |   1 -
> fs/nfsd/nfs4state.c                           | 593 ------------------
> fs/nfsd/nfsctl.c                              |   3 -
> fs/nfsd/state.h                               |  27 -
> tools/nfsd/inject_fault.sh                    |  50 --
> 8 files changed, 755 deletions(-)
> delete mode 100644 Documentation/admin-guide/nfs/fault_injection.rst
> delete mode 100755 tools/nfsd/inject_fault.sh
>=20
> diff --git a/Documentation/admin-guide/nfs/fault_injection.rst =
b/Documentation/admin-guide/nfs/fault_injection.rst
> deleted file mode 100644
> index eb029c0c15ce..000000000000
> --- a/Documentation/admin-guide/nfs/fault_injection.rst
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -NFS Fault Injection
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Fault injection is a method for forcing errors that may not normally =
occur, or
> -may be difficult to reproduce.  Forcing these errors in a controlled =
environment
> -can help the developer find and fix bugs before their code is shipped =
in a
> -production system.  Injecting an error on the Linux NFS server will =
allow us to
> -observe how the client reacts and if it manages to recover its state =
correctly.
> -
> -NFSD_FAULT_INJECTION must be selected when configuring the kernel to =
use this
> -feature.
> -
> -
> -Using Fault Injection
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -On the client, mount the fault injection server through NFS v4.0+ and =
do some
> -work over NFS (open files, take locks, ...).
> -
> -On the server, mount the debugfs filesystem to <debug_dir> and ls
> -<debug_dir>/nfsd.  This will show a list of files that will be used =
for
> -injecting faults on the NFS server.  As root, write a number n to the =
file
> -corresponding to the action you want the server to take.  The server =
will then
> -process the first n items it finds.  So if you want to forget 5 =
locks, echo '5'
> -to <debug_dir>/nfsd/forget_locks.  A value of 0 will tell the server =
to forget
> -all corresponding items.  A log message will be created containing =
the number
> -of items forgotten (check dmesg).
> -
> -Go back to work on the client and check if the client recovered from =
the error
> -correctly.
> -
> -
> -Available Faults
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -forget_clients:
> -     The NFS server keeps a list of clients that have placed a mount =
call.  If
> -     this list is cleared, the server will have no knowledge of who =
the client
> -     is, forcing the client to reauthenticate with the server.
> -
> -forget_openowners:
> -     The NFS server keeps a list of what files are currently opened =
and who
> -     they were opened by.  Clearing this list will force the client =
to reopen
> -     its files.
> -
> -forget_locks:
> -     The NFS server keeps a list of what files are currently locked =
in the VFS.
> -     Clearing this list will force the client to reclaim its locks =
(files are
> -     unlocked through the VFS as they are cleared from this list).
> -
> -forget_delegations:
> -     A delegation is used to assure the client that a file, or part =
of a file,
> -     has not changed since the delegation was awarded.  Clearing this =
list will
> -     force the client to reacquire its delegation before accessing =
the file
> -     again.
> -
> -recall_delegations:
> -     Delegations can be recalled by the server when another client =
attempts to
> -     access a file.  This test will notify the client that its =
delegation has
> -     been revoked, forcing the client to reacquire the delegation =
before using
> -     the file again.
> -
> -
> -tools/nfs/inject_faults.sh script
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -This script has been created to ease the fault injection process.  =
This script
> -will detect the mounted debugfs directory and write to the files =
located there
> -based on the arguments passed by the user.  For example, running
> -`inject_faults.sh forget_locks 1` as root will instruct the server to =
forget
> -one lock.  Running `inject_faults forget_locks` will instruct the =
server to
> -forgetall locks.
> diff --git a/Documentation/admin-guide/nfs/index.rst =
b/Documentation/admin-guide/nfs/index.rst
> index 6b5a3c90fac5..3601a708f333 100644
> --- a/Documentation/admin-guide/nfs/index.rst
> +++ b/Documentation/admin-guide/nfs/index.rst
> @@ -12,4 +12,3 @@ NFS
>     nfs-idmapper
>     pnfs-block-server
>     pnfs-scsi-server
> -    fault_injection
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 99d2cae91bd6..9223e13c3051 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -156,13 +156,3 @@ config NFSD_V4_SECURITY_LABEL
>=20
> 	If you do not wish to enable fine-grained security labels =
SELinux or
> 	Smack policies on NFSv4 files, say N.
> -
> -config NFSD_FAULT_INJECTION
> -	bool "NFS server manual fault injection"
> -	depends on NFSD_V4 && DEBUG_KERNEL && DEBUG_FS && BROKEN
> -	help
> -	  This option enables support for manually injecting faults
> -	  into the NFS server.  This is intended to be used for
> -	  testing error recovery on the NFS client.
> -
> -	  If unsure, say N.
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index 6a40b1afe703..3f0983e93a99 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -13,7 +13,6 @@ nfsd-y			+=3D trace.o
> nfsd-y 			+=3D nfssvc.o nfsctl.o nfsproc.o nfsfh.o =
vfs.o \
> 			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
> 			   stats.o filecache.o
> -nfsd-$(CONFIG_NFSD_FAULT_INJECTION) +=3D fault_inject.o
> nfsd-$(CONFIG_NFSD_V2_ACL) +=3D nfs2acl.o
> nfsd-$(CONFIG_NFSD_V3)	+=3D nfs3proc.o nfs3xdr.o
> nfsd-$(CONFIG_NFSD_V3_ACL) +=3D nfs3acl.o
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 81ed8e8bab3f..4c9c79fdc3b8 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7251,599 +7251,6 @@ nfs4_check_open_reclaim(clientid_t *clid,
> 	return nfs_ok;
> }
>=20
> -#ifdef CONFIG_NFSD_FAULT_INJECTION
> -static inline void
> -put_client(struct nfs4_client *clp)
> -{
> -	atomic_dec(&clp->cl_rpc_users);
> -}
> -
> -static struct nfs4_client *
> -nfsd_find_client(struct sockaddr_storage *addr, size_t addr_size)
> -{
> -	struct nfs4_client *clp;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -					  nfsd_net_id);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return NULL;
> -
> -	list_for_each_entry(clp, &nn->client_lru, cl_lru) {
> -		if (memcmp(&clp->cl_addr, addr, addr_size) =3D=3D 0)
> -			return clp;
> -	}
> -	return NULL;
> -}
> -
> -u64
> -nfsd_inject_print_clients(void)
> -{
> -	struct nfs4_client *clp;
> -	u64 count =3D 0;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -					  nfsd_net_id);
> -	char buf[INET6_ADDRSTRLEN];
> -
> -	if (!nfsd_netns_ready(nn))
> -		return 0;
> -
> -	spin_lock(&nn->client_lock);
> -	list_for_each_entry(clp, &nn->client_lru, cl_lru) {
> -		rpc_ntop((struct sockaddr *)&clp->cl_addr, buf, =
sizeof(buf));
> -		pr_info("NFS Client: %s\n", buf);
> -		++count;
> -	}
> -	spin_unlock(&nn->client_lock);
> -
> -	return count;
> -}
> -
> -u64
> -nfsd_inject_forget_client(struct sockaddr_storage *addr, size_t =
addr_size)
> -{
> -	u64 count =3D 0;
> -	struct nfs4_client *clp;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -					  nfsd_net_id);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return count;
> -
> -	spin_lock(&nn->client_lock);
> -	clp =3D nfsd_find_client(addr, addr_size);
> -	if (clp) {
> -		if (mark_client_expired_locked(clp) =3D=3D nfs_ok)
> -			++count;
> -		else
> -			clp =3D NULL;
> -	}
> -	spin_unlock(&nn->client_lock);
> -
> -	if (clp)
> -		expire_client(clp);
> -
> -	return count;
> -}
> -
> -u64
> -nfsd_inject_forget_clients(u64 max)
> -{
> -	u64 count =3D 0;
> -	struct nfs4_client *clp, *next;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -	LIST_HEAD(reaplist);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return count;
> -
> -	spin_lock(&nn->client_lock);
> -	list_for_each_entry_safe(clp, next, &nn->client_lru, cl_lru) {
> -		if (mark_client_expired_locked(clp) =3D=3D nfs_ok) {
> -			list_add(&clp->cl_lru, &reaplist);
> -			if (max !=3D 0 && ++count >=3D max)
> -				break;
> -		}
> -	}
> -	spin_unlock(&nn->client_lock);
> -
> -	list_for_each_entry_safe(clp, next, &reaplist, cl_lru)
> -		expire_client(clp);
> -
> -	return count;
> -}
> -
> -static void nfsd_print_count(struct nfs4_client *clp, unsigned int =
count,
> -			     const char *type)
> -{
> -	char buf[INET6_ADDRSTRLEN];
> -	rpc_ntop((struct sockaddr *)&clp->cl_addr, buf, sizeof(buf));
> -	printk(KERN_INFO "NFS Client: %s has %u %s\n", buf, count, =
type);
> -}
> -
> -static void
> -nfsd_inject_add_lock_to_list(struct nfs4_ol_stateid *lst,
> -			     struct list_head *collect)
> -{
> -	struct nfs4_client *clp =3D lst->st_stid.sc_client;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -					  nfsd_net_id);
> -
> -	if (!collect)
> -		return;
> -
> -	lockdep_assert_held(&nn->client_lock);
> -	atomic_inc(&clp->cl_rpc_users);
> -	list_add(&lst->st_locks, collect);
> -}
> -
> -static u64 nfsd_foreach_client_lock(struct nfs4_client *clp, u64 max,
> -				    struct list_head *collect,
> -				    bool (*func)(struct nfs4_ol_stateid =
*))
> -{
> -	struct nfs4_openowner *oop;
> -	struct nfs4_ol_stateid *stp, *st_next;
> -	struct nfs4_ol_stateid *lst, *lst_next;
> -	u64 count =3D 0;
> -
> -	spin_lock(&clp->cl_lock);
> -	list_for_each_entry(oop, &clp->cl_openowners, oo_perclient) {
> -		list_for_each_entry_safe(stp, st_next,
> -				&oop->oo_owner.so_stateids, =
st_perstateowner) {
> -			list_for_each_entry_safe(lst, lst_next,
> -					&stp->st_locks, st_locks) {
> -				if (func) {
> -					if (func(lst))
> -						=
nfsd_inject_add_lock_to_list(lst,
> -									=
collect);
> -				}
> -				++count;
> -				/*
> -				 * Despite the fact that these functions =
deal
> -				 * with 64-bit integers for "count", we =
must
> -				 * ensure that it doesn't blow up the
> -				 * clp->cl_rpc_users. Throw a warning if =
we
> -				 * start to approach INT_MAX here.
> -				 */
> -				WARN_ON_ONCE(count =3D=3D (INT_MAX / =
2));
> -				if (count =3D=3D max)
> -					goto out;
> -			}
> -		}
> -	}
> -out:
> -	spin_unlock(&clp->cl_lock);
> -
> -	return count;
> -}
> -
> -static u64
> -nfsd_collect_client_locks(struct nfs4_client *clp, struct list_head =
*collect,
> -			  u64 max)
> -{
> -	return nfsd_foreach_client_lock(clp, max, collect, =
unhash_lock_stateid);
> -}
> -
> -static u64
> -nfsd_print_client_locks(struct nfs4_client *clp)
> -{
> -	u64 count =3D nfsd_foreach_client_lock(clp, 0, NULL, NULL);
> -	nfsd_print_count(clp, count, "locked files");
> -	return count;
> -}
> -
> -u64
> -nfsd_inject_print_locks(void)
> -{
> -	struct nfs4_client *clp;
> -	u64 count =3D 0;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return 0;
> -
> -	spin_lock(&nn->client_lock);
> -	list_for_each_entry(clp, &nn->client_lru, cl_lru)
> -		count +=3D nfsd_print_client_locks(clp);
> -	spin_unlock(&nn->client_lock);
> -
> -	return count;
> -}
> -
> -static void
> -nfsd_reap_locks(struct list_head *reaplist)
> -{
> -	struct nfs4_client *clp;
> -	struct nfs4_ol_stateid *stp, *next;
> -
> -	list_for_each_entry_safe(stp, next, reaplist, st_locks) {
> -		list_del_init(&stp->st_locks);
> -		clp =3D stp->st_stid.sc_client;
> -		nfs4_put_stid(&stp->st_stid);
> -		put_client(clp);
> -	}
> -}
> -
> -u64
> -nfsd_inject_forget_client_locks(struct sockaddr_storage *addr, size_t =
addr_size)
> -{
> -	unsigned int count =3D 0;
> -	struct nfs4_client *clp;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -	LIST_HEAD(reaplist);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return count;
> -
> -	spin_lock(&nn->client_lock);
> -	clp =3D nfsd_find_client(addr, addr_size);
> -	if (clp)
> -		count =3D nfsd_collect_client_locks(clp, &reaplist, 0);
> -	spin_unlock(&nn->client_lock);
> -	nfsd_reap_locks(&reaplist);
> -	return count;
> -}
> -
> -u64
> -nfsd_inject_forget_locks(u64 max)
> -{
> -	u64 count =3D 0;
> -	struct nfs4_client *clp;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -	LIST_HEAD(reaplist);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return count;
> -
> -	spin_lock(&nn->client_lock);
> -	list_for_each_entry(clp, &nn->client_lru, cl_lru) {
> -		count +=3D nfsd_collect_client_locks(clp, &reaplist, max =
- count);
> -		if (max !=3D 0 && count >=3D max)
> -			break;
> -	}
> -	spin_unlock(&nn->client_lock);
> -	nfsd_reap_locks(&reaplist);
> -	return count;
> -}
> -
> -static u64
> -nfsd_foreach_client_openowner(struct nfs4_client *clp, u64 max,
> -			      struct list_head *collect,
> -			      void (*func)(struct nfs4_openowner *))
> -{
> -	struct nfs4_openowner *oop, *next;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -	u64 count =3D 0;
> -
> -	lockdep_assert_held(&nn->client_lock);
> -
> -	spin_lock(&clp->cl_lock);
> -	list_for_each_entry_safe(oop, next, &clp->cl_openowners, =
oo_perclient) {
> -		if (func) {
> -			func(oop);
> -			if (collect) {
> -				atomic_inc(&clp->cl_rpc_users);
> -				list_add(&oop->oo_perclient, collect);
> -			}
> -		}
> -		++count;
> -		/*
> -		 * Despite the fact that these functions deal with
> -		 * 64-bit integers for "count", we must ensure that
> -		 * it doesn't blow up the clp->cl_rpc_users. Throw a
> -		 * warning if we start to approach INT_MAX here.
> -		 */
> -		WARN_ON_ONCE(count =3D=3D (INT_MAX / 2));
> -		if (count =3D=3D max)
> -			break;
> -	}
> -	spin_unlock(&clp->cl_lock);
> -
> -	return count;
> -}
> -
> -static u64
> -nfsd_print_client_openowners(struct nfs4_client *clp)
> -{
> -	u64 count =3D nfsd_foreach_client_openowner(clp, 0, NULL, NULL);
> -
> -	nfsd_print_count(clp, count, "openowners");
> -	return count;
> -}
> -
> -static u64
> -nfsd_collect_client_openowners(struct nfs4_client *clp,
> -			       struct list_head *collect, u64 max)
> -{
> -	return nfsd_foreach_client_openowner(clp, max, collect,
> -						=
unhash_openowner_locked);
> -}
> -
> -u64
> -nfsd_inject_print_openowners(void)
> -{
> -	struct nfs4_client *clp;
> -	u64 count =3D 0;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return 0;
> -
> -	spin_lock(&nn->client_lock);
> -	list_for_each_entry(clp, &nn->client_lru, cl_lru)
> -		count +=3D nfsd_print_client_openowners(clp);
> -	spin_unlock(&nn->client_lock);
> -
> -	return count;
> -}
> -
> -static void
> -nfsd_reap_openowners(struct list_head *reaplist)
> -{
> -	struct nfs4_client *clp;
> -	struct nfs4_openowner *oop, *next;
> -
> -	list_for_each_entry_safe(oop, next, reaplist, oo_perclient) {
> -		list_del_init(&oop->oo_perclient);
> -		clp =3D oop->oo_owner.so_client;
> -		release_openowner(oop);
> -		put_client(clp);
> -	}
> -}
> -
> -u64
> -nfsd_inject_forget_client_openowners(struct sockaddr_storage *addr,
> -				     size_t addr_size)
> -{
> -	unsigned int count =3D 0;
> -	struct nfs4_client *clp;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -	LIST_HEAD(reaplist);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return count;
> -
> -	spin_lock(&nn->client_lock);
> -	clp =3D nfsd_find_client(addr, addr_size);
> -	if (clp)
> -		count =3D nfsd_collect_client_openowners(clp, &reaplist, =
0);
> -	spin_unlock(&nn->client_lock);
> -	nfsd_reap_openowners(&reaplist);
> -	return count;
> -}
> -
> -u64
> -nfsd_inject_forget_openowners(u64 max)
> -{
> -	u64 count =3D 0;
> -	struct nfs4_client *clp;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -	LIST_HEAD(reaplist);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return count;
> -
> -	spin_lock(&nn->client_lock);
> -	list_for_each_entry(clp, &nn->client_lru, cl_lru) {
> -		count +=3D nfsd_collect_client_openowners(clp, =
&reaplist,
> -							max - count);
> -		if (max !=3D 0 && count >=3D max)
> -			break;
> -	}
> -	spin_unlock(&nn->client_lock);
> -	nfsd_reap_openowners(&reaplist);
> -	return count;
> -}
> -
> -static u64 nfsd_find_all_delegations(struct nfs4_client *clp, u64 =
max,
> -				     struct list_head *victims)
> -{
> -	struct nfs4_delegation *dp, *next;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -	u64 count =3D 0;
> -
> -	lockdep_assert_held(&nn->client_lock);
> -
> -	spin_lock(&state_lock);
> -	list_for_each_entry_safe(dp, next, &clp->cl_delegations, =
dl_perclnt) {
> -		if (victims) {
> -			/*
> -			 * It's not safe to mess with delegations that =
have a
> -			 * non-zero dl_time. They might have already =
been broken
> -			 * and could be processed by the laundromat =
outside of
> -			 * the state_lock. Just leave them be.
> -			 */
> -			if (dp->dl_time !=3D 0)
> -				continue;
> -
> -			atomic_inc(&clp->cl_rpc_users);
> -			WARN_ON(!unhash_delegation_locked(dp));
> -			list_add(&dp->dl_recall_lru, victims);
> -		}
> -		++count;
> -		/*
> -		 * Despite the fact that these functions deal with
> -		 * 64-bit integers for "count", we must ensure that
> -		 * it doesn't blow up the clp->cl_rpc_users. Throw a
> -		 * warning if we start to approach INT_MAX here.
> -		 */
> -		WARN_ON_ONCE(count =3D=3D (INT_MAX / 2));
> -		if (count =3D=3D max)
> -			break;
> -	}
> -	spin_unlock(&state_lock);
> -	return count;
> -}
> -
> -static u64
> -nfsd_print_client_delegations(struct nfs4_client *clp)
> -{
> -	u64 count =3D nfsd_find_all_delegations(clp, 0, NULL);
> -
> -	nfsd_print_count(clp, count, "delegations");
> -	return count;
> -}
> -
> -u64
> -nfsd_inject_print_delegations(void)
> -{
> -	struct nfs4_client *clp;
> -	u64 count =3D 0;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return 0;
> -
> -	spin_lock(&nn->client_lock);
> -	list_for_each_entry(clp, &nn->client_lru, cl_lru)
> -		count +=3D nfsd_print_client_delegations(clp);
> -	spin_unlock(&nn->client_lock);
> -
> -	return count;
> -}
> -
> -static void
> -nfsd_forget_delegations(struct list_head *reaplist)
> -{
> -	struct nfs4_client *clp;
> -	struct nfs4_delegation *dp, *next;
> -
> -	list_for_each_entry_safe(dp, next, reaplist, dl_recall_lru) {
> -		list_del_init(&dp->dl_recall_lru);
> -		clp =3D dp->dl_stid.sc_client;
> -		revoke_delegation(dp);
> -		put_client(clp);
> -	}
> -}
> -
> -u64
> -nfsd_inject_forget_client_delegations(struct sockaddr_storage *addr,
> -				      size_t addr_size)
> -{
> -	u64 count =3D 0;
> -	struct nfs4_client *clp;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -	LIST_HEAD(reaplist);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return count;
> -
> -	spin_lock(&nn->client_lock);
> -	clp =3D nfsd_find_client(addr, addr_size);
> -	if (clp)
> -		count =3D nfsd_find_all_delegations(clp, 0, &reaplist);
> -	spin_unlock(&nn->client_lock);
> -
> -	nfsd_forget_delegations(&reaplist);
> -	return count;
> -}
> -
> -u64
> -nfsd_inject_forget_delegations(u64 max)
> -{
> -	u64 count =3D 0;
> -	struct nfs4_client *clp;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -	LIST_HEAD(reaplist);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return count;
> -
> -	spin_lock(&nn->client_lock);
> -	list_for_each_entry(clp, &nn->client_lru, cl_lru) {
> -		count +=3D nfsd_find_all_delegations(clp, max - count, =
&reaplist);
> -		if (max !=3D 0 && count >=3D max)
> -			break;
> -	}
> -	spin_unlock(&nn->client_lock);
> -	nfsd_forget_delegations(&reaplist);
> -	return count;
> -}
> -
> -static void
> -nfsd_recall_delegations(struct list_head *reaplist)
> -{
> -	struct nfs4_client *clp;
> -	struct nfs4_delegation *dp, *next;
> -
> -	list_for_each_entry_safe(dp, next, reaplist, dl_recall_lru) {
> -		list_del_init(&dp->dl_recall_lru);
> -		clp =3D dp->dl_stid.sc_client;
> -
> -		trace_nfsd_deleg_recall(&dp->dl_stid.sc_stateid);
> -
> -		/*
> -		 * We skipped all entries that had a zero dl_time =
before,
> -		 * so we can now reset the dl_time back to 0. If a =
delegation
> -		 * break comes in now, then it won't make any difference =
since
> -		 * we're recalling it either way.
> -		 */
> -		spin_lock(&state_lock);
> -		dp->dl_time =3D 0;
> -		spin_unlock(&state_lock);
> -		nfsd_break_one_deleg(dp);
> -		put_client(clp);
> -	}
> -}
> -
> -u64
> -nfsd_inject_recall_client_delegations(struct sockaddr_storage *addr,
> -				      size_t addr_size)
> -{
> -	u64 count =3D 0;
> -	struct nfs4_client *clp;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -	LIST_HEAD(reaplist);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return count;
> -
> -	spin_lock(&nn->client_lock);
> -	clp =3D nfsd_find_client(addr, addr_size);
> -	if (clp)
> -		count =3D nfsd_find_all_delegations(clp, 0, &reaplist);
> -	spin_unlock(&nn->client_lock);
> -
> -	nfsd_recall_delegations(&reaplist);
> -	return count;
> -}
> -
> -u64
> -nfsd_inject_recall_delegations(u64 max)
> -{
> -	u64 count =3D 0;
> -	struct nfs4_client *clp, *next;
> -	struct nfsd_net *nn =3D net_generic(current->nsproxy->net_ns,
> -						nfsd_net_id);
> -	LIST_HEAD(reaplist);
> -
> -	if (!nfsd_netns_ready(nn))
> -		return count;
> -
> -	spin_lock(&nn->client_lock);
> -	list_for_each_entry_safe(clp, next, &nn->client_lru, cl_lru) {
> -		count +=3D nfsd_find_all_delegations(clp, max - count, =
&reaplist);
> -		if (max !=3D 0 && ++count >=3D max)
> -			break;
> -	}
> -	spin_unlock(&nn->client_lock);
> -	nfsd_recall_delegations(&reaplist);
> -	return count;
> -}
> -#endif /* CONFIG_NFSD_FAULT_INJECTION */
> -
> /*
>  * Since the lifetime of a delegation isn't limited to that of an =
open, a
>  * client may quite reasonably hang on to a delegation as long as it =
has
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7ae236113040..f6d5d783f4a4 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1534,7 +1534,6 @@ static int __init init_nfsd(void)
> 	retval =3D nfsd4_init_pnfs();
> 	if (retval)
> 		goto out_free_slabs;
> -	nfsd_fault_inject_init(); /* nfsd fault injection controls */
> 	nfsd_stat_init();	/* Statistics */
> 	retval =3D nfsd_drc_slab_create();
> 	if (retval)
> @@ -1555,7 +1554,6 @@ static int __init init_nfsd(void)
> 	nfsd_drc_slab_free();
> out_free_stat:
> 	nfsd_stat_shutdown();
> -	nfsd_fault_inject_cleanup();
> 	nfsd4_exit_pnfs();
> out_free_slabs:
> 	nfsd4_free_slabs();
> @@ -1575,7 +1573,6 @@ static void __exit exit_nfsd(void)
> 	nfsd_lockd_shutdown();
> 	nfsd4_free_slabs();
> 	nfsd4_exit_pnfs();
> -	nfsd_fault_inject_cleanup();
> 	unregister_filesystem(&nfsd_fs_type);
> 	unregister_cld_notifier();
> 	unregister_pernet_subsys(&nfsd_net_ops);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 3b408532a5dc..9eae11a9d21c 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -693,31 +693,4 @@ extern void nfsd4_client_record_remove(struct =
nfs4_client *clp);
> extern int nfsd4_client_record_check(struct nfs4_client *clp);
> extern void nfsd4_record_grace_done(struct nfsd_net *nn);
>=20
> -/* nfs fault injection functions */
> -#ifdef CONFIG_NFSD_FAULT_INJECTION
> -void nfsd_fault_inject_init(void);
> -void nfsd_fault_inject_cleanup(void);
> -
> -u64 nfsd_inject_print_clients(void);
> -u64 nfsd_inject_forget_client(struct sockaddr_storage *, size_t);
> -u64 nfsd_inject_forget_clients(u64);
> -
> -u64 nfsd_inject_print_locks(void);
> -u64 nfsd_inject_forget_client_locks(struct sockaddr_storage *, =
size_t);
> -u64 nfsd_inject_forget_locks(u64);
> -
> -u64 nfsd_inject_print_openowners(void);
> -u64 nfsd_inject_forget_client_openowners(struct sockaddr_storage *, =
size_t);
> -u64 nfsd_inject_forget_openowners(u64);
> -
> -u64 nfsd_inject_print_delegations(void);
> -u64 nfsd_inject_forget_client_delegations(struct sockaddr_storage *, =
size_t);
> -u64 nfsd_inject_forget_delegations(u64);
> -u64 nfsd_inject_recall_client_delegations(struct sockaddr_storage *, =
size_t);
> -u64 nfsd_inject_recall_delegations(u64);
> -#else /* CONFIG_NFSD_FAULT_INJECTION */
> -static inline void nfsd_fault_inject_init(void) {}
> -static inline void nfsd_fault_inject_cleanup(void) {}
> -#endif /* CONFIG_NFSD_FAULT_INJECTION */
> -
> #endif   /* NFSD4_STATE_H */
> diff --git a/tools/nfsd/inject_fault.sh b/tools/nfsd/inject_fault.sh
> deleted file mode 100755
> index 10ceee64a09a..000000000000
> --- a/tools/nfsd/inject_fault.sh
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -#!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Copyright (c) 2011 Bryan Schumaker <bjschuma@netapp.com>
> -#
> -# Script for easier NFSD fault injection
> -
> -# Check that debugfs has been mounted
> -DEBUGFS=3D`cat /proc/mounts | grep debugfs`
> -if [ "$DEBUGFS" =3D=3D "" ]; then
> -	echo "debugfs does not appear to be mounted!"
> -	echo "Please mount debugfs and try again"
> -	exit 1
> -fi
> -
> -# Check that the fault injection directory exists
> -DEBUGDIR=3D`echo $DEBUGFS | awk '{print $2}'`/nfsd
> -if [ ! -d "$DEBUGDIR" ]; then
> -	echo "$DEBUGDIR does not exist"
> -	echo "Check that your .config selects =
CONFIG_NFSD_FAULT_INJECTION"
> -	exit 1
> -fi
> -
> -function help()
> -{
> -	echo "Usage $0 injection_type [count]"
> -	echo ""
> -	echo "Injection types are:"
> -	ls $DEBUGDIR
> -	exit 1
> -}
> -
> -if [ $# =3D=3D 0 ]; then
> -	help
> -elif [ ! -f $DEBUGDIR/$1 ]; then
> -	help
> -elif [ $# !=3D 2 ]; then
> -	COUNT=3D0
> -else
> -	COUNT=3D$2
> -fi
> -
> -BEFORE=3D`mktemp`
> -AFTER=3D`mktemp`
> -dmesg > $BEFORE
> -echo $COUNT > $DEBUGDIR/$1
> -dmesg > $AFTER
> -# Capture lines that only exist in the $AFTER file
> -diff $BEFORE $AFTER | grep ">"
> -rm -f $BEFORE $AFTER
> --=20
> 2.26.2
>=20

--
Chuck Lever
chucklever@gmail.com



