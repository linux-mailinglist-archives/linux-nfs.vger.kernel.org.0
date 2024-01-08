Return-Path: <linux-nfs+bounces-978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A182786F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 20:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748DE1F23479
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 19:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3231955C21;
	Mon,  8 Jan 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmBNon97"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DB55C37
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jan 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so2241134e87.0
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jan 2024 11:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704741596; x=1705346396; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7hEU4GqkAauyy1vXU+CcuCqs+wfYQUfOI/iPMWkfy7A=;
        b=HmBNon976+xB2fvQRAr9bMK+6FI+kNUMuvMxKRvJpgxOBL13PZkSG02jy1CpLokGGA
         THEVyhCEBOoPiMntkZxieVHDRGYpTFhqltffQaRz6aEgDvYikGIbnkOev05smlaYnJsk
         9oKAgWEL2IE1EpEaT0xhc4lfytfWmfKHx2bu78k8Pn1eNOMTrLMv0Blq3RC9XAWe8x5U
         zGHMBSqbejR6SLhM0aTWgqRU7MxTp9LWMwikZxCPs9tfA884Pi258tZAD0859HUEkGU8
         jDu18XVhVKj1zCXHj4A4tPeKOn/MaCT8bKGKD39AdQvteMGfKS+Stvc8SuKue2ZKJRIK
         QOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741596; x=1705346396;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hEU4GqkAauyy1vXU+CcuCqs+wfYQUfOI/iPMWkfy7A=;
        b=CXCGYEUmeDa1mVkN2neqX5vyn/rCcNPDqJUtKlyGRzpX+atMyxpHsDkDq4vvs5dSFd
         DpSKA1w1eZp65ZgO1EoYZeBLR/uW/5VeLy7HWY2C3QbEAqSDXFBOUc1Qr9UyAwncvBqQ
         mz3jO/4iLgxJG1tYUWZnn2UNX5AqlsDVVkRTqsaLJAnYfWNQFNFv3NiE2QfqQhB/AJ4y
         LGYO7DZwvAwQFzrW1UiePicJZ+PqcqTzpBw5Gp37S077MHSCHggq+fjSZIhNvPIIKTcK
         GKY+flY9F2USQoP3IYIPy92bu66weEk6eic2RNg8NNMUB+deUFEYLi5Gf2iIGft7HyLm
         JVLA==
X-Gm-Message-State: AOJu0YwZgGfH4eIOD9UxmHKERQjfRQth7JTL/YatOy6i/TUW4XXZJZ2f
	cjG/06VtSPIr1sOl1jvWnayGm6owf68DBv4aXbBkcBBx3aubHg==
X-Google-Smtp-Source: AGHT+IFllPwq6OJ8Xd0I+qaIjGFQM4RouOyYI1ca4ErttUDnNjEl1Xtae7POWHRKYrjiJaT1MHzoS7PGc69em1z1+cg=
X-Received: by 2002:a05:6512:400a:b0:50e:ad63:1650 with SMTP id
 br10-20020a056512400a00b0050ead631650mr1793927lfb.97.1704741596317; Mon, 08
 Jan 2024 11:19:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Mon, 8 Jan 2024 20:19:30 +0100
Message-ID: <CAAvCNcBiCxdC+zyr1JRRrzBff9eBGpT5Zmfe2nU3dr_8Vgf8JA@mail.gmail.com>
Subject: Mailing list for nfs4j, simple-nfs, and simple-nfs crash as plain user?
To: kofemann@gmail.com, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello, is there a nfs4j/simple-nfs mailing list, where I can ask questions?

I cannot get the simple-nfs server to run as a plain user (not root).
I tried this, but I get a java exception:

$ cat exports
/ *(rw,insecure,all_squash)
$ java -jar ./target/simple-nfs-1.0-SNAPSHOT-jar-with-dependencies.jar
-root / -port 30000 -exports $PWD/exports
Exception in thread "main" java.io.UncheckedIOException:
java.nio.file.AccessDeniedException: /lost+found
       at org.dcache.simplenfs.SimpleNfsServer.<init>(SimpleNfsServer.java:77)
       at org.dcache.simplenfs.App.run(App.java:55)
       at org.dcache.simplenfs.App.main(App.java:27)
Caused by: java.nio.file.AccessDeniedException: /lost+found
       at java.base/sun.nio.fs.UnixException.translateToIOException(UnixException.java:90)
       at java.base/sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:106)
       at java.base/sun.nio.fs.UnixException.rethrowAsIOException(UnixException.java:111)
       at java.base/sun.nio.fs.UnixFileSystemProvider.newDirectoryStream(UnixFileSystemProvider.java:440)
       at java.base/java.nio.file.Files.newDirectoryStream(Files.java:482)
       at java.base/java.nio.file.FileTreeWalker.visit(FileTreeWalker.java:301)
       at java.base/java.nio.file.FileTreeWalker.next(FileTreeWalker.java:374)
       at java.base/java.nio.file.Files.walkFileTree(Files.java:2845)
       at java.base/java.nio.file.Files.walkFileTree(Files.java:2882)
       at org.dcache.simplenfs.LocalFileSystem.<init>(LocalFileSystem.java:149)
       at org.dcache.simplenfs.SimpleNfsServer.<init>(SimpleNfsServer.java:52)
       ... 2 more

Please help

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

