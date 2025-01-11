Return-Path: <linux-nfs+bounces-9142-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7AFA0A5C5
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jan 2025 21:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085AA168625
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jan 2025 20:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33F61B78F3;
	Sat, 11 Jan 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZbRF7X/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0321817C68
	for <linux-nfs@vger.kernel.org>; Sat, 11 Jan 2025 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736626133; cv=none; b=P+YFNRXbPgyiPnhtPAmrPpIj3JZC8SDbsMaN3PhZgVnyXjr+jWNa4ZU9tb/kVkQxqS4raC40adhjseoLPshW86BVPPMCFHSFU7xDzWa/hztdn0OIEbOBIzx9TW71FY+Fk0SAN6nbCfI46xCtNpgkU5lZetMM7rtaMNjUA649Dq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736626133; c=relaxed/simple;
	bh=wtZpotcZhpKYlglxc1ewIhsB0m9+S8g+eQ8nc0ewfyY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eaCAy5xL9m21y2PA97b6BjWHk2C/wGsPzzHaRwD2VWJfgftg+67THodwxv29MRRqUSomtQELZ5M70rqWOsh9Sov1lninSqSLw+1K2ckBH2n84m41VjKj6gfV7eJpPByG7x6rld/Qeb7OV3eOzB20WC+AamZPCzdENyfXoLypz14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZbRF7X/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa689a37dd4so579517266b.3
        for <linux-nfs@vger.kernel.org>; Sat, 11 Jan 2025 12:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736626129; x=1737230929; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wtZpotcZhpKYlglxc1ewIhsB0m9+S8g+eQ8nc0ewfyY=;
        b=OZbRF7X/s+8eURyzd3MKWZr42yxkGShIVz4Pkf5GJ+gCJM1Cv6bMgBvkNe9ufnalpH
         P2dZ7X0xB0pO9wre14n9tYzs25QsniIoS7GFcLTgnlpo30oQmw0iVLQyhCQlj5iUuxBs
         vQFplPZ58I+w97mmMo0lTgT7yQleZCXhGXmZRlqM4BCkTg78BuOD83WMm0GoSGXUT5AA
         9X2anYelHa8W6bGEt34TYPoL7bDdOKUkprIX3mTWbnvfH+CaHe+Dg56GqN8vsrS03t9n
         AU309REWWpFQpC+sckbILZvWyANHQvgy2RThmEfgJrzSDiUcfVEEawfrbolhS5Mt19PE
         t0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736626129; x=1737230929;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtZpotcZhpKYlglxc1ewIhsB0m9+S8g+eQ8nc0ewfyY=;
        b=RaHhGH599qjR0HqtAzi48X304/XtdLLjcBNSq0RBh8Xn8SBcJlgzX/cKmi/8P6i+nc
         ta1Rw31opvKkVSyT9rniozDqhjzAkgrk7Dvrlk5BLXNiGVcorgnCGw1bBqwWqgwXBh08
         OkP/j04PzilO26WfWbKZPRjvmUMeNIYPZphXpsqW0j9wAB/qzfX/5Bf8Cx1Tei5YIAQX
         VlxTs1R5RK9bG0hMs0s7j6gJmMQBmId8dbQfkx08aeVryRsWEnN/+AEXTa8//9SsmaO5
         do6fivPDPqMiK7v67i+EnbZmpBcrCbYJsTeq0mFqvOddNYl7L6mTWne2Ruw0PTFOIKo0
         jqaQ==
X-Gm-Message-State: AOJu0YxJAb4W9r8wbf6bjVc4RmtfT4mUK3lY0saWWZ2iYVNQ5JGHdQ5+
	TPC3jD3MQEngLN4jcgmpj9w6m7uAe92bWN/Cy2OpgaixS9n6kX3ZYMFYv+3+RixxZkbw5RAFUXy
	mIXkx5+7DMFs/VHo+taor1DpY9sn/Fy2c
X-Gm-Gg: ASbGncti2nziTesKFf6ELuPkMsnBqWdP3k9CBVVcdsHihl+6t4CeIWgjy1gZXwAUV+6
	fc7XDT5E8AYPbj6bzx2Vvctp+NTi+NKPlpuPPR/k=
X-Google-Smtp-Source: AGHT+IFF2Mm9IsoV/U/6Zuhn7Zqs6Q53AUf/Cv1SZNuv7el3kWomS/u4wHzns8gt/u1glg7R1NM2/1+vt174wgLucvQ=
X-Received: by 2002:a17:907:c10:b0:aa6:77e6:ea3d with SMTP id
 a640c23a62f3a-ab2abc92415mr1451608466b.45.1736626129031; Sat, 11 Jan 2025
 12:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>
Date: Sat, 11 Jan 2025 21:08:13 +0100
X-Gm-Features: AbW1kvYTPtJMc9V-hR83-k7IDSseZGySq9auMRli70U1i1sLP_Fc0FhZwPEt1Qo
Message-ID: <CALWcw=EPJk3XFNfXG95v4A3Dq7=spqh5aLYru05r9Lm-eVep6w@mail.gmail.com>
Subject: BUG: Linux 6.12 nfsd does not support FATTR4_WORD2_CHANGE_ATTR_TYPE
 in NFSv4.2 mode!!
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear list,

We tried to use FATTR4_WORD2_CHANGE_ATTR_TYPE with Linux 6.12 nfsd,
but the server does not set that attribute, while it is mandatory for
NFSv4.2.
Could this please be fixed?
--=20
Internationalization&localization dev / =E5=A4=A7=E9=98=AA=E5=A4=A7=E5=AD=
=A6
Takeshi Nishimura <takeshi.nishimura.linux@gmail.com>

