Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E1331FD
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 16:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfFCOVS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 10:21:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20475 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbfFCOVR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jun 2019 10:21:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 341B72F8BDD;
        Mon,  3 Jun 2019 14:21:12 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-46.phx2.redhat.com [10.3.116.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7FFF1B465;
        Mon,  3 Jun 2019 14:21:10 +0000 (UTC)
Subject: Re: [PATCH v3 04/11] Add utilities for resolving nfsd paths and
 stat()ing them
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@gmail.com>
Cc:     linux-nfs@vger.kernel.org
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
 <20190531155217.GC1251@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <c038bbe5-aef6-a740-4591-3814d02c4126@RedHat.com>
Date:   Mon, 3 Jun 2019 10:21:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531155217.GC1251@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 03 Jun 2019 14:21:17 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/31/19 11:52 AM, J. Bruce Fields wrote:
> On Tue, May 28, 2019 at 04:31:15PM -0400, Trond Myklebust wrote:
>> +char *
>> +nfsd_path_strip_root(char *pathname)
>> +{
>> +	const char *dir = nfsd_path_nfsd_rootdir();
>> +	char *ret;
>> +
>> +	ret = strstr(pathname, dir);
>> +	if (!ret || ret != pathname)
>> +		return pathname;
> 
> Shouldn't we return NULL or an error or something here?  It seems a
> little strange not to care if the path began with root or not.  I guess
> I need to look at the caller....
Well pathname will never be NULL... It is returning what is passed in, 
but it might be nice to know about the memory failure.

steved.

> 
> --b.
> 
>> +	return pathname + strlen(dir);
>> +}
>> +
>> +char *
>> +nfsd_path_prepend_dir(const char *dir, const char *pathname)
>> +{
>> +	size_t len, dirlen;
>> +	char *ret;
>> +
>> +	dirlen = strlen(dir);
>> +	while (dirlen > 0 && dir[dirlen - 1] == '/')
>> +		dirlen--;
>> +	if (!dirlen)
>> +		return NULL;
>> +	len = dirlen + strlen(pathname) + 1;
>> +	ret = xmalloc(len + 1);
>> +	snprintf(ret, len, "%.*s/%s", (int)dirlen, dir, pathname);
>> +	return ret;
>> +}
>> +
>> +static void
>> +nfsd_setup_workqueue(void)
>> +{
>> +	const char *rootdir = nfsd_path_nfsd_rootdir();
>> +
>> +	if (!rootdir)
>> +		return;
>> +	nfsd_wq = xthread_workqueue_alloc();
>> +	if (!nfsd_wq)
>> +		return;
>> +	xthread_workqueue_chroot(nfsd_wq, rootdir);
>> +}
>> +
>> +void
>> +nfsd_path_init(void)
>> +{
>> +	nfsd_setup_workqueue();
>> +}
>> +
>> +struct nfsd_stat_data {
>> +	const char *pathname;
>> +	struct stat *statbuf;
>> +	int ret;
>> +	int err;
>> +};
>> +
>> +static void
>> +nfsd_statfunc(void *data)
>> +{
>> +	struct nfsd_stat_data *d = data;
>> +
>> +	d->ret = xstat(d->pathname, d->statbuf);
>> +	if (d->ret < 0)
>> +		d->err = errno;
>> +}
>> +
>> +static void
>> +nfsd_lstatfunc(void *data)
>> +{
>> +	struct nfsd_stat_data *d = data;
>> +
>> +	d->ret = xlstat(d->pathname, d->statbuf);
>> +	if (d->ret < 0)
>> +		d->err = errno;
>> +}
>> +
>> +static int
>> +nfsd_run_stat(struct xthread_workqueue *wq,
>> +		void (*func)(void *),
>> +		const char *pathname,
>> +		struct stat *statbuf)
>> +{
>> +	struct nfsd_stat_data data = {
>> +		pathname,
>> +		statbuf,
>> +		0,
>> +		0
>> +	};
>> +	xthread_work_run_sync(wq, func, &data);
>> +	if (data.ret < 0)
>> +		errno = data.err;
>> +	return data.ret;
>> +}
>> +
>> +int
>> +nfsd_path_stat(const char *pathname, struct stat *statbuf)
>> +{
>> +	if (!nfsd_wq)
>> +		return xstat(pathname, statbuf);
>> +	return nfsd_run_stat(nfsd_wq, nfsd_statfunc, pathname, statbuf);
>> +}
>> +
>> +int
>> +nfsd_path_lstat(const char *pathname, struct stat *statbuf)
>> +{
>> +	if (!nfsd_wq)
>> +		return xlstat(pathname, statbuf);
>> +	return nfsd_run_stat(nfsd_wq, nfsd_lstatfunc, pathname, statbuf);
>> +}
>> diff --git a/support/misc/xstat.c b/support/misc/xstat.c
>> new file mode 100644
>> index 000000000000..d092f73dfd65
>> --- /dev/null
>> +++ b/support/misc/xstat.c
>> @@ -0,0 +1,33 @@
>> +#include <sys/types.h>
>> +#include <fcntl.h>
>> +#include <sys/stat.h>
>> +#include <unistd.h>
>> +
>> +#include "config.h"
>> +#include "xstat.h"
>> +
>> +#ifdef HAVE_FSTATAT
>> +
>> +int xlstat(const char *pathname, struct stat *statbuf)
>> +{
>> +	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT |
>> +			AT_SYMLINK_NOFOLLOW);
>> +}
>> +
>> +int xstat(const char *pathname, struct stat *statbuf)
>> +{
>> +	return fstatat(AT_FDCWD, pathname, statbuf, AT_NO_AUTOMOUNT);
>> +}
>> +
>> +#else
>> +
>> +int xlstat(const char *pathname, struct stat *statbuf)
>> +{
>> +	return lstat(pathname, statbuf);
>> +}
>> +
>> +int xstat(const char *pathname, struct stat *statbuf)
>> +{
>> +	return stat(pathname, statbuf);
>> +}
>> +#endif
>> -- 
>> 2.21.0
