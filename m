Return-Path: <linux-nfs+bounces-13080-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4237B0630C
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A5B97A7EAE
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E01922FB;
	Tue, 15 Jul 2025 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVbf29qW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205E137923;
	Tue, 15 Jul 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593624; cv=none; b=D6WauP2jHX58sdSC68mIg5KisjOsdJ+NJS1dS3hpsizMPjfpGiBmxIMr2HvokL8PBDV/Pg6egLIMShtOQo0R8E8DTL2SyTkt8+uuBG2zMM5uYip9w3oI/3r5BdELRrrfT1iNo6wIWiBikup35LL9SI+33eXL/gebbd7Hbf3YC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593624; c=relaxed/simple;
	bh=8IziRa7QYaq7WSGWJLaDCatFVb/HNU86juxjQUvlp7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmI5ovWu2oi4UhkbBPXapJSg0G3WQACppSWKtGH4hadHzaWtJpKyywflJAk9EYtPAXQQjx3hzPdrqn2oCO0a8EoIaiYq9OBPU0LQIbGEIaAQDeBQxkZzKeliNSsYN4xxOhg/FwTPFSlVLR4F7QN1plv9YQCeolAEKY4wYmMNFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVbf29qW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-558facbc19cso4430826e87.3;
        Tue, 15 Jul 2025 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752593620; x=1753198420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKgKH5pfscs2ZBzdpzCDQh6TrBuIy96Wf3PnVmY4jNo=;
        b=nVbf29qWnB8KEFG0xWFUUNsRnaxX5OGzoSPe79t7S/dON3RUImzklN1sGQusDGzEAI
         O6aueNFgxfZL93rB5sgyqiN7SDm62XiKqwRjqKdFCHnQBdnKrEDBBRzI+1LEHaHBNStx
         0bP3MeCjV9z2kh9oUMZERVQ/iCpZn4Sb7NiSX1RLKUI24NHAvhe0PmKVR8mhwjhPRJhP
         lcfvbk7xmhd8qi8s82ReWrx619alvYt+hc8NC1p+CBjjK0YFSevJZHha6QgHVwjde9Js
         CvwCCwcB+JRTNRavpQsebKM/MhOoY1oLUFjuVk626HAwdbj9HRMHY7mGoDJUBYZ7QDz9
         B9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593620; x=1753198420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKgKH5pfscs2ZBzdpzCDQh6TrBuIy96Wf3PnVmY4jNo=;
        b=WjWN0FeS4lDVBFkeL9M39wnaTu8WAc/K6pg3USTGZ7Ta0S8eENsD8gfar5Q6hA8ajR
         FTn8RItfreMGKasyV2lN6tvF755VfCsOcrKLrx4HxvbMiwEqvlh9KN86cFbtml1lJeUu
         7fScU0OFNomQ78ZF0O+2m8PsUEH5QxOtzKkvAQkuuXGBpCRoMwpm/fWkqHh3Ivz/Lik6
         wqrLqaBdIu1M0yUDhZoPvH0o+7qOqeqT7RdxbGDJltWpQCVYHnLSNbiPz5ikAH49E9fs
         JJBvrtkm8Bqn/81LeJPAtJMUzBqHmrS3H9oD7Fukh/HdHOCcSrHjHssAm9uzBftUPBfy
         C6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7SfoCkf76zFLUVAbDp+FwJDFGSAT8rEUWBEMArSIB6N/x4WKGdcOaR3ehMGT/WAeWPszoA6yonan3KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBefgSON9xIbn/alt01sJ9spV8m9lv9il6XMZ5nUalSgrJZdPI
	xt5QHNY8VXv7DHBebsjC5p9QEgAekokv8tEs9E/hlGRQI+aS5qQNttc3
X-Gm-Gg: ASbGncvzTczDQOMtjrxqyO7xOEzzo4tSlUVKNLcB/9TeKrJP3DvHidyRhEzcv/o3+75
	MrW1hzo40sgyHSVL5T+FVaaKvK6y3yv+aY7dmuEXgSnGT9237MuQ471jGosGczJD/s4GY+ZOjkn
	YYemRRqw1qUwl63wiZgL3ace5rUNNJ70ec50m5rubwPhDH0Hrg8+Mk+q/hZG276lfPqs97rABVw
	yFMEVsO2JBhXPxBo+k2iRog00Y6EiUNCxFdCYDm1WVmJmNF3dVSNEt1sjaUb3coNB7GuEvsNdYc
	6c63af43jp5Qm3ffwQCaxoDuV1T41+qskHdw7ZOKKD+VeLWTHTE3K+hi2l6ci0sbv0InhKeSbMT
	Lnle0ZgOVmC8NDgcXqtD5bJwhkQnpB2SCZU/tSbBdTCyRhEng/pY=
X-Google-Smtp-Source: AGHT+IGsQSYGbVGhel6OK6JGXp21aNd3R6Vzv4g5nl7oty3Vuy3eSu3WHWtX0383dsY/yjMQ7K1m7w==
X-Received: by 2002:a05:6512:3508:b0:553:ceed:c85f with SMTP id 2adb3069b0e04-55a044d718bmr3779535e87.21.1752593620185;
        Tue, 15 Jul 2025 08:33:40 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.192.104])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7e9c7dsm2316482e87.64.2025.07.15.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:33:39 -0700 (PDT)
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
Subject: [PATCH v2 0/3] NFSD: Fix last write offset handling in layoutcommit
Date: Tue, 15 Jul 2025 18:32:17 +0300
Message-ID: <20250715153319.37428-1-sergeybashirov@gmail.com>
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
Changes in v2:
 - The first cleanup patch is unchanged
 - Reworked main patch to guard entire new_size check, improved description
 - Added cleanup patch to decode lc_newoffset as bool

Sergey Bashirov (3):
  NFSD: Minor cleanup in layoutcommit processing
  NFSD: Fix last write offset handling in layoutcommit
  NFSD: Minor cleanup in layoutcommit decoding

 fs/nfsd/blocklayout.c |  5 ++---
 fs/nfsd/nfs4proc.c    | 34 ++++++++++++++--------------------
 fs/nfsd/nfs4xdr.c     |  2 +-
 3 files changed, 17 insertions(+), 24 deletions(-)

-- 
2.43.0


