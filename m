Return-Path: <linux-nfs+bounces-12103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD4BACE448
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 20:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2B63A7139
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E91F1FCFC0;
	Wed,  4 Jun 2025 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsI1edO/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466D1DE3DB;
	Wed,  4 Jun 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061225; cv=none; b=Mvor8hBsYvohOLvjrvtJidaGw+LMRklmv3XegCE51T0yKDmnudr4su9qK/1fj1LSJFuSPnRy7h1ZPWrDMvZ7m97NNRSyRy6yRRaR0x+Tha6jdxxYWDZ1SqV81P7H809ZDz1y8IXh5v0ibycUDZti+xuf0K2Q0bXCYgq+jw7LBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061225; c=relaxed/simple;
	bh=xq8Pfxlh3I4akIPbWg6cSsZWuj6UwsxawCqEy+t4kCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rxi5wMyGozXdAV0vNQ2VW5gSCtUbcQDFMtIaLXweaFKyvDxlojSLzZSFHUmGKpEO7afBrVwFROePVY34+euq0TfO8AlpqSFVp2w53XDtmSOdf/cNIWunvhqDnirai+bVGFNDlIRA0WMwnRcBKZYxGB9UqzvbnMbBSpknAvZwEq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsI1edO/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23539a1a421so1779475ad.0;
        Wed, 04 Jun 2025 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749061223; x=1749666023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9Wbm1mpu+LrSj9fhlQVho/f6spGI1rLCVKmxwzSbfY=;
        b=JsI1edO/V+HqIZY3qcryPkFn3FGuvWdRaED/+Gw7HIQVYybWIHCl2bK4JYLNIPAUbP
         qTUUTxYM/ppJBCx2HXqG/yIDiwDMFwvN4TTiMdIntBkbOK84QeuykjBXcLti9pOZEycK
         nV5klKzb5BrN401IzxZ4BdwcdObenRT0HxmzmNXntzoUeWGgt0p/T1J6PJaBGOPDhjcj
         QoJlK6OaeJ3F0nKks1rp75PD7q7l3IVY5E2uUHNezAo0exPlsNbXxJb5NXYI60Egddzg
         aQZjM00rfbcjp/Zg8YHuxRQCp9XPaDtwRTDLskK7cYdl/ZFhN9MicfhzMR6A/u0jsbJt
         BmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749061223; x=1749666023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9Wbm1mpu+LrSj9fhlQVho/f6spGI1rLCVKmxwzSbfY=;
        b=go6wM1CEa4jEW8UOBaN4ehYu4Xz/9SloQB3oSMF1dPVW+rDPPx1WrRurZ+1VfnF9W4
         LHz0VjJJjYZl5GD5KqEUwbSx1+noZmaYlfI8+eZSzZdmgA485lXxq5F6xTHSvKVzm9AC
         QJfuYLNtk/imsqaDrO3n7nShzLmqsvVAZAx7+6+zAWYMcH8Ns90mxH1cfwW+mUIBIU7w
         0t8RaRm8/jjR4jlNXTAuCTvk+yAwmoJ3wW5D/triBNiqsatIjNKnDY2s7ExWibqSqn9X
         rxe/TChFvmioGrYiJr8BTckqqfrpsW5p+89jZ/pQuqSoyk3NZd8LVVrrrXb+TaAx75o1
         CrEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzO7xsM2k0WF/DrbFgfpa63hcU/RiqjxZ9mkjqYpuf4ACaNVpEEjD8tHwAERsrZbi851UBGaj5Fng=@vger.kernel.org, AJvYcCWVh1pxgz88qI14QHSyNrGTUFHi3wkgIRwxI1FwPwzcIj761uDmuQtmt9ZQCIRk+Ksz6HILMHyT@vger.kernel.org, AJvYcCXrhxH+wbVSaf56pNCNfn1KgJ1L4aou9oCcOM6P2liGiVjihQ2XCE7vcOFWU725ARBVxTG0wFCSBc17tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpkWikhYWuAYtMWOj0uVZ3rqfkUymxcLCXA3NWL4syciegVnaG
	5kOxg7zKV7nv47KyINP2bLleqtj3ers1zFMoAlNa6eCOMbS29kfG8+o=
X-Gm-Gg: ASbGncuHOy6RGzTJzLQw2VrYPkeczLwMp9tbb0WxDGa9NBwiP4MTW5+aG174D7TCDFv
	UTDy25ni5uW8wrxp4kIARfLUJacCT1oU8cJi484KuLhRqR6yg6d4ZZY3/6lZZk66QLjdKbc0tXr
	o3MgSaKLs5FNNjKrpsqo+ZXwDGt72tSL1v+pHGOYM+IqaUlHMyvoCEvEeilQF8cIxQEOYLxPsF5
	9FQfiISEpsO4owfEneuJ+sUIrN3dDnc7IgvdOoXRDixsjySzpyfQN8rqXYDs66M38eyQ8Ut3HkZ
	kGT+utCNISQR/wylE/Jl0QCBli3O9btgKBAOOwY=
X-Google-Smtp-Source: AGHT+IGIouN/nMiCxvNDy5Ikm1iFDpXIIVrGTTraPYBI83jtD4OKXOtjOvlar8/eWBmagZfZh4sDMA==
X-Received: by 2002:a17:902:e74c:b0:235:225d:3098 with SMTP id d9443c01a7336-235e11fef9amr54068335ad.46.1749061222816;
        Wed, 04 Jun 2025 11:20:22 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb9a5eesm7841454a12.53.2025.06.04.11.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 11:20:22 -0700 (PDT)
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
Date: Wed,  4 Jun 2025 11:20:17 -0700
Message-ID: <20250604182020.126258-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603045021.GA8367@lst.de>
References: <20250603045021.GA8367@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 3 Jun 2025 06:50:21 +0200
> On Mon, Jun 02, 2025 at 02:52:47PM -0700, Kuniyuki Iwashima wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > Date: Mon, 2 Jun 2025 07:09:49 +0200
> > > On Thu, May 29, 2025 at 08:03:06PM -0700, Kuniyuki Iwashima wrote:
> > > > I actually tried to to do so as sock_create_user() in the
> > > > previous series but was advised to avoid rename as the benefit
> > > > against LoC was low.
> > > 
> > > I can't really parse this.  What is the 'benefit against LoC'?
> > 
> > It was a kind of subjective opinion whether the amount of changes
> > was worth or not.
> 
> So the simple scripted renaming was not worth it.  Maybe I misunderstand,
> but based on the reading we should basically have about a handful
> callers of the non-__kern variant left.  Or is it a lot more?

Yes, after this series, only 2 sock_create() left, one in sctp and
another in core.

