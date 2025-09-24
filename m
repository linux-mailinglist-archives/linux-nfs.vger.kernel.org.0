Return-Path: <linux-nfs+bounces-14646-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35389B9ADB5
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 18:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF3D07AA080
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF1E30CDAA;
	Wed, 24 Sep 2025 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AUc+uNkk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010C3128AD
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730860; cv=none; b=mEoGr/R3U8BnWx6q0fjqGFgrM0cAFcE9erPvyMO7vSGgx7n3nmW8LsK+EWVuXO21HoUs8Nt39ABMlk5kYSpcOEtOvupzwG4Kt/raUz0JlbLrtFO9wx7AycFObT9ZsfZ4ANW3lvu805S0rYA1aWGDpBqmaYlb+LbIbGruEwV4YH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730860; c=relaxed/simple;
	bh=1xeGAreEi2x2Aquc/6dLVE/3TMfMr/uLa0az8bFjmD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r1wrlT4UlQARrwomil7ZfmjTVClzenc/enE9THr2sdjkQ2fWjyFHUGVO268oVyb7VJEekhQtz632F6JQzthrcB2475GkC/RVhXQiip6t7qoMiWd3/Qcm+JQkq2gZJE7XmTzqLF3rDjUIAWMu8xQ+bFA/qjQdguhfs8P53VqAe9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AUc+uNkk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b2e173b8364so4135666b.1
        for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758730857; x=1759335657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTolq9FwrPuwgNkvd2mCU01hlYYpCl0W5vdd5AH8Bok=;
        b=AUc+uNkky5YaFOhvEIzX+xY3DKB/KUvcvTGCgnQ1Ea7WXDIFZl8ygU/mvxtvW9L0NX
         vBQ5pvXN+JRvhfjvZiobeSuBk/8Xw6frwyYn/pRl/fK+rqQFPUxa650xIU3v+ql1SE15
         m4yLixI5sEice48aahGV/GquSt/dV83XjYDkZMe+2O2kAeiTw8LS7CytDhcKTHrirpwR
         4yuEBhfW3tVvu1fo81ydC/Tw3IdY9znB6JocbxlExUzq5YBHzTjc5EZpRuth0Z59QwNo
         htSIARZRd1QjxtIDE4JaQgvUgOZ2UD2wZfkc9DllRdCZ6JiftIAZ7qpPxb914P4p873J
         GAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730857; x=1759335657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTolq9FwrPuwgNkvd2mCU01hlYYpCl0W5vdd5AH8Bok=;
        b=oHm06H2ZblQNZJJA+XzCusygD50DXYKL8shDO34FDNwNqYZOAQb9G/NB27ZE7qfvJm
         xVmcmhALSFiN1hU2raZVe6aDa5Wj91IXlzAkl0x8gPVCfQXLY0HZsw9qZ8uFkffmcdis
         j/5w4VRqhe8o20CBt+jgJYEb7Suz9PQmsxJA0uzTgmyclsPfrg0CzmbraVgPPl2Hwe4d
         4v/VNSE13cSy7ghlTDBI79x0B115aNapPjEXwyeYpdSZIRYV7Tlyfgu+hmRHivW85r+E
         K5ovcoq1HR7N3jIdIBg6ilJ5E515yTrcTXOEhbekEhYQEVoSEjdCy9L18OFNU3LmEFfv
         4/uw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Ey08sOfgdYwHp9/NWkbsvE8lDUvhSIMAGe0kTMY798TQHODjd4ONwBn7hwiMLczQniliUO3cUJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywhX/fkcEZys1i3sa3fn5H/84PTwkBWI0+Hc+RZ+MZbruE07+U
	9UVqteGFp4rZsHEqZaFm/fs0QZEtWljx2whonjVyzEYzDbmbbwoeIsd557kfjPlslpo7MEJ4O2X
	Sm5mH
X-Gm-Gg: ASbGnctwcUbdNGGIZxAegYstEBzp50fL5xtPwgj7ktVqAqTiF0KjG1YFRBUYaDrA34x
	2RlCZWktkLhesXWJPCTgLCYG2m8F0DGxCHL3ZrDxbkQL9LwF59cBoZLYThjyT1x+hQyF5EjgK8H
	WtPmICkym9A4ZNAt7LTh9rT7qPFC0F0Tr6Qbh2uuedAElkk7SQ5af2d5b2izmCHZOL6+LvvjVRC
	jIvD6c29kvRtZfgYTdg6RSGsb5eyGmnmjsJAMfeVzsNNlvSWzV1NzM8pl8E/75EI5dxyKekzM1r
	ErxewskkANLyBTA6gWnvg3Z0PLnyu5ToO03XiO9sJD6W/RjqQECeABxfmAEp3TKBA2oSvN5MjUA
	yqOLlGXOKqfmOk5tFhOSUUso=
X-Google-Smtp-Source: AGHT+IGK1iRYuyuKrtw/gscS6MUlkskKjmgZtplV7bZajL4K/l7djPYHoPI20ab10zJ6U+vNYoPzcA==
X-Received: by 2002:a17:907:7e88:b0:b07:87f5:73a2 with SMTP id a640c23a62f3a-b34bef98e8dmr30097866b.44.1758730857121;
        Wed, 24 Sep 2025 09:20:57 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b2a88413a9fsm872207966b.90.2025.09.24.09.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:20:56 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v4 1/9] NFSv4/flexfiles: Remove cred local variable dependency
Date: Wed, 24 Sep 2025 16:20:42 +0000
Message-Id: <20250924162050.634451-2-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924162050.634451-1-jcurley@purestorage.com>
References: <20250924162050.634451-1-jcurley@purestorage.com>
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


