Return-Path: <linux-nfs+bounces-19436-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKd3J0MXomnFzAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19436-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 23:14:27 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1099D1BE944
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 23:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D3F630BB531
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 22:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E85478E5B;
	Fri, 27 Feb 2026 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xe/3YrN7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnGolnOh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1B478858
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230129; cv=none; b=FCsDCi4tDpGG8pWmN7B3qaVde92acNS/y66R8QYzzCMrq+BKPT7XlnK5Id3GLVgDUs3o7EdNVSwBz5Xb5bLd5/RuovIIaEa8eE/CZ9z5KWgHYyDGn3Wamvvxz4xucsgEcwbyUvr7vK7+ChFqAV3tr3Ok2niMtoRd2ToKR9kwiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230129; c=relaxed/simple;
	bh=8plZvIc3MWmWOf3tCH4O2W18Nr4LwwUVKkBACPFnzbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRr8CFbvGVKUyN06McBX6DUJjX/XjSnEy9/6uewgQmFPTYkCzVXNR6zBPXDTSiRWbO3gXhOkv4FJOt6JrKYU0Bb7I5NIis3UGqDZ/rCXOzzo4i+dJKKBNOtdCCmmRYII7g8y9odB72j3+749ZzcvnEHCRy0HsOwV8cbXf9P8KKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xe/3YrN7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PnGolnOh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772230127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R1prsx7vWsItznP123F070ioTHMJLfogvObpC35oUVc=;
	b=Xe/3YrN7CHRLnr3WUXxpGok6gEs9AIhD37T0lJB8juq3To95P/ZYKyMRuidkXqd1fJfcl1
	KQFKMZWtVm9/d6OPWt2NHOBh61PQearS6qa+5lOHqXs022olmb37XxhtmRsYWoToUiS3QE
	AkcvsV/kfXrEP2OIlA5uuHLyP4PKrLw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-hoZT-sbqMPiSm0qC-WXNZg-1; Fri, 27 Feb 2026 17:08:45 -0500
X-MC-Unique: hoZT-sbqMPiSm0qC-WXNZg-1
X-Mimecast-MFC-AGG-ID: hoZT-sbqMPiSm0qC-WXNZg_1772230125
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-899afef8eebso241521236d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772230124; x=1772834924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1prsx7vWsItznP123F070ioTHMJLfogvObpC35oUVc=;
        b=PnGolnOhtLIms2ZIFwP5lN+IQSTiLIvInQYCW7ysXRTHa6qN6Pgg00zjlD8c0D8hmD
         zNxgUXNcWRNG2DE1S0ycn4nhgC+JN2j2vYyNmdgaUcQdcSfFNjizQpz7onp1iD4Be+2V
         DkUayJGLMOVD+eTbi+qXnpJteOe3pG3pY1y+VUZd7JplUoiOVWSpHpvNrgFm4chUGUds
         uB9XmPQOaIuiJbSZkYt/+Ob0f4SAa+KPxkbTTmdiIjKxnpGyM+W3N5sauk/tfZbudF20
         vZOs3jSbHw4elWOb0/+i3qhbBC4HxJhEjKqriVaUUbbVaVEUMRJSV3EnJhW+PtHzHvpr
         FNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772230124; x=1772834924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1prsx7vWsItznP123F070ioTHMJLfogvObpC35oUVc=;
        b=nxr1rBVsiBN9py8BReo+rIDYKp2unhLE2CYDm5noujYXcuehbWNc7hqIWlPp3W9TX0
         Puhba+BogCjnpM5KGX3WQBa8oHr929xKaHQ92jYM7zHEjWFn1VosFPSRW8g6kZuBDsCf
         R1oX4sri17qqZ3VDJP3bCHoJP9l9Jf12sM+9mZhBBTykTmfdFE2XtljatbK9FavxUhZe
         2Bn5iY9+EmZJNUbB+qR1gYVchkywCxxERteQQgIT2S7k/MfFGAvmojp5/2FvfcfPiNG2
         FvC/geVXWCuXD4OWjf4RW3ElumnUOVyAd4/u4NdnEwxv9s0wcg4RlbTC+Vx9MB0MHq7C
         Lq3A==
X-Gm-Message-State: AOJu0Ywfz+Ga/TgtGimL7RJROzTtnPbc174+cb+gtbOnw84TYIWsfrCP
	lojBllfpCLBRNSdKmmocB7/Ra738DdxY1fgtvz9cewsff+gqduh0JtdmSsdX1DLcUP8mCbaqa3o
	khj9bBP4ctFDD1fA1G/Jz30jjiUe/5NvJtDfgOu6vW+pAvSJSAv1UvYtyElelQfYZqhDITcogJN
	CBkE6aOPDdSeIOgAXy1hA3yc1Vm57Fn7nUg5FWLCc+1bYV4w==
X-Gm-Gg: ATEYQzyBMfFFarcRiZZpAh3WJEmyNXOgNPZHkxkhSwgGVbz7xsmu3ghrWc41/QI5Sg/
	+l3fTj/NCniZF7wQfP+7bejsCAZg7av8rfGCeF4Rj3N8E16v9Q+q9u5dKz/duaaAkTO2lDRkvvq
	s1m6/KX7RKpdNDQbwuwFqv3beXPvgG2X5GKBVVQ+DLKhDEi4+sgm/6+v+kQpcew0f6CvCG1oMLK
	0ts/tPq626EyasRqkyX2uM8vR9bsWnxXBpAU/kQ4uI00pDMs8QEd0FX1aaToLtS4xqOTTqtFOd+
	9bSV2z+8GPfkHnvi3xWqsYOyluKzoFWLTQwLlUsr/f7H6QGMZFns4OejIXaB9fgWhRxUZMRscY7
	avGU8yWQpDa4fy3qZ+1AvSUZX1gNG25HjmvQCYEYUgJYau2X3w25JhMeYQDrsVMJbrenmItiBgY
	mEf+r5
X-Received: by 2002:a05:6214:2481:b0:899:b42f:9dea with SMTP id 6a1803df08f44-899d1db1605mr68145136d6.25.1772230124529;
        Fri, 27 Feb 2026 14:08:44 -0800 (PST)
X-Received: by 2002:a05:6214:2481:b0:899:b42f:9dea with SMTP id 6a1803df08f44-899d1db1605mr68144796d6.25.1772230124155;
        Fri, 27 Feb 2026 14:08:44 -0800 (PST)
Received: from bearskin.sorenson.redhat.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7377b0csm54046126d6.31.2026.02.27.14.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:08:43 -0800 (PST)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: steved@redhat.com,
	achillesgaikwad@gmail.com,
	kennethdsouza94@gmail.com
Subject: [PATCH] nfsdclnts: fix display of stateids where the kernel doesn't provide the superblock
Date: Fri, 27 Feb 2026 16:08:41 -0600
Message-ID: <20260227220841.3015642-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19436-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sorenson@redhat.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1099D1BE944
X-Rspamd-Action: no action

If the stateid's file can't be found, the kernel will skip printing
the superblock and filename in the 'states' procfile.  When this
happens, nfsdclnts crashes trying to reference the non-existent
superblock key while getting the inode.

Fix this by setting the inode field to 'N/A' when the superblock
isn't present, as is done with other fields which may be missing.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 tools/nfsdclnts/nfsdclnts.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/nfsdclnts/nfsdclnts.py b/tools/nfsdclnts/nfsdclnts.py
index b7280f2c..183a02ee 100755
--- a/tools/nfsdclnts/nfsdclnts.py
+++ b/tools/nfsdclnts/nfsdclnts.py
@@ -87,7 +87,10 @@ def printer(data_list, argument):
     client_info = file_to_dict(client_info_path)
     for i in data_list:
         for key in i:
-            inode = i[key]['superblock'].split(':')[-1]
+            try:
+                inode = i[key]['superblock'].split(':')[-1]
+            except:
+                inode = 'N/A'
             # The ip address is quoted, so we dequote it.
             try:
                 client_ip = client_info['address'][1:-1]
-- 
2.52.0


