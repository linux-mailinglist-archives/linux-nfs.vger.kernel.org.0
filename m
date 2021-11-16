Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39B74533D4
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 15:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhKPOPo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 09:15:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237162AbhKPOPb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 09:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637071954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SfdU2peNgKyBR0T9ro85RDznlaLcllbGSAuJmmNHXlM=;
        b=Xcsz1LaflnxD0U3RseOK3sEgfVV0OvdLAu+AlKAGVoJtolFz5WFfVjFC2b557cAftu3A4g
        4pQumnmTfAM56szlY1ff1hlS59aM3Oaddxe9NofEP0f1RXJHnZ2clq0Q405FpoaZTxpXl7
        xxrf/PJ9eVS7vTObNq7PjPsAp0lRB3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-gm02fycPPPm2bcM-BcQDxA-1; Tue, 16 Nov 2021 09:12:30 -0500
X-MC-Unique: gm02fycPPPm2bcM-BcQDxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81FA215722;
        Tue, 16 Nov 2021 14:12:29 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F7A960BD8;
        Tue, 16 Nov 2021 14:12:28 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] NFSv42: Don't drop NFS_INO_INVALID_CHANGE if we hold
 a delegation
Date:   Tue, 16 Nov 2021 09:12:27 -0500
Message-ID: <9FE34DCC-0F28-4960-B25C-B006DA6D9A38@redhat.com>
In-Reply-To: <a06d3d97a865747058c7d1cbcd4f70911c336fce.camel@hammerspace.com>
References: <cover.1637069577.git.bcodding@redhat.com>
 <c91e224b847e697e42b25cdc36cd164a61ad1ade.1637069577.git.bcodding@redhat.com>
 <a06d3d97a865747058c7d1cbcd4f70911c336fce.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Nov 2021, at 9:03, Trond Myklebust wrote:
> No, we really shouldn't need to care what the server thinks or does.
> The client is authoritative for the change attribute while it holds a
> delegation, not the server.

My understanding of the intention of the code (which I had to sort of put
together from historical patches in this area) is that we want to see ctime,
mtime, and block size updates after copy/clone even if we hold a delegation,
but without NFS_INO_INVALID_CHANGE, the client won't update those
attributes.

If that's not necessary, we can drop this patch.

