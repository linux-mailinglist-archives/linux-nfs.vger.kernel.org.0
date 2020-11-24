Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7639C2C3287
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 22:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbgKXVUa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 16:20:30 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:32250 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbgKXVU3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 16:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606252824; x=1637788824;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject;
  bh=iww5HI+6Mi7YQdPiGU4PwXQMQOjauNrDeB4ebidcvzA=;
  b=DJ5IuJm6tirhzvCBX5CBhZ/cd+NM3UQ/yP1UBdY5opG+NfkH+IWoaI+7
   0dYIDF61E9fMLurMAaZHYcoDHvNMV0RQvCv98AtFBDNENqHzH/DyAW/Wm
   +7jz4gfwWljS6njbtMF02SNp4vktxJXBLQG4GKyH9RUI9AJsMuF3TVS/e
   o=;
X-Amazon-filename: xattr.c
X-IronPort-AV: E=Sophos;i="5.78,367,1599523200"; 
   d="c'?scan'208";a="97553779"
Subject: Re: [PATCH v1] NFS: Fix rpcrdma_inline_fixup() crash with new LISTXATTRS
 operation
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 24 Nov 2020 21:19:27 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id 155A8A27BD;
        Tue, 24 Nov 2020 21:19:27 +0000 (UTC)
Received: from EX13D40UWA001.ant.amazon.com (10.43.160.53) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Nov 2020 21:19:26 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D40UWA001.ant.amazon.com (10.43.160.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Nov 2020 21:19:26 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 24 Nov 2020 21:19:26 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 5E0D4C133E; Tue, 24 Nov 2020 21:19:26 +0000 (UTC)
Date:   Tue, 24 Nov 2020 21:19:26 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
CC:     Chuck Lever <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Message-ID: <20201124211926.GB14140@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <160623862874.1534.4471924380357882531.stgit@manet.1015granger.net>
 <20201124200640.GA2476@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <B1CF6271-B168-4571-B8E4-0CAB0A0B40FB@netapp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B1CF6271-B168-4571-B8E4-0CAB0A0B40FB@netapp.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Nov 24, 2020 at 08:50:36PM +0000, Kornievskaia, Olga wrote:
> 
> 
> ﻿On 11/24/20, 3:06 PM, "Frank van der Linden" <fllinden@amazon.com> wrote:
> 
>     On Tue, Nov 24, 2020 at 12:26:32PM -0500, Chuck Lever wrote:
>     > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>     >
>     >
>     >
>     > By switching to an XFS-backed export, I am able to reproduce the
>     > ibcomp worker crash on my client with xfstests generic/013.
>     >
>     > For the failing LISTXATTRS operation, xdr_inline_pages() is called
>     > with page_len=12 and buflen=128. Then:
>     >
>     > - Because buflen is small, rpcrdma_marshal_req will not set up a
>     >   Reply chunk and the rpcrdma's XDRBUF_SPARSE_PAGES logic does not
>     >   get invoked at all.
>     >
>     > - Because page_len is non-zero, rpcrdma_inline_fixup() tries to
>     >   copy received data into rq_rcv_buf->pages, but they're missing.
>     >
>     > The result is that the ibcomp worker faults and dies. Sometimes that
>     > causes a visible crash, and sometimes it results in a transport
>     > hang without other symptoms.
>     >
>     > RPC/RDMA's XDRBUF_SPARSE_PAGES support is not entirely correct, and
>     > should eventually be fixed or replaced. However, my preference is
>     > that upper-layer operations should explicitly allocate their receive
>     > buffers (using GFP_KERNEL) when possible, rather than relying on
>     > XDRBUF_SPARSE_PAGES.
>     >
>     > Reported-by: Olga kornievskaia <kolga@netapp.com>
>     > Suggested-by: Olga kornievskaia <kolga@netapp.com>
>     > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>     > ---
>     >  fs/nfs/nfs42proc.c |   17 ++++++++++-------
>     >  fs/nfs/nfs42xdr.c  |    1 -
>     >  2 files changed, 10 insertions(+), 8 deletions(-)
>     >
>     > Hi-
>     >
>     > I like Olga's proposed approach. What do you think of this patch?
>     >
>     >
>     > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>     > index 2b2211d1234e..24810305ec1c 100644
>     > --- a/fs/nfs/nfs42proc.c
>     > +++ b/fs/nfs/nfs42proc.c
>     > @@ -1241,7 +1241,7 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>     >                 .rpc_resp       = &res,
>     >         };
>     >         u32 xdrlen;
>     > -       int ret, np;
>     > +       int ret, np, i;
>     >
>     >
>     >         res.scratch = alloc_page(GFP_KERNEL);
>     > @@ -1253,10 +1253,14 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>     >                 xdrlen = server->lxasize;
>     >         np = xdrlen / PAGE_SIZE + 1;
>     >
>     > +       ret = -ENOMEM;
>     >         pages = kcalloc(np, sizeof(struct page *), GFP_KERNEL);
>     > -       if (pages == NULL) {
>     > -               __free_page(res.scratch);
>     > -               return -ENOMEM;
>     > +       if (pages == NULL)
>     > +               goto out_free;
>     > +       for (i = 0; i < np; i++) {
>     > +               pages[i] = alloc_page(GFP_KERNEL);
>     > +               if (!pages[i])
>     > +                       goto out_free;
>     >         }
>     >
>     >         arg.xattr_pages = pages;
>     > @@ -1271,14 +1275,13 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
>     >                 *eofp = res.eof;
>     >         }
>     >
>     > +out_free:
>     >         while (--np >= 0) {
>     >                 if (pages[np])
>     >                         __free_page(pages[np]);
>     >         }
>     > -
>     > -       __free_page(res.scratch);
>     >         kfree(pages);
>     > -
>     > +       __free_page(res.scratch);
>     >         return ret;
>     >
>     >  }
>     > diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
>     > index 6e060a88f98c..8432bd6b95f0 100644
>     > --- a/fs/nfs/nfs42xdr.c
>     > +++ b/fs/nfs/nfs42xdr.c
>     > @@ -1528,7 +1528,6 @@ static void nfs4_xdr_enc_listxattrs(struct rpc_rqst *req,
>     >
>     >         rpc_prepare_reply_pages(req, args->xattr_pages, 0, args->count,
>     >             hdr.replen);
>     > -       req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
>     >
>     >         encode_nops(&hdr);
>     >  }
>     >
>     >
> 
>     I can see why this is the simplest and most pragmatic solution, so it's
>     fine with me.
> 
>     Why doesn't this happen with getxattr? Do we need to convert that too?
> 
> [olga] I don't know if GETXATTR/SETXATTR works. I'm not sure what tests exercise those operations. I just ran into the fact that generic/013 wasn't passing. And I don't see that it's an xattr specific tests. I'm not sure how it ends up triggering is usage of xattr.

I'm attaching the test program I used, it should give things a better workout.

- Frank

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="xattr.c"

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#ifdef __FreeBSD__
#include <sys/extattr.h>
#else
#include <sys/xattr.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#ifndef __FreeBSD__
#include <malloc.h>
#endif
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#include <stdarg.h>
#include <limits.h>

#ifdef __FreeBSD__
#define XATTR_SIZE_MAX 32768
#endif

#ifndef XATTR_SIZE_MAX
#define XATTR_SIZE_MAX 65536
#endif

#ifndef XATTR_LIST_MAX
#define XATTR_LIST_MAX 65536
#endif

#ifdef __FreeBSD__
#define XATTR_REPLACE 0
#define XATTR_CREATE 0
#define ENODATA ENOATTR
#endif

#define XATTR_TEST_ATTRLEN	(5 + 4 + 1)	/* "user.NNNN\0" */
#ifdef __FreeBSD__
#define XATTR_TEST_NATTR_MAX	4096
#else
#define XATTR_TEST_NATTR_MAX	(XATTR_LIST_MAX / XATTR_TEST_ATTRLEN)
#endif

#ifdef __FreeBSD__
#define ERR_TOOBIG	ENOSPC
#else
#define ERR_TOOBIG	E2BIG
#endif

#if 0
char tmpbuf[XATTR_LIST_MAX];
#endif

static const char *xt_dir;

typedef struct xattr_test_handle {
	const char *xt_test;
	char xt_filename[256];
	char xt_attrkey[2 * 256];	/* Long to test limit */
	char *xt_attrbuf;
	ssize_t xt_attrlen;
	char xt_fillc;
	ssize_t xt_failoff;
	int xt_fd;
	char *xt_listbuf;
	ssize_t xt_listlen;
} xt_hdl;

#define xt_value_len(xth)	((xth)->xt_attrlen)
#define xt_value_failoff(xth)	((xth)->xt_failoff)
#define xt_fillc(xth)		((xth)->xt_fillc)
#define xt_filename(xth)	((xth)->xt_filename)

#define PAGE_SIZE	sysconf(_SC_PAGE_SIZE)

static void
usage(void)
{
	fprintf(stderr, "usage: xattr <dir>\n");
	exit(1);
}

static void
fail(xt_hdl *xth, const char *fmt, ...)
{
	va_list ap;

	printf("%-24s FAIL: ", xth->xt_test);

	va_start(ap, fmt);
	vprintf(fmt, ap);
	va_end(ap);

	printf("\n");
}

static void
pass(xt_hdl *xth, const char *fmt, ...)
{
	va_list ap;

	printf("%-24s PASS: ", xth->xt_test);

	va_start(ap, fmt);
	vprintf(fmt, ap);
	va_end(ap);

	printf("\n");
}

static int
xt_set_fs(const char *dir)
{
	int ret;
	struct stat st;

	ret = stat(dir, &st);
	if (ret < 0)
		return ret;

	if (!S_ISDIR(st.st_mode))
		return -ENOTDIR;

	xt_dir = dir;

	return 0;
}


static xt_hdl *
xt_init(const char *test)
{
	xt_hdl *xth;


	if (xt_dir == NULL) {
		errno = EINVAL;
		return NULL;
	}

	xth = calloc(1, sizeof (xt_hdl));
	if (xth == NULL)
		return NULL;

	xth->xt_test = test;
	snprintf(xth->xt_filename, sizeof xth->xt_filename, "%s/%sXXXXXX",
	    xt_dir, test);

	/*
	 * Default value, can be changed.
	 */
	snprintf(xth->xt_attrkey, sizeof xth->xt_attrkey, "user.%s",
	    test);

	return xth;
}

static int
xt_file_create(xt_hdl *xth)
{
	int fd;
	int ret;

#ifdef __FreeBSD__
	fd = mkstemp(xth->xt_filename);
#else
	fd = mkostemp(xth->xt_filename, O_RDWR|O_TRUNC);
#endif
	if (fd < 0)
		return -errno;
	
	close(fd);

	return 0;
}

static void
xt_file_remove(xt_hdl *xth)
{
	unlink(xth->xt_filename);
}

static int
xt_file_open(xt_hdl *xth, int flags)
{
	int fd;

	fd = open(xth->xt_filename, flags);
	if (fd < 0)
		return errno;
	xth->xt_fd = fd;

	return fd;
}

static int
xt_file_close(xt_hdl *xth)
{
	if (xth->xt_fd != -1) {
		close(xth->xt_fd);
		xth->xt_fd = -1;
	}

	return 0;
}

static void
xt_value_fill(xt_hdl *xth)
{
	char c;
	char *p;
	ssize_t i;

	if (xth->xt_attrlen == 0)
		return;

	p = xth->xt_attrbuf;

	c = random() & 0xff;
	if (c == 0)
		c++;

	for (i = 0; i < xth->xt_attrlen; i++)
		p[i] = c;

	xth->xt_fillc = c;

}

static void
xt_value_free(xt_hdl *xth)
{
	if (xth->xt_attrbuf != NULL) {
		free(xth->xt_attrbuf);
		xth->xt_attrbuf = NULL;
		xth->xt_attrlen = 0;
	}
}

static int
xt_value_alloc(xt_hdl *xth, ssize_t len)
{
	char *p;

	xt_value_free(xth);

	if (len == 0)
		return 0;

	p = malloc(len);
	if (p == NULL)
		return ENOMEM;

	xth->xt_attrbuf = p;
	xth->xt_attrlen = len;
	xth->xt_failoff = 0;
	xth->xt_fd = -1;

	xt_value_fill(xth);

	return 0;
}

static int
__xt_value_check(xt_hdl *xth, ssize_t len, char c)
{
	ssize_t i;

	for (i = 0; i < len; i++) {
		if (xth->xt_attrbuf[i] != c) {
			xth->xt_failoff = i;
			return -EINVAL;
		}
	}

	return 0;
}

static int
xt_value_check(xt_hdl *xth, ssize_t len)
{
	return __xt_value_check(xth, len, xth->xt_fillc);
}

static int
xt_list_alloc(xt_hdl *xth, ssize_t size)
{
	char *p;

	p = calloc(1, size);
	if (p == NULL)
		return -ENOMEM;

	xth->xt_listbuf = p;
	xth->xt_listlen = size;

	return 0;
}

static void
xt_value_clear(xt_hdl *xth)
{
	memset(xth->xt_attrbuf, 0, xth->xt_attrlen);
}

static void
xt_list_free(xt_hdl *xth)
{
	if (xth->xt_attrbuf != NULL) {
		free(xth->xt_listbuf);
		xth->xt_listbuf = NULL;
		xth->xt_listlen = 0;
	}
}

static void
xt_free(xt_hdl *xth)
{
	xt_value_free(xth);
	xt_list_free(xth);
	free(xth);
}

static int
xt_set_attr_name(xt_hdl *xth, const char *name)
{
	if (strlen(name) > (sizeof xth->xt_attrkey) - 1)
		return -EINVAL;

	strcpy(xth->xt_attrkey, name);

	return 0;
}

static int
xt_getxattr(xt_hdl *xth)
{
	ssize_t ret;

#ifdef __FreeBSD__
	ret = extattr_get_file(xth->xt_filename, EXTATTR_NAMESPACE_USER,
	    xth->xt_attrkey, xth->xt_attrbuf, xth->xt_attrlen);
#else
	ret = getxattr(xth->xt_filename, xth->xt_attrkey, xth->xt_attrbuf,
	    xth->xt_attrlen);
#endif

	return ret < 0 ? -errno : ret;
}

static int
xt_fgetxattr(xt_hdl *xth)
{
	ssize_t ret;

#ifdef __FreeBSD__
	ret = extattr_get_fd(xth->xt_fd, EXTATTR_NAMESPACE_USER,
	    xth->xt_attrkey, xth->xt_attrbuf, xth->xt_attrlen);
#else
	ret = fgetxattr(xth->xt_fd, xth->xt_attrkey, xth->xt_attrbuf,
	    xth->xt_attrlen);
#endif
	return ret < 0 ? -errno : ret;
}

static int
xt_setxattr(xt_hdl *xth, int flags)
{
	int ret;

#ifdef __FreeBSD__
	ret = extattr_set_file(xth->xt_filename, EXTATTR_NAMESPACE_USER,
	    xth->xt_attrkey, xth->xt_attrbuf, xth->xt_attrlen);
#else
	ret = setxattr(xth->xt_filename, xth->xt_attrkey, xth->xt_attrbuf,
	    xth->xt_attrlen, flags);
#endif

	return ret < 0 ? -errno : 0;
}

static int
xt_fsetxattr(xt_hdl *xth, int flags)
{
	int ret;

#ifdef __FreeBSD__
	ret = extattr_set_fd(xth->xt_fd, EXTATTR_NAMESPACE_USER,
	    xth->xt_attrkey, xth->xt_attrbuf, xth->xt_attrlen);
#else
	ret = fsetxattr(xth->xt_fd, xth->xt_attrkey, xth->xt_attrbuf,
	    xth->xt_attrlen, flags);
#endif

	return ret < 0 ? -errno : 0;
}

static int
xt_removexattr(xt_hdl *xth)
{
	int ret;

#ifdef __FreeBSD__
	ret = extattr_delete_file(xth->xt_filename, EXTATTR_NAMESPACE_USER,
	    xth->xt_attrkey);
#else
	ret = removexattr(xth->xt_filename, xth->xt_attrkey);
#endif

	return ret < 0 ? -errno : 0;
}

static int
xt_fremovexattr(xt_hdl *xth)
{
	int ret;

#ifdef __FreeBSD__
	ret = extattr_delete_file(xth->xt_filename, EXTATTR_NAMESPACE_USER,
	    xth->xt_attrkey);
#else
	ret = fremovexattr(xth->xt_fd, xth->xt_attrkey);
#endif

	return ret < 0 ? -errno : 0;
}

static int
cmpstr(const void *p1, const void *p2)
{
	char *s1, *s2;

	s1 = *(char * const *) p1;
	s2 = *(char * const *) p2;

	if (s1 == s2)
		return 0;

	if (s1 == NULL)
		return 1;

	if (s2 == NULL)
		return -1;

	return strcmp(s1, s2);
}

static void
xattrs_sort(char **list, ssize_t count)
{
	qsort(list, count, sizeof (char *), cmpstr);
}

static int
xattrs_alloc(char ***listp, ssize_t count, ssize_t *lenp)
{
	ssize_t i, n, len, j;
	size_t slen;
	char **list;

	n = count;
	len = 0;

#ifdef LIST_MAX_CHECK
	if (n > (XATTR_LIST_MAX / 6))
		return -EINVAL;
#endif

	list = calloc(n, sizeof (char *));
	if (list == NULL)
		return -ENOMEM;

	for (i = 0; i < n; i++) {
#ifdef LIST_MAX_CHECK
		if ((len + 10) > XATTR_LIST_MAX)
			break;
#endif
		len += 10;

		if (asprintf(&list[i], "user.%04d", (int)i) < 0)
			break;
	}

	if (i < n) {
		for (j = 0; j < i; j++) {
			free(list[j]);
		}
		free(list);
		return -ENOMEM;
	}

	if (lenp)
		*lenp = len;
	*listp = list;

	return 0;

}

static void
xattrs_free(char **list, ssize_t count)
{
	ssize_t i;

	for (i = 0; i < count; i++) {
		if (list[i] != NULL)
			free(list[i]);
	}

	free(list);
}

static int
xattrs_buf2list(char *buf, ssize_t buflen, char ***listp, ssize_t *countp)
{
	ssize_t slen, count, len, i;
	char *p;
	char **list;

	p = buf;
	len = buflen;

	count = 0;
	while (len > 0) {
#ifdef __FreeBSD__
		slen = *p++;
		len--;
#else
		slen = strlen(p) + 1;
		if (!strncmp(p, "user.", 5))
#endif
			count++;
		p += slen;
		len -= slen;
	}

	if (count == 0) {
		list = NULL;
		goto out;
	}

	p = buf;
	len = buflen;

	list = calloc(count, sizeof (char *));
	if (list == NULL)
		return -ENOMEM;

	i = 0;
	while (len > 0) {
#ifdef __FreeBSD__
		char *mp;

		slen = *p++;
		len--;
		if (slen > len)
			return -EINVAL;

		mp = malloc(slen + 1);
		if (mp == NULL)
			return -ENOMEM;
		memcpy(mp, p, slen);
		mp[slen] = 0;
		list[i++] = mp;
#else
		slen = strlen(p) + 1;
		if (!strncmp(p, "user.", 5))
			list[i++] = strdup(p);
#endif
		p += slen;
		len -= slen;
	}

	xattrs_sort(list, count);

out:
	*listp = list;
	*countp = count;

	return 0;
}

static int
xattrs_file2list(const char *filename, char ***listp, ssize_t *countp)
{
	ssize_t len, ret;
	int error;
	char *buf;

#ifdef __FreeBSD__
	len = extattr_list_file(filename, EXTATTR_NAMESPACE_USER, NULL, 0);
#else
	len = listxattr(filename, NULL, 0);
#endif
	if (len < 0)
		return -errno;

	buf = malloc(len);
	if (buf == NULL)
		return -ENOMEM;

#ifdef __FreeBSD__
	ret = extattr_list_file(filename, EXTATTR_NAMESPACE_USER, buf, len);
#else
	ret = listxattr(filename, buf, len);
#endif
	if (ret < 0) {
		error = errno;
		*listp = NULL;
		free(buf);
		return -error;
	}

	error = xattrs_buf2list(buf, ret, listp, countp);

	free(buf);
	return error;
}

/*
 * Compare two string arrays that may have NULL entries. Counts are
 * the number of entries that include possible NULL entries.
 */
static int
xattrs_cmplists(char **list1, ssize_t count1, char **list2, ssize_t count2)
{
	ssize_t n1, n2;

	for (n1 = n2 = 0; n1 < count1 && n2 < count2;) {
		while (n1 < count1 && list1[n1] == NULL)
			n1++;
		while (n2 < count2 && list2[n2] == NULL)
			n2++;

		if (n1 >= count1) {
			if (n2 >= count2)
				return 0;
			return -1;
		}

		if (n2 >= count2) {
			if (n1 >= count1)
				return 0;
			return -1;
		}

		if (strcmp(list1[n1++], list2[n2++]))
			return -1;
	}

	return 0;
}

static int
xattrs_listset(const char *filename, char **list, ssize_t len)
{
	ssize_t i;
	int ret;
	char c = 'a';

	for (i = 0; i < len; i++) {
		if (list[i] == NULL)
			continue;
#ifdef __FreeBSD__
#if 0
		ret = extattr_set_file(filename, EXTATTR_NAMESPACE_USER,
		    list[i], NULL, 0);
#else
		ret = extattr_set_file(filename, EXTATTR_NAMESPACE_USER,
		    list[i], &c, 1);
#endif
#else
		ret = setxattr(filename, list[i], NULL, 0, 0);
#endif
		if (ret < 0)
			return -errno;
	}

	return 0;
}

static int
xattrs_listrm(const char *filename, char **list, ssize_t len)
{
	ssize_t i;
	int ret;

	for (i = 0; i < len; i++) {
		if (list[i] == NULL)
			continue;
#ifdef __FreeBSD__
		ret = extattr_delete_file(filename, EXTATTR_NAMESPACE_USER,
		    list[i]);
#else
		ret = removexattr(filename, list[i]);
#endif
		if (ret < 0)
			return -errno;
	}

	return 0;
}


static void
__test_xattr_len(xt_hdl *xth, ssize_t len)
{
	int ret;
	ssize_t xlen;

	ret = xt_file_create(xth);
	if (ret < 0) {
		fail(xth, "file create errno %d (%s)", errno,
		    strerror(errno));
		return;
	}

	ret = xt_value_alloc(xth, len);
	if (ret < 0) {
		fail(xth, "value alloc errno %d (%s)", errno,
		    strerror(errno));
		goto cleanup;
	}

	ret = xt_setxattr(xth, 0);
	if (ret < 0) {
		fail(xth, "setxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}

	xt_value_clear(xth);

	xlen = xt_getxattr(xth);
	if (xlen < 0) {
		fail(xth, "getxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}

	if (xlen != xt_value_len(xth)) {
		fail(xth, "getxattr length mismatch (expected %lld got %lld)",
		    (long long)xt_value_len(xth), (long long)xlen);
		goto cleanup;
	}

	ret = xt_value_check(xth, len);
	if (ret < 0) {
		fail(xth, "value check failed at offset %lld",
		    xt_value_failoff(xth));
		goto cleanup;
	}

	pass(xth, "success setting / getting %lld length xattr",
	    (long long)len);
cleanup:
	xt_file_remove(xth);
}

void
test_xattr_probe()
{
	int ret;
	xt_hdl *xth;
	ssize_t xlen;
	char c;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	ret = xt_file_create(xth);
	if (ret < 0) {
		fail(xth, "file create errno %d (%s)", errno,
		    strerror(errno));
		return;
	}

	ret = xt_value_alloc(xth, 37);
	if (ret < 0) {
		fail(xth, "value alloc failure");
		goto cleanup;
	}

	c = xt_fillc(xth);

	ret = xt_setxattr(xth, 0);
	if (ret < 0) {
		fail(xth, "setxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}

	ret = xt_value_alloc(xth, 0);
	if (ret < 0) {
		fail(xth, "value reset failure");
		goto cleanup;
	}

	xlen = xt_getxattr(xth);
	if (xlen < 0) {
		fail(xth, "getxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}
	if (xlen != 37) {
		fail(xth, "getxattr length mismatch (expected 37, got %lld)",
		    (long long)xlen);
		goto cleanup;
	}

	ret = xt_value_alloc(xth, 37);
	if (ret < 0) {
		fail(xth, "value realloc failure");
		goto cleanup;
	}

	xlen = xt_getxattr(xth);
	if (xlen < 0) {
		fail(xth, "getxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}

	if (__xt_value_check(xth, 37, c) < 0) {
		fail(xth, "value check failed at offset %lld",
		    xt_value_failoff(xth));
		goto cleanup;
	}

	pass(xth, "getxattr length probe works correctly");

cleanup:
	xt_file_remove(xth);
	xt_free(xth);
}

void
test_xattr_0()
{
	int ret;
	xt_hdl *xth;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	__test_xattr_len(xth, 0);

	xt_free(xth);
}

void
test_xattr_1()
{
	xt_hdl *xth;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	__test_xattr_len(xth, 1);

	xt_free(xth);
}

void
test_xattr_256()
{
	xt_hdl *xth;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	__test_xattr_len(xth, 256);

	xt_free(xth);
}

void
test_xattr_1page()
{
	xt_hdl *xth;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	__test_xattr_len(xth, PAGE_SIZE);

	xt_free(xth);
}

void
test_xattr_2pages()
{
	xt_hdl *xth;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	__test_xattr_len(xth, 2 * PAGE_SIZE);

	xt_free(xth);
}

void
test_xattr_max()
{
	xt_hdl *xth;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	__test_xattr_len(xth, XATTR_SIZE_MAX);

	xt_free(xth);
}

void
test_xattr_toolarge()
{
	xt_hdl *xth;
	ssize_t ret;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	ret = xt_file_create(xth);
	if (ret < 0) {
		fail(xth, "file create errno %d (%s)", errno,
		    strerror(errno));
		return;
	}

	ret = xt_value_alloc(xth, XATTR_SIZE_MAX + 1);
	if (ret < 0) {
		fail(xth, "value alloc errno %d (%s)", errno,
		    strerror(errno));
		goto cleanup;
	}

	ret = xt_setxattr(xth, 0);
	if (ret != -ERR_TOOBIG) {
		fail(xth, "expected %d got %d (%s)", ERR_TOOBIG,
		    -ret, ret == 0 ? "no error" : strerror(-ret));
		goto cleanup;
	}

	pass(xth, "setxattr beyond max length fails as expected");

cleanup:
	xt_file_remove(xth);
	xt_free(xth);
}

void
test_setxattr_create()
{
	xt_hdl *xth;
	int ret;
	ssize_t xlen;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	ret = xt_file_create(xth);
	if (ret < 0) {
		fail(xth, "file create errno %d (%s)", errno,
		    strerror(errno));
		return;
	}

	ret = xt_value_alloc(xth, 16);
	if (ret < 0) {
		fail(xth, "value alloc errno %d (%s)", errno,
		    strerror(errno));
		goto cleanup;
	}

	/*
 	 * XATTR_CREATE for a non-existing xattr ==> OK
 	 */
	ret = xt_setxattr(xth, XATTR_CREATE);
	if (ret < 0) {
		fail(xth, "setxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}

#ifndef __FreeBSD__
	/*
 	 * XATTR_CREATE for an existing xattr ==> EEXIST
 	 */
	ret = xt_setxattr(xth, XATTR_CREATE);
	if (ret != -EEXIST) {
		fail(xth, "expected %d got %d (%s)", EEXIST,
		    -ret, ret == 0 ? "no error" : strerror(-ret));
		goto cleanup;
	}
#endif

	/*
	 * Verify value (xattr should still exist).
	 */
	xt_value_clear(xth);

	xlen = xt_getxattr(xth);
	if (xlen < 0) {
		fail(xth, "getxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}

	if (xlen != xt_value_len(xth)) {
		fail(xth, "getxattr length mismatch (expected %lld got %lld)",
		    (long long)xt_value_len(xth), (long long)xlen);
		goto cleanup;
	}

	ret = xt_value_check(xth, 16);
	if (ret < 0) {
		fail(xth, "value check failed at offset %lld",
		    xt_value_failoff(xth));
		goto cleanup;
	}

	pass(xth, "setxattr with XATTR_CREATE behaves correctly");

cleanup:

	xt_file_remove(xth);
	xt_free(xth);
}

#ifdef __FreeBSD__
void
test_setxattr_replace()
{
	xt_hdl *xth;

	xth = xt_init(__func__);

	pass(xth, "not applicable on FreeBSD");
}
void
test_setxattr_badflag()
{
	xt_hdl *xth;

	xth = xt_init(__func__);

	pass(xth, "not applicable on FreeBSD");
}
#else
void
test_setxattr_replace()
{
	xt_hdl *xth;
	int ret;
	ssize_t xlen;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	ret = xt_file_create(xth);
	if (ret < 0) {
		fail(xth, "file create errno %d (%s)", errno,
		    strerror(errno));
		return;
	}

	ret = xt_value_alloc(xth, 16);
	if (ret < 0) {
		fail(xth, "value alloc errno %d (%s)", errno,
		    strerror(errno));
		goto cleanup;
	}

	/*
 	 * XATTR_REPLACE for a non-existing xattr ==> ENODATA
 	 */
	ret = xt_setxattr(xth, XATTR_REPLACE);
	if (ret != -ENODATA) {
		fail(xth, "expected %d got %d (%s)", ENODATA,
		    -ret, ret == 0 ? "no error" : strerror(-ret));
		goto cleanup;
	}

	/*
 	 * Create it, try to replace it afterwards.
 	 */
	ret = xt_setxattr(xth, 0);
	if (ret < 0) {
		fail(xth, "setxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}

	xt_value_fill(xth);

	/*
 	 * XATTR_REPLACE should work.
 	 */
	ret = xt_setxattr(xth, XATTR_REPLACE);
	if (ret < 0) {
		fail(xth, "setxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}

	/*
	 * Verify value (xattr should still exist).
	 */
	xt_value_clear(xth);

	xlen = xt_getxattr(xth);
	if (xlen < 0) {
		fail(xth, "getxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}

	if (xlen != xt_value_len(xth)) {
		fail(xth, "getxattr length mismatch (expected %lld got %lld)",
		    (long long)xt_value_len(xth), (long long)xlen);
		goto cleanup;
	}

	ret = xt_value_check(xth, 16);
	if (ret < 0) {
		fail(xth, "value check failed at offset %lld",
		    xt_value_failoff(xth));
		goto cleanup;
	}

	pass(xth, "setxattr with XATTR_REPLACE behaves correctly");

cleanup:
	xt_file_remove(xth);
	xt_free(xth);
}

void
test_setxattr_badflag()
{
	xt_hdl *xth;
	int ret;
	ssize_t xlen;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	ret = xt_file_create(xth);
	if (ret < 0) {
		fail(xth, "file create errno %d (%s)", errno,
		    strerror(errno));
		return;
	}

	ret = xt_value_alloc(xth, 16);
	if (ret < 0) {
		fail(xth, "value alloc errno %d (%s)", errno,
		    strerror(errno));
		goto cleanup;
	}

	/*
 	 * XATTR_REPLACE for a non-existing xattr ==> ENODATA
 	 */
	ret = xt_setxattr(xth, XATTR_REPLACE);
	if (ret != -ENODATA) {
		fail(xth, "expected %d got %d (%s)", ENODATA,
		    -ret, ret == 0 ? "no error" : strerror(-ret));
		goto cleanup;
	}

	ret = xt_setxattr(xth, -1);
	if (ret != -EINVAL) {
		fail(xth, "setxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}

	pass(xth, "setxattr with a bad flag behaves correctly");

cleanup:
	xt_file_remove(xth);
	xt_free(xth);
}
#endif

void
test_removexattr()
{
	xt_hdl *xth;
	int ret;
	ssize_t xlen;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	ret = xt_file_create(xth);
	if (ret < 0) {
		fail(xth, "file create errno %d (%s)", errno,
		    strerror(errno));
		return;
	}

	ret = xt_value_alloc(xth, 16);
	if (ret < 0) {
		fail(xth, "value alloc errno %d (%s)", errno,
		    strerror(errno));
		goto cleanup;
	}

	ret = xt_removexattr(xth);
	if (ret != -ENODATA) {
		fail(xth, "expected %d got %d (%s)", ENODATA,
		    -ret, ret == 0 ? "no error" : strerror(-ret));
		goto cleanup;
	}

	/*
 	 * Create it, try to remove it afterwards.
 	 */
	ret = xt_setxattr(xth, 0);
	if (ret < 0) {
		fail(xth, "setxattr errno %d (%s)", errno, strerror(errno));
		goto cleanup;
	}

	ret = xt_removexattr(xth);
	if (ret < 0) {
		fail(xth, "removexattr errno %d (%s)", errno,
		    strerror(errno));
		goto cleanup;
	}

	/*
	 * See if it's actually gone.
	 */
	xlen = xt_getxattr(xth);
	if (xlen != -ENODATA) {
		fail(xth, "expected %d got %d (%s)", ENODATA,
		    -xlen, xlen == 0 ? "no error" : strerror(xlen));
		goto cleanup;
	}

	pass(xth, "removexattr behaves correctly");

cleanup:
	xt_file_remove(xth);
	xt_free(xth);
}

void
__test_listxattr(xt_hdl *xth, ssize_t nattr)
{
	ssize_t len, alen;
	char **list1, **list2;
	int ret;

	list1 = list2 = NULL;

	ret = xattrs_alloc(&list1, nattr, &alen);
	if (ret < 0) {
		fail(xth, "failed to allocate xattr names");
		return;
	}

	ret = xattrs_listset(xt_filename(xth), list1, nattr);
	if (ret < 0) {
#ifdef __FreeBSD__
		if (nattr >= XATTR_TEST_NATTR_MAX && ret == -ENOSPC)
			goto pass;
#endif
		fail(xth, "failed to set xattrs (%s)", strerror(-ret));
		goto out;
	}

	ret = xattrs_file2list(xt_filename(xth), &list2, &len);
	if (ret < 0) {
		if (alen > XATTR_SIZE_MAX && ret == -ERR_TOOBIG) {
			/*
			 * Expected failure.
			 */
			goto rm;
		}
		fail(xth, "failed to get xattrs");
		goto out;
	}

	if (xattrs_cmplists(list1, nattr, list2, len)) {
		ret = -EINVAL;	/* XXX */
		fail(xth, "list comparison failed");
		goto out;
		
	}

rm:
	ret = xattrs_listrm(xt_filename(xth), list1, nattr);
	if (ret < 0) {
		fail(xth, "failed to remove xattrs");
		goto out;
	}

pass:

	pass(xth, "expected results listing and removing %lld xattrs",
	    (long long)nattr);

out:
	if (list2 != NULL)
		xattrs_free(list2, len);
	if (list1 != NULL)
		xattrs_free(list1, nattr);
}

void
test_listxattr_1()
{
	xt_hdl *xth;
	int ret;
	char **list1, **list2;
	ssize_t len;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	ret = xt_file_create(xth);
	if (ret < 0) {
		fail(xth, "file create errno %d (%s)", errno,
		    strerror(errno));
		return;
	}

	__test_listxattr(xth, 1);

	xt_file_remove(xth);
	xt_free(xth);
}

void
test_listxattr_256()
{
	xt_hdl *xth;
	int ret;
	char **list1, **list2;
	ssize_t len;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	ret = xt_file_create(xth);
	if (ret < 0) {
		fail(xth, "file create errno %d (%s)", errno,
		    strerror(errno));
		return;
	}

	__test_listxattr(xth, 256);

	xt_file_remove(xth);
	xt_free(xth);
}

void
test_listxattr_large()
{
	xt_hdl *xth;
	int ret;
	char **list1, **list2;
	ssize_t len;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	ret = xt_file_create(xth);
	if (ret < 0) {
		fail(xth, "file create errno %d (%s)", errno,
		    strerror(errno));
		return;
	}

	__test_listxattr(xth, XATTR_TEST_NATTR_MAX - 2);

	xt_file_remove(xth);
	xt_free(xth);
}

void
test_listxattr_2big()
{
	xt_hdl *xth;
	int ret;
	char **list1, **list2;
	ssize_t len;

	xth = xt_init(__func__);
	if (xth == NULL) {
		printf("%-24s FAIL: can't initialize handle", __func__);
		return;
	}

	ret = xt_file_create(xth);
	if (ret < 0) {
		fail(xth, "file create errno %d (%s)", errno,
		    strerror(errno));
		return;
	}

	__test_listxattr(xth, XATTR_TEST_NATTR_MAX + 1);

	xt_file_remove(xth);
	xt_free(xth);
}

int
main(int argc, char **argv)
{
	struct stat st;
	int fd, ret;

	if (argc < 2)
		usage();

	ret = xt_set_fs(argv[1]);
	if (ret != 0) {
		fprintf(stderr, "xattr: set fs: %s\n", strerror(ret));
		exit(1);
	}

	srandom(time(NULL));

	test_xattr_probe();
	test_xattr_0();
	test_xattr_1();
	test_xattr_256();
	test_xattr_1page();
	test_xattr_2pages();
	test_xattr_max();
	test_xattr_toolarge();

	test_setxattr_create();
	test_setxattr_replace();
	test_setxattr_badflag();

	test_removexattr();

	test_listxattr_1();
	test_listxattr_256();
	test_listxattr_large();
	test_listxattr_2big();

	return 0;
}

--k1lZvvs/B4yU6o8G--
