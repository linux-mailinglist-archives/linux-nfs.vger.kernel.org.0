Return-Path: <linux-nfs+bounces-10029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3789A2F844
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 20:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E40F7A21A5
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9FE2566C4;
	Mon, 10 Feb 2025 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="O55MLCSf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80025E463
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214687; cv=none; b=n+qq4YTw8rqe579M3FfU+zZPX2oxKjjgEtwi1wq34jdBNIf+oPXNONXPRDAD2B9v95qGqt9P7Vp91IXqhsBd3+gCa9oFBAWKLrHe7itDh0XxSdp1OTu+Dkjt4C0IDEapJJ4MegIAyS19N3kO65dxNwAL7I2cujDNrS/2bnWFnkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214687; c=relaxed/simple;
	bh=FuRalVomnUo4fAYGb7ePQCR9+STX3xDmBsVlwWk2WsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btRflk5muZGM2YzIlqHwrEhNJO8hsu16KgUuF1HSlRaSo8vxTUtR3CT9elQlr1ZUo50VvhESsYyue6hU9GlXChAFcVzkCN+QdzAbJj/DjK+ZGeMilLuIsZPkslKzCWQeuf4GvAr508YfWlb7FzHVp4SOQGlPjYpeybzKgafjo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=O55MLCSf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so702481266b.3
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 11:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739214682; x=1739819482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRdLgzD1wD3MEmKM8GjV3bFdVy6SihSEQKzMmUmzv9E=;
        b=O55MLCSfHMX/xT/5jbCTnxIqoXXpbB0uejuD+9BX5SJG8UtOVBAoQmaCP4WffhPzOz
         zKkH+dpXq0RZ20VC5X1JIrUtjmK13vNMM1GFCKg1V4Pn/95O6ictpNMpPDZjx24kCYo3
         odMRUkTBtmBwQc1lPv0JRK5HS2yyp8DQnckDG93t6VCWXClJbW+flCgjIv2+D6pSq//F
         +msRpIb+G93gp1T/1UEB8Zr7kVJoD4Q2fsURNEdHz6Y6pK6ob/6Es2eqRc0aiGT3BqH0
         mw9/fkqwW3l9QUt0m5roAbJo8KuIZPSojoF6WbekujMtmj/s3X08Abrjz5aJ+ZwjCju/
         8g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214682; x=1739819482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRdLgzD1wD3MEmKM8GjV3bFdVy6SihSEQKzMmUmzv9E=;
        b=cdj/N6ZqUJO/WW+mpwWTqKWJgAlZIDnDUsULe27mlLSd9wqdePjPTCowuESzdXsaYn
         HSWOEqyjKx965XY7uPJ4SIvKP7VCK13fCjPeJ4W9nOga3VwoABI2BPKQUtGAyIfZ/+ui
         VcmLxLSbur+BaIp5gg7j19v3+9+113HcmI0czfxnsVzSU2Qbvn3uj7H1yUsFBhYvOs3A
         zlL2mDB/iBVijCZxTkSR3fpZvUemiLDU8ebBSPHPV9fRCqmZCC/3QMikgkKhZZ3Cv2fD
         /vikCj/4PKOnKbV3D6tjUGdBJ98/jUi1vt56miXoeqtbyWDRXBGKXLrBF9/Adw4XlMyf
         yJiA==
X-Forwarded-Encrypted: i=1; AJvYcCWPIUFGx9X2dgyXVX0Ug5OdKGKSh4FLlyfQcUy9WeEmGHmqWnMsQgJ+7XBnoB9r4rIQLZQJZl2XFMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjbJeg5sRsbgRyFqH/9JzRJIbxZfti/Rz6jEC/Yfgfh2VD9HAy
	gxq83OvDhwi6XZNOGBUodRw0qsgHgUyvvmRPd+Y61DB+qh6vwPQvl+2B26s7aWUkcf71/IenkWc
	s
X-Gm-Gg: ASbGncsbBY9MuU+jE4sxi9jUa9s0QjARytolNZhcSFxtsspTQLYM1ggPOM/mMlp5IKE
	Zgg/ADqgfjeb7AcMgxDxzRSawxjCvJ8SU60uyzLCyVRHaKk8ojwJxaSIuM5KP8p/7uPUXPv5+TZ
	0OP75cW2p7m2JiVO27YUvOPYLXAM2q/fouWQpnRlEnL8eqaLVYXdcLduZPtRdsB03FxFDrYfW3E
	DLouhbZo24uQtvxLyfqJJnhRMrhu3JY2aU9ldAa4ELMdHOW6EDqSMTPaOiABffypxLcFt/uwfZo
	DfWhFa7aXJ/8q1RzmZ3dQ2fuXLv3+nSgt/WfQbfaQiobCkZV6V6GC0iGEINEOydNUm67TYvk8i+
	6l+W236GIXQPxZDE=
X-Google-Smtp-Source: AGHT+IGhMqK5v2fSt6EV9RNWf/Z5VkBUx+UNoSTflx/SUbiE5SXTICj9mdVUZA6Z3mG7mSkQBoQAnA==
X-Received: by 2002:a17:906:4fc5:b0:aa6:79fa:b480 with SMTP id a640c23a62f3a-ab789a6b504mr1707903766b.10.1739214682515;
        Mon, 10 Feb 2025 11:11:22 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f19d800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f19:d800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab786aa2c60sm812424766b.102.2025.02.10.11.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:11:22 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/netfs/read_collect: add to next->prev_donated
Date: Mon, 10 Feb 2025 20:11:18 +0100
Message-ID: <20250210191118.3444416-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If multiple subrequests donate data to the same "next" request
(depending on the subrequest completion order), each of them would
overwrite the `prev_donated` field, causing data corruption and a
BUG() crash ("Can't donate prior to front").

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://lore.kernel.org/netfs/CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com/
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
David, this seems to fix the bug for me.  Please also check if we need
a "donation_changed" check.
---
 fs/netfs/read_collect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 0d95cdbe5611..681b630b4f06 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -284,7 +284,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 				   netfs_trace_donate_to_deferred_next);
 	} else {
 		next = list_next_entry(subreq, rreq_link);
-		WRITE_ONCE(next->prev_donated, excess);
+		WRITE_ONCE(next->prev_donated, next->prev_donated + excess);
 		trace_netfs_donate(rreq, subreq, next, excess,
 				   netfs_trace_donate_to_next);
 	}
-- 
2.47.2


