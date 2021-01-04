Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF22E964A
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 14:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbhADNsJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 08:48:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbhADNsI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 08:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609768002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=LAokNNuaCHLuDjVTwRUA+0vYUui2/RictYwpObwb3Xg=;
        b=GIxnAaKQg1Xt7Qi7ardGPDN0orwHxeAJgvnh1AkTPUxGll6X2mP0pYkOCK8EmJ0zC4PKyP
        djGaVeS34zTLvVS7iXhr0+dBv21v0BFn+rXTbWSzuE78BUju8QXEES2dV5bkdR/+RQxVgL
        mpV/dzYQTFwV67bsiew6FVm7sHr6PeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-YYQVfwdGPvuqMBUNC6nHpQ-1; Mon, 04 Jan 2021 08:46:37 -0500
X-MC-Unique: YYQVfwdGPvuqMBUNC6nHpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3A6C10054FF;
        Mon,  4 Jan 2021 13:46:36 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6EC860CCE;
        Mon,  4 Jan 2021 13:46:35 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        NFSv4 <nfsv4@ietf.org>
Subject: virtual/permanent bakeathon infrastructure
Date:   Mon, 04 Jan 2021 08:46:34 -0500
Message-ID: <85C06BBD-2861-4CDE-BCED-ACD974560D3A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

How are folks feeling about throwing time at a virtual bakeathon?  I had
some ideas about how this might be possible by building out a virtual
network of OpenVPN clients, and hacked together some infrastructure to make
it happen:

https://vpn.nfsv4.dev/

That network exists today, and any systems that are able to join it can use
it to test.  There are a number of problems/complications:
    - the private network is ipv6-only by design to avoid conflicts with
      overused ipv4 private addresses.
    - it uses hacked-together PKI to protect the TLS certificates encrypting
      the connections
    - some implementations of NFS only run on systems that cannot run
      OpenVPN software, requiring complicated routing/transalations
    - it needs to be re-written from bash to something..  less bash.
    - network latencies restrict testing to function; testing performance
      doesn't make sense.

With the ongoing work on NFS over TLS, my thought now is that if there is
interest in standing up permanent infrastructure for testing, then that's
probably sustainable way forward.  But until implementations mature, its not
going to help us host a successful testing event in the near future.

So, the second question -- should we instead work towards implementations of
NFS over TLS as a way of creating a more permanent testing infrastructure?

I am aware that I am leaving out a lot of detail here in order to try to
start a conversation and perhaps coalesce momentum.

Happy new year!
Ben

