Return-Path: <linux-nfs+bounces-185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA737FE7EA
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 04:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF0EB20E54
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 03:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA56E101E3;
	Thu, 30 Nov 2023 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5Isabnt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A1798
	for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 19:59:14 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b88f2a37deso319724b6e.0
        for <linux-nfs@vger.kernel.org>; Wed, 29 Nov 2023 19:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316754; x=1701921554; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OR4nFx8hBywb0dRM02jccvTcqGGI3FZZV7emz2FdoYE=;
        b=D5Isabnt0rpmzuqu3dZFyqztKDBzOW3z3XnY0peTFZ8RXvOcP2KbBm6WBw8hk1tJYt
         afGEAqDV/zMfqq41Lfz+89+cHuzMrS39FF1Lx1bjWbe9sSp2mYc0wva2APEoTqTIIRTV
         3z2McfZEKG2kxH8km8VWpdtxm4h1lvhAlYvusfycTuvNgBOqvz84lN0GbdueTqhJGNjt
         LMoPq2vDAVfen5JzledKUt46IyxTCHdZxxtCxXEW6TJdcJbAZ9sSMGUi+Cr0Tj0neB8P
         7L26OxX24Do3hfxrSWbidgr+nTFk01FIOnBL5qNM5athSEXQg+RJmBOJQMsUcraPtGu3
         /8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316754; x=1701921554;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OR4nFx8hBywb0dRM02jccvTcqGGI3FZZV7emz2FdoYE=;
        b=inW+mUuNIy50WsUsoV3KcMoKL0cdzlOR/k6H1jUNXSZnpo4vpzjLWgeBcllurNx4u0
         yQbA5V5f/s4+/2nL+zHVHnuMz8DZUHfgT5p8daYEViRTCIBWVeVQiQj/2jCQPv1oDxAH
         o5bX9lZr86EYo2klxypYL0TjDCkTL5YjQHdKwz5NaqUYQtXKbD79oQk+xbCtrz0/19o4
         KnToSdQgEJQ5Krl2wl74m0OPyP09QLamwBHsAJxyUPQsstrgTv8CJUwMIed84omlmpzG
         U1fPAtU1a+19UK5tXwtvpe0nAqzgUz2+yjQi+FoZKckF2nEB9jpjWUtz//aiyxEwviKm
         CEgg==
X-Gm-Message-State: AOJu0Yz8cpNQ5B1i6CM0EENqeHqGw8YQ8H2+JKAdZOc9OF7IGe+1x0Ml
	wqaUojOQWSi8sBl9WvnX2xJYXquDlbWJxDRGcW8bJAlx
X-Google-Smtp-Source: AGHT+IGR/iRrfu4OPeDq+GJRgylCsykiZ5iZs+kyzLH78Yyc6pblLRZUAmMQI4wY6Bwk03GmgruqmpsUQpUeBQEszDM=
X-Received: by 2002:a05:6870:3c05:b0:1fa:1ebc:df4b with SMTP id
 gk5-20020a0568703c0500b001fa1ebcdf4bmr24230423oab.28.1701316754032; Wed, 29
 Nov 2023 19:59:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wege <martin.l.wege@gmail.com>
Date: Thu, 30 Nov 2023 04:59:06 +0100
Message-ID: <CANH4o6PeiV+ba0uLVzAnbrA3WtG8VSkvjA1_epfLCVyH-r-pJw@mail.gmail.com>
Subject: NFSv4 alternate data streams?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

does the Linux NFSv4 server has support for alternate data streams?
Solaris surely has, but we want to replace it. As our Windows
applications (DB) rely on alternate data streams the question is
whether the Linux NFSv4 server can fully replace the Solaris NFSv4
server in that respect.

Thanks,
Martin

