Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB7D3119B
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEaPwS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 May 2019 11:52:18 -0400
Received: from fieldses.org ([173.255.197.46]:42186 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfEaPwS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 31 May 2019 11:52:18 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 85E671CEA; Fri, 31 May 2019 11:52:17 -0400 (EDT)
Date:   Fri, 31 May 2019 11:52:17 -0400
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     SteveD@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 04/11] Add utilities for resolving nfsd paths and
 stat()ing them
Message-ID: <20190531155217.GC1251@fieldses.org>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528203122.11401-5-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 28, 2019 at 04:31:15PM -0400, Trond Myklebust wrote:
> +char *
> +nfsd_path_strip_root(char *pathname)
> +{
> +	const char *dir = nfsd_path_nfsd_rootdir();
> +	char *ret;
> +
> +	ret = strstr(pathname, dir);
> +	if (!ret || ret != pathname)
> +		return pathname;

Shouldn't we return NULL or an error or something here?  It seems a
little strange not to care if the path began with root or not.  I guess
I need to look at the caller....

--b.

> +	return pathname + strlen(dir);
> +}
> +
> +char *
> +nfsd_path_prepend_dir(const char *dir, const char *pathname)
> +{
> +	size_t len, dirlen;
> +	char *ret;
> +
> +	dirlen = strlen(dir);
> +	while (dirlen > 0 && dir[dirlen - 1] == '/')
> +		dirlen--;
> +	if (!dirlen)
> +		return NULL;
> +	len = dirlen + strlen(pathname) + 1;
> +	ret = xmalloc(len + 1);
> +	snprintf(ret, len, "%.*s/%s", (int)dirlen, dir, pathname);
> +	return ret;
> +}
> +
> +static void
> +nfsd_setup_workqueue(void)
> +{
> +	const char *rootdir = nfsd_path_nfsd_rootdir();
> +
> +	if (!rootdir)
> +		return;
> +	nfsd_wq = xthread_workqueue_alloc();
> +	if (!nfsd_wq)
> +		return;
> +	xthread_workqueue_chroot(nfsd_wq, rootdir);
> +}
> +
> +void
> +nfsd_path_init(void)
> +{
> +	nfsd_setup_workqueue();
> +}
> +
> +struct nfsd_stat_data {
> +	const char *pathname;
> +	struct stat *statbuf;
> +	int ret;
> +	int err;
> +};
> +
> +static void
> +nfsd_statfunc(void *data)
> +{
> +	struct nfsd_stat_data *d = data;
> +
> +	d->ret = xstat(d->pathname, d->statbuf);
> +	if (d->ret < 0)
> +		d->err = errno;
> +}
> +
> +static void
> +nfsd_lstatfunc(void *data)
> +{
> +	struct nfsd_stat_data *d = data;
> +
> +	d->ret = xlstat(d->pathname, d->statbuf);
> +	if (d->ret < 0)
> +		d->err = errno;
> +}
> +
> +static int
> +nfsd_run_stat(struct xthread_workqueue *wq,
> +		void (*func)(void *),
> +		const char *pathname,
> +		struct stat *statbuf)
> +{
> +	struct nfsd_stat_data data = {
> +		pathname,
> +		statbuf,
> +		0,
> +		0
> +	};
> +	xthread_work_run_sync(wq, func, &data);
> +	if (data.ret < 0)
> +		errno = data.err;
> +	return data.ret;
> +}
> +
> +int
> +nfsd_path_stat(const char *pathname, struct stat *statbuf)
> +{
> +	if (!nfsd_wq)
> +		return xstat(pathname, statbuf);
> +	return nfsd_run_stat(nfsd_wq, nfsd_statfunc, pathname, statbuf);
> +}
> +
> +int
> +nfsd_path_lstat(const char *pathname, struct stat *statbuf)
> +{
> +	if (!nfsd_wq)
> +		return xlstat(pathname, statbuf);
> +	return nfsd_run_stat(nfsd_wq, nfsd_lstatfunc, pathname, statbuf);
> +}
> diff --git a/support/misc/xstat.c b/support/misc/xstat.c
> new file mode 100644
> index 000000000000..d092f73dfd65
> --- /dev/null
> +++ b/support/misc/xstat.c
> @@ -0,0 +1,33 @@
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#include "config.h"
> +#include "xstat.h"
> +
> +#ifdef HAVE_FSTATAT
> +
> +int xlstat(const char *pathname, struct stat *statbuf)
> +{
> +	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT |
> +			AT_SYMLINK_NOFOLLOW);
> +}
> +
> +int xstat(const char *pathname, struct stat *statbuf)
> +{
> +	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT);
> +}
> +
> +#else
> +
> +int xlstat(const char *pathname, struct stat *statbuf)
> +{
> +	return lstat(pathname, statbuf);
> +}
> +
> +int xstat(const char *pathname, struct stat *statbuf)
> +{
> +	return stat(pathname, statbuf);
> +}
> +#endif
> -- 
> 2.21.0
