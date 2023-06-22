Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAA173A8EF
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jun 2023 21:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFVTXl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Jun 2023 15:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjFVTXf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Jun 2023 15:23:35 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D51B1A3;
        Thu, 22 Jun 2023 12:23:34 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77e2f2ad553so280966439f.2;
        Thu, 22 Jun 2023 12:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687461814; x=1690053814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eC08gMbU+jYe02ROyuVIhFgvmG2YMVwcZn8Vj95saR8=;
        b=sESAw4vm7st7jA4Fq67y0hVgzaad2vomCpNrCN+XEGDGFt2BMuTo0uPVoknJvfvHy4
         /U7whvMKc4vyJPE+//Qfs6gFwMtIa8CbKZDH0dlLmk4BIgKmMMyXZK9PY0VLPT1RhXXJ
         87TZJGuYzRsx9/S8RE5K+Tw5Gqd4jGhkaE6uSkBAkLk+s41rVjZ/5gRgVrGiICSPUtqb
         JBPdjmv0d2o2pX1DiuopeWBdXaKJKyYOTGptqUfOscsdtc+s7HsvqSe9f8rertRlq+QQ
         sUmwp5c3e/R+H1lflX+kVKfl85rRNx97/bcCmdY0K+GVkdkD/fhRV59hdRinz5/rbk7T
         v8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687461814; x=1690053814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC08gMbU+jYe02ROyuVIhFgvmG2YMVwcZn8Vj95saR8=;
        b=WcswmBtO9nIK7MUi2+V2+LccAhxRblkgl0TIkVjpYSkmu4kF+qPblHAIW/JxOQhQZ0
         2adgeH7nn0Gpgdlli3fc3rlKElehib1xHZqx6KjvT90lygBwEYspXvrtBsV3yQkgvhnz
         L19EfVgdROgXYwacpJ2yfaZxAdB0Q2QdZaGYgv1xSjpvOJrj3LdxKXYr8CVGxLOSLJrq
         oT20VmFn5kMm5HwhQA1bxRamkSyNYGGrR5GPE1oNSxhJVEDVzXebOCiICnYHL56UzjaH
         hoYw4ZH8uQ2Vp5sZmvCLXKAHspp+qyEdmJRI96ha7+JNj2kw7qu6/Fqnf2reHFbEl85G
         WNMA==
X-Gm-Message-State: AC+VfDyDd5mavdxuRKRCBL/4IZ3MsZ5eO2F6510Ap7SabiqbEkwU9Y7H
        jrJqswb3yrBVsfhi8+973Q2sjxYESp/9Ow==
X-Google-Smtp-Source: ACHHUZ5tKQm8O2WBSKOXZmnobnQ/hphBAZGXxgHqL5BfL+/GYAF+386j2++MO61oTyBpFTeUzYKaKw==
X-Received: by 2002:a6b:fd16:0:b0:778:5cb1:3e27 with SMTP id c22-20020a6bfd16000000b007785cb13e27mr20137995ioi.16.1687461813559;
        Thu, 22 Jun 2023 12:23:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:287f])
        by smtp.gmail.com with ESMTPSA id h1-20020a5e8401000000b0077e35ffac2fsm2305065ioj.32.2023.06.22.12.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:23:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 22 Jun 2023 09:23:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: contention on pwq->pool->lock under heavy NFS workload
Message-ID: <ZJSfsvFtC_d265M1@slm.duckdns.org>
References: <38FA0353-5303-4A3D-86A5-EF1E989CD497@oracle.com>
 <ZJNrht3NlLyPn2A0@slm.duckdns.org>
 <CF5AF0E6-5213-489D-87CD-8E8325A6560F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF5AF0E6-5213-489D-87CD-8E8325A6560F@oracle.com>
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

Hello,

On Thu, Jun 22, 2023 at 03:45:18PM +0000, Chuck Lever III wrote:
> The good news:
> 
> On stock 6.4-rc7:
> 
> fio 8k [r=108k,w=46.9k IOPS]
> 
> On the affinity-scopes-v2 branch (with no other tuning):
> 
> fio 8k [r=130k,w=55.9k IOPS]

Ah, okay, that's probably coming from per-cpu pwq. Didn't expect that to
make that much difference but that's nice.

> The bad news:
> 
> pool->lock is still the hottest lock on the system during the test.
> 
> I'll try some of the alternate scope settings this afternoon.

Yeah, in your system, there's still gonna be one pool shared across all
CPUs. SMT or CPU may behave better but it might make sense to add a way to
further segment the scope so that e.g. one can split a cache domain N-ways.

Thanks.

-- 
tejun
