Return-Path: <linux-nfs+bounces-794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293EE81DBB3
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 18:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4951F2150E
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 17:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03762D267;
	Sun, 24 Dec 2023 17:29:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567CD262
	for <linux-nfs@vger.kernel.org>; Sun, 24 Dec 2023 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7ba8c218fe1so159235939f.3
        for <linux-nfs@vger.kernel.org>; Sun, 24 Dec 2023 09:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703438993; x=1704043793;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJZTCsVUE6Bcwd++TYbF+QDAB32pVlzTwkeQqcBSg1s=;
        b=DF+Itxn6TM8iKD34bJQpZmn/ciqFZqf/8gtGiRI16nxZfYoOXky0ID5U8Y7f2u3U8G
         QV3CGuAvm2ZjITBs+pD6RJ8jptkoYBzAmi5b9WQGJZ/psx6WKyXt+5L33ZhoH7ngyf9m
         Yc4WAFPi6CrqhBrg9yXgyEapioIeqS4zkSysToC9TqOeIYmQbjd4TH49Bs/fVdsDvGDB
         P7lj8IsXrc3PF4B40SwsqKHFkIEIC422c/7p8xegaGizBgUa/yVIILK5yPpY3A623v3X
         /d4p2OrZNhWgn91XyXTwSApYb+ux7SdMww+g1ihuqrZwxx5diCcH0SXPMRJ4TNHUkqKL
         C+mg==
X-Gm-Message-State: AOJu0YwsRKj+nzDKA0ubdeP2cVWJPfUyA+ELrMh8ESc8u0jY8QFWzVOh
	llq/xLCMBx4dAkjLKaUxB8hhLbHOWKXplCKiJPnWNMYKZ/M=
X-Google-Smtp-Source: AGHT+IHEaZRNtVzv4OGj1HvzZNagWSItWB6zSETggPg/0k0CKYV659yp7ZttAAboSHHnmUaIejav2E5LSqzAeLToUB8=
X-Received: by 2002:a05:6e02:180d:b0:35f:dc48:9153 with SMTP id
 a13-20020a056e02180d00b0035fdc489153mr4389025ilv.57.1703438993417; Sun, 24
 Dec 2023 09:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Sun, 24 Dec 2023 18:29:27 +0100
Message-ID: <CAKAoaQniGNGuPm5CTTs3oJRuCH40HTt6K91nCAPRnt0tECxkBA@mail.gmail.com>
Subject: NFSv4.1 mandatory locks working in Linux nfsd ?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi!

----

Are there any known issues with NFSv4.1 mandatory locking nfsd code in
the Linux 5.10.0-22-rt-amd64 kernel (technically the Debian Bullseye
RT kernel) ? Is there any kernel or NFS test suite module which covers
NFSv4.1 client mandatory locking ?

----

Bye,
Roland
-- 
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /==\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

