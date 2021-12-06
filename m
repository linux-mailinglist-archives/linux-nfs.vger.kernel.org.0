Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4DF46925F
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Dec 2021 10:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhLFJcW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Dec 2021 04:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240658AbhLFJcU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Dec 2021 04:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638782931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/hcGb4l6mpPWh8991ifbOPCqVsTwn4Kydw3b+jqs2g=;
        b=fK4U7cOh+C20okcudW2mo4Lm21vlAZQHhj0gywJ182Em8riSGl/eU2E1rEu8UXxMXF3cwm
        Mj/RR2VEkCTwknFOR6RNGhYtLeFl4iKklzd/GVEkox5CT/9VxsBkUGSg69O8hn27Wy2F9U
        3d+BJx7ucBipjXTbdCTsNm+MkS8aXpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-P-am3-asPp-Z9BspzF_zag-1; Mon, 06 Dec 2021 04:28:50 -0500
X-MC-Unique: P-am3-asPp-Z9BspzF_zag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94326192CC47;
        Mon,  6 Dec 2021 09:28:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4A95794A8;
        Mon,  6 Dec 2021 09:28:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALF+zO=+1JV2JbXWL1zFjkWX=Rz-q93X0C7GTvng77U4LqT91w@mail.gmail.com>
References: <CALF+zO=+1JV2JbXWL1zFjkWX=Rz-q93X0C7GTvng77U4LqT91w@mail.gmail.com> <20211201085443.GA24725@kili> <CALF+zOkZgtfP7HrX4oP=qx2uKr3FTRHqECRqKGkRBZaz6F-jdg@mail.gmail.com> <997841.1638547576@warthog.procyon.org.uk>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] nfs: Convert to new fscache volume/cookie API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1218009.1638782915.1@warthog.procyon.org.uk>
Date:   Mon, 06 Dec 2021 09:28:35 +0000
Message-ID: <1218010.1638782915@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

David Wysochanski <dwysocha@redhat.com> wrote:

> 1. Use the nfs_server.s_dev (someone can lookup the mount from
> /proc/self/mountinfo)
> Maybe "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev)

I think those numbers are just allocated on the fly, so they're not
consistent, so just unmounting and remounting can change them.

> 2. Use a checksum on the parameters?

I have considered hashing them.  It might also make sense to only include them
if they get explicitly set.

David

