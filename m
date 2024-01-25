Return-Path: <linux-nfs+bounces-1327-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1628A83B6D4
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 02:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468291C21C87
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 01:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D5B10E6;
	Thu, 25 Jan 2024 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzK+mQ+K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52FECC
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147348; cv=none; b=dUwrlS9hSe/iCgEDTW2x4+vMWYMvs7UJZ2jqdmmhxyw2LKPiGXTOnSnT0JdWd4JyLPSX9LEakkYnTOFc5PE6WvdesOYda38WF4EsGQmwbZCe+1G5jZk3O/JtPQl1hc+Nj1vpqxRmiOPkN65NcHRtxQ1z9Zk6rCamquA4r7HQu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147348; c=relaxed/simple;
	bh=arw7HJX/AQBvBHDbDIl3c41cuc1xN2sTHbepKdNOryM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=alhjOYbLlUu9yqOAfRcR+KXuN9KQYyy6BFWBhX95+35JqNraDUQiOV38XD26UNvYMmBeHekQJP/igqpSdLd1cena8j8DJerFVWPmQ0iVr4fKuUo4UJXefILI1EvEbPOoR1Qsl7No2SL5f5dawl/DjC/MDBXqTDd0FuzH+0SbYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzK+mQ+K; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf328885b4so4579481fa.3
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jan 2024 17:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706147344; x=1706752144; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dPyKT14O00fZfEcls0aEKiF1DbuFPbmUD/imgWNFVw4=;
        b=OzK+mQ+KD3EJovhU/3kqbB/CdxAE1ygy9citQsZrpYbV20un7MxNdg6pIgIqEuJLBf
         7x6U00euAeZNurMIUoZpvxw1CmqSUwkj8YXWp1qB5H3qMEt7GBxc7K2oILUG/40TqRPy
         EiscxsdAtXhmPMiQAJZqtVU8ozW7La0F3BZsz2H6YJgYuP0epRbfY6eE2dg2n8XZIBkD
         FrNQ7DDSf5p4Ehm2yCe+1m+croLkrBCyeGZrnmXLC7fywv/yA0zgi6dRycUNi5VpyWKJ
         nByNCQJC+z1yUGO8zEMw0yn70g+yqc4nEzs0R1teVsHAaW4OlqAerCqygf1PtV4JFp39
         Hoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706147344; x=1706752144;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dPyKT14O00fZfEcls0aEKiF1DbuFPbmUD/imgWNFVw4=;
        b=qi+YC+VxwYJp+dRJK7tBBXAAqo5pwKsBnusRQyNSC+j2yeh2kGY74AYjiJ0RtjkfQK
         2A5l40NZ1dUdEBlISRhkB7SGWA4MlnOU4FXfS3kjix0ThjeI2RAIg/I3GzHdXR9Bc2mn
         3eXymrAgGJqiVMm3BK9mnzO7ZoH3M0MbWJMOm9rRXlm1tpH4MfLkV/Trr7J1DEayAQT9
         +TzTYtHdZP1d1XJZ7cDLvh46PzN2s9xHmJAE3pXIxiVOqhMxnETavNDpkSHAs3GEmLZO
         ZU2kqVF0V3q6gT6d7DR3weW+57p+rM55fQ8DOW6ApcQ1Fl0xJcsrcuOIRMklGNnXVvXj
         PToQ==
X-Gm-Message-State: AOJu0YyN4SFKKLm9IUFZbYtHtq2mq0riot8cThPABmVNM/KsqcOWeesK
	Uwhu0QwgLSEvGH+L7lwRPHLkD71rHnG7EdSl0EoaFa1Hteipwjiz3UAcFswmUVOXAEJhdwMxCtD
	fH0i/HwNG+G9mmgIWDAsaSoF7LZ5CB5tKN0U=
X-Google-Smtp-Source: AGHT+IFsT3g3xpuT1x5tX/eOHKaHLBwso0/SgYIXKy03lAZJQ+mzEI6oKSYdXqm/+V+AixnzfwebNuPTqq2gfzFL/fA=
X-Received: by 2002:a2e:984b:0:b0:2cd:dfe:74ae with SMTP id
 e11-20020a2e984b000000b002cd0dfe74aemr115787ljj.52.1706147344282; Wed, 24 Jan
 2024 17:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Thu, 25 Jan 2024 02:48:37 +0100
Message-ID: <CAAvCNcBvWjt13mBGoNZf-BGwn18_R6KAeMmA7NZOTifORLEANg@mail.gmail.com>
Subject: Public NFSv4 handle?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

Do the Linux NFSv4 server and client support the NFS public handle?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

