Return-Path: <linux-nfs+bounces-12064-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5012CACBCD5
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 23:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048F33A53BB
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Jun 2025 21:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFF124C664;
	Mon,  2 Jun 2025 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWy2VeR+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E642C3250;
	Mon,  2 Jun 2025 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748901199; cv=none; b=BnWB1vrv7GgVEjVzwBC/cGjD7IsAtQ8wDcsZ/8S6rv3i42saz/7YZwOtF2fruGCKK73m//6BaGWosreE2oVDyCl6f5QpatZAOgNtLx+/f7CcxlnykkNebgjNtVVrtOEKLLWoTcbOi0DrIjeUMxpAu/CySbvKFAayB6i/u0gY5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748901199; c=relaxed/simple;
	bh=AIFKKpyKFXNqHaQaeip2wcUVUnkpbec6eRCBmD+Lb9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5iKCAk73UX+YwePDuyMSoETcZM6EU8zu0dUJXWP1BBtSyHr4Dv95YI1Tc0XtUDKJEu9f7YHVeMwHU7wmPzIKAxIf9dUZCOO7/FRdlO9znF4WPnkK9onCRMuw5OI4/EAyaV6spEdXK0qZWeGjeoMEqEI1rBk6yITVIvSZstxgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWy2VeR+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-231e98e46c0so45287365ad.3;
        Mon, 02 Jun 2025 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748901197; x=1749505997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4+gh6dDpCcbatPs3U4I0oqizAhZfGMCTAgt1Y0fPDM=;
        b=KWy2VeR+IEonOeneRi0h771D6y5pAQZClENOyGA74l1Ckcev93IQXGdewmrXCMXZi3
         ra3AkWpCbYmlNJ+JcBm5su3EQhBKDYxtFQj/4/lpKfxj2+lpaEE62nRxLOWDVMyFMkWw
         6/u83JJSvs6rFknnz0q/dKJX7mE6zO4TnIaHU2WiunkpJAWrZGpTBKHTPW/1ExUQxqh1
         zf/BvjJbxRbmnd5K1MZuyqhkt1zEEEo64yM4gel3F/NiNs5IJDXOSU3MRtpVUolrZrRV
         nh6JzlvzXTKh5N5wejXHBv5IB29+vZk/lykhrFrwP8YHPJ/BZC1tnanQfR4qyGKB1DYQ
         dkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748901197; x=1749505997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4+gh6dDpCcbatPs3U4I0oqizAhZfGMCTAgt1Y0fPDM=;
        b=HF/Frn35TYkrzCM/kOdIxuCkOLTYDFAoYPCb/LAtQ5jGnK/hTVxY+ZKWVLhpvxN8mE
         usWYA+mNL2Q/N7zxxxKwsR+Ll0eVrnn+3XmvmCb6jgiJkx9hLA2SSwuDjxQtTz6uouz0
         6DdzQW7qx39bi/GGXX4RzzHyYDsYvd7IiLJntFu8e1AkGtCWwV+AnPfHftu/hPSewvpf
         sHE5nT6tKfiB+5ByuVmhbuBbqryqNTucSvcC2gncBbN5s4N/18Q2hHH62oVewN4P+4lx
         QR3KvCVIcqTLm/LITXIzO+Zy7v+JcKHTtIaeqSIlqZXmwlcfmnoWSb9lIulhIRFx6WYv
         J/rA==
X-Forwarded-Encrypted: i=1; AJvYcCUSFc9GfS+7ILy9O7yuuUpmb1AnC5KqqEowv+rvrCar81jln7l2r2bix38w2kmJ6NgFj5j/BeD9FcSaRg==@vger.kernel.org, AJvYcCVqwlWR+jDSXbC0jPPihKcYyujU4+Gca5PeGnQhDtU31TaE5NI3WRXdBmdmr4B/PJbMrMTgFV+M@vger.kernel.org, AJvYcCWrSXP4iY7Sc6Z8TtfrGXFU1Fv010Htz8EUcJvT7oynv4mBlh9wfcb9plVFJq4f9oU7r7O6nsh5ez0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyWeoAtYjGK9OAE0TLFLrUps0F6jSUVRtkK7JSN/dALRtdB/Mf
	K9HnvQ3UZFa2UKnp53FoD8B6OwNXhBH9xCe0DzO5ftfcEV6yr6E7ctk=
X-Gm-Gg: ASbGncvmiFCXOv+pI3W8PTYoqoHkClY+X9mHhCIBOmw9j8gdNigagoyeHvahghBXoOk
	zRq6jL21SvSbRiORd/TY8/DK3tHS2YvPABx1IkredHKmP4fcsrFyVlEaJ2OkGFhuFq9uFB/0tm+
	6lTWPMLMq54hEN8W8Y7emtPojFxBi0WaYnrw+23ABjq5wod5EOezKswE9ILrbU+8k5wWWRsgN/b
	dYCmE0Cm3Yljigj4T31PeR85+zQZo2AQD8sfnhsrwug1YesEhFF96Cjt0/rUbLX304KljHNw0UF
	0qbSwP9ph0HZczOYh3k1iPvPpNe7
X-Google-Smtp-Source: AGHT+IFablHnOD0Qjkeg3PmBrfl9McO7L58/0ECQc55ZulNN/C+wNm8xqlIMyGBLFl88nguN3OKykw==
X-Received: by 2002:a17:902:ea06:b0:234:ef42:5d65 with SMTP id d9443c01a7336-2355f79fb5amr139393815ad.52.1748901197133;
        Mon, 02 Jun 2025 14:53:17 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf954esm75552875ad.210.2025.06.02.14.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 14:53:16 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: hch@lst.de
Cc: axboe@kernel.dk,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jaka@linux.ibm.com,
	jlayton@kernel.org,
	kbusch@kernel.org,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@amazon.com,
	linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sfrench@samba.org,
	wenjia@linux.ibm.com,
	willemb@google.com
Subject: Re: [PATCH v2 net-next 6/7] socket: Replace most sock_create() calls with sock_create_kern().
Date: Mon,  2 Jun 2025 14:52:47 -0700
Message-ID: <20250602215314.2531309-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602050949.GA21943@lst.de>
References: <20250602050949.GA21943@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 2 Jun 2025 07:09:49 +0200
> On Thu, May 29, 2025 at 08:03:06PM -0700, Kuniyuki Iwashima wrote:
> > I actually tried to to do so as sock_create_user() in the
> > previous series but was advised to avoid rename as the benefit
> > against LoC was low.
> 
> I can't really parse this.  What is the 'benefit against LoC'?

It was a kind of subjective opinion whether the amount of changes
was worth or not.

