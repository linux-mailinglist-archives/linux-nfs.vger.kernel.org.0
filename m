Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB651ABD9A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504705AbgDPKHh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 06:07:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37315 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504502AbgDPKH3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Apr 2020 06:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587031647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OmsPi2QnL58V6dwlzGWYnyAjZz9+qFBEs7u/qfWR06o=;
        b=Twx+E7dp35CtUjoTe0kMdD7qm3/o4mSonADxLXI0YqCFV0k/b2TN7uh+zYPqQ+dmLCoF08
        WXem6GccE2A0k39I4SJ+nOUeovotVNaBLTbLU9QPzidLeMwU7RmLEWTMJib0LSuWblQioF
        dF6t73KcONpY/9PP+WjvGvBJy0ZWO58=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-16ULehxZM2yjZEg0n42kew-1; Thu, 16 Apr 2020 06:07:01 -0400
X-MC-Unique: 16ULehxZM2yjZEg0n42kew-1
Received: by mail-qt1-f197.google.com with SMTP id g23so18143056qto.0
        for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2020 03:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmsPi2QnL58V6dwlzGWYnyAjZz9+qFBEs7u/qfWR06o=;
        b=ma6qMLlKa4+Bpx/erixzJt11/Ck4aVC7qjMRVEecYxiBi0jFP+Ne3B6sL1JtkZkHFE
         /nIj0UZuiZiVk48Fm8B8PG8GJK2NS8lrDNvqiLxj7lNftYb9uNB6K/eeizGrdiMB8mrz
         VT5yuevLEkCKoHEn2RbcyC5SSPzk5X0q/wKXRkOdwg38KlGXZIJQtHoS4DdDJ1e5jlN4
         5NHYqZ3i5RV5GWbBVssLIX+KNwtj1wQ/Vhhx2eoGoCtgq7AvOVRiodbhmFBdAdRaWLAG
         L1eb2q/tDWgKoaA0mrCFbBmQW7fiNrDmOfgxS2Ry92eRXLY7b3Pg0BPHxlQ1hZWMbzeX
         akyw==
X-Gm-Message-State: AGi0PubqILwLoVtnXTQ+HnGUmMY3iNQJhQ1kQvzS8dKzTGgRMft8QYza
        nwNVn7TKjyN3crZJ2SXV9EW/YmsMPwZ9zDg5hhuyqB9saTa9K5wL8KsRExQifWYT6noiIxQ7BBU
        Y6Jf/xsr53pgyjx3FPVKUUbv+VIE6SVR7tQoH
X-Received: by 2002:ac8:6b86:: with SMTP id z6mr25020943qts.293.1587031620547;
        Thu, 16 Apr 2020 03:07:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypKsFJ+prvuKLIADK/GffwhJPlQ6KkCC61k4UEK/sqqXkcM7tDzmctBcg9f1QsRDlcnVgYUsl3fcmlkGBH+9eP0=
X-Received: by 2002:ac8:6b86:: with SMTP id z6mr25020924qts.293.1587031620236;
 Thu, 16 Apr 2020 03:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <1586981683-3077-3-git-send-email-dwysocha@redhat.com> <202004160938.QgDZTXXG%lkp@intel.com>
In-Reply-To: <202004160938.QgDZTXXG%lkp@intel.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 16 Apr 2020 06:06:24 -0400
Message-ID: <CALF+zOn2x2WzumgcjmeqteYtJ+a6bb0zWoHLvpkO7iiPYZYG9g@mail.gmail.com>
Subject: Re: [PATCH 3/3] NFSv4: Fix fscache cookie aux_data to ensure
 change_attr is included
To:     kbuild test robot <lkp@intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>, kbuild-all@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Apologies for somehow missing this, resent v2 of 3/3 with 'void' added
to prototype.

Should be
static void nfs_fscache_update_auxdata(struct
nfs_fscache_inode_auxdata *auxdata,




On Wed, Apr 15, 2020 at 9:49 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Dave,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on nfs/linux-next]
> [also build test WARNING on v5.7-rc1 next-20200415]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Dave-Wysochanski/NFS-Fix-fscache-super_cookie-index_key-from-changing-after-umount/20200416-070856
> base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
> config: c6x-allyesconfig (attached as .config)
> compiler: c6x-elf-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=c6x
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> fs/nfs/fscache.c:228:8: warning: return type defaults to 'int' [-Wreturn-type]
>      228 | static nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
>          |        ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    fs/nfs/fscache.c: In function 'nfs_fscache_update_auxdata':
> >> fs/nfs/fscache.c:239:1: warning: control reaches end of non-void function [-Wreturn-type]
>      239 | }
>          | ^
>
> vim +/int +228 fs/nfs/fscache.c
>
>    227
>  > 228  static nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
>    229                                    struct nfs_inode *nfsi)
>    230  {
>    231          memset(auxdata, 0, sizeof(*auxdata));
>    232          auxdata->mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
>    233          auxdata->mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
>    234          auxdata->ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
>    235          auxdata->ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
>    236
>    237          if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
>    238                  auxdata->change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
>  > 239  }
>    240
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

