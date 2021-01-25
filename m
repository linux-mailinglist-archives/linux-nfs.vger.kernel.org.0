Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68F9302EB7
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jan 2021 23:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbhAYWNE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jan 2021 17:13:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731936AbhAYWMZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jan 2021 17:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611612659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XxzIZYfJbXzf8XFHtDGnmq7KPaRYstlqB3o28is+DnY=;
        b=eL4a48pvNBMcEZxVKVTxxR4XFWzsCVQuiH2OgzpzOF/wiSMDtzMaG1zmPMqfTtL/PfwXds
        f1R70+Aux+KcIYH/7TJj/jaHsVHaudpdo2dWfvkXh4AKzGHsl8t/4sOTyuuv+xuWoGW8uG
        aegAVlCy31YiiKikYUcIugKYn+Wqm1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-H9LQIQ72MUOXzfe9Mxz5Bw-1; Mon, 25 Jan 2021 17:10:57 -0500
X-MC-Unique: H9LQIQ72MUOXzfe9Mxz5Bw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B9C118C8C01;
        Mon, 25 Jan 2021 22:10:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A714B5D9DB;
        Mon, 25 Jan 2021 22:10:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
cc:     dhowells@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: How to handle NFS patches for fscache I/O partial rewrite?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2543103.1611612650.1@warthog.procyon.org.uk>
Date:   Mon, 25 Jan 2021 22:10:50 +0000
Message-ID: <2543104.1611612650@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond, Anna,

As you may have seen, I've managed to cut down the fscache overhaul to add a
glue layer to handle reads and switch to using async DIO through kiocbs rather
than using sync write and async reads with page wait list snooping.  All the
rest of the API is unchanged (for the moment).

The glue layer (netfs helper library) handles the new VM readahead stuff and
reading transparent huge pages on behalf of the netfs, plus read shaping,
splitting and retrying.

Dave Wysochanski created some NFS patches for it, which I posted as part of my
branch.  I'd like to get them into linux-next with an eye to having them
pulled by Linus in the next merge window, along with the rest of my branch.

Should I keep them in my branch and thence into linux-next, or do they need to
go through one of your branches?

Thanks,
David

