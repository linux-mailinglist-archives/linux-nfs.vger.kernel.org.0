Return-Path: <linux-nfs+bounces-6155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E515969B60
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 13:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4807B1F24634
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2024 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62961B12E9;
	Tue,  3 Sep 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9U5GMdS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736DD1885B5
	for <linux-nfs@vger.kernel.org>; Tue,  3 Sep 2024 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362227; cv=none; b=sgiOKc3GBFnxJGydt5yIehaRvYWlmyFYDcUd2HVuyPWrOGVTHWLHj9naGs30CZ8zdE8DRqFn0uGWYlBZtrp5stOTHsutG03nRPaDSk7yAclf1/z6O2rthT3uv7+iOL+0qnL+h5jAD03zZHF/Zzkye3WhYuNtz8csLMGcsuxr+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362227; c=relaxed/simple;
	bh=Uli6+dwkkUBvfWmllfnZoY9byd2SVr5RbTTPPyRauys=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=euKMw2VEqtMOHoiNVU6ZmJvcxwugSSKtsZZOd8gdvsnFjL2fz4Hh7y4xjvsL4rAgI5EpKJ9NEv6Vg6/pCGuCmlw1juPqcnMESt+YaqAmWmXhopNuyKBMdSXNnUpC93V2xtsUpA98kKD37X2ufdnx0uJbW4BzaX6ywuNQ7vQMm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9U5GMdS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc47abc040so40916575ad.0
        for <linux-nfs@vger.kernel.org>; Tue, 03 Sep 2024 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725362226; x=1725967026; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cDdEN1oXOBpiOuwmnB6ENkZEYQ5svN5Hlt5wMcU1Xv4=;
        b=K9U5GMdSgERLslmEwh/VeBJu41PSTV1xvbe0xsIqRy8tnwNZJfk5NBWQUQs55wLUvb
         wT/3GcIkb0+DfcnfSROIKJfX5zwmtwuXRrpXNFRJ/ljrGlUbZi9u7bb+dWaom1u+bhCc
         D0eAFseiJFVxytI432rkcIHzC14oaxsHKcBloJbul6mdMk0tZAvJrRhicKFBWrgmI9cZ
         0rUqtzZLZcmLv/w1LbcYck1ipWpIaC2n3ljd5oRdKg1hXnkrZkaJccuexm+y7UqAP1x9
         h3eEiqHhMNM6CzjBBk2ZL5bgLe01OLaBQt3FMWP65qeLuwx2VsOFeZtmQ0m5p1gnz7YQ
         uFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725362226; x=1725967026;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDdEN1oXOBpiOuwmnB6ENkZEYQ5svN5Hlt5wMcU1Xv4=;
        b=G5rKcfQQWlkxifZZB5kAO2TnZy4mFlJibBqkmHjlLGz3QGuKXwKSgXZzzt29S6he8C
         nxpQbDX3xYAGNhOHN+h+hCfAhxFEAqftubQrexF/To+3PPPDHOiTSzroWLx1gunKDi9u
         4B0Uow2qRnr/o+cjgu86qHWjM6I/LSU/V1Ojw+lQmt79EjmGqe9ZpyDUcOVXOicLk6QI
         B9qvGj+ITMmVEu8XDi2zyoXw5NPL7MXW1eeL449dKQWx2FTKn5DLT/9wU2NANgioA9ES
         A8USZqQ8fhVstNNBffOIyOAmUj4Pf59JzLik6x6+d0q5hgAjW3O5W7PQNgnUPnM1ZB33
         d2mA==
X-Gm-Message-State: AOJu0YwM/pHQpn+gDe7jObD/VvzQK/LZbJ4Hpiz6EW8PM4E9Z0F8yFVV
	Eh/ROcjywKaqOa8xR8SGIuvk/9LFp1S/3a36JUioApfD8u9Bv4UD6jylTgcUhP/Q5C2Qb5axkRn
	5KnlR2U+JgOclDsVJ3oDLVgGgte5ol76Y
X-Google-Smtp-Source: AGHT+IHYlLOWbv2uCwPa9rxIwBlEHnqYFZivxiA3xeiBM1sQD5Idryd/gFQSjUFnAz0kvazdiPf5TEiPonyfQEUZSOU=
X-Received: by 2002:a17:902:fb87:b0:205:8cde:34cc with SMTP id
 d9443c01a7336-2058cde3621mr37885145ad.10.1725362225578; Tue, 03 Sep 2024
 04:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mark Liam Brown <brownmarkliam@gmail.com>
Date: Tue, 3 Sep 2024 13:16:29 +0200
Message-ID: <CAN0SSYyAf51Vdeg9yVGD7isZfT+PcvbC8RcUGzgkH9MUB1QjgQ@mail.gmail.com>
Subject: IPV6 localhost (::1) in /etc/exports?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greetings!

How can I add IPV6 localhost to /etc/export, to access a nfs4 share
via ssh? I tried, but in wireshark I get this error:
    1 0.000000000          ::1 =E2=86=92 ::1          NFS 278 V4 Call looku=
p
LOOKUP test14
   2 0.000076041          ::1 =E2=86=92 ::1          NFS 214 V4 Reply (Call=
 In
1) lookup PUTROOTFH | GETATTR Status: NFS4ERR_PERM

for this entry in /etc/exports:
/test14 ::1/64(rw,async,insecure,no_subtree_check,no_root_squash)

The same mount attempt works if I replace the entry in /etc/exports with th=
is:
/test14 *(rw,async,insecure,no_subtree_check,no_root_squash)

Mark
--=20
IT Infrastructure Consultant
Windows, Linux

