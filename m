Return-Path: <linux-nfs+bounces-3978-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDA490C7D5
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 12:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEEF1C22A95
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39134156F47;
	Tue, 18 Jun 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmr5iRGF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE04156993
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702464; cv=none; b=FvpXWaVllReVVoFWK1I2I+CCPiqz6KArIGtbJyTdrtgxL4uvIdBPfro8irYmeZWOJ4m9OMu0A1YlRQdSVd2u8Yp3GlzsUBs9i0o8jq/eJFiSriQRzgX/yx+6uQ6GgBPIxLbWqW4yGAm105yPDYWiv82hzgC5qM5TGvltF5UFb80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702464; c=relaxed/simple;
	bh=esKFWtUZOED2sDn2l6IFN8lFTUYYgtFIusCN3vgbvK4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Jg9fJyp0oLoVZkpl7+8/IgezYhseaEkCJMfQA0ZNdIerlU6D5SKTBZRBUFU005nIhDgp6eHYTt0hnlWAl9yc8z8cAvVx55HXiVSsZ84nQF24yhVinzjbj/aeQXNUHXYHw6baFPC4owJAsPxwAh8hVzFKPqZL2s/Z2kToGb0uEtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bmr5iRGF; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295e488248so5733723e87.2
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 02:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718702460; x=1719307260; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2uCQJv12kRXk6c5TcjxJSWslPgexWM5ze2b1Yyh5mo=;
        b=Bmr5iRGFjHZv/x5NwkSaQ29Lb3nHXnKUk9Ch6Typ2494Gj9aVJXQkQv1YaxxB0S7jq
         NjcKLZA3KT9g+n8wg+ckNouHgVtHguoDKtExbFq1p6NjjWfFuqE+BUCRBa4SwkVULUuB
         2s6OuyMWmFsGFZ3KRSPhf2zWKRxeFXAIQ3fW/F/I2uqqTOgHw/9FVAf8hNivLMvOZckz
         umlfP9qdt2Z/trpyILTOdjy7m6/ccH8o98heyuHCbsrWHvEeUFGdy1cKA2GenSJ6Yv17
         4m8BeKDByIfE+F9EgjiltRuPxT82FiNN/KTCzyngvtGjK7utNwn+3hP/hbUkA3W3O9Wt
         IDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718702460; x=1719307260;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2uCQJv12kRXk6c5TcjxJSWslPgexWM5ze2b1Yyh5mo=;
        b=HIOEM53Z6/pDPQ6ID1JA6Z/zqv5pI761kdBr0/VCVnKnzc6JWuGIf/THNzTCPaUoDR
         d8XW1tnC5tctvzSF5PPGR213hDEgE1woKZ3JXs2o7iCqWuMCm+HpJeY5nQD6hYhedF5q
         g6xCMAyqqvRSLZBCWo6blHSaPCF7wZ6+tUfcY7OWpE0WedJh8RlVSqNqiPllACxMGgD1
         jw/PZjwadInLH1zLhQH56QDBDXHhVJItbT4PIQk7kFEQlp/nzSYXbJnieFM6xAigE6PJ
         gVl8Apf11NmmnSbUIS7OXitOu4XUVBFNCKqN3Yrq2NA341lwOC0pl74n1YoUzq/B0ehI
         VmzA==
X-Gm-Message-State: AOJu0Yx/c/fOPECMBrpcdKsWwugiBa4QfpxIyWcCZ21eRAZbZeGaQFlp
	o1A3C52ndVQoTZI/Av0G2z5HJN3ChbE/VlWM+f2HW261gxtPO2u6FF9A6ObM7TOZgZPTirYgXtI
	5tgXcoPL2FBSNMt17kK+XFvttARQXLyWU
X-Google-Smtp-Source: AGHT+IEFoZyDRDYIUQaMzfubsv6f5njtfOAKunvLmTRxQA1ssDZerxS/TqZQrPoIXhgRddILu3hKbSB2oIiScO/UcpU=
X-Received: by 2002:a05:6512:2fc:b0:52c:8aad:5fc6 with SMTP id
 2adb3069b0e04-52ca6e65209mr5986206e87.15.1718702460357; Tue, 18 Jun 2024
 02:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 18 Jun 2024 12:20:49 +0300
Message-ID: <CAAiJnjrKr65w-DttnyOc+srDweZnpb_LfXMvCCyP64KrzNO2oQ@mail.gmail.com>
Subject: NFS 4.2 multipath
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi I have a NFS 4.2 server with 6x100 Gb/s ports.

The NFS server connected via two switches to the ESXi host,  3 NFS
server ports per switch.

Three VMs running with Oracle Linux 8.10 (kernel 4.18.0-553)

On the VMs I mounted NFS share 6 times with 6 different ip addresses

mount -o nconnect=16,max_connect=6,trunkdiscovery
10.44.41.90:/exports/lv_prd6 /deep-storage2
mount -o nconnect=16,max_connect=6,trunkdiscovery
10.44.41.91:/exports/lv_prd6 /deep-storage2
mount -o nconnect=16,max_connect=6,trunkdiscovery
10.44.41.92:/exports/lv_prd6 /deep-storage2
mount -o nconnect=16,max_connect=6,trunkdiscovery
10.44.41.93:/exports/lv_prd6 /deep-storage2
mount -o nconnect=16,max_connect=6,trunkdiscovery
10.44.41.94:/exports/lv_prd6 /deep-storage2
mount -o nconnect=16,max_connect=6,trunkdiscovery
10.44.41.95:/exports/lv_prd6 /deep-storage2

During test I/O workload (8 fio jobs with different files per VM),
looking at two switches I see that single port shows much higher
bandwidth -

2 250 000 TX packets per second

and rest of the traffic spreads across all other 5 ports evenly -

900 000 TX packets per second

Please help determine why traffic doesn't spread evenly across all 6
ports, more like 5+1 ?

Seems like nconnect=16 works only for the 1st of 6 ip addresses.

