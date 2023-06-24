Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2733E73C5F2
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jun 2023 03:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjFXBoV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jun 2023 21:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjFXBoU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Jun 2023 21:44:20 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1A12738;
        Fri, 23 Jun 2023 18:44:18 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3411ea250efso5103285ab.3;
        Fri, 23 Jun 2023 18:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687571058; x=1690163058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMommZLnYHJXEnk+MncZOGSvudo7MNGmt+FMy+GKCMQ=;
        b=PNzriG/OKI1Y/mfSlLbtZmPE8UrhRGAs8F2kh+JgDdWcZZcaWcFPUtx0muy0EIHM5x
         IivxkDLlf6DEitYaSjf54syRuywwCbqu0xNoXQdq76l5gvio6RNg/ckhEcJ0Obl6P6G4
         2OYa4SY24CrLz/zuAeqVrNM9/Efw3HtrjU1z65/STmSPfKIsR3Qcja+CTEsLxwQ5PF9t
         QiDnAFOL0jN3sur5FxCEzEdKiS7D/hbGVRtZDMcx/72IcUIrN7QORP3hMaCfzONKq/WJ
         esjyRRFDmrPMTWeCIpiEnsqSj0mSlIHkLp74/f40zu7fS9tyzMQRcswpGrLUwK4oHS7A
         4fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687571058; x=1690163058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMommZLnYHJXEnk+MncZOGSvudo7MNGmt+FMy+GKCMQ=;
        b=P4FULO7nxozdoWuJXA5BSIgQvznQhSbVXWrVXcYqKHbKuBnAcyv5SvSwWJnu0zWFGS
         zlgAJ573v4RKZDvqPL8ia/2t7W6JFqnPwiE0D2W9Tf0DvnP+I1P3qiSEsaZxKm6u4VId
         iQdOpdD848J5dlissbpxLJe26VJH8RFVmYf8kne/wduGvZbE2P/f9ldMsifRcnAZJtz+
         M0LWg4tfqufvCecFWj+Ue3idGlVz4+pbpuvrI5KUbBricN7ggkl/+UIqf/reitTBIV7C
         NZL8XOQJK2U/w9whpN4q1USMPwiVlTkJ+0yFrd2bauEZJeDg7vr1tBW/Br+Arbod5Ju9
         WErQ==
X-Gm-Message-State: AC+VfDzmvaFzCifi13D/M5CYqOE2OXwK4CqB9QT0pSilH23L1jY2ayl+
        xpQMUu2WIdOy9KbYWHISH3I=
X-Google-Smtp-Source: ACHHUZ5FWOInilLhcehZIDyUAiMvxbQYaIerluvkJDK5CtaIlAGF+oh9LgPYUlOwqv8w+PkzqBUUZw==
X-Received: by 2002:a92:c10e:0:b0:335:7be2:26ca with SMTP id p14-20020a92c10e000000b003357be226camr25301144ile.19.1687571057596;
        Fri, 23 Jun 2023 18:44:17 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id e17-20020a921e11000000b003312915e615sm212173ile.28.2023.06.23.18.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 18:44:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Jun 2023 15:44:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: contention on pwq->pool->lock under heavy NFS workload
Message-ID: <ZJZKb4CvyKmHBwmg@slm.duckdns.org>
References: <38FA0353-5303-4A3D-86A5-EF1E989CD497@oracle.com>
 <ZJNrht3NlLyPn2A0@slm.duckdns.org>
 <CF5AF0E6-5213-489D-87CD-8E8325A6560F@oracle.com>
 <ZJSfsvFtC_d265M1@slm.duckdns.org>
 <36C8F75A-7C84-4D86-A721-6BCD6001CAFF@oracle.com>
 <7E9EF026-EF8B-4125-AB00-A1E9F0F907C5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E9EF026-EF8B-4125-AB00-A1E9F0F907C5@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey,

On Fri, Jun 23, 2023 at 02:37:17PM +0000, Chuck Lever III wrote:
> I'm using NFS/RDMA for my test because I can drive more IOPS with it.
> 
> I've found that setting the nfsiod and rpciod workqueues to "cpu"
> scope provide the best benefit for this workload. Changing the
> xprtiod workqueue to "cpu" had no discernible effect.
> 
> This tracks with the number of queue_work calls for each of these
> WQs. 59% of queue_work calls during the test are for the rpciod
> WQ, 21% are for nfsiod, and 2% is for xprtiod.
> 
> The same test with TCP (using IP-over-IB on the same physical network)
> shows no improvement on any test. That suggests there is a bottleneck
> somewhere else, when using TCP, that limits its throughput.

Yeah, you can make the necessary workqueues to default to CPU or SMT scope
using apply_workqueue_attrs(). The interface a bit cumbersome and we
probably wanna add convenience helpers to switch e.g. affinity scopes but
it's still just several lines of code.

Thanks.

-- 
tejun
