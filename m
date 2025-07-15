Return-Path: <linux-nfs+bounces-13083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6141B06312
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 17:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BEA18959FD
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BB624EA8F;
	Tue, 15 Jul 2025 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDRy7k73"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB124337B;
	Tue, 15 Jul 2025 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593691; cv=none; b=UNJohJywbkhNjXXJu7l8/3mm5md9I+zgmdnnVehWnaGaZQcN0fZXNK38LxMNj3eu+bmg9XEcdoHEIwDNIgQ9yEBOJby81NIPlDRMUceniLec/ZObOYM4yqp4BzzcIbc9IFxmgHMmcv71+6dSCwF/cnFSLvgyOspji4jeHjnpy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593691; c=relaxed/simple;
	bh=Opc0fAF84w4wvc5gQZ7ZkrPABHjFRdWfuYNVH2A9HTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwD97ZCZYOUxDmn+VDTH/JXfUkW54Ez8ONSPXNce00wvITZo5x9H9feuMxdyGz5qoKb7dxbkXS6+WL2zTDGtSp7bTJblGWbJmwGSPAd1qTH1TmhakQyxJ+8SD5kzQMU5iWQ3Qxwvyf9S5jURsXFQYN8ZAxAD8etnJJWZQVEtqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDRy7k73; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so49847731fa.0;
        Tue, 15 Jul 2025 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752593688; x=1753198488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wjro2UMVYBNQuYncM4eVApUcwQNNk3iK9loyoyjEx5U=;
        b=CDRy7k73GJbNs+931+tbpDVg7GTxJeW+BC9CIOFRGOLG1UXTytLWdJ2mw/bG4BhZfi
         0IZba/nOVQx4MZUlF9VHakiPT0dz06I0KvyjwQZGHOLu3GppGjmxy4kAON4519BNVnA5
         669jZgNablMZYer5NpociIW1Xm+osqglEvX3DrFHw2yrOZk5IAYvZSm2PYp3Nf4A73Wj
         N52BpibifEpXVdM2RXNZJ/efnpnLbRAFf4omMzdbu1w6ohvQFqyh090PDx4shLDzXUBY
         takQvJPFzo424pHHJf0yWRZ9FSt04j66NKll2P17spFzsZmnSG383B4Fr1BjunT2mbmw
         Ldbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752593688; x=1753198488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wjro2UMVYBNQuYncM4eVApUcwQNNk3iK9loyoyjEx5U=;
        b=fXTTiMwTwpMmFZGfXoqCNZVVB1FiSGCm/3G8FlRFXd9+L00Ds8BOBUrLnACxXldYiN
         8gmkq9QdRVd94sKmxFy/pCxP8TgER5huYodF9J2nuQSlttpFQfxjfID8rkh2lkosHasq
         2TCStUn2vwxanhzeR+TE4w/E4gZ6Ae+OEfwCvCtjPtVAhsEhi1ugFlLmqx4T9XiwT81F
         VDki0+r/MzlYU601sOu9VRscg8MG+s8lGCGcFLBVuk0BIkvdP5lvK15uWv/mtKkXDciv
         4KABrzbR/EhTo5rTcLi7epXoUSEkimUnbDNnR2EJdjl8Npy48LFTa+BtVEfJUTiESvp6
         bwAA==
X-Forwarded-Encrypted: i=1; AJvYcCVoJGDrPNM9qMWGbcg9ajXjyzkO2W1QN24jVlxc5MFMVExweMZO1pZfCsSuuaENI+YuR9jGXyG/GTD1Tmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx56fNx2TzC3//L3kaUDZ6Ozsqa3ksPkadSVwlwoKn9bYzfFR1h
	+nMW7x0mhR4OVeHTUwwPUR83yZU38mW2HG5umQdHINFKzJ58I0iOtasD
X-Gm-Gg: ASbGncue11xct6MjsDu+fuRlJZ7RUaXb0Znr4mycGl+xa1TVESEwkD0bgd3zfulrqqN
	yMxIWUumgIjtt61ZTOYcCzKyclgAxK4oF43buCudPFLV6UWuqeT3zUfyOZ0gvDC/lfH0jQJId56
	K3oQ53O9zgnY3a6G+F97DDr6O+Xlk7Dv9yNnUCe3bIwU/KPfheeSZzIlNpW9LkwVh3pQTWdRMC6
	+MpviHaUw4Aaxp9RQrWaxma+jPQ/kaB23SdM98NE9miAPLzRRRAfkD55PRizQXMvCYk5dv5oIxM
	uLlwzaD10XTEmVLWrrPIXjZnK+tL7X37bLXkgizVKc8noyWgZQ3MsJGKHcLHlm0MJvfiZGV0Sgu
	Y2d9aRr+RI6VYcWAwaC0m8fsNqcQGpTdGj13JsIWpc3EyKKg4LvY=
X-Google-Smtp-Source: AGHT+IEGmXA3gwbi1bGfQ5IHJHibBvHXSZUZkPSKbqnCfdnKOWaraCe24fGuJIA+NIPiD3oXLmhiCg==
X-Received: by 2002:a05:6512:b01:b0:553:25b2:fd28 with SMTP id 2adb3069b0e04-55a04609053mr5279160e87.42.1752593688058;
        Tue, 15 Jul 2025 08:34:48 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([85.174.192.104])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7e9c7dsm2316482e87.64.2025.07.15.08.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:34:47 -0700 (PDT)
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
Subject: [PATCH v2 3/3] NFSD: Minor cleanup in layoutcommit decoding
Date: Tue, 15 Jul 2025 18:32:20 +0300
Message-ID: <20250715153319.37428-4-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715153319.37428-1-sergeybashirov@gmail.com>
References: <20250715153319.37428-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the appropriate xdr function to decode the lc_newoffset field,
which is a boolean value. See RFC 8881, section 18.42.1.

Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6479c1e3b7741..ca9e3321b6691 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1813,7 +1813,7 @@ nfsd4_decode_layoutcommit(struct nfsd4_compoundargs *argp,
 	status = nfsd4_decode_stateid4(argp, &lcp->lc_sid);
 	if (status)
 		return status;
-	if (xdr_stream_decode_u32(argp->xdr, &lcp->lc_newoffset) < 0)
+	if (xdr_stream_decode_bool(argp->xdr, &lcp->lc_newoffset) < 0)
 		return nfserr_bad_xdr;
 	if (lcp->lc_newoffset) {
 		if (xdr_stream_decode_u64(argp->xdr, &lcp->lc_last_wr) < 0)
-- 
2.43.0


