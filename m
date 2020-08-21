Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CAF24CE46
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Aug 2020 08:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgHUGvO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Aug 2020 02:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHUGvM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Aug 2020 02:51:12 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB65C061385
        for <linux-nfs@vger.kernel.org>; Thu, 20 Aug 2020 23:51:12 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id cq28so576048edb.10
        for <linux-nfs@vger.kernel.org>; Thu, 20 Aug 2020 23:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rB3tdo1AFNiA7Wu4nTadC4BMNP6zcZHRxaqHlPhCmCs=;
        b=d839esNndQRjfZXdWbAYJ7wwJ4XfSjv60gS5Zgfmu4VC1A52aGL1WjTDrlqcSuhODZ
         QAhw0dBdrW0PnnDmPE9tXjI3JWxSn1iG3r6odr6uAbvKYChdDET+6v8CX9sPBx+K+oxl
         DzVnFgz3LUu6V96gCRt7wbxCH7pZsVCFRpjJaEmG4idqaf7MMlEqMRxYjH3Mk95V3eF5
         cawwsubGQxYZS2rKps5APy/PgZdrru53AO8qjz3s0qA5W/nm33dRvsSaYIN5K3eaIZaz
         5Txw27o4JWERq12b+eDT6q8Y1D2tYZqMgiazm0luiaXbjij+DMDQ1xJXVUkfWhrQXKH/
         I4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rB3tdo1AFNiA7Wu4nTadC4BMNP6zcZHRxaqHlPhCmCs=;
        b=mK1Cqyd1lE3bQOUwfCKoVnqWFMl6eG6yHr5so602RqjgpIZCJ362WHYiZFEdpGH3Qq
         zB8XjknY7/SDOSJSzr/WUSNj7MwfQLmsdwmEUSomNFxVO/pFEr2oTqT98L0qijrPDXXR
         RNkDREXDqL8IGDwHxKpXl9SOaI7WTYmrsV0FmIZPsMflUBEJxNEVEKVStoEasysOJ7xM
         /4TKRmXd1IjzXc9w20L+Hb421U+Ibcu4pOdreMDmpVMgO2td/d7FUsjU9KKJSgbRMhHC
         q4KbX9Bn1uHadmXP1gwR+82e9cUjlMYMcm+685rsoYauDDiW6cWOgs0oCDdpQWjOlaTn
         izeA==
X-Gm-Message-State: AOAM5320vX3xiYS8IvxStcTTpqxzs2LpYYJ62G7sKrR5yOlcqbijA5Cb
        f9SUTv7FOc0Tuh0lf12STBdoQGlS575vvgq5wws=
X-Google-Smtp-Source: ABdhPJwZk63D3NJS6A75nTN6wVncEorSK3UNDz9EK82I9wnOy02vtoKraYDM+OMCzOxHfxMoRUFpDoIndFD5pRBm/uY=
X-Received: by 2002:aa7:c251:: with SMTP id y17mr1465346edo.13.1597992670881;
 Thu, 20 Aug 2020 23:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200623223904.31643-1-fllinden@amazon.com> <20200623223904.31643-13-fllinden@amazon.com>
In-Reply-To: <20200623223904.31643-13-fllinden@amazon.com>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Fri, 21 Aug 2020 14:50:59 +0800
Message-ID: <CADJHv_tVZ3KzO_RZ18V=e6QBYEFnX5SbyVU6yhh6yCqYMmvmRQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] NFSv4.2: hook in the user extended attribute handlers
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Wed, Jun 24, 2020 at 6:51 AM Frank van der Linden
<fllinden@amazon.com> wrote:
>
> Now that all the lower level code is there to make the RPC calls, hook
> it in to the xattr handlers and the listxattr entry point, to make them
> available.
>
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>
> ---
>  fs/nfs/nfs4proc.c | 123 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 121 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 0fbd2925a828..92a07956f07b 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -66,6 +66,7 @@
>  #include "nfs4idmap.h"
>  #include "nfs4session.h"
>  #include "fscache.h"
> +#include "nfs42.h"
>
>  #include "nfs4trace.h"
>
> @@ -7440,6 +7441,103 @@ nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
>
>  #endif
>
> +#ifdef CONFIG_NFS_V4_2
> +static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
> +                                   struct dentry *unused, struct inode *inode,
> +                                   const char *key, const void *buf,
> +                                   size_t buflen, int flags)
> +{
> +       struct nfs_access_entry cache;
> +
> +       if (!nfs_server_capable(inode, NFS_CAP_XATTR))
> +               return -EOPNOTSUPP;
> +
> +       /*
> +        * There is no mapping from the MAY_* flags to the NFS_ACCESS_XA*
> +        * flags right now. Handling of xattr operations use the normal
> +        * file read/write permissions.
> +        *
> +        * Just in case the server has other ideas (which RFC 8276 allows),
> +        * do a cached access check for the XA* flags to possibly avoid
> +        * doing an RPC and getting EACCES back.
> +        */
> +       if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
> +               if (!(cache.mask & NFS_ACCESS_XAWRITE))
> +                       return -EACCES;
> +       }
> +
> +       if (buf == NULL)
> +               return nfs42_proc_removexattr(inode, key);
> +       else
> +               return nfs42_proc_setxattr(inode, key, buf, buflen, flags);
> +}
> +
> +static int nfs4_xattr_get_nfs4_user(const struct xattr_handler *handler,
> +                                   struct dentry *unused, struct inode *inode,
> +                                   const char *key, void *buf, size_t buflen)
> +{
> +       struct nfs_access_entry cache;
> +
> +       if (!nfs_server_capable(inode, NFS_CAP_XATTR))
> +               return -EOPNOTSUPP;
> +
> +       if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
> +               if (!(cache.mask & NFS_ACCESS_XAREAD))
> +                       return -EACCES;
> +       }
> +
> +       return nfs42_proc_getxattr(inode, key, buf, buflen);
> +}
> +
> +static ssize_t
> +nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
> +{
> +       u64 cookie;
> +       bool eof;
> +       int ret, size;
> +       char *buf;
> +       size_t buflen;
> +       struct nfs_access_entry cache;
> +
> +       if (!nfs_server_capable(inode, NFS_CAP_XATTR))
> +               return 0;
> +
> +       if (!nfs_access_get_cached(inode, current_cred(), &cache, true)) {
> +               if (!(cache.mask & NFS_ACCESS_XALIST))
> +                       return 0;
> +       }
> +
> +       cookie = 0;
> +       eof = false;
> +       buflen = list_len ? list_len : XATTR_LIST_MAX;
> +       buf = list_len ? list : NULL;
> +       size = 0;
> +
> +       while (!eof) {
> +               ret = nfs42_proc_listxattrs(inode, buf, buflen,
> +                   &cookie, &eof);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (list_len) {
> +                       buf += ret;
> +                       buflen -= ret;
> +               }
> +               size += ret;
> +       }
> +
> +       return size;
> +}
> +
> +#else
> +
> +static ssize_t
> +nfs4_listxattr_nfs4_user(struct inode *inode, char *list, size_t list_len)
> +{
> +       return 0;
> +}
> +#endif /* CONFIG_NFS_V4_2 */
> +
>  /*
>   * nfs_fhget will use either the mounted_on_fileid or the fileid
>   */
> @@ -10045,7 +10143,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
>
>  static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
>  {
> -       ssize_t error, error2;
> +       ssize_t error, error2, error3;
>
>         error = generic_listxattr(dentry, list, size);
>         if (error < 0)
> @@ -10058,7 +10156,17 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
>         error2 = nfs4_listxattr_nfs4_label(d_inode(dentry), list, size);
>         if (error2 < 0)
>                 return error2;
> -       return error + error2;
> +
> +       if (list) {
> +               list += error2;
> +               size -= error2;
> +       }
> +
> +       error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, size);
> +       if (error3 < 0)
> +               return error3;
> +
> +       return error + error2 + error3;
>  }
>
>  static const struct inode_operations nfs4_dir_inode_operations = {
> @@ -10146,10 +10254,21 @@ static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
>         .set    = nfs4_xattr_set_nfs4_acl,
>  };
>
> +#ifdef CONFIG_NFS_V4_2
> +static const struct xattr_handler nfs4_xattr_nfs4_user_handler = {
> +       .prefix = XATTR_USER_PREFIX,
> +       .get    = nfs4_xattr_get_nfs4_user,
> +       .set    = nfs4_xattr_set_nfs4_user,
> +};
> +#endif
> +

Any plan to support XATTR_TRUSTED_PREFIX ?

Thanks.

>  const struct xattr_handler *nfs4_xattr_handlers[] = {
>         &nfs4_xattr_nfs4_acl_handler,
>  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
>         &nfs4_xattr_nfs4_label_handler,
> +#endif
> +#ifdef CONFIG_NFS_V4_2
> +       &nfs4_xattr_nfs4_user_handler,
>  #endif
>         NULL
>  };
> --
> 2.17.2
>
