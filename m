Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7585462FAF7
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Nov 2022 18:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbiKRRAU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Nov 2022 12:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242169AbiKRRAT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Nov 2022 12:00:19 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7693A87A40
        for <linux-nfs@vger.kernel.org>; Fri, 18 Nov 2022 09:00:18 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h14so5006299pjv.4
        for <linux-nfs@vger.kernel.org>; Fri, 18 Nov 2022 09:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TThN9EjghGiN/tuFc6wPX6GqaW/hzqaujSE2kp1eBs=;
        b=eygPz9dT5zVZTbgpWAHY1wME0OfRDovtVRGYQqwVShoGa80yBlHlieQFim7CsakxqX
         fDMll4oHXXBUP6E8waKvG83ciP3NU2XiVtAoPF6EpTNOPJ3OJMVfWHhacPuaIwYVQwug
         kuHuEDxaPmOPnanz4g5nBvSVTTchZje4v4pjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TThN9EjghGiN/tuFc6wPX6GqaW/hzqaujSE2kp1eBs=;
        b=cfl2UyU7aV8IyI8PF7h2jV6DIy6Ppt9E8tOz+TlySEUD0MPhy7UTqMkUC4pPxSjEba
         XUI5DfsQscFzPIYQAmaEt6aB05JlJdsfWLQaFAcrEK016J2KLqb2mzgjVZvST+Xkn4RT
         Sk12CO4YXNADnO5P1aO7jFP2HQFhxrZy8l3IibL8D+LadgM/Q8H/SvHKDIbE4Iej7wcn
         hunCCk0RhcyN2MstgR+0AKp37YTOeLX7xqVjW5jYTdGccKSnnXz1DxbBWl+lUrZA3PUC
         dS3H4hcqk3Y41oh1jvfr3v9OZe4HXcDbYPGpOIlscEGUFQbNxpF+SzX/CkWryueZFsdR
         7L3A==
X-Gm-Message-State: ANoB5pk0DPQMWNhwLT0huHwBWMN5mo8hUBN0dDCgVyS8xjJxcwjLOUQk
        WlpZJf7Ah4+UGhAykwfx2AHkYg==
X-Google-Smtp-Source: AA0mqf5QvHv11UC9twhA6JD4pceg2EobzmHdMqKKh3Naitc4xc3SRR7TJucJpCtXoSecmx9CZqphkw==
X-Received: by 2002:a17:90a:294f:b0:213:d04:7529 with SMTP id x15-20020a17090a294f00b002130d047529mr14331588pjf.181.1668790817961;
        Fri, 18 Nov 2022 09:00:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b00178b77b7e71sm475429plh.188.2022.11.18.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 09:00:17 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 18 Nov 2022 09:00:16 -0800
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: encode_cb_recallany4args(): Error handling issues
Message-ID: <202211180900.6F94436@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221118 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Thu Nov 17 11:55:28 2022 -0500
    32dce0f9611b ("NFSD: add support for sending CB_RECALL_ANY")

Coverity reported the following:

*** CID 1527365:  Error handling issues  (CHECKED_RETURN)
fs/nfsd/nfs4callback.c:344 in encode_cb_recallany4args()
338      */
339     static void
340     encode_cb_recallany4args(struct xdr_stream *xdr,
341     	struct nfs4_cb_compound_hdr *hdr, struct nfsd4_cb_recall_any *ra)
342     {
343     	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
vvv     CID 1527365:  Error handling issues  (CHECKED_RETURN)
vvv     Calling "xdr_stream_encode_u32" without checking return value (as is done elsewhere 23 out of 24 times).
344     	xdr_stream_encode_u32(xdr, ra->ra_keep);
345     	xdr_stream_encode_uint32_array(xdr, ra->ra_bmval,
346     				       ARRAY_SIZE(ra->ra_bmval));
347     	hdr->nops++;
348     }
349

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527365 ("Error handling issues")
Fixes: 32dce0f9611b ("NFSD: add support for sending CB_RECALL_ANY")

Thanks for your attention!

-- 
Coverity-bot
