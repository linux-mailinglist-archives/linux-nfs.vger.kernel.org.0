Return-Path: <linux-nfs+bounces-12896-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E060FAF91D1
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 13:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A5F1C85A22
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADEA2BD5BB;
	Fri,  4 Jul 2025 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPgkd77t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF529D19;
	Fri,  4 Jul 2025 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751629777; cv=none; b=Zh55cSaKO8z3sofyQrC9xb/Sp6nUNUVdLTVJFtz9O3gOH5fvHnQcZfRfv/aFxetcdzNc79tU+AEIe6VZfhCwiRPjOHxxSqWmkLa67NKB3NAi0HwtSO4k8mSjsQFdB1W/XGHMNXr8rNFA9M5xPeSoc+LYSPxPXfgsojM4ApKY8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751629777; c=relaxed/simple;
	bh=WbVMk99qFIW2WBou+/8MlE9Z24auaP8B8x9QzyyCDbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Onbv8T1oBBdq6sc5qN/vTjI0FAaSIcfJyAvSvkDvFX/lJ7rPdV2HDMXDf5QYtLSmjEKQbMJOCWJGe3GpOkkrIO1YeHvqCWgnfUiTvmaTb1P4U+9qFnM9ilqdd0Js1kICWggM1FzRY/w5PRGvVLyWyoc5JzneFvo3ia9GV3GyUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPgkd77t; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553b165c80cso847008e87.2;
        Fri, 04 Jul 2025 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751629773; x=1752234573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uL1APji0AnR7xyAZbAGomZApmKQV24LYoY0rSnLFcpo=;
        b=QPgkd77tLw3vlIkuDcGuuyyXPRlD8ZbCBVpRgB2fV7fdLu3ZhnAPtvu1+z82b+CAVS
         8O/c678PMMvdTw6Fj8Qi1r7RA5GH2GMrUmFTytzH2PabFZ6YEodATgcsLK8MAWMCsb8V
         hpl1tRad4BJ83CEUjYoPeSJxX2sRIYZKuPM9ipthTDCtwYKGsdzHf0hDBrP87CoGEr3Z
         LPKzhIQIBjITKp5YlkLs/D7IddA0S/oxNGw+T4lrs96DvXj/jMyzdDrHDj/fsBfX2zdM
         hI5CIboNV7TTnwQL9HL2v4y37z1u4hiDgbeu+RrNxgQRyjUndx5hE26b28p2I7WbADRO
         s20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751629773; x=1752234573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uL1APji0AnR7xyAZbAGomZApmKQV24LYoY0rSnLFcpo=;
        b=qxQ0chQ+2GXKcn9GrtC55fndR3exKESKo9wqNO5UEMzZfUq4b4JcFd5qiSk63/IiAz
         NI1iYXn5eB6FL6Wj4tOkuRTJC/sPN+f2J3ruuflXURMthaxkQawk717vD5Arzg+FxHvS
         AqGkQOct6L6Oelmwv9tddIdqzvhUPFVJX5giCQD2fDljqUgwtbMJvTFxZ73tdBNg9poQ
         M61kQwLHbJfvsY412lZvPU2jHIRpohXGl31Uhbo5FgN4aXgStJ3os9UCruyEGxrdGNwr
         cgf+UkjI7gizAVA9ePu2LGs1BjfZxEqfvTBXjp/5YvZoaOtLY2XS+VThyVn9hfOSB5q+
         pvgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4yA3NMFtltsL0YWI599TxO5qSSwS3fSV7t/+LwGpinnhxUuE0DdBFAAKKd5akEAFyb+GFzG/nram0sTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhodZEbkjS9csFiJ7Qj4l1DMu2S1B2jR0u7espe4pAAhOtQ1T+
	TK04FRCWjSj5sja+jelGrFHH/uihc0KDi22wU5ywrZrU40yhS2WVJ9tK
X-Gm-Gg: ASbGncuaXXC0PFBMZ9HcBSfKTK4oL8Y007IiDngP1/Nu0DloC8SV6mLu2M9wm4TCfsF
	mjSLDY2Dl0lAu0f3/hx36buCidDbpnpeuA8FZchNGibFSZHTHzui5tCdzOQ/g1BGzE/Yza7TSTA
	xF0JojWlX7lVbzBwQqf2eAFKsOaChNG9WCixhVP7iWLikoq98beoJ50CBQ0+dgjD0pOCGFQRRfr
	lrbol4NMQ9rzxqbJ7Lh5I9zSDsbx3Ega7xr1VRvHPsWvHfEkiw46wHg/NXYX4OqdxhvoEKOCp1E
	uJEyDx1DV+ecgLGIRSwSvSPE6vIlHWPT2ToIZCvyGsGWAfCkoVU23zNL7pLCDOE5FyqngAaSgsW
	JGd2Z0zml9AA=
X-Google-Smtp-Source: AGHT+IGejGjoLF6cLpibwMGeaqk1PPYmZ7OlKl5jt1hKbchv7zW0ACiVoLzPxh1Vl0Mvm6ewZtALtg==
X-Received: by 2002:a05:6512:1155:b0:553:af02:78d3 with SMTP id 2adb3069b0e04-556dcc1ce08mr549196e87.25.1751629772608;
        Fri, 04 Jul 2025 04:49:32 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.70.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55638494e1esm231109e87.89.2025.07.04.04.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 04:49:32 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH 0/2] NFSD: Fix last write offset handling in layoutcommit
Date: Fri,  4 Jul 2025 14:49:03 +0300
Message-ID: <20250704114917.18551-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches correct the behavior of the pNFS server when the client
sends a layoutcommit without a new file size and with zero number of
block/scsi extents.

Tested manually for the pNFS block layout setup.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
Sergey Bashirov (2):
  NFSD: Minor cleanup in layoutcommit processing
  NFSD: Fix last write offset handling in layoutcommit

 fs/nfsd/blocklayout.c |  2 +-
 fs/nfsd/nfs4proc.c    | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

-- 
2.43.0


