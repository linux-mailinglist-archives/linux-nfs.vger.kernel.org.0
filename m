Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CC920A3C5
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2020 19:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404214AbgFYRNX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 13:13:23 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:59033 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404083AbgFYRNT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 13:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1593105194; x=1624641194;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=11AvrCyzNHji9lyGjPeiELhY3BM0IihpDFB+FpHECRs=;
  b=uBMK73OWKQQgR9BdvnXeW88cMsBzV6ek9iy70ec/HFbpDB8mylfOxTvu
   SZ2QA+kxanxKim5CsiSMSSUcTAe350oLNW4EEr9ztLJKy+vjU0Vm2xrxO
   PFT6x5Ws7Xp/FGI11esulHA7H+Lr7NgrZwT0sb95dWIU6gXMeJMKttfJP
   4=;
IronPort-SDR: BNxUfOxITTY69cTtYRuUFgG92kTneAt9tBmeseWFPFzaiiQ29Ny6EhcO9T2+HcZGEpbgPtlHzK
 wx2fQpb7XHDA==
X-Amazon-filename: xattr.c
X-IronPort-AV: E=Sophos;i="5.75,280,1589241600"; 
   d="c'?scan'208";a="38552696"
Subject: Re: [PATCH v3 00/10] server side user xattr support (RFC 8276)
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 25 Jun 2020 17:13:13 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id A0243A189E;
        Thu, 25 Jun 2020 17:13:11 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Jun 2020 17:13:11 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 25 Jun 2020 17:13:10 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 25 Jun 2020 17:13:10 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 6E9A5C3318; Thu, 25 Jun 2020 17:13:10 +0000 (UTC)
Date:   Thu, 25 Jun 2020 17:13:10 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
CC:     <chuck.lever@oracle.com>, <linux-nfs@vger.kernel.org>
Message-ID: <20200625171310.GA29600@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
 <20200625165038.GA30655@fieldses.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20200625165038.GA30655@fieldses.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Jun 25, 2020 at 12:50:38PM -0400, J. Bruce Fields wrote:
> > In general, these patches were, both server and client, tested as
> > follows:
> >       * stress-ng-xattr with 1000 workers
> >       * Test all corner cases (XATTR_SIZE_*)
> >       * Test all failure cases (no xattr, setxattr with different or
> >         invalid flags, etc).
> >       * Verify the content of xattrs across several operations.
> 
> Do you have some code to share for these tests?
> 
> --b.

Sure, my main piece of test code is attached.

- Frank

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="xattr.c"

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/xattr.h>
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <time.h>
#include <stdarg.h>
#include <limits.h>

#ifndef XATTR_SIZE_MAX
#define XATTR_SIZE_MAX	65536
#endif

#ifndef XATTR_LIST_MAX
#define XATR_LIST_MAX 65536
#endif

#define XATTR_TEST_ATTRLEN	(5 + 4 + 1)	/* "user.NNNN\0" */
#define XATTR_TEST_NATTR_MAX	(XATTR_LIST_MAX / XATTR_TEST_ATTRLEN)

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

	fd = mkostemp(xth->xt_filename, O_TRUNC);
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

	ret = getxattr(xth->xt_filename, xth->xt_attrkey, xth->xt_attrbuf,
	    xth->xt_attrlen);

	return ret < 0 ? -errno : ret;
}

static int
xt_fgetxattr(xt_hdl *xth)
{
	ssize_t ret;

	ret = fgetxattr(xth->xt_fd, xth->xt_attrkey, xth->xt_attrbuf,
	    xth->xt_attrlen);
	return ret < 0 ? -errno : ret;
}

static int
xt_setxattr(xt_hdl *xth, int flags)
{
	int ret;

	ret = setxattr(xth->xt_filename, xth->xt_attrkey, xth->xt_attrbuf,
	    xth->xt_attrlen, flags);

	return ret < 0 ? -errno : 0;
}

static int
xt_fsetxattr(xt_hdl *xth, int flags)
{
	int ret;

	ret = fsetxattr(xth->xt_fd, xth->xt_attrkey, xth->xt_attrbuf,
	    xth->xt_attrlen, flags);

	return ret < 0 ? -errno : 0;
}

static int
xt_removexattr(xt_hdl *xth)
{
	int ret;

	ret = removexattr(xth->xt_filename, xth->xt_attrkey);

	return ret < 0 ? -errno : 0;
}

static int
xt_fremovexattr(xt_hdl *xth)
{
	int ret;

	ret = fremovexattr(xth->xt_fd, xth->xt_attrkey);

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

static int
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
		slen = strlen(p) + 1;
		if (!strncmp(p, "user.", 5))
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
		slen = strlen(p) + 1;
		if (!strncmp(p, "user.", 5))
			list[i++] = strdup(p);
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

	len = listxattr(filename, NULL, 0);
	if (len < 0)
		return -errno;

	buf = malloc(len);
	if (buf == NULL)
		return -ENOMEM;

	ret = listxattr(filename, buf, len);
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

	for (i = 0; i < len; i++) {
		if (list[i] == NULL)
			continue;
		ret = setxattr(filename, list[i], NULL, 0, 0);
		if (ret < 0) {
			ret = -errno;
			fprintf(stderr, "%s: failed at %d (%s)\n",
					__func__, i, strerror(ret));
			return ret;
		}
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
		ret = removexattr(filename, list[i]);
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

	__test_xattr_len(xth, 65536);

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
	if (ret != -E2BIG) {
		fail(xth, "expected %d got %d (%s)", E2BIG,
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

	/*
 	 * XATTR_CREATE for an existing xattr ==> EEXIST
 	 */
	ret = xt_setxattr(xth, XATTR_CREATE);
	if (ret != -EEXIST) {
		fail(xth, "expected %d got %d (%s)", EEXIST,
		    -ret, ret == 0 ? "no error" : strerror(-ret));
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

	pass(xth, "setxattr with XATTR_CREATE behaves correctly");

cleanup:

	xt_file_remove(xth);
	xt_free(xth);
}

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
		fail(xth, "failed to set xattrs");
		goto out;
	}

	ret = xattrs_file2list(xt_filename(xth), &list2, &len);
	if (ret < 0) {
		if (alen > XATTR_SIZE_MAX && ret == -E2BIG) {
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

--J/dobhs11T7y2rNN--
