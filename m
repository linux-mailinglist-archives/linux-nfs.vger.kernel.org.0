Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6311347B21F
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 18:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhLTRad (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 12:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240214AbhLTRab (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 12:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640021430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8Hf5kt0lJFJ40JumzWax+oEUjwH0n+Y/bekgKydiYQ=;
        b=DaNsApj+gcn2AR28/QO64qDiDBVYi4SB4Z6z9CHX6EwBXbt+DjDvmc+OHlRM9Cf53+S48Z
        wpUUs+oaBhLzY2oJewAxTgPi4edCRBVSki+ZEHDIXVjV1yzl+K4qRn0lMb39j92FRbKi+p
        lbE6fJemZ9gyFI00tn4vk8Wwco6iPMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-c3rYASJRObCl7dWfPy9Xig-1; Mon, 20 Dec 2021 12:30:28 -0500
X-MC-Unique: c3rYASJRObCl7dWfPy9Xig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 912531023F4D;
        Mon, 20 Dec 2021 17:30:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68BF6519D7;
        Mon, 20 Dec 2021 17:29:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1639763665-4917-3-git-send-email-dwysocha@redhat.com>
References: <1639763665-4917-3-git-send-email-dwysocha@redhat.com> <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [PATCH v2 2/4] NFS: Rename fscache read and write pages functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2512432.1640021388.1@warthog.procyon.org.uk>
Date:   Mon, 20 Dec 2021 17:29:48 +0000
Message-ID: <2512433.1640021388@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dave Wysochanski <dwysocha@redhat.com> wrote:

> Rename NFS fscache functions in a more consistent fashion
> to better reflect when we read from and write to fscache.

Do you want me to merge this into my patch that rewrites the nfs cache I/O?

David

