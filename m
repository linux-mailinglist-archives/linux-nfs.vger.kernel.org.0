Return-Path: <linux-nfs+bounces-12897-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0847AF91D3
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 13:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454D75450D1
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F30F2D5C78;
	Fri,  4 Jul 2025 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krnF35hC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1012D4B7A;
	Fri,  4 Jul 2025 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751629780; cv=none; b=MbknX7vJlm33VNgSnr6atw8b2GteBn/qrKhgf4DXRvRmCCHqopv3RrnUrs/5KD9I65SVrgVXpRkoSwz6gBppNA1njKfPA61LDcFYMBUXhLYd3ppcPs3mpr+lZ4tJui1jImPQXm9cvoigHtBM1NfiT+JR4J8NOXF6QClnNfY/Ix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751629780; c=relaxed/simple;
	bh=GlDsMKJgD81/NA042SI6YAEK4kTUNsXZub1aj2a3PmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXiVl/3eOCRlL6yST2ADso1oDzxk1d0qBMp0FVXoJRc5kkQEACOC/RIHQQ3rey2PSdoUV0b78mWU9qceNkSyIk2IIlMjETB3iosaybfFu95dv8st/ack/63NACOintraXrOoI7gSgzf4OghAP1rxXX0mlNZyqHl53y4wCUiAlIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krnF35hC; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54d98aa5981so1207672e87.0;
        Fri, 04 Jul 2025 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751629776; x=1752234576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IffhPoJDjgfAd17BD6YaMJBhmOSUuBw7Usfk4ovhu7Y=;
        b=krnF35hC/cSyVJs76T0YmK1BfrT+2dLrvk48IAoGHnOrXMygWBCyOnwMnNasipDXje
         GZ5NZFp3X+J7W5QtCeaqYbYPq6s+NjVtWM4mFjMsb15guXyCMZdBpKub70SgnPu7/Mvx
         /h24acrWCAWSwk2owYaVbvsd+XZ+x5cZxWRjmykC77g1+Gjz0xbMSZIFD3RrEdb36KUI
         jdmP8R1Z16LpBN3mKkcg/pDKYTcRheIFp/k5AfOcRuypIq91OK58eOtlRY/2RJbLQAm9
         Ns0rTblD4tTxGzdU0clQlWel42M0UepS4xCAluqkF67ZXOdXtInV0H+DRfIlK1h6rrTn
         9dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751629776; x=1752234576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IffhPoJDjgfAd17BD6YaMJBhmOSUuBw7Usfk4ovhu7Y=;
        b=lDkjs9PTBnTNGTF02SbRjz+M52HxgJr38hQ47V3e6miKREzbzyFX8ZfuN7FA7+WvjL
         HigA06KkJUaLmd38hVWkvPXk3ILW/jrYH8h7YrJOVeoafLkXIUHjo89Ydn4Vv4h0DBmu
         lbmnBYZjzfQIoJUoEw+kcsXQ0LoSmLaTpNWPol2LKi4zJGIEQtL+xSBUEFU9wfsulnE4
         JapCtdeXeak/TxOhzGX6quMCNTTPssHyj4Ztn0YmnVOxgSAcqGftJ74rRVoi2w3nmooQ
         pZueQC5sPqtQ+zS4i+q0NsyMFpklzwvFHyZdrIj1hNxRk0wnToNTvnQc7S/DC++Kz3uC
         hNZA==
X-Forwarded-Encrypted: i=1; AJvYcCUcTixrpauWAr/0OwfoDO9ktyZOQ3CO5AYGJVqGvZYp9YSZ2fX3Ad6q4GraaG9Jj7BYqiO8eO+SEGaiNVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XDvJux1yZLP7yVklYzSwo9CXf7lkatQMlMo4xwoUHjUR17O6
	BcU7M32ZSSgDVnocwC/DCBGWQrWgMu+FaOnVw6A+DCWedTJ8C2NBN1ER
X-Gm-Gg: ASbGncuneWARAgL5pZROveERUFjRXLMg44LRgaPs6sILL5Cr0/JJddL9RwftMsjsqcO
	8vC6DVxTOz6DC6Q2n0fc/K1ujAX/gx/uV1VUQh2lMdFQAZXyABDxoEgZZVn6u4hBw+JrvdtRI90
	qRpbPqSHHt9tc5vkUHYCm8BWRXhheVhWntjrK10LmvWaToyEf0UWPcxnEWiZzWkH+XWMblR4zZ5
	JCcClDlLySb0KgH3SH0bU4ZmeCPYgNoN0R2IeM6rYMGTC3tzGTh5JLnfPbsTEtVohEFzRcYFMLQ
	uH2/9FwVhZwPP0Ld02bbjgZ7LdZ9eRukkvXo6Qp8RlGYTJtsg8jE5Hnmu9s2IC2ZwDrNBBeZTlo
	HfXvtzL8iasM=
X-Google-Smtp-Source: AGHT+IGzc9Ub7w7DfNGZ0nxu8ThDJ4VAp5Cj+FKWx+l3RGs0n6RH9aoj+Ab8mbT20MQAcFbnV1it1Q==
X-Received: by 2002:a05:6512:114f:b0:553:a867:8dd6 with SMTP id 2adb3069b0e04-557a1235e9bmr510994e87.9.1751629775726;
        Fri, 04 Jul 2025 04:49:35 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.70.88])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55638494e1esm231109e87.89.2025.07.04.04.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 04:49:35 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH 1/2] NFSD: Minor cleanup in layoutcommit processing
Date: Fri,  4 Jul 2025 14:49:04 +0300
Message-ID: <20250704114917.18551-2-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704114917.18551-1-sergeybashirov@gmail.com>
References: <20250704114917.18551-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove dprintk in nfsd4_layoutcommit. These are not needed
in day to day usage, and the information is also available
in Wireshark when capturing NFS traffic.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/nfs4proc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f4edf222e00e..37bdb937a0ae 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2499,18 +2499,12 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 	inode = d_inode(current_fh->fh_dentry);
 
 	nfserr = nfserr_inval;
-	if (new_size <= seg->offset) {
-		dprintk("pnfsd: last write before layout segment\n");
+	if (new_size <= seg->offset)
 		goto out;
-	}
-	if (new_size > seg->offset + seg->length) {
-		dprintk("pnfsd: last write beyond layout segment\n");
+	if (new_size > seg->offset + seg->length)
 		goto out;
-	}
-	if (!lcp->lc_newoffset && new_size > i_size_read(inode)) {
-		dprintk("pnfsd: layoutcommit beyond EOF\n");
+	if (!lcp->lc_newoffset && new_size > i_size_read(inode))
 		goto out;
-	}
 
 	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
 						false, lcp->lc_layout_type,
-- 
2.43.0


