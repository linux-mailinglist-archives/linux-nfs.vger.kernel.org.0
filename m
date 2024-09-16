Return-Path: <linux-nfs+bounces-6513-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DAD97A507
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 17:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E84F286172
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163BF155CBA;
	Mon, 16 Sep 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9raKL/9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BAE157A72
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499681; cv=none; b=pFtoj5JLYkCiCRtwWW2i2FT1wSdVM+vMWrOsSVMvxpwzxmVIPd1r0mnt+DTNPKdayHU+IrnfBSChxxqjzs7D7N46x3HSTKxKXvbziTGyzsqv8HH//4fb5yKshDm6LyDp5rlc68C7xfg1ACwnIzxZWQfdEe+2VejlL9GgXfVdAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499681; c=relaxed/simple;
	bh=Sv0Rxv+yxy8niHK9XBVRbApuFNTcwKQPwo77pA/4qPs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NCLy4HvUwEMzPZx1mn+begY1W594Jt/PIXaV5RCeKXZzZcD1PfGyhWy/OLRxlS6fGKz+DTf0FaZF+JD0h4djxHc4w3rReDr4N6ahrnaBp5VgwfyAr7PoHsJbuxmpyoyGCafsFdFy7bVMy7Cfbq4pn10Szr30HBj4VYej7eTnjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d9raKL/9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a837cec81so260165166b.2
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726499678; x=1727104478; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wV6yfbjsti0Dnlo+9zCnxR9bFPDF+JkbbHcFhgk/Qq8=;
        b=d9raKL/9tCfZz0n3xC4n77y3ZPn5KlEkOcb4qAdhefgSagXQ+ooAnR4H2C7yCmsUtu
         JDjLVhikfUtKN+VQNL1CLABu+hjYkrvvL/ZmoeByvYxYm99CvgCcgEU6ucx4+8FZB8Bq
         pOZ7qT7GSvXr3zoPeEp2ae1hO64gm9SoFzsg9/m6wwhcBiMF5KedK1QME5lrqP2JyBH5
         TSCbRSf8xPhIc4ue3kdIJG0jmJBWm6ZBTZ33aOThnSoxu8qjINibBjJx3s01Or+Z7EyZ
         +ALJRJewfEaxH0+4qt5MKlGL2MEzJg9KMV2+ljxYF1YMInIB5mi9DjSvMefy3eAEe+ng
         nP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726499678; x=1727104478;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wV6yfbjsti0Dnlo+9zCnxR9bFPDF+JkbbHcFhgk/Qq8=;
        b=BKHrFgwy1lzal9bFnOaqvlSOLhngP0O/mBCdXqnGUWqXqkVkQoiGfmeFNGsOQFxfc7
         uYIeKIXbISsA738nwcj/3WXENgjM7Z1LU1gUNhOg0/HS00M+LfKDvBZGwH3xWDO6kSjs
         SeCFxpJLqiG7XIgMhVnUrwlnTuImpJHmiLxcXPx/81NdUWG90noZJ/ed2kt3GrLMRvqp
         H47W6s3QTRDCvNmhHPxCCuCqCUcOAby0qJ/2p0fxzgglkDmc6Cjsefa3qZr9tOA+H6XA
         EuTlKpoei+sRRZSGTp/9Vp5opO6PzHlTQp3gjR1FcGCgPQ2dVrkfMGBRtPBlLGPyZT/i
         Mw+A==
X-Gm-Message-State: AOJu0YzurlrmIyjoeIlmOmMnpadnXCsJV/bP531Fu+xI52xkPwxOAXfr
	+0Ya0MkQH64jIMJIq1U6yvPWdTy4352zeZOL4tZqBN+cf+mJrt6k3C/PmZ0brMg=
X-Google-Smtp-Source: AGHT+IE41dsXRl0M00HgFOKMtkBDgA82vxHGLmjpMb46dR9uX5kfkvoB9FglLdAImw/GYcrqo61B2g==
X-Received: by 2002:a05:6402:5d3:b0:5c3:c530:e99a with SMTP id 4fb4d7f45d1cf-5c41e1930c7mr21136872a12.15.1726499678136;
        Mon, 16 Sep 2024 08:14:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5dc0dsm2707965a12.42.2024.09.16.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 08:14:37 -0700 (PDT)
Date: Mon, 16 Sep 2024 18:14:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] SUNRPC: Convert unwrap_integ_data() to use xdr_stream
Message-ID: <9084882e-0fa6-4426-bc4d-fb20e86eeead@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Chuck Lever,

Commit b68e4c5c3227 ("SUNRPC: Convert unwrap_integ_data() to use
xdr_stream") from Jan 2, 2023 (linux-next), leads to the following
Smatch static checker warning:

	net/sunrpc/auth_gss/svcauth_gss.c:895 svcauth_gss_unwrap_integ()
	warn: potential user controlled sizeof overflow 'offset + 4'

net/sunrpc/auth_gss/svcauth_gss.c
    859 static noinline_for_stack int
    860 svcauth_gss_unwrap_integ(struct svc_rqst *rqstp, u32 seq, struct gss_ctx *ctx)
    861 {
    862         struct gss_svc_data *gsd = rqstp->rq_auth_data;
    863         struct xdr_stream *xdr = &rqstp->rq_arg_stream;
    864         u32 len, offset, seq_num, maj_stat;
    865         struct xdr_buf *buf = xdr->buf;
    866         struct xdr_buf databody_integ;
    867         struct xdr_netobj checksum;
    868 
    869         /* Did we already verify the signature on the original pass through? */
    870         if (rqstp->rq_deferred)
    871                 return 0;
    872 
    873         if (xdr_stream_decode_u32(xdr, &len) < 0)
                                               ^^^^
    874                 goto unwrap_failed;
    875         if (len & 3)

There used a if (len > buf->len) here but it was deleted.

    876                 goto unwrap_failed;
    877         offset = xdr_stream_pos(xdr);
    878         if (xdr_buf_subsegment(buf, &databody_integ, offset, len))

I don't see any bounds checking in here but I might have missed it

    879                 goto unwrap_failed;
    880 
    881         /*
    882          * The xdr_stream now points to the @seq_num field. The next
    883          * XDR data item is the @arg field, which contains the clear
    884          * text RPC program payload. The checksum, which follows the
    885          * @arg field, is located and decoded without updating the
    886          * xdr_stream.
    887          */
    888 
    889         offset += len;
                ^^^^^^^^^^^^^
This could be an integer overflow?

    890         if (xdr_decode_word(buf, offset, &checksum.len))
    891                 goto unwrap_failed;
    892         if (checksum.len > sizeof(gsd->gsd_scratch))
    893                 goto unwrap_failed;
    894         checksum.data = gsd->gsd_scratch;
--> 895         if (read_bytes_from_xdr_buf(buf, offset + XDR_UNIT, checksum.data,
                                                 ^^^^^^^^^^^^^^^^^
This integer overflow warning is only about foo + sizeof() to cut down on false
positives.

    896                                     checksum.len))
    897                 goto unwrap_failed;
    898 
    899         maj_stat = gss_verify_mic(ctx, &databody_integ, &checksum);
    900         if (maj_stat != GSS_S_COMPLETE)
    901                 goto bad_mic;
    902 
    903         /* The received seqno is protected by the checksum. */
    904         if (xdr_stream_decode_u32(xdr, &seq_num) < 0)
    905                 goto unwrap_failed;
    906         if (seq_num != seq)
    907                 goto bad_seqno;
    908 
    909         xdr_truncate_decode(xdr, XDR_UNIT + checksum.len);
    910         return 0;
    911 
    912 unwrap_failed:
    913         trace_rpcgss_svc_unwrap_failed(rqstp);
    914         return -EINVAL;
    915 bad_seqno:
    916         trace_rpcgss_svc_seqno_bad(rqstp, seq, seq_num);
    917         return -EINVAL;
    918 bad_mic:
    919         trace_rpcgss_svc_mic(rqstp, maj_stat);
    920         return -EINVAL;
    921 }

regards,
dan carpenter

