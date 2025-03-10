Return-Path: <linux-nfs+bounces-10545-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BCFA59526
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Mar 2025 13:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3B116D11E
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Mar 2025 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F3435963;
	Mon, 10 Mar 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="cRuL5VHD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE71227E99
	for <linux-nfs@vger.kernel.org>; Mon, 10 Mar 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611140; cv=none; b=EiLEJN/RBOk4NrNF3pBnAbm3ewO3OUKf19AeAqoCGKRdGZhUD9RB7IyqE5odrt348pPuL74VB42bMwk6tQ22FhhsfX9mRcntKVeIXaZPW+yuzHHqcawC5hVmMtyxWU1HbSm2tHco17sOT8lw86fVBP8qql7VVheewKFngKV67+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611140; c=relaxed/simple;
	bh=eo8niHuNp1QPkRC+8VHeCRb7NBZ8f7c+023KrJxzT2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldLp+mg6b5R4TuTw9w0CZnA2/sSDNPjKGRyi58Q9P4SL4GCoWLjBwUovNudeSImsz/opPir3j65g1EDjOSVXJ30B7VEr0RNopiq7CniIaLpLwoxu0uIK9uaNnltfOtGn5HRLnciJyPdmtfXzXBisYoKyiLHWzDySQWIFZzLpxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=cRuL5VHD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912c09be7dso2231654f8f.1
        for <linux-nfs@vger.kernel.org>; Mon, 10 Mar 2025 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1741611136; x=1742215936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbvPBXjPkU/vWTQyJKU3YYiI8PPNp6kp3AITrSiEcko=;
        b=cRuL5VHD5sUsp+xtXNI4kg2zfmv7CbFvrygtnG6XHJDkK9zNlrmEghfwEtq2VPl5GL
         RvOP3PcjM4Dk0Y4N4rLzmf8dEyuITFyEV00lnEF/EfB7v5TDCjv+Va97it2veXCHDtpJ
         BtZVL1gY64Fg5SaLSMsX9pvevRKaretK3xPDP/XXjmm9XTCFpKJgTdpG8O4ftZhtrSY2
         p7/lVvu9FgcIMZkUT2g43STUhIbh0Hz+ny77q4HzWBWwPjrBnfUvy6U5kP4j6yNxHGUP
         nsSN1u/wRMhtE8IbG7RfLFkirPBGBMgVB2Z48AMICSDQCX20YYngaOQswWB+VwbniWOm
         NZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611136; x=1742215936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbvPBXjPkU/vWTQyJKU3YYiI8PPNp6kp3AITrSiEcko=;
        b=QsHlp4HgVofRsH4A0XI8O6bHXtzdULUB7yCv1RlVgUNsz/oBgslaRYI6V3Bkcyr49U
         jvZDnoYfg9AmqjG4v/UBqKyNe1C5u2ul4AyiGV2LunOspIP4e9agrnVh8NwuF4n81Mee
         m5PMfPqTyj3BzSWz8nsm/EdY03PrMb/LZFmrF4vI0MRGkyH6NG3G5/fU8QVoaENzjXMB
         n7I/Fac/5uhfxiO83Lck3Q/+mN0uut3/jYbAEUV6iKZ7CJs+S9Z2Fxg4Yd8UcQvzKRKP
         IIToppgg5D8jC7s94XVYtKsBn0+ujqvzZQK4Re/z/5Db7INPpp3u0Nersj9lA4Yf/T7y
         OsMQ==
X-Gm-Message-State: AOJu0YzNk6m/lO9fE3r1+IM+vpJA8RWbTM78hjUmIdWdb+6HoFcYv2Xc
	jmsmuQCHkJVZKMv73AsBFRAQolKtCxbghpKdNX07o+cGsvVp5Hw3DZ9OG8vUGPU=
X-Gm-Gg: ASbGnctmfhiMeR4e6JN/R7aHaflHzBSUeMSntf07m/psp1DmS5jtLxQELxpC6cpUJ7V
	4MhiNV1Tvt2DhSEukSBFu+YpZ+/Qqfxx0aYqU+ot5x54r0hi7odJsNBCsyIeIEKrwZP0LJRY3R3
	IVKwlqgzgUIte97B1/MhXRKdpILxZLYnVjaanyppZzHjzaHNZvGqnt7clH/Ex6hrqC9k8ZMxLG1
	d1jPlTW/401I44qHLq0kbU0WMfu1uLke+ajGt6t2NWsitIghiOvfqcTK4sHLFSDFArtJ6eDRWSM
	VD/dBY9IfATZw6/t2VGBFzpT6HXw5RD10LEfQngAEH8Tg2ybicreDKEztnOcy7deLI1DMwbZq0v
	3zxxQ5XogAGAVzbwQkypROw==
X-Google-Smtp-Source: AGHT+IFVboGfJoqjJhfZi+dsfHavP5m9Lph+rLBZNrIGc495wO1VRiGqRsb3VqyIHntxDPW16N5v3w==
X-Received: by 2002:a5d:588f:0:b0:390:f394:6274 with SMTP id ffacd0b85a97d-39132da9214mr8349821f8f.52.1741611135698;
        Mon, 10 Mar 2025 05:52:15 -0700 (PDT)
Received: from jupiter.vstd.int (IGLD-84-229-89-124.inter.net.il. [84.229.89.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceed32e64sm62168675e9.5.2025.03.10.05.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:52:15 -0700 (PDT)
From: Dan Aloni <dan.aloni@vastdata.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] utils/mount/nfs.man: add noalignwrite
Date: Mon, 10 Mar 2025 14:52:14 +0200
Message-ID: <20250310125214.2592313-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <c1ba003f46c0d9b59dcb6d1bd0afdb94b5f7df3f.camel@kernel.org>
References: <c1ba003f46c0d9b59dcb6d1bd0afdb94b5f7df3f.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 utils/mount/nfs.man | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
index eab4692a87de..b5c5913bf315 100644
--- a/utils/mount/nfs.man
+++ b/utils/mount/nfs.man
@@ -618,6 +618,17 @@ option is not specified,
 the default behavior depends on the kernel version,
 but is usually equivalent to
 .BR "xprtsec=none" .
+.TP 1.5i
+.BI noalignwrite
+This option disables the default behavior of extending buffered write operations
+to full page boundaries.
+.IP
+Normally, the NFS client rounds non-aligned buffered writes up to the system
+page size, which can lead to "lost writes" when multiple clients write
+concurrently to distinct non-overlapping regions. Use this option when your
+applications perform non-aligned buffered writes and you can guarantee that file
+regions do not overlap, thus avoiding the need for file locking.
+.IP
 .SS "Options for NFS versions 2 and 3 only"
 Use these options, along with the options in the above subsection,
 for NFS versions 2 and 3 only.
-- 
2.47.0


