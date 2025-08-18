Return-Path: <linux-nfs+bounces-13754-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D75DB2B3ED
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 00:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26273A84A2
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DF1246BB0;
	Mon, 18 Aug 2025 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MATL8AXL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6271E5205
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554899; cv=none; b=jCh84cctYy00kqwgW+5KwmsA+QijzzfkBezZo2ejnM2RHFnQF7BitBM96zE5BpPrKBkeQMMBMaWyVOoAvdImQ9vr+9s7gPDSOo9ZAsYCiaBlkAqyw7vSHO6Wb4KdWHNj73r6cbJKIh00Hi0GAh3MU3uOKvxumdZVHdYcDdZNZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554899; c=relaxed/simple;
	bh=1xeGAreEi2x2Aquc/6dLVE/3TMfMr/uLa0az8bFjmD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qG/32xdDrmVx1WQ009kZWatJRn0kh21oRx/3qtF+aDvNaIpZbKHkMXqn8vJR1Nbumrhq0YayiGtnGqvCJE3V+cpDMzl2D8tcHji+xHyc7iWsSllF8gcD8Z03MLodcmDcj7vVNqLoZX8dpdI9Ni/262MgELVYS9FEsiUpLwB3D6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MATL8AXL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-618adc251f0so5761030a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755554893; x=1756159693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTolq9FwrPuwgNkvd2mCU01hlYYpCl0W5vdd5AH8Bok=;
        b=MATL8AXLCJLgjXFcjcQVBMdcGmfr1rqaPLWLPlg3fz1NBxbQxbBMkg6Hh54rDUFUYX
         ynrtYmFYu4G+1V8hGiGRy9iVge2h/43Yc3GCZ7Gh6ozpVt1K3O+e6mxhUw8ZsrRf4MBI
         ChvnKOx/cWMBSnNAhSXKCpHmg4s7TNNMYkoUAUjAqft49q/u6w46JMNQ/mLZqkLd8rAF
         OIRO03kaJmXG6vHPbyENoDxQPpguVfizK9NVvxmtAaUynOV4027Cf09zASL3ZYsaX60O
         ICmLZec+y/yM6Sbl8r+afGI0Wo+wzYieiD/viMbT88vRYfLXZUWQidul+grUSpRTcibr
         +4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755554893; x=1756159693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTolq9FwrPuwgNkvd2mCU01hlYYpCl0W5vdd5AH8Bok=;
        b=wWVXR188A1/ViIFZLkQ/LsLzviswQ4PYRP3zDbDMAf+XUljN9uyujcEyZRGbPBjxPt
         paFfbRmmRoaxToF4fpZELrg9bzrHLQlfBghiOZnGJxHzWMi6PX/ZWG+gnc4YMMlC8NhK
         kRjDsCwUm58ZLpimJke+tx5YhoaqZ6rrQExuTqpsnhwwFlsJackMsDGsID1M280TszEg
         frD+2hWRr86UPXGQQrRpnKyIwr1+GE/YjYbwtAGMaMoqB+wEMl90cvMkPEBT0NVolP5/
         Tktx5L8Wlusj3u/SoEyHitfC1JtRgsAVgrEDkPZtjVI/m9JW03nQCAbbWk9DEp3VoNyZ
         uzEA==
X-Forwarded-Encrypted: i=1; AJvYcCWu+682VluY8N7+szPpIf+JTFGhXdeykaBQ5P0X8XxfhuvEjsFIpYnEucXw3e+zpVgEvP1MvqM9c6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oVJ3ZYraIvwxkSXXHDkoIAiFqkUBZZAkeA2XESXcrA28lkHs
	eIZghqg6nw5mvKAQQYIWGVx6zUb/qg3ojYPVzA43D7+IvQpQzwtfLNCmaY+pZihdYqQ=
X-Gm-Gg: ASbGnct2QDDCq/Tlx2NZ8X+jILGhW+uwapfNDhTa1tgEZViVGAd3XDfIjIWjrdvp1ig
	+gFIzLUo+SNXwZAOpQklmHWFwpP8k7TrkU9FtS0M2YorRFRjFsE3GGs+FU4NMfavzUHwAKkqoey
	YFXO8nvVYAgaKhDEHUtfoo+IpvyLxpmRPAtQVi0ev8ugeFNKh0YG1WD248sq9ibWEQIpr8xYwPn
	07en9hxnCGsoforFokj4rww8hgN/of2vIBPbUKUNjRA4yrTdwodBZcbAhVsYJkH3J0KFu0B+yze
	VVVcHf7fWk0hUm8+F1/kBOYK3ZrI9cOiimddfhrV8wnkKisaXpcnH1S6rwYmBUvOyoV1Ikg5m0n
	otNjClkbdHX9irO57A7Hi51QDwk3EWwhtcQ==
X-Google-Smtp-Source: AGHT+IFZdc9E/A783UPHEQfeub9WZyNMLxTrr6mEX6nh3ldmEbrfv0DxlN8jcxuWOm0oau5iD5bP5w==
X-Received: by 2002:a05:6402:524e:b0:615:6482:7498 with SMTP id 4fb4d7f45d1cf-61a7e765f80mr100439a12.31.1755554893603;
        Mon, 18 Aug 2025 15:08:13 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a75774618sm540818a12.33.2025.08.18.15.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 15:08:13 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/9] NFSv4/flexfiles: Remove cred local variable dependency
Date: Mon, 18 Aug 2025 22:07:42 +0000
Message-Id: <20250818220750.47085-2-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220750.47085-1-jcurley@purestorage.com>
References: <20250818220750.47085-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No-op preparation change to remove dependency on cred local
variable. Subsequent striping diff has a cred per stripe so this local
variable can't be trusted to be the same.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 4bea008dbebd..a437d20ebcdf 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -532,10 +532,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		if (mirror != fls->mirror_array[i]) {
 			/* swap cred ptrs so free_mirror will clean up old */
 			if (lgr->range.iomode == IOMODE_READ) {
-				cred = xchg(&mirror->ro_cred, cred);
+				cred = xchg(&mirror->ro_cred, fls->mirror_array[i]->ro_cred);
 				rcu_assign_pointer(fls->mirror_array[i]->ro_cred, cred);
 			} else {
-				cred = xchg(&mirror->rw_cred, cred);
+				cred = xchg(&mirror->rw_cred, fls->mirror_array[i]->rw_cred);
 				rcu_assign_pointer(fls->mirror_array[i]->rw_cred, cred);
 			}
 			ff_layout_free_mirror(fls->mirror_array[i]);
-- 
2.34.1


