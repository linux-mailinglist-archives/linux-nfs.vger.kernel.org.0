Return-Path: <linux-nfs+bounces-2444-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7BD886B1A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 12:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF73FB20EEB
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Mar 2024 11:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21D93E479;
	Fri, 22 Mar 2024 11:12:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429052C18D
	for <linux-nfs@vger.kernel.org>; Fri, 22 Mar 2024 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105932; cv=none; b=G6PzIf8m1u+EJZs6jmQVzeZUd1Z1Rm9fsI8MxT1WwUSQMlpK6K5+X78iFxsLuNvmuCsIx3r+putYXiBtcj/NzfdO2tNChi4a/WZC9ENfYbzavijZUotKBGaSWPB30uD9cptDn3M7s8Hxc2Qg1Q1no5UOUyjiVypXRI2ilNpSDVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105932; c=relaxed/simple;
	bh=RgBbbNkbozIabxUf1MlfWYF5e6rPzi/qZZ+CpipG9Sc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IrLanwJV+GJFrl/Rugcx6SlewjkirtMhyPNZpwbgaA+a4zN2Axr+i2CH/U+sbhW0aCrSUoAXYzovPu9GzVAyAay2w35ikxibY+IbJfy+iqw/p1lj7kT6OQbmoiC/lGznnxuoH+BojG6gXsXB1IxxRn6HaGcsA3iteixcg0bnUII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7cc0e0dba0fso90813139f.3
        for <linux-nfs@vger.kernel.org>; Fri, 22 Mar 2024 04:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711105930; x=1711710730;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUiz6c2TOvIW6KjtWKbc5iglnP1LjFnxas45yidAGU8=;
        b=PT+hXIuL73/HX2y3fH3evrP5NhZB93wwo2eRzvb2o4S1RJGc0hBZ6J85weWYLmr/k6
         IJ3Xqs+xpKYxqsE3oa0pRyhOZZjq9F3OFxNZNq/psys+N8nLsy8syBkM6Arr+SJ+497y
         rgI3JMU5O1btWpwMMicBGCCpkFJjQ+rUzbcRZBzKljRf1+fBPK9Qon2zFNwHvPIQ3QRI
         i4ZX9wAHzThzXsqhY7tLNy9p9vAUw6eb9Jk0jqkc8NsaAoJf9mgEixuzRYhjzPli6jeA
         HhPacz8SUuI3ELF0YO7jQJK7zikUe1wC84gjxALwlwt32dvCuABBTD2NGCMi/k4AfE1/
         SHaQ==
X-Gm-Message-State: AOJu0YyJCZQxL4375JTQv6V0gbRaE7bdsp/VBQaOfwfr06Jk0RMqC5DE
	CHCj2j1rs7Mg3o7mD93XgpbLMIF3c/Pk87IkAOBYsMI9ZYSwqiH6rTzJBnQmIDHKcitw/tlCz1W
	+CCJ/Dr+h33xry1ghO5dTryXpUVpVgiQ3PY0=
X-Google-Smtp-Source: AGHT+IGpoZrBDvi6QyXGC5QTYlDrw8llVT66uc093h0+iGxEeik9uamUa5yN7StX3nAJmfzFOPZy/vzRJjrDLXBPFRw=
X-Received: by 2002:a5d:9c59:0:b0:7cf:267b:fc22 with SMTP id
 25-20020a5d9c59000000b007cf267bfc22mr2331296iof.15.1711105930083; Fri, 22 Mar
 2024 04:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Fri, 22 Mar 2024 12:11:44 +0100
Message-ID: <CAKAoaQng8vUV2uHNwNxhcL-d17ULPqO0iCSUmVKHunfSaHLMTg@mail.gmail.com>
Subject: "svc_tcp_read_marker nfsd RPC fragment too large" with Linux 6.6 LTS
 nfsd ...
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi!

----

After updating my Debian 11 and RHEL 9 installations with Linux kernel
6.6.20-rt25 I start getting the following error messages
"svc_tcp_read_marker nfsd RPC fragment too large".
Client side is Linux NFSv4.2 client (Debian&&RHEL, both default kernel
and Linux 6.6.20-rt25)+ms-nfs41-client HEAD.

Is this a know issue, and is there a patch for it ?

----

Bye,
Roland
-- 
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /==\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

