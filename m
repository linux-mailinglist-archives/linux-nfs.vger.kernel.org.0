Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9571227614B
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Sep 2020 21:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIWTqx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 15:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbgIWTqx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Sep 2020 15:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600890412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OnjdjHdk8aLmJCmvDWTAH5dPsjUyh8r1A3Qp04VA/FY=;
        b=ItWfWRCaEdwSlneoPQellaWjrMIun1LoxZZCB31gZuwsWubZMBKzWUSiK5xYFqbcfQPPoc
        IDM9Lowo2p01rMBtLU1BsBFF87vx1z7OXHqpjc+CZ/iNbBxMVYwYvpidxMnVI3zvFzs2FU
        RKMJeIUCJxJ5sFJSXsMB0f0FViX+pus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-8uwzJvESNZuKaYLDt8Etyg-1; Wed, 23 Sep 2020 15:46:48 -0400
X-MC-Unique: 8uwzJvESNZuKaYLDt8Etyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 377CE1074668;
        Wed, 23 Sep 2020 19:46:47 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5AA060BF1;
        Wed, 23 Sep 2020 19:46:46 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com
Subject: Re: [PATCH 1/2 v3] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Date:   Wed, 23 Sep 2020 15:46:45 -0400
Message-ID: <A38F09A7-34FC-483C-8629-51BA2D833DAD@redhat.com>
In-Reply-To: <3053ab24162fbb9431f4918373aaa919c3b55a34.camel@hammerspace.com>
References: <cover.1600882430.git.bcodding@redhat.com>
 <787d0d4946efb286f4dc51051b048277c0dc697e.1600882430.git.bcodding@redhat.com>
 <69ca1c64b0e7eb205e8f53af8febf6d688f65d80.camel@hammerspace.com>
 <24324678-510B-4524-8C17-EB7365C2A3CD@redhat.com>
 <3053ab24162fbb9431f4918373aaa919c3b55a34.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 23 Sep 2020, at 15:39, Trond Myklebust wrote:
> The client can't predict what is going to happen w.r.t. an OPEN call.
> If it does an open by name, it doesn't even know which file is going to
> get opened. That's why we have the wait loop
> in nfs_set_open_stateid_locked(). Why should we not do the same in
> CLOSE and OPEN_DOWNGRADE? It's the same problem.

I will give it a shot.  In the meantime, please consider adding this patch
which fixes a real bug today.  Thank you for your excellent advice and time.

Ben

