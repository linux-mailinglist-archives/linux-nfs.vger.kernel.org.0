Return-Path: <linux-nfs+bounces-14032-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B34B43F0C
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 16:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A497B573F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18752FF649;
	Thu,  4 Sep 2025 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL89va8C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BB30BB87
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996426; cv=none; b=PYL1uOnHDMS5S6w136R9mGM8TWGyANE/HO0Loetoxp/RHhuLpz8Kh7MfZoHnfl9Kk3He/sa8wcnTpfPyO6CfGy54z0YkQqIx7DF9ywWjOyoCcRj4ou7e614Yy4WABiGwe4ZHNBsjyau63N8CZo8AFt+VlOaAk44yYod9uYWTnmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996426; c=relaxed/simple;
	bh=/7s3Wm84M2Rsy7gzk1wo+wwQq05SNYq2B4s2uT4xgFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5Ltsxkpah4t4ixx9H8yCrxiovgzfVTAxHNtp04i2BTaAiwQwyR7uJNUMShqiNmF5wYxZEXDHPa9tCOOrZz+/uHr3GgIItj2WWLow2tYYlz6QOlZfcuotxCMbmZDcUzBd0GGHLMPNo+E4UN2N1kL6t3JeX2opmj0xkxnR4k4fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PL89va8C; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c4af9eso10504321cf.3
        for <linux-nfs@vger.kernel.org>; Thu, 04 Sep 2025 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756996423; x=1757601223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRYTixjEGWlDXOxPIuBKCec1Af+v49zBHmZsXxwHTX8=;
        b=PL89va8CaTuEjRmKDK0bmL7Z/V4wy9W0Uyf0HDUNjms8Q7osHrT0EoSltRbxYSDuWd
         ajf+JJV0KZwLf6xJp/qSkx0OAkl0iasz25QcoGS0yYCMkG07ms2XFEBFpX6yLzfU7A5V
         C51Wk2qOj6TyCduEzHwyn5iapI9sd/5whzntDz7k82kF8YSZD4gS2bes7t5+9tXU+Vub
         fdVN3BIaDxX74lFN58uJpbBwaJhAaz115nvxp6mxrog9Ztw3p/YG+yGgXO1VuJDg01ZN
         ntlHZ+aS3ZYKaMTnUmv3CVFLPud4ftlA7qsJlVjRKPnXytPFPjfFPYZRniBR6yGohJ77
         l9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996423; x=1757601223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRYTixjEGWlDXOxPIuBKCec1Af+v49zBHmZsXxwHTX8=;
        b=HLrmm1p240tyq3tZj/FJAKlRCmC0XV5MlIcQfXEn9f2Eh+LgSE9v1IgD5nADj83R0d
         mJny/kV84z9PInmw9ZmlzXqKyepEmJrY4NNt3LGC3wbNKgnElz5zQ6TTdPTJnMkRE03S
         pfY++S9VpAVLvlgs9ntINkYDbNnrLHc8F6mQnsdbn513xPq90p+nr13wxEhpk3Tz/xJG
         pNDPw/wDAa150Xj5flzxOHnxkY6bcT82KaX2YF3OhNLY1S4zDoZITDfvi0+BoU8mR/vz
         iYGiOTOEA8T8PetySCLviwYPIjWrxUK0YZmOpu5GR8tbTdxXf4SpcdX3j5umVMMI/DDy
         wC6A==
X-Gm-Message-State: AOJu0YzjU8JwDI+Gx/8W5r8z7mQ66z6QNBpvijZP5DhgZR0vI3M3OPCR
	GmM95bnqoIB2PowtVJxsr28HJnM+ZFAPj1Jh4FB55ustKD3UiiPSZizFwynNTw==
X-Gm-Gg: ASbGnctDR3fGnto8UhmNJF7bHFnKVcv+uJ5gV1oKhhj20oBzRvUm8fK+upxkaYC8ZTZ
	+zfh8sisDpOUWPbCc1iAjiPmrtIzkovL9SKZYYW18oFsPKWxvQre9+8aEz4Z31bbALwbgSmI7uD
	cW+L5huCUSYhlld4zVxqye7VwerY73UOS1OWIY7AH407b4rnNR8MZUEz/1ULTYt2idEKpYgTgrT
	XqlU8c42hiM+w3x01KX18JB73oMxaiAVZZ40cOciW3oEqiiRRSsbVn9s2TWNsdRh3s6bZiAWNVY
	43vPLOeq3YKNgthdGEJwlJNzNKb44VYMeE4Yq47gDiNQiWPT97beQ0w8or+/6Qd3WxjFlTgUsG0
	ZmfL2wXshymSyviLvgnnvBL6CI29iZt3zVEKe0w4g66l3JKlwROWbKBzhc6U=
X-Google-Smtp-Source: AGHT+IG2WaLIWM4qUx2YOQKEO6CyfBy1kbs8/aoFMB8Mdzvlk8SP10W2VqJH2hmlG5vfVCg3QWOf1g==
X-Received: by 2002:a05:622a:50b:b0:4b2:e166:7a84 with SMTP id d75a77b69052e-4b31d547b73mr229792581cf.0.1756996423223;
        Thu, 04 Sep 2025 07:33:43 -0700 (PDT)
Received: from justins-desktop.glenwood.vitti.io ([104.222.93.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aaac08a6fsm284299685a.40.2025.09.04.07.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 07:33:42 -0700 (PDT)
From: Justin Worrell <jworrell@gmail.com>
To: linux-nfs@vger.kernel.org
Cc: smayhew@redhat.com,
	trondmy@hammerspace.com,
	okorniev@redhat.com,
	Justin Worrell <jworrell@gmail.com>
Subject: [PATCH v2 0/1] call xs_sock_process_cmsg for all cmsg
Date: Thu,  4 Sep 2025 09:32:59 -0500
Message-ID: <20250904143302.34217-1-jworrell@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aLirFyirQpRRW3qr@aion>
References: <aLirFyirQpRRW3qr@aion>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

My initial attempt to submit this patch was not formatted correctly. The only change in v2 is me trying to use git send-email correctly. Thanks for being patient with me. 

xs_sock_recv_cmsg was failing to call xs_sock_process_cmsg for any cmsg type other than TLS_RECORD_TYPE_ALERT (TLS_RECORD_TYPE_DATA, and other values not handled.) Based on my reading of the previous commit (cc5d5908: sunrpc: fix client side handling of tls alerts), it looks like only iov_iter_revert should be conditional on TLS_RECORD_TYPE_ALERT (but that other cmsg types should still call xs_sock_process_cmsg). On my machine, I was unable to connect (over mtls) to an NFS share hosted on FreeBSD. With this patch applied, I am able to mount the share again.

Based on analysis by Olga Kornievskaia, while this patch does allow Linux to mount FreeBSD exports over (m)tls -- it does not seem to fully correct all underlying issues. I think I’m a bit over my head to analyze the protocol for deeper issues than what I found (which was just thinking through functional differences between the old and new code, and throwing stuff at the wall till it runs.)

Obviously it is up to the community and maintainers if stands alone as step in the right direction, or if a full root cause needs to be found and corrected before proceeding with any changes.  

Justin Worrell (1):
  call xs_sock_process_cmsg for all cmsg

 net/sunrpc/xprtsock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.51.0


