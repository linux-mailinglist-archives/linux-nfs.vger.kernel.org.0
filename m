Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12537140D86
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 16:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgAQPMs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 10:12:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37992 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728512AbgAQPMr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 10:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579273965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fMvdkxieshf5qMjWzbe24xoi8/IPuS4Clb2g2FTl2C0=;
        b=ExrQy03aVacZicLDVAEg+YPyZqSw0F8cNaDFGPPWWcL9pvAvLv60PZnfQhgbs3vPTRpvwx
        +IU/AOeje4x16TiURg9n1bXUd98SzfC9dhRvsCffHPDIOiQj5xYwhKw0clgRh60T+Gw2ZK
        qZZhEP3VQpqL4wtb7GT25mIYvRq3btw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-EvqXYFZrOwil26R6rgB_qw-1; Fri, 17 Jan 2020 10:12:42 -0500
X-MC-Unique: EvqXYFZrOwil26R6rgB_qw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB0301800D4F;
        Fri, 17 Jan 2020 15:12:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1274B81201;
        Fri, 17 Jan 2020 15:12:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200117144055.GB3215@pi3>
References: <20200117144055.GB3215@pi3> <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com> <433863.1579270803@warthog.procyon.org.uk>
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
Content-ID: <461539.1579273958.1@warthog.procyon.org.uk>
Date:   Fri, 17 Jan 2020 15:12:38 +0000
Message-ID: <461540.1579273958@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> wrote:

> mount.nfs4 -o vers=4,nolock 192.168.1.10:/srv/nfs/odroidhc1 /new_root

Okay, it looks like the mount command makes two attempts at mounting.
Firstly, it does this:

> [   22.938314] NFSOP 'source=192.168.1.10:/srv/nfs/odroidhc1'
> [   22.942638] NFSOP 'nolock=(null)'
> [   22.945772] NFSOP 'vers=4.2'
> [   22.948660] NFSOP 'addr=192.168.1.10'
> [   22.952350] NFSOP 'clientaddr=192.168.1.12'
> [   22.956831] NFS4: Couldn't follow remote path

Which accepts the "vers=4.2" parameter as there's no check that that is
actually valid given the configuration, but then fails later.  Secondly, it
does this:

> [   22.971001] NFSOP 'source=192.168.1.10:/srv/nfs/odroidhc1'
> [   22.975217] NFSOP 'nolock=(null)'
> [   22.978444] NFSOP 'vers=4'
> [   22.981265] NFSOP 'minorversion=1'
> [   22.984513] NFS: Value for 'minorversion' out of range
> mount.nfs4: Numerical result out of range

which fails because of the minorversion=1 specification, where the kernel
config didn't enable NFS_V4_1.

It looks like it ought to have failed prior to these patches in the same way:

		case Opt_minorversion:
			if (nfs_get_option_ul(args, &option))
				goto out_invalid_value;
			if (option > NFS4_MAX_MINOR_VERSION)
				goto out_invalid_value;
			mnt->minorversion = option;
			break;

David

