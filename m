Return-Path: <linux-nfs+bounces-12955-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9DBAFEC23
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jul 2025 16:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BB63BA757
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jul 2025 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647DA21B182;
	Wed,  9 Jul 2025 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDVfUwAp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD04D2D0298
	for <linux-nfs@vger.kernel.org>; Wed,  9 Jul 2025 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071826; cv=none; b=QynzsP3mokX1gci/EMzlEkp1N6vFgsw8SjlZmozpQLN5GVz/Tlh0sxIKECqBbAmVpt9mld8zkHSwolUrI6vcp20VGfFN4OAhF5mU3X1LMvcuasLFftHBg9tPtk393pSTuQxl7/IL5xD1QJLG1Xhsn/BolVFZvnObIiajo4YZ6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071826; c=relaxed/simple;
	bh=GKVNVuwjaGSMx0bZJ038qEc/YmPJ/q0uDCDeOjxzcSM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IFeWrUPteTgxadeRcqq1n+UHFuezHt7EhsLVqcF4UWXq017/SZarPj4Eg+FjSVyPfE1cABHiUVemDadFdDB1ajc8FIu+qrLJy/V/ia0JzkEdlnkxfwhbAKOcOucjq1vquHnrQqXlsORdmb/TmwQMbndlIm8k9aogUkHVSBOAjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDVfUwAp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752071823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXEA6M/34LCdBuNTvil7Pgq3q841eGi/An8za5Mm4mE=;
	b=BDVfUwApu9UTtgBc+mSDmnQ1W/I70MBjjqCV6C1JnQri+7rzEOx71tKc6q9IecDu0EP2kt
	7Ik0JFb9955I0Kl752vww3syBP0k6B/qXVKe/eNGKORj/jYuqHm+Om01Q66DiQf8+I2zRk
	//cY+L50MZP+aHI71NxALYnCUjYpdh0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-_0LmqoiyOjW1_j9URk0kvg-1; Wed, 09 Jul 2025 10:37:02 -0400
X-MC-Unique: _0LmqoiyOjW1_j9URk0kvg-1
X-Mimecast-MFC-AGG-ID: _0LmqoiyOjW1_j9URk0kvg_1752071822
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70e4bd6510eso77960917b3.0
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jul 2025 07:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071820; x=1752676620;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXEA6M/34LCdBuNTvil7Pgq3q841eGi/An8za5Mm4mE=;
        b=tIaMKw1wjM1wcHIx0xvvYBzDXv7PyOF/U3DiiMN04ZJTjLjPg/L2UykLxsGMSXCVoK
         zwQyA/q8UQysS2aqgctKQfTo7dgeEGHixGue00Hp5z/eVlGX3CXHmXkiD+S0OhDZzQh0
         8Aqs9bjx8s0/0K+NhLsuFt2uLIwbV4vOR90gPdIT+jGQEPKqcr85aeSl9Qe+lxyvz8ki
         FqOPu4IbSJteUls2Ox1twV9Shqf6QxLLJQ4pqjS4u8gi0utmHXFRz6TEjoavUR1Vr3lb
         aQ3/UNX/A7YytClfWzJvAm1ZXY03tgbCoWGPFXTygkedEsjrbwafGa8NjcndQWit8gsv
         2yDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqMztCKlkPwiWZq3r9ieVoYkP1uZZ8euw+IR37HMT6WvcIN5FMyTLohF447KXIUAmqVeu1+zQekyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEq5dTEw29Tqdi1aiTiz+lluhqjIjHReDwJKVkkhXWGkjnnNuE
	mu6e+XJBvrVljGVGDLVCtfCzEfMdvpq0ItkyU54+CEUOW9iffMIp/jpeJEU92L/1oWKx6f3dr23
	yPRlYoE3bceBGiNVaYEe9ffDci7j8WP8hgoiDU/5eilahEa+strX+ZkpthlD4uYOxR3wfpg==
X-Gm-Gg: ASbGncsh7h0pndozYAF8N776gvBZk4loruzmh3OlAHD3IJqlC2Ogi7md+caJvUne1Kn
	/kwdHPAjy8GmXLVt8xXjlCRHNOKdZhzU0ZurZR5uvgc9R0eH+WtVz3x5zkOaAQiMEsfbdzlt9Iw
	A1TjF1w+0/+oCCvOlX7fvmMYDf0QpKjpsMt0mpd5MfJOkuWo46s1u3sg8QrldhtEWFPb7ozdH2n
	1gwtb2D5ZJuyPAlB/WNi1UFfpvQGvjICvhzJZzCe6IQ6THGdYM86lFZ/WX4vyowAAkmToQGCa6Y
	AxAtyUFWNVFCskVKxHVyaJAmOvsQhQKRsbQ48emYkLoZgDco04yOi4ryxU/FGip7Ai2s9MCK
X-Received: by 2002:a05:690c:7013:b0:711:7128:114f with SMTP id 00721157ae682-717b1693a4cmr42503337b3.12.1752071819787;
        Wed, 09 Jul 2025 07:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZPpQQpbvc157ohZHPfa3U2UXwLOMs5YYJ3CsEodt44H944ZiwEa89Oq8Svz0t8OnaWMSmkw==
X-Received: by 2002:a05:690c:7013:b0:711:7128:114f with SMTP id 00721157ae682-717b1693a4cmr42502937b3.12.1752071819317;
        Wed, 09 Jul 2025 07:36:59 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71665ae0461sm25443297b3.61.2025.07.09.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:36:58 -0700 (PDT)
Message-ID: <f9ad0b98aa8944270612d933c5d217710cd06dbf.camel@redhat.com>
Subject: [PATCH] NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY
From: Laurence Oberman <loberman@redhat.com>
To: Benjamin Coddington <bcodding@redhat.com>, trondmy@kernel.org, 
	anna@kernel.org, linux-nfs@vger.kernel.org
Date: Wed, 09 Jul 2025 10:36:57 -0400
In-Reply-To: <F889E706-9B2B-48CA-B30E-60FB5EFE2578@redhat.com>
References: <cover.1751913604.git.bcodding@redhat.com>
	 <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
	 <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
	 <59530cbe001f5d02fa007ce642a860a7bade4422.camel@redhat.com>
	 <a93e72cfc812a117166c0b20e9cca4e5f8d43393.camel@redhat.com>
	 <E38B4D1E-C7C4-4694-94E7-5318AD47EE1C@redhat.com>
	 <e5afbff5d8a0bb6448305a3f85a51e3772852ef8.camel@redhat.com>
	 <F889E706-9B2B-48CA-B30E-60FB5EFE2578@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>=20

If the NFS client is doing writeback from a workqueue context, avoid
using
__GFP_NORETRY for allocations if the task has set PF_MEMALLOC_NOIO or
PF_MEMALLOC_NOFS.  The combination of these flags makes memory
allocation
failures much more likely.

We've seen those allocation failures show up when the loopback driver
is
doing writeback from a workqueue to a file on NFS, where memory
allocation
failure results in errors or corruption within the loopback device's
filesystem.

Suggested-by: Trond Myklebust <trondmy@kernel.org>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/internal.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 69c2c10ee658..7f3213607431 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -671,9 +671,12 @@ nfs_write_match_verf(const struct nfs_writeverf
*verf,
=20
 static inline gfp_t nfs_io_gfp_mask(void)
 {
-	if (current->flags & PF_WQ_WORKER)
-		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
-	return GFP_KERNEL;
+	gfp_t ret =3D current_gfp_context(GFP_KERNEL);
+
+	/* For workers __GFP_NORETRY only with __GFP_IO or __GFP_FS */
+	if ((current->flags & PF_WQ_WORKER) && ret =3D=3D GFP_KERNEL)
+		return ret |=3D __GFP_NORETRY | __GFP_NOWARN;
+	return ret;
 }
=20
 /*
--
2.47.0

Confirming that the above patch fixes the issue seen

Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by:   Laurence Oberman <loberman@redhat.com>



