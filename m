Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538EF3DB94B
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jul 2021 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhG3N0Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jul 2021 09:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230480AbhG3N0Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jul 2021 09:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627651579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9VcuZIvScbJB6g6d0ufI7w9hFQSZu1svBZfTXQSpqzI=;
        b=jAmne/qYgf04QWvsRhGAU6cibJFVuia9qvLXxDlIXcfCQWEPo4ZYNXy9SBzScdqVa30HS0
        rP691WlWjYxsL7Vk4zlSeZOn+z73QUCQc2JDIKYYymL7dlPa79cCBfpTlLAbRZWZpvCwoy
        FkI2s7Sm2HeoxG5REEXe/O63XIvHP6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-hdBCOFLCNPm5VdDAIjA_2w-1; Fri, 30 Jul 2021 09:26:16 -0400
X-MC-Unique: hdBCOFLCNPm5VdDAIjA_2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7656802CB9;
        Fri, 30 Jul 2021 13:26:01 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59A625D9D5;
        Fri, 30 Jul 2021 13:26:01 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Cc:     "Pierguido Lambri" <plambri@redhat.com>
Subject: cto changes for v4 atomic open
Date:   Fri, 30 Jul 2021 09:25:59 -0400
Message-ID: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have some folks unhappy about behavior changes after: 479219218fbe NFS:
Optimise away the close-to-open GETATTR when we have NFSv4 OPEN

Before this change, a client holding a RO open would invalidate the
pagecache when doing a second RW open.

Now the client doesn't invalidate the pagecache, though technically it could
because we see a changeattr update on the RW OPEN response.

I feel this is a grey area in CTO if we're already holding an open.  Do we
know how the client ought to behave in this case?  Should the client's open
upgrade to RW invalidate the pagecache?

Ben

