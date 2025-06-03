Return-Path: <linux-nfs+bounces-12084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB9ACCFF0
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 00:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CF116AEC5
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 22:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404FE70838;
	Tue,  3 Jun 2025 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS0L9uvU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99B4B5AE
	for <linux-nfs@vger.kernel.org>; Tue,  3 Jun 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990314; cv=none; b=le56jX9PUbHvnuyZnUsJ8IAZZJfX97Y5YjBSILUcz3Wa7ZzOpL/wdjlB9sVIAH5UDacEmnIM2zua5hXvmVX/DSRZZzYPcErntQdhKAPeVA377OIeuWduNvIeA+F8Xwc2vx2PF5one0c3ucWsdZnEuIEkwcXTfwoCCiDCxCzWM7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990314; c=relaxed/simple;
	bh=dgc2ysJW9aqSOLmnAmhWRI9jtngN/VmgckKcPLuqmlk=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=QW6dIMHzEFPlFcPRTeleZCBeVfpCkvlawBw2TMlmJ9z5g5fF4vW3A+jPlCH6A06CO7kOVxFxpw9Sbrzi7kHxlo1m8K4QmRw6YZs/dMFEPbucER7iyS0Twr6qZSVMsho8R1GqkOUYtIlPvVqI5y6VTm21MHC497fPOj93PTGjzKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS0L9uvU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e09f57ed4so3364765ad.0
        for <linux-nfs@vger.kernel.org>; Tue, 03 Jun 2025 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748990311; x=1749595111; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgc2ysJW9aqSOLmnAmhWRI9jtngN/VmgckKcPLuqmlk=;
        b=OS0L9uvUsoKUWb3dkgebSpRv1+4KGcN7PCp05qHPxqTB7WHS7lK4AeKcV9nGJQOO90
         V7cLd1jwP5nLf/2OALX7hCOOSM78ec+/bTcfzuWUz1lvg4b88SsaurhxPaTQYOqa6ToW
         oc9nP+aNrK6QzAR4M03m9os6o+dlEkC2+gbXxrflm94V6nziOx/ckuVmyvZyK6hsVUq6
         hHiAIt4nRl7Jltg9Iy3FjHdhTPeXGJcf0Sj1GrN36vTHi/X8D2CRPYjr2OUixBXJylul
         w5WDLuo6hlQMM/PRFAIbIwRUDuVu/3qgdWOxxrEfFTinh3Y/e92fNyv/S+SMVGuM5NXa
         1CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748990311; x=1749595111;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dgc2ysJW9aqSOLmnAmhWRI9jtngN/VmgckKcPLuqmlk=;
        b=Ybyvr2UiKIQn5eD2GsM27nKukufnpxe4zIITKV6aRNRnPOfUWvdCnEp2y/dGhqKfsk
         QKOBQWfo+rzSwUJ/JRwj3twHFUsTijzu2Wn69MDXmNImrw+SOU55+OFw4OW3GZRvZ/M2
         5d/NaweolPDi9AgdH5oXDOn1qkscUq/v7uko5rWpn9kKkeh5oYg4WvLdQtwOely9tHq+
         +X+GTjdJZK2g8vI7JzVBzJl5jTEqpUzoPys/0dYw4b56+9HZe8bdP1t17ECQ5B1usoyy
         vjvW/gy/GGuiWUtljqakL/Vzzo1aYWk+LxWkBeSukWiCxW5+j00XgaAVJ9mGl1zx/W9d
         5XEw==
X-Gm-Message-State: AOJu0YwUbju7oi3sw1tLSOYfyGahteFrRU3bD21C8EyYC5tRRO0QwF5I
	zrwQMkMcJO0DaHC1anBfW/nN6DF+LaJsrprm2v+pR0KOJ3b4H3Qch2dVZo9Qpg==
X-Gm-Gg: ASbGncuf7RUj3yodrzxRs+2rQiBbURbLLhEsx++czj0JWzfJ99WfJUxUwHQWtCaSxgJ
	RzPoakJW7Obd+sCz+xjgH+xVa3jQHXs3HctJBxz6Pcj75gESJZhfmgh6tthMl/ug7XUzmWRdHfN
	nnV8uvHxCoKNgZwK2EnYYh+l5ABxWneD18irhrpaA/3ptVnzVxts0l3XZUGa+jGRiItP1N3PcE8
	YuNDMrI8X032VOQwbbWACtrcgCN1kyR4hxhaH1vE09ba/vEW8ybkHPgcEymU9XDaLDKgTxM/PSh
	qL8x41I27IXHbYcRwMWz0b8xGvz9x1YS97mM0rxMUbFtaJ66oYVS54gGiCVYHK+9BItBmUfBKnk
	Qz75iPNpzvzxla7YBKXeyHuvvWO7+
X-Google-Smtp-Source: AGHT+IFlWe67JJqI/REbqdWzdijR10mTtmuEnVv2t7O2Y5SH/yfy6lTIgkx5icoRu6domWIVR4E/9w==
X-Received: by 2002:a17:902:b487:b0:22e:491b:20d5 with SMTP id d9443c01a7336-235e0b14a17mr6655705ad.26.1748990311545;
        Tue, 03 Jun 2025 15:38:31 -0700 (PDT)
Received: from smtpclient.apple (syn-076-088-087-014.res.spectrum.com. [76.88.87.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8537sm92295515ad.26.2025.06.03.15.38.30
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 15:38:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Anthony Rossomano <trossoma2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 3 Jun 2025 15:38:19 -0700
Subject: Path for rpc_pipefs
Message-Id: <B7AF8E7A-65BC-4DF5-A590-00E4B2F0B5D5@gmail.com>
To: linux-nfs@vger.kernel.org
X-Mailer: iPhone Mail (22F76)

I wanted to get some input about changing the path to rpc_pipefs mount point=
. Can this be done and how to do it. The mount unit provided by nfs-utils pk=
g is cfg=E2=80=99d with path to /var/lib/nfs/rpc_pipefs but you can change t=
he path for dependent services in /etc/nfs.conf. Can a new mount unit be cre=
ated to change the mount path? Env is Alma 8. Having trouble because mount p=
oint is created early and need to remount /var elsewhere later, and need to d=
eal with the rpc_pipefs mount point. Changes to systemd dependencies are not=
 panning out. Thanks in advance for any input=

