Return-Path: <linux-nfs+bounces-4403-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5606E91CD0D
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 15:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9B41C21164
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jun 2024 13:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDF71DA5F;
	Sat, 29 Jun 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lfw01EOL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9633C466
	for <linux-nfs@vger.kernel.org>; Sat, 29 Jun 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719667216; cv=none; b=lLqnYgkiUm/sKfbWetHfWnX92KGhfar1gFGZ2Uh5ZFyAq0XDda943KToldQNzoiVNx7iDnJn2v2CvjNY2SbzYcgwyh8HGM4yPcxuzszeOSh9Lcf+B6zMlrVRjBBnGH1ZkSOaTniZbvSIa/yOuQMo5rqtetqKYxR2G/jBub+8QPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719667216; c=relaxed/simple;
	bh=QvNh1s2P3O1NWepvKJh4S6sIgf6j69iTchvq3IgSJkU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TptbVsaFyYpuxD3CJP6ZRuLt8Q58FOftXeLE6Q8lQRJoDVsAmiL7DymXIM7Yl9OrlMdDU+gaX5a5e6uBOd90iWjXgF6QmEKTg4nE/g6tcOpBuG+s69ZrVfwCu+zqxH1iQh77z/YiOHZaMM9O6XUJsqcEHCf/8ALpBi0SjQh/Fqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lfw01EOL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5295e488248so2008396e87.2
        for <linux-nfs@vger.kernel.org>; Sat, 29 Jun 2024 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719667212; x=1720272012; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l+DfSeozhxShlgHAnq+YeD5ryHsvSU4PBa11HHuI1Wo=;
        b=Lfw01EOLuv5N4carum7FuOYH+FdtAt+bl/2nfveRUb0RbuFMw/u4TUIxmWOgatOa2g
         sTYm/npMDYIJtYscJW+tCB+vCsVMTpwZLlrsuvMwKQ7DCy/yDx5F3jFl51CawV2U+Pp3
         B3rJAMLgXNXNLBV93Id7x7J1Ueqt78BpRchgg675Py1Zriy40LPkCaNaGtX4rCpbZB9V
         4zzqhlZitcx8PXOkJ6TtdBq8olyiQYPaGP2t0KyW+gQtXf9uQOsWe6R92wiu9X+hzAre
         AH7Hr96FCnh7GtKLWzcyMPVHRFWW74rKbjZ0jNF/jYGHAprZH+n/QkWRjtiBnA1kfBj2
         S0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719667212; x=1720272012;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+DfSeozhxShlgHAnq+YeD5ryHsvSU4PBa11HHuI1Wo=;
        b=bsJ+ID7nu3bl1ddIGiy22MWCVpPxdVsBlW5+1Wol8X6tZ/mnFIuc+6BvxaD7oh3XiO
         5MZHYN0/KhZE9REoMAVJzv1DdBUjBo269IUD0xYX7BrgBRQIB3aXHGiR9w64pN66lYyt
         W6Njd4QtenXscsN7wsWGfuf+oU0aMmpNg7CIY6HJbXgOnEDPncm93voKDbGz5ijx0yuX
         5yU92e3kaPe2JkWfMB1agurOAcy+RAPaAJHjU0kRPfYEuY9jWDB8zOvM8F7flEjJDfB7
         ldMhD1gjtksyZMow6L/m9n+S/KYEBQt3s7fovmzPqZdEDl3os8yJiqkY6ESeDs5yjRMr
         igng==
X-Gm-Message-State: AOJu0YwdHQtD3/LHagXoWvy5FEGEFNx5pUNKUtLVKMWail/wyG3OGaKI
	LNbrigZ1OX8QBCbNGtHORu3i+yMx5jwJmBDfLnesTKpjILIT8MG38/IsLEM09+R6jRyr+SFxUOJ
	m8dmNatsHKxFRFEW8c2+amTzgnms57pLw
X-Google-Smtp-Source: AGHT+IF7rDUCXq4r8NZ9am2JbjWcLpc7J3j2wWe7kLCGCV0VV09StpmkossYPpiB3G/O7XVBMiYCcVf9M7Ijx9wSJdw=
X-Received: by 2002:a05:6512:318e:b0:52e:6ff9:1957 with SMTP id
 2adb3069b0e04-52e8273f50amr759148e87.60.1719667212329; Sat, 29 Jun 2024
 06:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Sat, 29 Jun 2024 16:20:01 +0300
Message-ID: <CAAiJnjozyKAXbf5XHEbqCvY=Tdh78nzWRgTW=0mJrr=6gaHQqQ@mail.gmail.com>
Subject: Are there any known NFS4.2 over TCP bandwidth limits ?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

I have a NFS server with 6x100 Gb/s ports.

The NFS server connected via two switches to the ESXi hosts.  3 NFS
server ports per switch.
Many ESXi hosts connected to the same switches using 25 Gb/s ports
(4x25 Gb/s ports per single ESXi)

The NFS server exports single mount point (raid6, many NVMe SSDs PCIe Gen5)

VMs running with Oracle Linux 8.10 (kernel 4.18.0-553)

There is a "magic" bandwidth number limited up to 100Gb/s between the
NFS server and multiple VMs/ESXis.

We tried different numbers of VMs/ESXis, different fio parameters (bs,
iodepth, numjobs, reads/writes, etc...), and tried nconnect=16 option
with mount command.

Total bandwidth between the NFS server and multiple VMs/ESXis limited
up to 100 Gb/s.  Always.  While iperf between the NFS and multiple
VMs/ESXis shows hundreds Gb/s .

Anton

