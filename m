Return-Path: <linux-nfs+bounces-7272-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28019A3F26
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 15:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73213281EA2
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 13:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5737B433B5;
	Fri, 18 Oct 2024 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLAX/9vd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355C1CD2B
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256851; cv=none; b=hDqCMkqHBlh0Xn8+LYDjhC0IdSHOxEf4i3LJzVoQcunEZlrO5JS93WwQffmmSdLd6Ip+I3eFN+1ma9fB5T1ra3O4BIcM8495KvaDnQG1WLCRjEB/SxVbMJBILEt95fGmlnvBo7ddUeQh4WI60i1uiemickWsiFMZvf/XhKTyL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256851; c=relaxed/simple;
	bh=Saz8kr0JOpJuz85G/iY7lT7xt/0pu1YzJDxS8vpi5pw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WQGM0t3/Q0HSuDKy3WGEk3z0acRw1ILU4QwYnwneT66mOdV7xVQNXc3Ze2bRev1JfccVdpMGPln3H/uG50NbEPBYdP5w6yraN+FBdgSYpaewAc03k5LsegWYD82Ts2MKo/e1p3dLScW3DQQ2nc+ua9zCaoT4NY2XSrBpp3p+XBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLAX/9vd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso2468844a12.3
        for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729256847; x=1729861647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=meQ20/1SujNWGSO/W5meSIMP7qAweE6wBonzNDLiGuY=;
        b=WLAX/9vd1h1btjacghR6jri5SsFjYZgYInKfWKnGOzUdEbc6KsC5HGQ/3SJkUvrkF0
         UzpJXVtCInj0xqD81lfcyo2WlGA9/pXganVzRbuGJYU1m3k/AuK6Qz06K0jvwA2dgZsE
         obEqaaquNd3N2hYikzkhzH1Je7vkbHiGd3vWTpbC0T4GZKJWTUuxewC9Sbv6BinpBqrL
         /6x07xFqJdmlWDmtn5DG8fE6POKCvjHAuLQLAYaf7Vt0GqHwqb4La9VOWGZN9rFUSz5N
         woctTJw042YJ7JZE6dycBlu3dVZTg0peXsx1KqxbBMG/miHVxThl68VyTDc04faOstVD
         eSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729256847; x=1729861647;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meQ20/1SujNWGSO/W5meSIMP7qAweE6wBonzNDLiGuY=;
        b=ZFV691pH/q0G3Df2vYuDJB+gCdiNA6eyEPDRJlJhW2HiyAR7oN1pv/BkOOgqxPB3Ht
         mJkoyyuDsN45ZMYS3c5iQRrJ+ufoT1xtq4o58Ln7N2sgwHWGApxC6N+G504d+RUV/fnC
         ll/g3htx5VtxloLuhEWeV3DKiM72/iS0lqIvF9yDjA+LA8vtAwPvz+1bf8CSc/zE2D9g
         VROFDCrUGEsslFgCr2lC9fV/j60+jCzs0eP40hllQ+k5M2SJSDRzNqsWSgX6zY94DiBZ
         0aoLVb4W/TaSTGDcdJNofGCbMX+S2OOkrQDpgoG5hYcLuSG6D9oXmAMTe0OqylWreSss
         LLag==
X-Gm-Message-State: AOJu0YwpM6FXVtzCwbaXkziNHLrOFb/fkLhXz9SByJlX6YMOeH4qkLN7
	O5cFi0LtoCSLbD9W1wvUcgzNa5Kqc1tMntPYpCFsoPf4L5qx3kxGt0Wunh+JOOX2UFRWufF3gjj
	wFPeKq7CR1P1EvHxJmQFSwGodGvlUKlCy
X-Google-Smtp-Source: AGHT+IE9tObVq+DstAmE3uS9MFgpsHgZcSMMbCmf3TwOQAq6hVUvnOMOx8nVsxOjikIAryGjXcwOs+gqUB319jYCbqs=
X-Received: by 2002:a05:6402:528d:b0:5c8:8416:cda7 with SMTP id
 4fb4d7f45d1cf-5ca0ae806aamr1580607a12.15.1729256846964; Fri, 18 Oct 2024
 06:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 18 Oct 2024 15:06:50 +0200
Message-ID: <CALXu0UdkaXPMWEe9amJ5Ugg0rw3CWnQMLDyhx6PtPc6oEKoPMg@mail.gmail.com>
Subject: /etc/exports refer= syntax for raw IPv6 addresse?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Good afternoon!

What is the /etc/exports refer= syntax to pass a raw IPv6 address?

PS: No, nfsref is of no use, the target system does not support it. I
need the refer= syntax for exports(5)

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

