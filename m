Return-Path: <linux-nfs+bounces-14259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B680B523D5
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 23:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C837BD049
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 21:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D3830FF02;
	Wed, 10 Sep 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8kFZ+rM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D230F935
	for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540823; cv=none; b=Uu2/AYeUezbY0QvJ0dtHaaKXGeX+lm1ysJbohQnUqUAgVkuvGF8lEuJrdNYotUfob8uq5ErgAhA8HZ8NZLn6Z+cXMZhuAXi4+5V9Ek6xjyW2qCq3nj4lVkmyueG6ASlHcbdzV/3Uy4SoWeWvn3JXq9jGiQ5NvkPkT4ZAVxL0j9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540823; c=relaxed/simple;
	bh=N1vu5A1ZRCFHnhrDrtQSS+sG1PdI8dtEJ7gEJSlJ2a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsUWPGgXc9c4hwXNw2UcZcIiEJgBhZgVlHhZzLPccJ5ynrbo0oU38B9Os6/aT7/2V/msAntyqwEt5buagIIbW9VR0nAWrtK0Uy2C6ckBusFN+fBg44CBvPRumJNsPXaznD+oe7gKRJU2cQy+oFGNDCXmLgT7SiRpT2ARCILFD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8kFZ+rM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso53021b3a.1
        for <linux-nfs@vger.kernel.org>; Wed, 10 Sep 2025 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757540821; x=1758145621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jh1PVWcfGklaWv+aRqcKqBvGWRMB1ZgPcYyyYXlyxeU=;
        b=N8kFZ+rM1tVBGEpDjPDRLuoXoLTBb3Ert5R9b/JUD88kJvwhY+wyo9t6dT4Vd+DFlG
         UNrGEeFtDYYAd6fN+ZuWPkNZ6vr7XPVSK/6GZnxminO4JDB8KwW7qebXZQmsJLA/n1dq
         DoBx3T+hiXkvF1wBUSlqm6iKyAcda4JHpaXvI8FFstrsZuVrq50kxKuiD108e8QXqiFD
         IvzuPrNbtUoYxmjrqaMXL3aTPsXuaJsH/BNMyrT1L+R+p1LZxFLrbk72C2IiMXmxQfG3
         2hfwrsCinFl7DYrdyT5UDdqoQrU59fGUVCtGvOq8V33hEoEzk6M76yis5nd26kbiZMTz
         29Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757540821; x=1758145621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jh1PVWcfGklaWv+aRqcKqBvGWRMB1ZgPcYyyYXlyxeU=;
        b=PjyOyRMcekt5LJZLcakq9CVX8wA5LOKWr7hCJx4v/A2k21lvFT4ywybmnVqYOsWXhj
         ClKhZVNhdWBFEE5OXs6BmvhHvMKxkasX4NsrRQ61pj6hfg5S5JI1PMSynzyyr1ZX+RP+
         YJ1QekjazJ4GhNfIWBOhLTYhbkiYFC9a0nbA7XZ85/I09IvSaDMtbTufkPZIwXMN9q9r
         VQIz1biyeo4l3r7N2y4JUIxJdwEvvcQktOvwcvEw8IB7C51Xgh0KHUylH5R1D3v9x8d1
         c6x8PfywJbjP9hYxalaOlp02vWHjBTQwEJKQ+S1oiOlz1tBV+bzjzkKHscDnTibR1znp
         qVEg==
X-Forwarded-Encrypted: i=1; AJvYcCVYhcpSF9BuIuh5lqT3hF4W4AuES1Q7qDPvYZO/AA6JyV2Dx830atOO/FICh3ptzMCw8JK9v/mXyfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweT+5HZ7INVVYnjjY32ZCly4Q1N0k5PENeRQInCjbZaXjhJqgQ
	+JTkqCpaAq+Ce/0LyJOhP0i9f6EmtkaRA4PrAzI3l1FQMfx6uy/WgOZx
X-Gm-Gg: ASbGncsSPwHhvfi9PIpHwlPRJQ/9rjz2+BdsweYQsDgp6aCIJp9cZLRuxcUejJ9mgkA
	NihDOI/x3STyeksod/z61Wgg/wP6NXGPSHOMbDExZrtMjDEw/tL4SuBU9LVOQ2VpIl7Xrl9UcFI
	Kz4A63u7s0WKFdMOUXgDyoCuuTZxCQrQIPeP2mjUJ2glE0mylwd2ctTY4nDRxo8DVSyvRU3b52S
	WbMwW5YWdllOGF8JJmHW6sF3EF0kkqrOnSZmZIpFOm4ogv9dH5Vs/LGliyojIoABokPJ9uTeG1L
	TlOpnf3x/Hzgsk/j/VrvOCMdYtKWNGti8Zdk0K65ahNG+HMwENdV6Hn9RphtZgKU7moK60nPoX+
	hu2ZovmxyQFktqYypnDdzZXb90g==
X-Google-Smtp-Source: AGHT+IHg4ns4GkmdZ6pzmsU1/aewjLF9oDtwhywGlNT90Gumf5P4l0ty5klyFIatdkwk619z24neag==
X-Received: by 2002:a05:6a00:3c90:b0:772:f23:f9f with SMTP id d2e1a72fcca58-7742ded55a4mr20159233b3a.29.1757540820798;
        Wed, 10 Sep 2025 14:47:00 -0700 (PDT)
Received: from jicarita ([65.144.169.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-775fbbc3251sm2422516b3a.103.2025.09.10.14.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 14:47:00 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-nfs@vger.kernel.org
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH 04/10] fhandle: create do_filp_path_open() helper
Date: Wed, 10 Sep 2025 15:49:21 -0600
Message-ID: <20250910214927.480316-5-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910214927.480316-1-tahbertschinger@gmail.com>
References: <20250910214927.480316-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This pulls the code for opening a file, after its handle has been
converted to a struct path, into a new helper function.

This function will be used by io_uring once io_uring supports
open_by_handle_at(2).

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 fs/fhandle.c  | 21 +++++++++++++++------
 fs/internal.h |  1 +
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 36e194dd4cb6..91b0d340a4d1 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -402,6 +402,20 @@ int handle_to_path(int mountdirfd, struct file_handle *handle,
 	return retval;
 }
 
+struct file *do_filp_path_open(struct path *path, int open_flag)
+{
+	const struct export_operations *eops;
+	struct file *file;
+
+	eops = path->mnt->mnt_sb->s_export_op;
+	if (eops->open)
+		file = eops->open(path, open_flag);
+	else
+		file = file_open_root(path, "", open_flag, 0);
+
+	return file;
+}
+
 static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 			   int open_flag)
 {
@@ -409,7 +423,6 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 	long retval = 0;
 	struct path path __free(path_put) = {};
 	struct file *file;
-	const struct export_operations *eops;
 
 	handle = get_user_handle(ufh);
 	if (IS_ERR(handle))
@@ -423,11 +436,7 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 	if (fd < 0)
 		return fd;
 
-	eops = path.mnt->mnt_sb->s_export_op;
-	if (eops->open)
-		file = eops->open(&path, open_flag);
-	else
-		file = file_open_root(&path, "", open_flag, 0);
+	file = do_filp_path_open(&path, open_flag);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
diff --git a/fs/internal.h b/fs/internal.h
index ab80f83ded47..599e0d7b450e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -366,4 +366,5 @@ long do_sys_name_to_handle_at(int dfd, const char __user *name,
 struct file_handle *get_user_handle(struct file_handle __user *ufh);
 int handle_to_path(int mountdirfd, struct file_handle *handle,
 		   struct path *path, unsigned int o_flags);
+struct file *do_filp_path_open(struct path *path, int open_flag);
 #endif /* CONFIG_FHANDLE */
-- 
2.51.0


