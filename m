Return-Path: <linux-nfs+bounces-2567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2938D892B03
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 12:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE4C1F21ABE
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Mar 2024 11:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360AE2C698;
	Sat, 30 Mar 2024 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwcu7mJW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722DD3613C
	for <linux-nfs@vger.kernel.org>; Sat, 30 Mar 2024 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711799829; cv=none; b=K40dwpRo5GRFwCXRGemnGySw2rHAm/P0uTLgJYt7GQQJUtb0EYqVk2IcZ6UY/p0JU50tWNLaEHQ9fgJMsm53zzgfMQckiQ0aB08g/vJqBbmWOVeXOokymHJNxCZggkdWzCK0p+CHJ8EfuDkO+9Fla5ME6+TZvNmnQA7dGhXf5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711799829; c=relaxed/simple;
	bh=wLg+RJulmsWvddvgZrCGEPX1Lb1sQ5Vh8GrHczlVlWI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ARXr8kUvDcKZHg9CmrM1tn+49ukBO4qW4CKGjoEA7PE6LuA1C3wizT0VtNla0B/KV6B7/XAacoOYYPtNSDPOrduCI3XcwCZqCg8EQmlLmN/TE0suqYEVNh9CaFboPtI7paEL4i4XAQOBiBL65K8sBJZCmg+jwY+m44YEERjiBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwcu7mJW; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d68651e253so38969741fa.0
        for <linux-nfs@vger.kernel.org>; Sat, 30 Mar 2024 04:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711799825; x=1712404625; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ujt4e5pjtLdXppP5j85PRz53pRrQthkbXNOvIPEZaJk=;
        b=kwcu7mJWkaarGicx639Wk1vhAKMtUgIgTJC1GLZ7mtTMT3PBWg2KqI9mUDzHFgA5+g
         xgl2Beovge3hS71TMZSjMtbnqAZEc/Op560JfwgY8laEtIFLOs3WVDTmxKUYffPxUksV
         e8CNeUhDG1M9w5+gt/UZcox8YsnRELsPTMfaa9ahZxGGRH6hnjJ4u2uN9IVuiIqBa2Mg
         JvfYTfG06AnEK278mTQgX10zyj5hAYlhfAHnk/6PtF/p7KUBZA24wUtAcmg4TDisFYGD
         vafSHy4Qjxx6zVx7Zb4tOSf5pSIHbKgb04PPNZtyFPp/zkJl/KvBnBZ/FiyB3qYF96XS
         s3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711799825; x=1712404625;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujt4e5pjtLdXppP5j85PRz53pRrQthkbXNOvIPEZaJk=;
        b=lWpG2wQZHWkcZILcJ68SgkGDT3LS6TAryNJerBXIxNClSUYrITFPoP8yfghNA6QUTu
         C++hpwHHk4Sq3qLsr2yNwfcRJaVoWZR30D4uiPc2Szv4O8fjW5kqvwC1zEr1/GEJg43M
         DOHlAamsC4l8Pdx1u5y25EI7gs4eAqqZALZyVsiBF2vGPBMeaVY3t7gshTgJfXb7JVbZ
         s5weP+1H10LMFHTuei9TWnFfU3aFcRhOZeoC/IngBOMtFSbcCxNS+T5RmIzpGwqtxwA6
         DyggCvEIn7MKhSrSamvCIHH5K/aWmRrPffYQ8wQIgVsKpeZYYrxA9Ersk2/R4MNyfBZA
         RV6w==
X-Gm-Message-State: AOJu0YxmqqJ+MeTuBjOa+jEZPxdKYNtg7JcMW7OJhaiSKMU1SseCad4d
	j4pzyTg3vJwDYDTF5dHrXGlbw5jELOJyxSrz7TRz5RwPxikDIGkxiFrLRokVWa6FcJEuDe04y6e
	hYaAmecUVvvZfayjGHVuRVy87LvR0HSMH89Y=
X-Google-Smtp-Source: AGHT+IEEmBWIPhaXmxXVSNJjdCnd77XG3+tA+E69LszZgZw5AdKRcMP3daxMIb9CP0zmtlWkUnqTs9ysqUFIpAlrQi4=
X-Received: by 2002:a2e:b009:0:b0:2d7:8152:1ee5 with SMTP id
 y9-20020a2eb009000000b002d781521ee5mr844228ljk.31.1711799825199; Sat, 30 Mar
 2024 04:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Sat, 30 Mar 2024 12:56:39 +0100
Message-ID: <CAAvCNcCDsAcZFoCuCgM_HrooSTjr5T9aQ2s_LC_81XUzVetwqw@mail.gmail.com>
Subject: kernel update to 6.8.2 broke idmapd group mapping
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

I have updated my Debian 11 with the Linux 6.8.2 kernel, running
rpc.nfsd with various NFSV4 clients.
Userland stayed exactly the same, so neither idmapd or nfs-utils were changed.

But I now see lots of weird group names (not usernames, they are
normal) from idmapd, but not all group name mappings are affected:
Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfsdcb:
authbuf=*,10.2.66.30 authtype=group
Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
calling nsswitch->name_to_gid
Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
nsswitch->name_to_gid returned -22
Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
return value is -22
Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: Server : (group) name
"^PM-!M-?M-4q" -> id "65534"
Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfsdcb:
authbuf=*,10.2.66.30 authtype=group
Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
calling nsswitch->name_to_gid
Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
nsswitch->name_to_gid returned -22
Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
return value is -22
Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: Server : (group) name
"PM-^^M-^OM-4q" -> id "65534"
Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfsdcb:
authbuf=*,10.2.66.30 authtype=group
Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
calling nsswitch->name_to_gid
Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
nsswitch->name_to_gid returned -22
Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
return value is -22
Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: Server : (group) name
"M-^PM-^]/M-4q" -> id "65534"
Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfsdcb:
authbuf=*,10.2.66.30 authtype=group
Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
calling nsswitch->name_to_gid
Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
nsswitch->name_to_gid returned -22
Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
return value is -22
Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: Server : (group) name
"M- M- M-^_M-4q" -> id "65534"
,

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

