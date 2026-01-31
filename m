Return-Path: <linux-nfs+bounces-18622-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCXIClBIfWlZRQIAu9opvQ
	(envelope-from <linux-nfs+bounces-18622-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 01:09:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECFCBF7EE
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 01:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13445301A3A8
	for <lists+linux-nfs@lfdr.de>; Sat, 31 Jan 2026 00:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C911C8603;
	Sat, 31 Jan 2026 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOZZsA1k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124A19F121
	for <linux-nfs@vger.kernel.org>; Sat, 31 Jan 2026 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818187; cv=none; b=hZZ4njg3JMJk5vjOCroM+0fX0koWZy1dk0qghGf0kVzSWXwLhVCPS5ASDbvd7MIE3sA6kNDDqLGrxjwe+GRQndg9Yl1Awluahk/VeLkWw4VycfnYOZ3qXiU6+N0MkAzcMM5KzdIGX3pOndeTVCRQuZCzsRQ8HApg7k6uTpcbGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818187; c=relaxed/simple;
	bh=BABPqIegGw1M1x1cIf7g82ZdUgSt6Gg8si8SJcXJ52o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFPZ6xYixMEih4dmsWOBdkM6CKpIDMvQj4vNpr4VPTpDhm3vSE7CWD1EZBbwGzESD82Uv7cJeHWMHzbGM2jT/q8zGEA9o4yYYG9Dgo7OytZZYi3ybgpcn46AMV8wMOL7K57e0V0L82LEdlCenWEgKabIemBefN6+B4YA8knReGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOZZsA1k; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso24042035e9.2
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jan 2026 16:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769818184; x=1770422984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bvS+3cJ/XGNCOT2BgtSdv6YJD9aNN+H/BEiGpUrPdsY=;
        b=SOZZsA1kLqwTsOAJ+w1IMSbQQPRC4S2XMKvaiDhrcAOcKjYh+a5CwYu5uJ8+80FZRa
         R49aaUyQsmSd8+VhK5rZLTZBXgJLn0nFRwtl8egHY6REN05EXrqB7d9xq6uOj3fRgv6q
         IVeQxxYeqxGqmPe65LoNGh/pg6/auP+c5/iPRb4AhuIMag3LuGGLqcyLmmTluSZxlKto
         vCUO6X5iLMuuoGfLmiQZyJv4AYH6xjo8NDxu8QM22qLwL9pne6BF1GA5kw/wvunvlAMz
         eyrL+4KG79SgYlz5q1izF0aHPqus/VQYmVKDHE41EGVuAgV73imXz9P6oiTBbLVj+aJL
         vvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769818184; x=1770422984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvS+3cJ/XGNCOT2BgtSdv6YJD9aNN+H/BEiGpUrPdsY=;
        b=qNeFxSE646d84Q09oGzXwXyxM1YsPCZs0kBLgShzh/uFgxxK5QmukAbc/eYILtk+cu
         TNfcVnQ3BPn7AVH+7kZuwsXRl7cVY+Tng/43lbKbO4dJBkTzz9uSNAk/W+sX2uTlwQb0
         yPC88Mn+VLC/2dWm/Rd1EHEfqwhHyUmUBoS1XqI9b0wDCCvTrOEloDCVN9HGSXFYls6U
         JReefzeSDDmAyHLEkL5odPlkVK4KSXnws4e4Zx+nw0nv+ariRuAjEhB0sCRCl8eId13x
         o9RvzIa34FiqHlzpTgRpnhL4SSIyVw1zDiYW/adOZ8SHiBY55/F3Rh2e7d1EQOCrL1GU
         Fvlw==
X-Gm-Message-State: AOJu0Yz+f+WhA7Aj3adUe19wT52rqsT6XwNXqbwGY8ICHWazjma1ZJ8Q
	e3ZiRb0EdBgDr1xRFsmQnvXKLHP1YgJLy8np55n6NrjvpH1e9axA2gp0
X-Gm-Gg: AZuq6aK+QNSJhrWnhtv86fH6ym8gP6LrzfPJihZgD6Q6QumnwOcSy9hbhFAD5pukI0B
	jqOjNZ4Ta6hYl356/fjDym02Mw3YFco0mEFFJo8NiigRDWnAZ60wUsu/ufUCn6gIBV7INYXSOGU
	tQwOvGRDys8Z00vYjYoZGGCDptJq0TCfZibNwTUlYvwsPWP7GUHTqs9TpAXPCpnDqO+QgFGCndi
	D2FJqj76nc/4mbh464K+tp01Rrg2i8DNz+5ktzg/fHndsuAKif4OHNXyEbg4P1T62TlPIr1++9g
	qGVr/TXQD8lhQpX7obX1waIPY4fW0ElJT/gVCIGYZKympvnyPuM6hDbqIlTz4C4N5PpObyt2pXq
	VsgnNDH9uGHKZm1GkSaivh+eg1fZostVbCW7Y7gJpH/2WchIR/BKiLZI73/rCF7n8f7Uh8IQSsx
	hlUElGWwGfWkjc5hgTcdguTo6Oag==
X-Received: by 2002:a05:600c:474a:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-482db48e828mr55477635e9.27.1769818184011;
        Fri, 30 Jan 2026 16:09:44 -0800 (PST)
Received: from localhost.localdomain ([196.235.250.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cf16sm26386004f8f.22.2026.01.30.16.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 16:09:42 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] nfs: fix memory leak in nfs_sysfs_init if kset_register fails
Date: Sat, 31 Jan 2026 01:09:37 +0100
Message-ID: <20260131000937.229276-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18622-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[salahtriki@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7ECFCBF7EE
X-Rspamd-Action: no action

When `kset_register()` fails, it does not clean up the underlying
kobject. Calling `kfree()` directly is incorrect because the kobject
within the kset has already been initialized, and its internal
resources or reference counting must be handled properly.

As stated in the kobject documentation, once a kobject is registered
(or even just initialized), you must use `kobject_put()` instead of
`kfree()` to let the reference counting mechanism perform the cleanup
via the ktype's release callback.

This patch replaces the incorrect `kfree()` with `kobject_put()` in the
error path of `nfs_sysfs_init()`.

Fixes: 943aef2dbcf75 ("NFS: Open-code the nfs_kset
kset_create_and_add()")

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 fs/nfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index ea6e6168092b..6e39cd69ed44 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -59,7 +59,7 @@ int nfs_sysfs_init(void)
 
 	ret = kset_register(nfs_kset);
 	if (ret) {
-		kfree(nfs_kset);
+		kset_put(nfs_kset);
 		return ret;
 	}
 
-- 
2.43.0


