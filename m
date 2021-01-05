Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC442EAD8A
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 15:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbhAEOls (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 09:41:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbhAEOls (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 09:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609857621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXFhB2iyx6hjWz/E/UcH4G+PRucSIF/NqnWLe1xbZ1o=;
        b=c5aE+20xdgCH6K/IytmxXa3DElbK7l02hOXHXBFadVKxfi5UOAMCjFbiGPp4OkikwRXxXS
        R9Vss0EHPDrb3eN0s6jkTVSfv0fPZCT3deukjBkG2T6QYFmLb4K83cYVEiaQ91EUd/oUOH
        qrE1yid3UqK4nWIgjAUywaiwh1GNVAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-D7jFd9XXPAiFftboI8MEXg-1; Tue, 05 Jan 2021 09:40:19 -0500
X-MC-Unique: D7jFd9XXPAiFftboI8MEXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE40E801817;
        Tue,  5 Jan 2021 14:40:18 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31F5610016F4;
        Tue,  5 Jan 2021 14:40:18 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Scott Mayhew" <smayhew@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Adjust fs_context error logging
Date:   Tue, 05 Jan 2021 09:40:17 -0500
Message-ID: <AC256A5D-88B8-4B96-8BE4-7BE8B7124027@redhat.com>
In-Reply-To: <20210105135432.1605419-1-smayhew@redhat.com>
References: <20210105135432.1605419-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5 Jan 2021, at 8:54, Scott Mayhew wrote:

> Several existing dprink()/dfprintk() calls were converted to use the new
> mount API logging macros by commit ce8866f0913f ("NFS: Attach
> supplementary error information to fs_context").  If the fs_context was
> not created using fsopen() then it will not have had a log buffer
> allocated for it, and the new mount API logging macros will wind up
> calling printk().
>
> This can result in syslog messages being logged where previously there
> were none... most notably "NFS4: Couldn't follow remote path", which can
> happen if the client is auto-negotiating a protocol version with an NFS
> server that doesn't support the higher v4.x versions.
>
> Convert the nfs_errorf(), nfs_invalf(), and nfs_warnf() macros to check
> for the existence of the fs_context's log buffer and call dprintk() if
> it doesn't exist.  Add nfs_ferrorf(), nfs_finvalf(), and nfs_warnf(),
> which do the same thing but take an NFS debug flag as an argument and
> call dfprintk().  Finally, modify the "NFS4: Couldn't follow remote
> path" message to use nfs_ferrorf().
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207385
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>

I hope someday we can convert all the old debugging to tracepoints.  I know
you considered just removing the debug lines or converting these to a
tracepoint and decided to fix what we have for now.  It does make for a
better stable fix.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

