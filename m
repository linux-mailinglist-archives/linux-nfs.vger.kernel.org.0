Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCAA6865F5
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Feb 2023 13:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBAMdO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Feb 2023 07:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjBAMdN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Feb 2023 07:33:13 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E450C1114C
        for <linux-nfs@vger.kernel.org>; Wed,  1 Feb 2023 04:33:11 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l8so12551143wms.3
        for <linux-nfs@vger.kernel.org>; Wed, 01 Feb 2023 04:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woOh9xu5jNldHrxmdtSlzzJrCvYUiAcEsoN6bJN0i9w=;
        b=h/fKiY2u1tbfYHWdjH7NCFH8fw3suEUfgiJdv1Ml0qe+kU1e/ER53cWVvPiIlSuzJH
         WSgEF8gugF15JoUQo2SMolbkSfXluaS25FKrrYISj3ivIpzJJHLXridxRUgoViQupNm8
         t3II/sBU/fuw4g8YlGrbIZjwfLrW/u7rsiW1pgwX8eA/dw2b+w/Evz47pg5ResPwXlOW
         pjoyjr3JO1+dyA98/NosoT77vXaPRaBPc1tYCkaptBFJUjEthUizON1wpHx6bh39ooJe
         oW3x9gfN1sM0g5uONLurFbLg5xwoYH3U6Fed4BGAExP3aHz2+33swqGZKYtH6kyL99eC
         qKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woOh9xu5jNldHrxmdtSlzzJrCvYUiAcEsoN6bJN0i9w=;
        b=dAFFMt906ukQlOSKtsgJcdXjeRWe2G9w+TnVHoHPly6yG976dAgJcoCv4vdplXFPyt
         iCaaG5PAf+MHsSgZ6tDifWBvikNX7mMvLghPDBusrmcnckLNeYuFqt9w7GLDPH3uukfp
         D2gPqxRq7ykl3eFN+LTFDnN82TQSmPiTTDSjFZbFHCwE5ArcnQOHM7apMDctvU9525Q1
         Ejnmh9NOcLpruVpDYjmfSZ3BvuQSGQI3Z2P5gZTaj2Z33UEdMyCuepIzkYCAg0SRlq6C
         NnKnlHpy1kETkA17guirmunZjLmZ/GKpkY+oe2zTZ8ek6K+o020volQxUiTRGGnJ0MTm
         bUTQ==
X-Gm-Message-State: AO0yUKUq2YeCQcqMOHusBHpzvVtLq7TyLiBdjMpqwZUG2rpzGVuSkkrF
        L2hs1VILOKS2MTTOIjul8DA=
X-Google-Smtp-Source: AK7set8cUPbhpIWPoy17doM7JkvqPEi/0ch0n/9LhmiNiTrp7JOPu+XYf3gmrU9Yh1xvEcivcujR/Q==
X-Received: by 2002:a05:600c:b8f:b0:3da:f5e6:a320 with SMTP id fl15-20020a05600c0b8f00b003daf5e6a320mr7348207wmb.22.1675254790389;
        Wed, 01 Feb 2023 04:33:10 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c21c900b003dc434b39c7sm5903105wmj.0.2023.02.01.04.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:33:10 -0800 (PST)
Date:   Wed, 1 Feb 2023 14:27:22 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     trond.myklebust@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] NFS: Simplify struct nfs_cache_array_entry
Message-ID: <Y9pMmpqzjwQUn1XP@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Trond Myklebust,

The patch a52a8a6adad9: "NFS: Simplify struct nfs_cache_array_entry"
from Nov 1, 2020, leads to the following Smatch static checker
warning:

	fs/nfs/dir.c:226 nfs_readdir_clear_array()
	warn: uncapped user loop index 'i'

fs/nfs/dir.c
    219 static void nfs_readdir_clear_array(struct page *page)
    220 {
    221         struct nfs_cache_array *array;
    222         unsigned int i;
    223 
    224         array = kmap_atomic(page);
    225         for (i = 0; i < array->size; i++)
--> 226                 kfree(array->array[i].name);

I guess I don't really understand how kmap() works.  I thought it was
for mapping userspace memory into kernel space.  So Smatch marks "array"
as untrusted user controlled data.

How should smatch treat kmap()?

    227         array->size = 0;
    228         kunmap_atomic(array);
    229 }

regards,
dan carpenter
