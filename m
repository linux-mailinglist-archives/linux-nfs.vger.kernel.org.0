Return-Path: <linux-nfs+bounces-18558-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH3fJwjReWlCzwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18558-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 10:04:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3569E9E9D3
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 10:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EFA63013ED2
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 09:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1576E33BBC3;
	Wed, 28 Jan 2026 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="F5gw6hm3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8326033BBC0
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590987; cv=pass; b=qseOGB9OJEmPpX6pFrndHOPXYdjY7BPUQRhyz0FEzwgdGjUzthtF1/ppjrCAOxUwOeysXcwgEL5gDfZuw0kbnKF19EivDRr98OjuJacUEBBzctpr+RqYEeI44zYwJvQv2T/jSmUcK+2glHeS+AIQS0/8a9Squ0JhpLUv9zflItc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590987; c=relaxed/simple;
	bh=of8Tglwez6BrwbetCX0dF+/F9ySxWwbN2HB8CRQxj8w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NBeKwqz9APmeTPGq7nZmmygABXqLpGnL7PSzM35k1GWtUL8QltIbaCD5wAUreR81UPgzmMoR59KR14WYMgAR4TSzlu4PyskKkcK3a/EtVymXkRIWgZlywFjOwsQMjDJnQYcbylyeFyhFsF8Q947oKx41rXyxln77EVTMyeZRUNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=F5gw6hm3; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b86ed375d37so771456266b.3
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 01:03:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769590984; cv=none;
        d=google.com; s=arc-20240605;
        b=R+K3syGn9Wv6A0pCAkEyXQfb3i2dzvCycFnj3PVTxxNn/0CVNFWpX5FJ7V5BGmaODo
         WQ7meFEjNdh1bs2GPadyjC0aAugDqDu2vQxBb1HurEZqzFmS/Mfa5c9yWPvtPtUO0YHD
         krZKF4EZs7PxOx1I8lVvMRdsxRhOk/bTnCvOXh6wVoXay30ogyKhdiPW5SUTWchpuHYS
         oqQ0MjGD4UzJQHUn8B1lVwtyii7S2DSEfUfGhXsSJfNyIkO3rcSwyit8cxoujDFa9+6m
         ahH4kAWzI7iyqywPigkyslYEz7ZXGtjhpTLQ1vdl2VH+YvZBBybFbiZqLbbq3BBqQiHU
         n1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=of8Tglwez6BrwbetCX0dF+/F9ySxWwbN2HB8CRQxj8w=;
        fh=BxPDKKIf2KF5EupqmJE70t8P2jEszcS8uOFMtoG8pDE=;
        b=AjY7KSW4dK2c8ufN6soGkelSk1zBW/8dy15R7zH/n6ce+W9DQCtefnaIpKbgSJmKZv
         8+PFuw0aYaCScYNQBxp4H4NAjlam0tF7gdKeeF+VAu4uwwabJTAWPfg3LrnO7vV5MXNI
         2NwazkRj6+37+buO7VqRoRinhto92jmBlNyTB4AZIF/Cx98dYZC98aG15WiXFZ/p2AJv
         ciS+RUbvYK9RHl5CwTCkDCspKsGJGMkijW7B3LKKK5glkB30jgdY7i2oG9bRmH8P4Ilw
         yhsWgcwMkw4bWrbIe02EkTIAgHsLdK7UkwkRrrTjsVUdZuu5n/vYOxu1CiYy1EbReT9G
         Goxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1769590984; x=1770195784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=of8Tglwez6BrwbetCX0dF+/F9ySxWwbN2HB8CRQxj8w=;
        b=F5gw6hm3xB8AmLG01Bl+/9VnnGT8TCN5Uhzrs453gbB1laEz9Boh0WUiJ/V8j7WIOt
         ngWoRfQoSpg/8M3XoiaNoA9TDHGMykAGN7imQd1k9ZgM6QfDucz+LLj6tzq8NAhKZG+H
         xu9qJiKj6/PACvBfHdvkupaT/cFvjkfVuG7HnEIxj4k+S7rIqNV2G9wn4IuJaqZLHbk4
         suhrbl9458IRoWTgn/h9WcElH9comAXvW2MmJykocuUSg1xEg/qaLxe2/5EB56dR3CUb
         dTTR4+Ig96ERKPo2f+5A9omnMWv5Jf8LMkukodayDgLSqj/xKgT9erF3x4ZF1Bk2X4RU
         q4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769590984; x=1770195784;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=of8Tglwez6BrwbetCX0dF+/F9ySxWwbN2HB8CRQxj8w=;
        b=NJhZieMmxRFsJ+DGEGbo7yQTtFvNSCdXkKBtPU7Nlbxh6v+Rc70XgqF/YXiMfEsnFg
         Mwm9W/6u8EsA5wRt2lHUUJ7gZrgiUlqi3xA0qgT7AfASt/o+AfHW2dTFEle55bVKeIPq
         kM3pV9iK1be2vWcq+HDO0EOBC9iRXteCeFxIV3O7fghYTeTTOa8tU3talhnAdD6JAypE
         xgw1mXhuAKherZX9GEGwWwFWq7aPpSyAnXOpDPxnlHxB/bNf0K1MIvZ7mlhX1E5XBPRA
         dw9qspIMlMYtS4sNhuthdnL38zNgXkyvMYvcMTOGAQZMVRdFbzx2XRzTohq1c4WmEOze
         xNvw==
X-Gm-Message-State: AOJu0YxvTYlhrnY1QupP2thO8wDnQsRO1Lq/b+pjoFMcULxNhF36SeiX
	xR4MZNQBYWMVj0ycjav2dkimUr2lyqwVtoPzA31MFZrc3TqGVgU3uC/siTpS29f7ZFN2EQEEp+W
	aiIiL68QCUqRXbsY/0inYD5dMwZbEzwPqkFITqFN64e4GLWS3geUcgHI=
X-Gm-Gg: AZuq6aKQHRr84aGTUop2yItxcbu/2hWVAC3QtJWgAVHjamse/K3tXnODUdkJvxkUxGA
	qdivOA9z7gHpWY+shlIjsa0mY3WlyTx/a5QqlsTAhXgeyGY8xSfGnEfV5fsJT9lgJUMSEvLiRHS
	4GoMnjQpP4q9lQ2DXXlisdLK90hTOv8j8ph4HF+Wtp7hZ5tpX8heSK73yt+EJRySHGyQDYaBRng
	3b2NKpNxpxVZhw2L53uiIIkZITWHKPYMktOVzsI2n9YVUC8YLG+yNAFjwlCrzEZxL/M+8Y=
X-Received: by 2002:a17:907:7fa9:b0:b87:7cb9:c3dc with SMTP id
 a640c23a62f3a-b8dab2fda90mr309331666b.32.1769590984197; Wed, 28 Jan 2026
 01:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roi Azarzar <roi.azarzar@vastdata.com>
Date: Wed, 28 Jan 2026 11:02:53 +0200
X-Gm-Features: AZwV_QjClq2AHrABct3ZDqDjYYf1cRUzgr6483fPLJdloFerEeM2N34oVM8cSnU
Message-ID: <CAF3mN6WtR76OCckuAmfQ36MbLekeC5mAd3pFWRaqgDvSgd06wg@mail.gmail.com>
Subject: pNFS - handling ghost writes scenario
To: linux-nfs@vger.kernel.org
Cc: Sagi Grimberg <sagi.grimberg@vastdata.com>, Shaul Tamari <shaul.tamari@vastdata.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[vastdata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[vastdata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18558-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[vastdata.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roi.azarzar@vastdata.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3569E9E9D3
X-Rspamd-Action: no action

Hi,

We are working on implementing pNFS and we are discussing how to
handle the following in ghost write scenario:
1. Client writes to DS and gets TO.
2. Client resends the write to the MDS.
3. After X time the server executes the first write.

We can handle it with some barrier and such but we are wondering if
there is any pNFS semantic that we are missing to handle such a
scenario (without session trunking support).

Thanks,
Roi.

