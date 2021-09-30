Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F141DC49
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Sep 2021 16:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349724AbhI3Obw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Sep 2021 10:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348126AbhI3Obu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Sep 2021 10:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A09nBnh3+znqPTmyctOPsBC8fydwsZHVz2bjxrS6BRg=;
        b=Z460mongC9/NRYQPSD0687ALRmyjPInYaThZilibZdORqagpAxxDBcRsw+ZXY0FBuoZurf
        dGbqQKXWggWhaqwls5gG3iBG/Dre5Oo/GC1B0T0CJFr6Ei2iN++mJddMvsCvJoBtqh1QEN
        ohl+F0LOyRJ8FLDi1LNmR8fp0AM5kiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-TJlGUIyeMpaBMoTMQvWhSA-1; Thu, 30 Sep 2021 10:30:01 -0400
X-MC-Unique: TJlGUIyeMpaBMoTMQvWhSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6146E804148;
        Thu, 30 Sep 2021 14:29:26 +0000 (UTC)
Received: from [10.10.66.66] (ovpn-66-66.rdu2.redhat.com [10.10.66.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0792F5C1A1;
        Thu, 30 Sep 2021 14:29:25 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/5] NFS: Further optimisations for 'ls -l'
Date:   Thu, 30 Sep 2021 10:29:23 -0400
Message-ID: <46C79084-3586-4B63-A55F-7A3B9ED547CE@redhat.com>
In-Reply-To: <558be6c89090b38cc9b679a0893649c5067cff14.camel@hammerspace.com>
References: <20210929134944.632844-1-trondmy@kernel.org>
 <20210929134944.632844-2-trondmy@kernel.org>
 <20210929134944.632844-3-trondmy@kernel.org>
 <20210929134944.632844-4-trondmy@kernel.org>
 <C9ED123C-A092-4417-8597-AB6267379E2F@redhat.com>
 <f09a7c00b70d51a442542dec1e1ba98289ad612c.camel@hammerspace.com>
 <F6D17359-3190-4A67-9DF7-08BCE61BE075@redhat.com>
 <558be6c89090b38cc9b679a0893649c5067cff14.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 29 Sep 2021, at 16:35, Trond Myklebust wrote:
> It is concerning, and indeed in our test we are seeing READDIR
> amplification with these multiple process accesses. So scenarios like
> the one you describe above are exactly the kind of issue I was looking
> to fix with these patches.

I spent some time trying to trigger the scenario I was concerned about, but
I couldn't generate any op amplifications.  Feel free to add my:

Tested-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

for the series.

Ben

