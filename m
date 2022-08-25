Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7FE5A0A90
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Aug 2022 09:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiHYHoL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Aug 2022 03:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiHYHnw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Aug 2022 03:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4117DA2DA4
        for <linux-nfs@vger.kernel.org>; Thu, 25 Aug 2022 00:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661413430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ox/AAlmY8QWkZllM5xgykJtk+SQ6oHc0MDfzXatpM38=;
        b=OvSno6CqpG9F7hdbG4qmeIUtEC1LTyJqgCTOIuZPYbSepx4wlwPpE4hutzJHAgnVuekrZT
        kqTUb6hRYNIR3O16xahq0d5hPREWUO6x3LqVtSjR4YwVEUzSNW/YLTc5nEj2KbuI+YZmNC
        LJ2GSmsyAzf6YF2OvXfXQB2RQx7pFSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-Eu07MR6vPLq3YNHF8SrjLg-1; Thu, 25 Aug 2022 03:43:48 -0400
X-MC-Unique: Eu07MR6vPLq3YNHF8SrjLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97D59804191
        for <linux-nfs@vger.kernel.org>; Thu, 25 Aug 2022 07:43:48 +0000 (UTC)
Received: from plambri-t490s (unknown [10.33.36.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F1CA1121319;
        Thu, 25 Aug 2022 07:43:48 +0000 (UTC)
Date:   Thu, 25 Aug 2022 08:43:45 +0100
From:   Pierguido Lambri <plambri@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs4_setfacl: add a specific option for indexes
Message-ID: <20220825074345.cexc7kgaljnuqf66@plambri-t490s>
References: <20220815083908.65720-1-plambri@redhat.com>
 <dff91106-4869-c20b-502b-4d3e0e9ac536@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dff91106-4869-c20b-502b-4d3e0e9ac536@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 24, 2022 at 04:10:40PM -0400, Steve Dickson wrote:
> Hello,
> 
> I'll go ahead and que this patch.. but there needs to be
> an manpage update for me to commit to it...

Thanks Steve.
I wasn't sure this would be accepted, I'll send another patch for the man
page.

Pier

