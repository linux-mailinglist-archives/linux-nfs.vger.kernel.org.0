Return-Path: <linux-nfs+bounces-11311-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250EBA9F5F8
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 18:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4D55A087B
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A364D279789;
	Mon, 28 Apr 2025 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ccoNQalv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9527A122
	for <linux-nfs@vger.kernel.org>; Mon, 28 Apr 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858243; cv=none; b=WPu7tn/zMz323RbaQoaftwn2OdcJ7hgke+T+8chIDzG7hASx267ZR7jKbMSw7tDvUBWp0BZtrIKCEWb62uHP81qNq4Ow/kccLD3ud6sHsNPAJJKjK3iSeftamkUp3WdZryt7pSqOHW9xo3QKux1ogaV1actVfvQH3kiLTWIPDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858243; c=relaxed/simple;
	bh=0VvQeNVU4UgdbwYBHvilrt2m+ijy4wdKBUUD2tIDmIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRAXapHFmt+qIR4MzsbPjKkIQhkUvjBvDSNAkq17R+nmNBNQ/iM82BLkqrm4LvnxM0K6s/57vvQuVRqn/nss/ZJ1cNL5xZGCvElorSSCWJ5KsQXF5iahxnGibbhVz/a4HDQ3PVhVOj4oIem1cTLUTmkATVG2INw+ox7qdx6gWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ccoNQalv; arc=none smtp.client-ip=66.163.184.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745858241; bh=Bv8soi9tACJn9WGewxRVBUl8fgiOJi3nT89t8VKibUs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ccoNQalvhr50TrnL1wDoFAjJBwOsiLi6QCeQGbSn8OFwqWMbXKN6fkKXJAgBN9f+LxYK9QhKvuKjFQlTZhkZ9SZM17MvbLuoQxJKf96LlFBAS3XxnFB9iH7BWuKV3KzD5pWgtf2dTwBRaVEZS/L3S8Ed98lsE6jp5drCME+F1gZEW+UIZt4H5NtQNmoUQt9FzS0P0QAGyU6X6taB17+bFjEdFRxe6fGkiIEXMD9V8blGs3V8v2EKXOGdBu5YZefVEZB1X2EdndeXKR6RMf0R5l78aDNIwqOAzV4026SBpleGp40mpFiVI20kiyjksdvRgQFgmN3jyVxAEY/hHF093w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745858241; bh=p7+j9cYTZRAQ5oVDZy5J/8FQvBN/UXkpJZqi7y4zNhy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fg8xUsVU+rUa3ISOBsjgnPoZx9KMZc93OzqwM0koL7T12vSMfVGdft+CJK9E5bfes6feq0Wok1ucyKCrbvY2S7F6nS0Nq49/xxm/UuQX/SSW6bm9wxJkUJivkxEYK3EoqwDyxe4Ot6a+huwjU7QaJhXibYCzPxCMNUsi2o3Xrst7jutVOD3x+59qhV0RHn0mEGnXxX5vuDwp7/TrYkKhyWDutQor9usaZkPD+haBOmrbcVjJ68hKn+30hpE0qUTOAgg2FCMk3nKGEjLsKRDZ0oodEkVsXAq4gXbFnoH+shOU1RxpsXflRQPIhLS39zQsRBDa64hiKf64QBnhrQCEQA==
X-YMail-OSG: iMY2u.gVM1l90gKJDkm7xWJB9KcK486jGS.kVjAk2Fb207glp6iGi_9UMrEMMWT
 vMg8Gh3004OqDAC39tU0WargmSDGDeEXcoCss2RstxZR_bqC7fx_kFsw25ie.qMVI_ncxxFUeyxQ
 T09IeQJFBk5SnMb0RpZp.prpvs7kvkIyT7atvPI2WWAzqJlGTt9b71oziCTrXCcJSM2Lhf8DQ7Mi
 P4B1Z.Lv7UzsoI8ukACgq5C0E7qcx17ZjTOTLlBDu2qOmmPNCQqdhXDE6EmcdOUdewaizr0v5FgR
 B3DMeaZS6F3N2Bmnzq4AfiQdtY.3760ojRfgWxqtsHNaaDm5Qcgdwc..9m7FYOpDZU6uOx1NH2O1
 .uCePu50linOGtN2TrQYTn24soqboODqufgsV8bX0E3TFKfRrbaA0ZL.bmPAxOk7fpurCZ6vGsGC
 zAX9xk5fJ1Ou4SoahjqI65noOacynhHnwrnbseX17xCTO1BEzp6TD1Doh0qLyhHACk9DNIdAekzj
 dzwKWn.MVqXcibFaHnR8FO5RwCW95ZXYH6mj77dxWrICPTaNlm7vIOMfsfJi4qeq3KeLpmlghGaB
 4Z5HBFGKK5q2om4gssXIhss97DDSfgbokxUAmwBj2s7yYf6Q6vI85JZsNEWDGNUPZ5gdMRSC04Fd
 .kxGLKIIeckOGtp_8Kja0TDk0c6dnhLlfleLP4JX2.acbTY6YmRnByhX0NymWSOw3n2EVx2GBlDa
 1QGF1WY2yGIi1obHji6Z9kaIRqH665oYz3e9bvQaAAPeV3CGU0Imnw3HdPZx_g3TFP75q3daepbP
 LrHiB2l.0VmJAZG6wXNoUWS8uAhhicPJCIsPbMP7qdpTGZ8_U3SyAp6z3TpMzD42xIDhKa_IG2WA
 v4JWsfRVbSm2RB6flqBl0BKJlj5sxiOcUI0RC_TtEFS3mXrw1AKKROBsK8x1o9jptLmvh6_fJ76l
 4URHUtDayI1SsPy4GZZnoZ5w92KjXnaC6b2OvlxEW3HZetgb0zn4KTpDiNxX8Db.I9llyaq3wMB9
 QlogKDH9IgKm0yNOR8FCvvczZBb1ZA9wiViedi22_UD9V9IRY2gsc.PsNB2kskq6TzdJsdAsSa8i
 XE2Gt7kRavMsL73amiOrbceWP_.vNpcNlDY2Ur33cK.KccCYXgI.aJzGhPDsANfBDY4aBz3n.h4w
 CM3W_ryojATmbn_o3atofJH8GU353CeRtbFv3oKXmfWSDugzML5pYaej.KIT8Qq5Xxlw8XqDZzVz
 p5MzLN.4HCQfClnH_I8tZiZzMilzYz2qEz_IkJmb1BPUBHx3agdCJ6IeQ4jrxEDWTt.aerS13qng
 V32OMbRtC0yMBm0iKi4MODI.lWqk5EAvaUi6OhOQvXxY39FAaGhVi2jSYyQk9nUGvrwwP0vT91Yr
 0k2eh21fBpApm9_HUq0RSNoL7kD7DUysgP4nH4tSTCMiPGYir9MUOiSJxtWSR.UAJUxgY5gcK0uP
 6HWsjNugCiWzrums8IEAUgKgycA0hqFH5zIVmPvzZt9oTUVUAd5r8wiPLRhq5ouE92vD5RWq.SGF
 CO0fD.zzq8yJlAg1E5FE2dcGcgoauRh2H97t9uWamKwHXNYJ.WTd7tIjjR376dWLkHBeh4BKjC.Z
 fxdymB4NyX0EajG93qZ1TiLdI6H4y1ojdGX.xB7iUinZP73H3FZNMSHxCh1Aj3bNNClR.2V9GW4w
 VBkemrq5EhSHhojiiT8_SpJJH5ZCzu7of6lbRjHX6rBseah0aonGdwDt8j4YyrYXcEPT_Ptu5UmU
 hp..3CHP.HRbS7sBG6b_UKvwo7jVUIyhi4Y5wAAa3K7D3T5MQLjqgi8hI9VfMZFpHF0FsjksfpDp
 SIIVrLK9Za0SFvjW9L6v6KdsFxmz3LtVmUbQC8jZG0jcrowP3c4gXKFGjZulo62nSkDOIKxEWYhc
 aHgm4lg9kcTX_hfdsQsv2TtTJC0AenCXP3G0UJt74O5IcDVZykIm2.KtsdW85.KSBtkoZd2bYaPv
 28_pTZYoHI.924vOLysEgI0lXaSIGeSgszQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6a7dbf5d-0d04-426f-a172-733de4aba77a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Apr 2025 16:37:21 +0000
Received: by hermes--production-gq1-74d64bb7d7-w6q4t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ee4682840e2fd9fd638ea25af20b289c;
          Mon, 28 Apr 2025 16:17:05 +0000 (UTC)
Message-ID: <988adabb-4236-4401-9db1-130687b0d84f@schaufler-ca.com>
Date: Mon, 28 Apr 2025 09:17:04 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Stephen Smalley <stephen.smalley.work@gmail.com>, paul@paul-moore.com
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250428155535.6577-2-stephen.smalley.work@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250428155535.6577-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23737 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/28/2025 8:55 AM, Stephen Smalley wrote:
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
>
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@gmail.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This patch is relative to the one linked above, which in theory is on
> vfs.fixes but doesn't appear to have been pushed when I looked.
>
>  fs/nfs/nfs4proc.c             |  9 +++++----
>  fs/xattr.c                    | 20 ++++++++------------
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      |  5 +++--
>  net/socket.c                  |  8 +-------
>  security/security.c           | 16 ++++++++--------
>  security/selinux/hooks.c      | 10 +++-------
>  security/smack/smack_lsm.c    | 13 ++++---------
>  8 files changed, 34 insertions(+), 51 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 970f28dbf253..a1d7cb0acb5e 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -8023,12 +8023,13 @@ static int nfs4_xattr_get_nfs4_label(const struct xattr_handler *handler,
>  static ssize_t
>  nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
>  {
> -	int len = 0;
> +	ssize_t len = 0;
> +	int err;
>  
>  	if (nfs_server_capable(inode, NFS_CAP_SECURITY_LABEL)) {
> -		len = security_inode_listsecurity(inode, list, list_len);
> -		if (len >= 0 && list_len && len > list_len)
> -			return -ERANGE;
> +		err = security_inode_listsecurity(inode, &list, &len);
> +		if (err)
> +			len = err;
>  	}
>  	return len;
>  }
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 2fc314b27120..fdd2f387bfd5 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -492,9 +492,12 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
>  	if (inode->i_op->listxattr) {
>  		error = inode->i_op->listxattr(dentry, list, size);
>  	} else {
> -		error = security_inode_listsecurity(inode, list, size);
> -		if (size && error > size)
> -			error = -ERANGE;
> +		char *buffer = list;
> +		ssize_t len = 0;
> +
> +		error = security_inode_listsecurity(inode, &buffer, &len);
> +		if (!error)
> +			error = len;
>  	}
>  	return error;
>  }
> @@ -1469,17 +1472,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>  	if (err)
>  		return err;
>  
> -	err = security_inode_listsecurity(inode, buffer, remaining_size);
> -	if (err < 0)
> +	err = security_inode_listsecurity(inode, &buffer, &remaining_size);
> +	if (err)
>  		return err;
>  
> -	if (buffer) {
> -		if (remaining_size < err)
> -			return -ERANGE;
> -		buffer += err;
> -	}
> -	remaining_size -= err;
> -
>  	read_lock(&xattrs->lock);
>  	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
>  		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index bf3bbac4e02a..3c3919dcdebc 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -174,8 +174,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
>  	 struct inode *inode, const char *name, void **buffer, bool alloc)
>  LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
>  	 const char *name, const void *value, size_t size, int flags)
> -LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
> -	 size_t buffer_size)
> +LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char **buffer,
> +	 ssize_t *remaining_size)

How about "rem", "rsize" or some other name instead of the overly long
"remaining_size_"? 

>  LSM_HOOK(void, LSM_RET_VOID, inode_getlsmprop, struct inode *inode,
>  	 struct lsm_prop *prop)
>  LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cc9b54d95d22..0efc6a0ab56d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -457,7 +457,7 @@ int security_inode_getsecurity(struct mnt_idmap *idmap,
>  			       struct inode *inode, const char *name,
>  			       void **buffer, bool alloc);
>  int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
> -int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
> +int security_inode_listsecurity(struct inode *inode, char **buffer, ssize_t *remaining_size);
>  void security_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop);
>  int security_inode_copy_up(struct dentry *src, struct cred **new);
>  int security_inode_copy_up_xattr(struct dentry *src, const char *name);
> @@ -1077,7 +1077,8 @@ static inline int security_inode_setsecurity(struct inode *inode, const char *na
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
> +static inline int security_inode_listsecurity(struct inode *inode,
> +					char **buffer, ssize_t *remaining_size)
>  {
>  	return 0;
>  }
> diff --git a/net/socket.c b/net/socket.c
> index 9a0e720f0859..52e3670dc89b 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -562,15 +562,9 @@ static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
>  	ssize_t len;
>  	ssize_t used = 0;
>  
> -	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
> +	len = security_inode_listsecurity(d_inode(dentry), &buffer, &used);
>  	if (len < 0)
>  		return len;
> -	used += len;
> -	if (buffer) {
> -		if (size < used)
> -			return -ERANGE;
> -		buffer += len;
> -	}
>  
>  	len = (XATTR_NAME_SOCKPROTONAME_LEN + 1);
>  	used += len;
> diff --git a/security/security.c b/security/security.c
> index fb57e8fddd91..3985d040d5a9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2710,22 +2710,22 @@ int security_inode_setsecurity(struct inode *inode, const char *name,
>  /**
>   * security_inode_listsecurity() - List the xattr security label names
>   * @inode: inode
> - * @buffer: buffer
> - * @buffer_size: size of buffer
> + * @buffer: pointer to buffer
> + * @remaining_size: pointer to remaining size of buffer
>   *
>   * Copy the extended attribute names for the security labels associated with
> - * @inode into @buffer.  The maximum size of @buffer is specified by
> - * @buffer_size.  @buffer may be NULL to request the size of the buffer
> - * required.
> + * @inode into *(@buffer).  The remaining size of @buffer is specified by
> + * *(@remaining_size).  *(@buffer) may be NULL to request the size of the
> + * buffer required. Updates *(@buffer) and *(@remaining_size).
>   *
> - * Return: Returns number of bytes used/required on success.
> + * Return: Returns 0 on success, or -errno on failure.
>   */
>  int security_inode_listsecurity(struct inode *inode,
> -				char *buffer, size_t buffer_size)
> +				char **buffer, ssize_t *remaining_size)
>  {
>  	if (unlikely(IS_PRIVATE(inode)))
>  		return 0;
> -	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
> +	return call_int_hook(inode_listsecurity, inode, buffer, remaining_size);
>  }
>  EXPORT_SYMBOL(security_inode_listsecurity);
>  
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b8115df536ab..e6c98ebbf7bc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3612,16 +3612,12 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>  	return 0;
>  }
>  
> -static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
> +static int selinux_inode_listsecurity(struct inode *inode, char **buffer,
> +				ssize_t *remaining_size)
>  {
> -	const int len = sizeof(XATTR_NAME_SELINUX);
> -
>  	if (!selinux_initialized())
>  		return 0;
> -
> -	if (buffer && len <= buffer_size)
> -		memcpy(buffer, XATTR_NAME_SELINUX, len);
> -	return len;
> +	return xattr_list_one(buffer, remaining_size, XATTR_NAME_SELINUX);
>  }
>  
>  static void selinux_inode_getlsmprop(struct inode *inode, struct lsm_prop *prop)
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 99833168604e..3f7ac865532e 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1619,17 +1619,12 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
>   * smack_inode_listsecurity - list the Smack attributes
>   * @inode: the object
>   * @buffer: where they go
> - * @buffer_size: size of buffer
> + * @remaining_size: size of buffer
>   */
> -static int smack_inode_listsecurity(struct inode *inode, char *buffer,
> -				    size_t buffer_size)
> +static int smack_inode_listsecurity(struct inode *inode, char **buffer,
> +				    ssize_t *remaining_size)
>  {
> -	int len = sizeof(XATTR_NAME_SMACK);
> -
> -	if (buffer != NULL && len <= buffer_size)
> -		memcpy(buffer, XATTR_NAME_SMACK, len);
> -
> -	return len;
> +	return xattr_list_one(buffer, remaining_size, XATTR_NAME_SMACK);
>  }
>  
>  /**

