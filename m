Return-Path: <linux-nfs+bounces-968-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DDF826626
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jan 2024 22:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0995828180A
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jan 2024 21:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB90711738;
	Sun,  7 Jan 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDwwYs+R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42611725
	for <linux-nfs@vger.kernel.org>; Sun,  7 Jan 2024 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so1346069a12.2
        for <linux-nfs@vger.kernel.org>; Sun, 07 Jan 2024 13:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704663184; x=1705267984; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RhFrVvXSRdQboL9elGAp8X1K9COgrXjN6VH+GgnlYP8=;
        b=nDwwYs+RKXKLD64bzM1TIBfCYBYSwq3EgTk/Gvz5cdUg9c6rgSq3jTDWMZs4tD0ZTu
         zX20tN/sUdL3wxL8ugDQabDxCMjom2u787QgJcAaXMo8oE6FFR6bqNhKJxU40uNbz/5u
         ICY0Rls1asSDy5eovf6MPqOq1LCRDktpE0YedlmO6kltthgNHFhBNYECH4DUkX1qy/ZL
         5CkqbhmidMZqJuzS9BHqiqK/pymkKIxWkDG7nr3OEZXqoiYuSk9llPXo9+ndkU7D22la
         UqkirnruZj/R9kvuWGwbYLOP2vqIGNJcvPS8fG9ayNK8TgspRDF50U0v9OXF6oGWYNmF
         4nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704663184; x=1705267984;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhFrVvXSRdQboL9elGAp8X1K9COgrXjN6VH+GgnlYP8=;
        b=jKyIWrupE8w6gALm2tVgUWwrqDJB+MgXI4uQhKeiOJloG/9y7JjAZ1ndZ6of8OCIFP
         i+o0l2c56Qrr2uctfYEMppA3Go7vJ1hfzO5mL2VnPfVMXeD1Pki++aWrVP+JjNxOpy03
         Q+x26870CZ+JmnrSRk0tcV3lF6rQjnMjpowLUVQIiO9YIHBSrxAH2D+U/9fBHCVwzOqA
         3yw506V8bP7sVhTDyINYRBlxsrlrS16qFUbpJ4dU8KMr20LMxKalJWDzGnK1Da9AoDpX
         ++q0jGf/esVhJN/E00Z2Bh4TVJv3ZkhrSw87Kdrh3lskVZoPRK5tRDJeebpmakZmodNe
         UPdQ==
X-Gm-Message-State: AOJu0YxsFpSlpiXQuG/IqYxRUIOruuBcFNURiGMB7LARdlnoBY+JQO33
	n1Nluos3uDRpVcQy4gxfWbr4Pmvm1sc2zpiSvTWUdiDduNA=
X-Google-Smtp-Source: AGHT+IFu4GLnO8gqMi108GoV4oAb4ZsVuHbvwOmwvfbomRESsL9QaRv+3F2x6WInFDXmdoriv+WA//bAD812fSpZ/xo=
X-Received: by 2002:a05:6402:14d9:b0:556:8712:879e with SMTP id
 f25-20020a05640214d900b005568712879emr1064322edx.97.1704663184112; Sun, 07
 Jan 2024 13:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sun, 7 Jan 2024 22:32:28 +0100
Message-ID: <CALXu0UdFR7Xn51eKFUUi6a68wvDKc-RXz7F4LKyQgDptqfYbgw@mail.gmail.com>
Subject: showmount -e with custom port number?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good evening!

How can I get showmount -e to use a non-2049 TCP port number to show
mounts on a NFSv4 server?

/sbin/showmount -e localhost@30000
clnt_create: RPC: Unknown host

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

