Return-Path: <linux-nfs+bounces-371-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27392807A82
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 22:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB96B20BED
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440A870964;
	Wed,  6 Dec 2023 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJwKrPYd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC9D5F
	for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:33:35 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4258ca2ee9dso78251cf.1
        for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701898414; x=1702503214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GGkFOHXTx9A2Ch/09jIUlLvdwbwn/eW0b7s9NeYsh+Y=;
        b=eJwKrPYdHxiUtU92MJQipM9fE5Dg33k6kU3t5aMA1c9qPK6MsYdDFmTefMQNPUcSfb
         lsxhwCxrrPtU73PL668CidJDmU+VMqJHfIXZ7GSgtH15F0gBupExiNoHVAn0k801OIbz
         b/gK0qEr+1XLy67S64LSFtXdDYE0sD6N+MG4yuCTGAH7Q8Bk6j26TPwiuxRILjb/HttL
         r9B/enOdlZSJYEhbh6353ILjv/PWNLg2ot/+6wcv+AInqhtsej0jAbvql1i7sc54btkW
         j2WLvZ4zOV1xlF2Dx1gTKEbAzHP0uXy6R6JMbjQu/Ex5KQysLc7e7FTB8wU0T/EWo1Uj
         LzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898414; x=1702503214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGkFOHXTx9A2Ch/09jIUlLvdwbwn/eW0b7s9NeYsh+Y=;
        b=h+dptZoFlgyHLMVMbvbhqPseFaKpOFr2MS9HQ1/I66wlRRJkoqWAMzfc6/GsGcgOWS
         e7opypcP4UOfZVHcwWEcplHi8897kzEuIBm1VDSDw0pH+cXBqWa94DecNirqjn5s7jql
         e1X0ayZT3nTgxlKzVkDO5tUnLjnljLF4DRP+rtn9Ic/xVbhfW6RJNp904IOrOC57xHHD
         v/FdpnR5NoxvXvc0PV6zwk8fTIqmAE3XHPn304kvxa+2KIYXgPf4xq6ZDo7ZpRETEJEc
         pUNAWK7IPPr03zw+rcsPbOawF1C23q7R/D74PLOc535wRjg7VYy2f+LiKM7tcz1SKFOE
         G0kQ==
X-Gm-Message-State: AOJu0YzuF9Nj+vFLi1dVVRgFGGyrvPoVeUm0861DUkQPjWghFa7+Hsn2
	r4bFgg/j2iNvmQFlUs/VdK8=
X-Google-Smtp-Source: AGHT+IEP9MEtdL054wifuR+sgqNjgmOFC0RiYpAq6nX31PFfqiSK71nlcpd4aud++WruKKcfhkspDQ==
X-Received: by 2002:a05:620a:1919:b0:77f:2baf:c969 with SMTP id bj25-20020a05620a191900b0077f2bafc969mr3003696qkb.6.1701898414060;
        Wed, 06 Dec 2023 13:33:34 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b])
        by smtp.gmail.com with ESMTPSA id ro3-20020a05620a398300b0077da601f06csm256435qkn.10.2023.12.06.13.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:33:33 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com
Subject: [PATCH 0/6] nfs-utils: handle BAD_INTEGRITY ERROR
Date: Wed,  6 Dec 2023 16:33:26 -0500
Message-Id: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

This patch series is re-work of the previous patch series that handles
gss error for bad integrity. In this version, gssd is changed to use
rpc_gss_seccreate() function in tirpc which exposes the gss errors to
the caller. This functionality is further checked with configure for the
presence of this function in the tirpc library.

Note that the current libtirpc (1.3.4 version) needs a fix to
rpc_gss_seccreate() to work correctly for the gssd that passes in
credentials to be used for the gss context establishement.

Olga Kornievskaia (6):
  gssd: revert commit a5f3b7ccb01c
  gssd: revert commit 513630d720bd
  gssd: switch to using rpc_gss_seccreate()
  gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials
  gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for user credentials
  configure: check for rpc_gss_seccreate

 aclocal/libtirpc.m4    |  5 +++++
 utils/gssd/gssd_proc.c | 26 +++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.39.1


