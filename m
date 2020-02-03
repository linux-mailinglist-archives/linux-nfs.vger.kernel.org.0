Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77DC150848
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2020 15:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgBCOVd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Feb 2020 09:21:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44948 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728098AbgBCOVc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Feb 2020 09:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580739691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JqCeqPP2h85rOy9MEo9ya027nswLM/F289rlk37ND94=;
        b=B1MsElHzS2tvZ0U3skISRJSfWms9AeM/0AuBl85p22JO2XxJPtkCv6XwIQs7l0E+jDmEuA
        YqoBOiOSR18Z8Hr8C2qmOBO/HW1Vagyk3yIqzI9j+rv4BdA9W4/shqi9zIcDCfrQyJkoYx
        v2zpEonydCOauSkhrLtjmheB5hlC8IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-mAq-OCIwOcOab1_ar4uEIg-1; Mon, 03 Feb 2020 09:21:26 -0500
X-MC-Unique: mAq-OCIwOcOab1_ar4uEIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32DF01005516;
        Mon,  3 Feb 2020 14:21:25 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3B3687B1D;
        Mon,  3 Feb 2020 14:21:24 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@gmail.com>
Cc:     "Anna Schumaker" <Anna.Schumaker@netapp.com>,
        "Dai Ngo" <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/4] NFS: Directory page cache pages need to be locked
 when read
Date:   Mon, 03 Feb 2020 09:21:23 -0500
Message-ID: <E691238F-D0EE-4BEA-9178-35751D218F54@redhat.com>
In-Reply-To: <20200202225356.995080-3-trond.myklebust@hammerspace.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
 <20200202225356.995080-2-trond.myklebust@hammerspace.com>
 <20200202225356.995080-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2 Feb 2020, at 17:53, Trond Myklebust wrote:

> When a NFS directory page cache page is removed from the page cache,
> its contents are freed through a call to nfs_readdir_clear_array().
> To prevent the removal of the page cache entry until after we've
> finished reading it, we must take the page lock.
>
> Fixes: 11de3b11e08c ("NFS: Fix a memory leak in nfs_readdir")
> Cc: stable@vger.kernel.org # v2.6.37+
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

