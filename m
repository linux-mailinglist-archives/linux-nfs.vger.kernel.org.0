Return-Path: <linux-nfs+bounces-8170-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD4E9D449D
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 00:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1424D282D7C
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2024 23:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E30193402;
	Wed, 20 Nov 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzhU/rob"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FF13BAF1
	for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146049; cv=none; b=J+9NnKZwCYyNH5l5Ttust+NfaDLULg4R4oknVu3r9P6kyLgTZAvbVgQvr5EZbuQc87T+w934IV+7VDN+qsuAXknHZskSMTH9hMbAu3aBNmDm8/KfjCHMHH7QVuwJd3/eSUXH/wT5zW7JAJOYbqwGrHh/5b8nU83kbvJJasvSV7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146049; c=relaxed/simple;
	bh=bKR/gg+LZGo3af54PLM3rIFBTGBpSeQCcrVxQio4xyg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=X/FeM9Hj4gVekmqOjRDHsDobM3h9sal3Jl4w4NYXRa9edflKzPTgh2opr3P4VgFU3ETq0o+xzmb7C7ceUfx0D8dsLyvIGjldn/2oDdmj05ZfrfOfkwE70RB9XZ1aVAbpzwhAq6+n4jFCcf4BwEpnVE134m9gFtrLGZ4ccCU8rdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzhU/rob; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71a6c05dc10so737720a34.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2024 15:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732146047; x=1732750847; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Rz32jjL2b+3L7L28onTSEF8sBWdX0DHN0cbzo+DrR8=;
        b=JzhU/robMNsjI5WxKLsDU0Al1S5pe+OLsvEWebTsHmtvSvf/PQS6LJ2jTYpgodkdH/
         mTWARzlgIekpcImyBDE6WKnoVYLFnmS0fWY/LwpmTrhhCvFtweoBDpBv+w0cIPiw7QK3
         ybsXApOl7TL9PFRoxCDx9MkcUXqc6IpDIk1JhnEGl8reAGrkrra/xDeSrJ9c1DdoVNvV
         HPPyL+/XRSocjk/sgGxCYuGCxp6cYTX0gs+SPQdvf5R630FcRLC3r7/Iy8gNJNUX1RIT
         xSKc+bRJTpbVueSSg6fMVV6VlbVTWWwjwGGl9PSwFV8Q6v5FEhlVPkgDOXvN5sgJhHuY
         VQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732146047; x=1732750847;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Rz32jjL2b+3L7L28onTSEF8sBWdX0DHN0cbzo+DrR8=;
        b=URs4wdPopITcWKXyF2FAF/jF+CsVxEkhxQvdGma0CyQWycSlXVl5MJOBPx7ZFoqqP9
         2vjNkmjXV4vs4mFj9TpfDOpD8B0BWZHgNC4tX40mesqukIVGoYAc4r8gwh2gEd5F8dXk
         tSSnW1rIMYswRVbicbfFQCz281bYA2j2jtsPEur9RAXv/53he60mFtYnYB2itCVRrNcc
         RrK/+Qn1N+Q7tnURbJbGyfQLLCoRI6jBLccXbjCjFsE+/RcVe4KLXKSzk1s//ITRB+VZ
         ed0v8M1anAuoLrQbaXCumjP9yqdZaq8ypbiRWGgDQl9EoD5yiUXDS57ynWCuBM27DMXz
         EbIA==
X-Gm-Message-State: AOJu0Yx0qMb118QHVb3YnV10pKyviUJUPuqxsveVzSe2U4GD/d6xzcX5
	Ph7bCqrTV3Dfoh9lBOMHWPTZCpHjwT5pnJtkAY4Gob5CSjdN8XngNkXpjZvY9J1vygIZsVoUSBJ
	B0TkSR3nwxzPfn+zJft+OW7FJTn3HBt7Y
X-Google-Smtp-Source: AGHT+IFXhqLffa14mTA/gU/7Mo+iI3AZHZZRMTEbNVWxqSIk5GSaVJUkr+w65H5qrk+/Q5jhBNseqVJBsOqYP4Tr+rE=
X-Received: by 2002:a05:6830:12:b0:710:d4cd:bff3 with SMTP id
 46e09a7af769-71b037b5bf3mr721332a34.9.1732146047037; Wed, 20 Nov 2024
 15:40:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Thu, 21 Nov 2024 00:40:11 +0100
Message-ID: <CAAvCNcByQhbxh9aq_z7GfHx+_=S8zVcr9-04zzdRVLpLbhxxSg@mail.gmail.com>
Subject: WRITE_SAME support available in NFSv4.1 mode?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

1. Is WRITE_SAME op supported in NFSV4.1 mode, or MUST a client
support NFSv4.2 first, and only then WRITE_SAME can be used by a
client?

2. Does Linux nfsd support WRITE_SAME?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

