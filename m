Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC6E6F6C7D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjEDM5h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 08:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjEDM5b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 08:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C559FD
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683205002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=88eIQrGiFqCWFNvU+e8uQ+H0LUggzmKetsReRSSig9M=;
        b=dSulKI6LaXM/6JlZ74DMQfrIFhTT8x/3xurE5hTuYLO6JISPLgompR32cYrqqp1u4r+jrV
        x0FV0aaXosN/5ssQ2xqyS7vqqEkpwADgtfusCFhMSGbgAT2Z6OupvnQtX0rBNmckDvYJzC
        akCeXWnJcAyQC23H/ilYW+13Zaecp1E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-8uF3I8GHNbCKg46-MGPlug-1; Thu, 04 May 2023 08:56:39 -0400
X-MC-Unique: 8uF3I8GHNbCKg46-MGPlug-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1BEB3C10C70;
        Thu,  4 May 2023 12:56:38 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B26E492C3E;
        Thu,  4 May 2023 12:56:38 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFS: add a sysfs file for enabling & disabling nfs
 features
Date:   Thu, 04 May 2023 08:56:37 -0400
Message-ID: <B1DC5ECE-ECA8-4282-92EB-7272D091AC87@redhat.com>
In-Reply-To: <20230421182738.901701-1-anna@kernel.org>
References: <20230421182738.901701-1-anna@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Apr 2023, at 14:27, Anna Schumaker wrote:

> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> And add some basic checking so we only enable features that are present
> in a given NFS version.
>
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---

This is great, I like how you've kept the +/- notation similar to knfsd
supported versions.

Another way to do this would be an attribute file per capability, setting it
to 0 or 1 which is more inline with sysfs usage.

I think if we do use this, we ought to leave readdir plus out of it because
there's already a mount option for it.  Readdir plus can be turned on and
off with a remount already.  The issue for me would be how to work out what
the behavior should be when we have a mount that has "nordirplus" and then
someone tries to toggle it via sysfs.

Any other thoughts?

I'll add this patch to my future postings of sysfs work.

Ben

