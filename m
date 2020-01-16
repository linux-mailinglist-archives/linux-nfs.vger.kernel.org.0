Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111D313E027
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2020 17:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAPQcJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Jan 2020 11:32:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52334 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbgAPQcI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 11:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579192327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q60n1VZsESu3zhrmHy6lpyB2sF3Ad29tA2SxUDw1vL4=;
        b=HTkrF/h5OXXhv1HZgbvcOBIPbG0ytGJFrCT7tHjBJdkVocX4jaQ3oAJXBBdx2fLoCpn7zW
        9B8Ae4pGCO0Xmr6SPEvqzBAf3iw8mO4B2UYMCGLbcd7Wwgz2JoawBb01+QElcvCtLo4jQA
        HGWzj3CE6GGmLDGyb+pWP0/bR7UfSH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-6waNMwwPPuqApST3VfPhEQ-1; Thu, 16 Jan 2020 11:32:04 -0500
X-MC-Unique: 6waNMwwPPuqApST3VfPhEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08CB6107ACC5;
        Thu, 16 Jan 2020 16:32:03 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81A7489D02;
        Thu, 16 Jan 2020 16:32:02 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFS: Don't skip lookup when holding a delegation
Date:   Thu, 16 Jan 2020 11:32:01 -0500
Message-ID: <C5892E37-4731-4AD5-97FE-D8151C289CE9@redhat.com>
In-Reply-To: <d8639ad40df3b0a814e7396e1e824220c4d21a55.camel@hammerspace.com>
References: <77be993185fa7f114f6856f74f2f7affb5bd411d.1568904510.git.bcodding@redhat.com>
 <6399DBA2-DA9D-40C3-80BC-6DCE94BB9C49@redhat.com>
 <d8639ad40df3b0a814e7396e1e824220c4d21a55.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Jan 2020, at 11:02, Trond Myklebust wrote:
> We should need to perform this revalidation once, and only once for
> that directory, and only if we opened the file using a CLAIM_FH open,
> or if we opened it through a different hard linked name (and did not
> create this hard link after we got the delegation).
>
> Perhaps we could define a magic value for dentry->d_time that causes us
> to skip revalidation if and only if we hold a delegation?

Can we put the delegation's change_attr in d_time for dentries that have
been revalided while holding a delegation?

Ben

