Return-Path: <linux-nfs+bounces-2738-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCA889E4AC
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 22:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAB51C20C4D
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 20:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9285C15885B;
	Tue,  9 Apr 2024 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DilyxIPA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268361586C1
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695818; cv=none; b=edvxsUYWrWyFDz63ICkPyQhXtvAG9P8uEw0tI1P4aztOB/nEbP9Gz0tPLEUp1a3XOyAVSM90MSMAJdaS4Vdvp6EyQqlE+AayOs/1jOKYMGukhicVneYSu4PUfGLO1npi7QHF/JAEKsICB6rnrJfMF6UW+JdktUpfRmnkWw6JtiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695818; c=relaxed/simple;
	bh=6r8Pjys0GBYGYZoUpzmWT8IL1jW3K0ckYvTZI8/BINw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=omyAm18i6HxneAXU8sqBsOgvGSedrbGncN3EncZWcbfy9KWm0CuuEzCtPksyxgzQyY47AQlmji+ICaz4vDOL07M6BBSCFBWe9hOZ9gutKojy/KTylZXt43+H5VBRPJRzUpZQSlGzSb+8oEhr0VrkUme3ONL4k5Z1A6TNd3PKiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DilyxIPA; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so4442740a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 09 Apr 2024 13:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712695816; x=1713300616; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6r8Pjys0GBYGYZoUpzmWT8IL1jW3K0ckYvTZI8/BINw=;
        b=DilyxIPAqCC90LF2aWHSoKiuPzeywNJhjDHbI3h0jY3ZlSrzgZYhGIVLPgzEMJGHCh
         +/JGRF6CQdN5i62+2rCpTgExXXQ1jCmYMi1oEF6Gi+D1RgA/2zq6g01Lnt9o5H7jnOWe
         TxTqxGsZ2V6MkiwwdmoMPuBRAJl8lo85lly2SmTNFlwsYWa01rSHg57w4kt+egK2y6Mo
         vqgLsrknjErOvaXDJ0ahmqjR3atrtX0yKDeMcSxxE903AS/kvVE42TSZ6u73x99l4bav
         8CTrl5DMPe548dg/88Phbrp6c9ANjBeNApUGhyDEYaMiBsOKdweLWdipVTkpJf2xRv8I
         8piA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695816; x=1713300616;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6r8Pjys0GBYGYZoUpzmWT8IL1jW3K0ckYvTZI8/BINw=;
        b=uuWhL1+8GyZAYmXeebJhqfChIoBP/QNvBrdhvUJO1RUTI90rcNfbggCAPxXTcJnDBE
         x31l7Wf30rqKgVQBbVMiws4trCEJA86doEPsc20ZMLstZotGaRBsJCxUJRGyXL58CPzb
         oJOFiyuZD9vQOAYq8YLz9aGDbTHzy6zDw1fZMo9BCSfEqcR3Acw5SOkY8AZh/h5Zr7kM
         f/fN3v33+UAYs5a2ZTzKiEAeEDTGt3Yg4SgoxT9ig6+OxQVpS+NotvgoEcKJ6VzI+YFl
         rfBBHzvcRbaMBTDZnLqKKQ9kvQNx4nk4+EKV1IArKYA9Mho0nEnhAKtnzAcOH80X1tpK
         H/HQ==
X-Gm-Message-State: AOJu0YzE9gkKZMM9nDjTpqIMcqbB7swKk9mmpGiw8mU8hGYerkVVpPUQ
	C1RuX/sGsNmRPGbtD8XkQtbFBxivtmBTvxdee5tiv5PcCrDczllRxclJRiLsFfx4c3b59y6XTFB
	Flcdo72HfRGLFnF9iS6w179HALbLx7LcMYq8=
X-Google-Smtp-Source: AGHT+IHXPKczgu/ehOtuNnP3k1mZqK3+CDaZGVU+5OaA6SGV7K0PEwLYPwG/3U1yYhXFCGXWHvHDjUbQbjGWCyJsq9c=
X-Received: by 2002:a17:90b:1894:b0:2a2:a243:478f with SMTP id
 mn20-20020a17090b189400b002a2a243478fmr805946pjb.1.1712695816114; Tue, 09 Apr
 2024 13:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Z=C3=A9_Geraldo?= <zgcarvalho@gmail.com>
Date: Tue, 9 Apr 2024 17:50:04 -0300
Message-ID: <CABJN9r6n1mxLNqFo2nsM9gBz6LDku9kk_V6c-85pMeH=CGzEaw@mail.gmail.com>
Subject: Configuring NFS with UID/GID Offset (sec=sys approach)
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm seeking advice on configuring NFS to handle a specific scenario
where the server and client have an offset in their UID/GID values. On
the server, a UID/GID translates to a UID/GID + 10000 on the client
side.

Ideally, I'd like to avoid modifying server configurations or changing
client UIDs at this time.

My current approach involves utilizing the sec=3Dsys option with an
offset to bridge this UID/GID gap. However, I'm unsure about the
effectiveness of this method and would appreciate any insights from
the community about how I could do this.

Here's a summary of the situation:

Problem: Server and client have a UID/GID offset (server UID/GID =3D
client UID/GID + 10000)
Goal: Configure NFS to handle this offset without server config
changes or client UID modifications.
Possible Solution (under consideration): Using sec=3Dsys with an offset
in the mount options.

While alternative configurations like sec=3Dkrb5 functioned in a test
environment, modifying the server configuration is not preferred.

If anyone has experience with similar scenarios or can offer guidance
on using sec=3Dsys with offsets for NFS, your expertise would be greatly
appreciated.

Thanks,

Jos=C3=A9 Geraldo

