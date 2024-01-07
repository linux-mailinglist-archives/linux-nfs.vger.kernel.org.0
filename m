Return-Path: <linux-nfs+bounces-966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D182E8264AF
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jan 2024 16:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F13B21290
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jan 2024 15:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD7A13AC0;
	Sun,  7 Jan 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftbWgSH6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BC613AC3
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jan 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e766937ddso1044981e87.3
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jan 2024 07:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704641092; x=1705245892; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/f7ZGcTeGJHQfg1P6evPzWs3pF5MtkfEJBuCM5v9SbU=;
        b=ftbWgSH6+4b6tFD5fOlvQEw4qUyGpdCJjQfG77sC6DIc8AglM3slF8J54e5Nc9nrkH
         LFw41cN/QF+ox5syn+4WlCeRXGcRtkhNLXAT8TF+8bOwxWli6/Rqe7koF1zYS0UA3Gtj
         LSQJO74/IfMrqRjxkRGn801sKhAxD6BP81X8T7uIYSUH5Cnpb3Stj+81Ao+edv3jC6yz
         ZxjM4dd4yAluUncCigCooIUQAaJQ8tuIvWu3BgazElijDGbwfcBPYVuWL6c+ss3bfOXL
         Az8Ojf/9MbemrKSfWmZx0m5y0uCnxLH0Kw2vwlMgg69knbf8MKmxNBfPLucv66azqsoO
         ixmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704641092; x=1705245892;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/f7ZGcTeGJHQfg1P6evPzWs3pF5MtkfEJBuCM5v9SbU=;
        b=llzCGVWHgwDnw+ezQ28F/G4MlFnFBE5iB1hiIBb/kiTzCbcEntweNYqjxeFnKI0c2e
         mDe32gfX1vUGar1Cf4Z7qU36z7LX6OA3PgJYnpxliHzFNyFiAFTMbl77rQfZ9VHV77ZJ
         xnzWVDzTXbzxur6AuGx/ZcgcuvIN1xRzKNhPD6ha55OFGZcD6Rgc2AcwqN6b6nc3SxsO
         ZxPMaXwNTzPzvAyLbkcaZvVvYz243K8jzVCanJcKs5Cj+tB9zX+iII50rLAVOD/zAyXm
         v9omaEVlUhqFYsl3e/+2IxLKzJkt9HzyD1WKyCLNUbTF1twpt9h+AN0aEWLMcBoISxhp
         XgWQ==
X-Gm-Message-State: AOJu0YzDf8KjiFB865nlMtWEwr2pSKuu+bHxMZs3VUuNbrrm87TXR7pJ
	WAuUSp2yhlA3/eRjZe+7Il+m3bdPGYqndMimL45bRNKftNMTNA==
X-Google-Smtp-Source: AGHT+IGqOZxVuEiKGkbs/xhBjzDJQtiFbxjW8yDlzjj8L7z30IHB1f4GkP4ZHA2M1wId/4N6fjgU+chzDrNDNPC0h8E=
X-Received: by 2002:a05:6512:4cc:b0:50e:3e65:5f30 with SMTP id
 w12-20020a05651204cc00b0050e3e655f30mr823948lfq.125.1704641091990; Sun, 07
 Jan 2024 07:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Sun, 7 Jan 2024 16:24:25 +0100
Message-ID: <CAAvCNcAAE0x4wJ0mVJ0b-7keSv3g=cFQf5o0yEd6-pMq35AzGg@mail.gmail.com>
Subject: What are nfs persistent sessions, and how to enable them in the server?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, ms-nfs41-client-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello!

The ms-nfs41-client brings up a message about "persistent session" -
what is that?
2388: WARNING: requested session flags 3 received 2
2388: WARNING: we asked for persistent session but server refused

nfsd server is Debian Linux buster, nfs client is ms-nfs41-client
2024-01-01 from
https://sourceforge.net/p/ms-nfs41-client/mailman/message/58718627/ on
Windows 11.

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

