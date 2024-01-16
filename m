Return-Path: <linux-nfs+bounces-1118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689D282E668
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 02:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E175AB21E8C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 01:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6544A946;
	Tue, 16 Jan 2024 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgD8aGb/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A08480
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jan 2024 01:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e741123acso11255807e87.0
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jan 2024 17:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705366957; x=1705971757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kdEhuLWe3d17fcS86kGr+f0TnK2jMTbehpEdzK+B83U=;
        b=lgD8aGb/dTFasBSKUEDj3Il3UAIvkCRkBwHLzXiQ4w92gQzWE2XEvmqqJjc4DyWtVu
         0F/VcpDzemiHpaoRLYfuGy99pB+IuGWIBh95+qb7euRBkYHi2PuZ0QJx286iHuGw/mNC
         DohmPCGkzGhjwO//7B/r5Neh1RFp3obLf/Hfpr2OzkI6ZBd8PveNe7rPA3+gWkrGwumQ
         5eXENWJQeb0IqPSyqHKiAud82yC8+ZXq+N/f9WKZHZZ5FFwyZc7EzckOaYk7T5g5trNi
         jMyCdOiTWbsbpbqUXml+kvmgUC1jqk8gg6irDnl5ggyVQZ0QKaNhwtVQzwub+Nt0HZRh
         fNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705366957; x=1705971757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdEhuLWe3d17fcS86kGr+f0TnK2jMTbehpEdzK+B83U=;
        b=oDujcxSYFV5G0RUCgnqzl6Jhj8qnAaFH1STZand1BWuJOSNyk7oDGLYdkUH64YTyJC
         vCHpCEvvdNBkAYwc/aGekodlMevcTar62U9s+LCgl2dHEeyyyMI9Ep2Y28illOAVBjCD
         IPxOJXSorD3EnqQMuY8iPah69g2NWQb7s4jJAAm+ocLJB2Pv3vS5Gnm7QnMo/lvmrsTQ
         W10SHQyLEOwGqBpv45rUkf2mzgv/oorT7/BVRWUYm8eAmnOm8pRMym8kP/hg43MJJwRc
         tnvUNzDSaP/i2KyCKfXbHSSO4iGPX0QaaOYbfCXOXMV5+g3sEXDSVFAGrohhwafsckeL
         V0fQ==
X-Gm-Message-State: AOJu0Yyg5QKQ0WXML9C3rIKDIhQ/oGxqqYE1raYhYKH35MbGjbyXAugv
	hw4sXyt0J6RF7+5Gctz1E/yBKILStnyS+5j6a3cVrY4NBFA=
X-Google-Smtp-Source: AGHT+IE+nw3enzDY0xAB0ad9mBX9p3yiEBLmBN3WIOZz3kbTAJ1IdxMAV5L8Ja05wmozNd6w21RDn5B/Rfp9DxhhE7o=
X-Received: by 2002:a05:6512:3f07:b0:50e:8137:9a13 with SMTP id
 y7-20020a0565123f0700b0050e81379a13mr3504095lfa.66.1705366956932; Mon, 15 Jan
 2024 17:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115063605.2064-1-chenhx.fnst@fujitsu.com>
In-Reply-To: <20240115063605.2064-1-chenhx.fnst@fujitsu.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Tue, 16 Jan 2024 02:02:00 +0100
Message-ID: <CAAvCNcDxZF-ftqb1dRnjUW-q-1m2kyqN-MAGNXUd+i1r_b_vSQ@mail.gmail.com>
Subject: Re: [PATCH] nfsv4: Add support for the birth time attribute
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jan 2024 at 07:37, Chen Hanxiao <chenhx.fnst@fujitsu.com> wrote:
>
> This patch enable nfs to report btime in nfs_getattr.
> If underlying filesystem supports "btime" timestamp,
> statx will report btime for STATX_BTIME.
>
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
> v1:
>     Don't revalidate btime attribute
>
> RFC v2:
>     properly set cache validity
>
>  fs/nfs/inode.c          | 23 ++++++++++++++++++++---
>  fs/nfs/nfs4proc.c       |  3 +++
>  fs/nfs/nfs4xdr.c        | 23 +++++++++++++++++++++++
>  include/linux/nfs_fs.h  |  2 ++
>  include/linux/nfs_xdr.h |  5 ++++-
>  5 files changed, 52 insertions(+), 4 deletions(-)#

Hello

Where is the patch which adds support for btime to nfsd?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

