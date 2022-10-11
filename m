Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B625FB760
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 17:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJKPeJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 11:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJKPdZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 11:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7929111B2D2
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665501750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1KeRoBKO88EXX5LJybx+YRok7f0l9HL7l45UCULlJ0=;
        b=fxccCCYh3uxr25p9sTddCKnFm7ho18ZSLBIeMv9wa0CaEpNtlvQUbLW6IvCgNOjZqXEMRG
        LiKDjTlLXT2rfIoBsLn5S0nEZ3IkUEqK+oDDhIAYNCXG9PCsnxprM/DtLQAd3h6YdNQFWe
        5ZdkxKl1DA9dCMGibtM+/6LrX6N0aa4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-77-Lnigrir-Og6heFOImMbEcQ-1; Tue, 11 Oct 2022 11:01:02 -0400
X-MC-Unique: Lnigrir-Og6heFOImMbEcQ-1
Received: by mail-wm1-f69.google.com with SMTP id n6-20020a7bc5c6000000b003c6bbe5d5cfso2848167wmk.4
        for <linux-nfs@vger.kernel.org>; Tue, 11 Oct 2022 08:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1KeRoBKO88EXX5LJybx+YRok7f0l9HL7l45UCULlJ0=;
        b=hO3t8B8mm2t1iXp2UAhc+4qbxcH5CKXfS/Ry/ik8057MA0zrF+j7dXOJXfLgY7kAb4
         ie90IONAxT1Pry80x2GSot4LSk9hJ95WJpqenIw34EjxHu1Fjl08wNqz6SMhBPMOECX7
         RGKg/1XMAN1sjdmEowE/jSm/H4GfnWmjqfTdQF+2PJqkVCHxT33anCb5YrR5aTl86Qzp
         SuVPDulkinsjQX2nQrvsGG7VJYAJ2hOBY8bgZyBnpFt5f0DMko5DXmv+TAyuP4sqm3ug
         oiBL7s3ZKccEzlBmwOcGCaKnOiXAwtVfLcY0YUTpZvbt4LBA1pMW+RCyGhgKoBjJ3AXA
         Bc/Q==
X-Gm-Message-State: ACrzQf2bkuyZrH8agnXd6IHoOYSRdKv1nL3VUi4ZIZXpX27xjmqoLcKg
        BpbxgnBbXZy8wNRMEpCEe02rv52bcRPJfr2uNxlw6RRhkO6/h33ia8ArdWD4CHN0XSG5J8BrLVd
        4auZ3O50XbtL7+1JK/mGO
X-Received: by 2002:a05:600c:354c:b0:3b4:a328:1412 with SMTP id i12-20020a05600c354c00b003b4a3281412mr23060332wmq.145.1665500461364;
        Tue, 11 Oct 2022 08:01:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6yj4NmRzNeT/kH5WdB4Zmx97Pn1nMeOBMzVm6fHnABNo3WBPVyxNcPNjFbDuX9hiHBHzWq9A==
X-Received: by 2002:a05:600c:354c:b0:3b4:a328:1412 with SMTP id i12-20020a05600c354c00b003b4a3281412mr23060323wmq.145.1665500461185;
        Tue, 11 Oct 2022 08:01:01 -0700 (PDT)
Received: from localhost.localdomain ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id bo17-20020a056000069100b0022e653f5abbsm11651290wrb.69.2022.10.11.08.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:01:00 -0700 (PDT)
Date:   Tue, 11 Oct 2022 17:00:57 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [PATCH v2] sunrpc: Use GFP_NOFS to prevent use of
 current->task_frag.
Message-ID: <20221011150057.GB3606@localhost.localdomain>
References: <de6d99321d1dcaa2ad456b92b3680aa77c07a747.1665401788.git.gnault@redhat.com>
 <Y0QyYV1Wyo4vof70@infradead.org>
 <20221010165650.GA3456@ibm-p9z-18-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com>
 <Y0UKq62ByUGNQpuY@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0UKq62ByUGNQpuY@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 10, 2022 at 11:18:19PM -0700, Christoph Hellwig wrote:
> On Mon, Oct 10, 2022 at 06:56:50PM +0200, Guillaume Nault wrote:
> > That's what my RFC patch did. It was rejected because reading
> > current->flags may incur a cache miss thus slowing down TCP fast path.
> > See the discussion in the Link tag:
> > https://lore.kernel.org/netdev/b4d8cb09c913d3e34f853736f3f5628abfd7f4b6.1656699567.git.gnault@redhat.com/
> 
> As GFP_NOFS/NOIO are on their way out the networking people will have to
> do this anyway.

We can always think of a nicer solution in the future. But right now we
have a real bug to fix.

Commit a1231fda7e94 ("SUNRPC: Set memalloc_nofs_save() on all
rpciod/xprtiod jobs") introduces a bug that crashes the kernel. I can't
see anything wrong with a partial revert.

