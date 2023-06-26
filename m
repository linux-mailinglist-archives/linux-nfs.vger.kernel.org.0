Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB93C73EBBB
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jun 2023 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFZUVc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jun 2023 16:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjFZUVb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jun 2023 16:21:31 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F2611D;
        Mon, 26 Jun 2023 13:21:30 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5533c545786so2423855a12.1;
        Mon, 26 Jun 2023 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687810890; x=1690402890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gp9pHGIFobLb/ub4aK2fR6jSEu86S+QQeKX1nWkWvE=;
        b=fvhxAdCNuGnceSESiy0qMI/h57psQdf4WAKEwNbQKCeI/ZhdE4mVl0pA90r3gGXB2g
         3ewf0YzLXD+7fOuBmoc4T/ZRMa3OGp89pzKtjPO5bLxkN0ZE5oEayDkCajNwLA10POc3
         CaA4hQSoBh6cfxBywWEQLvHNnt1LYX+VCaAEbKmM88AXMLStHR/Q/4xflwacOQ+8iVna
         Fh2+Jr0gUqlWOwgsjx2wg2IPLvNP7ZNvfSPvzbTLCKSXgXuojFsIKu9JAk1uWj91nrtk
         4zts0YMtQYqFdtGvKstVaPG8/JJu/0ws1ob70cSh0UdJRVadBLgSpsbYER/xdxVwfgwv
         O7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687810890; x=1690402890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gp9pHGIFobLb/ub4aK2fR6jSEu86S+QQeKX1nWkWvE=;
        b=U7tfNL8yDlDaFSKPSxKLbhf9thOOv4aqVfws72gJ9ZsJV3Ic7AosVVBFE6wzRA1TNW
         NFW2GZIwdDRrRqSWTbxld2WWWoNtjRt35YN5dZPmSIbZRnf/M/RUOi5RJfAlYx4e02pF
         pqtjvVOpfrUCzbSu6IB7nIOHMoLj8gHVy7GIggmneCNXtisPDqopC5+Lk22WCcKs+yiq
         0gIRVIj7BXt2pnfu/hm0E6iI5Ygqv9tSWI3+3Sf3mk3ciimYN20gIgNX/L86H+IEPCwl
         bvJRKAeu2favx/3b95Wg1Pxupg8T8D9BbG7drhRr/FkeMcXY2frhOYHYEMZQ+y4gkcJj
         KpVA==
X-Gm-Message-State: AC+VfDwVHM8Fw4WX0u3ji+3kzWLlFRLfqXfy66Q4YjkfB6pF9ss0dL4T
        dqH8M0qmhPFb7sRaIVGy8Ui088oiIrJFfQ==
X-Google-Smtp-Source: ACHHUZ6c65qKJqjRFTsTCErbai7aegvBFMr+pJ6kbEf5erTOOngJ/7IiQPSzg8IFTcpoJuxX1GFdWQ==
X-Received: by 2002:a17:90a:4d88:b0:25c:18ad:6b82 with SMTP id m8-20020a17090a4d8800b0025c18ad6b82mr40026146pjh.21.1687810890086;
        Mon, 26 Jun 2023 13:21:30 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090ade9400b0025bc49aa716sm4817295pjv.27.2023.06.26.13.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:21:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jun 2023 10:21:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: contention on pwq->pool->lock under heavy NFS workload
Message-ID: <ZJnzSSMdWhnuXYNE@slm.duckdns.org>
References: <38FA0353-5303-4A3D-86A5-EF1E989CD497@oracle.com>
 <ZJNrht3NlLyPn2A0@slm.duckdns.org>
 <CF5AF0E6-5213-489D-87CD-8E8325A6560F@oracle.com>
 <ZJSfsvFtC_d265M1@slm.duckdns.org>
 <36C8F75A-7C84-4D86-A721-6BCD6001CAFF@oracle.com>
 <7E9EF026-EF8B-4125-AB00-A1E9F0F907C5@oracle.com>
 <ZJZKb4CvyKmHBwmg@slm.duckdns.org>
 <24E8E2D2-F91B-47F6-91BF-02D02750054F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24E8E2D2-F91B-47F6-91BF-02D02750054F@oracle.com>
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

On Sun, Jun 25, 2023 at 04:01:38PM +0000, Chuck Lever III wrote:
> Both wq_pool_mutex and copy_workqueue_attrs() are static, so having
> only apply_workqueue_attrs() is not yet enough to carry this off
> in workqueue consumers such as sunrpc.ko.
> 
> It looks like padata_setup_cpumasks() for example is holding the
> CPU read lock, but it doesn't take the wq_pool_mutex.
> apply_wqattrs_prepare() has a "lockdep_assert_held(&wq_pool_mutex);" .
> 
> I can wait for a v3 of this series so you can construct the public
> API the way you prefer.

Ah, indeed. That API isn't really useable right now. It's gonna be a while
before the affinity scope patches are applied. I'll fix up the apply
interface afterwards.

Thanks.

-- 
tejun
