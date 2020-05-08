Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C551CBA6C
	for <lists+linux-nfs@lfdr.de>; Sat,  9 May 2020 00:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgEHWIY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 May 2020 18:08:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57515 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727095AbgEHWIY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 May 2020 18:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588975703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Peg2YF2ND29ekNS6MGkynfv7ACrX9QEyGb3a4hyznQ0=;
        b=P48PSq3dv3W9+44dAxbs2ofUEVRP78yJvMbB5br5Epqv7C5vx9+l0PTbBK3/59AcZ9BDzF
        W4123traLCKoYlgt2UaI3Z+BmhdxUmFF5WAE5D2BEj36XLIFNZeHnbpecHi68ErGkM07jM
        CWJ/qM1dPnqUEkP2SaSUqC8LXHuJpTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-b6UCqDmWNjSy4M4G7KOTOQ-1; Fri, 08 May 2020 18:08:22 -0400
X-MC-Unique: b6UCqDmWNjSy4M4G7KOTOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B53880058A;
        Fri,  8 May 2020 22:08:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C0AF2E183;
        Fri,  8 May 2020 22:08:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <158897464246.1116213.8184341356151224705.stgit@warthog.procyon.org.uk>
References: <158897464246.1116213.8184341356151224705.stgit@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] cachefiles, nfs: Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1118495.1588975692.1@warthog.procyon.org.uk>
Date:   Fri, 08 May 2020 23:08:12 +0100
Message-ID: <1118496.1588975692@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Oops - I forgot to include a patch.  I'll resend.

David

