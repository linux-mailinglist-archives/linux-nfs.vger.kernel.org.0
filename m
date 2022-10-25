Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B9B60CAB1
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 13:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiJYLPj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Oct 2022 07:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiJYLPe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Oct 2022 07:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C57112ABE
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666696531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c7bW41VuSqcRQyPX6vwXhhOS0mRKD55wff4sbYfZqKY=;
        b=EhKHvr6QSQqtzeu2OE2MnikX3GnrUPi3DywYMceMpH2UgsxvafHozobeElT3TymSCBOhFH
        ZGux/STskRcHZ3vwc+O8ybkPE8jbjMg9RJ3B4qtoIRYLRlLonG9sitFw3GxxivQQ1wWNC7
        iUC0oQnlhNwLjPykJh/m2QgmUeTJUWE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-X2keDgP6PsGDFvzDYjqQvA-1; Tue, 25 Oct 2022 07:15:30 -0400
X-MC-Unique: X2keDgP6PsGDFvzDYjqQvA-1
Received: by mail-wr1-f72.google.com with SMTP id p7-20020adfba87000000b0022cc6f805b1so4507624wrg.21
        for <linux-nfs@vger.kernel.org>; Tue, 25 Oct 2022 04:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7bW41VuSqcRQyPX6vwXhhOS0mRKD55wff4sbYfZqKY=;
        b=3ynhCIM8rni3bAHIrJAqPKPBh5k0WHkIvpF+x090I9s3e6SwzIH3BSybr61v59DJQU
         esLcpOGMI6R3nxV+lvGVmhg48cHgX2Tk72/pbglg12YY9XxLVx3rDyY9/MtZW1LouPnn
         jy+1eI1EKNwSObJIZpddb4rW1FMQZhgtqWpJggZqzHdT4rLysIdgQhup6QmjSNJIr4HH
         RvUTnK0G8qNV9aykFdLt/BxeHV0YA1rhZhswUbXWKIeKkwDNplZgsZlh8bOOyNn9IV3O
         kI1GEEvJB0YFqOQSMFxfT7hjVaH6d57gB6lh2svRXW9kO2bXaI9vu+aGWqp/D4+4NNWN
         CYIw==
X-Gm-Message-State: ACrzQf2Z8u6j12GB1km1SoMO7oxIk08HuH26doHQ2+E5igaxeQszzanV
        /ymQK66fDa/UuKRN4w6JVpZvLYKmGbUVYfB1h7lOAmrmtxCQ3eytBSC6njwNv78jgbRg65PN7Ca
        xBP8e+ODIeOpAn4nFLVax
X-Received: by 2002:a05:600c:46cd:b0:3c6:f5ab:d383 with SMTP id q13-20020a05600c46cd00b003c6f5abd383mr26287911wmo.40.1666696529019;
        Tue, 25 Oct 2022 04:15:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Wx1ArwGsu4MsWfDtyUa7mG+AF0bcGB36rI41IZOoqGCfUWShib+ZZQ/JK5sHXOh0g8Ltllg==
X-Received: by 2002:a05:600c:46cd:b0:3c6:f5ab:d383 with SMTP id q13-20020a05600c46cd00b003c6f5abd383mr26287888wmo.40.1666696528691;
        Tue, 25 Oct 2022 04:15:28 -0700 (PDT)
Received: from localhost.localdomain (wifi-guest-gw.tecnico.ulisboa.pt. [193.136.152.65])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c314600b003c6f426467fsm11303922wmo.40.2022.10.25.04.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 04:15:28 -0700 (PDT)
Date:   Tue, 25 Oct 2022 13:15:25 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Trond Myklebust <trondmy@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2] sunrpc: Use GFP_NOFS to prevent use of
 current->task_frag.
Message-ID: <20221025111525.GA4415@localhost.localdomain>
References: <de6d99321d1dcaa2ad456b92b3680aa77c07a747.1665401788.git.gnault@redhat.com>
 <Y0QyYV1Wyo4vof70@infradead.org>
 <20221010165650.GA3456@ibm-p9z-18-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com>
 <Y0UKq62ByUGNQpuY@infradead.org>
 <20221011150057.GB3606@localhost.localdomain>
 <a0bf0d49a7a69d20cfe007d66586a2649557a30b.camel@kernel.org>
 <20221011211433.GA13385@ibm-p9z-18-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com>
 <20221013121834.GA3353@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013121834.GA3353@localhost.localdomain>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 13, 2022 at 02:18:37PM +0200, Guillaume Nault wrote:
> Still, that looks like net-next material to me. Reverting sunrpc to use
> GFP_NOFS looks better for an immediate bug fix.

Could we please move forward with this patch? This bug really needs to be
fixed. So please let's either revert to GFP_NOFS or actively work on a
different solution.

