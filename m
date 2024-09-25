Return-Path: <linux-nfs+bounces-6636-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9600C985339
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 08:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47991C23BDC
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 06:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C60155751;
	Wed, 25 Sep 2024 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVDy4jQw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E415575B
	for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247016; cv=none; b=pAhxVxvLxAWQ2b+WPmq9rJfteet4uvblS446XRHVD9Hw7EtBu0vIpG/AcR4asLmTUq5C59Z8aPF3Ey/t0XtXq1HpP60VwlUKgBzk8EM0MkH4iVimU+Pa1tekbHSkS5qO0koHyRapAtcDVfem+NHZKAhZvIPYXSCBlXQbgy5RRGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247016; c=relaxed/simple;
	bh=/eCF2XO9/F9dwPGvs6P9MzUG1LMTTGGJu2Fj8VXNhgk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=umwTpAE8SDq92GSqiQsl3ixvbL1YiLnSz+CDQp6h+1+73bPxIhOm29uQGKPQoAYNoY5Xyc8xR0+64WieuBWGlybAs6OEpC+b7BeE1/g8HsNm61RrWg80Xb2f2MKga/SUbsdOwrNai39Y8BXea3cjMBaNHp54fE3ErlD4Gus5p64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVDy4jQw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cc5fb1e45so142272f8f.2
        for <linux-nfs@vger.kernel.org>; Tue, 24 Sep 2024 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727247013; x=1727851813; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=diq2YgiilWf5U8eJm6rVnc1OetowdeFoXs3N8U1oOqM=;
        b=HVDy4jQwkpleVrJ31+h1x1SpT3jBCDcEgvPuJUCeghA8MlhV0BxhhXn8yV2sIItIxt
         CFBuUA1kU0+dNLeUzKSD1/lAGFlFFsNI8zxfoRwFA7p4Eb7ptMqb2v1ANGi08ku/3Gj8
         3hO1QKg7sanJga0yU2RFCsXlYIB2HzsZTIs4D//x2K1v9HLCDNrN03MaT7edMujgEGCt
         8/MXNe0OXlcDNBKwIWei/EZ+cuK9TMJ/3miiIYfJ6S2h2cXIU7DgbDlROK7slFHt1+q0
         YSlxI5jsNKgHXJ7V+nVljIvr+eY6SQXwoqoYW0WIH+xAfkLn49gFbt0pGSK4aqf26rQV
         vsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727247013; x=1727851813;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=diq2YgiilWf5U8eJm6rVnc1OetowdeFoXs3N8U1oOqM=;
        b=aGgFYH9MpJoLIXC6UC9JkdWNhhr/BVRVLSvoB+eAP/SFG58AM3sD9Qd492pIYhlccr
         ra2H9M98UNROnSZaxwCr46tbcG1BIl01Ni97hxON7wRioKwISjPSiRHx6kkzsqeUqNZf
         k1F+NIbfNj84cn3/AmQKayva3OHk1s40vgVLFwIospkQYdK7ZUaqw2W8fD3WDR7SjMTU
         gPEvYrgKHJc2Q4hWcLLBhn4MCZU+nGyjQSMtmZBFOg0Z4WUrYNtIB72YQHK32e69qJYE
         7aQNtp0GKEujbWd3dq/TPrw0pQRKfj7PIcrJ8xfZ6uSsQAtgy0tMOwyr8Ab5t+TmxKqy
         FWYA==
X-Gm-Message-State: AOJu0YzQeJgDGkyh+X8Z990i/yqyA5aMD7cCNrXPqA4y6KGOT9AfrNqy
	sF8lVVdTz7qZ1sO7u3TOSQHKcqZFABsTC26DlYTgp1TO9IvbArzRw8O/s3M4ZF8=
X-Google-Smtp-Source: AGHT+IHYmaPqmJPJIEgNc35OYPlcJVEpnwQdiJTFvxo2qTKC/vErGIgV9qZVu27fVTjzaOU35GmDFw==
X-Received: by 2002:adf:f30c:0:b0:374:cd36:8533 with SMTP id ffacd0b85a97d-37cc24c7347mr1102371f8f.54.1727247012795;
        Tue, 24 Sep 2024 23:50:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f976esm3154313f8f.69.2024.09.24.23.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 23:50:11 -0700 (PDT)
Date: Wed, 25 Sep 2024 09:50:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] SUNRPC: replace program list with program array
Message-ID: <12f691c2-6453-4646-a31a-23d14a610b97@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello NeilBrown,

Commit 86ab08beb3f0 ("SUNRPC: replace program list with program
array") from Sep 5, 2024 (linux-next), leads to the following Smatch
static checker warning:

	net/sunrpc/svc.c:1368 svc_process_common()
	error: uninitialized symbol 'progp'.

net/sunrpc/svc.c
    1320 static int
    1321 svc_process_common(struct svc_rqst *rqstp)
    1322 {
    1323         struct xdr_stream        *xdr = &rqstp->rq_res_stream;
    1324         struct svc_program        *progp;
    1325         const struct svc_procedure *procp = NULL;
    1326         struct svc_serv                *serv = rqstp->rq_server;
    1327         struct svc_process_info process;
    1328         enum svc_auth_status        auth_res;
    1329         unsigned int                aoffset;
    1330         int                        pr, rc;
    1331         __be32                        *p;
    1332 
    1333         /* Will be turned off only when NFSv4 Sessions are used */
    1334         set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
    1335         clear_bit(RQ_DROPME, &rqstp->rq_flags);
    1336 
    1337         /* Construct the first words of the reply: */
    1338         svcxdr_init_encode(rqstp);
    1339         xdr_stream_encode_be32(xdr, rqstp->rq_xid);
    1340         xdr_stream_encode_be32(xdr, rpc_reply);
    1341 
    1342         p = xdr_inline_decode(&rqstp->rq_arg_stream, XDR_UNIT * 4);
    1343         if (unlikely(!p))
    1344                 goto err_short_len;
    1345         if (*p++ != cpu_to_be32(RPC_VERSION))
    1346                 goto err_bad_rpc;
    1347 
    1348         xdr_stream_encode_be32(xdr, rpc_msg_accepted);
    1349 
    1350         rqstp->rq_prog = be32_to_cpup(p++);
    1351         rqstp->rq_vers = be32_to_cpup(p++);
    1352         rqstp->rq_proc = be32_to_cpup(p);
    1353 
    1354         for (pr = 0; pr < serv->sv_nprogs; pr++) {

This loop used to iterate until we hit a break statement or until progp was NULL

    1355                 progp = &serv->sv_programs[pr];

But now progp is always non-NULL.  (Smatch is concerned that ->sv_nprogrs is
<= 0 but I doubt that's possible?)

    1356 
    1357                 if (rqstp->rq_prog == progp->pg_prog)
    1358                         break;
    1359         }
    1360 
    1361         /*
    1362          * Decode auth data, and add verifier to reply buffer.
    1363          * We do this before anything else in order to get a decent
    1364          * auth verifier.
    1365          */
    1366         auth_res = svc_authenticate(rqstp);
    1367         /* Also give the program a chance to reject this call: */
--> 1368         if (auth_res == SVC_OK && progp)
                                           ^^^^^
So this condition doesn't make sense.

    1369                 auth_res = progp->pg_authenticate(rqstp);
    1370         trace_svc_authenticate(rqstp, auth_res);
    1371         switch (auth_res) {
    1372         case SVC_OK:
    1373                 break;
    1374         case SVC_GARBAGE:
    1375                 goto err_garbage_args;
    1376         case SVC_SYSERR:
    1377                 goto err_system_err;
    1378         case SVC_DENIED:
    1379                 goto err_bad_auth;
    1380         case SVC_CLOSE:
    1381                 goto close;
    1382         case SVC_DROP:
    1383                 goto dropit;
    1384         case SVC_COMPLETE:
    1385                 goto sendit;
    1386         default:
    1387                 pr_warn_once("Unexpected svc_auth_status (%d)\n", auth_res);
    1388                 goto err_system_err;
    1389         }
    1390 
    1391         if (progp == NULL)
                     ^^^^^^^^^^^^^
Same

    1392                 goto err_bad_prog;
    1393 
    1394         switch (progp->pg_init_request(rqstp, progp, &process)) {
    1395         case rpc_success:
    1396                 break;
    1397         case rpc_prog_unavail:
    1398                 goto err_bad_prog;
    1399         case rpc_prog_mismatch:

regards,
dan carpenter

