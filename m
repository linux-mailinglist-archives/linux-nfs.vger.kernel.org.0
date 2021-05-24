Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE95938EA08
	for <lists+linux-nfs@lfdr.de>; Mon, 24 May 2021 16:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhEXOwU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 May 2021 10:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233824AbhEXOuT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 May 2021 10:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621867730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FuwT3ctKk4xVdw6+dePmYKxpmod0OzT4Muotu5Xq2YQ=;
        b=MGjcFIe6HQ+CE8ivbPUwD5SDTe1CHz48lNvgOMC45F6KCyfeLrTIgWomVhJq1NSO1l96Ti
        C+Xm9xOc9thAHRAmcaDXSPmyIfVU5e+mI1HF6x33BPEHwlvr5VcMVcVmG5fmGxm1o9ip+3
        +7/KXHvtubdG6WVuoSumU0RrdSmpxbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-Jn65E5Z_NS-BiEj1r18Qqg-1; Mon, 24 May 2021 10:48:48 -0400
X-MC-Unique: Jn65E5Z_NS-BiEj1r18Qqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF912180FD6C;
        Mon, 24 May 2021 14:48:47 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96CCC5C230;
        Mon, 24 May 2021 14:48:47 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Jason Keltz" <jas@eecs.yorku.ca>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: ksu problem with sec=krb5 and nfs
Date:   Mon, 24 May 2021 10:48:46 -0400
Message-ID: <0D324C0D-A00C-4A44-9814-2D717F830DF9@redhat.com>
In-Reply-To: <dd51738b-b2c2-2dcf-68b1-e78c66d08b28@eecs.yorku.ca>
References: <abbd93ac-4a68-a471-fbb4-a9baf05b89c9@eecs.yorku.ca>
 <7714ABF4-E9CD-424B-BF7F-6F1B91F58C2B@redhat.com>
 <dd51738b-b2c2-2dcf-68b1-e78c66d08b28@eecs.yorku.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 May 2021, at 10:44, Jason Keltz wrote:

> Hi Benjamin,
>
> That's exactly it - I definately want ksu to be writing that exact 
> file.  Any idea why it isn't, and why it matters if the home 
> directory is using sec=krb5 or not?

Because if you're mounting with sec=krb5, then the kernel's going to 
upcall to rpc.gssd, which is going to try to find the credential cache 
to establish a context with the NFS server.  None of that has to happen 
with sec=sys.

As far as where ksu puts the target cred cache - I don't know the 
details there.  Dig into the ksu source, or docs.. maybe you need to set 
the krb5cc default cred cache.

Ben

