Return-Path: <linux-nfs+bounces-13118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05045B07E27
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 21:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477C9A44940
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47929B768;
	Wed, 16 Jul 2025 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6QtCAoH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC629DB95
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694861; cv=none; b=oWaxgKgWkz1YkaMjnqA+zY5vwRpdZ6yottpBMH16Jd4T3AMJlUuWnZcS6UMKeQtknIkuXKyVD0HJzh7XOKxtl+eFv6I/qejDKo/XIc48GjtXn1aaeyhU3jiod8ZmSBUx0j2rziiu3cXWYEnLnIjZUh+Myb0V6fkfKFYQf88INj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694861; c=relaxed/simple;
	bh=G1HdkGTMk50VVGNNH7ekNBm9lPaZebxwsJY9s3ZfvDs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WPD+qwS3eLXy3eeYwmhi+e/UWY5orBsFr79iiQiP81BaduG+4r0VwEhvvNvHijq+z6ZhHd5+4Z7B3SUwkecz6WpK3xF/lCXt1yEB3SoLzbO9psyZ/+aSnHF5oI0n6MrAmDVX8uEZ2jWdMT6T+TjZ6id6GlXkKU/91a7ZXFxVN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e6QtCAoH; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73e58206ac1so72852a34.0
        for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752694858; x=1753299658; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhx9JqXgrKzGU+q5Bk6US+Xm2lM09vF4up5PIdY388Y=;
        b=e6QtCAoHBQlT4NiR7/zfKnRNSwTYmaUT4F6++4apZXM2srbNLm1hX+UqzNbhG2Sd1T
         ZC/3AF5juP19u1JBDtr/aSysyAq17OZuqkGCxm5OEOc3FlzjlSPZKVYChPZaKEq4RxKw
         3GQDY5Cql+JnlBySvKInwpgHbEGsvdMsiiPJ6iscNSQBezTbNI53IcXeZ9TpDbldalQR
         WJv703s5oIQppkqrSMqG/4J8kaIJBtNIKPveeLeLJXK71jWiukVMY7Lkqo3ymr4mXkiR
         HAI/m76g6OPIrOq6XlJyWfTQtV9WDzd1e9WT2A6Vpa4pscMgfZdUof8EFyiRI7R+w9k1
         Swag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694858; x=1753299658;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhx9JqXgrKzGU+q5Bk6US+Xm2lM09vF4up5PIdY388Y=;
        b=M8oDLhgPkPRTs82nO/SDPwjc5aP4YuLOAmXVVKwYx+TNDICzQ7bO5vx9/83v1A32qA
         KQo7GDoEDHxWPF69gtLz+M1Rp4JWz/SF/XAf6isV6Brfhca/mfD7lY66AYARalIvKopT
         yY4IGM+AohU/OB7W7wiCduMsZwAQO4u6ubNICrll7MvE0EkAlzef31GBlEh85lYPQ/4T
         tcakPaV1cpmCPXmx5y6+TvxxS7mTDdcC9AjdTfUVSFvGUSyh0UPdhuRdY68bb1czrh5O
         GLM+M5Fqp/0EWC4lydWo14R9ICfBmpXziDo2McZUcqYSJNjT19sTcw/7EbfxPxoLvset
         p5KA==
X-Gm-Message-State: AOJu0YwH/QWcRy6bBQt8PbWFyShw+Ufka0fqZGomq12mqjLFsdI0ozK6
	lIc6o/sLPvmWqsrmJ0ejP8mfpuLFnuJ9bk9oThuRlcy0E9UfpVbbwt2nHI95G7OGtEHdaKhNo86
	SV5yp
X-Gm-Gg: ASbGncs1P17Jby9VUqq/JHfHVLp7Z/ZOtTAsy0IeSiqrOjvn4zQwOfuLlHrBJKgwsHf
	JaJRIU5haIt6309qf5X/ymm9kVSyyUwwtgEV/OjxH9HMMOwPAGX4vvwceSuQxyUWo30hvZMtACu
	w1LBGf54bS7TBOV0X6JBL/0yoTwnvBWOEMqCZDYyqgBGshf+2/Gg/51dGrvts14p5ghTVRyv858
	om4ofPFhs8PHrVS9cv/O8pH/wdIqvDZptMQITh6Gn4z3sD8P+OwP+XIB3a2S/aSSpPObtpOlZ5E
	vNsgIn3zpM6GUvHUnCWxkzXbbkWn45QpduYl2a6j8Bimjrgaw4v30lbDO37a1mmnoZ8bB62hrtg
	VWCqUat4TrfP/qoqJAmaib79o5dy/iw==
X-Google-Smtp-Source: AGHT+IFrYuse4mxE8k9f0syxoU3niIMN8eNFXS7pgOKsGhCiNTQiYr2JLifVgpxrKbpjMKzTfx8rHw==
X-Received: by 2002:a05:6808:f8a:b0:41c:9345:3ab9 with SMTP id 5614622812f47-41d034f7de2mr3319430b6e.15.1752694858296;
        Wed, 16 Jul 2025 12:40:58 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-414197c6064sm2963435b6e.20.2025.07.16.12.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:40:57 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:40:55 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] nfsd: Implement large extent array support in pNFS
Message-ID: <9892f785-e9f5-4a29-9ff7-fd89dbf7e474@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sergey Bashirov,

Commit 067b594beb16 ("nfsd: Implement large extent array support in
pNFS") from Jun 21, 2025 (linux-next), leads to the following Smatch
static checker warning:

	fs/nfsd/blocklayoutxdr.c:160 nfsd4_block_decode_layoutupdate()
	warn: error code type promoted to positive: 'ret'

fs/nfsd/blocklayoutxdr.c
    135 nfsd4_block_decode_layoutupdate(struct xdr_stream *xdr, struct iomap **iomapp,
    136                 int *nr_iomapsp, u32 block_size)
    137 {
    138         struct iomap *iomaps;
    139         u32 nr_iomaps, expected, len, i;
    140         __be32 nfserr;
    141 
    142         if (xdr_stream_decode_u32(xdr, &nr_iomaps))
    143                 return nfserr_bad_xdr;
    144 
    145         len = sizeof(__be32) + xdr_stream_remaining(xdr);
    146         expected = sizeof(__be32) + nr_iomaps * PNFS_BLOCK_EXTENT_SIZE;
    147         if (len != expected)
    148                 return nfserr_bad_xdr;
    149 
    150         iomaps = kcalloc(nr_iomaps, sizeof(*iomaps), GFP_KERNEL);
    151         if (!iomaps)
    152                 return nfserr_delay;
    153 
    154         for (i = 0; i < nr_iomaps; i++) {
    155                 struct pnfs_block_extent bex;
    156                 ssize_t ret;
    157 
    158                 ret = xdr_stream_decode_opaque_fixed(xdr,
    159                                 &bex.vol_id, sizeof(bex.vol_id));
--> 160                 if (ret < sizeof(bex.vol_id)) {

xdr_stream_decode_opaque_fixed() returns negative error codes or
sizeof(bex.vol_id) on success.  If it returns a negative then the
condition is type promoted to size_t and the negative becomes a high
positive value and is treated as success.

There are so many ways to fix this bug.

#1: if (ret < 0 || ret < sizeof(bex.vol_id)) {
I love this approach but every other person in the world seems to hate
it.

#2: if (ret < (int)sizeof(bex.vol_id)) {
Fine.  I don't love casts, but fine.

#3: if (ret != sizeof(bex.vol_id)) {
I like this well enough.

#4: Change xdr_stream_decode_opaque_fixed() to return zero on success.
This is the best fix.

regards,
dan carpenter

    161                         nfserr = nfserr_bad_xdr;
    162                         goto fail;
    163                 }
    164 
    165                 if (xdr_stream_decode_u64(xdr, &bex.foff)) {
    166                         nfserr = nfserr_bad_xdr;
    167                         goto fail;
    168                 }
    169                 if (bex.foff & (block_size - 1)) {
    170                         nfserr = nfserr_inval;
    171                         goto fail;
    172                 }
    173 
    174                 if (xdr_stream_decode_u64(xdr, &bex.len)) {
    175                         nfserr = nfserr_bad_xdr;
    176                         goto fail;
    177                 }
    178                 if (bex.len & (block_size - 1)) {
    179                         nfserr = nfserr_inval;
    180                         goto fail;
    181                 }
    182 
    183                 if (xdr_stream_decode_u64(xdr, &bex.soff)) {
    184                         nfserr = nfserr_bad_xdr;
    185                         goto fail;
    186                 }
    187                 if (bex.soff & (block_size - 1)) {
    188                         nfserr = nfserr_inval;
    189                         goto fail;
    190                 }
    191 
    192                 if (xdr_stream_decode_u32(xdr, &bex.es)) {
    193                         nfserr = nfserr_bad_xdr;
    194                         goto fail;
    195                 }
    196                 if (bex.es != PNFS_BLOCK_READWRITE_DATA) {
    197                         nfserr = nfserr_inval;
    198                         goto fail;
    199                 }
    200 
    201                 iomaps[i].offset = bex.foff;
    202                 iomaps[i].length = bex.len;
    203         }
    204 
    205         *iomapp = iomaps;
    206         *nr_iomapsp = nr_iomaps;
    207         return nfs_ok;
    208 fail:
    209         kfree(iomaps);
    210         return nfserr;
    211 }


