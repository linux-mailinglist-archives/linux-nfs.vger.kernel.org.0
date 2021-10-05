Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC164226B0
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 14:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhJEMdc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 08:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233602AbhJEMdc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 08:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633437101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWvs98y6f4dZTabsJw1VEGryB1k64mYr32bRtsWV+bs=;
        b=WzOnH67RRJ4Mv14GJv07qqlAg9gF6Vih0+d8IpnsejJbOT+tA1Kfkt+jY0KAMn4hkzVkYL
        8ckTx7iET6oFM6DEOEorgFWInaVPu7TAzD+phfJobIOh2fUYnrhFjMr1kVN0/bQ7P9twMF
        Yy1POhcclglAyPE3Y0FGiH+u64+k1sM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-3tU6qnJIMbqeyyPe7QZ6uQ-1; Tue, 05 Oct 2021 08:31:38 -0400
X-MC-Unique: 3tU6qnJIMbqeyyPe7QZ6uQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4CEC801E72;
        Tue,  5 Oct 2021 12:31:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BC971036B3A;
        Tue,  5 Oct 2021 12:31:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <980957.1633427535@warthog.procyon.org.uk>
References: <980957.1633427535@warthog.procyon.org.uk> <1633288958-8481-1-git-send-email-dwysocha@redhat.com>
Cc:     dhowells@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] Various NFS fscache cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1077509.1633437094.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 05 Oct 2021 13:31:34 +0100
Message-ID: <1077510.1633437094@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > This patchset is on top of David Howells fscache-iter-3 branch, which
> > he posted v2 recently
> > https://lore.kernel.org/all/163189104510.2509237.10805032055807259087.=
stgit@warthog.procyon.org.uk/
> > =

> > The first patch in this series should probably be merged into David Ho=
wells
> > 3/8 patch of that series.  Otherwise, these patches are applied on top=
 of
> > his series, and this series is mostly orthogonal to fscache-iter-3 bra=
nch.
> =

> I've added it to my series, putting it in front of my nfs patch.  Your c=
hanges
> there aren't really anything to do with mine, so I don't think they want
> merging together.

Ah - I got confused by the "3/8 patch" bit and took patch 3, not patch 1.

David

