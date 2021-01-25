Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF8302E6F
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jan 2021 22:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbhAYVy4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jan 2021 16:54:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732600AbhAYVyp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jan 2021 16:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611611599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=kSqY2isPGiYd94MJnT6t+js1VhXCwUyvvi1MxfW3oVw=;
        b=N28vOqO/2E/lxwxe1LMJX5I/6l+siHSaWYc0IBsxxxHSUHmHrDnHkfTHACwwYdTxF4W0+o
        U0e0awa8FAR3LCDeCVFIk0itXHyljMdeGRsCs7tDNtdBvW7L7seR2Mfd26QuD0/aeYESjr
        zs/H94j3bkG6kLjIr0ST2+31/idq5H8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-vtpqz-3KP_2-2Y7AX_hwpQ-1; Mon, 25 Jan 2021 16:53:17 -0500
X-MC-Unique: vtpqz-3KP_2-2Y7AX_hwpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F12A10054FF;
        Mon, 25 Jan 2021 21:53:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2B185D6DC;
        Mon, 25 Jan 2021 21:53:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: Adding my fscache-next branch to linux-next
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2541780.1611611590.1@warthog.procyon.org.uk>
Date:   Mon, 25 Jan 2021 21:53:10 +0000
Message-ID: <2541781.1611611590@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Stephen,

Could you add my fscache-next branch, which is in this repo:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

to linux-next please?

Note that it might conflict with anything Trond and/or Anna ask you to pull
for NFS, in which case I'll drop the NFS patches from it and seek to get Trond
and Anna to take them into the NFS tree.

Thanks,
David

