Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775C54222B4
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhJEJy0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 05:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232723AbhJEJyZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Oct 2021 05:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633427555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H9j96tZUjecksQe/75RFn+NpxY/g6scwuQUOeHzSW0k=;
        b=THksjvx6rzVNWh+gC4jz8cGGbaV4h1M+o5y72ODsvNHQwnv4kGn/hfnZQvZIcyAABSMI6s
        AsUyTXU6dWLPhtOpNXvmcbRoVOodeRlN//c7rxJI4n2cjUexIsrm/WP8U2nnx8yMkRA/9C
        oR4p983OLwZjHnNYDlEvsR6vWNhwiCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-gjADx5zmOwaqYoRoBDcx8Q-1; Tue, 05 Oct 2021 05:52:34 -0400
X-MC-Unique: gjADx5zmOwaqYoRoBDcx8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27937801E72;
        Tue,  5 Oct 2021 09:52:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CE0819D9D;
        Tue,  5 Oct 2021 09:52:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1633288958-8481-1-git-send-email-dwysocha@redhat.com>
References: <1633288958-8481-1-git-send-email-dwysocha@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] Various NFS fscache cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <980956.1633427535.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 05 Oct 2021 10:52:15 +0100
Message-ID: <980957.1633427535@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dave Wysochanski <dwysocha@redhat.com> wrote:

> This patchset is on top of David Howells fscache-iter-3 branch, which
> he posted v2 recently
> https://lore.kernel.org/all/163189104510.2509237.10805032055807259087.st=
git@warthog.procyon.org.uk/
> =

> The first patch in this series should probably be merged into David Howe=
lls
> 3/8 patch of that series.  Otherwise, these patches are applied on top o=
f
> his series, and this series is mostly orthogonal to fscache-iter-3 branc=
h.

I've added it to my series, putting it in front of my nfs patch.  Your cha=
nges
there aren't really anything to do with mine, so I don't think they want
merging together.

David

