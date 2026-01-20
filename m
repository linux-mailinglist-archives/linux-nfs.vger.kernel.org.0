Return-Path: <linux-nfs+bounces-18206-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M2FANrab2n8RwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18206-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 20:43:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 945284AA8F
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 20:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 279F688C545
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jan 2026 19:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4F3BC4E8;
	Tue, 20 Jan 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6IfN2CE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A63793D5
	for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936753; cv=pass; b=lAu+zJmgD5d6o8eIACvOp3ZJc9HMkInaNk3e020b5+ksXiTADCMMXRR8GmN18MHFOviuOq4QHHfCX6m3f3Szfd5xmxA8J9cCNIxDHZST/Q1CqP+ZJGFT8XxbcXpf9LLIaYGCQwJeSBu3OH/wMF6qjFYAKVXgyoHAuBkXn2D6r4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936753; c=relaxed/simple;
	bh=tmQDk/BLWI1wRqZTu5nWhzL/u+5+r4HjgBzcFiok0VQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dXuD3b8Ksu7LELgMmB6tg07ck8Q5hZi8MCiwT8IS8i4EjhDuNP/akrMOduBT/26GbDNHD5drro/pco0hAUKi0QT5Fqnax+W6lBZTLysh+9978iDqt8dnxntr4WkjeiggdC10BV0UgzO+lHvnGwHF9b7MVItMe+tZ0Q6J5y98TzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6IfN2CE; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b871cfb49e6so909312966b.1
        for <linux-nfs@vger.kernel.org>; Tue, 20 Jan 2026 11:19:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768936748; cv=none;
        d=google.com; s=arc-20240605;
        b=KwFrQhLprsvVzuzvWrv1969M2pslKqzS0710ERcawDIjf0r3K4FfmefzNv/nYANRp8
         51mjUDQih9RgoUjlo+6UJlqSUcHm/+Bn/5+VRnSR28iWada5vYjh8pQ1GoK1hl3AwNJm
         UoZErw2XeOuK9KoWikY+N14LjCuoEmYjf7WltqKphfFakLMSNbIZ6l7pEZSU0zbLNCFR
         kyYMJPqf77AMDljOMi/4olrV9/l1w8wF9I2G/NdU/O2T+gYejIvA4/1ozBGkbyNK7mZN
         9AZR8oYeDHG4tg4tcCrs8rkVtpOUHoUoy4e90mq0QcAWI9fLlSiXxNGl4DE/0pBL3e2u
         2pNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tmQDk/BLWI1wRqZTu5nWhzL/u+5+r4HjgBzcFiok0VQ=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=jgDJUPQGGbUr8zhJH2iFHmqmp/cgdzlz6VRv7mAlpW91r9mTzK861sugzhp6i666ka
         Apc9+E2OG3AmRdG4s9PtfCBExxFDb/PanLUUKDiO5ePqqVGh4wkvF40wR05a2y8P5IK4
         kGwJYNRGGC+sQ1RI4fAlFAK9pifbHhfXudg5eoL9UyQhxPIDCjrRqETBv5Ayv68ogKJp
         HEAB4JcA8B3w9rs91cAB07w0FDY605c4HDbY+2ZjXgwOcqcH+fHlFcA1EybotX7eRUsY
         vtTzstYRaDtJk15uHv5efE6tytiEb0o/5BQ7qbQs/oNGQ2V+0Oy25im1ag9xaw/m1aJE
         V9mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768936748; x=1769541548; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tmQDk/BLWI1wRqZTu5nWhzL/u+5+r4HjgBzcFiok0VQ=;
        b=b6IfN2CEYF8//c0DU3aWK1FSQhTr7XxE9s8mJRwXI7pp4bVEZvP3rFb2EOR1kB6SA/
         voOIw5u59NNctXasK9Ym1ANYEOt8fOFJnLPuyox+XW9yCpdYBKyFQA5/mvJlkyn3c57X
         WUvcp72DAWk1GkRN5q8YMO9dEBfV3UdtUTcu+vcXUkqDhbhdm2nXfdtBbfNnfrsZuSVR
         Vvr2PLGL/9fUK3bUCnjjlmt9FN2DQ0aH/XCwCvfA1Eyv9raPiqIoMPj0YRN9RDWHWzEC
         ULiTqZ97j+rAiyxt+7APj2qIJQcHXxLMf7tOttKljPlB3eM+9UiCVRSBGLa5SoFGQS1I
         Njlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768936748; x=1769541548;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmQDk/BLWI1wRqZTu5nWhzL/u+5+r4HjgBzcFiok0VQ=;
        b=f/ebY3uSEFGJgLSQ7OPvde99nWFAfFmcTjXw56cHti9suylX8+vUNCyehgUbHt2aBt
         SwE4FOluQIBw9SylPEdXG9csuWxxwLmB6G8nA3SCSUubx+wjnh9+G8pQifdZSLHf2TDf
         tYqeo6FeimMDrz9JIkUGibf/D0frCOJGnLd+Y6wXBM/gVX7Rgf9XQWnBXz5iFEXh3Nv+
         5uK3ZmOOtIgxfSNJ6LvjLROUdA049SD1pvC6h42i2Z0+TMdzvuLR0OMQV0iN2VMHggBY
         jEwUCwLwDLelmiXEAqPxww8ZweLnuS/4aTvNog9B8QYgbcDoYJTqhIR/jbfWv2rMV4Cq
         du+g==
X-Gm-Message-State: AOJu0Yybz2nmawiKRmp1ScS9OyvAgYcbLq2djZwGsdRsW+vnhpjD9ZhS
	DzDGltwvL8Osx8Tlz2TygKNvf3pUvdYtFBGziNfG30m0Ia8tVPzMpCvYZG4R2n0moUc9PHQFqhL
	jviK0Rd+g4acbJ6Frz1Aa9Aij5tlJp/hOYuSzBK8=
X-Gm-Gg: AZuq6aIdC3pFV3s8fHqOf2jMLgEdzFDGXkXVi8nXAAZGFms+Ao0PXva2qg7irvmRLw/
	+z9upArm9Rt9v912VyHJM8TyWezKZOyel/nVY4/Ins4ehCfH1nmz0YKxIOamncvOAjfVz9eqKVJ
	MCbN7V/GU0/Fkl+4fT+QgfgRghssUrPe8svVpjRImQI/itZakd1vqCv394Mi83CrporDGL+jcj8
	6P3WSZ4oCWcgXeGC5EYuY0/JcHOn1N5gHJDmEjkSh/MIB4idAwTt/gZ8W9DLf0ebidewwE=
X-Received: by 2002:a17:907:7f8e:b0:b87:2e44:a2cf with SMTP id
 a640c23a62f3a-b879691c762mr1316293166b.23.1768936748304; Tue, 20 Jan 2026
 11:19:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 20 Jan 2026 20:18:31 +0100
X-Gm-Features: AZwV_Qg-lR8u35FIRQhE1lOwj_ZkqiGnSQRRhhSgovVeWGLRKO7xzH5ygdhTrpk
Message-ID: <CANH4o6N3ULoZ9bW-0A+S2y=4F05g29_61a-jW2Q35oxfnE1oxQ@mail.gmail.com>
Subject: Linux NFSv4 server supports FATTR4_TIME_METADATA ?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18206-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martinlwege@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 945284AA8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Does the Linux NFSv4 server support FATTR4_TIME_METADATA? How reliable
is this on ext4, xfs, btrfs, fat, tmpfs, ...?

Thanks,
Martin

