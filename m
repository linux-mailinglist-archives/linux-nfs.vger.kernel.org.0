Return-Path: <linux-nfs+bounces-8033-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D9D9D0233
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Nov 2024 07:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760ADB220F7
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Nov 2024 06:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7217BA0;
	Sun, 17 Nov 2024 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWj0FUKk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F533E7
	for <linux-nfs@vger.kernel.org>; Sun, 17 Nov 2024 06:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731823802; cv=none; b=XD9FL9FhZF7cZLIFH+pYiIZn4L+A8h+q7Ry1gZ8/SABNuPknzt7iuFBCnCAZy1gpeCcmbg/k7Cud6OC7tY6a9JLeWHMVJv9LIlkeLMll4HcFFFMBhVePYoXEzzEsjAIK9FXmeOrdyzmsvyMdy/rn8I9v/JD9i0qlvdOiG6Vw57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731823802; c=relaxed/simple;
	bh=jT4jz3tQQHtYCHlHSQGveC8rQSe+5+kNf9o9LffreMU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qJULMqIX8fZW32SSgMUd/mYlI/l/jvFzc0UpRDiIOTSYdBZ3I+WoFOUXcvNab7a+2mzg/AfWnlIBj/j1HVqKG+NfsjmpIppRfnGOhmX6z8faXnS3MQYoXGuUfEGcfCU5yR9UzrJ7jWkucpnilNNAyGkitxGwkpVHvsY+xCK4LDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWj0FUKk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa4833e9c44so284861266b.2
        for <linux-nfs@vger.kernel.org>; Sat, 16 Nov 2024 22:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731823798; x=1732428598; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jT4jz3tQQHtYCHlHSQGveC8rQSe+5+kNf9o9LffreMU=;
        b=WWj0FUKk3kVT20TlhbKGIfMWsldPZuBHR2LMIsMbrc5LKZDBW9V1o4RL8SZa9CDqAh
         k7gumJH58opc0LMzcfhYT/F33K+PSZYdq3/DiP0zvI6qBGqWwHX+7g00d4f7c4MFzHMG
         pqEt4hNzwNRjKQQkjfKJ3GHYvryto84lSD27hq5V40RnD/BPyCNuRX2Q+y7cJErite4B
         DFjHLFDdP7EErVhaKrxAzsE45g1MT8+8A8K+8AjDPYFVaFjQ9fmJyKJgpMZ+yPKeuVWj
         qZPuYirCroGObQwkDO3WdUOt+/HvLbuWWosvVEUuPvpGYLZ5yj2oImyIlbkWOeRDJkdu
         X+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731823798; x=1732428598;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jT4jz3tQQHtYCHlHSQGveC8rQSe+5+kNf9o9LffreMU=;
        b=hRWyCAlH2akedvYwkgBOynfFEc6lb6aD4j16uqOtfYo9YZ5gSErvJmjaukmMPrJF4P
         UXhNVaJCENC0mCsD+N31gs3qjNY4+pa4S2gG3FbCJETPdQIZYRwKxv70dzUM/zc36PWY
         BnT3/FopWA7NlXR6fyXNqzvkpegHYFij6ALSuMb0cFQGDYs607wY4N1BrVHVJD5t0an/
         rp9uG1M5adHONWcGlThzrCsRvZ0lZSnDV5IalCPYjOnnS58l7iLmBavp9UV/2xbuQry9
         3OM25MbeB6rwTTYUIMwZ5gwHI/5WqG8gvGcYAWivULmu1ckbAzq6LvmvSkTw/IHtayIb
         GyDQ==
X-Gm-Message-State: AOJu0Yzx+/vPpSID9AqFg/mVeI4HQJjWTWYB9Vnox7fn6AjwQNyCn82P
	f2HfYeNS5K6fdWxigPf9j91rz9lkf8Bg/k7bYu/7+pVdBMkI+rbNopTSmAbHI30nMkRSrFS8KDd
	niRzA2UFWiEaF6CeqIWKqIgYKlralkRQV
X-Google-Smtp-Source: AGHT+IFR+6JNzFa/TV59IovBWw4fum1FiZZmm3a4jTX7wirh7dD3YQtT++KFPBKykZvFKmc+yZbGw4BkFGaYjQCardE=
X-Received: by 2002:a17:907:9604:b0:a9a:cee1:3cf3 with SMTP id
 a640c23a62f3a-aa483556d3emr741128766b.53.1731823797936; Sat, 16 Nov 2024
 22:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Leo <lijianze98@gmail.com>
Date: Sun, 17 Nov 2024 14:09:46 +0800
Message-ID: <CAH5FnXXZO3uUtJOndsf-LfwPiS8ug_oBnbj-VoYVG0CeFx8ejA@mail.gmail.com>
Subject: [nfs-utils] dependency issue with rpc.idmapd systemd unit file
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there,

I would like to report a bug with nfs-utils.

The package provides a file, nfs-idmapd.service, which is a systemd
unit file contains contents below:

[Unit]
Description=NFSv4 ID-name mapping service
Documentation=man:idmapd(8)
DefaultDependencies=no
Requires=rpc_pipefs.target
After=rpc_pipefs.target local-fs.target network-online.target
Wants=network-online.target

BindsTo=nfs-server.service

[Service]
Type=forking
ExecStart=/usr/sbin/rpc.idmapd

This systemd unit declares a strong dependency to another unit,
nfs-server.service, which is for NFSv3, while idmapd is dedicated for
NFSv4.

In case the user wants to set up a NFSv4-only server,
nfs-server.service and rpcbind.service shall be masked, while
nfsv4-server.service should be enabled and started, which renders
nfs-idmapd.service unable to be started.

I would suggest such a patch to have this issue fixed:

--- a/nfs-idmapd.service 2024-10-20 15:17:42.000000000 +0800
+++ b/nfs-idmapd.service 2024-11-17 14:06:18.028380419 +0800
@@ -6,7 +6,7 @@
 After=rpc_pipefs.target local-fs.target network-online.target
 Wants=network-online.target

-BindsTo=nfs-server.service
+BindsTo=nfsv4-server.service

 [Service]
 Type=forking

Best Regards

Jianze

