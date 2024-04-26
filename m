Return-Path: <linux-nfs+bounces-3016-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFFD8B2E7F
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 03:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22481F234E7
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 01:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D07EBE;
	Fri, 26 Apr 2024 01:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcLpVdK7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997CEBB
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 01:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714096653; cv=none; b=tRHikqqXze90FKHmtZTjdlDgGA+ApxkwOKBR4uW5dC7zVF8RJSvKcswcsjnhsPR9vDLE1/NQ72nXeMfcUYOCfZMjp5F2USZVqU3HF84Fl7T6+4c3VBvhSVquLkeK4ctzLFcMSEw/2/OMe6RAV3bmYu3HelpiIq1z4hV1r607KkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714096653; c=relaxed/simple;
	bh=TQtIzyj6DHoOrevs3cBUuHCvT2K/4HlQrzcVLqLP+kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=PGKcxxzPypm4Ag1NciG8eUNA3tL3mAiOkMkQ0ACoJsGcOM6vn2220ibTeaDMXbs8qR61qwnK0G6s10pDaxTRoDbsT6uqZuYElobCM7uFLEgZm2gRUJa08jIYSjqjgrvSTOhJa6Vx2N4g4d1Puf4lTRTehQDLWrU+vGBx+MGr+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcLpVdK7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5176f217b7bso2860490e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Apr 2024 18:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714096650; x=1714701450; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aMMG6qTzQZ/z8QhupIUyvG48De2LntD/fIXbMTTc58g=;
        b=LcLpVdK7R2mIeb755MGfES1o3yzEVQXoKGi9ApC73ISFjaqQKVg8o44BPzUZ4sJTmJ
         od93Dn+aRCBc7oGygbf9/0+s0va28tZZWuD/DS3attzKWrwoT42VyM7I+NcI9/S4axxP
         LB23cxbX73NfXVp1PVOy0nO8mL6SmbYxgZYJ4v4BNWbxZ6oqAJf54UPFRnyFFT3gy/Lz
         bqW9NmI7531EVUSNEtjFh1HZKWp+hGHbthJ7IEFCYF9/bdqNvGTOY92PGiMxPSQG7n4C
         a/lccJY4BEm89jU5RQsiSRLzbfKCY+IlrWBcFkreEeHEyE0UUaxE6qag5E9AatEmR1P3
         HzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714096650; x=1714701450;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMMG6qTzQZ/z8QhupIUyvG48De2LntD/fIXbMTTc58g=;
        b=hQ+GN3pOwmYaNwmBTjbN6anWAm0QMXXbF38ICdfDOJgoc5XzejoAGcCdQVex5NZodZ
         OguppwVJYzOr0Gr9J1hAMcRObp0wFnYcKflAg5DTh5YSFCVN6D6arIhcWdPFfx798PYS
         WN9LC0YSJAIzxm+DP23ZyqkTtNrpvvvD6VBEnlkmG/FdOldAC4wF05eWoZERZsMTpWcy
         lYYdrX1uooiJPhgHir+83ttQm9s32dcC74LNuoX2meNAGtQHh557V8CaHRLNQCC/ih9r
         qKIEJELfMF+v8ZtfsxRRNvCi702LUvMNo6K3zj4a0Ka+eJxbl6nDiJXHo/XLCQtp9GTc
         fP8A==
X-Gm-Message-State: AOJu0Ywk6rWnpqBZX/XzpbrVNCxTJoSDS8a5Frw2TGLmTi1q6zCYdz09
	gHvlAPzB5JzUEprfxBrVpfHDCKUec+WoQxl6qH1FDWoWm953wrPFogvWJgizZbko0ZecTssApuL
	E9zce3/8ZWSY8HQyF6PfEf8l7Ypz6XQ==
X-Google-Smtp-Source: AGHT+IFPcduOMtbJoz55QuerxDMVA2JFbpUijRfDXP9FT6QmnQOaJcwIDru4QP1t1ya0fiNk8q2Sh9syw8YxGpip2/s=
X-Received: by 2002:a05:6512:29c:b0:519:6c2d:9bcb with SMTP id
 j28-20020a056512029c00b005196c2d9bcbmr786045lfp.31.1714096649546; Thu, 25 Apr
 2024 18:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcCDsAcZFoCuCgM_HrooSTjr5T9aQ2s_LC_81XUzVetwqw@mail.gmail.com>
In-Reply-To: <CAAvCNcCDsAcZFoCuCgM_HrooSTjr5T9aQ2s_LC_81XUzVetwqw@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 26 Apr 2024 03:57:03 +0200
Message-ID: <CAAvCNcDahJvPdhFj=WYBHKUVPVz+oCZcXeqVXhT3s8b6B0kiEA@mail.gmail.com>
Subject: Re: kernel update to 6.8.2 broke idmapd group mapping
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Mar 2024 at 12:56, Dan Shelton <dan.f.shelton@gmail.com> wrote:
>
> Hello!
>
> I have updated my Debian 11 with the Linux 6.8.2 kernel, running
> rpc.nfsd with various NFSV4 clients.
> Userland stayed exactly the same, so neither idmapd or nfs-utils were changed.
>
> But I now see lots of weird group names (not usernames, they are
> normal) from idmapd, but not all group name mappings are affected:
> Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfsdcb:
> authbuf=*,10.2.66.30 authtype=group
> Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> calling nsswitch->name_to_gid
> Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> nsswitch->name_to_gid returned -22
> Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
> return value is -22
> Mar 28 19:15:18 ingramnode86 rpc.idmapd[400]: Server : (group) name
> "^PM-!M-?M-4q" -> id "65534"
> Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfsdcb:
> authbuf=*,10.2.66.30 authtype=group
> Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> calling nsswitch->name_to_gid
> Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> nsswitch->name_to_gid returned -22
> Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
> return value is -22
> Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: Server : (group) name
> "PM-^^M-^OM-4q" -> id "65534"
> Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfsdcb:
> authbuf=*,10.2.66.30 authtype=group
> Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> calling nsswitch->name_to_gid
> Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> nsswitch->name_to_gid returned -22
> Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
> return value is -22
> Mar 28 19:15:19 ingramnode86 rpc.idmapd[400]: Server : (group) name
> "M-^PM-^]/M-4q" -> id "65534"
> Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfsdcb:
> authbuf=*,10.2.66.30 authtype=group
> Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> calling nsswitch->name_to_gid
> Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid:
> nsswitch->name_to_gid returned -22
> Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: nfs4_name_to_gid: final
> return value is -22
> Mar 28 19:15:20 ingramnode86 rpc.idmapd[400]: Server : (group) name
> "M- M- M-^_M-4q" -> id "65534"

Help?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

