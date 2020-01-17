Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFE5140C4D
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 15:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgAQOUR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 09:20:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23492 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbgAQOUQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 09:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579270815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeEZ0qUeju7e6fsOK/2xeFdlefM8ZRogr0yjS7mThiU=;
        b=Qe5ZKjnt+5PO9FdaTbiRWcGO5qb9bZzwkMIGVzRcueIQ3FgTERlJLQpf0+i97egpT9zDa1
        xIGJTiioQqgocQG8RaUqHb0pFbC/Ik1voUxyHhx2uL1pAQ4fTXqFOJMcKLc7WbPCejY7QY
        dhpi1RmpPF0rzIM+gYS5rUIKQD/Qttg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-r2Rpb7Z4N9ao2YSI1_W4aQ-1; Fri, 17 Jan 2020 09:20:11 -0500
X-MC-Unique: r2Rpb7Z4N9ao2YSI1_W4aQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 711248010CE;
        Fri, 17 Jan 2020 14:20:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24CD3845C6;
        Fri, 17 Jan 2020 14:20:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
References: <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Scott Mayhew <smayhew@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [BISECT BUG] NFS v4 root not working after 6d972518b821 ("NFS: Add fs_context support.")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <433862.1579270803.1@warthog.procyon.org.uk>
Date:   Fri, 17 Jan 2020 14:20:03 +0000
Message-ID: <433863.1579270803@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

You seem to be running afoul of the check here:

	case Opt_minorversion:
		if (result.uint_32 > NFS4_MAX_MINOR_VERSION)
			goto out_of_bounds;
		ctx->minorversion = result.uint_32;
		break;

which would seem to indicate that the mount process is supplying
minorversion=X as an option.  Can you modify your kernel to print param->key
and param->string at the top of nfs_fs_context_parse_param()?  Adding
something like:

	pr_notice("NFSOP '%s=%s'\n", param->key, param->string);

will likely suffice unless you're directly driving the new mount API - in
which case param->string might be things other than a string, but that's
unlikely.  It might also be NULL, but printk should handle that.

David

