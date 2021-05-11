Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E7337A9D4
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhEKOsD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 10:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231643AbhEKOsD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 10:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620744416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=6Lnvc0+a40OR30zqdZUM/znfFU40ZwYiFKsjTJls1DU=;
        b=RecVwHfnNGnVk2skb1mMBVJkgLweF5J+ol1/lhQHmEL7d9dqHyZgSmqXheNQFSk928oyr0
        ORxNpj0IfjUotmwiFCGJYIJDF1/EvEXevDwuqlvd2INVVtNdYiEE4OTPoF4bpRXJ1ZdNdk
        6TelSvTFP4TolodX1c+VVCJ5lFk8o18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-GtEQvuKVM3KdXq1GH3fAPQ-1; Tue, 11 May 2021 10:46:53 -0400
X-MC-Unique: GtEQvuKVM3KdXq1GH3fAPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F04FE106BB29;
        Tue, 11 May 2021 14:46:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19C875C1A3;
        Tue, 11 May 2021 14:46:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
cc:     dhowells@redhat.com, linux-nfs@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Extracting out the gss/krb5 support in sunrpc
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2581830.1620744410.1@warthog.procyon.org.uk>
Date:   Tue, 11 May 2021 15:46:50 +0100
Message-ID: <2581831.1620744410@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I'm looking at extracting out the gssapi/krb5 support from the sunrpc package
in the kernel into a common library under crypto/ so that afs (and anyone else
- cifs, maybe) can use it too.  Are you willing to entertain that idea - or is
that a definite no for you?

David

