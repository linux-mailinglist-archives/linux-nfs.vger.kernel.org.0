Return-Path: <linux-nfs+bounces-5063-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C90D93CD62
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 06:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764051C21759
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 04:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAA622EED;
	Fri, 26 Jul 2024 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X27z5zcG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54FA28EF
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721969251; cv=none; b=GUcap/BWxjFqD+BUMDdHiShKaPKEsjaJfsPQM4nXGg5yfzIRUNYzYzMVv7WgnuJBDyIDlda+kXG27068BWL4vzzikTRPhXeAsr0I3mBD8jZqIefGckRQiUhp2651ETlt0tYN0MIUK/Yyq21TaV4MW/qGML4LsfpX+UDKbTEIdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721969251; c=relaxed/simple;
	bh=90U8ZTU15PuOhPz6p4Oiv+lu7unJxHXHKdSXe4FDuWY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oXKGefRMgW59JvOh8D+oAyssky18rAuSjyeDEYvH8bp5NDj2OqgtHxw6BOWRW/D8lBiQ9AJuKSAtmuBNeK1Hbrbqu0U+eERkOIi6A6Tk5ah/XLrXdl4TXoi6GzDLb6Sfke0F/if5JYLfnIW5Nx2HNn6LUa1mYejrmdal6V9PshU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X27z5zcG; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efbb55d24so1303257e87.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jul 2024 21:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721969248; x=1722574048; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qYFdpbZDymiYARgGaSu1xV6L3YcaCRW9LPPjoZmr6h0=;
        b=X27z5zcGu9Vf+1BdG357NyQl5paKBPZJuCaI3dOuSil/17eSz3ssyR5zL+sGdHekVt
         hVagoW36V3gn0yhxTjiX33waDHuo5nWFvcfOP3LP9QMfoFxC8GXhH8bEQPBU/0mCqcUk
         i2ksPNy/zAaBe6T0aeHFT+ZpEfaJ64wz6AgXTDhpy7CzsuPetTCuGBqQE4YZr7JXxZ2f
         ZSRzENtvYBuEX39t+11Ij1FxmyEf/yC2GeuwKzO0pn620UqJg93o7/IASMtU5hgBuj3Y
         qs1zd8iOLqZrr/8zY0S8ehrHYmb3yfSGIYpmw4SzMB7wVJo+PmzUpXTp/SA3n5K8ovhv
         ywOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721969248; x=1722574048;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYFdpbZDymiYARgGaSu1xV6L3YcaCRW9LPPjoZmr6h0=;
        b=rW6CvV5k2c3zKWwNE4SudUn5ptNi5o24uHjsxchaGh82EXVTd0jt2gjyrblReJIfsW
         lCLNufNRSDfLjVA41PJ3TJrDtRpElChv4+K+TJGwwxDaf5jrDSGNa7OrSXqKRPGQOkM7
         Dhp/J8ieIaRsuK7moqws78eGWD3ai60l88pBowS/1ReT47N0QUgrbBLmbYZx0E9pZeaz
         rzLoeml3qs95oR39koZyaNdzMg6NDFTPu5F/yBDpRbmXZ7s91EjWLmp/8Hpl0PqfAJ6w
         Ro5vUgEUrHeuFoG5vyJyTHMZkOH60dLJ5gqwbFfUOWTWMDiMtryG6XZtHQm3r7Pc72CL
         odmg==
X-Gm-Message-State: AOJu0YxbnwP9s/7G51YTIcKs2vp3236FSiy1OYdhPUrcNcF4QAnqRwT1
	9apCyAblvUOGJFdXJRCrHNSfPCjeFznc0XMoqG6fvkBjXm0fxjJjoB/14wpSQtDE9e69Pp8SV1Q
	2htXn9J2SCsKVO/CSGVHE0JRwbXB60Q7m
X-Google-Smtp-Source: AGHT+IEPVkjmb4I3UEbMliybqlYQHnBv4LIzri+pZst1ETepl3smIuG3UtEqj5yyft8mmeec02yg7fP1BnkoCRz7+PU=
X-Received: by 2002:a05:6512:e8b:b0:52e:933f:f1fa with SMTP id
 2adb3069b0e04-52fd60a0e65mr3686181e87.61.1721969247588; Thu, 25 Jul 2024
 21:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Fri, 26 Jul 2024 07:47:15 +0300
Message-ID: <CAAiJnjqd3jLK5Ghp6Ja-JXWkp2W07XDo+vDtThRSx+jt7eiTkg@mail.gmail.com>
Subject: number of nfsd threads
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

Are there any rules of thumb when configuring the number of nfsd threads ?

I mean the number of nfsd threads should be equal or less to the
number of physical CPU cores, etc...  Setting just a big number may
cause overheads, contention....

Expected workload - 10's GB/s sequential reads and writes from many
clients using single NFS shared XFS.

Anton

