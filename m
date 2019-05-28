Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 737F52D071
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 22:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfE1Udh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 16:33:37 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54344 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfE1Udh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 16:33:37 -0400
Received: by mail-it1-f196.google.com with SMTP id h20so6577822itk.4
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jUmzQXFgosC7ztxN2DEYWeUIGWU2k+scoj1vllYXDW0=;
        b=O72yHaKNaySnpTiwioQ0RduqpXEgBZH2IZpKKwN3zBY4mLGNO5T5qvzLbajLe7RWe1
         esLrI8GhX++oSS77f1AK76k3ig9+zkRlRH49pSUE3o7rEJe7AcQovk/LmpgQSXNorRhr
         vXGGch7FChamqx2t7U/NUM+finmGbqS7ost8h46y81XaMIJLJcr6qKchDuosb6p27zGT
         jMsRZPD7DOw5rkpopBPyFEJ1TAHXpyx3k0Nk3V7WsBO1jJLbc82efhxZo5A03tU3/K1o
         he8Da9jm8fmkfWv/NzZt6jpOVHB0P5RH8jmouBOh/PNPtvK4Qo5dIYAKl7IjF+AwkZte
         BCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUmzQXFgosC7ztxN2DEYWeUIGWU2k+scoj1vllYXDW0=;
        b=M0m60wkgSDLYQ1JNZHXTXCq1lDPZeYRGoqnfXi4Sc3ILCQVw4sJiC8nk2mOaDak6Tk
         Bu3mgvSgUkNi39scxGY2pDP0R3rLXjIigvIm8wFtwqD5Tu75pks1Sv2GRMzo2APQkAGK
         S72atbkcgeipaD+0FEmo8CkjFMeKxgZF5ZtFJP0rmTvuYPHIJRgV50G68QKT4eK6ydTw
         BiewPT2J8YTyeEAfZSOnnb1JvwCsY3pVlleU1BCHRwzmEomoJtkkaUTsm3y/mY22CuUR
         +uyfNqPjUO+PgZxh3vdslwA9CfN3rIO+/KDLD2wMEb1ntMomusd+dN6FORLAH/YSwmVB
         VR2Q==
X-Gm-Message-State: APjAAAVKnoaZo9QO7Pft9KLFn6EviHLg1Ykx9fCg5BtsWxrpc82p9wv4
        Bqth9tiXBxVhTQQrfinH9UcRvn0=
X-Google-Smtp-Source: APXvYqxdRXNnfFqbOwKmGlVo6yIMZmv7FVYDSHDf09v5UmN42cB0isA0h13uHs2ZqXyu2eRTHGxLUA==
X-Received: by 2002:a24:2547:: with SMTP id g68mr4534763itg.109.1559075616273;
        Tue, 28 May 2019 13:33:36 -0700 (PDT)
Received: from localhost.localdomain (50-124-247-140.alma.mi.frontiernet.net. [50.124.247.140])
        by smtp.gmail.com with ESMTPSA id i141sm53089ite.20.2019.05.28.13.33.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:33:35 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 06/11] Add helpers to read/write to a file through the chrooted thread
Date:   Tue, 28 May 2019 16:31:17 -0400
Message-Id: <20190528203122.11401-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528203122.11401-6-trond.myklebust@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
 <20190528203122.11401-2-trond.myklebust@hammerspace.com>
 <20190528203122.11401-3-trond.myklebust@hammerspace.com>
 <20190528203122.11401-4-trond.myklebust@hammerspace.com>
 <20190528203122.11401-5-trond.myklebust@hammerspace.com>
 <20190528203122.11401-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add helper functions to do synchronous I/O to a nfsd filesystem pseudofile
from inside the chrooted environment. This ensures that calls to kern_path()
in knfsd resolves to paths that are relative to the nfsd root directory.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 support/include/nfsd_path.h |  3 ++
 support/misc/nfsd_path.c    | 84 +++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/support/include/nfsd_path.h b/support/include/nfsd_path.h
index db9b41a179ad..f4a7f0a4337f 100644
--- a/support/include/nfsd_path.h
+++ b/support/include/nfsd_path.h
@@ -13,4 +13,7 @@ char *		nfsd_path_prepend_dir(const char *dir, const char *pathname);
 int 		nfsd_path_stat(const char *pathname, struct stat *statbuf);
 int 		nfsd_path_lstat(const char *pathname, struct stat *statbuf);
 
+ssize_t		nfsd_path_read(int fd, char *buf, size_t len);
+ssize_t		nfsd_path_write(int fd, const char *buf, size_t len);
+
 #endif
diff --git a/support/misc/nfsd_path.c b/support/misc/nfsd_path.c
index fe2c011b1521..55bca9bdf4bd 100644
--- a/support/misc/nfsd_path.c
+++ b/support/misc/nfsd_path.c
@@ -166,3 +166,87 @@ nfsd_path_lstat(const char *pathname, struct stat *statbuf)
 		return xlstat(pathname, statbuf);
 	return nfsd_run_stat(nfsd_wq, nfsd_lstatfunc, pathname, statbuf);
 }
+
+struct nfsd_read_data {
+	int fd;
+	char *buf;
+	size_t len;
+	ssize_t ret;
+	int err;
+};
+
+static void
+nfsd_readfunc(void *data)
+{
+	struct nfsd_read_data *d = data;
+
+	d->ret = read(d->fd, d->buf, d->len);
+	if (d->ret < 0)
+		d->err = errno;
+}
+
+static ssize_t
+nfsd_run_read(struct xthread_workqueue *wq, int fd, char *buf, size_t len)
+{
+	struct nfsd_read_data data = {
+		fd,
+		buf,
+		len,
+		0,
+		0
+	};
+	xthread_work_run_sync(wq, nfsd_readfunc, &data);
+	if (data.ret < 0)
+		errno = data.err;
+	return data.ret;
+}
+
+ssize_t
+nfsd_path_read(int fd, char *buf, size_t len)
+{
+	if (!nfsd_wq)
+		return read(fd, buf, len);
+	return nfsd_run_read(nfsd_wq, fd, buf, len);
+}
+
+struct nfsd_write_data {
+	int fd;
+	const char *buf;
+	size_t len;
+	ssize_t ret;
+	int err;
+};
+
+static void
+nfsd_writefunc(void *data)
+{
+	struct nfsd_write_data *d = data;
+
+	d->ret = write(d->fd, d->buf, d->len);
+	if (d->ret < 0)
+		d->err = errno;
+}
+
+static ssize_t
+nfsd_run_write(struct xthread_workqueue *wq, int fd, const char *buf, size_t len)
+{
+	struct nfsd_write_data data = {
+		fd,
+		buf,
+		len,
+		0,
+		0
+	};
+	xthread_work_run_sync(wq, nfsd_writefunc, &data);
+	if (data.ret < 0)
+		errno = data.err;
+	return data.ret;
+}
+
+ssize_t
+nfsd_path_write(int fd, const char *buf, size_t len)
+{
+	if (!nfsd_wq)
+		return write(fd, buf, len);
+	return nfsd_run_write(nfsd_wq, fd, buf, len);
+}
-- 
2.21.0

