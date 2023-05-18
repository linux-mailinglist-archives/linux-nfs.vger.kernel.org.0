Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED0F707994
	for <lists+linux-nfs@lfdr.de>; Thu, 18 May 2023 07:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjERF0Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 May 2023 01:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjERF0X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 May 2023 01:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB133A90
        for <linux-nfs@vger.kernel.org>; Wed, 17 May 2023 22:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684387532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XgjDn/fMn2KTsPrGr1IM2peFSMqoGe+HeOm/AiE4UBk=;
        b=Q67zZT7RfO+npppT+srDf3+OOvktFu75mU01p+uTOXqp7CYR6SVUPKyBAA/U/8qgI8+d/q
        bAuar//5VNWiJA3jCK065M3/MyoY1hkfSJfYInoqGnJuFSGU2Ew90UjaUoycCNGFDpd6Id
        S+7gZQz3v8FGb2ifwgG1rvC0AtvkdjY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-UwuRv4wGPd20bKUqiFDipw-1; Thu, 18 May 2023 01:25:31 -0400
X-MC-Unique: UwuRv4wGPd20bKUqiFDipw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-64386573ba8so978870b3a.3
        for <linux-nfs@vger.kernel.org>; Wed, 17 May 2023 22:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684387530; x=1686979530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgjDn/fMn2KTsPrGr1IM2peFSMqoGe+HeOm/AiE4UBk=;
        b=PpK7hO324CooHEXYA06neO5BOJEn3bP1oD6cW55yPbP63FiJAbrSa52kKqFS61esVb
         Ht+Iadh+npI4a8wpz3L6OBL6RZ6JfDh0+D2gVRRpcpSx98qMmjiukFfZRmNNuU3oEBPR
         mTb7stqS0n1epNKvUT80KMJjV2pkgbnuOoMcElMtjX5S2CQ0RpsECNrN8+i9IOjMKeHw
         JB4e4ROash4A4t1PiEkd1rOeYfC6tARzgtdq9gP7TL3srArui0tpipTA/drAkZJqxDB3
         VP46F5OfQoLCEvwl58UK4auWrWfpVjYYwIWSenHPsr7+hslz3LLfDQmw2I2T6/0R1abg
         PbYA==
X-Gm-Message-State: AC+VfDy5HMHoxtO94dJ0z3fgBlNtC+TqfH7UIRCL9WHLDSQHvypulyF2
        ECYy4D+chNjwOCNwonEfS8s3727fSvRv3mCVMprZ3qAWadYwqJBedMwaEI+MDS6Pi9FWANMbjwW
        R6OIo4s+VB0n375J1w6J9Ja6yOcyoisuAtg==
X-Received: by 2002:a05:6a21:6da9:b0:101:457:c687 with SMTP id wl41-20020a056a216da900b001010457c687mr1149750pzb.20.1684387529861;
        Wed, 17 May 2023 22:25:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7T/jB8RExJYkHCtr4EJfPn00TyB+0UIDeZc2b6eY6r+YEAtuXYp+TZgyT+XhHQFCjrcB12wQ==
X-Received: by 2002:a05:6a21:6da9:b0:101:457:c687 with SMTP id wl41-20020a056a216da900b001010457c687mr1149730pzb.20.1684387529496;
        Wed, 17 May 2023 22:25:29 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p37-20020a631e65000000b005143448896csm361081pgm.58.2023.05.17.22.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 22:25:29 -0700 (PDT)
Date:   Thu, 18 May 2023 13:25:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3] generic/728: Add a test for xattr ctime updates
Message-ID: <20230518052524.dzoniitzq72hkzyx@zlang-mailbox>
References: <20230516141407.201674-1-anna@kernel.org>
 <c4b7915a-0bb7-178e-0258-fe24ee3359df@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b7915a-0bb7-178e-0258-fe24ee3359df@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, May 17, 2023 at 01:04:59PM +0800, Anand Jain wrote:
> On 16/5/23 22:14, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > The NFS client wasn't updating ctime after a setxattr request. This is a
> > test written while fixing the bug.
> 
> You can include the '_fixed_by_kernel_commit' field for hints

Anna said the related kernel commit hasn't been acked. I'm not sure what's the
current status, if it's acked but not merged, Anna can use "xxxxxxxx" to replace
the commit id temporarily, or add this later (just don't forget:)

Thanks,
Zorro

> on unfixed kernels. With this and Darrick's suggestions, you
> can add my RB.
> 
>  Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> 

