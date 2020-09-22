Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6CA274417
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Sep 2020 16:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgIVOWX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Sep 2020 10:22:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726473AbgIVOWX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Sep 2020 10:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600784542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nsea8EcN/QQ00P2hjXg098n3GKxc7bMiKmiAIyVKRXE=;
        b=XAwyqSucQlWiUtB5IHi+ckNNKEINRDzIOP23sYH1k8ySD1pdxAlVuPFBtZeBRg1XZnKhd9
        oRwscr4iH27RSVN4/NlsSqy0LT0ee+sIWF8K/ohvjv/K4goL0fdH1GY+std9WtGT0e+MjI
        RnhNqgKRt0dTvUPAH8Vey38IVH0pMJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-FScPb0AcOaCNL_GIMq-3cw-1; Tue, 22 Sep 2020 10:22:20 -0400
X-MC-Unique: FScPb0AcOaCNL_GIMq-3cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D68DC188C153;
        Tue, 22 Sep 2020 14:22:18 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AF9719C4F;
        Tue, 22 Sep 2020 14:22:18 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Anna Schumaker" <anna.schumaker@netapp.com>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] NFSv4: Fix a livelock when CLOSE pre-emptively bumps
 state sequence
Date:   Tue, 22 Sep 2020 10:22:17 -0400
Message-ID: <8DB79D4D-6986-4114-B031-43157089C2B5@redhat.com>
In-Reply-To: <CAFX2JfmeOm+-cpq6aTGnBNZLmAOwp8dykTWe7L6OU3mmnSw6rw@mail.gmail.com>
References: <5a7f6bbf4cf2038634a572f42ad80e95a8d0ae9c.1600686204.git.bcodding@redhat.com>
 <CAFX2JfmeOm+-cpq6aTGnBNZLmAOwp8dykTWe7L6OU3mmnSw6rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 Sep 2020, at 10:03, Anna Schumaker wrote:
> Hi Ben,
>
> Once I apply this patch I have trouble with generic/478 doing lock reclaim:
>
> [  937.460505] run fstests generic/478 at 2020-09-22 09:59:14
> [  937.607990] NFS: __nfs4_reclaim_open_state: Lock reclaim failed!
>
> And the test just hangs until I kill it.
>
> Just thought you should know!

Yes, thanks!  I'm not seeing that..  I've tested these based on v5.8.4, I'll
rebase and check again.  I see a wirecap of generic/478 is only 515K on my
system, would you be willing to share a capture of your test failing?

Ben

