Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960F7311E2
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEaQCZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 May 2019 12:02:25 -0400
Received: from fieldses.org ([173.255.197.46]:42200 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEaQCZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 31 May 2019 12:02:25 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id D406B1CEA; Fri, 31 May 2019 12:02:24 -0400 (EDT)
Date:   Fri, 31 May 2019 12:02:24 -0400
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     SteveD@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 08/11] Add support for the "[exports] rootdir"
 nfs.conf option to rpc.mountd
Message-ID: <20190531160224.GD1251@fieldses.org>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
 <20190528203122.11401-6-trond.myklebust@hammerspace.com>
 <20190528203122.11401-7-trond.myklebust@hammerspace.com>
 <20190528203122.11401-8-trond.myklebust@hammerspace.com>
 <20190528203122.11401-9-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528203122.11401-9-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 28, 2019 at 04:31:19PM -0400, Trond Myklebust wrote:
> @@ -373,21 +390,22 @@ static char *next_mnt(void **v, char *p)
>  	FILE *f;
>  	struct mntent *me;
>  	size_t l = strlen(p);
> +	char *mnt_dir = NULL;
> +
>  	if (*v == NULL) {
>  		f = setmntent("/etc/mtab", "r");
>  		*v = f;
>  	} else
>  		f = *v;
> -	while ((me = getmntent(f)) != NULL && l > 1 &&
> -	       (strncmp(me->mnt_dir, p, l) != 0 ||
> -		me->mnt_dir[l] != '/'))
> -		;
> -	if (me == NULL) {
> -		endmntent(f);
> -		*v = NULL;
> -		return NULL;
> +	while ((me = getmntent(f)) != NULL && l > 1) {
> +		mnt_dir = nfsd_path_strip_root(me->mnt_dir);
> +
> +		if (strncmp(mnt_dir, p, l) == 0 && mnt_dir[l] != '/')
> +			return mnt_dir;

That should be "mnt_dir[l] == '/'", right?

--b.

>  	}
> -	return me->mnt_dir;
> +	endmntent(f);
> +	*v = NULL;
> +	return NULL;
>  }
>  
>  /* same_path() check is two paths refer to the same directory.
